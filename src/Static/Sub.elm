module Static.Sub exposing (main)

import Color.Palette as Palette
import Css exposing (..)
import Css.Extra exposing (orNoStyle)
import Css.Global exposing (children)
import Css.Media as Media exposing (only, screen, withMedia)
import DateFormat exposing (dayOfMonthSuffix, format, monthNameFull, yearNumber)
import Html.Styled exposing (Html, div, fromUnstyled, h1, header, i, main_, p, text)
import Html.Styled.Attributes exposing (class, css, href, name)
import Iso8601
import Json.Decode as D exposing (Decoder)
import Markdown
import Siteelm.Html.Styled as Html
import Siteelm.Html.Styled.Attributes as Attributes exposing (rel)
import Siteelm.Ogp as Ogp
import Siteelm.Page exposing (Page, page)
import Static.View exposing (siteFooter, siteHeader, viewArticle)
import Time exposing (Posix, Zone)
import Url.Builder exposing (crossOrigin)


main : Page Preamble
main =
    page
        { decoder = preambleDecoder
        , head = viewHead
        , body = viewBody
        }


type alias Preamble =
    { title : String
    , createdAt : Posix
    }


preambleDecoder : Decoder Preamble
preambleDecoder =
    D.map2 Preamble
        (D.field "title" D.string)
        (D.field "createdAt" Iso8601.decoder)


viewHead : Preamble -> String -> List (Html Never)
viewHead preamble _ =
    let
        siteName =
            "神奈川総合高校同窓会"

        siteUrl =
            "https://kanagawasohgoh-d.net/"

        description =
            "同窓会からのお知らせを発信してまいります"

        imageUrl =
            crossOrigin siteUrl [ "M3fRFrmf.jpg" ] []
    in
    [ Html.title [] (String.join " | " [ preamble.title, siteName ])
    , Html.link [ rel "canonical", href siteUrl ]
    , Html.meta [ name "description", Attributes.content description ]
    , Ogp.title preamble.title
    , Ogp.type_ "article"
    , Ogp.url siteUrl
    , Ogp.image imageUrl
    , Ogp.siteName siteName
    , Ogp.description description
    , Ogp.locale "ja_JP"
    , Ogp.twitterCard "summary"
    , Ogp.twitterSite "@kdnweb"
    , Html.script "https://kit.fontawesome.com/a26b6242ff.js" ""
    ]


viewBody : Preamble -> String -> List (Html Never)
viewBody preamble body =
    [ siteHeader
    , main_
        [ css
            [ width (px 620)
            , margin2 zero auto
            , padding2 (px 20) zero
            , withMedia [ only screen [ Media.maxWidth (px 480) ] ]
                [ width (pct 100)
                , padding (px 15)
                ]
            ]
        ]
        [ header []
            [ h1
                [ css
                    [ padding2 (px 5) zero
                    , fontFamilies [ qt "-apple-system", sansSerif.value ]
                    , fontSize (px 24)
                    , fontWeight (int 600)
                    ]
                ]
                [ text preamble.title ]
            , div
                [ css
                    [ color |> orNoStyle Palette.default.optionalColor
                    , children
                        [ Css.Global.p
                            [ padding2 (px 5) zero
                            , fontSize (px 14)
                            , lineHeight (int 1)
                            ]
                        ]
                    ]
                ]
                [ p []
                    [ i [ class "fas fa-edit" ] []
                    , text " "
                    , text (dateString Time.utc preamble.createdAt)
                    ]
                ]
            ]
        , viewArticle []
            [ fromUnstyled <|
                Markdown.toHtmlWith markdownOptions [] body
            ]
        ]
    , siteFooter
    ]


markdownOptions : Markdown.Options
markdownOptions =
    { githubFlavored = Just { tables = True, breaks = False }
    , defaultHighlighting = Nothing
    , sanitize = False
    , smartypants = False
    }


dateString : Zone -> Posix -> String
dateString =
    format
        [ monthNameFull
        , DateFormat.text " "
        , dayOfMonthSuffix
        , DateFormat.text ", "
        , yearNumber
        ]
