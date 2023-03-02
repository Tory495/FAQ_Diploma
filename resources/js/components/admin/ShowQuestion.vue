<template>
    <div class="container">
        <div class="form-group">
            <label for="categorySelect">Категория</label>
            <div class="input-group mb-3">
                <select class="form-select" id="categorySelect" v-model="question.category_id"
                        :class="{ 'is-invalid': $v.question.category_id.$error }">
                    <option v-for="category in categories" :value="category.id">{{ category.title }}</option>
                </select>
            </div>
            <label>Текст вопроса</label>
            <div class="input-group mb-3">
                <textarea class="form-control" v-model="question.question_text"
                          :class="{ 'is-invalid': $v.question.question_text.$error }"></textarea>
                <!-- Валидация текста вопроса -->
                <div class="invalid-feedback" v-if="!$v.question.question_text.required">
                    Обязательное поле.
                </div>
                <div class="invalid-feedback" v-if="!$v.question.question_text.maxLength">
                    Макс. количество символов: {{ $v.question.question_text.$params.maxLength.max }}.
                </div>
            </div>
            <label>Текст ответа</label>
            <div class="input-group mb-3">
                <textarea class="form-control" v-model="question.answer_text"
                          :class="{ 'is-invalid': $v.question.answer_text.$error }"></textarea>
                <!-- Валидация текста ответа -->
                <div class="invalid-feedback" v-if="!$v.question.answer_text.required">
                    Обязательное поле.
                </div>
                <div class="invalid-feedback" v-if="!$v.question.answer_text.maxLength">
                    Макс. количество символов: {{ $v.question.answer_text.$params.maxLength.max }}.
                </div>
            </div>
        </div>
        <div class="alert alert-danger" role="alert" v-if="errored">
            Ошибка загрузки данных!
            {{ errors[0] }}
        </div>
        <button @click="save" class="btn btn-success">Опубликовать</button>
        <button @click="back" class="btn btn-danger">Отмена</button>
    </div>
</template>

<script>

import {integer, maxLength, required} from "vuelidate/lib/validators";

export default {
    props: [
        'questionId',
        'flag'
    ],
    data() {
        return {
            question: [],
            categories: [],
            errored: false,
            errors: [],
        }
    },
    methods: {
        back() {
            if (this.flag) {
                this.$router.push({name: 'TrueQuestions'});
            } else {
                this.$router.push({name: 'FalseQuestions'});
            }
        },
        getCategories() {
            axios.get('/api/categories')
                .then(response => {
                    this.categories = response.data.data;
                })
                .catch(error => {
                    console.log(error);
                    this.errored = true;
                });
        },
        getQuestion() {
            axios.get('/api/questions/' + this.questionId)
                .then(response => {
                    this.question = response.data.data;
                })
                .catch(error => {
                    console.log(error);
                    this.errored = true;
                });
        },
        save() {
            // Валидация данных на frontend
            this.$v.$touch()
            if (this.$v.$anyError) {
                return;
            }
            // POST-запрос на сохранение данных
            axios.post('/api/questions/' + this.questionId, {
                _method: 'PUT',
                category_id: this.question.category_id,
                question_text: this.question.question_text,
                answer_text: this.question.answer_text,
                status: 1,
            }).then(response => {
                //TODO: Вывод результата запроса
            }).catch(error => {
                console.log(error.message);
                if (error.response.data.errors.title) {
                    this.errors = [];
                    this.errors.push(error.response.data.errors.title[0]);
                }
                this.errored = true;
            });
            if (this.errors.length === 0) {
                if (this.flag) {
                    this.$router.push({name: 'TrueQuestions'});
                } else {
                    this.$router.push({name: 'FalseQuestions'});
                }
            }
        }
    },
    mounted() {
        this.getCategories();
        this.getQuestion();
    },
    validations: {
        question: {
            question_text: {
                required,
                maxLength: maxLength(1024),
            },
            answer_text: {
                required,
                maxLength: maxLength(4096),
            },
            category_id: {
                required,
                integer,
            }
        },
    }
}
</script>
