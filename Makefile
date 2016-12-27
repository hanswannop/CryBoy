all: cryboy

cryboy:
	crystal build main.cr -o cryboy --release
