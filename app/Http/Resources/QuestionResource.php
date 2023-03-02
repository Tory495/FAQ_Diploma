<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class QuestionResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param \Illuminate\Http\Request $request
     * @return array
     */
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'category_id' => $this->category_id,
            'question_text' => $this->question_text,
            'answer_text' => $this->answer_text,
            'sender_info' => $this->sender_info,
            'like_count' => $this->like_count,
            'status' => $this->status,
            'created_at' => $this->created_at,
        ];
    }
}
