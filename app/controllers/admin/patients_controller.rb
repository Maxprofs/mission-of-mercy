module Admin
  class PatientsController < ApplicationController

    before_filter :admin_required, :set_current_tab

    def edit
      @patient = Patient.find(params[:id])

      build_previous_mom_clinics
    end

    def update
      if params[:id] == nil
        params[:id] = params[:patient_id]
      end

      @patient = Patient.find(params[:id])

      if @patient.update_attributes(params[:patient])

        if params[:commit] == "Next"
          redirect_to(:controller => 'exit_surveys', :action => 'new', :id => @patient.id)
        else
          flash[:notice] = 'Patient was successfully updated.'

          redirect_to patients_path
        end
      else
        render :action => "edit"
      end
    end

    def destroy
      @patient = Patient.find(params[:id])
      @patient.destroy

      redirect_to(patients_url)
    end

    def history
      @patient = Patient.find(params[:patient_id])
    end

    private

    # TODO kbl
    # copy paste
    def build_previous_mom_clinics
      PatientPreviousMomClinic::CLINICS.each do |y, l|
        existing = @patient.previous_mom_clinics.detect do |c|
            c.clinic_year == y && c.location == l
          end

        unless existing
          @patient.previous_mom_clinics.build(:clinic_year => y, :location => l)
        end
      end
    end

    def set_current_tab
      @current_tab = 'patients'
    end

  end
end
