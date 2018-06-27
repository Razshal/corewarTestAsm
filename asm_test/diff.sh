#!/bin/bash

FILES=$(find wrong_tests -name "*.s")

_RED=$(tput setaf 1)
_PURPLE=$(tput setaf 5)
_END=$(tput sgr0)

for i in ${FILES}; do
	printf "%s :\n" "${i}";
	./asm "${i}" &1> /dev/null;
	name="$(echo "$i" | cut -f 1 -d '.')";
	mv "$name".cor "$name"_student.cor;
	./realasm "${i}" &1> /dev/null;
	hexdump -C $name"_student.cor" > out;
	hexdump -C $name".cor" > out2;
	if ! diff out out2; then
		echo "no diffs";
	fi
	rm out out2;
done;
rm wrong_tests/*.cor
