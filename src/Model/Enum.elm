module Model.Enum exposing (..)

import Json.Decode as Decode
import Html
import Html.Attributes
import Html.Events


{-| This module is from <https://discourse.elm-lang.org/t/how-to-do-enums-in-elm/1353> and related comments
-}
type alias Enum a =
    { values : List a
    , toString : a -> String
    }


findEnumValue : Enum a -> String -> Maybe a
findEnumValue enum value =
    enum.values
        |> List.filter ((==) value << enum.toString)
        |> List.head


decodeEnumValue : Enum a -> String -> Decode.Decoder a
decodeEnumValue enum stringValue =
    case findEnumValue enum stringValue of
        Just value ->
            Decode.succeed value

        Nothing ->
            Decode.fail <| "Could not decode value to enum: " ++ stringValue


onEnumInput : Enum a -> (a -> msg) -> Html.Attribute msg
onEnumInput enum tagger =
    let
        decodeTargetValue =
            Html.Events.targetValue
                |> Decode.andThen (decodeEnumValue enum)
                |> Decode.map tagger
    in
        Html.Events.on "input" decodeTargetValue


enumOption : Enum a -> a -> a -> Html.Html msg
enumOption enum selectedValue value =
    Html.option [ Html.Attributes.selected (selectedValue == value) ] [ Html.text <| enum.toString value ]


enumSelect : Enum a -> (String -> msg) -> a -> Html.Html msg
enumSelect enum msg selectedValue =
    Html.select [ Html.Events.onInput msg ]
        (List.map (enumOption enum selectedValue) enum.values)
