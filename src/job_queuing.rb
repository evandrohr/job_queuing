require 'byebug'

Job = Struct.new(:id,:precedence,:sorted)

class JobQueing
  attr_reader :jobs

  def initialize(jobs)
    @jobs = []
    unsorted_jobs = jobs.split(',')
    unsorted_jobs.each do |job|
      @jobs << Job.new(job.split("=>")[0], job.split("=>")[1].to_s, false)
    end
  end

  def sorted_jobs
    return "Error: Jobs cannot depends on themselves" if have_autoreference?
    sorted = []
    @jobs.each do |job|
      next if job.sorted == true 
      get_precedences([job]).each do |precedence|
        sorted << precedence.id if precedence != nil
      end
    end

    sorted.join(',')
  end

  def get_precedences(job)

    # byebug

    if job[0].sorted == true
      return nil
    end

    if job[0].precedence == "" then
      mark_as_sorted(job[0])
      return job
    end

    precedent_job = @jobs.select { |job_id|  job_id.id == job[0].precedence }
   
    if precedent_job[0].sorted == false then
      job.unshift(precedent_job[0])
      mark_as_sorted(job[1])
      get_precedences(job)      
    end

    mark_as_sorted(job[0])

    return job
  end

  def mark_as_sorted(job)
    obj = @jobs.select { |job_id|  job_id.id == job.id.to_s }
    obj[0].sorted = true
  end

  def have_autoreference?
    autoreferences = false
    @jobs.each do |job|
      if job.id == job.precedence.to_s then
        autoreferences = true
        break
      end
    end
    autoreferences
  end

end