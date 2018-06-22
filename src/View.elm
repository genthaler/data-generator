module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Model exposing (Model, Msg(..), DataType)
import View.Table


view : Model -> Html Msg
view model =
    div []
        [ text "Message"
        , text model.message
        , text "Row count"
        , input [ type_ "text", placeholder "How many rows?", onInput RowCount ] []
        , View.Table.view model.table
        ]
