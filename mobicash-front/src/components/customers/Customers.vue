/* eslint-disable eol-last */
<template>
  <div class="m-auto py-10" style="width:60%">
    <div class="text-red" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb-4 text-center">Add Customer</h3>
    <form action="" @submit.prevent="addCustomer" style="width:40%;margin:auto">
      <div class="form-group">
        <input class="input form-control"
          autofocus autocomplete="off"
          placeholder="Name"
          v-model="name" id="name" />
      </div>
      <div class="form-group">
        <input class="input form-control"
          autofocus autocomplete="off"
          placeholder="Address"
          v-model="address" id="address" />
      </div>
      <div class="form-group">
        <input class="input form-control"
          autofocus autocomplete="off"
          placeholder="Phone"
          v-model="phone" id="phone" />
      </div>
      <input type="submit" value="Create Customer" class="btn-success btn-sm" />
    </form><br>
    <form class="w-full max-w-sm" method="GET" action="http://localhost:3000/api/v1/customerpdf">
        <div class="flex items-center border-b border-b-2 border-teal-500 py-2">
           <input type="submit"  class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" name="print" value="Print pdf">
        </div>
      </form>
    <p class="font-bold text-center">Created Customers</p>
    <div class="border-t border-blue-500 text-blue-700" role="alert">
      <ul class="list-reset mt-4">
        <p class="titles"><b>Customer Names</b> <b>Address</b><b>Phone Number</b></p>
        <li class="py-4" v-for="customer in customers" :key="customer.id" :customer="customer">

          <div class="flex items-center justify-between flex-wrap">
            <p class="block flex-1 font-mono font-semibold flex items-center ">
              <strong><b>{{ customer.name }}</b> <b>{{ customer.address }}</b> <b>{{ customer.phone }}</b></strong>
            </p>

            <button class="btn btn-info btn-sm"
            @click.prevent="editCustomer(customer)">Edit</button> &nbsp;&nbsp;

            <button class="btn btn-danger btn-sm"
          @click.prevent="removeCustomer(customer)">Delete</button>
          </div>

          <div v-if="customer == editedCustomer" style="width:30%">
            <form action="" @submit.prevent="updateCustomer(customer)">
              <div class="mb-6 p-4 bg-white rounded border border-grey-light mt-4">
                <input class="input form-control" v-model="customer.name" /><br>
                <input class="input form-control" v-model="customer.address" /><br>
                <input class="input form-control" v-model="customer.phone" /><br>
                <input type="submit" value="Update" class="btn-info text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 rounded cursor-pointer">
              </div>
            </form>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Customers',
  data () {
    return {
      customers: [],
      name: '',
      error: '',
      editedCustomer: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/customers')
        .then(response => { this.customers = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    addCustomer () {
      this.$http.secured.post('/api/v1/customers/', { name: this.name, address: this.address, phone: this.phone })

        .then(response => {
          this.customers.push(response.data)
          this.name = ''
          this.address = ''
          this.phone = ''
        })
        .catch(error => this.setError(error, 'Cannot create customer'))
    },
    removeCustomer (customer) {
      this.$http.secured.delete(`/api/v1/customers/${customer.id}`)
        .then(response => {
          this.customers.splice(this.customers.indexOf(customer), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete customer'))
    },
    editCustomer (customer) {
      this.editedCustomer = customer
    },
    updateCustomer (customer) {
      this.editedCustomer = ''
      this.$http.secured.patch(`/api/v1/customers/${customer.id}`, { customer: { title: customer.name } })
        .catch(error => this.setError(error, 'Cannot update customer'))
    }
  }
}
</script>
