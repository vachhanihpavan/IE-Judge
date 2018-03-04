json.extract! problem, :id, :title, :description, :testcases, :input, :correct_output, :correct_code, :created_at, :updated_at
json.url problem_url(problem, format: :json)
