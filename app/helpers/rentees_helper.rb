module RenteesHelper

  def isAdmin?
    current_user.email == 'admin@gmail.com' unless current_user.blank?
  end


end



