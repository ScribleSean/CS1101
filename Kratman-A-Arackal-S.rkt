;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Kratman-A-Arackal-S) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct date(year month day))
;;date is a (make-date Natural Natural Natural)
;;year: year of release
;;month: month of realease
;day: day of release

(define-struct film (title genre rating running-time opening-date nominations))
;;film is a (make-film String String String Natural Date Natural)
;;title: the title of the film (Up, Luca, Ratatouille)
;;genre: the title of the film (drama, comedy, family)
;;rating: the film's rating.  (G, PG, PG-13)
;;running-time: the running time of the film, in minutes 
;opening-date: the date the film opened at the theater
;;nominations: the number of Oscar (Academy Award) nominations the film received 

;;(define UP-DATE (make-date 2009 05 29))
(define UP (make-film "Up" "Family" "PG" 96 (make-date 2009 05 29) 5))
(define LUCA (make-film "Luca" "Family" "PG" 95 (make-date 2021 06 18) 1))
(define RATTA (make-film "Ratatouille" "Family" "PG" 111 (make-date 2007 06 27) 5))


;; hi sean! this is all my work.

(define-struct date (year month date))
(define SILENCEDATE (make-date 1991 02 14))
(define SAWDATE (make-date 2004 10 29))
(define BLAIRDATE (make-date 1999 07 30))
(define HEREDATE (make-date 2018 01 21))
(define GETDATE (make-date 2017 02 24))
(define EXORDATE (make-date 1973 12 26))
(define ARRIVEDATE (make-date 2016 09 02))
(define FAKEDATE (make-date 2022 09 05))
(define FAKEDATETWO (make-date 2022 09 05))
(define FAKEDATETHREE (make-date 2022 09 05))


;;film-title: String -> String
;;film-genre: String -> String
;;film-rating String -> String
;;film-running-time: Natural -> Natural
;;film-opening-date: Film -> Date
;;film-nominations: Natural -> Natural
;; ask sean abt this

(define-struct film (title genre rating running-time opening-date nominations))
(define SILENCE (make-film "The Silence of the Lambs" "horror" "R" 118 SILENCEDATE 10))
(define SAW (make-film "Saw" "horror" "R" 100 SAWDATE 0))
(define BLAIR (make-film "The Blair Witch Project" "horror" "R" 81 BLAIRDATE 0))
(define HEREDITARY (make-film "Hereditary" "horror" "R" 128 HEREDATE 0))
(define GETOUT (make-film "Get Out" "horror" "R" 104 GETDATE 4))
(define EXORCIST (make-film "The Exorcist" "horror" "R" 132 EXORDATE 10))
(define ARRIVAL (make-film "Arrival" "drama" "PG-13" 112 ARRIVEDATE 8))
(define FAKEMOVIE (make-film "Fake Movie" "comedy" "NR" 106 FAKEDATE 8))
(define FAKEMOVIETWO (make-film "Fake Movie: The Wrath of Khan" "drama" "PG" 200 FAKEDATETWO 16))
(define FAKEMOVIETHREE (make-film "Fake Movie: Tokyo Drift" "drama" "R" 107 FAKEDATETHREE 16))


(define (high-brow? film)
(or (and (or (string=? (film-rating film) "NR")(string=? (film-rating film) "NC-17"))(> (film-nominations film) 0))
  (and (string=? (film-genre film) "drama") (> (film-running-time film) 150)))) 

(check-expect (high-brow? SAW) #false)
(check-expect (high-brow? FAKEMOVIE) #true)
(check-expect (high-brow? FAKEMOVIETWO) #true)
(check-expect (high-brow? FAKEMOVIETHREE) #false)
(check-expect (high-brow? BLAIR) #false)
(check-expect (high-brow? EXORCIST) #false)

;; question 4

(define (total-nominations filmOne filmTwo) 
 (+ (film-nominations filmOne) (film-nominations filmTwo)))

(check-expect (total-nominations BLAIR EXORCIST) 10)
(check-expect (total-nominations SAW HEREDITARY) 0)
(check-expect (total-nominations BLAIR EXORCIST) 10)
(check-expect (total-nominations GETOUT SILENCE) 14)
(check-expect (total-nominations FAKEMOVIE FAKEMOVIETWO) 24)

;; question 5

;;Write a function update-nominations which consumes a film 
;;and a Number (representing the number of Oscar nominations), and produces a 
;;film. The film that is produced is the same as the original except that its 
;;nominations has been replaced by the given nominations. 

(define (update-nominations film newNominations)
  (make-film (film-title film) (film-genre film) (film-rating film) (film-running-time film) (film-opening-date film) newNominations))

(check-expect (update-nominations BLAIR 62) (make-film "The Blair Witch Project" "horror" "R" 81 BLAIRDATE 62))
;; add check expects tmmmrw!!!

;; (25 Points) Write a function opened-after? which consumes a film and a 
;;date, and produces a Boolean. The function produces true if the given film 
;;opened after the given date, and returns false otherwise.

(define (opened-after? film date)
  (> (film-opening-date film) (date-year date)))

(define TESTDATE (make-date 1992 12 10))

  (opened-after? SILENCE TESTDATE)
;; ? talk to sean tmmrw!
