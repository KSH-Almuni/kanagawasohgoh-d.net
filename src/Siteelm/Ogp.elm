module Siteelm.Ogp exposing (description, image, locale, siteName, title, twitterCard, twitterSite, type_, url)

import Html.Styled exposing (Html)
import Html.Styled.Attributes exposing (name)
import Siteelm.Html.Styled exposing (meta)
import Siteelm.Html.Styled.Attributes as Attributes



-- BASIC METADATA


og : String -> String -> Html msg
og p c =
    meta
        [ Attributes.property p
        , Attributes.content c
        ]


image : String -> Html msg
image str =
    og "og:image" str


title : String -> Html msg
title str =
    og "og:title" str


type_ : String -> Html msg
type_ str =
    og "og:type" str


url : String -> Html msg
url str =
    og "og:url" str



-- OPTIONAL METADATA


description : String -> Html msg
description str =
    og "og:description" str


locale : String -> Html msg
locale str =
    og "og:locale" str


siteName : String -> Html msg
siteName str =
    og "og:site_name" str



-- TWITTER


twitter_ : String -> String -> Html msg
twitter_ n c =
    meta
        [ name n
        , Attributes.content c
        ]


twitterCard : String -> Html msg
twitterCard str =
    twitter_ "twitter:card" str


twitterSite : String -> Html msg
twitterSite str =
    twitter_ "twitter:site" str
