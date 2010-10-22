require 'spec_helper'

describe "Callbacks" do
  before :each do
    Micon.clear
    Micon.metadata.clear
  end
  
  describe "components callbacs" do
    it "basic" do
      Micon.register(:the_object){"The Object"}
    
      check = mock
      check.should_receive(:done)
      Micon.before :the_object do
        check.done
      end
    
      Micon.after :the_object do |o|
        o << " updated"
      end
      Micon.after :the_object do |o|
        o << " even more updated"
      end
    
      Micon[:the_object].should == "The Object updated even more updated"
    end
  
    it "should be able reference to the component itself inside of after filter (cycle reference)" do
      Micon.register(:the_object){"The Object"}
      check = nil
      Micon.after :the_object do
        check = Micon[:the_object]
      end
      Micon[:the_object]
      check.should == "The Object"
    end
  end
  
  describe "custom scope callbacks" do
    it "scope :before and :after callbacks" do
      check = mock
      check.should_receive(:before).with({}).ordered
      check.should_receive(:run).ordered
      check.should_receive(:after).with({}).ordered
      check.should_receive(:after2).with({}).ordered

      Micon.before_scope(:custom){|container| check.before container}
      Micon.after_scope(:custom){|container| check.after container}
      Micon.after_scope(:custom){|container| check.after2 container}

      Micon.activate(:custom, {}){check.run}
    end    
  end  
end