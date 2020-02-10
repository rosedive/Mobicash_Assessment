module Api
  module V1
    class CustomersController < ApplicationController
      before_action :authorize_access_request!, except: [:show, :index]
      before_action :set_customer, only: [:show, :update, :destroy]

      # GET /customers
      def index
        @customers = Customer.all
        render json: @customers
      end

      # GET /customers/1
      def show
        render json: @customer
      end

      # POST /customers
      def create
        @customer = Customer.new(customer_params)

        if @customer.save
          render json: @customer, status: :created
        else
          render json: @customer.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /customers/1
      def update
        if @customer.update(customer_params)
          render json: @customer
        else
          render json: @customer.errors, status: :unprocessable_entity
        end
      end

      # DELETE /customers/1
      def destroy
        @customer.destroy
      end
      def pdf
        @customers = Customer.all
        pdf = CustomerPdf.new(@customers)
        send_data pdf.render, filename: "customers.pdf",type: "application/pdf",disposition: "inline"
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_customer
          @customer = Customer.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def customer_params
          params.require(:customer).permit(:name, :address, :phone)
        end
    end
  end
end