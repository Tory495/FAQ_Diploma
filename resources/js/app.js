/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.Vue = require('vue');

/**
 * The following block of code may be used to automatically register your
 * Vue components. It will recursively scan this directory for the Vue
 * components and automatically register them with their "basename".
 *
 * Eg. ./components/ExampleComponent.vue -> <example-component></example-component>
 */

import VueRouter from "vue-router";
import Vuelidate from "vuelidate";

Vue.use(VueRouter);
Vue.use(Vuelidate);
import App from "./components/App";

import FAQ from "./components/user/FAQ";
import QuestionForm from "./components/user/QuestionForm";

import Admin from "./components/admin/Admin";
import TrueQuestions from "./components/admin/TrueQuestions";
import FalseQuestions from "./components/admin/FalseQuestions";
import ShowQuestion from "./components/admin/ShowQuestion";
import Categories from "./components/admin/categories/Categories";
import ShowCategory from "./components/admin/categories/ShowCategory";

const router = new VueRouter({
    mode: 'history',
    routes: [
        {
            path: '/faq',
            name: 'FAQ',
            component: FAQ
        },
        {
            path: '/admin',
            name: 'Admin',
            component: Admin
        },
        {
            path: '/faq/question_form',
            name: 'QuestionForm',
            component: QuestionForm
        },
        {
            path: '/admin/true_questions',
            name: 'TrueQuestions',
            component: TrueQuestions
        },
        {
            path: '/admin/false_questions',
            name: 'FalseQuestions',
            component: FalseQuestions
        },
        {
            path: '/admin/categories',
            name: 'Categories',
            component: Categories
        },
        {
            path: '/admin/categories/:categoryId',
            name: 'ShowCategory',
            component: ShowCategory,
            props: true
        },
        {
            path: '/admin/questions/:questionId',
            name: 'ShowQuestion',
            component: ShowQuestion,
            props: true
        }
    ]
});

/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */

const app = new Vue({
    el: '#app',
    components: {App},
    router
});
