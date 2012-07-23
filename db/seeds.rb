# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Create Admin vewg30

v = User.new
v.username= 'vewg30'
v.email= 'vincent.elliott.wagner@mni.thm.de'
v.isAdmin= true
v.save
a = Authorization.create(user: v,provider: 'cas',uid: 'vewg30')
