module View.Table exposing (view)

import Html
import Model exposing (Model, Msg(..), DataType, dataTypeEnum, defaultDataType)
import Model.Table as Table
import Model.Enum as Enum


view : Table.Table DataType String -> Html.Html Msg
view table =
    let
        columns =
            Table.getColumns table

        rows =
            Table.getRows table

        renderPlusTd =
            Html.td
                []
                [ Html.text "+" ]
    in
        Html.table
            []
            [ columns
                |> List.indexedMap
                    (\index dataType ->
                        Enum.enumSelect
                            dataTypeEnum
                            (Enum.findEnumValue dataTypeEnum
                                >> Maybe.withDefault Model.defaultDataType
                                >> (SetDataType index)
                            )
                            dataType
                            |> List.singleton
                            |> Html.td []
                    )
                |> Html.tr []
                |> List.singleton
                |> Html.thead []
            , rows
                |> List.map
                    ((Html.tr [])
                        << (List.map
                                (Html.td []
                                    << List.singleton
                                    << Html.text
                                )
                           )
                    )
                |> Html.tbody []
            , columns
                |> List.indexedMap
                    (\index dataType ->
                        Enum.enumSelect
                            dataTypeEnum
                            (Enum.findEnumValue dataTypeEnum
                                >> Maybe.withDefault Model.defaultDataType
                                >> (SetDataType index)
                            )
                            dataType
                            |> List.singleton
                            |> Html.td []
                    )
                |> Html.tr []
                |> List.singleton
                |> Html.tfoot []
            ]
