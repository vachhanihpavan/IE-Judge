json.extract! submission, :id, :solution_id, :result, :output, :created_at, :updated_at
json.url submission_url(submission, format: :json)
