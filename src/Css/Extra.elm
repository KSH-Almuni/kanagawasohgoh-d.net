module Css.Extra exposing (orNoStyle, palette)

import Color.Palette exposing (Palette)
import Css exposing (Style, backgroundColor, batch, borderColor, color)


orNoStyle : Maybe a -> (a -> Style) -> Style
orNoStyle maybe property =
    maybe
        |> Maybe.map (\v -> [ property v ])
        |> Maybe.withDefault []
        |> batch


palette : Palette -> Style
palette p =
    batch
        [ backgroundColor |> orNoStyle p.background
        , color |> orNoStyle p.color
        , borderColor |> orNoStyle p.border
        ]
