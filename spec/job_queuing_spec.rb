
Rspec.describe JobQueing do

  # Receives ""
  # Returns ""
  it "must returns an empty string when receives an empty string" do

  end

  # Receives "a"
  # Returns "a"
  it "must returns a single character string when receives only one job" do

  end

  # Receives "a,b,c"
  # Returns "a,b,c"
  it "must returns a string with the jobs in no significant order when receives only jobs without precedence" do

  end

  # Receives "a,b=>c,c"
  # Returns "a,c,b"
  it "must returns a string with jobs ordered considering precedence"
  
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