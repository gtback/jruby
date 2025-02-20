%{
// We ERB for ripper grammar and we need an alternative substitution value.
/*@@=
  SUBS = {
    'import_ripper' => [
         '',
         'import org.jruby.util.KeyValuePair; import org.jruby.RubyArray;'
    ],
    'program_production' => [
         '',
         '%type <IRubyObject> program'
    ],
    'ParserConstructorParams' => [
        'LexerSource source, IRubyWarnings warnings',
        'ThreadContext context, IRubyObject ripper, LexerSource source'
    ],
    'ParserConstructorBody' => [
        'super(warnings); setLexer(new RubyLexer(this, source, warnings));',
        'super(context, ripper, source);'
    ],
    'lexer' => [
        'org.jruby.lexer.yacc.RubyLexer', 
        'org.jruby.ext.ripper.RubyLexer'
    ],
    'package' => ['org.jruby.parser', 'org.jruby.ext.ripper'],
    'lex_package' => ['org.jruby.lexer.yacc', 'org.jruby.ext.ripper'],
    'Parser' => ['Ruby', 'Ripper'],
    'keyword_type' => ['Integer', 'IRubyObject'],
    'token_type' => ['ByteList', 'IRubyObject'],
    'token_integer_type' => ['Node', 'IRubyObject'],
    'token_float_type' => ['FloatNode', 'IRubyObject'],
    'token_rational_type' => ['RationalNode', 'IRubyObject'],
    'token_imaginary_type' => ['ComplexNode', 'IRubyObject'],
    'token_char_type' => ['StrNode', 'IRubyObject'],
    'token_nthref_type' => ['Node', 'IRubyObject'],
    'token_backref_type' => ['Node', 'IRubyObject'],
    'token_string_type' => ['Node', 'IRubyObject'],
    'token_regexp_type' => ['RegexpNode', 'IRubyObject'],
    'prod_undef_list_type' => ['Node', 'RubyArray'],
    'prod_bv_decls_type' => ['Node', 'RubyArray'],
    'prod_type' => ['Node', 'IRubyObject'],
    'prod_string_type' => ['Node', 'IRubyObject'],
    'prod_words_type' => ['ListNode', 'IRubyObject'],
    'prod_numeric_type' => ['NumericNode', 'IRubyObject'],
    'prod_blockarg_type' => ['BlockPassNode', 'IRubyObject'],
    'prod_fcall_type' => ['FCallNode', 'IRubyObject'],
    'prod_rescue_type' => ['RescueBodyNode', 'IRubyObject'],
    'prod_lhs_type' => ['AssignableNode', 'IRubyObject'],
    'prod_block_optarg_type' => ['ListNode', 'RubyArray'],
    'prod_args_type' => ['ArgsNode', 'IRubyObject'],
    'prod_farg_type' => ['ListNode', 'RubyArray'],
    'prod_marg_type' => ['ListNode', 'IRubyObject'],
    'prod_assoc_list_type' => ['HashNode', 'IRubyObject'],
    'prod_assocs_type' => ['HashNode', 'RubyArray'],
    'prod_assoc_type' => ['KeyValuePair', 'IRubyObject'],
    'prod_block_param_type' => ['ArgsNode', 'IRubyObject'],
    'prod_f_kwarg_type' => ['ListNode', 'RubyArray'],
    'prod_f_kw_type' => ['KeywordArgNode', 'IRubyObject'],
    'prod_bvar_type' => ['ByteList', 'IRubyObject'],
    'prod_lambda_type' => ['LambdaNode', 'IRubyObject'],
    'prod_f_larglist_type' => ['ArgsNode', 'IRubyObject'],
    'prod_brace_block_type' => ['IterNode', 'IRubyObject'],
    'prod_mlhs_type' => ['MultipleAsgnNode', 'IRubyObject'],
    'prod_mlhs_head_type' => ['ListNode', 'IRubyObject'],
    'prod_p_case_body_type' => ['InNode', 'IRubyObject'],
    'prod_p_find_type' => ['FindPatternNode', 'RubyArray'],
    'prod_p_args_type' => ['ArrayPatternNode', 'RubyArray'],
    'prod_p_args_head_type' => ['ListNode', 'RubyArray'],
    'prod_p_arg_type' => ['ListNode', 'RubyArray'],
    'prod_p_kwarg_type' => ['HashNode', 'RubyArray'],
    'prod_p_kwargs_type' => ['HashPatternNode', 'RubyArray'],
    'prod_p_kw_type' => ['KeyValuePair', 'RubyArray'],
    'prod_f_rest_arg_type' => ['RestArgNode', 'IRubyObject'],
    'prod_f_block_arg_type' => ['BlockArgNode', 'IRubyObject'],
    'prod_f_arg_asgn_type' => ['ArgumentNode', 'IRubyObject'],
    'prod_regexp_contents_type' => ['Node', 'IRubyObject'],
    'prod_excessed_comma_type' => ['RestArgNode', 'IRubyObject'],
  }
=@@*/
/*
 **** BEGIN LICENSE BLOCK *****
 * Version: EPL 2.0/GPL 2.0/LGPL 2.1
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
 * Copyright (C) 2008-2017 Thomas E Enebo <enebo@acm.org>
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

package @@package@@;

import java.io.IOException;
import java.util.Set;

import org.jruby.RubySymbol;
import org.jruby.ast.*;
import org.jruby.common.IRubyWarnings;
import org.jruby.common.IRubyWarnings.ID;
import org.jruby.lexer.LexerSource;
import org.jruby.lexer.LexingCommon;
import @@lex_package@@.StrTerm;
@@import_ripper@@
import org.jruby.util.ByteList;
import org.jruby.util.CommonByteLists;
import org.jruby.util.KeyValuePair;
import org.jruby.util.StringSupport;
import org.jruby.lexer.yacc.LexContext;
import @@lex_package@@.RubyLexer;
import org.jruby.lexer.yacc.StackState;
import org.jruby.parser.ProductionState;
import org.jruby.parser.ParserState;
import org.jruby.runtime.ThreadContext;
import org.jruby.runtime.builtin.IRubyObject;
import static org.jruby.lexer.yacc.RubyLexer.*;
import static org.jruby.lexer.LexingCommon.AMPERSAND;
import static org.jruby.lexer.LexingCommon.AMPERSAND_AMPERSAND;
import static org.jruby.lexer.LexingCommon.AMPERSAND_DOT;
import static org.jruby.lexer.LexingCommon.BACKTICK;
import static org.jruby.lexer.LexingCommon.BANG;
import static org.jruby.lexer.LexingCommon.CARET;
import static org.jruby.lexer.LexingCommon.DOLLAR_BANG;
import static org.jruby.lexer.LexingCommon.DOT;
import static org.jruby.lexer.LexingCommon.GT;
import static org.jruby.lexer.LexingCommon.LBRACKET_RBRACKET;
import static org.jruby.lexer.LexingCommon.LCURLY;
import static org.jruby.lexer.LexingCommon.LT;
import static org.jruby.lexer.LexingCommon.LT_LT;
import static org.jruby.lexer.LexingCommon.MINUS;
import static org.jruby.lexer.LexingCommon.PERCENT;
import static org.jruby.lexer.LexingCommon.OR;
import static org.jruby.lexer.LexingCommon.OR_OR;
import static org.jruby.lexer.LexingCommon.PLUS;
import static org.jruby.lexer.LexingCommon.RBRACKET;
import static org.jruby.lexer.LexingCommon.RCURLY;
import static org.jruby.lexer.LexingCommon.RPAREN;
import static org.jruby.lexer.LexingCommon.SLASH;
import static org.jruby.lexer.LexingCommon.STAR;
import static org.jruby.lexer.LexingCommon.TILDE;
import static org.jruby.lexer.LexingCommon.EXPR_BEG;
import static org.jruby.lexer.LexingCommon.EXPR_FITEM;
import static org.jruby.lexer.LexingCommon.EXPR_FNAME;
import static org.jruby.lexer.LexingCommon.EXPR_ENDFN;
import static org.jruby.lexer.LexingCommon.EXPR_ENDARG;
import static org.jruby.lexer.LexingCommon.EXPR_END;
import static org.jruby.lexer.LexingCommon.EXPR_LABEL;
import static org.jruby.util.CommonByteLists.FWD_BLOCK;
import static org.jruby.util.CommonByteLists.FWD_KWREST;
 
 public class @@Parser@@Parser extends @@Parser@@ParserBase {
    public @@Parser@@Parser(@@ParserConstructorParams@@) {
        @@ParserConstructorBody@@
    }
%}

// patch_parser.rb will look for token lines with {{ and }} within it to put
// in reasonable strings we expect during a parsing error.
%token <@@keyword_type@@> keyword_class        /* {{`class''}} */
%token <@@keyword_type@@> keyword_module       /* {{`module'}} */
%token <@@keyword_type@@> keyword_def          /* {{`def'}} */
%token <@@keyword_type@@> keyword_undef        /* {{`undef'}} */
%token <@@keyword_type@@> keyword_begin        /* {{`begin'}} */
%token <@@keyword_type@@> keyword_rescue       /* {{`rescue'}} */
%token <@@keyword_type@@> keyword_ensure       /* {{`ensure'}} */
%token <@@keyword_type@@> keyword_end          /* {{`end'}} */
%token <@@keyword_type@@> keyword_if           /* {{`if'}} */
%token <@@keyword_type@@> keyword_unless       /* {{`unless'}} */
%token <@@keyword_type@@> keyword_then         /* {{`then'}} */
%token <@@keyword_type@@> keyword_elsif        /* {{`elsif'}} */
%token <@@keyword_type@@> keyword_else         /* {{`else'}} */
%token <@@keyword_type@@> keyword_case         /* {{`case'}} */
%token <@@keyword_type@@> keyword_when         /* {{`when'}} */
%token <@@keyword_type@@> keyword_while        /* {{`while'}} */
%token <@@keyword_type@@> keyword_until        /* {{`until'}} */
%token <@@keyword_type@@> keyword_for          /* {{`for'}} */
%token <@@keyword_type@@> keyword_break        /* {{`break'}} */
%token <@@keyword_type@@> keyword_next         /* {{`next'}} */
%token <@@keyword_type@@> keyword_redo         /* {{`redo'}} */
%token <@@keyword_type@@> keyword_retry        /* {{`retry'}} */
%token <Object> keyword_in                     /* {{`in'}} */
%token <@@keyword_type@@> keyword_do           /* {{`do'}} */
%token <@@keyword_type@@> keyword_do_cond      /* {{`do' for condition}} */
%token <@@keyword_type@@> keyword_do_block     /* {{`do' for block}} */
%token <@@keyword_type@@> keyword_do_LAMBDA    /* {{`do' for lambda}} */
%token <@@keyword_type@@> keyword_return       /* {{`return'}} */
%token <@@keyword_type@@> keyword_yield        /* {{`yield'}} */
%token <@@keyword_type@@> keyword_super        /* {{`super'}} */
%token <@@keyword_type@@> keyword_self         /* {{`self'}} */
%token <@@keyword_type@@> keyword_nil          /* {{`nil'}} */
%token <@@keyword_type@@> keyword_true         /* {{`true'}} */
%token <@@keyword_type@@> keyword_false        /* {{`false'}} */
%token <@@keyword_type@@> keyword_and          /* {{`and'}} */
%token <@@keyword_type@@> keyword_or           /* {{`or'}} */
%token <@@keyword_type@@> keyword_not          /* {{`not'}} */
%token <@@keyword_type@@> modifier_if          /* {{`if' modifier}} */
%token <@@keyword_type@@> modifier_unless      /* {{`unless' modifier}} */
%token <@@keyword_type@@> modifier_while       /* {{`while' modifier}} */
%token <@@keyword_type@@> modifier_until       /* {{`until' modifier}} */
%token <@@keyword_type@@> modifier_rescue      /* {{`rescue' modifier}} */
%token <@@keyword_type@@> keyword_alias        /* {{`alias'}} */
%token <@@keyword_type@@> keyword_defined      /* {{`defined'}} */
%token <@@keyword_type@@> keyword_BEGIN        /* {{`BEGIN'}} */
%token <@@keyword_type@@> keyword_END          /* {{`END'}} */
%token <@@keyword_type@@> keyword__LINE__      /* {{`__LINE__'}} */
%token <@@keyword_type@@> keyword__FILE__      /* {{`__FILE__'}} */
%token <@@keyword_type@@> keyword__ENCODING__  /* {{`__ENCODING__'}} */
%token <@@token_type@@> tIDENTIFIER          /* {{local variable or method}} */
%token <@@token_type@@> tFID                 /* {{method}} */
%token <@@token_type@@> tGVAR                /* {{global variable}} */
%token <@@token_type@@> tIVAR                /* {{instance variable}} */
%token <@@token_type@@> tCONSTANT            /* {{constant}} */
%token <@@token_type@@> tCVAR                /* {{class variable}} */
%token <@@token_type@@> tLABEL               /* {{label}} */
%token <@@token_integer_type@@> tINTEGER     /* {{integer literal}} */
%token <@@token_float_type@@> tFLOAT         /* {{float literal}} */
%token <@@token_rational_type@@> tRATIONAL   /* {{rational literal}} */
%token <@@token_imaginary_type@@> tIMAGINARY /* {{imaginary literal}} */
%token <@@token_char_type@@> tCHAR           /* {{char literal}} */
%token <@@token_nthref_type@@> tNTH_REF      /* {{numbered reference}} */
%token <@@token_backref_type@@> tBACK_REF    /* {{back reference}} */
%token <@@token_string_type@@> tSTRING_CONTENT /* {{literal content}} */
%token <@@token_regexp_type@@>  tREGEXP_END

%type <@@prod_type@@> singleton strings string string1 xstring regexp
%type <@@prod_type@@> string_contents xstring_contents
%type <@@prod_regexp_contents_type@@> regexp_contents
%type <@@prod_string_type@@> string_content
%type <@@prod_words_type@@> words symbols symbol_list qwords qsymbols
%type <@@prod_words_type@@> word_list qword_list qsym_list  
%type <@@prod_type@@> word 
%type <@@prod_type@@> literal
%type <@@prod_numeric_type@@> numeric simple_numeric
%type <@@prod_type@@> ssym dsym symbol cpath
%type <DefHolder> def_name defn_head defs_head
%type <@@prod_type@@> top_compstmt top_stmts top_stmt begin_block
%type <@@prod_type@@> bodystmt compstmt stmts stmt_or_begin stmt expr arg primary command command_call method_call
%type <@@prod_type@@> expr_value expr_value_do arg_value primary_value 
%type <@@prod_fcall_type@@> fcall
%type <@@prod_type@@> rel_expr
%type <@@prod_type@@> if_tail opt_else case_body case_args cases 
%type <@@prod_rescue_type@@> opt_rescue
%type <@@prod_type@@> exc_list exc_var opt_ensure
%type <@@prod_type@@> args call_args opt_call_args 
%type <@@prod_type@@> paren_args opt_paren_args
%type <ArgsTailHolder> args_tail opt_args_tail block_args_tail opt_block_args_tail 
%type <@@prod_type@@> command_args aref_args
%type <@@prod_blockarg_type@@> opt_block_arg block_arg
%type <@@prod_type@@> var_ref
%type <@@prod_lhs_type@@> var_lhs
%type <@@prod_type@@> command_rhs arg_rhs
%type <@@prod_type@@> command_asgn mrhs mrhs_arg superclass block_call block_command
%type <@@prod_block_optarg_type@@> f_block_optarg
%type <@@prod_type@@> f_block_opt
%type <@@prod_args_type@@> f_arglist f_opt_paren_args f_paren_args f_args
%type <@@prod_farg_type@@> f_arg
%type <@@prod_type@@> f_arg_item
%type <@@prod_farg_type@@> f_optarg
%type <@@prod_type@@> f_marg
%type <@@prod_marg_type@@> f_marg_list 
%type <@@prod_type@@> f_margs f_rest_marg
%type <@@prod_assoc_list_type@@> assoc_list
%type <@@prod_assocs_type@@> assocs
%type <@@prod_assoc_type@@> assoc
%type <@@prod_undef_list_type@@> undef_list
%type <@@prod_type@@> backref string_dvar for_var
%type <@@prod_block_param_type@@> block_param opt_block_param block_param_def
%type <@@prod_type@@> f_opt
%type <@@prod_f_kwarg_type@@> f_kwarg
%type <@@prod_f_kw_type@@> f_kw
%type <@@prod_f_kwarg_type@@> f_block_kwarg
%type <@@prod_type@@> f_block_kw
%type <@@prod_bv_decls_type@@> bv_decls opt_bv_decl 
%type <@@prod_bvar_type@@> bvar
%type <@@prod_lambda_type@@> lambda
%type <@@prod_f_larglist_type@@> f_larglist
%type <@@prod_type@@> lambda_body
%type <@@prod_brace_block_type@@> brace_body do_body
%type <@@prod_brace_block_type@@> brace_block cmd_brace_block do_block
%type <@@prod_type@@> lhs none fitem
%type <@@prod_mlhs_type@@> mlhs
%type <@@prod_mlhs_head_type@@> mlhs_head
%type <@@prod_mlhs_type@@> mlhs_basic   
%type <@@prod_type@@> mlhs_item mlhs_node
%type <@@prod_mlhs_head_type@@> mlhs_post
%type <@@prod_type@@> mlhs_inner
%type <@@prod_p_case_body_type@@> p_case_body
%type <@@prod_type@@> p_cases p_top_expr p_top_expr_body
%type <@@prod_type@@> p_expr p_as p_alt p_expr_basic
%type <@@prod_p_find_type@@> p_find
%type <@@prod_p_args_type@@> p_args 
%type <@@prod_p_args_head_type@@> p_args_head
%type <@@prod_p_args_type@@> p_args_tail
%type <@@prod_p_arg_type@@> p_args_post p_arg
%type <@@prod_type@@> p_value p_primitive p_variable p_var_ref p_expr_ref p_const
%type <@@prod_p_kwargs_type@@> p_kwargs
%type <@@prod_p_kwarg_type@@> p_kwarg
%type <@@prod_p_kw_type@@> p_kw
  /* keyword_variable + user_variable are inlined into the grammar */
%type <@@token_type@@> sym operation operation2 operation3
%type <@@token_type@@> cname op
%type <@@token_type@@> fname 
%type <@@prod_f_rest_arg_type@@> f_rest_arg
%type <@@prod_f_block_arg_type@@> f_block_arg opt_f_block_arg
%type <@@token_type@@> f_norm_arg f_bad_arg
%type <@@token_type@@> f_kwrest f_label 
%type <@@prod_f_arg_asgn_type@@> f_arg_asgn
%type <@@token_type@@> call_op call_op2 reswords relop dot_or_colon
%type <@@token_type@@> p_rest p_kwrest p_kwnorest p_any_kwrest p_kw_label
%type <@@token_type@@> f_no_kwarg f_any_kwrest args_forward
%type <@@prod_excessed_comma_type@@> excessed_comma
%type <@@token_type@@> nonlocal_var
%type <LexContext> lex_ctxt
// Things not declared in MRI - start
%type <@@token_type@@> blkarg_mark restarg_mark kwrest_mark rparen rbracket
%type <@@prod_blockarg_type@@> none_block_pass
%type <@@keyword_type@@> k_return
%type <LexContext> k_class k_module
%type <@@keyword_type@@> k_else k_when k_begin k_if k_do
%type <@@keyword_type@@> k_do_block k_rescue k_ensure k_elsif
%token <ByteList> tUMINUS_NUM
%type <@@keyword_type@@> rbrace
%type <@@keyword_type@@> k_def k_end k_while k_until k_for k_case k_unless
%type <@@prod_type@@> p_lparen p_lbracket
// Things not declared in MRI - end  


%token <Integer> '\\'                   /* {{backslash}} */
%token <Integer> tSP                    /* {{escaped space}} */
%token <Integer> '\t'                   /* {{escaped horizontal tab}} */
%token <Integer> '\f'                   /* {{escaped form feed}} */
%token <Integer> '\r'                   /* {{escaped carriage return}} */
%token <Integer> '\v'                   /* {{escaped vertical tab}} */
%token <@@token_type@@> tUPLUS               /* {{unary+}} */
%token <@@token_type@@> tUMINUS              /* {{unary-}} */
%token <@@token_type@@> tPOW                 /* {{**}} */
%token <@@token_type@@> tCMP                 /* {{<=>}} */
%token <@@token_type@@> tEQ                  /* {{==}} */
%token <@@token_type@@> tEQQ                 /* {{===}} */
%token <@@token_type@@> tNEQ                 /* {{!=}} */
%token <@@token_type@@> tGEQ                 /* {{>=}} */
%token <@@token_type@@> tLEQ                 /* {{<=}} */
%token <@@token_type@@> tANDOP               /* {{&&}}*/
%token <@@token_type@@> tOROP                /* {{||}} */
%token <@@token_type@@> tMATCH               /* {{=~}} */
%token <@@token_type@@> tNMATCH              /* {{!~}} */
%token <@@token_type@@> tDOT2                /* {{..}} */
%token <@@token_type@@> tDOT3                /* {{...}} */
%token <@@token_type@@> tBDOT2               /* {{(..}} */
%token <@@token_type@@> tBDOT3               /* {{(...}} */
%token <@@token_type@@> tAREF                /* {{[]}} */
%token <@@token_type@@> tASET                /* {{[]=}} */
%token <@@token_type@@> tLSHFT               /* {{<<}} */
%token <@@token_type@@> tRSHFT               /* {{>>}} */
%token <@@token_type@@> tANDDOT              /* {{&.}} */
%token <ByteList> tCOLON2                    /* {{::}} */
%token <@@token_type@@> tCOLON3              /* {{:: at EXPR_BEG}} */
%token <@@token_type@@> tOP_ASGN             /* {{operator assignment}} +=, etc. */
%token <@@token_type@@> tASSOC               /* {{=>}} */
%token <Integer> tLPAREN               /* {{(}} */
%token <Integer> tLPAREN_ARG           /* {{( arg}} */
%token <@@token_type@@> tLBRACK              /* {{[}} */
%token <Object> tLBRACE               /* {{{}} */
%token <Integer> tLBRACE_ARG           /* {{{ arg}} */
%token <@@token_type@@> tSTAR                /* {{*}} */
%token <@@token_type@@> tDSTAR                /* {{**arg}} */
%token <@@token_type@@> tAMPER               /* {{&}} */
%token <@@token_type@@> tLAMBDA              /* {{->}} */
%token <@@token_type@@> tSYMBEG              /* {{symbol literal}} */
%token <@@token_type@@> tSTRING_BEG          /* {{string literal}} */
%token <@@token_type@@> tXSTRING_BEG         /* {{backtick literal}} */
%token <@@token_type@@> tREGEXP_BEG          /* {{regexp literal}} */
%token <@@token_type@@> tWORDS_BEG           /* {{word list}} */
%token <@@token_type@@> tQWORDS_BEG          /* {{verbatim work list}} */
%token <@@token_type@@> tSTRING_END          /* {{terminator}} */
%token <@@token_type@@> tSYMBOLS_BEG          /* {{symbol list}} */
%token <@@token_type@@> tQSYMBOLS_BEG         /* {{verbatim symbol list}} */
%token <@@token_type@@> tSTRING_DEND          /* {{'}'}} */
%token <@@token_type@@> tSTRING_DBEG tSTRING_DVAR tLAMBEG tLABEL_END
/* RIPPER-ONY TOKENS { */
%token <IRubyObject> tIGNORED_NL tCOMMENT tEMBDOC_BEG tEMBDOC tEMBDOC_END
%token <IRubyObject> tHEREDOC_BEG tHEREDOC_END
@@program_production@@
/* } RIPPER-ONY TOKENS */


/*
 *    precedence table
 */

%nonassoc tLOWEST
%nonassoc tLBRACE_ARG

%nonassoc  modifier_if modifier_unless modifier_while modifier_until keyword_in
%left  keyword_or keyword_and
%right keyword_not
%nonassoc keyword_defined
%right '=' tOP_ASGN
%left modifier_rescue
%right '?' ':'
%nonassoc tDOT2 tDOT3 tBDOT2 tBDOT3
%left  tOROP
%left  tANDOP
%nonassoc  tCMP tEQ tEQQ tNEQ tMATCH tNMATCH
%left  '>' tGEQ '<' tLEQ
%left  '|' '^'
%left  '&'
%left  tLSHFT tRSHFT
%left  '+' '-'
%left  '*' '/' '%'
%right tUMINUS_NUM tUMINUS
%right tPOW
%right '!' '~' tUPLUS

   //%token <Integer> tLAST_TOKEN

%%
program       : {
                  p.setState(EXPR_BEG);
                  p.initTopLocalVariables();
              } top_compstmt {
                  /*%%%*/
                  Node expr = $2;
                  if (expr != null && !p.getConfiguration().isEvalParse()) {
                      /* last expression should not be void */
                      if ($2 instanceof BlockNode) {
                        expr = $<BlockNode>2.getLast();
                      } else {
                        expr = $2;
                      }
                      expr = p.remove_begin(expr);
                      p.void_expr(expr);
                  }
                  p.getResult().setAST(p.addRootNode($2));
                  /*% %*/
                  /*% ripper[final]: program!($2) %*/
              }

top_compstmt  : top_stmts opt_terms {
                  $$ = p.void_stmts($1);
              }

top_stmts     : none {
                  /*%%%*/
                  $$ = null;
                  /*% %*/
                  /*% ripper: stmts_add!(stmts_new!, void_stmt!) %*/
              }
              | top_stmt {
                  /*%%%*/
                  $$ = p.newline_node($1, @1.start());
                  /*% %*/
                  /*% ripper: stmts_add!(stmts_new!, $1) %*/
              }
              | top_stmts terms top_stmt {
                  /*%%%*/
                  $$ = p.appendToBlock($1, p.newline_node($3, @3.start()));
                  /*% %*/
                  /*% ripper: stmts_add!($1, $3) %*/
              }
              | error top_stmt {
                  $$ = p.remove_begin($2);
              }

top_stmt      : stmt
              | keyword_BEGIN begin_block {
                  $$ = null;
              }

begin_block   : '{' top_compstmt '}' {
                  /*%%%*/
                  p.getResult().addBeginNode(new PreExe19Node(@1.start(), p.getCurrentScope(), $2, p.src_line()));
                  //                  $$ = new BeginNode(@1.start(), p.makeNullNil($2));
                  $$ = null;
                  /*% %*/
                  /*% ripper: BEGIN!($2) %*/
              }

bodystmt      : compstmt opt_rescue k_else {
                   if ($2 == null) p.yyerror("else without rescue is useless"); 
              } compstmt opt_ensure {
                  /*%%%*/
                   $$ = p.new_bodystmt($1, $2, $5, $6);
                  /*% %*/
                  /*% ripper: bodystmt!(escape_Qundef($1), escape_Qundef($2), escape_Qundef($5), escape_Qundef($6)) %*/
              }
              | compstmt opt_rescue opt_ensure {
                  /*%%%*/
                   $$ = p.new_bodystmt($1, $2, null, $3);
                  /*% %*/
                  /*% ripper: bodystmt!(escape_Qundef($1), escape_Qundef($2), Qnil, escape_Qundef($3)) %*/
              }

compstmt        : stmts opt_terms {
                    $$ = p.void_stmts($1);
                }

stmts           : none {
                   /*%%%*/
                   $$ = null;
                   /*% %*/
                   /*% ripper: stmts_add!(stmts_new!, void_stmt!) %*/
                }
                | stmt_or_begin {
                   /*%%%*/
                    $$ = p.newline_node($1, @1.start());
                   /*% %*/
                   /*% ripper: stmts_add!(stmts_new!, $1) %*/
                }
                | stmts terms stmt_or_begin {
                   /*%%%*/
                    $$ = p.appendToBlock($1, p.newline_node($3, @3.start()));
                   /*% %*/
                   /*% ripper: stmts_add!($1, $3) %*/
                }
                | error stmt {
                    $$ = $2;
                }

stmt_or_begin   : stmt {
                    $$ = $1;
                }
                | keyword_BEGIN {
                   p.yyerror("BEGIN is permitted only at toplevel");
                } begin_block {
                   $$ = $3;
                }

stmt            : keyword_alias fitem {
                    p.setState(EXPR_FNAME|EXPR_FITEM);
                } fitem {
                    /*%%%*/
                    $$ = newAlias($1, $2, $4);
                    /*% %*/
                    /*% ripper: alias!($2, $4) %*/
                }
                | keyword_alias tGVAR tGVAR {
                    /*%%%*/
                    $$ = new VAliasNode($1, p.symbolID($2), p.symbolID($3));
                    /*% %*/
                    /*% ripper: var_alias!($2, $3) %*/
                }
                | keyword_alias tGVAR tBACK_REF {
                    /*%%%*/
                    $$ = new VAliasNode($1, p.symbolID($2), p.symbolID($<BackRefNode>3.getByteName()));
                    /*% %*/
                    /*% ripper: var_alias!($2, $3) %*/
                }
                | keyword_alias tGVAR tNTH_REF {
                    String message = "can't make alias for the number variables";
                    /*%%%*/
                    p.yyerror(message);
                    /*% %*/
                    /*% ripper[error]: alias_error!(ERR_MESG(), $3) %*/
                }
                | keyword_undef undef_list {
                    /*%%%*/
                    $$ = $2;
                    /*% %*/
                    /*% ripper: undef!($2) %*/
                }
                | stmt modifier_if expr_value {
                    /*%%%*/
                    $$ = p.new_if(@1.start(), $3, p.remove_begin($1), null);
                    p.fixpos($<Node>$, $3);
                    /*% %*/
                    /*% ripper: if_mod!($3, $1) %*/
                }
                | stmt modifier_unless expr_value {
                    /*%%%*/
                    $$ = p.new_if(@1.start(), $3, null, p.remove_begin($1));
                    p.fixpos($<Node>$, $3);
                    /*% %*/
                    /*% ripper: unless_mod!($3, $1) %*/
                }
                | stmt modifier_while expr_value {
                    /*%%%*/
                    if ($1 != null && $1 instanceof BeginNode) {
                        $$ = new WhileNode(@1.start(), p.cond($3), $<BeginNode>1.getBodyNode(), false);
                    } else {
                        $$ = new WhileNode(@1.start(), p.cond($3), $1, true);
                    }
                    /*% %*/
                    /*% ripper: while_mod!($3, $1) %*/
                }
                | stmt modifier_until expr_value {
                    /*%%%*/
                    if ($1 != null && $1 instanceof BeginNode) {
                        $$ = new UntilNode(@1.start(), p.cond($3), $<BeginNode>1.getBodyNode(), false);
                    } else {
                        $$ = new UntilNode(@1.start(), p.cond($3), $1, true);
                    }
                    /*% %*/
                    /*% ripper: until_mod!($3, $1) %*/
                }
                | stmt modifier_rescue stmt {
                    /*%%%*/
                    $$ = p.newRescueModNode($1, $3);
                    /*% %*/
                    /*% ripper: rescue_mod!($1, $3) %*/
                }
                | keyword_END '{' compstmt '}' {
                   if (p.getLexContext().in_def) {
                       p.warn("END in method; use at_exit");
                    }
                    /*%%%*/
                    $$ = new PostExeNode($1, $3, p.src_line());
                    /*% %*/
                    /*% ripper: END!($3) %*/
                }
                | command_asgn
                | mlhs '=' lex_ctxt command_call {
                    /*%%%*/
                    $$ = node_assign($1, $4);
                    /*% %*/
                    /*% ripper: massign!($1, $4) %*/
                }
                | lhs '=' lex_ctxt mrhs {
                    /*%%%*/
                    p.value_expr($4);
                    $$ = node_assign($1, $4);
                    /*% %*/
                    /*% ripper: assign!($1, $4) %*/
                }
                | mlhs '=' lex_ctxt mrhs_arg modifier_rescue stmt {
                    /*%%%*/
                    $$ = node_assign($1, p.newRescueModNode($4, $6));
                    /*% %*/
                    /*% ripper: massign!($1, rescue_mod!($4, $6)) %*/
                }
                | mlhs '=' lex_ctxt mrhs_arg {
                    /*%%%*/
                    $$ = node_assign($1, $4);
                    /*% %*/
                    /*% ripper: massign!($1, $4) %*/
                }
                | expr

command_asgn    : lhs '=' lex_ctxt command_rhs {
                    /*%%%*/
                    p.value_expr($4);
                    $$ = node_assign($1, $4);
                    /*% %*/
                    /*% ripper: assign!($1, $4) %*/
                }
                | var_lhs tOP_ASGN lex_ctxt command_rhs {
                    /*%%%*/
                    p.value_expr($4);
                    $$ = p.new_op_assign($1, $2, $4);
                    /*% %*/
                    /*% ripper: opassign!($1, $2, $4) %*/
                }
                | primary_value '[' opt_call_args rbracket tOP_ASGN lex_ctxt command_rhs {
                    /*%%%*/
                    p.value_expr($7);
                    $$ = p.new_ary_op_assign($1, $5, $3, $7);
                    /*% %*/
                    /*% ripper: opassign!(aref_field!($1, escape_Qundef($3)), $5, $7) %*/
                }
                | primary_value call_op tIDENTIFIER tOP_ASGN lex_ctxt command_rhs {
                    /*%%%*/
                    p.value_expr($6);
                    $$ = p.new_attr_op_assign($1, $2, $6, $3, $4);
                    /*% %*/
                    /*% ripper: opassign!(field!($1, $2, $3), $4, $6) %*/
                }
                | primary_value call_op tCONSTANT tOP_ASGN lex_ctxt command_rhs {
                    /*%%%*/
                    p.value_expr($6);
                    $$ = p.new_attr_op_assign($1, $2, $6, $3, $4);
                    /*% %*/
                    /*% ripper: opassign!(field!($1, $2, $3), $4, $6) %*/
                }
                | primary_value tCOLON2 tCONSTANT tOP_ASGN lex_ctxt command_rhs {
                    /*%%%*/
                    int line = @1.start();
                    $$ = p.new_const_op_assign(line, p.new_colon2(line, $1, $3), $4, $6);
                    /*% %*/
                    /*% ripper: opassign!(const_path_field!($1, $3), $4, $6) %*/
                }

                | primary_value tCOLON2 tIDENTIFIER tOP_ASGN lex_ctxt command_rhs {
                    /*%%%*/
                    p.value_expr($6);
                    $$ = p.new_attr_op_assign($1, $2, $6, $3, $4);
                    /*% %*/
                    /*% ripper: opassign!(field!($1, ID2VAL(idCOLON2), $3), $4, $6) %*/
                }
 		| defn_head f_opt_paren_args '=' command {
                    p.endless_method_name($1);
                    p.restore_defun($1);
                    /*%%%*/
                    $$ = new DefnNode($1.line, $1.name, $2, p.getCurrentScope(), p.reduce_nodes(p.remove_begin($4)), @4.end());
                    // Changed from MRI
                    /*% %*/
                    /*% ripper: def!(get_value($1), $2, bodystmt!($4, Qnil, Qnil, Qnil)) %*/
                    p.popCurrentScope();
                }
                | defn_head f_opt_paren_args '=' command modifier_rescue arg {
                    p.endless_method_name($1);
                    p.restore_defun($1);
                    /*%%%*/
                    Node body = p.reduce_nodes(p.remove_begin(p.rescued_expr(@1.start(), $4, $6)));
                    $$ = new DefnNode($1.line, $1.name, $2, p.getCurrentScope(), body, @6.end());
                    // Changed from MRI (cmobined two stmts)
                    /*% %*/
                    /*% ripper: def!(get_value($1), $2, bodystmt!(rescue_mod!($4, $6), Qnil, Qnil, Qnil)) %*/

                    p.popCurrentScope();
                }
                | defs_head f_opt_paren_args '=' command {
                    p.endless_method_name($1);
                    p.restore_defun($1);
                    /*%%%*/
                    $$ = new DefsNode($1.line, (Node) $1.singleton, $1.name, $2, p.getCurrentScope(), p.reduce_nodes(p.remove_begin($4)), @4.end());
                    /*% %*/                    
                    /*% ripper: defs!(AREF($1, 0), AREF($1, 1), AREF($1, 2), $2, bodystmt!($4, Qnil, Qnil, Qnil)) %*/
                    p.popCurrentScope();
                }
                | defs_head f_opt_paren_args '=' command modifier_rescue arg {
                    p.endless_method_name($1);
                    p.restore_defun($1);
                    /*%%%*/
                    Node body = p.reduce_nodes(p.remove_begin(p.rescued_expr(@1.start(), $4, $6)));
                    $$ = new DefsNode($1.line, (Node) $1.singleton, $1.name, $2, p.getCurrentScope(), body, @6.end());
                    /*% %*/                    
                    /*% ripper: defs!(AREF($1, 0), AREF($1, 1), AREF($1, 2), $2, bodystmt!(rescue_mod!($4, $6), Qnil, Qnil, Qnil)) %*/
                    p.popCurrentScope();
                }
                | backref tOP_ASGN lex_ctxt command_rhs {
                    /*%%%*/
                    p.backrefAssignError($1);
                    /*% %*/
                    /*% ripper[error]: backref_error(p, RNODE($1), assign!(var_field(p, $1), $4)) %*/
                }

command_rhs     : command_call %prec tOP_ASGN {
                    p.value_expr($1);
                    $$ = $1;
                }
		| command_call modifier_rescue stmt {
                    /*%%%*/
                    p.value_expr($1);
                    $$ = p.newRescueModNode($1, $3);
                    /*% %*/
                    /*% ripper: rescue_mod!($1, $3) %*/
                }
		| command_asgn
 

// Node:expr *CURRENT* all but arg so far
expr            : command_call
                | expr keyword_and expr {
                    $$ = p.logop($1, AMPERSAND_AMPERSAND, $3);
                }
                | expr keyword_or expr {
                    $$ = p.logop($1, OR_OR, $3);
                }
                | keyword_not opt_nl expr {
                    $$ = p.call_uni_op(p.method_cond($3), BANG);
                }
                | '!' command_call {
                    $$ = p.call_uni_op(p.method_cond($2), BANG);
                }
                | arg tASSOC {
                    p.value_expr($1);
                    p.setState(EXPR_BEG|EXPR_LABEL);
                    p.setCommandStart(false);
                    // MRI 3.1 uses $2 but we want tASSOC typed?
                    LexContext ctxt = p.getLexContext();
                    $$ = ctxt.in_kwarg;
                    ctxt.in_kwarg = true;
                } {
                    $$ = p.push_pvtbl();
                } p_top_expr_body {
                    p.pop_pvtbl($<Set>4);
                    LexContext ctxt = p.getLexContext();
                    ctxt.in_kwarg = $<Boolean>3;
                    /*%%%*/
                    $$ = p.newPatternCaseNode(@1.start(), $1, p.newIn(@1.start(), $5, null, null));
                    /*% %*/
                    /*% ripper: case!($1, in!($5, Qnil, Qnil)) %*/
                }
                | arg keyword_in {
                    p.value_expr($1);
                    p.setState(EXPR_BEG|EXPR_LABEL);
                    p.setCommandStart(false);
                    LexContext ctxt = p.getLexContext();
                    $$ = ctxt.in_kwarg;
                    ctxt.in_kwarg = true;
                } {
                    $$ = p.push_pvtbl();
                } p_top_expr_body {
                    p.pop_pvtbl($<Set>4);
                    LexContext ctxt = p.getLexContext();
                    ctxt.in_kwarg = $<Boolean>3;
                    /*%%%*/
                    $$ = p.newPatternCaseNode(@1.start(), $1, p.newIn(@1.start(), $5, new TrueNode(p.tokline()), new FalseNode(p.tokline())));
                    /*% %*/
                    /*% ripper: case!($1, in!($5, Qnil, Qnil)) %*/
                }
		| arg %prec tLBRACE_ARG

/* note[ripper]: We use DefHolder and we ignore MRI ripper code */
// [!null] - DefHolder
def_name        : fname {
                    p.pushLocalScope();
                    ByteList currentArg = p.getCurrentArg();
                    p.setCurrentArg(null);
                    LexContext ctxt = p.getLexContext();
                    RubySymbol name = p.get_id($1);
                    /*%%%*/
                    p.numparam_name($1);
                    $$ = new DefHolder(name, currentArg, (LexContext) ctxt.clone());
                    // Changed from MRI
                    /*% 
                    p.numparam_name(@1.id);
                        $$ = new DefHolder(name, currentArg, p.get_value($1), (LexContext) ctxt.clone());
                    %*/
                    ctxt.in_def = true;
                    p.setCurrentArg(null);
                }

// [!null] - DefHolder
defn_head       : k_def def_name {
                    $2.line = @1.start();
                    $$ = $2;
                }

// [!null] - DefHolder
defs_head       : k_def singleton dot_or_colon {
                    p.setState(EXPR_FNAME); 
                    LexContext ctxt = p.getLexContext();
                    ctxt.in_argdef = true;
                } def_name {
                    p.setState(EXPR_ENDFN|EXPR_LABEL);
                    $5.line = @1.start();
                    $$ = $5;
                    /*%%%*/
                    $5.setSingleton($2);
                    $5.setDotOrColon(p.extractByteList($3));
                    // Changed from MRI
                    /*%
                       $<DefHolder>$.value = p.new_array($2, $3, $<DefHolder>$.value);
                    %*/
                }

expr_value      : expr {
                    p.value_expr($1);
                }

expr_value_do   : {
                    p.getConditionState().push1();
                } expr_value do {
                    p.getConditionState().pop();
                    $$ = $2;
                }

// Node:command - call with or with block on end [!null]
command_call    : command
                | block_command

// Node:block_command - A call with a block (foo.bar {...}, foo::bar {...}, bar {...}) [!null]
block_command   : block_call
                | block_call call_op2 operation2 command_args {
                    /*%%%*/
                    $$ = p.new_call($1, $2, $3, $4, null, @3.start());
                    /*% %*/
                    /*% ripper: method_add_arg!(call!($1, $2, $3), $4) %*/
                }

// :brace_block - [!null]
cmd_brace_block : tLBRACE_ARG brace_body '}' {
                    $$ = $2;
                    /*%%%*/
                    // FIXME: Missing loc stuff here.
                    /*% %*/
                }

fcall           : operation {
                    /*%%%*/
                    $$ = p.new_fcall($1);
                    /*% %*/
                    /*% ripper: $1 %*/
                }

// Node:command - fcall/call/yield/super [!null]
command        : fcall command_args %prec tLOWEST {
                    /*%%%*/
                    p.frobnicate_fcall_args($1, $2, null);
                    $$ = $1;
                    /*% %*/
                    /*% ripper: command!($1, $2) %*/
                }
                | fcall command_args cmd_brace_block {
                    /*%%%*/
                    p.frobnicate_fcall_args($1, $2, $3);
                    $$ = $1;
                    /*% %*/
                    /*% ripper: method_add_block!(command!($1, $2), $3) %*/
                }
                | primary_value call_op operation2 command_args %prec tLOWEST {
                    /*%%%*/
                    $$ = p.new_call($1, $2, $3, $4, null, @3.start());
                    /*% %*/
                    /*% ripper: command_call!($1, $2, $3, $4) %*/
                }
                | primary_value call_op operation2 command_args cmd_brace_block {
                    /*%%%*/
                    $$ = p.new_call($1, $2, $3, $4, $5, @3.start());
                    /*% %*/
                    /*% ripper: method_add_block!(command_call!($1, $2, $3, $4), $5) %*/
                }
                | primary_value tCOLON2 operation2 command_args %prec tLOWEST {
                    /*%%%*/
                    $$ = p.new_call($1, $3, $4, null);
                    /*% %*/
                    /*% ripper: command_call!($1, ID2VAL(idCOLON2), $3, $4) %*/
                }
                | primary_value tCOLON2 operation2 command_args cmd_brace_block {
                    /*%%%*/
                    $$ = p.new_call($1, $3, $4, $5);
                    /*% %*/
                    /*% ripper: method_add_block!(command_call!($1, ID2VAL(idCOLON2), $3, $4), $5) %*/
                }
                | keyword_super command_args {
                    /*%%%*/
                    $$ = p.new_super($1, $2);
                    /*% %*/
                    /*% ripper: super!($2) %*/
                }
                | keyword_yield command_args {
                    /*%%%*/
                    $$ = p.new_yield($1, $2);
                    /*% %*/
                    /*% ripper: yield!($2) %*/
                }
                | k_return call_args {
                    /*%%%*/
                    $$ = new ReturnNode($1, p.ret_args($2, $1));
                    /*% %*/
                    /*% ripper: return!($2) %*/
                }
                | keyword_break call_args {
                    /*%%%*/
                    $$ = new BreakNode($1, p.ret_args($2, $1));
                    /*% %*/
                    /*% ripper: break!($2) %*/
                }
                | keyword_next call_args {
                    /*%%%*/
                    $$ = new NextNode($1, p.ret_args($2, $1));
                    /*% %*/
                    /*% ripper: next!($2) %*/
                }

// MultipleAssigNode:mlhs - [!null]
mlhs            : mlhs_basic
                | tLPAREN mlhs_inner rparen {
                    /*%%%*/
                    $$ = $2;
                    /*% %*/
                    /*% ripper: mlhs_paren!($2) %*/
                }

// MultipleAssignNode:mlhs_entry - mlhs w or w/o parens [!null]
mlhs_inner      : mlhs_basic {
                    $$ = $1;
                }
                | tLPAREN mlhs_inner rparen {
                    /*%%%*/
                    $$ = new MultipleAsgnNode($1, p.newArrayNode($1, $2), null, null);
                    /*% %*/
                    /*% ripper: mlhs_paren!($2) %*/
                }

// MultipleAssignNode:mlhs_basic - multiple left hand side (basic because used in multiple context) [!null]
mlhs_basic      : mlhs_head {
                    /*%%%*/
                    $$ = new MultipleAsgnNode(@1.start(), $1, null, null);
                    /*% %*/
                    /*% ripper: $1 %*/
                }
                | mlhs_head mlhs_item {
                    /*%%%*/
                    $$ = new MultipleAsgnNode(@1.start(), $1.add($2), null, null);
                    /*% %*/
                    /*% ripper: mlhs_add!($1, $2) %*/
                }
                | mlhs_head tSTAR mlhs_node {
                    /*%%%*/
                    $$ = new MultipleAsgnNode(@1.start(), $1, $3, (ListNode) null);
                    /*% %*/
                    /*% ripper: mlhs_add_star!($1, $3) %*/
                }
                | mlhs_head tSTAR mlhs_node ',' mlhs_post {
                    /*%%%*/
                    $$ = new MultipleAsgnNode(@1.start(), $1, $3, $5);
                    /*% %*/
                    /*% ripper: mlhs_add_post!(mlhs_add_star!($1, $3), $5) %*/
                }
                | mlhs_head tSTAR {
                    /*%%%*/
                    $$ = new MultipleAsgnNode(@1.start(), $1, new StarNode(p.src_line()), null);
                    /*% %*/
                    /*% ripper: mlhs_add_star!($1, Qnil) %*/
                }
                | mlhs_head tSTAR ',' mlhs_post {
                    /*%%%*/
                    $$ = new MultipleAsgnNode(@1.start(), $1, new StarNode(p.src_line()), $4);
                    /*% %*/
                    /*% ripper: mlhs_add_post!(mlhs_add_star!($1, Qnil), $4) %*/
                }
                | tSTAR mlhs_node {
                    /*%%%*/
                    $$ = new MultipleAsgnNode(@2.start(), null, $2, null);
                    /*% %*/
                    /*% ripper: mlhs_add_star!(mlhs_new!, $2) %*/
                }
                | tSTAR mlhs_node ',' mlhs_post {
                    /*%%%*/
                    $$ = new MultipleAsgnNode(@2.start(), null, $2, $4);
                    /*% %*/
                    /*% ripper: mlhs_add_post!(mlhs_add_star!(mlhs_new!, $2), $4) %*/
                }
                | tSTAR {
                    /*%%%*/
                    $$ = new MultipleAsgnNode(p.src_line(), null, new StarNode(p.src_line()), null);
                    /*% %*/
                    /*% ripper: mlhs_add_star!(mlhs_new!, Qnil) %*/
                }
                | tSTAR ',' mlhs_post {
                    /*%%%*/
                    $$ = new MultipleAsgnNode(p.src_line(), null, new StarNode(p.src_line()), $3);
                    /*% %*/
                    /*% ripper: mlhs_add_post!(mlhs_add_star!(mlhs_new!, Qnil), $3) %*/
                }

mlhs_item       : mlhs_node
                | tLPAREN mlhs_inner rparen {
                    /*%%%*/
                    $$ = $2;
                    /*% %*/
                    /*% ripper: mlhs_paren!($2) %*/
                }

// Set of mlhs terms at front of mlhs (a, *b, d, e = arr  # a is head)
mlhs_head       : mlhs_item ',' {
                    /*%%%*/
                    $$ = p.newArrayNode(@1.start(), $1);
                    /*% %*/
                    /*% ripper: mlhs_add!(mlhs_new!, $1) %*/
                }
                | mlhs_head mlhs_item ',' {
                    /*%%%*/
                    $$ = $1.add($2);
                    /*% %*/
                    /*% ripper: mlhs_add!($1, $2) %*/
                }

// Set of mlhs terms at end of mlhs (a, *b, d, e = arr  # d,e is post)
mlhs_post       : mlhs_item {
                    /*%%%*/
                    $$ = p.newArrayNode(@1.start(), $1);
                    /*% %*/
                    /*% ripper: mlhs_add!(mlhs_new!, $1) %*/
                }
                | mlhs_post ',' mlhs_item {
                    /*%%%*/
                    $$ = $1.add($3);
                    /*% %*/
                    /*% ripper: mlhs_add!($1, $3) %*/
                }

mlhs_node       : /*mri:user_variable*/ tIDENTIFIER {
                    /*%%%*/
                   $$ = p.assignableLabelOrIdentifier($1, null);
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | tIVAR {
                    /*%%%*/
                   $$ = new InstAsgnNode(p.tokline(), p.symbolID($1), NilImplicitNode.NIL);
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | tGVAR {
                    /*%%%*/
                   $$ = new GlobalAsgnNode(p.tokline(), p.symbolID($1), NilImplicitNode.NIL);
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | tCONSTANT {
                    /*%%%*/
                    if (p.getLexContext().in_def) p.compile_error("dynamic constant assignment");
                    $$ = new ConstDeclNode(p.tokline(), p.symbolID($1), null, NilImplicitNode.NIL);
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | tCVAR {
                    /*%%%*/
                    $$ = new ClassVarAsgnNode(p.tokline(), p.symbolID($1), NilImplicitNode.NIL);
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                } /*mri:user_variable*/
                | /*mri:keyword_variable*/ keyword_nil {
                    /*%%%*/
                    p.compile_error("Can't assign to nil");
                    $$ = null;
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | keyword_self {
                    /*%%%*/
                    p.compile_error("Can't change the value of self");
                    $$ = null;
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | keyword_true {
                    /*%%%*/
                    p.compile_error("Can't assign to true");
                    $$ = null;
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | keyword_false {
                    /*%%%*/
                    p.compile_error("Can't assign to false");
                    $$ = null;
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | keyword__FILE__ {
                    /*%%%*/
                    p.compile_error("Can't assign to __FILE__");
                    $$ = null;
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | keyword__LINE__ {
                    /*%%%*/
                    p.compile_error("Can't assign to __LINE__");
                    $$ = null;
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | keyword__ENCODING__ {
                    /*%%%*/
                    p.compile_error("Can't assign to __ENCODING__");
                    $$ = null;
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                } /*mri:keyword_variable*/
                | primary_value '[' opt_call_args rbracket {
                    /*%%%*/
                    $$ = p.aryset($1, $3);
                    /*% %*/
                    /*% ripper: aref_field!($1, escape_Qundef($3)) %*/
                }
                | primary_value call_op tIDENTIFIER {
                    if ($2 == AMPERSAND_DOT) {
                        p.compile_error("&. inside multiple assignment destination");
                    }
                    /*%%%*/
                    $$ = p.attrset($1, $2, $3);
                    /*% %*/
                    /*% ripper: field!($1, $2, $3) %*/
                }
                | primary_value tCOLON2 tIDENTIFIER {
                    /*%%%*/
                    $$ = p.attrset($1, $3);
                    /*% %*/
                    /*% ripper: const_path_field!($1, $3) %*/
                }
                | primary_value call_op tCONSTANT {
                    if ($2 == AMPERSAND_DOT) {
                        p.compile_error("&. inside multiple assignment destination");
                    }
                    /*%%%*/
                    $$ = p.attrset($1, $2, $3);
                    /*% %*/
                    /*% ripper: field!($1, $2, $3) %*/
                }
                | primary_value tCOLON2 tCONSTANT {
                    /*%%%*/
                    if (p.getLexContext().in_def) p.yyerror("dynamic constant assignment");

                    Integer position = @1.start();

                    $$ = new ConstDeclNode(position, (RubySymbol) null, p.new_colon2(position, $1, $3), NilImplicitNode.NIL);
                    /*% %*/
                    /*% ripper: const_decl(p, const_path_field!($1, $3)) %*/
                }
                | tCOLON3 tCONSTANT {
                    /*%%%*/
                    if (p.getLexContext().in_def) {
                        p.yyerror("dynamic constant assignment");
                    }

                    Integer position = p.tokline();

                    $$ = new ConstDeclNode(position, (RubySymbol) null, p.new_colon3(position, $2), NilImplicitNode.NIL);
                    /*% %*/
                    /*% ripper: const_decl(p, top_const_field!($2)) %*/
                }
                | backref {
                    /*%%%*/
                    p.backrefAssignError($1);
                    /*% %*/
                    /*% ripper[error]: backref_error(p, RNODE($1), var_field(p, $1)) %*/
                }

// [!null or throws]
lhs             : /*mri:user_variable*/ tIDENTIFIER {
                    /*%%%*/
                    $$ = p.assignableLabelOrIdentifier($1, null);
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                    
                }
                | tIVAR {
                    /*%%%*/
                    $$ = new InstAsgnNode(p.tokline(), p.symbolID($1), NilImplicitNode.NIL);
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | tGVAR {
                    /*%%%*/
                    $$ = new GlobalAsgnNode(p.tokline(), p.symbolID($1), NilImplicitNode.NIL);
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | tCONSTANT {
                    /*%%%*/
                    if (p.getLexContext().in_def) p.compile_error("dynamic constant assignment");

                    $$ = new ConstDeclNode(p.tokline(), p.symbolID($1), null, NilImplicitNode.NIL);
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | tCVAR {
                    /*%%%*/
                    $$ = new ClassVarAsgnNode(p.tokline(), p.symbolID($1), NilImplicitNode.NIL);
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                } /*mri:user_variable*/
                | /*mri:keyword_variable*/ keyword_nil {
                    /*%%%*/
                    p.compile_error("Can't assign to nil");
                    $$ = null;
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | keyword_self {
                    /*%%%*/
                    p.compile_error("Can't change the value of self");
                    $$ = null;
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | keyword_true {
                    /*%%%*/
                    p.compile_error("Can't assign to true");
                    $$ = null;
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | keyword_false {
                    /*%%%*/
                    p.compile_error("Can't assign to false");
                    $$ = null;
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | keyword__FILE__ {
                    /*%%%*/
                    p.compile_error("Can't assign to __FILE__");
                    $$ = null;
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | keyword__LINE__ {
                    /*%%%*/
                    p.compile_error("Can't assign to __LINE__");
                    $$ = null;
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | keyword__ENCODING__ {
                    /*%%%*/
                    p.compile_error("Can't assign to __ENCODING__");
                    $$ = null;
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                } /*mri:keyword_variable*/
                | primary_value '[' opt_call_args rbracket {
                    /*%%%*/
                    $$ = p.aryset($1, $3);
                    /*% %*/
                    /*% ripper: aref_field!($1, escape_Qundef($3)) %*/
                }
                | primary_value call_op tIDENTIFIER {
                    /*%%%*/
                    $$ = p.attrset($1, $2, $3);
                    /*% %*/
                    /*% ripper: field!($1, $2, $3) %*/
                }
                | primary_value tCOLON2 tIDENTIFIER {
                    /*%%%*/
                    $$ = p.attrset($1, $3);
                    /*% %*/
                    /*% ripper: field!($1, ID2VAL(idCOLON2), $3) %*/
                }
                | primary_value call_op tCONSTANT {
                    /*%%%*/
                    $$ = p.attrset($1, $2, $3);
                    /*% %*/
                    /*% ripper: field!($1, $2, $3) %*/
                }
                | primary_value tCOLON2 tCONSTANT {
                    /*%%%*/
                    if (p.getLexContext().in_def) {
                        p.yyerror("dynamic constant assignment");
                    }

                    Integer position = @1.start();

                    $$ = new ConstDeclNode(position, (RubySymbol) null, p.new_colon2(position, $1, $3), NilImplicitNode.NIL);
                    /*% %*/
                    /*% ripper: const_decl(p, const_path_field!($1, $3)) %*/
                }
                | tCOLON3 tCONSTANT {
                    /*%%%*/
                    if (p.getLexContext().in_def) {
                        p.yyerror("dynamic constant assignment");
                    }

                    Integer position = p.tokline();

                    $$ = new ConstDeclNode(position, (RubySymbol) null, p.new_colon3(position, $2), NilImplicitNode.NIL);
                    /*% %*/
                    /*% ripper: const_decl(p, top_const_field!($2)) %*/
                }
                | backref {
                    /*%%%*/
                    p.backrefAssignError($1);
                    /*% %*/
                    /*% ripper[error]: backref_error(p, RNODE($1), var_field(p, $1)) %*/
                }

cname           : tIDENTIFIER {
                    String message = "class/module name must be CONSTANT";
                    /*%%%*/
                    p.yyerror(message, @1);
                    /*% %*/
                    /*% ripper[error]: class_name_error!(ERR_MESG(), $1) %*/
                }
                | tCONSTANT {
                   $$ = $1;
                }

cpath           : tCOLON3 cname {
                    /*%%%*/
                    $$ = p.new_colon3(p.tokline(), $2);
                    /*% %*/
                    /*% ripper: top_const_ref!($2) %*/
                }
                | cname {
                    /*%%%*/
                    $$ = p.new_colon2(p.tokline(), null, $1);
                    /*% %*/
                    /*% ripper: const_ref!($1) %*/
                }
                | primary_value tCOLON2 cname {
                    /*%%%*/
                    $$ = p.new_colon2(@1.start(), $1, $3);
                    /*% %*/
                    /*% ripper: const_path_ref!($1, $3) %*/
                }

// ByteList:fname - A function name [!null]
fname          : tIDENTIFIER {
                   $$ = $1;
               }
               | tCONSTANT {
                   $$ = $1;
               }
               | tFID  {
                   $$ = $1;
               }
               | op {
                   p.setState(EXPR_ENDFN);
                   $$ = $1;
               }
               | reswords {
                   $$ = $1;
               }

// Node:fitem
fitem           : fname {  // LiteralNode
                    /*%%%*/
                    $$ =  new LiteralNode(p.src_line(), p.symbolID($1));
                    /*% %*/
                    /*% ripper: symbol_literal!($1) %*/

                }
                | symbol {  // SymbolNode/DSymbolNode
                    $$ = $1;
                }

undef_list      : fitem {
                    /*%%%*/
                    $$ = newUndef(@1.start(), $1);
                    /*% %*/
                    /*% ripper: rb_ary_new3(1, get_value($1)) %*/
                }
                | undef_list ',' {
                    p.setState(EXPR_FNAME|EXPR_FITEM);
                } fitem {
                    /*%%%*/
                    $$ = p.appendToBlock($1, newUndef(@1.start(), $4));
                    /*% %*/
                    /*% ripper: rb_ary_push($1, get_value($4)) %*/
                }

// ByteList:op
op               : '|' {
                     $$ = p.maybe_symbolize(OR);
                 }
                 | '^' {
                     $$ = p.maybe_symbolize(CARET);
                 }
                 | '&' {
                     $$ = p.maybe_symbolize(AMPERSAND);
                 }
                 | tCMP {
                     $$ = $1;
                 }
                 | tEQ {
                     $$ = $1;
                 }
                 | tEQQ {
                     $$ = $1;
                 }
                 | tMATCH {
                     $$ = $1;
                 }
                 | tNMATCH {
                     $$ = $1;
                 }
                 | '>' {
                     $$ = p.maybe_symbolize(GT);
                 }
                 | tGEQ {
                     $$ = $1;
                 }
                 | '<' {
                     $$ = p.maybe_symbolize(LT);
                 }
                 | tLEQ {
                     $$ = $1;
                 }
                 | tNEQ {
                     $$ = $1;
                 }
                 | tLSHFT {
                     $$ = $1;
                 }
                 | tRSHFT{
                     $$ = $1;
                 }
                 | '+' {
                     $$ = p.maybe_symbolize(PLUS);
                 }
                 | '-' {
                     $$ = p.maybe_symbolize(MINUS);
                 }
                 | '*' {
                     $$ = p.maybe_symbolize(STAR);
                 }
                 | tSTAR {
                     $$ = $1;
                 }
                 | '/' {
                     $$ = p.maybe_symbolize(SLASH);
                 }
                 | '%' {
                     $$ = p.maybe_symbolize(PERCENT);
                 }
                 | tPOW {
                     $$ = $1;
                 }
                 | tDSTAR {
                     $$ = $1;
                 }
                 | '!' {
                     $$ = p.maybe_symbolize(BANG);
                 }
                 | '~' {
                     $$ = p.maybe_symbolize(TILDE);
                 }
                 | tUPLUS {
                     $$ = $1;
                 }
                 | tUMINUS {
                     $$ = $1;
                 }
                 | tAREF {
                     $$ = $1;
                 }
                 | tASET {
                     $$ = $1;
                 }
                 | '`' {
                     $$ = p.maybe_symbolize(BACKTICK);
                 }
 
// ByteList: reswords
reswords        : keyword__LINE__ {
                    $$ = p.maybe_symbolize(Keyword.__LINE__.bytes);
                }
                | keyword__FILE__ {
                    $$ = p.maybe_symbolize(Keyword.__FILE__.bytes);
                }
                | keyword__ENCODING__ {
                    $$ = p.maybe_symbolize(Keyword.__ENCODING__.bytes);
                }
                | keyword_BEGIN {
                    $$ = p.maybe_symbolize(Keyword.LBEGIN.bytes);
                }
                | keyword_END {
                    $$ = p.maybe_symbolize(Keyword.LEND.bytes);
                }
                | keyword_alias {
                    $$ = p.maybe_symbolize(Keyword.ALIAS.bytes);
                }
                | keyword_and {
                    $$ = p.maybe_symbolize(Keyword.AND.bytes);
                }
                | keyword_begin {
                    $$ = p.maybe_symbolize(Keyword.BEGIN.bytes);
                }
                | keyword_break {
                    $$ = p.maybe_symbolize(Keyword.BREAK.bytes);
                }
                | keyword_case {
                    $$ = p.maybe_symbolize(Keyword.CASE.bytes);
                }
                | keyword_class {
                    $$ = p.maybe_symbolize(Keyword.CLASS.bytes);
                }
                | keyword_def {
                    $$ = p.maybe_symbolize(Keyword.DEF.bytes);
                }
                | keyword_defined {
                    $$ = p.maybe_symbolize(Keyword.DEFINED_P.bytes);
                }
                | keyword_do {
                    $$ = p.maybe_symbolize(Keyword.DO.bytes);
                }
                | keyword_else {
                    $$ = p.maybe_symbolize(Keyword.ELSE.bytes);
                }
                | keyword_elsif {
                    $$ = p.maybe_symbolize(Keyword.ELSIF.bytes);
                }
                | keyword_end {
                    $$ = p.maybe_symbolize(Keyword.END.bytes);
                }
                | keyword_ensure {
                    $$ = p.maybe_symbolize(Keyword.ENSURE.bytes);
                }
                | keyword_false {
                    $$ = p.maybe_symbolize(Keyword.FALSE.bytes);
                }
                | keyword_for {
                    $$ = p.maybe_symbolize(Keyword.FOR.bytes);
                }
                | keyword_in {
                    $$ = p.maybe_symbolize(Keyword.IN.bytes);
                }
                | keyword_module {
                    $$ = p.maybe_symbolize(Keyword.MODULE.bytes);
                }
                | keyword_next {
                    $$ = p.maybe_symbolize(Keyword.NEXT.bytes);
                }
                | keyword_nil {
                    $$ = p.maybe_symbolize(Keyword.NIL.bytes);
                }
                | keyword_not {
                    $$ = p.maybe_symbolize(Keyword.NOT.bytes);
                }
                | keyword_or {
                    $$ = p.maybe_symbolize(Keyword.OR.bytes);
                }
                | keyword_redo {
                    $$ = p.maybe_symbolize(Keyword.REDO.bytes);
                }
                | keyword_rescue {
                    $$ = p.maybe_symbolize(Keyword.RESCUE.bytes);
                }
                | keyword_retry {
                    $$ = p.maybe_symbolize(Keyword.RETRY.bytes);
                }
                | keyword_return {
                    $$ = p.maybe_symbolize(Keyword.RETURN.bytes);
                }
                | keyword_self {
                    $$ = p.maybe_symbolize(Keyword.SELF.bytes);
                }
                | keyword_super {
                    $$ = p.maybe_symbolize(Keyword.SUPER.bytes);
                }
                | keyword_then {
                    $$ = p.maybe_symbolize(Keyword.THEN.bytes);
                }
                | keyword_true {
                    $$ = p.maybe_symbolize(Keyword.TRUE.bytes);
                }
                | keyword_undef {
                    $$ = p.maybe_symbolize(Keyword.UNDEF.bytes);
                }
                | keyword_when {
                    $$ = p.maybe_symbolize(Keyword.WHEN.bytes);
                }
                | keyword_yield {
                    $$ = p.maybe_symbolize(Keyword.YIELD.bytes);
                }
                | keyword_if {
                    $$ = p.maybe_symbolize(Keyword.IF.bytes);
                }
                | keyword_unless {
                    $$ = p.maybe_symbolize(Keyword.UNLESS.bytes);
                }
                | keyword_while {
                    $$ = p.maybe_symbolize(Keyword.WHILE.bytes);
                }
                | keyword_until {
                    $$ = p.maybe_symbolize(Keyword.UNTIL.bytes);
                }

arg             : lhs '=' lex_ctxt arg_rhs {
                    /*%%%*/
                    $$ = node_assign($1, $4);
                    /*% %*/
                    /*% ripper: assign!($1, $4) %*/
                }
                | var_lhs tOP_ASGN lex_ctxt arg_rhs {
                    /*%%%*/
                    $$ = p.new_op_assign($1, $2, $4);
                    /*% %*/
                    /*% ripper: opassign!($1, $2, $4) %*/
                }
                | primary_value '[' opt_call_args rbracket tOP_ASGN lex_ctxt arg_rhs {
                    /*%%%*/
                    p.value_expr($7);
                    $$ = p.new_ary_op_assign($1, $5, $3, $7);
                    /*% %*/
                    /*% ripper: opassign!(aref_field!($1, escape_Qundef($3)), $5, $7) %*/
                }
                | primary_value call_op tIDENTIFIER tOP_ASGN lex_ctxt arg_rhs {
                    /*%%%*/
                    p.value_expr($6);
                    $$ = p.new_attr_op_assign($1, $2, $6, $3, $4);
                    /*% %*/
                    /*% ripper: opassign!(field!($1, $2, $3), $4, $6) %*/
                }
                | primary_value call_op tCONSTANT tOP_ASGN lex_ctxt arg_rhs {
                    /*%%%*/
                    p.value_expr($6);
                    $$ = p.new_attr_op_assign($1, $2, $6, $3, $4);
                    /*% %*/
                    /*% ripper: opassign!(field!($1, $2, $3), $4, $6) %*/
                }
                | primary_value tCOLON2 tIDENTIFIER tOP_ASGN lex_ctxt arg_rhs {
                    /*%%%*/
                    p.value_expr($6);
                    $$ = p.new_attr_op_assign($1, $2, $6, $3, $4);
                    /*% %*/
                    /*% ripper: opassign!(field!($1, ID2VAL(idCOLON2), $3), $4, $6) %*/
                }
                | primary_value tCOLON2 tCONSTANT tOP_ASGN lex_ctxt arg_rhs {
                    /*%%%*/
                    Integer pos = @1.start();
                    $$ = p.new_const_op_assign(pos, p.new_colon2(pos, $1, $3), $4, $6);
                    /*% %*/
                    /*% ripper: opassign!(const_path_field!($1, $3), $4, $6) %*/
                }
                | tCOLON3 tCONSTANT tOP_ASGN lex_ctxt arg_rhs {
                    /*%%%*/
                    Integer pos = p.src_line();
                    $$ = p.new_const_op_assign(pos, new Colon3Node(pos, p.symbolID($2)), $3, $5);
                    /*% %*/
                    /*% ripper: opassign!(top_const_field!($2), $3, $5) %*/
                }
                | backref tOP_ASGN lex_ctxt arg_rhs {
                    /*%%%*/
                    p.backrefAssignError($1);
                    /*% %*/
                    /*% ripper[error]: backref_error(p, RNODE($1), opassign!(var_field(p, $1), $2, $4)) %*/
                }
                | arg tDOT2 arg {
                    /*%%%*/
                    p.value_expr($1);
                    p.value_expr($3);
    
                    boolean isLiteral = $1 instanceof FixnumNode && $3 instanceof FixnumNode;
                    $$ = new DotNode(@1.start(), p.makeNullNil($1), p.makeNullNil($3), false, isLiteral);
                    /*% %*/
                    /*% ripper: dot2!($1, $3) %*/
                }
                | arg tDOT3 arg {
                    /*%%%*/
                    p.value_expr($1);
                    p.value_expr($3);

                    boolean isLiteral = $1 instanceof FixnumNode && $3 instanceof FixnumNode;
                    $$ = new DotNode(@1.start(), p.makeNullNil($1), p.makeNullNil($3), true, isLiteral);
                    /*% %*/
                    /*% ripper: dot3!($1, $3) %*/
                }
                | arg tDOT2 {
                    /*%%%*/
                    p.value_expr($1);

                    boolean isLiteral = $1 instanceof FixnumNode;
                    $$ = new DotNode(@1.start(), p.makeNullNil($1), NilImplicitNode.NIL, false, isLiteral);
                    /*% %*/
                    /*% ripper: dot2!($1, Qnil) %*/
                }
                | arg tDOT3 {
                    /*%%%*/
                    p.value_expr($1);

                    boolean isLiteral = $1 instanceof FixnumNode;
                    $$ = new DotNode(@1.start(), p.makeNullNil($1), NilImplicitNode.NIL, true, isLiteral);
                    /*% %*/
                    /*% ripper: dot3!($1, Qnil) %*/
                }
                | tBDOT2 arg {
                    /*%%%*/
                    p.value_expr($2);
                    boolean isLiteral = $2 instanceof FixnumNode;
                    $$ = new DotNode(@1.start(), NilImplicitNode.NIL, p.makeNullNil($2), false, isLiteral);
                    /*% %*/
                    /*% ripper: dot2!(Qnil, $2) %*/
                }
                | tBDOT3 arg {
                    /*%%%*/
                    p.value_expr($2);
                    boolean isLiteral = $2 instanceof FixnumNode;
                    $$ = new DotNode(@1.start(), NilImplicitNode.NIL, p.makeNullNil($2), true, isLiteral);
                    /*% %*/
                    /*% ripper: dot3!(Qnil, $2) %*/
                }
                | arg '+' arg {
                    $$ = p.call_bin_op($1, PLUS, $3, p.src_line());
                }
                | arg '-' arg {
                    $$ = p.call_bin_op($1, MINUS, $3, p.src_line());
                }
                | arg '*' arg {
                    $$ = p.call_bin_op($1, STAR, $3, p.src_line());
                }
                | arg '/' arg {
                    $$ = p.call_bin_op($1, SLASH, $3, p.src_line());
                }
                | arg '%' arg {
                    $$ = p.call_bin_op($1, PERCENT, $3, p.src_line());
                }
                | arg tPOW arg {
                    $$ = p.call_bin_op($1, STAR_STAR, $3, p.src_line());
                }
                | tUMINUS_NUM simple_numeric tPOW arg {
                    $$ = p.call_uni_op(p.call_bin_op($2, $3, $4, p.src_line()), $1);
                }
                | tUPLUS arg {
                    $$ = p.call_uni_op($2, PLUS_AT);
                }
                | tUMINUS arg {
                    $$ = p.call_uni_op($2, MINUS_AT);
                }
                | arg '|' arg {
                    $$ = p.call_bin_op($1, OR, $3, p.src_line());
                }
                | arg '^' arg {
                    $$ = p.call_bin_op($1, CARET, $3, p.src_line());
                }
                | arg '&' arg {
                    $$ = p.call_bin_op($1, AMPERSAND, $3, p.src_line());
                }
                | arg tCMP arg {
                    $$ = p.call_bin_op($1, LT_EQ_RT, $3, p.src_line());
                }
                | rel_expr   %prec tCMP {
                    $$ = $1;
                }
                | arg tEQ arg {
                    $$ = p.call_bin_op($1, EQ_EQ, $3, p.src_line());
                }
                | arg tEQQ arg {
                    $$ = p.call_bin_op($1, EQ_EQ_EQ, $3, p.src_line());
                }
                | arg tNEQ arg {
                    $$ = p.call_bin_op($1, BANG_EQ, $3, p.src_line());
                }
                | arg tMATCH arg {
                    $$ = p.match_op($1, $3);
                }
                | arg tNMATCH arg {
                    $$ = p.call_bin_op($1, BANG_TILDE, $3, p.src_line());
                }
                | '!' arg {
                    $$ = p.call_uni_op(p.method_cond($2), BANG);
                }
                | '~' arg {
                    $$ = p.call_uni_op($2, TILDE);
                }
                | arg tLSHFT arg {
                    $$ = p.call_bin_op($1, LT_LT, $3, p.src_line());
                }
                | arg tRSHFT arg {
                    $$ = p.call_bin_op($1, GT_GT, $3, p.src_line());
                }
                | arg tANDOP arg {
                    $$ = p.logop($1, AMPERSAND_AMPERSAND, $3);
                }
                | arg tOROP arg {
                    $$ = p.logop($1, OR_OR, $3);
                }
                | keyword_defined opt_nl {
                    p.getLexContext().in_defined = true;
                } arg {
                    p.getLexContext().in_defined = false;                    
                    $$ = p.new_defined(@1.start(), $4);
                }
                | arg '?' arg opt_nl ':' arg {
                    /*%%%*/
                    p.value_expr($1);
                    $$ = p.new_if(@1.start(), $1, $3, $6);
                    /*% %*/
                    /*% ripper: ifop!($1, $3, $6) %*/
                }
                | defn_head f_opt_paren_args '=' arg {
                    p.endless_method_name($1);
                    p.restore_defun($1);
                    /*%%%*/
                    $$ = new DefnNode($1.line, $1.name, $2, p.getCurrentScope(), p.reduce_nodes(p.remove_begin($4)), @4.end());
                    if (p.isNextBreak) $<DefnNode>$.setContainsNextBreak();
                    p.popCurrentScope();
                    // Changed from MRI (combined two stmts)
                    /*% %*/
                    /*% ripper: def!(get_value($1), $2, bodystmt!($4, Qnil, Qnil, Qnil)) %*/
		}
                | defn_head f_opt_paren_args '=' arg modifier_rescue arg {
                    p.endless_method_name($1);
                    p.restore_defun($1);
                    /*%%%*/
                    Node body = p.reduce_nodes(p.remove_begin(p.rescued_expr(@1.start(), $4, $6)));
                    $$ = new DefnNode($1.line, $1.name, $2, p.getCurrentScope(), body, @6.end());
                    if (p.isNextBreak) $<DefnNode>$.setContainsNextBreak();
                    p.popCurrentScope();
                    // Changed from MRI (combined two stmts)
                    /*% %*/
                    /*% ripper: def!(get_value($1), $2, bodystmt!(rescue_mod!($4, $6), Qnil, Qnil, Qnil)) %*/
		}
                | defs_head f_opt_paren_args '=' arg {
                    p.endless_method_name($1);
                    p.restore_defun($1);
                    /*%%%*/
                    $$ = new DefsNode($1.line, (Node) $1.singleton, $1.name, $2, p.getCurrentScope(), p.reduce_nodes(p.remove_begin($4)), @4.end());
                    if (p.isNextBreak) $<DefsNode>$.setContainsNextBreak();
                    p.popCurrentScope();
                    /*% %*/
                    /*% ripper: defs!(AREF($1, 0), AREF($1, 1), AREF($1, 2), $2, bodystmt!($4, Qnil, Qnil, Qnil)) %*/
		}
                | defs_head f_opt_paren_args '=' arg modifier_rescue arg {
                    /*%%%*/
                    p.endless_method_name($1);
                    p.restore_defun($1);
                    Node body = p.reduce_nodes(p.remove_begin(p.rescued_expr(@1.start(), $4, $6)));
                    $$ = new DefsNode($1.line, (Node) $1.singleton, $1.name, $2, p.getCurrentScope(), body, @6.end());
                    if (p.isNextBreak) $<DefsNode>$.setContainsNextBreak();
                    p.popCurrentScope();
                    /*% %*/
                    /*% ripper: defs!(AREF($1, 0), AREF($1, 1), AREF($1, 2), $2, bodystmt!(rescue_mod!($4, $6), Qnil, Qnil, Qnil)) %*/
                }
                | primary {
                    $$ = $1;
                }
 
relop           : '>' {
                    $$ = p.maybe_symbolize(GT);
                }
                | '<' {
                    $$ = p.maybe_symbolize(LT);
                }
                | tGEQ {
                    $$ = $1;
                }
                | tLEQ {
                    $$ = $1;
                }

rel_expr        : arg relop arg   %prec '>' {
                    $$ = p.call_bin_op($1, $2, $3, p.src_line());
                }
		| rel_expr relop arg   %prec '>' {
                    p.warning(p.src_line(), "comparison '" + $2 + "' after comparison");
                    $$ = p.call_bin_op($1, $2, $3, p.src_line());
                }

lex_ctxt        : tSP {
                    $$ = (LexContext) p.getLexContext().clone();
                }
                | none {
                    $$ = (LexContext) p.getLexContext().clone();
                }
 
arg_value       : arg {
                    p.value_expr($1);
                    $$ = p.makeNullNil($1);
                }

aref_args       : none
                | args trailer {
                    $$ = $1;
                }
                | args ',' assocs trailer {
                    /*%%%*/
                    $$ = p.arg_append($1, p.remove_duplicate_keys($3));
                    /*% %*/
                    /*% ripper: args_add!($1, bare_assoc_hash!($3)) %*/
                }
                | assocs trailer {
                    /*%%%*/
                    $$ = p.newArrayNode(@1.start(), p.remove_duplicate_keys($1));
                    /*% %*/
                    /*% ripper: args_add!(args_new!, bare_assoc_hash!($1)) %*/
                }

arg_rhs         : arg %prec tOP_ASGN {
                    p.value_expr($1);
                    $$ = $1;
                }
                | arg modifier_rescue arg {
                    /*%%%*/
                    p.value_expr($1);
                    $$ = p.newRescueModNode($1, $3);
                    /*% %*/
                    /*% ripper: rescue_mod!($1, $3) %*/
                }

paren_args      : '(' opt_call_args rparen {
                    /*%%%*/
                    $$ = $2;
                    /*% %*/
                    /*% ripper: arg_paren!(escape_Qundef($2)) %*/
                }
                | '(' args ',' args_forward rparen {
                    if (!p.check_forwarding_args()) {
                        $$ = null;
                    } else {
                    /*%%%*/
                        $$ = p.new_args_forward_call(@1.start(), $2);
                    /*% %*/
                    /*% ripper: arg_paren!(args_add!($2, $4)) %*/
                    }
               }
               | '(' args_forward rparen {
                    if (!p.check_forwarding_args()) {
                        $$ = null;
                    } else {
                    /*%%%*/
                        $$ = p.new_args_forward_call(@1.start(), null);
                    /*% %*/
                    /*% ripper: arg_paren!($2) %*/
                    }
               }
 
opt_paren_args  : none | paren_args

opt_call_args   : none
                | call_args
                | args ',' {
                    $$ = $1;
                }
                | args ',' assocs ',' {
                    /*%%%*/
                    $$ = p.arg_append($1, p.remove_duplicate_keys($3));
                    /*% %*/
                    /*% ripper: args_add!($1, bare_assoc_hash!($3)) %*/
                }
                | assocs ',' {
                    /*%%%*/
                    $$ = p.newArrayNode(@1.start(), p.remove_duplicate_keys($1));
                    /*% %*/
                    /*% ripper: args_add!(args_new!, bare_assoc_hash!($1)) %*/
                }
   

// [!null] - ArgsCatNode, SplatNode, ArrayNode, HashNode, BlockPassNode
call_args       : command {
                    /*%%%*/
                    p.value_expr($1);
                    $$ = p.newArrayNode(@1.start(), $1);
                    /*% %*/
                    /*% ripper: args_add!(args_new!, $1) %*/
                }
                | args opt_block_arg {
                    /*%%%*/
                    $$ = arg_blk_pass($1, $2);
                    /*% %*/
                    /*% ripper: args_add_block!($1, $2) %*/
                }
                | assocs opt_block_arg {
                    /*%%%*/
                    $$ = p.newArrayNode(@1.start(), p.remove_duplicate_keys($1));
                    $$ = arg_blk_pass($<Node>$, $2);
                    /*% %*/
                    /*% ripper: args_add_block!(args_add!(args_new!, bare_assoc_hash!($1)), $2) %*/
                }
                | args ',' assocs opt_block_arg {
                    /*%%%*/
                    $$ = p.arg_append($1, p.remove_duplicate_keys($3));
                    $$ = arg_blk_pass($<Node>$, $4);
                    /*% %*/
                    /*% ripper: args_add_block!(args_add!($1, bare_assoc_hash!($3)), $4) %*/
                }
                | block_arg {
                    /*% ripper[brace]: args_add_block!(args_new!, $1) %*/
                }

// [!null] - ArgsCatNode, SplatNode, ArrayNode, HashNode, BlockPassNode
command_args    :  {
                    boolean lookahead = false;
                    switch (yychar) {
                    case '(': case tLPAREN: case tLPAREN_ARG: case '[': case tLBRACK:
                       lookahead = true;
                    }
                    StackState cmdarg = p.getCmdArgumentState();
                    if (lookahead) cmdarg.pop();
                    cmdarg.push1();
                    if (lookahead) cmdarg.push0();
                } call_args {
                    StackState cmdarg = p.getCmdArgumentState();
                    boolean lookahead = false;
                    switch (yychar) {
                    case tLBRACE_ARG:
                       lookahead = true;
                    }
                      
                    if (lookahead) cmdarg.pop();
                    cmdarg.pop();
                    if (lookahead) cmdarg.push0();
                    $$ = $2;
                }

block_arg       : tAMPER arg_value {
                    /*%%%*/
                    $$ = new BlockPassNode(@2.start(), $2);
                    /*% %*/
                    /*% ripper: $2 %*/
                }
                | tAMPER {
                    /*%%%*/
                    if (!p.local_id(FWD_BLOCK)) p.compile_error("no anonymous block parameter");
                    $$ = new BlockPassNode(p.tokline(), p.arg_var(FWD_BLOCK));
                    // Changed from MRI
                    /*%
                    $$ = p.nil();
                    %*/
                }
 

opt_block_arg   : ',' block_arg {
                    $$ = $2;
                }
                | none_block_pass

// [!null]
args            : arg_value { // ArrayNode
                    /*%%%*/
                    int line = $1 instanceof NilImplicitNode ? p.src_line() : @1.start();
                    $$ = p.newArrayNode(line, $1);
                    /*% %*/
                    /*% ripper: args_add!(args_new!, $1) %*/
                }
                | tSTAR arg_value { // SplatNode
                    /*%%%*/
                    $$ = p.newSplatNode($2);
                    /*% %*/
                    /*% ripper: args_add_star!(args_new!, $2) %*/
                }
                | args ',' arg_value { // ArgsCatNode, SplatNode, ArrayNode
                    /*%%%*/
                    Node node = p.splat_array($1);

                    if (node != null) {
                        $$ = p.list_append(node, $3);
                    } else {
                        $$ = p.arg_append($1, $3);
                    }
                    /*% %*/
                    /*% ripper: args_add!($1, $3) %*/
                }
                | args ',' tSTAR arg_value { // ArgsCatNode, SplatNode, ArrayNode
                    /*%%%*/
                    Node node = null;

                    // FIXME: lose syntactical elements here (and others like this)
                    if ($4 instanceof ArrayNode &&
                        (node = p.splat_array($1)) != null) {
                        $$ = p.list_concat(node, $4);
                    } else {
                        $$ = arg_concat($1, $4);
                    }
                    /*% %*/
                    /*% ripper: args_add_star!($1, $4) %*/
                }

mrhs_arg	: mrhs {
                    $$ = $1;
                }
		| arg_value {
                    $$ = $1;
                }


mrhs            : args ',' arg_value {
                    /*%%%*/

                    Node node = p.splat_array($1);

                    if (node != null) {
                        $$ = p.list_append(node, $3);
                    } else {
                        $$ = p.arg_append($1, $3);
                    }
                    /*% %*/
                    /*% ripper: mrhs_add!(mrhs_new_from_args!($1), $3) %*/
                }
                | args ',' tSTAR arg_value {
                    /*%%%*/
                    Node node = null;

                    if ($4 instanceof ArrayNode &&
                        (node = p.splat_array($1)) != null) {
                        $$ = p.list_concat(node, $4);
                    } else {
                        $$ = arg_concat($1, $4);
                    }
                    /*% %*/
                    /*% ripper: mrhs_add_star!(mrhs_new_from_args!($1), $4) %*/
                }
                | tSTAR arg_value {
                    /*%%%*/
                    $$ = p.newSplatNode($2);
                    /*% %*/
                    /*% ripper: mrhs_add_star!(mrhs_new!, $2) %*/
                }

primary         : literal
                | strings
                | xstring
                | regexp
                | words { 
                     $$ = $1; // FIXME: Why complaining without $$ = $1;
                }
                | qwords { 
                     $$ = $1; // FIXME: Why complaining without $$ = $1;
                }
                | symbols { 
                     $$ = $1; // FIXME: Why complaining without $$ = $1;
                }
                | qsymbols {
                     $$ = $1; // FIXME: Why complaining without $$ = $1;
                }
                | var_ref 
                | backref
                | tFID {
                    /*%%%*/
                    $$ = p.new_fcall($1);
                    /*% %*/
                    /*% ripper: method_add_arg!(fcall!($1), args_new!) %*/
                }
                | k_begin {
                    p.getCmdArgumentState().push0();
                } bodystmt k_end {
                    p.getCmdArgumentState().pop();
                    /*%%%*/
                    $$ = new BeginNode($1, p.makeNullNil($3));
                    /*% %*/
                    /*% ripper: begin!($3) %*/
                }
                | tLPAREN_ARG {
                    p.setState(EXPR_ENDARG);
                } rparen {
                    /*%%%*/
                    $$ = null; //FIXME: Should be implicit nil?
                    /*% %*/
                    /*% ripper: paren!(0) %*/
                }
                | tLPAREN_ARG stmt {
                    p.setState(EXPR_ENDARG); 
                } rparen {
                    /*%%%*/
                    $$ = $2;
                    /*% %*/
                    /*% ripper: paren!($2) %*/
                }
                | tLPAREN compstmt ')' {
                    /*%%%*/
                    if ($2 != null) {
                        // compstmt position includes both parens around it
                        $<Node>2.setLine($1);
                        $$ = $2;
                    } else {
                        $$ = new NilNode($1);
                    }
                    /*% %*/
                    /*% ripper: paren!($2) %*/
                }
                | primary_value tCOLON2 tCONSTANT {
                    /*%%%*/
                    $$ = p.new_colon2(@1.start(), $1, $3);
                    /*% %*/
                    /*% ripper: const_path_ref!($1, $3) %*/
                }
                | tCOLON3 tCONSTANT {
                    /*%%%*/
                    $$ = p.new_colon3(p.tokline(), $2);
                    /*% %*/
                    /*% ripper: top_const_ref!($2) %*/
                }
                | tLBRACK aref_args ']' {
                    /*%%%*/
                    Integer position = @2.start();
                    if ($2 == null) {
                        $$ = new ZArrayNode(position); /* zero length array */
                    } else {
                        $$ = $2;
                    }
                    /*% %*/
                    /*% ripper: array!(escape_Qundef($2)) %*/
                }
                | tLBRACE assoc_list '}' {
                    /*%%%*/
                    $$ = $2;
                    $<HashNode>$.setIsLiteral();
                    /*% %*/
                    /*% ripper: hash!(escape_Qundef($2)) %*/
                }
                | k_return {
                    /*%%%*/
                    $$ = new ReturnNode($1, NilImplicitNode.NIL);
                    /*% %*/
                    /*% ripper: return0! %*/
                }
                | keyword_yield '(' call_args rparen {
                    /*%%%*/
                    $$ = p.new_yield($1, $3);
                    /*% %*/
                    /*% ripper: yield!(paren!($3)) %*/
                }
                | keyword_yield '(' rparen {
                    /*%%%*/
                    $$ = new YieldNode($1, null);
                    /*% %*/
                    /*% ripper: yield!(paren!(args_new!)) %*/
                }
                | keyword_yield {
                    /*%%%*/
                    $$ = new YieldNode($1, null);
                    /*% %*/
                    /*% ripper: yield0! %*/
                }
                | keyword_defined opt_nl '(' {
                    p.getLexContext().in_defined = true;
                } expr rparen {
                    p.getLexContext().in_defined = false;
                    $$ = p.new_defined(@1.start, $5);
                }
                | keyword_not '(' expr rparen {
                    $$ = p.call_uni_op(p.method_cond($3), BANG);
                }
                | keyword_not '(' rparen {
                    $$ = p.call_uni_op(p.method_cond(p.nil()), BANG);
                }
                | fcall brace_block {
                    /*%%%*/
                    p.frobnicate_fcall_args($1, null, $2);
                    $$ = $1;                    
                    /*% %*/
                    /*% ripper: method_add_block!(method_add_arg!(fcall!($1), args_new!), $2) %*/
                }
                | method_call
                | method_call brace_block {
                    /*%%%*/
                    if ($1 != null && 
                          $<BlockAcceptingNode>1.getIterNode() instanceof BlockPassNode) {
                          p.compile_error("Both block arg and actual block given.");
                    }
                    $$ = $<BlockAcceptingNode>1.setIterNode($2);
                    $<Node>$.setLine(@1.start());
                    /*% %*/
                    /*% ripper: method_add_block!($1, $2) %*/
                }
                | lambda {
                    $$ = $1;
                }
                | k_if expr_value then compstmt if_tail k_end {
                    /*%%%*/
                    $$ = p.new_if($1, $2, $4, $5);
                    /*% %*/
                    /*% ripper: if!($2, $4, escape_Qundef($5)) %*/
                }
                | k_unless expr_value then compstmt opt_else k_end {
                    /*%%%*/
                    $$ = p.new_if($1, $2, $5, $4);
                    /*% %*/
                    /*% ripper: unless!($2, $4, escape_Qundef($5)) %*/
                }
                | k_while expr_value_do compstmt k_end {
                    /*%%%*/
                    $$ = new WhileNode($1, p.cond($2), p.makeNullNil($3));
                    /*% %*/
                    /*% ripper: while!($2, $3) %*/
                }
                | k_until expr_value_do compstmt k_end {
                    /*%%%*/
                    $$ = new UntilNode($1, p.cond($2), p.makeNullNil($3));
                    /*% %*/
                    /*% ripper: until!($2, $3) %*/
                }
                | k_case expr_value opt_terms {
                    $$ = p.case_labels;
                    p.case_labels = p.getRuntime().getNil();
                } case_body k_end {
                    /*%%%*/
                    $$ = p.newCaseNode($1, $2, $5);
                    p.fixpos($<Node>$, $2);
                    /*% %*/
                    /*% ripper: case!($2, $5) %*/
                }
                | k_case opt_terms {
                    $$ = p.case_labels;
                    p.case_labels = null;
                } case_body k_end {
                    /*%%%*/
                    $$ = p.newCaseNode($1, null, $4);
                    /*% %*/
                    /*% ripper: case!(Qnil, $4) %*/
                }
		| k_case expr_value opt_terms p_case_body k_end {
                    /*%%%*/
                    $$ = p.newPatternCaseNode($1, $2, $4);
                    /*% %*/
                    /*% ripper: case!($2, $4) %*/
                }
                | k_for for_var keyword_in expr_value_do compstmt k_end {
                    /*%%%*/
                    $$ = new ForNode($1, $2, $5, $4, p.getCurrentScope(), 111);
                    /*% %*/
                    /*% ripper: for!($2, $4, $5) %*/
                }
                | k_class cpath superclass {
                    LexContext ctxt = p.getLexContext();
                    if (ctxt.in_def) {
                        p.yyerror("class definition in method body");
                    }
                    ctxt.in_class = true;
                    p.pushLocalScope();
                } bodystmt k_end {
                    /*%%%*/
                    Node body = p.makeNullNil($5);

                    $$ = new ClassNode(@1.start(), $<Colon3Node>2, p.getCurrentScope(), body, $3, p.src_line());
                    /*% %*/
                    /*% ripper: class!($2, $3, $5) %*/
                    LexContext ctxt = p.getLexContext();
                    p.popCurrentScope();
                    ctxt.in_class = $1.in_class;
                    ctxt.shareable_constant_value = $1.shareable_constant_value;
                }
                | k_class tLSHFT expr {
                    LexContext ctxt = p.getLexContext();
                    ctxt.in_def = false;
                    ctxt.in_class = false;
                    p.pushLocalScope();
                } term bodystmt k_end {
                    /*%%%*/
                    Node body = p.makeNullNil($6);

                    $$ = new SClassNode(@1.start(), $3, p.getCurrentScope(), body, p.src_line());
                    /*% %*/
                    /*% ripper: sclass!($3, $6) %*/
                    LexContext ctxt = p.getLexContext();
                    ctxt.in_def = $1.in_def;
                    ctxt.in_class = $1.in_class;
                    ctxt.shareable_constant_value = $1.shareable_constant_value;
                    p.popCurrentScope();
                }
                | k_module cpath {
                    LexContext ctxt = p.getLexContext();
                    if (ctxt.in_def) { 
                        p.yyerror("module definition in method body");
                    }
                    ctxt.in_class = true;
                    p.pushLocalScope();
                } bodystmt k_end {
                    /*%%%*/
                    Node body = p.makeNullNil($4);

                    $$ = new ModuleNode(@1.start(), $<Colon3Node>2, p.getCurrentScope(), body, p.src_line());
                    /*% %*/
                    /*% ripper: module!($2, $4) %*/
                    p.popCurrentScope();
                    LexContext ctxt = p.getLexContext();
                    ctxt.in_class = $1.in_class;
                    ctxt.shareable_constant_value = $1.shareable_constant_value;
                }
                | defn_head f_arglist bodystmt k_end {
                    /*%%%*/
                    p.restore_defun($1);
                    Node body = p.reduce_nodes(p.remove_begin(p.makeNullNil($3)));
                    $$ = new DefnNode($1.line, $1.name, $2, p.getCurrentScope(), body, @4.end());
                    if (p.isNextBreak) $<DefnNode>$.setContainsNextBreak();
                    p.popCurrentScope();
                    /*% %*/
                    /*% ripper: def!(get_value($1), $2, $3) %*/
                }
                | defs_head f_arglist bodystmt k_end {
                    /*%%%*/
                    p.restore_defun($1);
                    Node body = p.reduce_nodes(p.remove_begin(p.makeNullNil($3)));
                    $$ = new DefsNode($1.line, (Node) $1.singleton, $1.name, $2, p.getCurrentScope(), body, @4.end());
                    if (p.isNextBreak) $<DefsNode>$.setContainsNextBreak();
                    p.popCurrentScope();
                    // Changed from MRI (no more get_value)
                    /*% %*/                    
                    /*% ripper: defs!(AREF($1, 0), AREF($1, 1), AREF($1, 2), $2, $3) %*/
                }
                | keyword_break {
                    /*%%%*/
                    p.isNextBreak = true;
                    $$ = new BreakNode($1, NilImplicitNode.NIL);
                    /*% %*/
                    /*% ripper: break!(args_new!) %*/
                }
                | keyword_next {
                    /*%%%*/
                    p.isNextBreak = true;
                    $$ = new NextNode($1, NilImplicitNode.NIL);
                    /*% %*/
                    /*% ripper: next!(args_new!) %*/
                }
                | keyword_redo {
                    /*%%%*/
                    $$ = new RedoNode($1);
                    /*% %*/
                    /*% ripper: redo! %*/
                }
                | keyword_retry {
                    /*%%%*/
                    $$ = new RetryNode($1);
                    /*% %*/
                    /*% ripper: retry! %*/
                }

primary_value   : primary {
                    p.value_expr($1);
                    $$ = $1;
                    if ($$ == null) $$ = p.nil();
                }

// FIXME: token_info_push
k_begin         : keyword_begin {
                    $$ = $1;
                }

k_if            : keyword_if {
                    $$ = $1;
                }

k_unless        : keyword_unless {
                    $$ = $1;
                }
 
k_while         : keyword_while {
                    $$ = $1;
                }
 
k_until         : keyword_until {
                    $$ = $1;
                }
 
k_case          : keyword_case {
                    $$ = $1;
                }
 
k_for           : keyword_for {
                    $$ = $1;
                }
 
k_class         : keyword_class {
                    $$ = (LexContext) p.getLexContext().clone();
                }

k_module        : keyword_module {
                    $$ = (LexContext) p.getLexContext().clone();  
                }

k_def           : keyword_def {
                    $$ = $1;
                    p.getLexContext().in_argdef = true;
                }

k_do            : keyword_do {
                    $$ = $1;
                }

k_do_block      : keyword_do_block {
                    $$ = $1;
                }

k_rescue        : keyword_rescue {
                    $$ = $1;
                }

k_ensure        : keyword_ensure {
                    $$ = $1;
                }
 
k_when          : keyword_when {
                    $$ = $1;
                }

k_else          : keyword_else {
                    $$ = $1;
                }

k_elsif         : keyword_elsif {
                    $$ = $1;
                }
 
k_end           : keyword_end {
                    $$ = $1;
                }

k_return        : keyword_return {
                    LexContext ctxt = p.getLexContext();
                    if (ctxt.in_class && !ctxt.in_def && !p.getCurrentScope().isBlockScope()) {
                        p.compile_error("Invalid return in class/module body");
                    }
                    $$ = $1;
                }

then            : term
                | keyword_then
                | term keyword_then

do              : term
                | keyword_do_cond

if_tail         : opt_else
                | k_elsif expr_value then compstmt if_tail {
                    /*%%%*/
                    $$ = p.new_if($1, $2, $4, $5);
                    /*% %*/
                    /*% ripper: elsif!($2, $4, escape_Qundef($5)) %*/
                }

opt_else        : none
                | k_else compstmt {
                    /*%%%*/
                    $$ = $2 == null ? NilImplicitNode.NIL : $2;
                    /*% %*/
                    /*% ripper: else!($2) %*/
                }

// [!null]
for_var         : lhs
                | mlhs {
                }

f_marg          : f_norm_arg {
                    /*%%%*/
                    $$ = p.assignableInCurr($1, NilImplicitNode.NIL);
                    /*%
                      $$ = p.assignable(@1.id, $1);
                    %*/
                }
                | tLPAREN f_margs rparen {
                    /*%%%*/
                    $$ = $2;
                    /*% %*/
                    /*% ripper: mlhs_paren!($2) %*/
                }

// [!null]
f_marg_list     : f_marg {
                    /*%%%*/
                    $$ = p.newArrayNode(@1.start(), $1);
                    /*% %*/
                    /*% ripper: mlhs_add!(mlhs_new!, $1) %*/
                }
                | f_marg_list ',' f_marg {
                    /*%%%*/
                    $$ = $1.add($3);
                    /*% %*/
                    /*% ripper: mlhs_add!($1, $3) %*/
                }

f_margs         : f_marg_list {
                    /*%%%*/
                    $$ = new MultipleAsgnNode(@1.start(), $1, null, null);
                    /*% %*/
                    /*% ripper: $1 %*/
                }
                | f_marg_list ',' f_rest_marg {
                    /*%%%*/
                    $$ = new MultipleAsgnNode(@1.start(), $1, $3, null);
                    /*% %*/
                    /*% ripper: mlhs_add_star!($1, $3) %*/
                }
                | f_marg_list ',' f_rest_marg ',' f_marg_list {
                    /*%%%*/
                    $$ = new MultipleAsgnNode(@1.start(), $1, $3, $5);
                    /*% %*/
                    /*% ripper: mlhs_add_post!(mlhs_add_star!($1, $3), $5) %*/
                }
                | f_rest_marg {
                    /*%%%*/
                    $$ = new MultipleAsgnNode(p.src_line(), null, $1, null);
                    /*% %*/
                    /*% ripper: mlhs_add_star!(mlhs_new!, $1) %*/
                }
                | f_rest_marg ',' f_marg_list {
                    /*%%%*/
                    $$ = new MultipleAsgnNode(p.src_line(), null, $1, $3);
                    /*% %*/
                    /*% ripper: mlhs_add_post!(mlhs_add_star!(mlhs_new!, $1), $3) %*/
                }

f_rest_marg     : tSTAR f_norm_arg {
                    ByteList id = @2.id;
                    /*%%%*/
                    $$ = p.assignableInCurr(id, null);
                    /*%
                      $$ = p.assignable(id, $2);
                    %*/
                }
                | tSTAR {
                    /*%%%*/
                    $$ = new StarNode(p.src_line());
                    /*% %*/
                    /*% ripper: Qnil %*/
                }

f_any_kwrest    : f_kwrest
                | f_no_kwarg {
                     $$ = p.maybe_symbolize(LexingCommon.NIL);
                }

f_eq            : {
                    p.getLexContext().in_argdef = false;
                } '='

 
block_args_tail : f_block_kwarg ',' f_kwrest opt_f_block_arg {
                    $$ = p.new_args_tail(@1.start(), $1, $3, $4);
                }
                | f_block_kwarg opt_f_block_arg {
                    $$ = p.new_args_tail(@1.start(), $1, (ByteList) null, $2);
                }
                | f_any_kwrest opt_f_block_arg {
                    $$ = p.new_args_tail(p.src_line(), null, $1, $2);
                }
                | f_block_arg {
                    $$ = p.new_args_tail(@1.start(), null, (ByteList) null, $1);
                }

opt_block_args_tail : ',' block_args_tail {
                    $$ = $2;
                }
                | {
                    $$ = p.new_args_tail(p.src_line(), null, (ByteList) null, (ByteList) null);
                }

excessed_comma  : ',' { // no need for this other than to look similar to MRI. 
                    /*%%%*/
                    $$ = new UnnamedRestArgNode(@1.start(), null, p.getCurrentScope().addVariable("*"));
                    /*% %*/
                    /*% ripper: excessed_comma! %*/
                }

// [!null]
block_param     : f_arg ',' f_block_optarg ',' f_rest_arg opt_block_args_tail {
                    $$ = p.new_args(@1.start(), $1, $3, $5, null, $6);
                }
                | f_arg ',' f_block_optarg ',' f_rest_arg ',' f_arg opt_block_args_tail {
                    $$ = p.new_args(@1.start(), $1, $3, $5, $7, $8);
                }
                | f_arg ',' f_block_optarg opt_block_args_tail {
                    $$ = p.new_args(@1.start(), $1, $3, null, null, $4);
                }
                | f_arg ',' f_block_optarg ',' f_arg opt_block_args_tail {
                    $$ = p.new_args(@1.start(), $1, $3, null, $5, $6);
                }
                | f_arg ',' f_rest_arg opt_block_args_tail {
                    $$ = p.new_args(@1.start(), $1, null, $3, null, $4);
                }
                | f_arg excessed_comma {
                    $$ = p.new_args(@1.start(), $1, null, $2, null, (ArgsTailHolder) null);
                }
                | f_arg ',' f_rest_arg ',' f_arg opt_block_args_tail {
                    $$ = p.new_args(@1.start(), $1, null, $3, $5, $6);
                }
                | f_arg opt_block_args_tail {
                    $$ = p.new_args(@1.start(), $1, null, null, null, $2);
                }
                | f_block_optarg ',' f_rest_arg opt_block_args_tail {
                    $$ = p.new_args(@1.start(), null, $1, $3, null, $4);
                }
                | f_block_optarg ',' f_rest_arg ',' f_arg opt_block_args_tail {
                    $$ = p.new_args(@1.start(), null, $1, $3, $5, $6);
                }
                | f_block_optarg opt_block_args_tail {
                    $$ = p.new_args(@1.start(), null, $1, null, null, $2);
                }
                | f_block_optarg ',' f_arg opt_block_args_tail {
                    $$ = p.new_args(@1.start(), null, $1, null, $3, $4);
                }
                | f_rest_arg opt_block_args_tail {
                    $$ = p.new_args(@1.start(), null, null, $1, null, $2);
                }
                | f_rest_arg ',' f_arg opt_block_args_tail {
                    $$ = p.new_args(@1.start(), null, null, $1, $3, $4);
                }
                | block_args_tail {
                    $$ = p.new_args(@1.start(), null, null, null, null, $1);
                }

opt_block_param : none {
                    $$ = p.new_args(p.src_line(), null, null, null, null, (ArgsTailHolder) null);
                }
                | block_param_def {
                    p.setCommandStart(true);
                    $$ = $1;
                }

block_param_def : '|' opt_bv_decl '|' {
                    p.setCurrentArg(null);
                    p.ordinalMaxNumParam();
                    p.getLexContext().in_argdef = false;
                    /*%%%*/
                    $$ = p.new_args(p.src_line(), null, null, null, null, (ArgsTailHolder) null);
                    /*% %*/
                    /*% ripper: block_var!(params!(Qnil,Qnil,Qnil,Qnil,Qnil,Qnil,Qnil), escape_Qundef($2)) %*/
                }
                | '|' block_param opt_bv_decl '|' {
                    p.setCurrentArg(null);
                    p.ordinalMaxNumParam();
                    p.getLexContext().in_argdef = false;
                    /*%%%*/
                    $$ = $2;
                    /*% %*/
                    /*% ripper: block_var!(escape_Qundef($2), escape_Qundef($3)) %*/
                }

// shadowed block variables....
opt_bv_decl     : opt_nl {
                    $$ = null;
                }
                | opt_nl ';' bv_decls opt_nl {
                    /*%%%*/
                    $$ = null;
                    /*% %*/
                    /*% ripper: $3 %*/
                }

// ENEBO: This is confusing...
bv_decls        : bvar {
                    $$ = null;
                    /*% ripper[brace]: rb_ary_new3(1, get_value($1)) %*/
                }
                | bv_decls ',' bvar {
                    $$ = null;
                    /*% ripper[brace]: rb_ary_push($1, get_value($3)) %*/
                }

bvar            : tIDENTIFIER {
                    p.new_bv(@1.id);
                    /*% ripper: get_value($1) %*/
                }
                | f_bad_arg {
                    $$ = null;
                }

lambda          : tLAMBDA {
                    p.pushBlockScope();
                    $$ = p.getLeftParenBegin();
                    p.setLeftParenBegin(p.getParenNest());
                } {
                    $$ = p.resetMaxNumParam();
                } {
                    $$ = p.numparam_push();
                } f_larglist {
                    p.getCmdArgumentState().push0();
                } lambda_body {
                    int max_numparam = p.restoreMaxNumParam($<Integer>3);
                    p.getCmdArgumentState().pop();
                    // Changed from MRI args_with_numbered put into parser codepath and not used by ripper (since it is just a passthrough method and types do not match).
                    /*%%%*/
                    ArgsNode args = p.args_with_numbered($5, max_numparam);
                    $$ = new LambdaNode(@1.start(), args, $7, p.getCurrentScope(), p.src_line());
                    /*% %*/
                    /*% ripper: lambda!($5, $7) %*/
                    p.setLeftParenBegin($<Integer>2);
                    p.numparam_pop($<Node>4);
                    p.popCurrentScope();
                }

f_larglist      : '(' f_args opt_bv_decl ')' {
                    p.getLexContext().in_argdef = false;
                    /*%%%*/
                    $$ = $2;
                    p.ordinalMaxNumParam();
                    /*% %*/
                    /*% ripper: paren!($2) %*/
                }
                | f_args {
                    p.getLexContext().in_argdef = false;
                    /*%%%*/
                    if (!p.isArgsInfoEmpty($1)) {
                        p.ordinalMaxNumParam();
                    }
                    /*% %*/
                    $$ = $1;
                }

lambda_body     : tLAMBEG compstmt '}' {
                    $$ = $2;
                }
                | keyword_do_LAMBDA bodystmt k_end {
                    $$ = $2;
                }

do_block        : k_do_block do_body k_end {
                    $$ = $2;
                    /*%%%*/
                    /*% %*/
                }

  // JRUBY-2326 and GH #305 both end up hitting this production whereas in
  // MRI these do not.  I have never isolated the cause but I can work around
  // the individual reported problems with a few extra conditionals in this
  // first production
block_call      : command do_block {
                    // Workaround for JRUBY-2326 (MRI does not enter this production for some reason)
                    /*%%%*/
                    if ($1 instanceof YieldNode) {
                        p.compile_error("block given to yield");
                    }
                    if ($1 instanceof BlockAcceptingNode && $<BlockAcceptingNode>1.getIterNode() instanceof BlockPassNode) {
                        p.compile_error("Both block arg and actual block given.");
                    }
                    if ($1 instanceof NonLocalControlFlowNode) {
                        ((BlockAcceptingNode) $<NonLocalControlFlowNode>1.getValueNode()).setIterNode($2);
                    } else {
                        $<BlockAcceptingNode>1.setIterNode($2);
                    }
                    $$ = $1;
                    $<Node>$.setLine(@1.start());
                    /*% %*/
                    /*% ripper: method_add_block!($1, $2) %*/
                }
                | block_call call_op2 operation2 opt_paren_args {
                    /*%%%*/
                    $$ = p.new_call($1, $2, $3, $4, null, @3.start());
                    /*% %*/
                    /*% ripper: opt_event(:method_add_arg!, call!($1, $2, $3), $4) %*/
                }
                | block_call call_op2 operation2 opt_paren_args brace_block {
                    /*%%%*/
                    $$ = p.new_call($1, $2, $3, $4, $5, @3.start());
                    /*% %*/
                    /*% ripper: opt_event(:method_add_block!, command_call!($1, $2, $3, $4), $5) %*/
                }
                | block_call call_op2 operation2 command_args do_block {
                    /*%%%*/
                    $$ = p.new_call($1, $2, $3, $4, $5, @3.start());
                    /*% %*/
                    /*% ripper: method_add_block!(command_call!($1, $2, $3, $4), $5) %*/
                }

// [!null]
method_call     : fcall paren_args {
                    /*%%%*/
                    p.frobnicate_fcall_args($1, $2, null);
                    $$ = $1;
                    /*% %*/
                    /*% ripper: method_add_arg!(fcall!($1), $2) %*/
                }
                | primary_value call_op operation2 opt_paren_args {
                    /*%%%*/
                    $$ = p.new_call($1, $2, $3, $4, null, @3.start());
                    /*% %*/
                    /*% ripper: opt_event(:method_add_arg!, call!($1, $2, $3), $4) %*/
                }
                | primary_value tCOLON2 operation2 paren_args {
                    /*%%%*/
                    $$ = p.new_call($1, $3, $4, null);
                    /*% %*/
                    /*% ripper: method_add_arg!(call!($1, ID2VAL(idCOLON2), $3), $4) %*/
                }
                | primary_value tCOLON2 operation3 {
                    /*%%%*/
                    $$ = p.new_call($1, $3, null, null);
                    /*% %*/
                    /*% ripper: call!($1, ID2VAL(idCOLON2), $3) %*/
                }
                | primary_value call_op paren_args {
                    /*%%%*/
                    $$ = p.new_call($1, $2, LexingCommon.CALL, $3, null, @3.start());
                    /*% %*/
                    /*% ripper: method_add_arg!(call!($1, $2, ID2VAL(idCall)), $3) %*/
                }
                | primary_value tCOLON2 paren_args {
                    /*%%%*/
                    $$ = p.new_call($1, LexingCommon.CALL, $3, null);
                    /*% %*/
                    /*% ripper: method_add_arg!(call!($1, ID2VAL(idCOLON2), ID2VAL(idCall)), $3) %*/
                }
                | keyword_super paren_args {
                    /*%%%*/
                    $$ = p.new_super($1, $2);
                    /*% %*/
                    /*% ripper: super!($2) %*/
                }
                | keyword_super {
                    /*%%%*/
                    $$ = new ZSuperNode($1);
                    /*% %*/
                    /*% ripper: zsuper! %*/
                }
                | primary_value '[' opt_call_args rbracket {
                    /*%%%*/
                    if ($1 instanceof SelfNode) {
                        $$ = p.new_fcall(LBRACKET_RBRACKET);
                        p.frobnicate_fcall_args($<FCallNode>$, $3, null);
                    } else {
                        $$ = p.new_call($1, LBRACKET_RBRACKET, $3, null);
                    }
                    /*% %*/
                    /*% ripper: aref!($1, escape_Qundef($3)) %*/
                }

brace_block     : '{' brace_body '}' {
                    $$ = $2;
                    /*%%%*/
                    $2.setLine(@1.end());
                    /*% %*/
                }
                | k_do do_body k_end {
                    $$ = $2;
                    /*%%%*/
                    $2.setLine(@1.end());
                    /*% %*/
                }

brace_body      : {
                    p.pushBlockScope();
                } {
                    $$ = p.resetMaxNumParam();
                } {
                    $$ = p.numparam_push();
                } opt_block_param compstmt {
                    int max_numparam = p.restoreMaxNumParam($<Integer>2);
                    // Changed from MRI args_with_numbered put into parser codepath and not used by ripper (since it is just a passthrough method and types do not match).
                    /*%%%*/
                    ArgsNode args = p.args_with_numbered($4, max_numparam);
                    $$ = new IterNode(@1.start(), args, $5, p.getCurrentScope(), p.src_line());
                    /*% %*/
                    /*% ripper: brace_block!(escape_Qundef($4), $5) %*/
                    p.numparam_pop($<Node>3);
                    p.popCurrentScope();                    
                }

do_body 	: {
                    p.pushBlockScope();
                } {
                    $$ = p.resetMaxNumParam();
                } {
                    $$ = p.numparam_push();
                    p.getCmdArgumentState().push0();
                } opt_block_param bodystmt {
                    int max_numparam = p.restoreMaxNumParam($<Integer>2);
                    // Changed from MRI args_with_numbered put into parser codepath and not used by ripper (since it is just a passthrough method and types do not match).
                    /*%%%*/
                    ArgsNode args = p.args_with_numbered($4, max_numparam);
                    $$ = new IterNode(@1.start(), args, $5, p.getCurrentScope(), p.src_line());
                    /*% %*/
                    /*% ripper: do_block!(escape_Qundef($4), $5) %*/
                    p.getCmdArgumentState().pop();
                    p.numparam_pop($<Node>3);
                    p.popCurrentScope();
                }

case_args	: arg_value {
                    /*%%%*/
                    p.check_literal_when($1);
                    $$ = p.newArrayNode(@1.start(), $1);
                    /*% %*/
                    /*% ripper: args_add!(args_new!, $1) %*/
                }
                | tSTAR arg_value {
                    /*%%%*/
                    $$ = p.newSplatNode($2);
                    /*% %*/
                    /*% ripper: args_add_star!(args_new!, $2) %*/
                }
                | case_args ',' arg_value {
                    /*%%%*/
                    p.check_literal_when($3);
                    $$ = p.last_arg_append($1, $3);
                    /*% %*/
                    /*% ripper: args_add!($1, $3) %*/
                }
                | case_args ',' tSTAR arg_value {
                    /*%%%*/
                    $$ = p.rest_arg_append($1, $4);
                    /*% %*/
                    /*% ripper: args_add_star!($1, $4) %*/
                }
 
case_body       : k_when case_args then compstmt cases {
                    /*%%%*/
                    $$ = p.newWhenNode($1, $2, $4, $5);
                    /*% %*/
                    /*% ripper: when!($2, $4, escape_Qundef($5)) %*/
                }

cases           : opt_else
                | case_body

// InNode - [!null]
p_case_body     : keyword_in {
                    p.setState(EXPR_BEG|EXPR_LABEL);
                    p.setCommandStart(false);
                    LexContext ctxt = (LexContext) p.getLexContext();
                    $1 = ctxt.in_kwarg;
                    ctxt.in_kwarg = true;
                    $$ = p.push_pvtbl();
                } {
                    $$ = p.push_pktbl();
                } p_top_expr then {
                    p.pop_pktbl($<Set>3);
                    p.pop_pvtbl($<Set>2);
                    p.getLexContext().in_kwarg = $<Boolean>1;
                } compstmt p_cases {
                    /*%%%*/
                    $$ = p.newIn(@1.start(), $4, $7, $8);
                    /*% %*/
                    /*% ripper: in!($4, $7, escape_Qundef($8)) %*/
                }

p_cases         : opt_else
                | p_case_body {
                    $$ = $1;
                }

p_top_expr      : p_top_expr_body
                | p_top_expr_body modifier_if expr_value {
                    /*%%%*/
                    $$ = p.new_if(@1.start(), $3, $1, null);
                    p.fixpos($<Node>$, $3);
                    /*% %*/
                    /*% ripper: if_mod!($3, $1) %*/
                }
                | p_top_expr_body modifier_unless expr_value {
                    /*%%%*/
                    $$ = p.new_if(@1.start(), $3, null, $1);
                    p.fixpos($<Node>$, $3);
                    /*% %*/
                    /*% ripper: unless_mod!($3, $1) %*/
                }

// FindPatternNode, HashPatternNode, ArrayPatternNode + p_expr(a lot)
p_top_expr_body : p_expr
                | p_expr ',' {
                    $$ = p.new_array_pattern(@1.start(), null, $1,
                                                   p.new_array_pattern_tail(@1.start(), null, true, null, null));
                }
                | p_expr ',' p_args {
                    $$ = p.new_array_pattern(@1.start(), null, $1, $3);
                    /*%%%*/
                    p.nd_set_first_loc($<Node>$, @1.start());
                    /*% %*/
                }
                | p_find {
                    $$ = p.new_find_pattern(null, $1);
                }
                | p_args_tail {
                    $$ = p.new_array_pattern(@1.start(), null, null, $1);
                }
                | p_kwargs {
                    $$ = p.new_hash_pattern(null, $1);
                }

p_expr          : p_as

p_as            : p_expr tASSOC p_variable {
                    /*%%%*/
                    $$ = new HashNode(@1.start(), new KeyValuePair($1, $3));
                    /*% %*/
                    /*% ripper: binary!($1, STATIC_ID2SYM((id_assoc)), $3) %*/
                }
                | p_alt

p_alt           : p_alt '|' p_expr_basic {
                    /*%%%*/
                    $$ = p.logop($1, OR_OR, $3);
                    /*% %*/
                    /*% ripper: binary!($1, STATIC_ID2SYM(idOr), $3) %*/
                }
                | p_expr_basic

p_lparen        : '(' {
                    $$ = p.push_pktbl();
                }
p_lbracket      : '[' {
                    $$ = p.push_pktbl();
                }

p_expr_basic    : p_value
                | p_variable
                | p_const p_lparen p_args rparen {
                    p.pop_pktbl($<Set>2);
                    $$ = p.new_array_pattern(@1.start(), $1, null, $3);
                    /*%%%*/
                    p.nd_set_first_loc($<Node>$, @1.start());
                    /*% %*/
                }
                | p_const p_lparen p_find rparen {
                    p.pop_pktbl($<Set>2);
                    $$ = p.new_find_pattern($1, $3);
                    /*%%%*/
                    p.nd_set_first_loc($<Node>$, @1.start());
                    /*% %*/
                }
                | p_const p_lparen p_kwargs rparen {
                    p.pop_pktbl($<Set>2);
                    $$ = p.new_hash_pattern($1, $3);
                    /*%%%*/
                    p.nd_set_first_loc($<Node>$, @1.start());
                    /*% %*/
                }
                | p_const '(' rparen {
                     $$ = p.new_array_pattern(@1.start(), $1, null,
                                                    p.new_array_pattern_tail(@1.start(), null, false, null, null));
                }
                | p_const p_lbracket p_args rbracket {
                    p.pop_pktbl($<Set>2);
                    $$ = p.new_array_pattern(@1.start(), $1, null, $3);
                    /*%%%*/
                    p.nd_set_first_loc($<Node>$, @1.start());
                    /*% %*/
                }
                | p_const p_lbracket p_find rbracket {
                    p.pop_pktbl($<Set>2);
                    $$ = p.new_find_pattern($1, $3);
                    /*%%%*/
                    p.nd_set_first_loc($<Node>$, @1.start());
                    /*% %*/
                }
                | p_const p_lbracket p_kwargs rbracket {
                    p.pop_pktbl($<Set>2);
                    $$ = p.new_hash_pattern($1, $3);
                    /*%%%*/
                    p.nd_set_first_loc($<Node>$, @1.start());
                    /*% %*/
                }
                | p_const '[' rbracket {
                    $$ = p.new_array_pattern(@1.start(), $1, null,
                            p.new_array_pattern_tail(@1.start(), null, false, null, null));
                }
                | tLBRACK p_args rbracket {
                    $$ = p.new_array_pattern(@1.start(), null, null, $2);
                }
                | tLBRACK p_find rbracket {
                    $$ = p.new_find_pattern(null, $2);
                }
                | tLBRACK rbracket {
                    $$ = p.new_array_pattern(@1.start(), null, null,
                            p.new_array_pattern_tail(@1.start(), null, false, null, null));
                }
                | tLBRACE {
                    $$ = p.push_pktbl();
                    LexContext ctxt = p.getLexContext();
                    $1 = ctxt.in_kwarg;
                    ctxt.in_kwarg = false;
                } p_kwargs rbrace {
                    p.pop_pktbl($<Set>2);
                    p.getLexContext().in_kwarg = $<Boolean>1;
                    $$ = p.new_hash_pattern(null, $3);
                }
                | tLBRACE rbrace {
                    $$ = p.new_hash_pattern(null, p.new_hash_pattern_tail(@1.start(), p.none(), null, null));
                }
                | tLPAREN {
                    $$ = p.push_pktbl();
                 } p_expr rparen {
                    p.pop_pktbl($<Set>2);
                    $$ = $3;
                }

p_args          : p_expr {
                    /*%%%*/
                    ListNode preArgs = p.newArrayNode(@1.start(), $1);
                    $$ = p.new_array_pattern_tail(@1.start(), preArgs, false, null, null);
                    // JRuby Changed
                    /*% 
                        $$ = p.new_array_pattern_tail(@1.start(), p.new_array($1), false, null, null);
                    %*/
                }
                | p_args_head {
                    $$ = p.new_array_pattern_tail(@1.start(), $1, true, null, null);
                }
                | p_args_head p_arg {
                    /*%%%*/
                    $$ = p.new_array_pattern_tail(@1.start(), p.list_concat($1, $2), false, null, null);
                    // JRuby Changed
                    /*%
			RubyArray pre_args = $1.push($2);
			$$ = p.new_array_pattern_tail(@1.start(), pre_args, false, null, null);
                    %*/
                }
                | p_args_head tSTAR tIDENTIFIER {
                     $$ = p.new_array_pattern_tail(@1.start(), $1, true, $3, null);
                }
                | p_args_head tSTAR tIDENTIFIER ',' p_args_post {
                     $$ = p.new_array_pattern_tail(@1.start(), $1, true, $3, $5);
                }
                | p_args_head tSTAR {
                     $$ = p.new_array_pattern_tail(@1.start(), $1, true, null, null);
                }
                | p_args_head tSTAR ',' p_args_post {
                     $$ = p.new_array_pattern_tail(@1.start(), $1, true, null, $4);
                }
                | p_args_tail {
                     $$ = $1;
                }

// ListNode - [!null]
p_args_head     : p_arg ',' {
                     $$ = $1;
                }
                | p_args_head p_arg ',' {
                    /*%%%*/
                    $$ = p.list_concat($1, $2);
                    /*% %*/
                    /*% ripper: rb_ary_concat($1, get_value($2)) %*/
                }

p_args_tail     : p_rest {
                     $$ = p.new_array_pattern_tail(@1.start(), null, true, $1, null);
                }
                | p_rest ',' p_args_post {
                     $$ = p.new_array_pattern_tail(@1.start(), null, true, $1, $3);
                }

// FindPatternNode - [!null]
p_find          : p_rest ',' p_args_post ',' p_rest {
                     p.warn_experimental(@1.start(), "Find pattern is experimental, and the behavior may change in future versions of Ruby!");
                     $$ = p.new_find_pattern_tail(@1.start(), $1, $3, $5);
                }

// ByteList
p_rest          : tSTAR tIDENTIFIER {
                    $$ = $2;
                }
                | tSTAR {
                    $$ = null;
                }

// ListNode - [!null]
p_args_post     : p_arg
                | p_args_post ',' p_arg {
                    /*%%%*/
                    $$ = p.list_concat($1, $3);
                    /*% %*/
                    /*% ripper: rb_ary_concat($1, get_value($3)) %*/
                }

// ListNode - [!null]
p_arg           : p_expr {
                    /*%%%*/
                    $$ = p.newArrayNode(@1.start(), $1);
                    /*% %*/
                    /*% ripper: rb_ary_new_from_args(1, get_value($1)) %*/
                }

// HashPatternNode - [!null]
p_kwargs        : p_kwarg ',' p_any_kwrest {
                    $$ = p.new_hash_pattern_tail(@1.start(), $1, $3, @3.id);
                }
		| p_kwarg {
                    $$ = p.new_hash_pattern_tail(@1.start(), $1, null, null);
                }
                | p_kwarg ',' {
                    $$ = p.new_hash_pattern_tail(@1.start(), $1, null, null);
                }
                | p_any_kwrest {
                    $$ = p.new_hash_pattern_tail(@1.start(), null, $1, @1.id);
                }

// HashNode - [!null]
p_kwarg         : p_kw {
                    /*%%%*/
                    $$ = new HashNode(@1.start(), $1);
                    /*% %*/
                    /*% ripper[brace]: rb_ary_new_from_args(1, $1) %*/
                }
                | p_kwarg ',' p_kw {
                    /*%%%*/
                    $1.add($3);
                    $$ = $1;
                    /*% %*/
                    /*% ripper: rb_ary_push($1, $3) %*/
                }

// KeyValuePair - [!null]
p_kw            : p_kw_label p_expr {
                    p.error_duplicate_pattern_key(@1.id);
                    /*%%%*/
                    Node label = p.asSymbol(@1.start(), $1);

                    $$ = new KeyValuePair(label, $2);
                    /*% %*/
                    /*% ripper: rb_ary_new_from_args(2, get_value($1), get_value($2)) %*/
                }
                | p_kw_label {
                    p.error_duplicate_pattern_key(@1.id);
                    if (@1.id != null && !p.is_local_id(@1.id)) {
                        p.yyerror("key must be valid as local variables");
                    }
                    p.error_duplicate_pattern_variable(@1.id);
                    /*%%%*/

                    Node label = p.asSymbol(@1.start(), $1);
                    $$ = new KeyValuePair(label, p.assignableLabelOrIdentifier($1, null));
                    /*% %*/
                    /*% ripper: rb_ary_new_from_args(2, get_value($1), Qnil) %*/
                }

// ByteList
p_kw_label      : tLABEL
                | tSTRING_BEG string_contents tLABEL_END {
		    /*%%%*/
                    if ($2 == null || $2 instanceof StrNode) {
                        $$ = $<StrNode>2.getValue();
                    }
		    /*%
                      if (true) {
                        $$ = $2;
                      }
		    %*/
                    else {
                        p.yyerror("symbol literal with interpolation is not allowed");
                        $$ = null;
                    }
                }

p_kwrest        : kwrest_mark tIDENTIFIER {
                    $$ = $2;
                }
                | kwrest_mark {
                    $$ = null;
                }

p_kwnorest      : kwrest_mark keyword_nil {
                    $$ = null;
                }

p_any_kwrest    : p_kwrest {
                    $$ = $1;
                }
                | p_kwnorest {
                    $$ = KWNOREST;
                }

p_value         : p_primitive
                | p_primitive tDOT2 p_primitive {
                    /*%%%*/
                    p.value_expr($1);
                    p.value_expr($3);
                    boolean isLiteral = $1 instanceof FixnumNode && $3 instanceof FixnumNode;
                    $$ = new DotNode(@1.start(), p.makeNullNil($1), p.makeNullNil($3), false, isLiteral);
                    /*% %*/
                    /*% ripper: dot2!($1, $3) %*/
                }
                | p_primitive tDOT3 p_primitive {
                    /*%%%*/
                    p.value_expr($1);
                    p.value_expr($3);
                    boolean isLiteral = $1 instanceof FixnumNode && $3 instanceof FixnumNode;
                    $$ = new DotNode(@1.start(), p.makeNullNil($1), p.makeNullNil($3), true, isLiteral);
                    /*% %*/
                    /*% ripper: dot3!($1, $3) %*/
                }
                | p_primitive tDOT2 {
                    /*%%%*/
                    p.value_expr($1);
                    boolean isLiteral = $1 instanceof FixnumNode;
                    $$ = new DotNode(@1.start(), p.makeNullNil($1), NilImplicitNode.NIL, false, isLiteral);
                    /*% %*/
                    /*% ripper: dot2!($1, Qnil) %*/
                }
                | p_primitive tDOT3 {
                    /*%%%*/
                    p.value_expr($1);
                    boolean isLiteral = $1 instanceof FixnumNode;
                    $$ = new DotNode(@1.start(), p.makeNullNil($1), NilImplicitNode.NIL, true, isLiteral);
                    /*% %*/
                    /*% ripper: dot3!($1, Qnil) %*/
                }
                | p_var_ref
                | p_expr_ref
                | p_const
                | tBDOT2 p_primitive {
                    /*%%%*/
                    p.value_expr($2);
                    boolean isLiteral = $2 instanceof FixnumNode;
                    $$ = new DotNode(@1.start(), NilImplicitNode.NIL, p.makeNullNil($2), false, isLiteral);
                    /*% %*/
                    /*% ripper: dot2!(Qnil, $2) %*/
                }
                | tBDOT3 p_primitive {
                    /*%%%*/
                    p.value_expr($2);
                    boolean isLiteral = $2 instanceof FixnumNode;
                    $$ = new DotNode(@1.start(), NilImplicitNode.NIL, p.makeNullNil($2), true, isLiteral);
                    /*% %*/
                    /*% ripper: dot3!(Qnil, $2) %*/
                }

p_primitive     : literal
                | strings
                | xstring
                | regexp
                | words {
                    $$ = $1;
                }
                | qwords {
                    $$ = $1;
                }
                | symbols {
                    $$ = $1;
                }
                | qsymbols {
                    $$ = $1;
                } 
                | /*mri:keyword_variable*/ keyword_nil {
                    /*%%%*/
                    $$ = new NilNode(p.tokline());
                    /*% %*/
                    /*% ripper: var_ref!($1) %*/
                }
                | keyword_self {
                    /*%%%*/
                    $$ = new SelfNode(p.tokline());
                    /*% %*/
                    /*% ripper: var_ref!($1) %*/
                }
                | keyword_true { 
                    /*%%%*/
                    $$ = new TrueNode(p.tokline());
                    /*% %*/
                    /*% ripper: var_ref!($1) %*/
                }
                | keyword_false {
                    /*%%%*/
                    $$ = new FalseNode(p.tokline());
                    /*% %*/
                    /*% ripper: var_ref!($1) %*/
                }
                | keyword__FILE__ {
                    /*%%%*/
                    $$ = new FileNode(p.tokline(), new ByteList(p.getFile().getBytes(),
                    p.getRuntime().getEncodingService().getLocaleEncoding()));
                    /*% %*/
                    /*% ripper: var_ref!($1) %*/
                }
                | keyword__LINE__ {
                    /*%%%*/
                    $$ = new FixnumNode(p.tokline(), p.tokline()+1);
                    /*% %*/
                    /*% ripper: var_ref!($1) %*/
                }
                | keyword__ENCODING__ {
                    /*%%%*/
                    $$ = new EncodingNode(p.tokline(), p.getEncoding());
                    /*% %*/
                    /*% ripper: var_ref!($1) %*/
                } /*mri:keyword_variable*/
                | lambda {
                    $$ = $1;
                } 

p_variable      : tIDENTIFIER {
                    /*%%%*/
                    p.error_duplicate_pattern_variable($1);
                    $$ = p.assignableInCurr($1, null);
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }

p_var_ref       : '^' tIDENTIFIER {
                    /*%%%*/
                    Node n = p.gettable($2);
                    if (!(n instanceof LocalVarNode || n instanceof DVarNode)) {
                        p.compile_error("" + $2 + ": no such local variable");
                    }
                    $$ = n;
                    /*% %*/
                    /*% ripper: var_ref!($2) %*/
                }
                | '^' nonlocal_var {
                    /*%%%*/
                    $$ = p.gettable($2);
                    if ($$ == null) $$ = new BeginNode(p.tokline(), NilImplicitNode.NIL);
                    /*% %*/
                    /*% ripper: var_ref!($2) %*/
                }

p_expr_ref      : '^' tLPAREN expr_value ')' {
                    /*%%%*/
                    $$ = new BeginNode(p.tokline(), $3);
                    /*% %*/
                    /*% ripper: begin!($3) %*/
                }

p_const         : tCOLON3 cname {
                    /*%%%*/
                    $$ = p.new_colon3(p.tokline(), $2);
                    /*% %*/
                    /*% ripper: top_const_ref!($2) %*/
                }
                | p_const tCOLON2 cname {
                    /*%%%*/
                    $$ = p.new_colon2(p.tokline(), $1, $3);
                    /*% %*/
                    /*% ripper: const_path_ref!($1, $3) %*/
                }
                | tCONSTANT {
                    /*%%%*/
                    $$ = new ConstNode(p.tokline(), p.symbolID($1));
                    /*% %*/
                    /*% ripper: var_ref!($1) %*/
                }

opt_rescue      : k_rescue exc_list exc_var then compstmt opt_rescue {
                    /*%%%*/
                    Node node;
                    if ($3 != null) {
                        node = p.appendToBlock(node_assign($3, new GlobalVarNode($1, p.symbolID(DOLLAR_BANG))), p.makeNullNil($5));
                        if ($5 != null) {
                            node.setLine($1);
                        }
                    } else {
                        node = $5;
                    }
                    Node body = p.makeNullNil(node);
                    $$ = new RescueBodyNode($1, $2, body, $6);
                    /*% %*/
                    /*% ripper: rescue!(escape_Qundef($2), escape_Qundef($3), escape_Qundef($5), escape_Qundef($6)) %*/
                }
                | none {
                    $$ = null; 
                }

exc_list        : arg_value {
                    /*%%%*/
                    $$ = p.newArrayNode(@1.start(), $1);
                    /*% %*/
                    /*% ripper: rb_ary_new3(1, get_value($1)) %*/
                }
                | mrhs {
                    /*%%%*/
                    $$ = p.splat_array($1);
                    if ($$ == null) $$ = $1; // ArgsCat or ArgsPush
                    /*% %*/
                    /*% ripper: $1 %*/
                }
                | none

exc_var         : tASSOC lhs {
                    $$ = $2;
                }
                | none

opt_ensure      : k_ensure compstmt {
                    /*%%%*/
                    $$ = $2;
                    /*% %*/
                    /*% ripper: ensure!($2) %*/
                }
                | none

literal         : numeric {
                    $$ = $1;
                }
                | symbol {
                    $$ = $1;
                }


strings         : string {
                    /*%%%*/
                    $$ = $1 instanceof EvStrNode ? new DStrNode(@1.start(), p.getEncoding()).add($1) : $1;
                    /*% %*/
                    /*% ripper: $1 %*/
                }

// [!null]
string          : tCHAR {
                    $$ = $1;
                }
                | string1 {
                    $$ = $1;
                }
                | string string1 {
                    /*%%%*/
                    $$ = p.literal_concat($1, $2);
                    /*% %*/
                    /*% ripper: string_concat!($1, $2) %*/
                }

string1         : tSTRING_BEG string_contents tSTRING_END {
                    /*%%%*/
                    p.heredoc_dedent($2);
		    p.setHeredocIndent(0);
                    $$ = $2;
                    /*% %*/
                    /*% ripper: string_literal!(heredoc_dedent(p, $2)) %*/
                }

xstring         : tXSTRING_BEG xstring_contents tSTRING_END {
                    /*%%%*/
                    int line = @2.start();

                    p.heredoc_dedent($2);
		    p.setHeredocIndent(0);

                    if ($2 == null) {
                        $$ = new XStrNode(line, null, StringSupport.CR_7BIT);
                    } else if ($2 instanceof StrNode) {
                        $$ = new XStrNode(line, (ByteList) $<StrNode>2.getValue().clone(), $<StrNode>2.getCodeRange());
                    } else if ($2 instanceof DStrNode) {
                        $$ = new DXStrNode(line, $<DStrNode>2);

                        $<Node>$.setLine(line);
                    } else {
                        $$ = new DXStrNode(line).add($2);
                    }
                    /*% %*/
                    /*% ripper: xstring_literal!(heredoc_dedent(p, $2)) %*/
                }

regexp          : tREGEXP_BEG regexp_contents tREGEXP_END {
                    $$ = p.new_regexp(@2.start(), $2, $3);
                }

// [!null] - ListNode
words           : tWORDS_BEG ' ' word_list tSTRING_END {
                    /*%%%*/
                    $$ = $3;
                    /*% %*/
                    /*% ripper: array!($3) %*/
                }

// [!null] - ListNode
word_list       : /* none */ {
                    /*%%%*/
                     $$ = new ArrayNode(p.src_line());
                    /*% %*/
                    /*% ripper: words_new! %*/
                }
                | word_list word ' ' {
                    /*%%%*/
                     $$ = $1.add($2 instanceof EvStrNode ? new DStrNode(@1.start(), p.getEncoding()).add($2) : $2);
                    /*% %*/
                    /*% ripper: words_add!($1, $2) %*/
                }

// [!null] - StrNode, ListNode (usually D*)
word            : string_content {
                     $$ = $1;
                     /*% ripper[brace]: word_add!(word_new!, $1) %*/
                }
                | word string_content {
                    /*%%%*/
                    $$ = p.literal_concat($1, $2);
                    /*% %*/
                    /*% ripper: word_add!($1, $2) %*/
                }

symbols         : tSYMBOLS_BEG ' ' symbol_list tSTRING_END {
                    /*%%%*/
                    $$ = $3;
                    /*% %*/
                    /*% ripper: array!($3) %*/
                }

symbol_list     : /* none */ {
                    /*%%%*/
                    $$ = new ArrayNode(p.src_line());
                    /*% %*/
                    /*% ripper: symbols_new! %*/
                }
                | symbol_list word ' ' {
                    /*%%%*/
                    $$ = $1.add($2 instanceof EvStrNode ? new DSymbolNode(@1.start()).add($2) : p.asSymbol(@1.start(), $2));
                    /*% %*/
                    /*% ripper: symbols_add!($1, $2) %*/
                }

// [!null] - ListNode
qwords          : tQWORDS_BEG ' ' qword_list tSTRING_END {
                    /*%%%*/
                    $$ = $3;
                    /*% %*/
                    /*% ripper: array!($3) %*/
                }

// [!null] - ListNode
qsymbols        : tQSYMBOLS_BEG ' ' qsym_list tSTRING_END {
                    /*%%%*/
                    $$ = $3;
                    /*% %*/
                    /*% ripper: array!($3) %*/
                }


// [!null] - ListNode
qword_list      : /* none */ {
                    /*%%%*/
                    $$ = new ArrayNode(p.src_line());
                    /*% %*/
                    /*% ripper: qwords_new! %*/
                }
                | qword_list tSTRING_CONTENT ' ' {
                    /*%%%*/
                    $$ = $1.add($2);
                    /*% %*/
                    /*% ripper: qwords_add!($1, $2) %*/
                }

// [!null] - ListNode
qsym_list      : /* none */ {
                    /*%%%*/
                    $$ = new ArrayNode(p.src_line());
                    /*% %*/
                    /*% ripper: qsymbols_new! %*/
                }
                | qsym_list tSTRING_CONTENT ' ' {
                    /*%%%*/
                    $$ = $1.add(p.asSymbol(@1.start(), $2));
                    /*% %*/
                    /*% ripper: qsymbols_add!($1, $2) %*/
                }

/* note: we differ from MRI in that we just use same RubyString logic
   vs their ripper_new_yyval code. */
string_contents : /* none */ {
                    ByteList aChar = ByteList.create("");
                    aChar.setEncoding(p.getEncoding());
                    $$ = p.createStr(aChar, 0);
                    /*% ripper: string_content! %*/
                }
                | string_contents string_content {
                    /*%%%*/
                    $$ = p.literal_concat($1, $2);
                    /*% %*/
                    /*% ripper: string_add!($1, $2) %*/
                    // JRuby changed (removed)
                }

xstring_contents: /* none */ {
                    /*%%%*/
                    ByteList aChar = ByteList.create("");
                    aChar.setEncoding(p.getEncoding());
                    $$ = p.createStr(aChar, 0);
                    /*% %*/
                    /*% ripper: xstring_new! %*/
                }
                | xstring_contents string_content {
                    /*%%%*/
                    $$ = p.literal_concat($1, $2);
                    /*% %*/
                    /*% ripper: xstring_add!($1, $2) %*/
                }

regexp_contents: /* none */ {
                    /*%%%*/
                    $$ = null;
                    /*% %*/
                    /*% ripper: regexp_new! %*/
                }
                | regexp_contents string_content {
                    // FIXME: mri is different here.
                    /*%%%*/
                    $$ = p.literal_concat($1, $2);
                    // JRuby changed
                    /*% 
			$$ = p.dispatch("on_regexp_add", $1, $2);
                    %*/
                }

/* note: We differ from MRI by not having any ripper for bare tSTRING_CONTENT.
 * We already create a RubyString for yyval. */
// [!null] - StrNode, EvStrNode
string_content  : tSTRING_CONTENT {
                    $$ = $1;
		    /*% ripper[brace]: ripper_new_yylval(p, 0, get_value($1), $1) %*/
                }
                | tSTRING_DVAR {
                    $$ = p.getStrTerm();
                    p.setStrTerm(null);
                    p.setState(EXPR_BEG);
                } string_dvar {
                    /*%%%*/
                    p.setStrTerm($<StrTerm>2);
                    $$ = new EvStrNode(@3.start(), $3);
                    /*% %*/
                    /*% ripper: string_dvar!($3) %*/
                }
                | tSTRING_DBEG {
                   $$ = p.getStrTerm();
                   p.setStrTerm(null);
                   p.getConditionState().push0();
                   p.getCmdArgumentState().push0();
                } {
                   $$ = p.getState();
                   p.setState(EXPR_BEG);
                } {
                   $$ = p.getBraceNest();
                   p.setBraceNest(0);
                } {
                   $$ = p.getHeredocIndent();
                   p.setHeredocIndent(0);
                } compstmt tSTRING_DEND {
                   p.getConditionState().pop();
                   p.getCmdArgumentState().pop();
                   p.setStrTerm($<StrTerm>2);
                   p.setState($<Integer>3);
                   p.setBraceNest($<Integer>4);
                   p.setHeredocIndent($<Integer>5);
                   p.setHeredocLineIndent(-1);

                   /*%%%*/
                   if ($6 != null) $6.unsetNewline();
                   $$ = p.newEvStrNode(@6.start(), $6);
                   /*% %*/
                   /*% ripper: string_embexpr!($7) %*/
                }

string_dvar     : tGVAR {
                    /*%%%*/
                    $$ = new GlobalVarNode(p.src_line(), p.symbolID($1));
                    /*% %*/
                    /*% ripper: var_ref!($1) %*/
                }
                | tIVAR {
                    /*%%%*/
                    $$ = new InstVarNode(p.src_line(), p.symbolID($1));
                    /*% %*/
                    /*% ripper: var_ref!($1) %*/
                }
                | tCVAR {
                    /*%%%*/
                    $$ = new ClassVarNode(p.src_line(), p.symbolID($1));
                    /*% %*/
                    /*% ripper: var_ref!($1) %*/
                }
                | backref

// [!null] - SymbolNode, DSymbolNode
symbol          : ssym
                | dsym

// [!null] - SymbolNode:symbol  
ssym            : tSYMBEG sym {
                    p.setState(EXPR_END);
                    /*%%%*/
                    $$ = p.asSymbol(p.src_line(), $2);
                    /*% %*/
                    /*% ripper: symbol_literal!(symbol!($2)) %*/
                }

// [!null] - ByteList:symbol
sym             : fname
                | tIVAR {
                    $$ = $1;
                }
                | tGVAR {
                    $$ = $1;
                }
                | tCVAR {
                    $$ = $1;
                }

// [!null] - SymbolNode, DSymbolNode 
dsym            : tSYMBEG string_contents tSTRING_END {
                    p.setState(EXPR_END);

                    /*%%%*/
                    // DStrNode: :"some text #{some expression}"
                    // StrNode: :"some text"
                    // EvStrNode :"#{some expression}"
                    // Ruby 1.9 allows empty strings as symbols
                    if ($2 == null) {
                        $$ = p.asSymbol(p.src_line(), new ByteList(new byte[] {}));
                    } else if ($2 instanceof DStrNode) {
                        $$ = new DSymbolNode(@2.start(), $<DStrNode>2);
                    } else if ($2 instanceof StrNode) {
                        $$ = p.asSymbol(@2.start(), $2);
                    } else {
                        $$ = new DSymbolNode(@2.start());
                        $<DSymbolNode>$.add($2);
                    }
                    /*% %*/
                    /*% ripper: dyna_symbol!($2) %*/
                }

numeric         : simple_numeric {
                    $$ = $1;  
                }
                | tUMINUS_NUM simple_numeric %prec tLOWEST {
                    /*%%%*/
                    $$ = p.negateNumeric($2);
                    /*% %*/
                    /*% ripper: unary!(ID2VAL(idUMinus), $2) %*/
                }

nonlocal_var    : tIVAR
                | tGVAR
                | tCVAR

simple_numeric  : tINTEGER {
                    $$ = $1;
                }
                | tFLOAT {
                     $$ = $1;
                }
                | tRATIONAL {
                     $$ = $1;
                }
                | tIMAGINARY {
                     $$ = $1;
                } 

/* note[ripper]: We call a helper for user_variables instead of their code */
// [!null]
var_ref         : tIDENTIFIER { // mri:user_variable
                    /*%%%*/
                    $$ = p.declareIdentifier($1);
                    /*%  %*/
                    /*%
                    if (p.id_is_var(@1.id)) {
                        $$ = p.dispatch("on_var_ref", $1);
                    } else {
                        $$ = p.dispatch("on_vcall", $1);
                    }
                    %*/
                }
                | tIVAR {
                    /*%%%*/
                    $$ = new InstVarNode(p.tokline(), p.symbolID($1));
                    /*%  %*/
                    /*%
                    if (p.id_is_var(@1.id)) {
                        $$ = p.dispatch("on_var_ref", $1);
                    } else {
                        $$ = p.dispatch("on_vcall", $1);
                    }
                    %*/
                }
                | tGVAR {
                    /*%%%*/
                    $$ = new GlobalVarNode(p.tokline(), p.symbolID($1));
                    /*%  %*/
                    /*%
                    if (p.id_is_var(@1.id)) {
                        $$ = p.dispatch("on_var_ref", $1);
                    } else {
                        $$ = p.dispatch("on_vcall", $1);
                    }
                    %*/
                }
                | tCONSTANT {
                    /*%%%*/
                    $$ = new ConstNode(p.tokline(), p.symbolID($1));
                    /*%  %*/
                    /*%
                    if (p.id_is_var(@1.id)) {
                        $$ = p.dispatch("on_var_ref", $1);
                    } else {
                        $$ = p.dispatch("on_vcall", $1);
                    }
                    %*/
                }
                | tCVAR {
                    /*%%%*/
                    $$ = new ClassVarNode(p.tokline(), p.symbolID($1));
                    /*%  %*/
                    /*%
                    if (p.id_is_var(@1.id)) {
                        $$ = p.dispatch("on_var_ref", $1);
                    } else {
                        $$ = p.dispatch("on_vcall", $1);
                    }
                    %*/
                } // mri:user_variable
                | keyword_nil { // mri:keyword_variable
                    /*%%%*/
                    $$ = new NilNode(p.tokline());
                    /*% %*/
                    /*% ripper: var_ref!($1) %*/
                }
                | keyword_self {
                    /*%%%*/
                    $$ = new SelfNode(p.tokline());
                    /*% %*/
                    /*% ripper: var_ref!($1) %*/
                }
                | keyword_true { 
                    /*%%%*/
                    $$ = new TrueNode(p.tokline());
                    /*% %*/
                    /*% ripper: var_ref!($1) %*/
                }
                | keyword_false {
                    /*%%%*/
                    $$ = new FalseNode(p.tokline());
                    /*% %*/
                    /*% ripper: var_ref!($1) %*/
                }
                | keyword__FILE__ {
                    /*%%%*/
                    $$ = new FileNode(p.tokline(), new ByteList(p.getFile().getBytes(),
                    p.getRuntime().getEncodingService().getLocaleEncoding()));
                    /*% %*/
                    /*% ripper: var_ref!($1) %*/
                }
                | keyword__LINE__ {
                    /*%%%*/
                    $$ = new FixnumNode(p.tokline(), p.tokline()+1);
                    /*% %*/
                    /*% ripper: var_ref!($1) %*/
                }
                | keyword__ENCODING__ {
                    /*%%%*/
                    $$ = new EncodingNode(p.tokline(), p.getEncoding());
                    /*% %*/
                    /*% ripper: var_ref!($1) %*/
                } // mri:keyword_variable

// [!null]
var_lhs         : tIDENTIFIER { // mri:user_variable
                    /*%%%*/
                    $$ = p.assignableLabelOrIdentifier($1, null);
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                    
                }
                | tIVAR {
                    /*%%%*/
                    $$ = new InstAsgnNode(p.tokline(), p.symbolID($1), NilImplicitNode.NIL);
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | tGVAR {
                    /*%%%*/
                    $$ = new GlobalAsgnNode(p.tokline(), p.symbolID($1), NilImplicitNode.NIL);
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | tCONSTANT {
                    /*%%%*/
                    if (p.getLexContext().in_def) p.compile_error("dynamic constant assignment");

                    $$ = new ConstDeclNode(p.tokline(), p.symbolID($1), null, NilImplicitNode.NIL);
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | tCVAR {
                    /*%%%*/
                    $$ = new ClassVarAsgnNode(p.tokline(), p.symbolID($1), NilImplicitNode.NIL);
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                } // mri:user_variable
                | keyword_nil { // mri:keyword_variable
                    /*%%%*/
                    p.compile_error("Can't assign to nil");
                    $$ = null;
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | keyword_self {
                    /*%%%*/
                    p.compile_error("Can't change the value of self");
                    $$ = null;
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | keyword_true {
                    /*%%%*/
                    p.compile_error("Can't assign to true");
                    $$ = null;
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | keyword_false {
                    /*%%%*/
                    p.compile_error("Can't assign to false");
                    $$ = null;
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | keyword__FILE__ {
                    /*%%%*/
                    p.compile_error("Can't assign to __FILE__");
                    $$ = null;
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | keyword__LINE__ {
                    /*%%%*/
                    p.compile_error("Can't assign to __LINE__");
                    $$ = null;
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                }
                | keyword__ENCODING__ {
                    /*%%%*/
                    p.compile_error("Can't assign to __ENCODING__");
                    $$ = null;
                    /*%
                      $$ = p.assignable(@1.id, p.var_field($1));
                    %*/
                } // mri:keyword_variable

// [!null]
backref         : tNTH_REF {
                    $$ = $1;
                }
                | tBACK_REF {
                    $$ = $1;
                }

superclass      : '<' {
                   p.setState(EXPR_BEG);
                   p.setCommandStart(true);
                } expr_value term {
                    $$ = $3;
                }
                | {
                    /*%%%*/
                    $$ = null;
                    /*% %*/
                    /*% ripper: Qnil %*/
                }

f_opt_paren_args: f_paren_args
                | none {
                    p.getLexContext().in_argdef = false;
                    $$ = p.new_args(p.tokline(), null, null, null, null, 
                                    p.new_args_tail(p.src_line(), null, (ByteList) null, (ByteList) null));
                }

f_paren_args    : '(' f_args rparen {
                    /*%%%*/
                    $$ = $2;
                    /*% %*/
                    /*% ripper: paren!($2) %*/
                    p.setState(EXPR_BEG);
                    p.getLexContext().in_argdef = false;
                    p.setCommandStart(true);
                }

// [!null]
f_arglist       : f_paren_args {
                   $$ = $1;
                }
                | {
                    LexContext ctxt = p.getLexContext();
                    $$ = ctxt.in_kwarg;
                    ctxt.in_kwarg = true;
                    ctxt.in_argdef = true;
                    p.setState(p.getState() | EXPR_LABEL);
                } f_args term {
                    LexContext ctxt = p.getLexContext();
                    ctxt.in_kwarg = $<Boolean>1;
                    ctxt.in_argdef = false;
                    $$ = $2;
                    p.setState(EXPR_BEG);
                    p.setCommandStart(true);
                }


args_tail       : f_kwarg ',' f_kwrest opt_f_block_arg {
                    $$ = p.new_args_tail(@1.start(), $1, $3, $4);
                }
                | f_kwarg opt_f_block_arg {
                    $$ = p.new_args_tail(@1.start(), $1, (ByteList) null, $2);
                }
                | f_any_kwrest opt_f_block_arg {
                    $$ = p.new_args_tail(p.src_line(), null, $1, $2);
                }
                | f_block_arg {
                    $$ = p.new_args_tail(@1.start(), null, (ByteList) null, $1);
                }
                | args_forward {
                    p.add_forwarding_args();
                    $$ = p.new_args_tail(p.tokline(), null, $1, FWD_BLOCK);
                }

opt_args_tail   : ',' args_tail {
                    $$ = $2;
                }
                | /* none */ {
                    $$ = p.new_args_tail(p.src_line(), null, (ByteList) null, (ByteList) null);
                }

// [!null]
f_args          : f_arg ',' f_optarg ',' f_rest_arg opt_args_tail {
                    $$ = p.new_args(@1.start(), $1, $3, $5, null, $6);
                }
                | f_arg ',' f_optarg ',' f_rest_arg ',' f_arg opt_args_tail {
                    $$ = p.new_args(@1.start(), $1, $3, $5, $7, $8);
                }
                | f_arg ',' f_optarg opt_args_tail {
                    $$ = p.new_args(@1.start(), $1, $3, null, null, $4);
                }
                | f_arg ',' f_optarg ',' f_arg opt_args_tail {
                    $$ = p.new_args(@1.start(), $1, $3, null, $5, $6);
                }
                | f_arg ',' f_rest_arg opt_args_tail {
                    $$ = p.new_args(@1.start(), $1, null, $3, null, $4);
                }
                | f_arg ',' f_rest_arg ',' f_arg opt_args_tail {
                    $$ = p.new_args(@1.start(), $1, null, $3, $5, $6);
                }
                | f_arg opt_args_tail {
                    $$ = p.new_args(@1.start(), $1, null, null, null, $2);
                }
                | f_optarg ',' f_rest_arg opt_args_tail {
                    $$ = p.new_args(@1.start(), null, $1, $3, null, $4);
                }
                | f_optarg ',' f_rest_arg ',' f_arg opt_args_tail {
                    $$ = p.new_args(@1.start(), null, $1, $3, $5, $6);
                }
                | f_optarg opt_args_tail {
                    $$ = p.new_args(@1.start(), null, $1, null, null, $2);
                }
                | f_optarg ',' f_arg opt_args_tail {
                    $$ = p.new_args(@1.start(), null, $1, null, $3, $4);
                }
                | f_rest_arg opt_args_tail {
                    $$ = p.new_args(@1.start(), null, null, $1, null, $2);
                }
                | f_rest_arg ',' f_arg opt_args_tail {
                    $$ = p.new_args(@1.start(), null, null, $1, $3, $4);
                }
                | args_tail {
                    $$ = p.new_args(@1.start(), null, null, null, null, $1);
                }
                | /* none */ {
                    $$ = p.new_args(p.src_line(), null, null, null, null, (ArgsTailHolder) null);
                }

// [!null] - ByteList
args_forward    : tBDOT3 {
                    /*%%%*/
                    $$ = FWD_KWREST;
                    /*% %*/
                    /*% ripper: args_forward! %*/
                }

f_bad_arg       : tCONSTANT {
                    String message = "formal argument cannot be a constant";
                    /*%%%*/
                    p.yyerror(message);
                    /*% %*/
                    /*% ripper[error]: param_error!(ERR_MESG(), $1) %*/
                }
                | tIVAR {
                    String message = "formal argument cannot be an instance variable";
                    /*%%%*/
                    p.yyerror(message);
                    /*% %*/
                    /*% ripper[error]: param_error!(ERR_MESG(), $1) %*/
                }
                | tGVAR {
                    String message = "formal argument cannot be a global variable";
                    /*%%%*/
                    p.yyerror(message);
                    /*% %*/
                    /*% ripper[error]: param_error!(ERR_MESG(), $1) %*/
                }
                | tCVAR {
                    String message = "formal argument cannot be a class variable";
                    /*%%%*/
                    p.yyerror(message);
                    /*% %*/
                    /*% ripper[error]: param_error!(ERR_MESG(), $1) %*/
                }

// ByteList:f_norm_arg [!null]
f_norm_arg      : f_bad_arg {
                    $$ = $1; // Not really reached
                }
                | tIDENTIFIER {
                    $$ = p.formal_argument(@1.id, $1);
                    p.ordinalMaxNumParam();
                }

f_arg_asgn      : f_norm_arg {
                    RubySymbol name = p.get_id($1);
                    p.setCurrentArg(name);
                    $$ = p.arg_var(@1.id);
                }

f_arg_item      : f_arg_asgn {
                    p.setCurrentArg(null);
                    /*%%%*/
                    $$ = $1;
                    /*% %*/
                    /*% ripper: get_value($1) %*/
                }
                | tLPAREN f_margs rparen {
                    /*%%%*/
                    $$ = $2;
                    /*% %*/
                    /*% ripper: mlhs_paren!($2) %*/
                }

// [!null]
f_arg           : f_arg_item {
                    /*%%%*/
                    $$ = new ArrayNode(p.src_line(), $1);
                    /*% %*/
                    /*% ripper[brace]: rb_ary_new3(1, get_value($1)) %*/
                }
                | f_arg ',' f_arg_item {
                    /*%%%*/
                    $1.add($3);
                    $$ = $1;
                    /*% %*/
                    /*% ripper: rb_ary_push($1, get_value($3)) %*/
                }

f_label 	: tLABEL {
                    p.formal_argument(@1.id, $1);
                    p.arg_var(@1.id);
                    p.setCurrentArg(p.get_id($1));
                    p.ordinalMaxNumParam();
                    p.getLexContext().in_argdef = false;
                    $$ = $1;
                }

// KeywordArgNode - [!null]
f_kw            : f_label arg_value {
                    p.setCurrentArg(null);
                    p.getLexContext().in_argdef = true;
                    /*%%%*/
                    $$ = new KeywordArgNode(@2.start(), p.assignableKeyword($1, $2));
                    /*%
                      $$ = p.new_assoc(p.assignable(@1.id, $1), $2);
                    %*/
                }
                | f_label {
                    p.setCurrentArg(null);
                    p.getLexContext().in_argdef = true;
                    /*%%%*/
                    $$ = new KeywordArgNode(p.src_line(), p.assignableKeyword($1, new RequiredKeywordArgumentValueNode()));
                    /*%
                      $$ = p.new_assoc(p.assignable(@1.id, $1), p.nil());
                    %*/
                }

f_block_kw      : f_label primary_value {
                    p.getLexContext().in_argdef = true;
                    /*%%%*/
                    $$ = new KeywordArgNode(@2.start(), p.assignableKeyword($1, $2));
                    /*%
                      $$ = p.new_assoc(p.assignable(@1.id, $1), $2);
                    %*/
                }
                | f_label {
                    p.getLexContext().in_argdef = true;
                    /*%%%*/
                    $$ = new KeywordArgNode(p.src_line(), p.assignableKeyword($1, new RequiredKeywordArgumentValueNode()));
                    /*%
                      $$ = p.new_assoc(p.assignable(@1.id, $1), p.fals());
                    %*/
                }
             

f_block_kwarg   : f_block_kw {
                    /*%%%*/
                    $$ = new ArrayNode(@1.start(), $1);
                    /*% %*/
                    /*% ripper: rb_ary_new3(1, get_value($1)) %*/
                }
                | f_block_kwarg ',' f_block_kw {
                    /*%%%*/
                    $$ = $1.add($3);
                    /*% %*/
                    /*% ripper: rb_ary_push($1, get_value($3)) %*/
                }

// ListNode - [!null]
f_kwarg         : f_kw {
                    /*%%%*/
                    $$ = new ArrayNode(@1.start(), $1);
                    /*% %*/
                    /*% ripper: rb_ary_new3(1, get_value($1)) %*/
                }
                | f_kwarg ',' f_kw {
                    /*%%%*/
                    $$ = $1.add($3);
                    /*% %*/
                    /*% ripper: rb_ary_push($1, get_value($3)) %*/
                }

kwrest_mark     : tPOW {
                    $$ = $1;
                }
                | tDSTAR {
                    $$ = $1;
                }

f_no_kwarg      : kwrest_mark keyword_nil {
                    /*%%%*/
                    $$ = $2;
                    /*% %*/
                    /*% ripper: nokw_param!(Qnil) %*/
                }

f_kwrest        : kwrest_mark tIDENTIFIER {
                    p.shadowing_lvar(@2.id);
                    /*%%%*/
                    $$ = $2;
                    /*% %*/
                    /*% ripper: kwrest_param!($2) %*/
                }
                | kwrest_mark {
                    /*%%%*/
                    $$ = p.INTERNAL_ID;
                    /*% %*/
                    /*% ripper: kwrest_param!(Qnil) %*/
                }

f_opt           : f_arg_asgn f_eq arg_value {
                    /*%%%*/
                    p.setCurrentArg(null);
                    p.getLexContext().in_argdef = true;
                    $$ = new OptArgNode(@3.start(), p.assignableLabelOrIdentifier($1.getName().getBytes(), $3));
                    /*%
                      $$ = p.new_assoc(p.assignable(@1.id, p.var_field($1)), $3);
                    %*/

                }

f_block_opt     : f_arg_asgn f_eq primary_value {
                    p.getLexContext().in_argdef = true;
                    p.setCurrentArg(null);
                    /*%%%*/
                    $$ = new OptArgNode(@3.start(), p.assignableLabelOrIdentifier($1.getName().getBytes(), $3));
                    /*%
                      $$ = p.new_assoc(p.assignable(@1.id, p.var_field($1)), $3);
                    %*/
                }

f_block_optarg  : f_block_opt {
                    /*%%%*/
                    $$ = new BlockNode(@1.start()).add($1);
                    /*% %*/
                    /*% ripper: rb_ary_new3(1, get_value($1)) %*/
                }
                | f_block_optarg ',' f_block_opt {
                    /*%%%*/
                    $$ = p.appendToBlock($1, $3);
                    /*% %*/
                    /*% ripper: rb_ary_push($1, get_value($3)) %*/
                }

f_optarg        : f_opt {
                    /*%%%*/
                    $$ = new BlockNode(@1.start()).add($1);
                    /*% %*/
                    /*% ripper: rb_ary_new3(1, get_value($1)) %*/
                }
                | f_optarg ',' f_opt {
                    /*%%%*/
                    $$ = p.appendToBlock($1, $3);
                    /*% %*/
                    /*% ripper: rb_ary_push($1, get_value($3)) %*/
                }

restarg_mark    : '*' {
                    $$ = STAR;
                }
                | tSTAR {
                    $$ = $1;
                }

// [!null]
f_rest_arg      : restarg_mark tIDENTIFIER {
                    if (!p.is_local_id(@2.id)) {
                        p.yyerror("rest argument must be local variable");
                    }
                    $$ = p.arg_var(p.shadowing_lvar(@2.id));
                    /*%%%*/
                    $$ = new RestArgNode($<ArgumentNode>$);
                    /*% %*/
                    /*% ripper: rest_param!($2) %*/
                }
                | restarg_mark {
                    /*%%%*/
                    $$ = new UnnamedRestArgNode(p.src_line(), p.symbolID(CommonByteLists.EMPTY), p.getCurrentScope().addVariable("*"));
                    /*% %*/
                    /*% ripper: rest_param!(Qnil) %*/
                }

// [!null]
blkarg_mark     : '&' {
                    $$ = AMPERSAND;
                }
                | tAMPER {
                    $$ = $1;
                }

// f_block_arg - Block argument def for function (foo(&block)) [!null]
f_block_arg     : blkarg_mark tIDENTIFIER {
                    if (!p.is_local_id(@2.id)) {
                        p.yyerror("block argument must be local variable");
                    }
                    $$ = p.arg_var(p.shadowing_lvar(@2.id));
                    /*%%%*/
                    $$ = new BlockArgNode($<ArgumentNode>$);
                    /*% %*/
                    /*% ripper: blockarg!($2) %*/
                }
                | blkarg_mark {
                    $$ = p.arg_var(p.shadowing_lvar(FWD_BLOCK));
                    /*%%%*/
                    $$ = new BlockArgNode($<ArgumentNode>$);
                    // Changed from MRI
                    /*% 
                        $$ = p.dispatch("on_blockarg", p.nil());
                    %*/
                }


opt_f_block_arg : ',' f_block_arg {
                    $$ = $2;
                }
                | {
                    $$ = null;
                }

singleton       : var_ref {
                    p.value_expr($1);
                    $$ = $1;
                }
                | '(' {
                    p.setState(EXPR_BEG);
                } expr rparen {
                    /*%%%*/
                    if ($3 == null) {
                        p.yyerror("can't define single method for ().");
                    } else if ($3 instanceof LiteralNode) {
                        p.yyerror("can't define single method for literals.");
                    }
                    p.value_expr($3);
                    $$ = $3;
                    /*% %*/
                    /*% ripper: paren!($3) %*/
                }

// HashNode: [!null]
assoc_list      : none {
                    /*%%%*/
                    $$ = new HashNode(p.src_line());
                    /*% %*/
                }
                | assocs trailer {
                    /*%%%*/
                    $$ = p.remove_duplicate_keys($1);
                    /*% %*/
                    /*% ripper: assoclist_from_args!($1) %*/
                }

// [!null]
assocs          : assoc {
                    /*%%%*/
                    $$ = new HashNode(p.src_line(), $1);
                    /*% %*/
                    /*% ripper[brace]: rb_ary_new3(1, get_value($1)) %*/
                }
                | assocs ',' assoc {
                    /*%%%*/
                    $$ = $1.add($3);
                    /*% %*/
                    /*% ripper: rb_ary_push($1, get_value($3)) %*/
                }

// Cons: [!null]
assoc           : arg_value tASSOC arg_value {
                    /*%%%*/
                    $$ = p.createKeyValue($1, $3);
                    /*% %*/
                    /*% ripper: assoc_new!($1, $3) %*/
                }
                | tLABEL arg_value {
                    /*%%%*/
                    Node label = p.asSymbol(@2.start(), $1);
                    $$ = p.createKeyValue(label, $2);
                    /*% %*/
                    /*% ripper: assoc_new!($1, $2) %*/
                }
                | tLABEL {
                    /*%%%*/
                    Node label = p.asSymbol(p.tokline(), $1);
                    Node var = p.gettable($1);
                    if (var == null) var = new BeginNode(p.tokline(), NilImplicitNode.NIL);
                    $$ = p.createKeyValue(label, var);
                    /*% %*/
                    /*% ripper: assoc_new!($1, Qnil) %*/
                }
 
                | tSTRING_BEG string_contents tLABEL_END arg_value {
                    /*%%%*/
                    if ($2 instanceof StrNode) {
                        DStrNode dnode = new DStrNode(@2.start(), p.getEncoding());
                        dnode.add($2);
                        $$ = p.createKeyValue(new DSymbolNode(@2.start(), dnode), $4);
                    } else if ($2 instanceof DStrNode) {
                        $$ = p.createKeyValue(new DSymbolNode(@2.start(), $<DStrNode>2), $4);
                    } else {
                        p.compile_error("Uknown type for assoc in strings: " + $2);
                    }
                    /*% %*/
                    /*% ripper: assoc_new!(dyna_symbol!($2), $4) %*/
                }
                | tDSTAR arg_value {
                    /*%%%*/
                    $$ = p.createKeyValue(null, $2);
                    /*% %*/
                    /*% ripper: assoc_splat!($2) %*/
                }

operation       : tIDENTIFIER {
                    $$ = $1;
                }
                | tCONSTANT {
                    $$ = $1;
                }
                | tFID {
                    $$ = $1;
                }
operation2      : tIDENTIFIER  {
                    $$ = $1;
                }
                | tCONSTANT {
                    $$ = $1;
                }
                | tFID {
                    $$ = $1;
                }
                | op {
                    $$ = $1;
                }
                    
operation3      : tIDENTIFIER {
                    $$ = $1;
                }
                | tFID {
                    $$ = $1;
                }
                | op {
                    $$ = $1;
                }
                    
dot_or_colon    : '.' {
                    $$ = p.maybe_symbolize(DOT);
                }
                | tCOLON2 {
                    $$ = $1;
                }

call_op 	: '.' {
                    $$ = p.maybe_symbolize(DOT);
                }
                | tANDDOT {
                    $$ = $1;
                }

call_op2        : call_op
                | tCOLON2 {
                    $$ = p.maybe_symbolize($1);
                }
  
opt_terms       : | terms
opt_nl          : | '\n'
rparen          : opt_nl ')' {
                    $$ = RPAREN;
                }
rbracket        : opt_nl ']' {
                    $$ = RBRACKET;
                }
rbrace          : opt_nl '}' {
                    $$ = RCURLY;
                }
trailer         : | '\n' | ','

term            : ';'
                | '\n'

terms           : term
                | terms ';'

none            : {
                      $$ = null;
                }

none_block_pass : {  
                  $$ = null;
                }

%%

}
