;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname kratman-a-arackal-s-hw1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Names: Abigail Kratman & Sean Arackal
;; WPI Usernames: aekratman & sarackal

;Question 1/2

(define-struct date(year month day))
;;date is a (make-date Natural Natural Natural)
;;year: year of release of film (2004, 2019, 2022, etc.)
;;month: month of realease of film (01, 06, 12, etc.)
;day: day of release of film (01, 11, 29, etc.)

(define SAWDATE (make-date 2004 10 29))
(define BLAIRDATE (make-date 1999 07 30))
(define GETDATE (make-date 2017 02 24))
(define ARRIVEDATE (make-date 2016 09 02))
(define FAKEDATE (make-date 2022 09 05))
(define FAKEDATETWO (make-date 2022 09 05))
(define FAKEDATETHREE (make-date 2022 09 05))


(define-struct film (title genre rating running-time opening-date nominations))
;;film is a (make-film String String String Natural Date Natural)
;;title: the title of the film (Saw, Get Out, Arrival, etc.)
;;genre: the title of the film (drama, comedy, family, etc.) 
;;rating: the film's rating (G, PG, PG-13, etc.)
;;running-time: the running time of the film, in minutes (92, 105, 161)
;opening-date: the date the film opened at the theater ((make-date 01 01 2001), etc.)
;;nominations: the number of Oscar (Academy Award) nominations the film received (0, 5, 10, etc.)

(define SAW (make-film "Saw" "horror" "R" 100 SAWDATE 0))
(define BLAIR (make-film "The Blair Witch Project" "horror" "R" 81 BLAIRDATE 0))
(define GETOUT (make-film "Get Out" "horror" "R" 104 GETDATE 4))
(define ARRIVAL (make-film "Arrival" "drama" "PG-13" 112 ARRIVEDATE 8))
(define FAKEMOVIE (make-film "Fake Movie" "comedy" "NR" 106 FAKEDATE 8))
(define FAKEMOVIETWO (make-film "Fake Movie: The Wrath of Khan" "drama" "PG" 200 FAKEDATETWO 16))
(define FAKEMOVIETHREE (make-film "Fake Movie: Toyko Drift" "drama" "PG" 130 FAKEDATETHREE 18))


;;Question 3

;;high-brow? : film --> Boolean
;;Consumes a film and returns true if it is a drama more than two and a half hours long or was both nominated for an Oscar and has a rating of NC-17 or NR

(define (high-brow? film)
(or (and (or (string=? (film-rating film) "NR")(string=? (film-rating film) "NC-17"))(> (film-nominations film) 0))
  (and (string=? (film-genre film) "drama") (> (film-running-time film) 150))))

