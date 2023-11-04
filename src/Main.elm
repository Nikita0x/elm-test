module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Html.Events exposing (onInput)
import Debug exposing (todo)


main = 
    Browser.sandbox { init = init, update = update, view = view}



-- MODEL
init : Model
init =
    { todoList = []
    , newTodo = "" 
    }

type alias Model =
    { todoList : List String
    , newTodo : String
    }



-- UPDATE

type Msg 
    = AddNewTodo
    | UpdateNewTodo String
    | DeleteTodo Int

update : Msg -> Model -> Model
update msg model =
    case msg of
        AddNewTodo ->
            { model | todoList = model.todoList ++ [model.newTodo], newTodo = ""}

        UpdateNewTodo newText ->
            { model | newTodo = newText }

        DeleteTodo index ->
            { model | todoList = List.take index model.todoList ++ List.drop (index + 1) model.todoList }


-- VIEW
todoToLi : Int -> String -> Html Msg
todoToLi index todo =
    li [] [ text todo, button [ onClick (DeleteTodo index)] [ text "Delete"]]


view : Model -> Html Msg
view model =
    div []
        [ input
            [ type_ "text" 
            , value model.newTodo
            , onInput (\newText -> UpdateNewTodo newText)
            ]
            []
        , button [ onClick AddNewTodo, class "button"] [ text "Add Todo" ]
        , ul [] (List.indexedMap (\index todo -> todoToLi index todo) model.todoList)
        ]
