class WidgetsController < ApplicationController
  def index
    @widgets = Widget.all
  end

  def new
    @widget = Widget.new
  end

  def create
    @widget = Widget.create(widget_params)
    if @widget.persisted?
      redirect_to widgets_path, notice: 'New widget successfully created.'
    else
      render 'new'
    end
  end

  private
  def widget_params
    params.require(:widget).permit(:name, :size)
  end
end