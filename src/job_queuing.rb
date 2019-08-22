Job = Struct.new(:id,:precedence,:sorted,:circular_reference)

class JobQueing
  attr_reader :jobs

  def initialize(jobs)
    @jobs = []
    unsorted_jobs = jobs.split(',')
    unsorted_jobs.each do |job|
      @jobs << Job.new(job.split("=>")[0], job.split("=>")[1].to_s, false, false)
    end
  end

  def sorted_jobs
    return "Error: Jobs cannot depends on themselves" if have_self_reference?
    sorted = []
    @jobs.each do |job|
      next if job.sorted == true 
      get_precedences([job]).each do |precedence|
        if precedence.circular_reference == true
          return "Error: Jobs cannot have circular dependencies"
        end
        mark_as_sorted(precedence)
        sorted << precedence.id if precedence != nil
      end
    end

    sorted.join(',')
  end

  def get_precedences(job)

    if job[0].sorted == true
      return nil
    end

    if job[0].precedence == "" then
      mark_as_sorted(job[0])
      return job
    end

    precedent_job = @jobs.select { |job_id|  job_id.id == job[0].precedence }
   
    if precedent_job[0].sorted == false then
      # Detecting circular reference
      if (job.select { |job_id|  job_id.id == precedent_job[0].id }).size > 0
        job[0].circular_reference = true
        return job
      end
      job.unshift(precedent_job[0])
      get_precedences(job)      
    end

    return job
  end

  def mark_as_sorted(job)
    obj = @jobs.select { |job_id|  job_id.id == job.id.to_s }
    obj[0].sorted = true
  end

  def have_self_reference?
    self_reference = false
    @jobs.each do |job|
      if job.id == job.precedence.to_s then
        self_reference = true
        break
      end
    end
    return self_reference
  end

end