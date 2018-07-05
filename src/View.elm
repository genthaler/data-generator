module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Model exposing (Model, Msg(..), DataType)
import View.Table
import Element exposing (..)
import Style exposing (..)
import Style.Color as Color
import Style.Font as Font


type MyStyles
    = None
    | Title
    | MyStyle
    | DataCellStyle


stylesheet =
    Style.styleSheet
        [ Style.style Title
            [ --      Color.text Color.darkGrey
              -- , Color.background Color.white
              -- ,
              Font.size 5 -- all units given as px
            ]
        ]



-- Element.layout renders the elements as html.
-- Every layout requires a stylesheet.


view : Model -> Html Msg
view model =
    Element.layout stylesheet <|
        -- An el is the most basic element, like a <div>
        Element.el MyStyle
            []
            (Element.text "hello!")
            div
            []
            [ el DataCellStyle [] [ Element.text "Message" ]
            , el [] [ Element.text model.message ]
            , el [] [ Element.text "Row count" ]
            , el [] [ input [ type_ "text", placeholder "How many rows?", onInput RowCount ] [] ]
            , el [] [ View.Table.view model.table ]
            ]
