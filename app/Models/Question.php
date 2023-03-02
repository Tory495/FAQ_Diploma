<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Question extends Model
{
    protected $fillable = ['category_id', 'question_text', 'answer_text', 'sender_info', 'like_count', 'status'];
}
