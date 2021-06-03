--1 What grades are stored in the database?
select *
from Grade
--2 What emotions may be associated with a poem?
select *
from emotion
--3 How many poems are in the database?
select count(*) as NumberOfPoems
from poem
--4 Sort authors alphabetically by name. What are the names of the top 76 authors?
select top 76 author.name
from author
order by name
--5 Starting with the above query, add the grade of each of the authors.
select top 76 author.name, Grade.Name
from author
left join grade on grade.Id = Author.GradeId
order by Author.name

--6 Starting with the above query, add the recorded gender of each of the authors.
select top 76 author.name, Grade.Name, Gender.Name
from author
left join grade on grade.Id = Author.GradeId
left join Gender on author.GenderId = Gender.Id 
order by Author.name

--7 What is the total number of words in all poems in the database?
select sum(wordcount) as TotalNumberOfWords
from poem 

--8 Which poem has the fewest characters?
select poem.Title
from poem
where  poem.charcount = (
select min(poem.CharCount)
from poem)

--9 How many authors are in the third grade?
select count(*) 
from author
left join Grade on author.GradeId = grade.Id
where grade.name = '3rd grade'

--10 How many total authors are in the first through third grades?
select count(*) as TotalAuthors
from author
left join grade on Author.GradeId = grade.id 
where (grade.name = '1st grade' or grade.name = '2nd grade' or grade.name = '3rd grade')

--11 What is the total number of poems written by fourth graders?
select count(*) as TotalPoems
from poem
left join author on author.Id = poem.AuthorId
left join grade on grade.id = author.GradeId
where grade.name = '4th grade'

--12 How many poems are there per grade
select count(*) as TotalPoems, grade.name as Grade
from poem
left join author on author.Id = poem.AuthorId
left join grade on grade.id = author.GradeId
group by grade.name
order by Grade.Name

--13 How many authors are in each grade? (Order your results by grade starting with 1st Grade)
select count(*) as TotalAuthors, grade.name
from author
left join grade on grade.id = author.GradeId
group by grade.name
order by Grade.Name

--14 What is the title of the poem that has the most words?
select poem.title as Title,
len(poem.title) as Length
from poem
where len(poem.title) = (
select max(len(poem.title))
from poem)

--15 Which author(s) have the most poems? (Remember authors can have the same name.)
select top 1 count(*) as NumberOfPoems, author.id, author.name
from poem 
left join author on author.id = poem.AuthorId
group by author.id, author.name
order by NumberOfPoems desc


--16 How many poems have an emotion of sadness?
select count(*)
from PoemEmotion
left join emotion on PoemEmotion.emotionId = Emotion.Id
where emotion.Name = 'Sadness'

--17 How many poems are not associated with any emotion? NOTFINISHED
select count(*)
from poem
left join PoemEmotion on poem.id = poemEmotion.Id
left join emotion on PoemEmotion.EmotionId = emotion.id
where emotion.name = Null

--18 Which emotion is associated with the least number of poems?
select top 1 count(*) as NumberOfEmotions, emotion.name
from emotion
left join poemEmotion on emotion.id = PoemEmotion.EmotionId
group by emotion.name
order by NumberOfEmotions 

--19 Which grade has the largest number of poems with an emotion of joy?
select top 1 count(*) as NumberOfPoems, grade.name as Grade, emotion.Name as Emotion
from poem
left join author on poem.authorid = author.Id 
left join grade on author.GradeId = grade.Id
left join PoemEmotion on poem.id = PoemEmotion.poemId 
left join emotion on poemEmotion.EmotionId = emotion.id
Where emotion.name = 'Joy'
group by grade.name, emotion.Name
order by numberofpoems desc
--Which gender has the least number of poems with an emotion of fear?
select top 1 count(*) as numberOfPoems, gender.name as Gender, emotion.Name as Emotion
from poem 
left join author on Author.id = poem.authorid 
left join gender on gender.id = author.genderid 
left join PoemEmotion on poem.id = PoemEmotion.PoemId
left join emotion on PoemEmotion.EmotionId = emotion.id 
where emotion.name = 'fear'
group by gender.name, emotion.name
order by numberOfPoems 

select poem.content 
from poem 
