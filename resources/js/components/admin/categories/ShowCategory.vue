<template>
    <div class="container">
        <div class="form-group">
            <label for="title">Название категории</label>
            <input type="text" v-model="category.title" name="title" id="title" class="form-control"
                   :class="{ 'is-invalid': $v.category.title.$error }">
            <!-- Валидация названия категории -->
            <div class="invalid-feedback" v-if="!$v.category.title.required">
                Обязательное поле.
            </div>
            <div class="invalid-feedback" v-if="!$v.category.title.maxLength">
                Макс. количество символов: {{ $v.category.title.$params.maxLength.max }}.
            </div>
            <label for="strength">Сила</label>
            <input type="text" v-model="category.strength" name="strength" id="strength" class="form-control"
                   :class="{ 'is-invalid': $v.category.strength.$error }">
            <!-- Валидация силы -->
            <div class="invalid-feedback" v-if="!$v.category.strength.required">
                Обязательное поле.
            </div>
            <div class="invalid-feedback" v-if="!$v.category.strength.integer">
                Значение в поле должно быть целым числом.
            </div>

        </div>
        <div class="alert alert-danger" role="alert" v-if="errored">
            Ошибка загрузки данных!
            {{ errors[0] }}
        </div>
        <button style="background-color: #1d68a7; color: #fff" @click="save" class="btn">Изменить</button>
        <button @click="back" class="btn btn-danger">Отмена</button>
    </div>
</template>

<script>

import {required, maxLength, integer} from 'vuelidate/lib/validators';

export default {
    props: [
        'categoryId',
    ],
    data() {
        return {
            category: [],
            errored: false,
            errors: [],
        }
    },
    methods: {
        back() {
            this.$router.push({name: 'Categories'});
        },
        save() {
            // Валидация данных на frontend
            this.$v.$touch()
            if (this.$v.$anyError) {
                return;
            }
            // POST-запрос на сохранение данных
            axios.post('/api/categories/' + this.categoryId, {
                _method: 'PUT',
                title: this.category.title,
                strength: this.category.strength,
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
                this.$router.push({name: 'Categories'});
            }
        }
    },
    mounted() {
        // GET-запрос на получение данных
        axios.get('/api/categories/' + this.categoryId)
            .then(response => {
                this.category = response.data.data;
            })
            .catch(error => {
                console.log(error);
                this.errored = true;
            });
    },
    validations: {
        category: {
            title: {
                required,
                maxLength: maxLength(255),
            },
            strength: {
                required,
                integer,
            },
        },
    }
}
</script>
