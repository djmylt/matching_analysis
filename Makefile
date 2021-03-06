CC=gcc
CARGS=-Wall -O3
PROF=$(CARGS) -pg
GMPLIB=-L/gmp_install/lib -lgmp
CMPHLIB=-L/usr/local/lib/libcmph.la -lcmph

all: gen-pattern parameterised-test exact-test kmp-test

profile: gen-pattern parameterised-test-profile exact-test-profile

clean: gen-pattern-clean parameterised-test-clean exact-test-clean kmp-test-clean

parameterised-test:
	$(CC) $(CARGS) -D PARAMETERISED stream_test.c -o parameterised_test

parameterised-test-profile:
	$(CC) $(PROF) -D PARAMETERISED stream_test.c -o parameterised_test

parameterised-test-clean:
	rm parameterised_test

kmp-test:
	$(CC) $(CARGS) -D KMP_TEST stream_test.c -o kmp_test

kmp-test-clean:
	rm kmp_test

exact-test:
	$(CC) $(CARGS) stream_test.c -o exact_test $(GMPLIB) $(CMPHLIB)

exact-test-profile:
	$(CC) $(PROF) stream_test.c -o exact_test $(GMPLIB) $(CMPHLIB)

exact-test-clean:
	rm exact_test

gen-pattern:
	$(CC) $(CARGS) make_pattern.c -o make_pattern

gen-pattern-clean:
	rm make_pattern

poster:
	pdflatex poster.tex

poster-clean:
	rm poster.aux poster.log poster.nav poster.out poster.pdf poster.snm poster.toc