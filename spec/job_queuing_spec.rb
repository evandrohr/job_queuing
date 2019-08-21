require 'job_queuing'

RSpec.describe JobQueing do
  let(:jobs_empty) { JobQueing.new("") }
  let(:one_job_without_precedence) { JobQueing.new("a") }
  let(:three_jobs_without_precedence) { JobQueing.new("a,b,c") }
  let(:jobs_with_precedence) { JobQueing.new("a,b=>c,c=>f,d=>a,e=>b,f") }
  let(:jobs_referring_themselves) { JobQueing.new("a,b,c=>c") }
  let(:jobs_with_circular_dependencies) { JobQueing.new("a,b=>c,c=>f,d=>a,e,f=>b") }

  # Receives ""
  # Returns ""
  it "must returns an empty string when receives an empty string" do
    expect(jobs_empty.sorted_jobs).to eq("")
  end

  # Receives "a"
  # Returns "a"
  it "must returns a single character string when receives only one job" do
    expect(one_job_without_precedence.sorted_jobs).to eq("a")
    expect(one_job_without_precedence.sorted_jobs).to_not match('[b-z]')
  end

  # Receives "a,b,c"
  # Returns "a,b,c"
  it "must returns a string with the jobs in no significant order when receives only jobs without precedence" do
    expect(three_jobs_without_precedence.sorted_jobs).to include("a").and include("b").and include("c")
    expect(three_jobs_without_precedence.sorted_jobs).to_not match('[d-z]')
  end

  # Receives "a,b=>c,c=>f,d=>a,e=>b,f"
  # Returns "a,f,c,b,d,e"
  it "must returns a string with jobs sorted considering precedence" do
    expect(jobs_with_precedence.sorted_jobs).to eq("a,f,c,b,d,e")
  end

  # Receives "a,b,c=>c"
  # Returns "Error: Jobs cannot depends on themselves"
  it "returns an error when a job depends on themself" do
    expect(jobs_referring_themselves.sorted_jobs).to eq("Error: Jobs cannot depends on themselves")
  end

  # Receives "a,b=>c,c=>f,d=>a,e,f=>b"
  # Returns "Error: Jobs cannot have circular dependencies"
  it "returns an error when find circular dependency" do
    expect(jobs_with_circular_dependencies.sorted_jobs).to eq("Error: Jobs cannot have circular dependencies")
  end

  it "has ability to mark a job as sorted" do
    job = Job.new("a","b",false)
    jobs_with_precedence.mark_as_sorted(job)
    obj = jobs_with_precedence.jobs.select { |job_id|  job_id.id == job.id }
    expect(obj[0].sorted).to eq(true) 
  end

  it "has ability to return one job when search for precedence but the job doesn't have one" do
    job = Job.new("a","",false)
    expect(one_job_without_precedence.get_precedences([job])).to eq([job])

    job = Job.new("a","",true)
    expect(one_job_without_precedence.get_precedences([job])).to be_nil
  end

  it "can return an array of precedences including the actual job" do
    job = Job.new("b","c",false)
    precedences = jobs_with_precedence.get_precedences([job])
    str_precedences = precedences.map { |j| j.id}.join(',')
    expect(str_precedences).to eq("f,c,b")
  end

end