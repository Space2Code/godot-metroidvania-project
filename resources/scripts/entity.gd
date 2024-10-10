extends Node

func delete_self():
	get_parent().queue_free()
