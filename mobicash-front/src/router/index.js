/* eslint-disable eol-last */
import Vue from 'vue'
import Router from 'vue-router'
import Signin from '@/components/Signin.vue'
import Products from '@/components/Products.vue'
import Signup from '@/components/Signup.vue'
import Customers from '@/components/customers/Customers.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/customers',
      name: 'Customers',
      component: Customers
    },
    {
      path: '/',
      name: 'Signin',
      component: Signin
    },
    {
      path: '/signup',
      name: 'Signup',
      component: Signup
    },
    {
      path: '/products',
      name: 'Products',
      component: Products
    }

  ]
})