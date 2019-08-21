# Job Queuing

Development of a class capable to order by priority jobs taking care abaout informed precedences

## Getting Started

This project was developed with simplicity, easy to install and test in mind. To achieve this I decided to create an environment using Docker to be sure users will have the same environment where the code was developed. Is it possible to run the test suite and use the class outside docker, by the way. The drawback will be the need to install a compatible ruby version and run 'bundle install'. Avoiding using Docker the user assumes the risk of contaminating their environment with unnecessary gems and ruby versions.
The commits were made to show an incremental process of TDD development code.
The better solution I found to handle precedences was using a recurring method. It have their fragility when handling circular references that was handled on algoritm.

### Prerequisites

Using Docker

```
1) Docker installed
```

Using without Docker

```
1) Ruby 2.6.3 installed
```

### Installing

Using Docker:

```
docker build -t job_queuing .
```

Without Docker:

```
bundle install
```

## Running the tests

Using Docker:

```
docker run -t -i job_queuing
```

Without Docker:

```
rspec
```

### Running other sequences of jobs

With Docker:

```
docker run -t -i job_queuing /bin/bash -c "ruby queuing.rb 'a,b=>c,c=>f,d=>a,e=>b,f'"
```

Without Docker:

```
ruby queuing.rb 'a,b=>c,c=>f,d=>a,e=>b,f'
```
