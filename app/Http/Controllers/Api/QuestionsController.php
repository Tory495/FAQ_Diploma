<?php

namespace App\Http\Controllers\Api;

use App\Http\Requests\QuestionRequest;
use App\Http\Resources\QuestionResource;
use App\Models\Question;
use GuzzleHttp\Client;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Http\Response;

class QuestionsController extends Controller
{
    protected function checkRecaptcha($token, $ip)
    {
        $response = (new Client)->post('https://www.google.com/recaptcha/api/siteverify', [
            'form_params' => [
                'secret'   => config('recaptcha.secret'),
                'response' => $token,
                'remoteip' => $ip,
            ],
        ]);
        $response = json_decode((string)$response->getBody(), true);
        return $response['success'];
    }

    public function index()
    {
        return QuestionResource::collection(Question::all());
    }

    public function show(Question $question)
    {
        return new QuestionResource($question);
    }

    public function store(QuestionRequest $request)
    {
        if (config('recaptcha.enabled') && !$this->checkRecaptcha($request->recaptcha_token, $request->ip())) {
            return response()->json([
                'error' => 'Captcha is invalid.',
            ], Response::HTTP_BAD_REQUEST);
        }
        $new_question = Question::create($request->validated());
        return new QuestionResource($new_question);
    }

    public function update(QuestionRequest $request, Question $question)
    {
        $question->update($request->validated());
        return $question;
    }

    public function destroy(Question $question)
    {
        $question->delete();
        return response(null, Response::HTTP_NO_CONTENT);
    }

    public function search(Request $request)
    {
        if ($request->input('category_id') != 0 && $request->input('text') == "") {
            return QuestionResource::collection(Question::where('category_id', $request->input('category_id'))->get());
        }
        if ($request->input('category_id') != 0 && $request->input('text') != "") {
            return QuestionResource::collection(Question::where('category_id', $request->input('category_id'))->where('question_text', 'like', '%' . $request->input('text') . '%')->get());
        }
        if ($request->input('category_id') == 0 && $request->input('text') != "") {
            return QuestionResource::collection(Question::where('question_text', 'like', '%' . $request->input('text') . '%')->get());
        }
        return QuestionResource::collection(Question::all());
    }
}
