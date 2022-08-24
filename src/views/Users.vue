<template>
  <div class="ui main container">
    <div class="ui segment">
      <form class="ui form">
        <div class="field">
          <label>ユーザー名</label>
          <input type="text" placeholder="userId" v-model="nickname" />
        </div>
        <div class="field">
          <label>年齢</label>
          <div class="inline fields">
            <div class="field">
              <input type="text" v-model="start" />
              <label>歳から</label>
            </div>
            <div class="field">
              <input type="text" v-model="end" />
              <label>歳まで</label>
            </div>
          </div>
        </div>
      </form>
    </div>

    <template v-for="(user, index) in filterdUsers">
      <div class="ui segment" :key="index">
        <h2 class="ui header">
          <div class="content">
            {{user.nickname}}
            <div class="ui green label">{{user.age}}</div>
            <div class="sub header">{{user.userId}}</div>
          </div>
        </h2>
      </div>
    </template>
  </div>
</template>
<script>
  // 必要なものはここでインポートする
  // @は/srcの同じ意味です
  // import something from '@/components/something.vue';
  import { baseUrl } from '@/assets/config.js';
  import axios from "axios";

  export default {
  name: 'Users',
  data() {
    return {
      users: [],
      nickname: "",
      start: 0,
      end: 10000,
    };
  },
  computed: {
    filterdUsers() {
      let result = this.users;
      if (this.nickname) {
        result = result.filter(target => {
          return target.userId.match(this.nickname);
        });
      }
      if (this.start) {
        result = result.filter(target => {
          return target.age >= this.start;
        });
      }
      if (this.end) {
        result = result.filter(target => {
          return target.age <= this.end;
        });
      }
      return result;
    }
  },
  async created() {
    if (!window.localStorage.getItem("userId")) {
      this.$router.push({name: "Login"});
    }
    await axios.get(baseUrl + "/users")
      .then((response) => {
        this.users = response.data;
      })
      .catch(() => {});
  }
}
</script>
<style scoped>
  /* このコンポーネントだけに適用するCSSは */
</style>