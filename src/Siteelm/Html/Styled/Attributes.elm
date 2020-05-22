module Siteelm.Html.Styled.Attributes exposing (charset, content, data, prefix, property, rel, role)

import Html.Styled exposing (Attribute)
import Html.Styled.Attributes exposing (attribute)


charset : String -> Attribute msg
charset =
    attribute "charset"


content : String -> Attribute msg
content =
    attribute "content"


prefix : String -> Attribute msg
prefix =
    attribute "prefix"


property : String -> Attribute msg
property =
    attribute "property"


rel : String -> Attribute msg
rel =
    attribute "rel"


role : String -> Attribute msg
role =
    attribute "role"


data : String -> String -> Attribute msg
data name value =
    attribute (String.join "-" [ "data", name ]) value
