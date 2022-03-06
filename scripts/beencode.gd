extends Node

var corpus: String = ""

var alpha_regex = RegEx.new()

func _ready():
	var corpus_file := File.new()
	corpus_file.open("res://bee.txt", File.READ)
	corpus = corpus_file.get_as_text()
	corpus_file.close()
	alpha_regex.compile("[a-zA-Z]")

func int_to_bitvec(number: int):
	var bitvec = []
	for i in range(0, 8):
		bitvec.append((number&(1<<i)) > 0)
	return bitvec

func beedecode(data: String) -> String:
	var seq = []
	var dat_test = data.to_lower()
	for i in range(0, data.length()):
		if alpha_regex.search(data[i]):
			# good char!
			if data[i].to_upper() == data[i]:
				seq.append(true)
			else:
				seq.append(false)
	var pos = 0
	var bytes = []
	for m in range(0, floor(seq.size()/8)):
		var num = 0
		for i in range(0, 8):
			var bit = seq[pos+i]
			if bit:
				num += (1 << i)
		pos += 8
		bytes.append(num)
	var pba = PoolByteArray(bytes)
	return pba.get_string_from_ascii()

func beencode(data: String) -> String:
	var out = ""
	var byte_sequence = []
	for i in range(0,data.length()):
		var datum = data[i]
		var d_utf = datum.to_ascii()
		for j in range(0, d_utf.size()):
			byte_sequence.append(int_to_bitvec(d_utf[j]))
	# flatten array
	var true_seq = []
	for i in range(0,byte_sequence.size()):
		for j in range(0, byte_sequence[i].size()):
			true_seq.append(byte_sequence[i][j])
	var cor = corpus.to_lower()
	var ind = 0
	for i in range(0,cor.length()):
		if cor[i].to_upper() == cor[i]:
			out += cor[i]
			continue
		if ind >= true_seq.size():
			break
		if true_seq[ind]:
			out += cor[i].to_upper()
		else:
			out += cor[i].to_lower()
		ind += 1
	return out
