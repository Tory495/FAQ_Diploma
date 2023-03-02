<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class QuestionRequest extends FormRequest
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
            'question_text' => 'required|max:1024',
            'answer_text' => 'max:4096',
            'category_id' => 'required|integer',
            'status' => 'integer',
            'like_count' => 'integer',
            'sender_info' => 'string',
            'recaptcha_token' => 'string',
        ];
    }

    public function messages()
    {
        return [
            'question_text.required' => 'Поле вопрос является обязательным',
            'question_text.max' => 'В поле вопрос превышено максимальное количество символов (1024)',
            'answer_text.max' => 'В поле ответ превышено максимальное количество символов (4096)',
        ];
    }
}
