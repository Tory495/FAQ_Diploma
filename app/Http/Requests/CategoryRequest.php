<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CategoryRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'title' => 'required|max:255',
            'strength' => 'required|integer',
        ];
    }

    public function messages()
    {
        return [
            'title.required' => 'Поле категория является обязательным',
            'strength.required' => 'Поле приоритет категории является обязательным',
            'title.max' => 'В поле категория превышено максимальное количество символов (255)',
            'strength.integer' => 'Приоритет должен быть целым числом',
        ];
    }
}
