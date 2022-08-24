<template>
  <div>
    <div class="ui main container" @submit.prevent="submit">
      <!-- 基本的なコンテンツはここに記載する -->
      <div class="ui segment">
        <form class="ui large form">
          <div class="field">
            <div class="ui left icon input">
              <i class="user icon"></i>
              <input type="text" placeholder="ID" v-model="user.userId" />
            </div>
          </div>
          <div class="field">
            <div class="ui left icon input">
              <i class="lock icon"></i>
              <input type="password" placeholder="Password" v-model="user.password" />
            </div>
          </div>
          <div class="field" v-if="!isLogin">
            <div class="ui left icon input">
              <i class="tag icon"></i>
              <input type="text" placeholder="Nickname" v-model="user.nickname" />
            </div>
          </div>
          <div class="field" v-if="!isLogin">
            <div class="ui left icon input">
              <i class="calendar icon"></i>
              <input type="text" placeholder="Age" v-model.number="user.age" />
            </div>
          </div>
          <button class="ui huge green fluid button" type="submit">
            {{ submitText }}
          </button>
        </form>
      </div>
      <button @click="toggleMode()" class="ui huge grey fluid button" type="submit">
        {{ toggleText }}
      </button>
    </div>
  </div>
</template>
<script>
// 必要なものはここでインポートする
// @は/srcの同じ意味です
// import something from '@/components/something.vue';
import { baseUrl } from '@/assets/config.js';
import axios from "axios";

export default {
  name: 'Login',
  components: {
   // 読み込んだコンポーネント名をここに記述する
  },
  data() {
  // Vue.jsで使う変数はここに記述する
    return {
      isLogin:true,
      user: {
        userId: null,
        password: null,
        nickname: null,
        age: null
      },
      err: null
    };
  },
  computed: {
  // 計算した結果を変数として利用したいときはここに記述する
  submitText() {
    return this.isLogin ? "ログイン" : "新規登録";
  },
  toggleText() {
    return this.isLogin ? "新規登録" : "ログイン" ;
  }
  },
  methods: {
  // Vue.jsで使う関数はここで記述する
    toggleMode() {
      this.isLogin = !this.isLogin;
    },
    submit() {
      if (this.isLogin) {
        if (!this.user.userId) {
          this.err = 'userIdを入力してください';
        }
        else if (!this.user.password) {
          this.err = 'パスワードを入力してください';
        }
        const requestBody = {
          userId: this.user.userId,
          password: this.user.password,
        }
        axios.post(baseUrl + "/user/login", requestBody)
          .then((response) => {
            // 成功したときの処理はここに記述する
            console.log(response.data);
            window.localStorage.setItem('token', response.data.token);
            window.localStorage.setItem('userId', this.user.userId);
            console.log(window.localStorage.getItem('token'))
            this.$router.push({ name: 'Home' });
          })
          .catch(() => {
            // レスポンスがエラーで返ってきたときの処理はここに記述する
            this.err = '予期せぬエラーが発生しました';
          });
        return;
      }
      if (!this.user.nickname) {
        this.err = "ニックネームを入力してください";
      } else if (!this.user.age) {
        this.err = "年齢を入力してください";
      }
      
      const requestBody = {
        userId: this.user.userId,
        password: this.user.password,
        nickname: this.user.nickname,
        age: this.user.age,
      }
      axios.post(baseUrl + "/user/signup", requestBody)
        .then((response) => {
          window.localStorage.setItem('token', response.data.token);
          window.localStorage.setItem('userId', this.user.userId);
          console.log(window.localStorage.getItem('token'))
          this.$router.push({ name: 'Home' });
          console.log(response.data);
        })
        .catch(() => {
          this.err = "予期せぬエラーが発生しました";
        }
      );
    }
  },
}
</script>
<style scoped>
/* このコンポーネントだけに適用するCSSは */
</style>