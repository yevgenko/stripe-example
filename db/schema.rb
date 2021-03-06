# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120222010440) do

  create_table "items", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.decimal  "price",       :precision => 8, :scale => 2, :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "plans", :force => true do |t|
    t.string   "name",                                     :null => false
    t.string   "slug",                                     :null => false
    t.decimal  "price",      :precision => 8, :scale => 2, :null => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "plans", ["price"], :name => "index_plans_on_price"
  add_index "plans", ["slug"], :name => "index_plans_on_slug", :unique => true

  create_table "purchases", :force => true do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.boolean  "live",                                              :default => false
    t.boolean  "paid",                                              :default => false
    t.boolean  "refunded",                                          :default => false
    t.decimal  "price",               :precision => 8, :scale => 2,                    :null => false
    t.integer  "fee"
    t.string   "card_type"
    t.string   "card_zip"
    t.string   "last_four"
    t.string   "stripe_charge_token"
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.integer  "item"
    t.integer  "month"
    t.integer  "year"
    t.string   "table"
    t.string   "username"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id",               :null => false
    t.integer  "plan_id",               :null => false
    t.string   "stripe_customer_token"
    t.string   "card_zip"
    t.string   "last_four"
    t.string   "card_type"
    t.date     "next_bill_on"
    t.string   "card_expiration"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "subscriptions", ["user_id"], :name => "index_subscriptions_on_user_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "webhooks", :force => true do |t|
    t.integer  "user_id"
    t.string   "stripe_webhook_id",                      :null => false
    t.string   "stripe_webhook_type",                    :null => false
    t.text     "object",                                 :null => false
    t.boolean  "livemode",            :default => false, :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "webhooks", ["stripe_webhook_id"], :name => "index_webhooks_on_stripe_webhook_id", :unique => true
  add_index "webhooks", ["user_id"], :name => "index_webhooks_on_user_id"

end
