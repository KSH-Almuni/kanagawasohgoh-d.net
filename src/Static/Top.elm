module Static.Top exposing (main)

import Color.Palette exposing (button, buttonOnHover)
import Css exposing (..)
import Css.Extra exposing (orNoStyle, palette)
import Css.Media as Media exposing (only, screen, withMedia)
import DateFormat exposing (dayOfMonthSuffix, format, monthNameFull, yearNumber)
import Html.Styled exposing (Html, a, h1, li, main_, section, span, text, ul)
import Html.Styled.Attributes as Attributes exposing (css, href, rel)
import Iso8601
import Json.Decode as D exposing (Decoder)
import Siteelm.Html.Styled as Html
import Siteelm.Page exposing (Page, page)
import Static.View exposing (siteFooter, siteHeader)
import Time exposing (Posix, Zone)


main : Page Preamble
main =
    page
        { decoder = preambleDecoder
        , head = viewHead
        , body = viewBody
        }


{-| Preamble is what you write on the head of the content files.
-}
type alias Preamble =
    { title : String
    , articles : List Article
    }


type alias Article =
    { url : String
    , title : String
    , createdAt : Posix

    -- Result (List DeadEnd) Posix
    }


{-| Preamble is passed as a JSON string. So it requires a decoder.
-}
preambleDecoder : Decoder Preamble
preambleDecoder =
    D.map2 Preamble
        (D.field "title" D.string)
        (D.field "articles" (D.list articleDecoder))


articleDecoder : Decoder Article
articleDecoder =
    D.map3 Article
        (D.field "url" D.string)
        (D.field "title" D.string)
        (D.field "createdAt" Iso8601.decoder)


{-| Make contents inside the _head_ tag.
-}
viewHead : Preamble -> String -> List (Html Never)
viewHead _ _ =
    [ Html.title [] "神奈川総合高校同窓会"
    ]


{-| Make contents inside the _body_ tag. The parameter "body" is usually something like markdown.
-}
viewBody : Preamble -> String -> List (Html Never)
viewBody preamble _ =
    [ siteHeader
    , main_ []
        [ topSection
            { title = "Blog posts"
            , children =
                [ ul [] <|
                    List.map
                        (\{ title, createdAt, url } ->
                            linkView
                                { title = title
                                , sub = dateString Time.utc createdAt
                                , url = url
                                }
                        )
                        (preamble.articles |> List.sortBy (.createdAt >> Iso8601.fromTime) |> List.reverse)
                ]
            }
        ]
    , siteFooter
    ]


topSection : { title : String, children : List (Html Never) } -> Html Never
topSection { title, children } =
    section
        [ css
            [ width (px 620)
            , margin2 zero auto
            , padding2 (px 25) zero
            , withMedia [ only screen [ Media.maxWidth (px 480) ] ]
                [ width (pct 100)
                , padding (px 15)
                ]
            ]
        ]
        (h1
            [ css
                [ paddingBottom (px 10)
                , fontFamilies [ qt "Saira", sansSerif.value ]
                , fontSize (px 16)
                , fontWeight (int 500)
                , lineHeight (int 1)
                ]
            ]
            [ text title ]
            :: children
        )


linkView :
    { title : String
    , sub : String
    , url : String
    }
    -> Html Never
linkView { title, sub, url } =
    li
        [ css
            [ listStyle none
            , nthChild "n+2"
                [ marginTop (px 5) ]
            ]
        ]
        [ a
            [ href url
            , Attributes.target <|
                case String.left 1 url of
                    "/" ->
                        "_self"

                    _ ->
                        "_blank"
            , rel <|
                case String.left 1 url of
                    "/" ->
                        ""

                    _ ->
                        "noopener"
            , css
                [ display block
                , padding (px 20)
                , withMedia [ only screen [ Media.maxWidth (px 480) ] ]
                    [ padding (px 15) ]
                , textDecoration none
                , borderRadius (px 10)
                , palette button
                , hover
                    [ palette buttonOnHover ]
                ]
            ]
            [ h1
                [ css
                    [ fontSize (px 16)
                    , fontWeight (int 600)
                    , lineHeight (num 1.5)
                    ]
                ]
                [ text title ]
            , span
                [ css
                    [ fontSize (px 13)
                    , lineHeight (int 1)
                    , color |> orNoStyle button.optionalColor
                    ]
                ]
                [ text sub ]
            ]
        ]


dateString : Zone -> Posix -> String
dateString =
    format
        [ monthNameFull
        , DateFormat.text " "
        , dayOfMonthSuffix
        , DateFormat.text ", "
        , yearNumber
        ]
