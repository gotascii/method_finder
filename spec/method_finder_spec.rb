require 'helper'

class SubjectA
  include MethodFinder

  abbrev :cat

  def cat
    'scratch!'
  end
end

class SubjectB
  include MethodFinder

  abbrev :cab

  def cab
    'cabbie!'
  end
end

class SubjectC
  include MethodFinder

  abbrev :jill
  abbrev :jack

  def jill
    'jill'
  end

  def jack
    'jack'
  end
end

class SubjectD
  include MethodFinder

  abbrev :bill
  abbrev :bo
end

describe SubjectA do
  before do
    @subject_a = SubjectA.new
  end

  it "resolves cat" do
    @subject_a.cat.should == 'scratch!'
  end

  it "raises NoMethodError for a method named h" do
    expect { @subject_a.h }.to raise_error(NoMethodError)
  end

  it "resolves ca to cat" do
    @subject_a.ca.should == 'scratch!'
  end
  
  it "resolves c to cat" do
    @subject_a.c.should == 'scratch!'
  end
  
  it "has an abbrev that should be cat" do
    SubjectA.abbrev.should == [:cat]
  end
end

describe SubjectB do
  before do
    @subject_b = SubjectB.new
  end

  it "has an abbrev that should be cab" do
    SubjectB.abbrev.should == [:cab]
  end

  it "resolves c to cabbie" do
    @subject_b.c.should == 'cabbie!'
  end

  it "can't resolve cam" do
    expect { @subject_a.cam }.to raise_error(NoMethodError)
  end
end

describe SubjectC do
  before do
    @subject = SubjectC.new
  end

  it "resolves jac to jack" do
    @subject.jac.should == 'jack'
  end

  it "resolves jil to jill" do
    @subject.jil.should == 'jill'
  end

  it "resolves j to jill, jack" do
    @subject.j.should == [:jill, :jack]
  end
end

describe SubjectD do
  before do
    @subject = SubjectD.new
  end

  it "can't resolve bo" do
    expect { @subject.bo }.to raise_error(NoMethodError)
  end
end