;; Case where film is not a Drama which is more than 150 mins long
;;and its not Oscar Nominated with a rating of "NR" or "NC-17"
(check-expect (high-brow? SAW) #false)

;; Case where film is not a Drama which is more than 150 mins long
;;and its not Oscar Nominated with a rating of "NR" or "NC-17"
(check-expect (high-brow? BLAIR) #false)

;; Case where film is not a Drama which is more than 150 mins long
;; and it IS Oscar Nominated but NOT with a rating of "NR" or "NC-17"
(check-expect (high-brow? GETOUT) #false)

;; Case where film IS a Drama but is NOT more than 150 mins long
;;and its not Oscar Nominated with a rating of "NR" or "NC-17"
(check-expect (high-brow? ARRIVAL) #false)

;; Case where film is not a Drama which is more than 150 mins long
;;but it IS Oscar Nominated with a rating of "NR" or "NC-17"
(check-expect (high-brow? FAKEMOVIE) #true)

;; Case where film IS a Drama which is more than 150 mins long
(check-expect (high-brow? FAKEMOVIETWO) #true)

;; Case where film IS a Drama but NOT more than 150 mins long
;;and it IS Oscar Nominated but NOT with a rating of "NR" or "NC-17"
(check-expect (high-brow? FAKEMOVIETHREE) #false)


;;Question 4

;;total-nominations : film film --> Number
;;Consumes two films and produces the sum of the Oscar nominations for the two films

(define (total-nominations filmOne filmTwo) 
 (+ (film-nominations filmOne) (film-nominations filmTwo)))

(check-expect (total-nominations SAW BLAIR) 0) ;;case where we find sum of two zeros
(check-expect (total-nominations GETOUT FAKEMOVIE) 12) ;;case where we find sum of two Naturals
(check-expect (total-nominations FAKEMOVIETWO ARRIVAL) 24) ;;case where we find sum of two Naturals
(check-expect (total-nominations BLAIR GETOUT) 4) ;;case where we find sum of a zero and a Natural
(check-expect (total-nominations SAW FAKEMOVIETWO) 16) ;;case where we find sum of a zero and a Natural

;;Question 5

;;update-nominations : film Number --> Film
;;Consumes a film and a Number (representing the number of Oscar nominations)
;;and produces a film that is produced is the same as the original except that its nominations has been replaced by the given nominations

(define (update-nominations film newNominations)
  (make-film (film-title film) (film-genre film) (film-rating film) (film-running-time film) (film-opening-date film) newNominations))

;;case where we "change" nominations to 0 where original value is also 0
(check-expect (update-nominations SAW 0) (make-film "Saw" "horror" "R" 100 (make-date 2004 10 29) 0))

;case where we increase nominations from 0
(check-expect (update-nominations BLAIR 12) (make-film "The Blair Witch Project" "horror" "R" 81 BLAIRDATE 12))

;case where we increase nominations from 4
(check-expect (update-nominations GETOUT 20) (make-film "Get Out" "horror" "R" 104 GETDATE 20))

;case where we decrease nominations from 8
(check-expect (update-nominations ARRIVAL 0) (make-film "Arrival" "drama" "PG-13" 112 ARRIVEDATE 0))

;;Question 6

;;Using Helper functions to make code look nicer

;;openingDate : film --> opening-date
;;consumes a film a returns an opening-date of the film
(define (openingDate film)
  (film-opening-date film))
(check-expect (openingDate GETOUT)(make-date 2017 02 24))

;;YEAR : date --> date-year
;;consumes a date and returns a date-year for that date
(define (YEAR date)
  (date-year date))
(check-expect (YEAR (make-date 2012 01 02)) 2012)

;;MONTH : date --> date-month
;;consumes a date and returns a date-month for that date
(define (MONTH date)
  (date-month date))
(check-expect (MONTH (make-date 2012 01 02)) 01)

;;DAY : date --> date-day
;;consumes a date and returns a date-day for that date
(define (DAY date)
  (date-day date))
(check-expect (DAY (make-date 2012 01 02)) 02)

;;opened-after? : film date --> Boolean
;;Consumes a film and a date, and produces a Boolean
;;#true if the given film opened after the given date, and #false otherwise

(define (opened-after? film date)
  (or (> (YEAR (openingDate film)) (YEAR date)) ;;compares years
      
      (and (= (YEAR (openingDate film)) (YEAR date))
           (> (MONTH (openingDate film)) (MONTH date))) ;;if years are equal, compares months
      
      (and (= (YEAR (openingDate film)) (YEAR date))
           (= (MONTH (openingDate film)) (MONTH date))
           (> (DAY (openingDate film)) (DAY date))))) ;;if both years and months are equal, compares dates

;;case where year of given date is before movie release date
(check-expect (opened-after? GETOUT (make-date 2000 01 01)) #true)

;;case where year of given date is same as movie release date but month is before
(check-expect (opened-after? GETOUT (make-date 2017 01 01)) #true)

;;case where year and month of given date is same as movie release date but day is before
(check-expect (opened-after? GETOUT (make-date 2017 02 23)) #true)

;;case where year and month and day of given date is same as movie release date
(check-expect (opened-after? GETOUT (make-date 2017 02 24)) #false)

;;case where year and month of given date is ahead as movie release date
(check-expect (opened-after? GETOUT (make-date 2022 12 21)) #false)

;;Thank you!