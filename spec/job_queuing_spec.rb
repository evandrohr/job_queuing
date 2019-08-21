require 'job_queuing'

RSpec.describe JobQueing do
  let(:jobs_empty) { JobQueing.new("") }
  let(:one_job_without_precedence) { JobQueing.new("a") }
  let(:three_jobs_without_precedence) { JobQueing.new("a,b,c") }


  # Receives ""
  # Returns ""
  it "must returns an empty string when receives an empty string" do
    expect(jobs_empty.ordered_jobs).to eq("")
  end

  # Receives "a"
  # Returns "a"
  it "must returns a single character string when receives only one job" do
    expect(one_job_without_precedence.ordered_jobs).to eq("a")
    expect(one_job_without_precedence.ordered_jobs).to_not match('[b-z]')
  end

  # Receives "a,b,c"
  # Returns "a,b,c"
  it "must returns a string with the jobs in no significant order when receives only jobs without precedence" do
    expect(three_jobs_without_precedence.ordered_jobs).to include("a").and include("b").and include("c")
    expect(three_jobs_without_precedence.ordered_jobs).to_not match('[d-z]')
  end

  # Receives "a,b=>c,c"
  # Returns "a,c,b"
  it "must returns a string with jobs ordered considering precedence" do
  
  end

  # Receives "a,b,c=>c"
  # Returns "Error: Jobs cannot depends on themselves"
  it "returns an error when a job depends on themself" do
  
  end

  # Receives "a,b=>c,c=>f,d=>a,e,f=>b"
  # Returns "Error: Jobs cannot have circular dependencies"
  it "returns an error when find circular dependency" do
  
  end

end