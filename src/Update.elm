module Update exposing (..)

import Model exposing (Model, Msg(..))
import Model.Table


init : ( Model, Cmd Msg )
init =
    ( Model.init, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RowCount rowCountString ->
            case
                String.toInt rowCountString
                    |> Result.andThen
                        (\rowCount -> Model.Table.setRowCount rowCount "" model.table)
            of
                Err msg ->
                    ( { model | message = msg }, Cmd.none )

                Ok table ->
                    ( { model | table = table }, Cmd.none )

        SetDataType index dataType ->
            { model
                | table =
                    Model.Table.populateColumn (always "zzz") index model.table
            }
                ! []

        Regenerate ->
            ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )
