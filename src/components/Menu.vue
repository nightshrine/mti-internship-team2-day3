<template>
  <div class="ui secondary pointing green inverted massive menu">
    <a class=item @click="switchPage('Home')" v-bind:class="{active: current=='Home'}">Home</a>
    <a class=item @click="switchPage('Users')" v-bind:class="{active: current=='Users'}">Users</a>
    <a class=item @click="switchPage('Profile')" v-bind:class="{active: current=='Profile'}">Profile</a>
    <div class="right menu">
      <button class="item" @click="logout">Logout</button>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Menu',
    computed: {
      current() {
        return this.$route.name;
      }
    },
    methods: {
      switchPage(pageName) {
        if (this.$route.name === pageName) {
          return;
        }
        this.$router.push({ name: pageName });
      },
      logout() {
        // localStorageと直接書くとグローバル変数使用の警告が出るため、windowから書いています。
        window.localStorage.removeItem('token');
        window.localStorage.removeItem('userId');
        this.$router.push({ name: 'Login' });
      }
    },
  }
</script>

<style scoped>
</style>