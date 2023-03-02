<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

//Route::get('/questions', 'Api\QuestionsController@index');
//
//Route::get('/categories', 'Api\CategoriesController@index');
//
//Route::get('/categories/{categoryId}', 'Api\CategoriesController@show');
//
//Route::post('/categories/update/{category}', 'Api\CategoriesController@update');

Route::apiResources([
    'questions' => Api\QuestionsController::class,
    'categories' => Api\CategoriesController::class,
]);

Route::post('/questions/search', 'Api\QuestionsController@search');
