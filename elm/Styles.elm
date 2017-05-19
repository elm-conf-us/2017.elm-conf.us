module Styles exposing (..)

import Css exposing (..)
import Css.Elements exposing (..)


white : Color
white =
    hex "FDFDFD"


grey : Color
grey =
    hex "CCC"


darkGrey : Color
darkGrey =
    hex "666"


green : Color
green =
    hex "7EBC42"


black : Color
black =
    hex "444548"



-- grid


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



-- media


tablet : List Snippet -> Snippet
tablet =
    mediaQuery <| "screen and (min-width: 768px)"


desktop : List Snippet -> Snippet
desktop =
    mediaQuery <| "screen and (min-width: 1200px)"



-- sections


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
    , blockquote
        [ borderLeft3 (px 2) solid grey
        , color darkGrey
        , marginLeft zero
        , paddingLeft (px 20)
        ]
    ]


logoWidth =
    squares 4


headerAndNav : List Snippet
headerAndNav =
    let
        margin =
            squares 1

        restWidth =
            gridMaxWidth |-| logoWidth |-| margin

        masthead =
            class "logo"
                [ backgroundColor green
                , textAlign center
                , color white
                , fontWeight bold
                , padding2 (px 30) (px 60)
                , width logoWidth
                , children
                    [ desktop
                        [ class "logo"
                            [ flexBasis (pct 100)
                            , displayFlex
                            , flexDirection columnReverse
                            , marginRight <| margin
                            ]
                        ]
                    ]
                ]

        navLinks =
            nav
                [ children
                    [ ul
                        [ listStyleType none
                        , padding zero
                        , displayFlex
                        , flexDirection column
                        , justifyContent flexEnd
                        , children
                            [ li
                                [ textAlign center
                                , children
                                    [ a
                                        [ color white
                                        , hover [ color green ]
                                        , lineHeight (squares 0.5)
                                        , paddingLeft (squares 0.25)
                                        , paddingRight (squares 0.25)
                                        ]
                                    ]
                                , withClass "callout"
                                    [ border3 (px 1) solid white
                                    ]
                                ]
                            ]
                        ]
                    , tablet
                        [ selector "header nav > ul"
                            [ flexDirection row |> important
                            , children
                                [ li
                                    [ marginRight (squares 0.25)
                                    , lastChild [ marginRight zero ]
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
            [ backgroundImage <| url "/images/footer_lodyas.png"
            , color white
            , withClass "home" [ paddingBottom (squares 1) ]
            , children
                [ class "content"
                    [ gridContainer
                    , displayFlex
                    , flexDirection column
                    , alignItems center
                    , justifyContent spaceBetween
                    , children
                        [ masthead
                        , navLinks
                        , info
                        , everything
                            [ maxWidth (pct 80)
                            , margin2 zero auto
                            ]
                        ]
                    ]
                ]
            ]
        , tablet
            [ header
                [ backgroundImage (url "/images/header.png")
                , backgroundSize cover
                , backgroundPosition bottom
                , backgroundRepeat noRepeat
                ]
            ]
        , desktop
            [ header
                [ backgroundImage (url "/images/header-short.png")
                , backgroundSize cover
                , backgroundPosition2 (pct 50) (px -30)
                , flexDirection row
                , children
                    [ class "content"
                        [ flexWrap wrap
                        , flexDirection column
                        , alignItems flexStart
                        , height <| squares 1.25
                        , children
                            [ everything
                                [ width restWidth
                                , Css.margin zero
                                ]
                            ]
                        ]
                    ]
                , withClass "home"
                    [ backgroundImage (url "/images/header.png")
                    , backgroundPosition bottom
                    , children
                        [ class "content"
                            [ height <| squares 5
                            , marginBottom margin
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
        , marginTop <| squares 1
        , padding2 zero (squares 0.25)
        , descendants
            [ article
                [ after
                    [ display block
                    , height zero
                    , property "visibility" "hidden"
                    , property "content" "\"\""
                    , property "clear" "both"
                    ]
                , adjacentSiblings
                    [ article
                        [ marginTop <| squares 0.5
                        , paddingTop <| squares 0.5
                        , borderTop3 (px 1) solid grey
                        ]
                    ]
                , children
                    [ class "calloutImage"
                        [ borderRadius logoWidth
                        , property "filter" "grayscale()"
                        , display block
                        , width (pct 80)
                        , margin2 zero auto
                        , maxWidth <| logoWidth |*| (px 0.8)
                        , children
                            [ desktop
                                [ class "calloutImage"
                                    [ float left
                                    , important <| width <| logoWidth |*| (px 0.8)
                                    , important <| margin2 zero (logoWidth |*| (px 0.1))
                                    ]
                                ]
                            ]
                        ]
                    , class "logo-sponsor"
                        [ display block
                        , maxWidth logoWidth
                        , margin2 zero auto
                        , children
                            [ desktop
                                [ class "logo-sponsor"
                                    [ float left
                                    , marginLeft zero
                                    , important <| marginRight <| logoWidth |*| (px 0.1)
                                    ]
                                ]
                            ]
                        ]
                    ]
                ]
            , section
                [ children
                    [ h2
                        [ withClass "level"
                            [ marginBottom <| squares 0.5
                            , marginTop <| squares 0.5
                            ]
                        ]
                    ]
                ]
            ]
        , children
            [ desktop
                [ selector "main.home"
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
        ]
    , desktop [ main_ [ padding zero ] ]
    ]


sponsorBlock : List Snippet
sponsorBlock =
    [ id "sponsors"
        [ paddingTop <| squares 0.5
        , marginTop <| squares 0.5
        , borderTop3 (px 1) solid grey
        , children
            [ ul
                [ listStyleType none
                , paddingLeft zero
                , width (pct 100)
                , displayFlex
                , flexWrap wrap
                , flexDirection row
                , justifyContent center
                , alignItems center
                , children
                    [ li
                        [ descendants
                            [ img
                                [ width <| squares 3
                                , margin <| squares 0.5
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
                , flexDirection column
                , padding2 zero (squares 0.25)
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
            , tablet
                [ selector "footer > .content"
                    [ flexDirection row
                    , padding zero
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
        , sponsorBlock
        , footerContent
        ]
