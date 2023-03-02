<template>
    <div class="container">
        <h2 style="background-color: #1d68a7; color: #fff; font-family: Lucida Console" class="p-3 text-center">
            Решенные вопросы</h2>
        <div v-for="category in categories">
            <div class="card mb-3" v-for="question in questions"
                 v-if="category.id === question.category_id && question.status === 1">
                <div class="card-body">
                    <h5 class="card-title">Категория: {{ category.title }}</h5>
                    <p class="card-text">Вопрос: {{ question.question_text }}</p>
                    <p class="card-text">Ответ: {{ question.answer_text }}</p>
                    <a href="#" class="card-link">
                        <router-link class="btn"
                                     :to="{name: 'ShowQuestion', params: {questionId: question.id, flag: true}}">
                            <img src="../../../img/edit.png" alt="" width="32" height="32"></router-link>
                    </a>
                    <button @click="deleteQuestion(question.id)" class="btn">
                        <img src="../../../img/delete.png" alt="" width="32" height="32">
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            questions: [],
            categories: [],
            errored: false,
            errors: [],
        }
    },
    mounted() {
        this.getQuestions();
        this.getCategories();
    },
    methods: {
        getQuestions() {
            axios.get('/api/questions')
                .then(response => {
                    this.questions = response.data.data;
                }).catch(error => {
                console.log(error);
                this.errored = true;
            });
        },
        getCategories() {
            axios.get('/api/categories')
                .then(response => {
                    this.categories = response.data.data;
                }).catch(error => {
                console.log(error);
                this.errored = true;
            });
        },
        deleteQuestion(id) {
            if (confirm('Вы действительно хотите удалить вопрос?')) {
                axios.post('/api/questions/' + id, {
                    _method: 'DELETE'
                }).then(response => {
                    this.questions = [];
                    this.getQuestions();
                }).catch(error => {
                    console.log(error);
                    this.errored = true;
                });
            }
        }
    }
}
</script>
