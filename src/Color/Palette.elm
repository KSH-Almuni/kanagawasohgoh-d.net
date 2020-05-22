module Color.Palette exposing (Palette, button, buttonOnHover, default, textLink, textLinkVisited)

import Color exposing (coolGray040, coolGray050, coolGray090, coolGray095, gray020, limeGreen020, limeGreen040)
import Css exposing (Color)


type alias Palette =
    { background : Maybe Color
    , color : Maybe Color
    , optionalColor : Maybe Color
    , border : Maybe Color
    , shadow : Maybe Color
    }


empty : Palette
empty =
    { background = Nothing
    , color = Nothing
    , optionalColor = Nothing
    , border = Nothing
    , shadow = Nothing
    }


default : Palette
default =
    { empty
        | color = gray020
        , optionalColor = coolGray050
    }


textLink : Palette
textLink =
    { empty | color = limeGreen040 }


textLinkVisited : Palette
textLinkVisited =
    { textLink | color = limeGreen020 }


button : Palette
button =
    { default
        | background = coolGray095
        , optionalColor = coolGray040
    }


buttonOnHover : Palette
buttonOnHover =
    { button | background = coolGray090 }
