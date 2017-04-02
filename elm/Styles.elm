module Styles exposing (..)

import Css exposing (..)
import Css.Elements exposing (..)


white : Color
white =
    hex "FDFDFD"


grey : Color
grey =
    hex "CCC"


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
    , everything
        [ boxSizing borderBox
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
    , selector "input[type=text], input[type=email]"
        [ border3 (px 1) solid grey ]
    , selector "input[type=submit]"
        [ backgroundColor green
        , color white
        , height (squares 0.5)
        , padding (squares 0.2)
        , border zero
        , borderRadius zero
        ]
    ]


logoWidth =
    squares 4


headerAndNav : List Snippet
headerAndNav =
    let
        margin =
            squares 0.5

        restWidth =
            gridMaxWidth |-| logoWidth |-| margin

        masthead =
            class "logo"
                [ backgroundColor green
                , textAlign center
                , color white
                , fontWeight bold
                , padding2 (px 30) (px 60)
                , marginRight margin
                , width logoWidth
                ]

        navLinks =
            nav
                [ children
                    [ ul
                        [ listStyleType none
                        , padding zero
                        , displayFlex
                        , flexDirection row
                        , justifyContent flexEnd
                        , children
                            [ li
                                [ children
                                    [ a
                                        [ color white
                                        , hover [ color green ]
                                        , lineHeight (squares 0.5)
                                        ]
                                    ]
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
                , children
                    [ form
                        [ displayFlex
                        , marginBottom zero
                        , children
                            [ selector "input[type=email]"
                                [ width (pct 100) ]
                            ]
                        ]
                    ]
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
                [ class "content"
                    [ gridContainer
                    , displayFlex
                    , flexDirection row
                    , justifyContent spaceBetween
                    , height (squares 1.25)
                    , children
                        [ everything [ maxWidth restWidth ]
                        , masthead
                        , navLinks
                        ]
                    ]
                ]
            , withClass "home"
                [ backgroundImage (url "/images/header.png")
                , backgroundPosition bottom
                , paddingBottom (squares 1.5)
                , children
                    [ class "content"
                        [ flexDirection column
                        , flexWrap wrap
                        , height (squares 5.5)
                        , children
                            [ info
                            , class "logo"
                                [ displayFlex
                                , flexDirection columnReverse
                                , flexBasis (pct 100)
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ]


mainContent : List Snippet
mainContent =
    [ main_
        [ gridContainer ]
    ]


css : Stylesheet
css =
    (stylesheet << List.concat)
        [ setup
        , headerAndNav
        , mainContent
        ]
