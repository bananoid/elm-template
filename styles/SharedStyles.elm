module SharedStyles exposing (..)

import Css exposing (..)
import Css.Elements exposing (body, li)
import Css.Namespace exposing (namespace)


css : Stylesheet
css =
    (stylesheet << namespace "sharedStyles")
        [ body
            [ backgroundColor (hex "#ffdd00") ]
        ]
