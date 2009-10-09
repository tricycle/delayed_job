require File.dirname(__FILE__) + '/database'

describe Delayed::Worker do

  describe "signal handling" do
    %w(INT TERM).each do |signal|
      it "should chain the #{signal} signal handler" do
        handler_called = false
        trap(signal) { handler_called = true }

        worker_thread = Thread.new do
          Delayed::Worker.new.start
        end

        Process.kill(signal, 0) # 0 is this process

        # Wait for the worker to exit
        worker_thread.join

        handler_called.should be_true
      end
    end
  end
end
