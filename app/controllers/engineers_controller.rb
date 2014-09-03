class EngineersController < ApplicationController
  before_action :set_engineer, only: [:show, :edit, :update, :destroy]

  # GET /engineers
  # GET /engineers.json
  def index
    @engineers = Engineer.where(rentee_id: params[:rentee_id])
    @rentee = Rentee.find(params[:rentee_id])
    # @renteeId = Rentee.find(params[:tokens])
  end

  # GET /engineers/1
  # GET /engineers/1.json
  def show

  end

  # GET /engineers/new
  def new
    @rentee = Rentee.find(params[:rentee_id])
    @engineer = Engineer.new
  end

  # GET /engineers/1/edit
  def edit
    @rentee = Rentee.find(params[:rentee_id])
  end

  # POST /engineers
  # POST /engineers.json
  def create
    @engineer = Engineer.new(engineer_params)
    r = Rentee.find(params[:rentee_id])
    @engineer.rentee = r
      if @engineer.save
      end

    respond_to do |format|
      if @engineer.save
        format.html { redirect_to [@engineer.rentee, @engineer], notice: 'Engineer was successfully created.' }
        format.json { render :show, status: :created, location: @engineer }
      else
        format.html { render :new }
        format.json { render json: @engineer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /engineers/1
  # PATCH/PUT /engineers/1.json
  def update
    numTokens = params[:engineer][:tokens].to_i
    puts "NUMBER OF TOKENS"
    puts numTokens
    engineerId = params[:id]
    renteeId = params[:rentee_id]
    engineerTokens = Engineer.find(engineerId).tokens

    renteeTokens = Rentee.find(renteeId).tokens
    puts "RENTEE TOKENS"
    puts renteeTokens

    if numTokens <= renteeTokens
      renteeTokens = renteeTokens - numTokens
      Rentee.update(renteeId, :tokens => renteeTokens)
      engineerTokens = engineerTokens + numTokens

    else
      puts "purchase more tokens"
    end

    respond_to do |format|
      if @engineer.update(:tokens => engineerTokens)
        format.html { redirect_to [@engineer.rentee, @engineer], notice: 'Engineer was successfully updated.' }
        format.json { render :show, status: :ok, location: @engineer }
      else
        format.html { render :edit }
        format.json { render json: @engineer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /engineers/1
  # DELETE /engineers/1.json
  def destroy
    @engineer.destroy
    respond_to do |format|
      format.html { redirect_to engineers_url, notice: 'Engineer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_engineer
      @engineer = Engineer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def engineer_params
      params.require(:engineer).permit(:name, :phone, :tokens)
    end
end
