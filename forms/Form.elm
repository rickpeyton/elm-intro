module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { name : String
    , age : String
    , password : String
    , passwordAgain : String
    }


model : Model
model =
    Model "" "" "" ""



-- UPDATE


type Msg
    = Name String
    | Age String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Age age ->
            { model | age = age }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "Name", onInput Name ] []
        , input
            [ type_ "text"
            , placeholder "Age"
            , onInput Age
            ]
            []
        , input
            [ type_ "password"
            , placeholder "Password"
            , onInput Password
            ]
            []
        , input
            [ type_ "password"
            , placeholder "Re-enter Password"
            , onInput PasswordAgain
            ]
            []
        , viewValidation model
        ]


viewValidation : Model -> Html msg
viewValidation model =
    let
        ( color, message ) =
            if model.password /= model.passwordAgain then
                ( "red", "Passwords do not match!" )
            else if String.length model.password < 8 then
                ( "red", "Passwords must be great than 8 characters!" )
            else if Result.withDefault 0 (String.toInt model.age) <= 0 then
                ( "red", "Age must be a number great than 0!" )
            else
                ( "green", "OK" )
    in
        div
            [ style
                [ ( "color"
                  , color
                  )
                ]
            ]
            [ text message
            ]
