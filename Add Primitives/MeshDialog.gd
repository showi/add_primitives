#==============================================================================#
# Copyright (c) 2015 Franklin Sobrinho.                                        #
#                                                                              #
# Permission is hereby granted, free of charge, to any person obtaining        #
# a copy of this software and associated documentation files (the "Software"), #
# to deal in the Software without restriction, including without               #
# limitation the rights to use, copy, modify, merge, publish,                  #
# distribute, sublicense, and/or sell copies of the Software, and to           #
# permit persons to whom the Software is furnished to do so, subject to        #
# the following conditions:                                                    #
#                                                                              #
# The above copyright notice and this permission notice shall be               #
# included in all copies or substantial portions of the Software.              #
#                                                                              #
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,              #
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF           #
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.       #
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY         #
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,         #
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE            #
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                       #
#==============================================================================#

extends WindowDialog

var index = 0

var mesh_instance

# Containers
var main_vbox
var main_panel
var color_hb

# Widgets
var options
var color_picker
var text_display

# Default editors
var parameter_editor
var modifier_editor

const DIALOG_SIZE = Vector2(250, 275)

static func create_display_material(instance):
	var fixed_material = FixedMaterial.new()
	fixed_material.set_name('__display_material__')
	fixed_material.set_parameter(fixed_material.PARAM_DIFFUSE, Color(0, 1, 0))
	
	instance.set_material_override(fixed_material)
	
	return fixed_material
	
func get_editor(name):
	if not main_panel.has_node(name):
		return null
		
	var editor = main_panel.get_node(name)
	
	return editor
	
func set_current_editor(id):
	var selected = main_panel.get_child(id)
	
	for c in main_panel.get_children():
		c.hide()
		
	selected.show()
	
	options.select(id)
	
	index = id
	
func connect_editor(name, obj, method):
	var editor = get_editor(name)
	
	if not editor:
		return
		
	var signal_ = editor.get_signal()
	
	if not signal_:
		return
		
	editor.connect(signal_, obj, method)
	
func edit(instance, builder):
	mesh_instance = instance
	
	if not mesh_instance:
		return
		
	set_title("New " + builder.get_name())
	
	parameter_editor.edit(builder)
	modifier_editor.create_modifiers()
	
	set_current_editor(0)
	
func show_dialog():
	if not mesh_instance:
		return
		
	color_picker.set_color(Color(0,1,0))
	
	if mesh_instance.get_material_override():
		color_hb.hide()
		
	else:
		create_display_material(mesh_instance)
		
		if color_hb.is_hidden():
			color_hb.show()
			
	popup_centered(DIALOG_SIZE)
	
func display_text(text):
	text_display.set_text(text)
	
func clear():
	mesh_instance = null
	
	parameter_editor.clear()
	modifier_editor.clear()
	
func _color_changed(color):
	if mesh_instance extends MeshInstance:
		var mat = mesh_instance.get_material_override()
		
		if mat:
			mat.set_parameter(FixedMaterial.PARAM_DIFFUSE, color)
			
func _popup_hide():
	if mesh_instance:
		var mat = mesh_instance.get_material_override()
		
		if mat and mat.get_name() == '__display_material__':
			mesh_instance.set_material_override(null)
			
func _init(base):
	main_vbox = VBoxContainer.new()
	add_child(main_vbox)
	main_vbox.set_area_as_parent_rect(get_constant('margin', 'Dialogs'))
	
	var hb = HBoxContainer.new()
	main_vbox.add_child(hb)
	hb.set_h_size_flags(SIZE_EXPAND_FILL)
	
	options = OptionButton.new()
	options.set_custom_minimum_size(Vector2(120, 0))
	hb.add_child(options)
	options.connect("item_selected", self, "set_current_editor")
	
	var s = Control.new()
	hb.add_child(s)
	s.set_h_size_flags(SIZE_EXPAND_FILL)
	
	color_hb = HBoxContainer.new()
	hb.add_child(color_hb)
	
	var l = Label.new()
	l.set_text("Display ")
	color_hb.add_child(l)
	
	color_picker = ColorPickerButton.new()
	color_picker.set_color(Color(0,1,0))
	color_picker.set_edit_alpha(false)
	color_hb.add_child(color_picker)
	
	var sy = color_picker.get_minimum_size().y
	color_picker.set_custom_minimum_size(Vector2(sy * 1.5, sy))
	
	color_picker.connect("color_changed", self, "_color_changed")
	
	main_panel = PanelContainer.new()
	main_vbox.add_child(main_panel)
	main_panel.set_v_size_flags(SIZE_EXPAND_FILL)
	
	var editors = preload("MeshDialogEditors.gd")
	
	parameter_editor = editors.ParameterEditor.new()
	main_panel.add_child(parameter_editor)
	
	modifier_editor = editors.ModifierEditor.new(base)
	main_panel.add_child(modifier_editor)
	
	for editor in main_panel.get_children():
		var name = editor.get_name().capitalize()
		
		options.add_item(name)
		
	text_display = Label.new()
	text_display.set_align(text_display.ALIGN_CENTER)
	main_vbox.add_child(text_display)
	
	connect("popup_hide", self, "_popup_hide")
	
