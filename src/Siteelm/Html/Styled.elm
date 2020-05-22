module Siteelm.Html.Styled exposing (body, dynamic, head, html, link, meta, script, title)

import Html.Styled exposing (Attribute, Html, div, node, text)
import Html.Styled.Attributes exposing (attribute)
import Siteelm.Html.Styled.Attributes exposing (data)


meta : List (Attribute msg) -> Html msg
meta attrs =
    node "meta" attrs []


link : List (Attribute msg) -> Html msg
link attrs =
    node "link" attrs []


script : String -> String -> Html msg
script src code =
    node "siteelm-custom" [ data "tag" "script", attribute "src" src ] [ text code ]


title : List (Attribute msg) -> String -> Html msg
title attrs s =
    node "title" attrs [ text s ]


head : List (Attribute msg) -> List (Html msg) -> Html msg
head attrs es =
    node "head" attrs es


html : List (Attribute msg) -> List (Html msg) -> Html msg
html attrs es =
    node "html" attrs es


body : List (Attribute msg) -> List (Html msg) -> Html msg
body attrs es =
    node "body" attrs es


dynamic : { moduleName : String, flags : String } -> Html msg
dynamic { moduleName, flags } =
    div
        [ data "elm-module" moduleName
        , data "flags" flags
        ]
        []
