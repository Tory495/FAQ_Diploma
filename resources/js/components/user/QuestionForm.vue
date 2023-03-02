<template>
    <div class="container">
        <h2 style="background-color: #1d68a7; color: #fff; font-family: Lucida Console" class="p-3 text-center">
            Вопрос</h2>
        <form @submit.prevent="validate">
            <div class="form-group">
                <label for="name">ФИО</label>
                <input v-model="form.name" type="text" name="name" placeholder="Введите ФИО..." id="name"
                       class="form-control" :class="{ 'is-invalid': $v.form.name.$error }">
                <!-- Валидация ФИО -->
                <div class="invalid-feedback" v-if="!$v.form.name.required">
                    Обязательное поле.
                </div>
                <div class="invalid-feedback" v-if="!$v.form.name.maxLength">
                    Макс. количество символов: {{ $v.form.name.$params.maxLength.max }}.
                </div>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input v-model="form.email" type="text" name="email" placeholder="Введите Email..." id="email"
                       class="form-control" :class="{ 'is-invalid': $v.form.email.$error }">
                <!-- Валидация Email -->
                <div class="invalid-feedback" v-if="!$v.form.email.required">
                    Обязательное поле.
                </div>
                <div class="invalid-feedback" v-if="!$v.form.email.maxLength">
                    Макс. количество символов: {{ $v.form.email.$params.maxLength.max }}.
                </div>
                <div class="invalid-feedback" v-if="!$v.form.email.email">
                    Некорректно введенный Email
                </div>
            </div>

            <div class="form-group">
                <label>Категория</label>
                <select v-model="form.category_id" class="form-select" name="category"
                        :class="{ 'is-invalid': $v.form.category_id.$error }">
                    <option v-for="category in categories" :value="category.id">{{ category.title }}</option>
                </select>
            </div>

            <div class="form-group">
                <label for="message">Сообщение</label>
                <textarea v-model="form.message" name="message" placeholder="Опишите проблему..." id="message"
                          class="form-control" :class="{ 'is-invalid': $v.form.message.$error }"></textarea>
                <!-- Валидация сообщения -->
                <div class="invalid-feedback" v-if="!$v.form.message.required">
                    Обязательное поле.
                </div>
                <div class="invalid-feedback" v-if="!$v.form.message.maxLength">
                    Макс. количество символов: {{ $v.form.message.$params.maxLength.max }}.
                </div>
            </div>
            <button style="background-color: #1d68a7; color: #fff" type="submit" class="btn">Отправить</button>
            <button @click="back" class="btn btn-danger">Вернуться</button>
        </form>
        <vue-recaptcha ref="recaptcha" size="invisible" :sitekey="sitekey"
                       @verify="sendMessage" @expired="onCaptchaExpired"/>
    </div>
</template>

<script>

import {integer, maxLength, required, email} from "vuelidate/lib/validators";
import {VueRecaptcha} from 'vue-recaptcha';

export default {
    data() {
        return {
            categories: [],
            form: [],
            errored: false,
            errors: [],
            sitekey: '6Lf5c3AgAAAAAAjCVSBUDOoZ_qXmK8gecZsf3vMO'
        }
    },
    mounted() {
        axios.get('/api/categories')
            .then(response => {
                this.categories = response.data.data;
            }).catch(error => {
            console.log(error);
            this.errored = true;
        });
    },
    methods: {
        back() {
            this.$router.push({name: 'FAQ'});
        },
        sendMessage( recaptchaToken ) {
            // Валидация данных на frontend
            this.$v.$touch()
            if (this.$v.$anyError) {
                return;
            }
            // POST-запрос на сохранение данных
            axios.post('/api/questions', {
                category_id: this.form.category_id,
                question_text: this.form.message,
                sender_info: "ФИО: " + this.form.name + "; E-mail: " + this.form.email,
                status: 0,
                recaptchaToken: recaptchaToken
            }).then(response => {
                alert("Сообщение отправлено");
            }).catch(error => {
                console.log(error);
                if (error.response.data.errors.title) {
                    this.errors = [];
                    this.errors.push(error.response.data.errors.title[0]);
                }
                this.errored = true;
            });
        },
        validate() {
            this.$refs.recaptcha.execute();
        },
        onCaptchaExpired() {
            this.$refs.recaptcha.reset()
        }
    },
    components: {VueRecaptcha},
    validations: {
        form: {
            email: {
                required,
                maxLength: maxLength(255),
                email,
            },
            name: {
                required,
                maxLength: maxLength(255),
            },
            category_id: {
                required,
            },
            message: {
                required,
                maxLength: maxLength(1024),
            }
        },
    }
}
</script>
