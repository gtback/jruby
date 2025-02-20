/***** BEGIN LICENSE BLOCK *****
 * Version: EPL 2.0/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Eclipse Public
 * License Version 2.0 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.eclipse.org/legal/epl-v20.html
 *
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 *
 * Copyright (C) 2002 Benoit Cerrina <b.cerrina@wanadoo.fr>
 * Copyright (C) 2002 Jan Arne Petersen <jpetersen@uni-bonn.de>
 * Copyright (C) 2002-2007 Anders Bengtsson <ndrsbngtssn@yahoo.se>
 * Copyright (C) 2003 Thomas E Enebo <enebo@acm.org>
 * Copyright (C) 2004-2005 Charles O Nutter <headius@headius.com>
 * Copyright (C) 2004 Stefan Matthias Aust <sma@3plus4.de>
 * 
 * Alternatively, the contents of this file may be used under the terms of
 * either of the GNU General Public License Version 2 or later (the "GPL"),
 * or the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the EPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the EPL, the GPL or the LGPL.
 ***** END LICENSE BLOCK *****/

package org.jruby;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.EOFException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import org.jruby.anno.JRubyMethod;
import org.jruby.anno.JRubyModule;

import org.jruby.ast.util.ArgsUtil;
import org.jruby.runtime.*;
import org.jruby.runtime.builtin.IRubyObject;
import org.jruby.runtime.marshal.MarshalStream;
import org.jruby.runtime.marshal.UnmarshalStream;

import org.jruby.util.ByteList;
import org.jruby.util.IOInputStream;
import org.jruby.util.IOOutputStream;

/**
 * Marshal module
 *
 * @author Anders
 */
@JRubyModule(name="Marshal")
public class RubyMarshal {

    public static RubyModule createMarshalModule(Ruby runtime) {
        RubyModule module = runtime.defineModule("Marshal");

        module.defineAnnotatedMethods(RubyMarshal.class);
        module.defineConstant("MAJOR_VERSION", runtime.newFixnum(Constants.MARSHAL_MAJOR));
        module.defineConstant("MINOR_VERSION", runtime.newFixnum(Constants.MARSHAL_MINOR));

        return module;
    }

    @JRubyMethod(required = 1, optional = 2, module = true, visibility = Visibility.PRIVATE)
    public static IRubyObject dump(ThreadContext context, IRubyObject recv, IRubyObject[] args, Block unusedBlock) {
        final Ruby runtime = context.runtime;

        IRubyObject objectToDump = args[0];
        IRubyObject io = null;
        int depthLimit = -1;

        if (args.length >= 2) {
            IRubyObject arg1 = args[1];
            if (sites(context).respond_to_write.respondsTo(context, arg1, arg1)) {
                io = arg1;
            } else if (arg1 instanceof RubyFixnum) {
                depthLimit = (int) ((RubyFixnum) arg1).getLongValue();
            } else {
                throw runtime.newTypeError("Instance of IO needed");
            }
            if (args.length == 3) {
                depthLimit = (int) args[2].convertToInteger().getLongValue();
            }
        }

        try {
            if (io != null) {
                dumpToStream(runtime, objectToDump, outputStream(context, io), depthLimit);
                return io;
            }
            
            ByteArrayOutputStream stringOutput = new ByteArrayOutputStream();
            dumpToStream(runtime, objectToDump, stringOutput, depthLimit);
            RubyString result = RubyString.newString(runtime, new ByteList(stringOutput.toByteArray(), false));
            
            return result;
        } catch (IOException ioe) {
            throw runtime.newIOErrorFromException(ioe);
        }
    }

    @Deprecated
    public static IRubyObject dump(IRubyObject recv, IRubyObject[] args, Block unusedBlock) {
        return dump(recv.getRuntime().getCurrentContext(), recv, args, unusedBlock);
    }

    @JRubyMethod(name = {"load", "restore"}, required = 1, optional = 2, module = true, visibility = Visibility.PRIVATE)
    public static IRubyObject load(ThreadContext context, IRubyObject recv, IRubyObject[] args, Block unusedBlock) {
        Ruby runtime = context.runtime;
        IRubyObject in = args[0];
        boolean freeze = false;
        IRubyObject proc = null;

        if (args.length > 1) {
            RubyHash kwargs = ArgsUtil.extractKeywords(args[args.length - 1]);
            if (kwargs != null) {
                IRubyObject[] options = ArgsUtil.extractKeywordArgs(context, kwargs, "freeze");
                freeze = options[0] != null ? options[0].isTrue(): false;
                if (args.length > 2) proc = args[1];
            } else {
                proc = args[1];
            }
        }

        final IRubyObject str = in.checkStringType();
        try {
            InputStream rawInput;
            if (str != context.nil) {
                ByteList bytes = ((RubyString) str).getByteList();
                rawInput = new ByteArrayInputStream(bytes.getUnsafeBytes(), bytes.begin(), bytes.length());
            } else if (sites(context).respond_to_getc.respondsTo(context, in, in) &&
                        sites(context).respond_to_read.respondsTo(context, in, in)) {
                rawInput = inputStream(context, in);
            } else {
                throw runtime.newTypeError("instance of IO needed");
            }

            return new UnmarshalStream(runtime, rawInput, freeze, proc).unmarshalObject();
        } catch (EOFException e) {
            if (str != context.nil) throw runtime.newArgumentError("marshal data too short");

            throw runtime.newEOFError();
        } catch (IOException ioe) {
            throw runtime.newIOErrorFromException(ioe);
        }
    }

    private static InputStream inputStream(ThreadContext context, IRubyObject in) {
        setBinmodeIfPossible(context, in);
        return new IOInputStream(in, false); // respond_to?(:read) already checked
    }

    private static OutputStream outputStream(ThreadContext context, IRubyObject out) {
        setBinmodeIfPossible(context, out);
        return new IOOutputStream(out, true, false); // respond_to?(:write) already checked
    }

    private static void dumpToStream(Ruby runtime, IRubyObject object, OutputStream rawOutput, int depthLimit)
        throws IOException {
        MarshalStream output = new MarshalStream(runtime, rawOutput, depthLimit);
        output.dumpObject(object);
    }

    private static void setBinmodeIfPossible(ThreadContext context, IRubyObject io) {
        if (sites(context).respond_to_binmode.respondsTo(context, io, io)) {
            sites(context).binmode.call(context, io, io);
        }
    }

    /**
     * Convenience method for objects that are undumpable. Always throws (a TypeError).
     */
    public static IRubyObject undumpable(ThreadContext context, RubyObject self) {
        throw context.runtime.newTypeError("can't dump " + self.type());
    }

    private static JavaSites.MarshalSites sites(ThreadContext context) {
        return context.sites.Marshal;
    }

}
