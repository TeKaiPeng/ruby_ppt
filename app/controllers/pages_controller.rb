class PagesController < ApplicationController
    def index
    end

    def about
    end

    def boards
    end

    def pricing
    end

    def payment
        @token = gateway.client_token.generate
        @plan = params[:plan]
        @price = plan_price(@plan)
    end
    
    def checkout
        result = gateway.transaction.sale(
        amount: plan_price(params[:plan]),
        payment_method_nonce: params[:nonce],
        # device_data: device_data_from_the_client,
        options: {
            :submit_for_settlement => true
        }
        )

        if result.success?
            #轉換角色
            # current_user.update(role: "plan_#{params[:plan]}")
            redirect_to root_path, notice:'e俺謝乾爹！'
        else
            redirect_to root_path, notice:'沒錢💰嘛？'
        end
        # render html: params[:nonce]
    end


    private
    def gateway
        Braintree::Gateway.new(
        environment: :sandbox,
        merchant_id: ENV["braintree_merchant_id"],
        public_key: ENV["braintree_public_key"],
        private_key: ENV["braintree_private_key"],
        )    
    end

    def plan_price(plan)
        case plan 
        when 'a'
            ENV['plan_a_price']
        when 'b'
            ENV['plan_b_price']
        end
    end
end
