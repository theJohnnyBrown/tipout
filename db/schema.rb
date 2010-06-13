# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100613030057) do

  create_table "days", :force => true do |t|
    t.date     "when"
    t.integer  "total_tips"
    t.integer  "tipout_pct"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "closer_id"
  end

  create_table "people", :force => true do |t|
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "shifts", :force => true do |t|
    t.integer  "day_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "closing_barback"
    t.boolean  "second_floor"
    t.datetime "time_in"
    t.datetime "time_out"
  end

end
