class WidgetsController < ApplicationController
  def index
    @widgets = Widget.all
  end
end