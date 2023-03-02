<template>
    <div class="container">
        <h2 style="background-color: #1d68a7; color: #fff; font-family: Lucida Console" class="p-3 text-center">Добавить
            новую категорию</h2>
        <!-- Валидация на уникальность -->
        <div class="alert alert-danger" role="alert" v-if="errored">
            Ошибка загрузки данных!
            {{ errors[0] }}
        </div>
        <form class="mb-5" @submit.prevent="createCategory">
            <div class="form-group">
                <label for="title">Название категории</label>
                <input type="text" class="form-control" placeholder="Название" id="title" v-model="category.title"
                       :class="{ 'is-invalid': ($v.category.title.$dirty && $v.category.title.$error) }">
                <!-- Валидация названия категории -->
                <div class="invalid-feedback" v-if="!$v.category.title.required">
                    Обязательное поле.
                </div>
                <div class="invalid-feedback" v-if="!$v.category.title.maxLength">
                    Макс. количество символов: {{ $v.category.title.$params.maxLength.max }}.
                </div>
            </div>
            <div class="form-group">
                <label for="strength">Сила (Чем больше значение, тем выше категория располагается в списке)</label>
                <input type="text" class="form-control" placeholder="Сила" id="strength" v-model="category.strength"
                       :class="{ 'is-invalid': $v.category.strength.$error }">
                <!-- Валидация силы -->
                <div class="invalid-feedback" v-if="!$v.category.strength.required">
                    Обязательное поле.
                </div>
                <div class="invalid-feedback" v-if="!$v.category.strength.integer">
                    Значение в поле должно быть целым числом.
                </div>
            </div>
            <button style="background-color: #1d68a7; color: #fff" type="submit" class="btn">Добавить</button>
        </form>
        <h2 style="background-color: #1d68a7; color: #fff; font-family: Lucida Console" class="p-3 text-center">
            Категории
        </h2>
        <div class="table-responsive">
            <table class="table" style="table-layout: fixed">
                <thead>
                <tr>
                    <th scope="col" width="40%">Название</th>
                    <th scope="col">Сила</th>
                    <th scope="col"></th>
                    <th scope="col"></th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="category in categories">
                    <td style="word-wrap: break-word">{{ category.title }}</td>
                    <td>{{ category.strength }}</td>
                    <td>
                        <router-link class="btn" :to="{name: 'ShowCategory', params: {categoryId: category.id}}"><img src="../../../../img/edit.png" alt="" width="32" height="32"></router-link>
                    </td>
                    <td>
                        <button @click="deleteCategory(category.id)" class="btn" >
                            <img src="../../../../img/delete.png" alt="" width="32" height="32">
                        </button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>

<script>

import {required, maxLength, integer} from 'vuelidate/lib/validators';

export default {
    data() {
        return {
            categories: [],
            category: [],
            errored: false,
            errors: [],
        }
    },
    mounted() {
        this.getCategories();
    },
    methods: {
        createCategory() {
            // Валидация данных на frontend
            this.$v.$touch()
            if (this.$v.$anyError) {
                return;
            }
            // POST-запрос на создание категории
            axios.post('/api/categories', {
                title: this.category.title,
                strength: this.category.strength,
            }).then(response => {
                this.category = [];
                this.getCategories();
            }).catch(error => {
                console.log(error);
                if (error.response.data.errors.title) {
                    this.errors = [];
                    this.errors.push(error.response.data.errors.title[0]);
                }
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
        deleteCategory(id) {
            if (confirm('Вы действительно хотите удалить категорию?')) {
                axios.post('/api/categories/' + id, {
                    _method: 'DELETE'
                }).then(response => {
                    this.categories = [];
                    this.getCategories();
                }).catch(error => {
                    console.log(error);
                    this.errored = true;
                });
            }
        }
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
