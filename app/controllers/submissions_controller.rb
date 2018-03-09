require 'open3'
require 'fileutils'
require 'active_support/core_ext/hash'
class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy]

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = Submission.all
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
  end

  # GET /submissions/new
  def new
    @submission = Submission.new
  end

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions
  # POST /submissions.json
  def create
    paramc = submission_params
    @this_solution = Solution.find_by id:paramc[:solution_id]
    @this_problem = Problem.find_by id:@this_solution.problem_id
    @creator_code = @this_problem.correct_code
    out_string = compile(@this_solution.language,submission_params[:code_name])
    if(out_string.include?('CE'))
      puts "Error1: #{out_string}"
      out_string[0]=""
      out_string[0]=""
      puts "Error: #{out_string}"
      paramc[:output] = out_string
      paramc[:result] = "Compilation Error"
    else
      paramc[:output] = out_string
      @this_solution = Solution.find_by id:paramc[:solution_id]
      @this_problem = Problem.find_by id:@this_solution.problem_id
      puts "Corr Out: #{@this_problem.correct_output}"
      if(@this_problem.correct_output == out_string)
        paramc[:result] = "Correct Answer"
      else
        paramc[:result] = "Wrong Answer"
      end
    end
    @submission = Submission.new(paramc)


    respond_to do |format|
      if @submission.save
        format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def compile(lang, name)
    if lang.to_s == "c"
      compile_command = "cc public/codes/submitted_codes/#{name}"
      stdout, stderr, stdstatus = Open3.capture3(compile_command)
      if stdstatus.success?
        run_command = "./a.out"
        stdout2, stderr2, stdstatus2 = Open3.capture3(run_command)
        stdout, stderr, stdstatus = Open3.capture3("rm a.out")
        stdout2 = stdout2.to_s
      else
        stderr = stderr.prepend("CE")
        puts "#{stderr}"
        return stderr
      end
      return stdout2

    elsif lang.to_s == "c++"
      compile_command = "g++ public/codes/submitted_codes/#{name}"
      stdout, stderr, stdstatus = Open3.capture3(compile_command)
      if stdstatus.success?
        run_command = "./a.out"
        stdout2, stderr2, stdstatus2 = Open3.capture3(run_command)
        stdout, stderr, stdstatus = Open3.capture3("rm a.out")
        stdout2 = stdout2.to_s
        return stdout2
      else
        stderr = stderr.prepend("CE")
        puts "#{stderr}"
        return stderr
      end

    elsif lang.to_s == "ruby"
      compile_command = "ruby public/codes/submitted_codes/#{name}"
      stdout, stderr, stdstatus = Open3.capture3(compile_command)
      if stdstatus.success?
        return stdout.to_s
      else
        stderr = stderr.prepend("CE")
        puts "#{stderr}"
        return stderr
      end

    elsif lang.to_s == "python"
    compile_command = "python public/codes/submitted_codes/#{name}"
    stdout, stderr, stdstatus = Open3.capture3(compile_command)
      if stdstatus.success?
        return stdout.to_s
      else
        stderr = stderr.prepend("CE")
        puts "#{stderr}"
        return stderr
      end
    end

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def submission_params
      params.require(:submission).permit(:solution_id, :code_name, :output)
    end
end
