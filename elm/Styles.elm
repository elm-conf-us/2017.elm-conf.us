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
                , paddingBottom (squares 2)
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
        [ gridContainer
        , marginTop (squares 1)
        , children
            [ article
                [ after
                    [ display block
                    , height zero
                    , property "visibility" "hidden"
                    , property "content" "\"\""
                    , property "clear" "both"
                    ]
                , children
                    [ class "siteImage"
                        [ width (logoWidth |*| (px 0.8))
                        , margin2 zero (logoWidth |*| (px 0.1))
                        , borderRadius logoWidth
                        , float left
                        , property "filter" "grayscale()"
                        ]
                    ]
                ]
            ]
        , withClass "home"
            [ marginTop zero
            , children
                [ article
                    [ firstChild
                        [ children
                            [ h1
                                [ width logoWidth
                                , textAlign center
                                , marginTop <| (squares 1) |*| (px -1)
                                , backgroundColor white
                                , height (squares 1)
                                , paddingTop (squares 0.25)
                                , paddingLeft (squares 0.25)
                                , paddingRight (squares 0.25)
                                , fontSize (Css.em 1.7)
                                , lineHeight (Css.em 1.2)
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ]
    ]


footerContent : List Snippet
footerContent =
    [ footer
        [ backgroundImage <| url "/images/footer_lodyas.png"
        , marginTop <| squares 1
        , paddingTop <| squares 1
        , paddingBottom <| squares 0.75
        , color white
        , children
            [ class "content"
                [ gridContainer
                , displayFlex
                , flexDirection row
                , children
                    [ everything
                        [ flex (int 1)
                        , marginRight (squares 0.5)
                        , lastChild [ marginRight zero ]
                        ]
                    ]
                , descendants
                    [ input
                        [ display block
                        , marginBottom (px 20)
                        , lastChild [ marginBottom zero ]
                        ]
                    ]
                ]
            ]
        ]
    ]


css : Stylesheet
css =
    (stylesheet << List.concat)
        [ setup
        , headerAndNav
        , mainContent
        , footerContent
        ]
