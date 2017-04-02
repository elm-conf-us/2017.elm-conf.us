module Styles exposing (..)

import Css exposing (..)
import Css.Elements exposing (..)


white : Color
white =
    hex "FDFDFD"


green : Color
green =
    hex "7EBC42"


black : Color
black =
    hex "444548"


gridSquare : Px
gridSquare =
    px 100


squares : Float -> Px
squares n =
    gridSquare |*| (px n)


gridMaxWidth : Px
gridMaxWidth =
    squares 12


gridContainer : Mixin
gridContainer =
    mixin
        [ maxWidth gridMaxWidth
        , margin2 zero auto
        ]


setup : List Snippet
setup =
    [ body
        [ fontFamilies [ "Roboto", .value sansSerif ]
        , fontSize (Css.pt 14)
        , color black
        , backgroundColor white
        , lineHeight <| squares 0.33
        ]
    , each [ h1, h2, h3, h4, h5, h6 ]
        [ fontFamilies [ "Roboto Condensed", .value sansSerif ]
        , fontWeight bold
        ]
    , a
        [ color green
        , textDecoration none
        ]
    , selector "input[type=text], input[type=email], input[type=submit]"
        [ backgroundColor white
        , height (squares 0.5)
        , padding (squares 0.2)
        , border zero
        , borderRadius zero
        , lineHeight zero
        ]
    , selector "input[type=submit]"
        [ backgroundColor green
        , color white
        , height (squares 0.5)
        , padding (squares 0.2)
        , border zero
        , borderRadius zero
        ]
    ]


headerAndNav : List Snippet
headerAndNav =
    let
        masthead =
            class "logo"
                [ backgroundColor green
                , textAlign center
                , color white
                , fontWeight bold
                , padding2 (px 30) (px 60)
                , marginRight (squares 0.5)
                ]

        navLinks =
            ul
                [ listStyleType none
                , padding zero
                , children
                    [ li
                        [ children
                            [ a
                                [ color white
                                , hover [ color green ]
                                ]
                            ]
                        ]
                    ]
                ]

        info =
            class "info"
                [ flexDirection column
                , property "text-align" "justify"
                , alignSelf flexEnd
                ]
    in
        [ header
            [ width (pct 100)
            , color white
            , backgroundImage (url "/images/header-short.png")
            , backgroundSize cover
            , backgroundPosition2 (pct 50) (px -30)
            , backgroundColor white
            , backgroundRepeat noRepeat
            , children
                [ nav
                    [ gridContainer
                    , displayFlex
                    , flexDirection row
                    , justifyContent spaceBetween
                    , children
                        [ masthead
                        , navLinks
                        ]
                    ]
                ]
            , withClass "home"
                [ backgroundImage (url "/images/header.png")
                , backgroundPosition bottom
                , paddingBottom <| squares 2
                , flexDirection column
                , descendants
                    [ class "logo"
                        [ paddingTop <| squares 2.5 ]
                    , info
                    ]
                ]
            ]
        ]


css =
    (stylesheet << List.concat)
        [ setup
        , headerAndNav
        ]
