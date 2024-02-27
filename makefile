NAME = NoahIovanniLorenzoDíaz-Práctica2.tar.gz

all:
	g++ -g rational_t.cpp main_p2.cpp -o main_p2

git: 
	git pull
	git add .
	git commit -m "Changes"
	git push

tar:
	tar cfvz $(NAME) .

clean:
	rm main_p2 *tar.gz