infiles = LOAD '/youtubepig/input/0222'
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

files = FILTER infiles BY category IS NOT NULL;

grpd = GROUP files BY category;

cnt = FOREACH grpd
    GENERATE group AS category,
    COUNT(files) AS total_videos;

sorted = ORDER cnt BY total_videos DESC;

top10 = LIMIT sorted 10;

DUMP top10;

STORE top10 INTO '/youtubepig/output/Top10Categories'
USING PigStorage('|');
