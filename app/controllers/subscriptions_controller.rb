class SubscriptionsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @subscription      = Subscription.new params[:subscription]
    @subscription.user = current_user

    @plan = Plan.find params[:subscription][:plan_id]

    if @subscription.save_with_payment
      flash[:success] = 'Subscription added!'
      redirect_to root_path
    else
      flash.now[:error] = 'Unable to add subscription!'
      render template: 'plans/show'
    end
  end

  def edit
    @subscription = current_user.subscription

    @plans = Plan.all
  end

  def update
    @subscription = current_user.subscription

    if @subscription.update_with_payment params[:subscription]
      flash.now[:success] = 'Subscription updated!'
      render :edit
    else
      flash.now[:error] = 'Unable to update billing!'
      render :edit
    end
  end

  def change_plan
    @subscription = current_user.subscription

    if @subscription.change_plan_to params[:new_plan_id]
      flash.now[:success] = 'The plans. You have changed them.'
    else
      flash.now[:error] = 'Unable to change your plan.'
    end
    render :edit
  end

  def destroy
    @subscription  = current_user.subscription
    customer_token = @subscription.stripe_customer_token
    customer = Stripe::Customer.retrieve(customer_token)
    
    customer.cancel_subscription
    current_user.subscription.destroy

    redirect_to root_path
    flash[:success] = 'account cancelled. :('
  end

end
