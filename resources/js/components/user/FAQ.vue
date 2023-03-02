<template>
    <div class="container">
        <h2 style="background-color: #1d68a7; color: #fff; font-family: Lucida Console" class="p-3 text-center">
            Часто задаваемые вопросы</h2>
        <form class="mb-5" @submit.prevent="search">
            <div class="form-group">
                <label>Категория</label>
                <select v-model="category_id" class="form-select" name="category">
                    <option selected value="0">Не выбрано</option>
                    <option v-for="category in categories" :value="category.id">{{ category.title }}</option>
                </select>
            </div>
            <div class="form-group">
                <label>Текст</label>
                <input type="text" class="form-control" placeholder="Введите текст..." id="title" v-model="text">
            </div>
            <button @ type="submit" style="background-color: #1d68a7; color: #fff" class="btn">Поиск</button>
        </form>
        <div class="accordion" id="accordionExample">
            <div class="accordion-item" v-for="question in questions" v-if="question.status === 1">
                <h2 class="accordion-header" v-bind:id="'flush-heading' + question.id">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                            :data-bs-target="'#flush-collapse' + question.id" aria-expanded="false"
                            v-bind:aria-controls="'flush-collapse' + question.id">
                        <h3>{{ question.question_text }}</h3>
                    </button>
                </h2>
                <div v-bind:id="'flush-collapse' + question.id" class="accordion-collapse collapse"
                     v-bind:aria-labelledby="'flush-heading' + question.id"
                     data-bs-parent="#accordionExample">
                    <div class="accordion-body">
                        {{ question.answer_text }}
                    </div>
                </div>
            </div>
        </div>
        <div class="alert alert-info" role="alert" v-if="questions.length === 0">
            Вопросы не найдены.
        </div>
        <router-link :to="{name: 'QuestionForm'}">Не нашли нужный вопрос? Задайте его сами!</router-link>
        <router-view/>
    </div>
</template>

<script>
export default {
    data() {
        return {
            questions: [],
            categories: [],
            category_id: 0,
            text: ""
        }
    },
    mounted() {
        axios.get('/api/questions').then(response => {
            this.questions = response.data.data;
        });
        axios.get('/api/categories').then(response => {
            this.categories = response.data.data;
        });
    },
    methods: {
        search() {
            console.log(this.category_id);
            console.log(this.text);
            // POST-запрос на поиск данных
            axios.post('/api/questions/search', {
                category_id: this.category_id,
                text: this.text,
            }).then(response => {
                console.log("OK");
                this.questions = response.data.data;
            }).catch(error => {
                console.log(error);
            });
        }
    }
}
</script>
