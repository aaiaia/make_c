test: llist.o tmain.o
	gcc -O0 -o test llist.o tmain.o
llist.o: ./llist.c
	gcc -O0 -lm -c ./llist.c
tmain.o: ./tmain.c
	gcc -O0 -lm -c ./tmain.c
re: clean all
clean:
	rm -f *.o test

