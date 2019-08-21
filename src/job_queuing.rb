require 'byebug'

Job = Struct.new(:id,:precedence,:ordered)

class JobQueing
  attr_reader :jobs

  def initialize(jobs)
    @jobs = []
    unordered_jobs = jobs.split(',')
    unordered_jobs.each do |job|
      @jobs << Job.new(job.split("=>")[0], job.split("=>")[1].to_s, false)
    end
  end

  def ordered_jobs
    ordered = []
    @jobs.each do |job|
      next if job.ordered == true 
      get_precedences([job]).each do |precedence|
        ordered << precedence.id if precedence != nil
      end
    end

    ordered.join(',')
  end

  def get_precedences(job)

    # byebug

    if job[0].ordered == true
      return nil
    end

    if job[0].precedence == "" then
      mark_as_ordered(job[0])
      return job
    end

    precedent_job = @jobs.select { |job_id|  job_id.id == job[0].precedence }
   
    if precedent_job[0].ordered == false then
      job.unshift(precedent_job[0])
      mark_as_ordered(job[1])
      get_precedences(job)      
    end

    mark_as_ordered(job[0])

    return job
  end

  def mark_as_ordered(job)
    obj = @jobs.select { |job_id|  job_id.id == job.id.to_s }
    obj[0].ordered = true
  end

end