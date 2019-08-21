$LOAD_PATH << 'src'

require 'job_queuing'

if ARGV[0] != nil 
  job_queuing = JobQueing.new(ARGV[0]) 
  puts job_queuing.sorted_jobs
end