<template>
    <div class="container">
        <h2 style="background-color: #1d68a7; color: #fff; font-family: Lucida Console" class="p-3 text-center">
            Панель администратора</h2>
        <ul class="navbar-nav">
            <h2 class="nav-item">
                <router-link class="nav-link" :to="{name: 'TrueQuestions'}">Вопросы</router-link>
            </h2>
            <h2 class="nav-item">
                <router-link class="nav-link" :to="{name: 'FalseQuestions'}">Вопросы без ответа</router-link>
            </h2>
            <h2 class="nav-item">
                <router-link class="nav-link" :to="{name: 'Categories'}">Категории</router-link>
            </h2>
        </ul>
    </div>
</template>

<script>
export default {}
</script>
