<?php

namespace App\Http\Controllers\Api;

use App\Http\Requests\CategoryRequest;
use App\Http\Resources\CategoryResource;
use App\Models\Category;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Http\Response;

class CategoriesController extends Controller
{
    public function index()
    {
        return CategoryResource::collection(Category::orderBy('strength', 'desc')->get());
    }

    public function show(Category $category)
    {
        return new CategoryResource($category);
    }

    public function store(CategoryRequest $request)
    {
        $new_category = Category::create($request->validated());
        return new CategoryResource($new_category);
    }

    public function update(CategoryRequest $request, Category $category)
    {
        $category->update($request->validated());
        return $category;
    }

    public function destroy(Category $category)
    {
        $category->delete();
        return response(null, Response::HTTP_NO_CONTENT);
    }
}
