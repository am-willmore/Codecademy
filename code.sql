{\rtf1\ansi\ansicpg1252\cocoartf1671
{\fonttbl\f0\fnil\fcharset0 HelveticaNeue-Bold;\f1\fnil\fcharset0 HelveticaNeue;\f2\froman\fcharset0 Times-Bold;
\f3\froman\fcharset0 Times-Roman;\f4\fnil\fcharset0 HelveticaNeue-Italic;}
{\colortbl;\red255\green255\blue255;\red56\green56\blue56;\red255\green255\blue255;\red0\green0\blue0;
}
{\*\expandedcolortbl;;\cssrgb\c28235\c28235\c28235;\cssrgb\c100000\c100000\c100000;\cssrgb\c0\c0\c0;
}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\sl300\partightenfactor0

\f0\b\fs24 \cf2 \cb3 \expnd0\expndtw0\kerning0
/* 1.
\f1\b0\fs26\fsmilli13200 How many campaigns and sources does CoolTShirts use? Which source is used for each campaign?*/\
\
SELECT COUNT(DISTINCT utm_campaign )\
FROM page_visits;\
\
SELECT COUNT(DISTINCT utm_source )\
FROM page_visits;\
\
SELECT DISTINCT utm_source, \
  utm_campaign\
FROM page_visits\
GROUP BY 1;\cb1 \
\

\f0\b\fs24 \cb3 /* 2.
\f1\b0   
\fs26\fsmilli13200 What pages are on the CoolTShirts website?*/\cb1 \
\
\
SELECT DISTINCT page_name\
FROM page_visits;\
\
\pard\pardeftab720\sl280\partightenfactor0

\f2\b\fs24 \cf4 /* 3.
\f3\b0   
\f1\fs35\fsmilli17600 \cf2 \cb3 How many first touches is each campaign responsible for?*/\
\pard\pardeftab720\sl300\partightenfactor0

\fs26\fsmilli13200 \cf2 \cb1 \
WITH first_touch AS (\
    SELECT user_id,\
        MIN(timestamp) as first_touch_at\
    FROM page_visits\
    GROUP BY user_id)\
SELECT COUNT(*) AS 'number of touches', \
    pv.utm_source,\
    pv.utm_campaign\
FROM first_touch AS 'ft'\
JOIN page_visits AS 'pv'\
    ON ft.user_id = pv.user_id\
    AND ft.first_touch_at = pv.timestamp\
GROUP BY 3\
ORDER BY 1 DESC;\
\
/*
\f0\b\fs24 \cb3 4.
\f1\b0   
\fs26\fsmilli13200 How many last touches is each campaign responsible for?*/\cb1 \
\
WITH last_touch AS (\
    SELECT user_id,\
        MAX(timestamp) as last_touch_at\
    FROM page_visits\
    GROUP BY user_id)\
SELECT COUNT(*) AS number_of_last_touches, \
    pv.utm_source,\
    pv.utm_campaign\
FROM last_touch AS 'lt'\
JOIN page_visits AS 'pv'\
    ON lt.user_id = pv.user_id\
    AND lt.last_touch_at = pv.timestamp\
GROUP BY 3\
ORDER BY 1 DESC;\
\
/*
\f0\b\fs24 \cb3 5.
\f1\b0  
\fs26\fsmilli13200 How many visitors make a purchase?*/\
\
SELECT COUNT(*), page_name\
FROM page_visits\
WHERE page_name = '4 - purchase'\
GROUP BY page_name;\
\cb1 \

\f0\b\fs24 \cb3 /*6.
\f1\b0\fs26\fsmilli13200 How many last touches\'a0
\f4\i on the purchase page
\f1\i0 \'a0is each campaign responsible for?*/\cb1 \
\
WITH last_touch AS (\
    SELECT user_id,\
        MAX(timestamp) as last_touch_at\
    FROM page_visits\
    GROUP BY user_id)\
SELECT COUNT(*) AS number_of_last_touches, \
    pv.utm_source,\
		pv.utm_campaign\
FROM last_touch AS 'lt'\
JOIN page_visits AS 'pv'\
    ON lt.user_id = pv.user_id\
    AND lt.last_touch_at = pv.timestamp\
WHERE pv.page_name = '4 - purchase'    \
GROUP BY 3\
ORDER BY 1 DESC;\
\
\
\
\
\
\
\
\
}