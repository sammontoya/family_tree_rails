require 'active_record'
require 'rspec'

require_relative '../app/models/person'

database_configuration = YAML::load(File.open('config/database.yml'))
configuration = database_configuration['test']
ActiveRecord::Base.establish_connection(configuration)

describe Person do
  it "should validate the presence of a first name" do
      first_name = Person.new({:given_name => '' })
      expect(first_name.save).to eq false
  end

  it "should validate the presence of a family name" do
      family_name = Person.new({:family_name => '' })
      expect(family_name.save).to eq false
  end

  it "should accept a mother" do
    myMother = Person.new({:given_name => 'MyMother', :family_name => 'Mom'})
    myMother.save
    myPerson = Person.new({:given_name => 'Me', :family_name => 'Myself'})
    myPerson.mother = myMother
    myPerson.save
    expect(myPerson.mother).to eq myMother
    expect(myMother.mother).to eq nil
  end

  it "should accept a father" do
      myFather = Person.new({:given_name => 'MyFather', :family_name => 'L'})
      myFather.save
      myPerson = Person.new({:given_name => 'Me', :family_name => 'Myself'})
      myPerson.father = myFather
      myPerson.save
      expect(myPerson.father).to eq myFather
      expect(myFather.father).to eq nil
  end

  it "has grandparents" do
    grandmaM = Person.new({:given_name  => 'granny', :family_name => 'f'})
    grandmaM.save
    grandpaM = Person.new({:given_name => 'gramps', :family_name => 'f'})
    grandpaM.save
    myMother = Person.new({:given_name => 'MyMother', :family_name => 'L'})

    myMother.mother = grandmaM
    myMother.father = grandpaM
    myMother.save

    grandmaF = Person.new({:given_name  => 'grannyF', :family_name => 'f'})
    grandmaF.save
    grandpaF = Person.new({:given_name => 'grampsF', :family_name => 'f'})
    grandpaF.save
    myFather = Person.new({:given_name => 'MyFather', :family_name => 'L'})

    myFather.mother = grandmaF
    myFather.father = grandpaF
    myFather.save


    myPerson = Person.new({:given_name => 'Me', :family_name => 'Myself'})
    myPerson.mother = myMother
    myPerson.father = myFather
    myPerson.save

    expect(myPerson.grandparents).to be_a Array
    expect(myPerson.grandparents).to match_array [grandmaM, grandpaM, grandmaF, grandpaF]
    # expect(myPerson.grandparents).to match_array [grandpa]
  end

end
