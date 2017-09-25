class TransactionsController < ApplicationController


  def create

    @transaction = Transaction.new(transaction_params)
    @transaction.sender_id = current_user.id
    current_user.lock!
    if @transaction.amount > current_user_balance
      render(
        json: ["Not enough credits."]
        )
    elsif @transaction.save
        redirect_to "/users"
    else
      render(
        json: ["Transaction did not go through"]
            )
    end
  end

  def show

  end



  def index

  end

  private

  def transaction_params
    params.require(:transaction).permit(:receiver_id, :amount)
  end
end
