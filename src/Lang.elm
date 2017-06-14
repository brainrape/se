module Lang exposing (..)

import DictList exposing (DictList)


type alias TypName =
    String


type alias ModuleName =
    String


type alias FieldName =
    String


type alias ConsName =
    String


type alias Module =
    { name : ModuleName
    , imports : List ModuleName
    , types : DictList TypName TypDef
    , aliases : DictList TypName Typ
    , bindings : Bindings
    }


init_module : Module
init_module =
    { name = "Unnamed"
    , imports = []
    , types = DictList.empty
    , aliases = DictList.empty
    , bindings = DictList.empty
    }


type alias TypDef =
    List ( ConsName, List Typ )


type Typ
    = TCons QualifiedName (List Typ)
    | TArrow Typ Typ
    | TRecord (DictList String Typ)
    | TVar String


type alias QualifiedName =
    ( Maybe String, String )


type alias Bindings =
    DictList FieldName ( Maybe Typ, Exp )


type Exp
    = Apply Exp Exp
    | Let Bindings Exp
    | Lam FieldName Exp
    | Var QualifiedName
    | Lit Literal
    | Tup (List Exp)
    | Case Exp (List ( Pattern, Exp ))
    | Record Bindings



--| Field FieldName


type Pattern
    = PCons QualifiedName (List Pattern)
    | PRecord (List String)
    | PVar QualifiedName
    | PLit Literal
    | PTup (List Pattern)


type Literal
    = String String
    | Char Char
    | Int Int
    | Float Float


type Focus
    = FTypApplyFun
    | FTypApplyArg
    | FTypArrowArg
    | FTypArrowResult
    | FTypName
    | FLetBindings
    | FLetExp
    | FBindingName Int
    | FBindingTyp Int
    | FBindingValue Int
    | FLamArg
    | FLamExp
    | FApplyFun
    | FApplyArg
    | FCaseExp
    | FCasePattern Int
    | FCaseResult Int
    | FRecordKey String
    | FRecordValue String
    | FTup Int
    | FPoint