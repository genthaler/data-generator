module Model exposing (Model, init, Msg(..), DataType, dataTypeEnum, defaultDataType)

{-| In this datatye, the table is a List of Lists, where each List is non-empty;
that is, the smallest it can get is a 1x1 table.
We need to keep the width of the table and the length of the columnTypes list consistent.
-}

import Model.Table exposing (..)
import Model.Enum exposing (..)


type alias Model =
    { table : Table DataType String
    , message : String
    }


init : Model
init =
    { table = Model.Table.init Text ""
    , message = ""
    }


type DataType
    = Text
    | Date
    | Email
    | Address
    | Postcode
    | State
    | Gender


dataTypeEnum : Enum DataType
dataTypeEnum =
    { values =
        [ Text
        , Date
        , Email
        , Address
        , Postcode
        , State
        , Gender
        ]
    , toString = Basics.toString
    }


defaultDataType : DataType
defaultDataType =
    Text


type Msg
    = NoOp
    | RowCount String
    | SetDataType Int DataType
    | Regenerate
