JA_FILES = \
	   evim-ja.UTF-8.1 \
	   vimdiff-ja.UTF-8.1 \
	   vim-ja.UTF-8.1 \
	   vimtutor-ja.UTF-8.1 \
	   xxd-ja.UTF-8.1

test:
	for i in $(JA_FILES); do \
		echo Checking $$i; \
		LC_ALL=en_US.UTF-8 MANROFFSEQ='' MANWIDTH=80 man --warnings -E UTF-8 -l -Tutf8 -Z $$i > $$i.log 2>&1 > /dev/null; \
		grep -v "cannot adjust line\|\(cannot\|can't\) break line" $$i.log && exit 1 || :; \
	done

clean:
	rm -f *.log
