infiles = LOAD '/youtubepig/input/0222/0.txt'
USING PigStorage('\t')
AS (
    videoid:chararray,
    uploader:chararray,
    age:int,
    category:chararray,
    length:int,
    views:int,
    rate:float,
    ratings:int,
    comments:int,
    related_id:chararray
);

infiles1 = LOAD '/youtubepig/input/0222/1.txt'
USING PigStorage('\t')
AS (
    videoid:chararray,
    uploader:chararray,
    age:int,
    category:chararray,
    length:int,
    views:int,
    rate:float,
    ratings:int,
    comments:int,
    related_id:chararray
);

infiles2 = LOAD '/youtubepig/input/0222/2.txt'
USING PigStorage('\t')
AS (
    videoid:chararray,
    uploader:chararray,
    age:int,
    category:chararray,
    length:int,
    views:int,
    rate:float,
    ratings:int,
    comments:int,
    related_id:chararray
);

infiles3 = LOAD '/youtubepig/input/0222/3.txt'
USING PigStorage('\t')
AS (
    videoid:chararray,
    uploader:chararray,
    age:int,
    category:chararray,
    length:int,
    views:int,
    rate:float,
    ratings:int,
    comments:int,
    related_id:chararray
);

infiles4 = LOAD '/youtubepig/input/0222/4.txt'
USING PigStorage('\t')
AS (
    videoid:chararray,
    uploader:chararray,
    age:int,
    category:chararray,
    length:int,
    views:int,
    rate:float,
    ratings:int,
    comments:int,
    related_id:chararray
);

all_data = UNION infiles, infiles1, infiles2, infiles3, infiles4;

files = FILTER all_data BY category IS NOT NULL AND ratings IS NOT NULL;

grouped_categories = GROUP files BY category;

top10_rated_categories = FOREACH grouped_categories {
    sorted = ORDER files BY ratings DESC;
    top10 = LIMIT sorted 10;
    GENERATE FLATTEN(top10);
};

result = FOREACH top10_rated_categories
    GENERATE videoid, category, ratings;

STORE result INTO '/youtubepig/output/Top10RatedByCategories'
USING PigStorage('|');
