/* eslint-disable eol-last */
<template>
<div>
  <nav class="navbar navbar-expand-lg navbar-light header">
  <a class="navbar-brand" href="#">Customer Application</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent" style="margin-left:50%">
    <form method="GET" action="http://dev.mobivat.com:8080/vsdc_module/mobivat/api/product/productId?upc=224444445" v-if="signedIn()" class="form-inline my-2 my-lg-0">
      <input type="search" name="upc" class="form-control mr-sm-2" placeholder="search product by upc">&nbsp;
      <input type="submit" class="btn btn-outline-success my-2 my-sm-0" name="search_button" value="Search">
    </form>
    <router-link to="/" class="btn-sm btn-success" v-if="!signedIn()">Sign in</router-link>&nbsp;&nbsp;
    <router-link to="/signup" class="btn-sm btn-primary" v-if="!signedIn()">Sign Up</router-link>
    <a href="#" @click.prevent="signOut" class="btn-sm btn-danger" v-if="signedIn()">Sign out</a>
  </div>
  </nav>

  <aside class="nav navbar bg-light fixed py-4" v-if="signedIn()">
    <div>
      <div>
        <router-link to="/customers" class="btn btn-link" v-if="signedIn()">Customers</router-link>
      </div>
    </div>
  </aside>
  </div>
</template>

<script>
export default {
  name: 'Header',
  created () {
    this.signedIn()
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    signedIn () {
      return localStorage.signedIn
    },
    signOut () {
      this.$http.secured.delete('/signin')
        .then(response => {
          delete localStorage.csrf
          delete localStorage.signedIn
          this.$router.replace('/')
        })
        .catch(error => this.setError(error, 'Cannot sign out'))
    }
  }
}
</script>
