require 'benchmark/ips'
require 'brcobranca'

Benchmark.ips do |x|
  x.config(:time => 3, :warmup => 2)

  # Typical mode, runs the block as many times as it can
  x.report("elixir") do
    %x{ mix run sample.exs }
  end

  x.report("ruby") do
    %x{ bundle exec ruby sample.rb }
  end

  # Compare the iterations per second of the various reports!
  x.compare!
end
