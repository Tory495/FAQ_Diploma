<template>
    <div class="container">
        <ul class="nav justify-content-center">
            <h1 class="nav-item">
                <router-link class="nav-link" :to="{name: 'FAQ'}">ЧаВо</router-link>
            </h1>
            <h1 class="nav-item">
                <router-link class="nav-link" :to="{name: 'Admin'}">Админ-панель</router-link>
            </h1>
        </ul>
        <div>
            <router-view/>
        </div>
    </div>
</template>

<script>
export default {
}
</script>
