class Respect
  def self.inherited(subclass)
    @@subclasses ||= []
    @@subclasses << subclass
  end

  def self.run_suite
    @@subclasses.each {|subclass| subclass.run_specs }
  end

  def self.run_specs
    @@contexts.each do |context|
      context.run_specs
    end
  end

  def self.describe(description, &block)
    @@contexts = []
    @@contexts << context = Respect::Context.new(description)
    context.instance_eval(&block)
  end

  class Context
    def initialize(description)
      @description = description
      @expectations = []
    end

    def before(&block)
      @before = block
    end

    def expect(&block)
      @expectations << expectation = Expectation.new(&block)
      expectation
    end

    def run_specs
      with_environment do |env|
        env.instance_eval(&@before)
        @expectations.each do |spec|
          spec.run_in(env)
        end
      end
    end

    def with_environment
      yield Object.new
    end

    # TODO: this should be a method_missing
    def be_nil
      Respect::Assertion.new do |obj|
        obj.respond_to?(:nil?) && obj.nil?
      end
    end
  end

  class Assertion
    def initialize(&block)
      @assert = block
    end

    def verify(subject)
      @assert.call(subject)
    end
  end

  class Expectation
    def initialize(&block)
      @subject = block
    end

    def report(assertion)
      puts assertion ? '.' : 'F'
    end

    def run_in(env)
      subject = env.instance_eval(&@subject)
      report @assertion.verify(subject)
    end

    def to(assertion)
      @assertion = assertion
    end

    def to_proc
      @subject
    end
  end
end
