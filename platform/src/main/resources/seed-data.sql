-- ============================================================================
-- VERITAS SEED DATA
-- Complete demo data for development and testing
-- ============================================================================

-- Clear existing data (order matters due to foreign keys)
DELETE FROM fact_checks;
DELETE FROM debate_votes;
DELETE FROM debate_arguments;
DELETE FROM debates;
DELETE FROM likes;
DELETE FROM posts;
DELETE FROM follows;
DELETE FROM users;

-- ============================================================================
-- USERS (8 total)
-- ============================================================================

INSERT INTO users (id, username, display_name, bio, avatar_url, trust_score, posts_fact_checked, posts_verified, posts_false, debates_won, debate_lost, created_at)
VALUES
    ('550e8400-e29b-41d4-a716-446655440001', 'scientist', 'Dr. Sarah Chen', 'Climate researcher at MIT. Facts matter.', 'https://api.dicebear.com/7.x/avataaars/svg?seed=scientist', 92.00, 25, 21, 2, 8, 2, datetime('now', '-30 days')),
    ('550e8400-e29b-41d4-a716-446655440002', 'journalist', 'Mike Thompson', 'Investigative journalist. 15 years at NYT. Seeking truth.', 'https://api.dicebear.com/7.x/avataaars/svg?seed=journalist', 78.00, 40, 18, 6, 5, 4, datetime('now', '-25 days')),
    ('550e8400-e29b-41d4-a716-446655440007', 'historian', 'Dr. Emily Park', 'History professor. Context is everything.', 'https://api.dicebear.com/7.x/avataaars/svg?seed=historian', 85.00, 18, 15, 1, 6, 1, datetime('now', '-28 days')),
    ('550e8400-e29b-41d4-a716-446655440003', 'techie', 'Alex Rivera', 'Software engineer and tech blogger. Hot takes on AI.', 'https://api.dicebear.com/7.x/avataaars/svg?seed=techie', 65.00, 15, 10, 3, 3, 5, datetime('now', '-20 days')),
    ('550e8400-e29b-41d4-a716-446655440004', 'skeptic', 'Jordan Hayes', 'Professional skeptic. Question everything.', 'https://api.dicebear.com/7.x/avataaars/svg?seed=skeptic', 55.00, 30, 8, 5, 12, 8, datetime('now', '-15 days')),
    ('550e8400-e29b-41d4-a716-446655440008', 'analyst', 'Sam Nakamura', 'Data analyst. Numbers dont lie, but people do.', 'https://api.dicebear.com/7.x/avataaars/svg?seed=analyst', 70.00, 22, 12, 4, 4, 3, datetime('now', '-18 days')),
    ('550e8400-e29b-41d4-a716-446655440005', 'newbie', 'Pat Morrison', 'Just joined! Learning the ropes.', 'https://api.dicebear.com/7.x/avataaars/svg?seed=newbie', 50.00, 2, 0, 0, 0, 1, datetime('now', '-5 days')),
    ('550e8400-e29b-41d4-a716-446655440006', 'contrarian', 'Chris Watts', 'Playing devils advocate since 1985. Debate me!', 'https://api.dicebear.com/7.x/avataaars/svg?seed=contrarian', 35.00, 20, 5, 8, 4, 10, datetime('now', '-10 days'));

-- ============================================================================
-- FOLLOWS (17 relationships)
-- ============================================================================

INSERT INTO follows (id, follower_id, following_id, created_at)
VALUES
    ('660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', datetime('now', '-20 days')),
    ('660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440001', datetime('now', '-18 days')),
    ('660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440001', datetime('now', '-3 days')),
    ('660e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440001', datetime('now', '-25 days')),
    ('660e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', datetime('now', '-22 days')),
    ('660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440002', datetime('now', '-12 days')),
    ('660e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440002', datetime('now', '-15 days')),
    ('660e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440003', datetime('now', '-8 days')),
    ('660e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440004', datetime('now', '-10 days')),
    ('660e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440004', datetime('now', '-7 days')),
    ('660e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440001', datetime('now', '-6 days')),
    ('660e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440002', datetime('now', '-5 days')),
    ('660e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440007', datetime('now', '-24 days')),
    ('660e8400-e29b-41d4-a716-446655440014', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440007', datetime('now', '-23 days')),
    ('660e8400-e29b-41d4-a716-446655440015', '550e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440001', datetime('now', '-16 days')),
    ('660e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440007', datetime('now', '-14 days')),
    ('660e8400-e29b-41d4-a716-446655440017', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440008', datetime('now', '-12 days'));

-- ============================================================================
-- POSTS (50 original posts)
-- ============================================================================

INSERT INTO posts (id, author_id, content, reply_to_id, repost_of_id, style, fact_check_status, fact_check_score, fact_check_data, was_checked_before, like_count, reply_count, repost_count, created_at)
VALUES
    -- SCIENTIST (8 posts)
    ('770e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001',
     'New study confirms global temperatures rose 1.1C since pre-industrial levels. The data is clear.',
     NULL, NULL, NULL, 'VERIFIED', 0.95,
     '{"sources":["IPCC AR6","NASA GISS"],"claim":"Global temps +1.1C","verdict":"Confirmed by multiple datasets"}',
     1, 45, 3, 8, datetime('now', '-29 days')),

    ('770e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001',
     'Peer-reviewed research shows Arctic ice loss accelerating at 13% per decade.',
     NULL, NULL, NULL, 'VERIFIED', 0.92,
     '{"sources":["NSIDC","Nature Climate Change"],"claim":"Arctic ice -13%/decade","verdict":"Accurate per satellite data"}',
     1, 38, 2, 5, datetime('now', '-25 days')),

    ('770e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440001',
     'Common misconception: weather is not climate. A cold winter does not disprove warming trends.',
     NULL, NULL, NULL, 'VERIFIED', 0.98,
     '{"sources":["NOAA","WMO"],"claim":"Weather != Climate","verdict":"Scientifically accurate distinction"}',
     1, 52, 4, 12, datetime('now', '-20 days')),

    ('770e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440001',
     'Our lab published findings on ocean acidification. pH dropped 0.1 units - thats 30% more acidic.',
     NULL, NULL, NULL, 'VERIFIED', 0.94,
     '{"sources":["Science Journal","NOAA PMEL"],"claim":"Ocean pH -0.1 = 30% acidity increase","verdict":"Logarithmic scale confirmed"}',
     1, 29, 1, 4, datetime('now', '-15 days')),

    ('770e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440001',
     'Excited to present at AGU next month. Will be sharing 5 years of temperature anomaly data.',
     NULL, NULL, NULL, 'UNCHECKED', NULL, NULL, 0, 18, 0, 1, datetime('now', '-10 days')),

    ('770e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440001',
     'For those asking: yes, renewable energy CAN meet global demand. See IPCC report section 4.3.',
     NULL, NULL, NULL, 'LIKELY_TRUE', 0.82,
     '{"sources":["IPCC SR15"],"claim":"Renewables can meet demand","verdict":"Technically possible, implementation challenges remain"}',
     1, 33, 2, 6, datetime('now', '-7 days')),

    ('770e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440001',
     'Thread: Let me explain the greenhouse effect in simple terms...',
     NULL, NULL, NULL, 'VERIFIED', 0.99,
     '{"sources":["Physics textbooks","NASA"],"claim":"Greenhouse effect explanation","verdict":"Accurate scientific explanation"}',
     1, 67, 1, 15, datetime('now', '-5 days')),

    ('770e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440001',
     'Coffee is essential for science. This is my most verified claim.',
     NULL, NULL, NULL, 'UNCHECKED', NULL, NULL, 0, 89, 5, 3, datetime('now', '-1 days')),

    -- JOURNALIST (8 posts)
    ('770e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440002',
     'BREAKING: City council votes 7-2 to approve new transit funding. $2.3B over 10 years.',
     NULL, NULL, NULL, 'VERIFIED', 0.97,
     '{"sources":["City Council Minutes","Official Press Release"],"claim":"7-2 vote, $2.3B transit","verdict":"Confirmed via official records"}',
     1, 56, 3, 22, datetime('now', '-24 days')),

    ('770e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440002',
     'Investigation update: Documents show company knew about safety issues 3 years before recall.',
     NULL, NULL, NULL, 'VERIFIED', 0.91,
     '{"sources":["Internal memos","FDA records"],"claim":"Company knew 3 years prior","verdict":"Documents support timeline"}',
     1, 78, 6, 31, datetime('now', '-22 days')),

    ('770e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440002',
     'Sources tell me the merger announcement is coming next week. Still confirming details.',
     NULL, NULL, NULL, 'LIKELY_TRUE', 0.75,
     '{"sources":["Anonymous sources"],"claim":"Merger next week","verdict":"Unconfirmed but credible sources"}',
     1, 42, 2, 8, datetime('now', '-18 days')),

    ('770e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440002',
     'Fact check: No, the new policy does NOT ban all imports. Here is what it actually says...',
     NULL, NULL, NULL, 'VERIFIED', 0.96,
     '{"sources":["Policy text","Legal analysis"],"claim":"Policy does not ban all imports","verdict":"Correct - only specific categories affected"}',
     1, 61, 2, 19, datetime('now', '-14 days')),

    ('770e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440002',
     'Interview with the whistleblower dropping tomorrow. 15 years of silence, finally speaking out.',
     NULL, NULL, NULL, 'UNCHECKED', NULL, NULL, 0, 93, 4, 12, datetime('now', '-11 days')),

    ('770e8400-e29b-41d4-a716-446655440014', '550e8400-e29b-41d4-a716-446655440002',
     'Unemployment figures out: 3.7% nationally, down from 3.9%. Regional breakdown in thread.',
     NULL, NULL, NULL, 'VERIFIED', 0.99,
     '{"sources":["Bureau of Labor Statistics"],"claim":"Unemployment 3.7%","verdict":"Official BLS data confirmed"}',
     1, 37, 1, 14, datetime('now', '-8 days')),

    ('770e8400-e29b-41d4-a716-446655440015', '550e8400-e29b-41d4-a716-446655440002',
     'Always verify before sharing. I have seen 3 fake screenshots today alone. Check your sources.',
     NULL, NULL, NULL, 'UNCHECKED', NULL, NULL, 0, 112, 3, 45, datetime('now', '-4 days')),

    ('770e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440002',
     'After 15 years in journalism: the truth is usually boring. Exciting claims need extra scrutiny.',
     NULL, NULL, NULL, 'UNCHECKED', NULL, NULL, 0, 156, 8, 52, datetime('now', '-2 days')),

    -- HISTORIAN (6 posts)
    ('770e8400-e29b-41d4-a716-446655440017', '550e8400-e29b-41d4-a716-446655440007',
     'The Great Wall of China is NOT visible from space with the naked eye. Common myth debunked by astronauts.',
     NULL, NULL, NULL, 'VERIFIED', 0.97,
     '{"sources":["NASA","Astronaut testimonies"],"claim":"Great Wall not visible from space","verdict":"Confirmed by multiple astronauts"}',
     1, 73, 2, 28, datetime('now', '-27 days')),

    ('770e8400-e29b-41d4-a716-446655440018', '550e8400-e29b-41d4-a716-446655440007',
     'Napoleon was not short. At 5 foot 7 he was average height for his era. British propaganda created the myth.',
     NULL, NULL, NULL, 'VERIFIED', 0.95,
     '{"sources":["Historical records","French archives"],"claim":"Napoleon average height","verdict":"5ft7 was average for 1800s France"}',
     1, 89, 3, 35, datetime('now', '-23 days')),

    ('770e8400-e29b-41d4-a716-446655440019', '550e8400-e29b-41d4-a716-446655440007',
     'The Library of Alexandria was not destroyed in one event. It declined over centuries due to budget cuts.',
     NULL, NULL, NULL, 'VERIFIED', 0.88,
     '{"sources":["Academic papers","Ancient sources"],"claim":"Library declined gradually","verdict":"Multiple factors over centuries"}',
     1, 64, 4, 18, datetime('now', '-19 days')),

    ('770e8400-e29b-41d4-a716-446655440020', '550e8400-e29b-41d4-a716-446655440007',
     'History does not repeat, but it rhymes. Current economic patterns mirror 1920s more than people realize.',
     NULL, NULL, NULL, 'LIKELY_TRUE', 0.72,
     '{"sources":["Economic analysis"],"claim":"Patterns mirror 1920s","verdict":"Some parallels exist, not exact match"}',
     1, 48, 5, 11, datetime('now', '-13 days')),

    ('770e8400-e29b-41d4-a716-446655440021', '550e8400-e29b-41d4-a716-446655440007',
     'Medieval people DID bathe. The dirty middle ages is a Renaissance-era smear campaign.',
     NULL, NULL, NULL, 'VERIFIED', 0.91,
     '{"sources":["Medieval texts","Archaeological evidence"],"claim":"Medieval bathing common","verdict":"Public baths well documented"}',
     1, 95, 2, 42, datetime('now', '-6 days')),

    ('770e8400-e29b-41d4-a716-446655440022', '550e8400-e29b-41d4-a716-446655440007',
     'Reading primary sources this weekend. Nothing humbles you like handwriting from 500 years ago.',
     NULL, NULL, NULL, 'UNCHECKED', NULL, NULL, 0, 34, 1, 2, datetime('now', '-3 days')),

    -- ANALYST (6 posts)
    ('770e8400-e29b-41d4-a716-446655440023', '550e8400-e29b-41d4-a716-446655440008',
     'Ran the numbers on housing prices: median home now costs 5.8x median income. In 1980 it was 3.1x.',
     NULL, NULL, NULL, 'VERIFIED', 0.94,
     '{"sources":["Census data","Federal Reserve"],"claim":"Housing 5.8x income vs 3.1x in 1980","verdict":"Data accurate per federal sources"}',
     1, 87, 4, 33, datetime('now', '-17 days')),

    ('770e8400-e29b-41d4-a716-446655440024', '550e8400-e29b-41d4-a716-446655440008',
     'That viral chart is misleading. Y-axis starts at 50%, making a 2% change look massive. Always check the axes.',
     NULL, NULL, NULL, 'VERIFIED', 0.96,
     '{"sources":["Original chart analysis"],"claim":"Chart Y-axis misleading","verdict":"Correct - truncated axis exaggerates change"}',
     1, 124, 3, 56, datetime('now', '-14 days')),

    ('770e8400-e29b-41d4-a716-446655440025', '550e8400-e29b-41d4-a716-446655440008',
     'Correlation: 0.89 between screen time and reported anxiety in teens. But correlation is not causation.',
     NULL, NULL, NULL, 'LIKELY_TRUE', 0.78,
     '{"sources":["Psychology studies"],"claim":"0.89 correlation screen time/anxiety","verdict":"Correlation exists, causation unclear"}',
     1, 56, 6, 12, datetime('now', '-11 days')),

    ('770e8400-e29b-41d4-a716-446655440026', '550e8400-e29b-41d4-a716-446655440008',
     'Sample size matters! That study everyone is sharing? n=47. Draw your own conclusions.',
     NULL, NULL, NULL, 'VERIFIED', 0.92,
     '{"sources":["Original study"],"claim":"Study had n=47","verdict":"Sample size confirmed, validity concerns raised"}',
     1, 67, 2, 23, datetime('now', '-8 days')),

    ('770e8400-e29b-41d4-a716-446655440027', '550e8400-e29b-41d4-a716-446655440008',
     'Built a model predicting Q3 earnings. 73% accuracy so far. Sharing methodology in comments.',
     NULL, NULL, NULL, 'UNCHECKED', NULL, NULL, 0, 29, 3, 4, datetime('now', '-5 days')),

    ('770e8400-e29b-41d4-a716-446655440028', '550e8400-e29b-41d4-a716-446655440008',
     'Data viz tip: if you cannot explain your chart in one sentence, it is too complicated.',
     NULL, NULL, NULL, 'UNCHECKED', NULL, NULL, 0, 78, 1, 31, datetime('now', '-2 days')),

    -- TECHIE (7 posts)
    ('770e8400-e29b-41d4-a716-446655440029', '550e8400-e29b-41d4-a716-446655440003',
     'Hot take: AI will replace 40% of jobs within 10 years. The automation wave is just starting.',
     NULL, NULL, NULL, 'DISPUTED', 0.45,
     '{"sources":["McKinsey","Oxford study"],"claim":"40% job replacement in 10 years","verdict":"Estimates vary widely (15-50%), 40% on high end"}',
     1, 134, 8, 28, datetime('now', '-19 days')),

    ('770e8400-e29b-41d4-a716-446655440030', '550e8400-e29b-41d4-a716-446655440003',
     'Just tested GPT-5. It passed the Turing test in my completely unscientific experiment.',
     NULL, NULL, NULL, 'LIKELY_TRUE', 0.65,
     '{"sources":["Anecdotal"],"claim":"GPT-5 passed Turing test","verdict":"Subjective test, not standardized"}',
     1, 89, 5, 15, datetime('now', '-16 days')),

    ('770e8400-e29b-41d4-a716-446655440031', '550e8400-e29b-41d4-a716-446655440003',
     'Unpopular opinion: Most blockchain projects are solutions looking for problems.',
     NULL, NULL, NULL, 'UNCHECKED', NULL, NULL, 0, 156, 12, 19, datetime('now', '-13 days')),

    ('770e8400-e29b-41d4-a716-446655440032', '550e8400-e29b-41d4-a716-446655440003',
     'Moores Law is not dead, it just moved to specialized chips. Look at TPU performance curves.',
     NULL, NULL, NULL, 'LIKELY_TRUE', 0.71,
     '{"sources":["Google TPU papers","Industry analysis"],"claim":"Moores Law in specialized chips","verdict":"Traditional CPU slowing, accelerators improving"}',
     1, 45, 3, 9, datetime('now', '-10 days')),

    ('770e8400-e29b-41d4-a716-446655440033', '550e8400-e29b-41d4-a716-446655440003',
     'The average app has 17 trackers. Your phone knows more about you than your therapist.',
     NULL, NULL, NULL, 'VERIFIED', 0.87,
     '{"sources":["Oxford Privacy Study","Exodus Privacy"],"claim":"Average 17 trackers per app","verdict":"Studies confirm 15-20 average"}',
     1, 201, 4, 78, datetime('now', '-7 days')),

    ('770e8400-e29b-41d4-a716-446655440034', '550e8400-e29b-41d4-a716-446655440003',
     'Quantum computing will break current encryption within 5 years. Banks are not ready.',
     NULL, NULL, NULL, 'DISPUTED', 0.38,
     '{"sources":["IBM","NIST"],"claim":"Encryption broken in 5 years","verdict":"Most experts say 10-20 years, 5 years unlikely"}',
     1, 78, 7, 12, datetime('now', '-4 days')),

    ('770e8400-e29b-41d4-a716-446655440035', '550e8400-e29b-41d4-a716-446655440003',
     'Code review tip: if you cannot explain why the code works, you do not understand it well enough.',
     NULL, NULL, NULL, 'UNCHECKED', NULL, NULL, 0, 234, 2, 89, datetime('now', '-1 days')),

    -- SKEPTIC (6 posts)
    ('770e8400-e29b-41d4-a716-446655440036', '550e8400-e29b-41d4-a716-446655440004',
     'Why does every new study contradict the last one? Maybe we should wait for replication before sharing.',
     NULL, NULL, NULL, 'UNCHECKED', NULL, NULL, 0, 89, 4, 11, datetime('now', '-14 days')),

    ('770e8400-e29b-41d4-a716-446655440037', '550e8400-e29b-41d4-a716-446655440004',
     'That 95% of scientists agree stat? I looked up the original study. The methodology is questionable.',
     NULL, NULL, NULL, 'DISPUTED', 0.52,
     '{"sources":["Cook et al 2013","Critiques"],"claim":"95% consensus methodology flawed","verdict":"Study has critics but methodology generally accepted"}',
     1, 67, 9, 8, datetime('now', '-12 days')),

    ('770e8400-e29b-41d4-a716-446655440038', '550e8400-e29b-41d4-a716-446655440004',
     'I am not saying the experts are wrong. I am saying blind trust in experts is also wrong.',
     NULL, NULL, NULL, 'UNCHECKED', NULL, NULL, 0, 145, 6, 23, datetime('now', '-9 days')),

    ('770e8400-e29b-41d4-a716-446655440039', '550e8400-e29b-41d4-a716-446655440004',
     'Follow the funding. Who paid for that research? Always relevant context.',
     NULL, NULL, NULL, 'UNCHECKED', NULL, NULL, 0, 78, 3, 14, datetime('now', '-6 days')),

    ('770e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440004',
     'Prediction markets are more accurate than expert panels. The data supports this consistently.',
     NULL, NULL, NULL, 'LIKELY_TRUE', 0.76,
     '{"sources":["Tetlock research","Metaculus data"],"claim":"Prediction markets beat experts","verdict":"Generally supported by research"}',
     1, 56, 4, 9, datetime('now', '-3 days')),

    ('770e8400-e29b-41d4-a716-446655440041', '550e8400-e29b-41d4-a716-446655440004',
     'Changed my mind on vaccine efficacy after reviewing the phase 3 data. Being wrong is fine. Staying wrong is not.',
     NULL, NULL, NULL, 'VERIFIED', 0.89,
     '{"sources":["FDA phase 3 data"],"claim":"Phase 3 data supports efficacy","verdict":"Data publicly available and verified"}',
     1, 178, 3, 45, datetime('now', '-1 days')),

    -- NEWBIE (3 posts)
    ('770e8400-e29b-41d4-a716-446655440042', '550e8400-e29b-41d4-a716-446655440005',
     'Just joined this platform! Excited to learn how fact-checking works. Any tips?',
     NULL, NULL, NULL, 'UNCHECKED', NULL, NULL, 0, 23, 2, 0, datetime('now', '-4 days')),

    ('770e8400-e29b-41d4-a716-446655440043', '550e8400-e29b-41d4-a716-446655440005',
     'I heard that goldfish have 3-second memories. Is that true or a myth?',
     NULL, NULL, NULL, 'FALSE', 0.12,
     '{"sources":["Marine biology studies"],"claim":"Goldfish 3-second memory","verdict":"Myth - goldfish remember for months"}',
     1, 45, 3, 2, datetime('now', '-3 days')),

    ('770e8400-e29b-41d4-a716-446655440044', '550e8400-e29b-41d4-a716-446655440005',
     'TIL goldfish actually have memories lasting months! Thanks for the corrections everyone.',
     NULL, NULL, NULL, 'VERIFIED', 0.94,
     '{"sources":["Plymouth University study"],"claim":"Goldfish memory lasts months","verdict":"Confirmed by multiple studies"}',
     1, 67, 1, 8, datetime('now', '-2 days')),

    -- CONTRARIAN (6 posts)
    ('770e8400-e29b-41d4-a716-446655440045', '550e8400-e29b-41d4-a716-446655440006',
     'The moon landing was real but the footage was faked because the real footage was too boring.',
     NULL, NULL, NULL, 'FALSE', 0.08,
     '{"sources":["NASA archives","Independent verification"],"claim":"Moon footage faked","verdict":"No evidence supports this - original footage verified"}',
     1, 34, 5, 5, datetime('now', '-9 days')),

    ('770e8400-e29b-41d4-a716-446655440046', '550e8400-e29b-41d4-a716-446655440006',
     'Hot take: Most healthy eating advice will be debunked in 20 years. Remember when fat was evil?',
     NULL, NULL, NULL, 'LIKELY_TRUE', 0.68,
     '{"sources":["Nutrition science history"],"claim":"Nutrition advice changes","verdict":"Historical pattern supports skepticism"}',
     1, 123, 4, 18, datetime('now', '-7 days')),

    ('770e8400-e29b-41d4-a716-446655440047', '550e8400-e29b-41d4-a716-446655440006',
     'Diamonds are worthless. The entire market is artificial scarcity created by De Beers.',
     NULL, NULL, NULL, 'DISPUTED', 0.55,
     '{"sources":["Economics papers","Industry analysis"],"claim":"Diamonds artificially scarce","verdict":"Partially true - market is controlled but gems have some intrinsic value"}',
     1, 89, 6, 12, datetime('now', '-5 days')),

    ('770e8400-e29b-41d4-a716-446655440048', '550e8400-e29b-41d4-a716-446655440006',
     'We only use 10% of our brains. I saw it in a documentary so it must be true.',
     NULL, NULL, NULL, 'FALSE', 0.05,
     '{"sources":["Neuroscience consensus"],"claim":"10% brain usage","verdict":"Complete myth - we use all of our brain"}',
     1, 12, 8, 3, datetime('now', '-4 days')),

    ('770e8400-e29b-41d4-a716-446655440049', '550e8400-e29b-41d4-a716-446655440006',
     'Debate me: pineapple on pizza is actually the optimal topping combination. I have data.',
     NULL, NULL, NULL, 'UNCHECKED', NULL, NULL, 0, 267, 15, 23, datetime('now', '-2 days')),

    ('770e8400-e29b-41d4-a716-446655440050', '550e8400-e29b-41d4-a716-446655440006',
     'Fine, I was wrong about the 10% brain thing. But I stand by my pizza opinions.',
     NULL, NULL, NULL, 'UNCHECKED', NULL, NULL, 0, 89, 3, 7, datetime('now', '-1 days'));

-- ============================================================================
-- THREADED REPLIES (12 replies)
-- ============================================================================

INSERT INTO posts (id, author_id, content, reply_to_id, repost_of_id, style, fact_check_status, fact_check_score, fact_check_data, was_checked_before, like_count, reply_count, repost_count, created_at)
VALUES
    ('880e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440004',
     'But what about the medieval warm period? Temperatures were higher then without industrialization.',
     '770e8400-e29b-41d4-a716-446655440001', NULL, NULL, 'DISPUTED', 0.42,
     '{"sources":["Paleoclimate data"],"claim":"Medieval period warmer","verdict":"Regional, not global - current warming is global"}',
     1, 23, 1, 2, datetime('now', '-29 days', '+2 hours')),

    ('880e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001',
     'The medieval warm period was regional (North Atlantic), not global. Current warming is unprecedented in global scope.',
     '880e8400-e29b-41d4-a716-446655440001', NULL, NULL, 'VERIFIED', 0.94,
     '{"sources":["PAGES 2k","Nature Geoscience"],"claim":"MWP was regional","verdict":"Confirmed by proxy records"}',
     1, 45, 0, 5, datetime('now', '-29 days', '+3 hours')),

    ('880e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440008',
     '40% seems high. McKinsey estimates 15% displacement, 30% augmentation. Big difference.',
     '770e8400-e29b-41d4-a716-446655440029', NULL, NULL, 'VERIFIED', 0.88,
     '{"sources":["McKinsey Global Institute"],"claim":"McKinsey says 15% displacement","verdict":"Accurate citation"}',
     1, 78, 2, 12, datetime('now', '-19 days', '+4 hours')),

    ('880e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440003',
     'Fair point on the distinction. But augmentation often leads to displacement in the next cycle.',
     '880e8400-e29b-41d4-a716-446655440003', NULL, NULL, 'LIKELY_TRUE', 0.72,
     '{"sources":["Historical automation data"],"claim":"Augmentation leads to displacement","verdict":"Pattern exists but not universal"}',
     1, 34, 1, 4, datetime('now', '-19 days', '+5 hours')),

    ('880e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440002',
     'We saw this with journalism too. AI will help reporters became AI writes the articles now.',
     '880e8400-e29b-41d4-a716-446655440004', NULL, NULL, 'UNCHECKED', NULL, NULL, 0, 56, 0, 8, datetime('now', '-19 days', '+6 hours')),

    ('880e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440007',
     'The footage was not faked. We have independent verification from multiple countries including the USSR.',
     '770e8400-e29b-41d4-a716-446655440045', NULL, NULL, 'VERIFIED', 0.98,
     '{"sources":["Soviet space program records","Independent tracking"],"claim":"USSR verified landing","verdict":"Confirmed - Soviets tracked mission"}',
     1, 156, 1, 34, datetime('now', '-9 days', '+2 hours')),

    ('880e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440006',
     'I was being sarcastic but apparently that does not come through in text. Of course we went to the moon!',
     '880e8400-e29b-41d4-a716-446655440006', NULL, NULL, 'UNCHECKED', NULL, NULL, 0, 89, 0, 5, datetime('now', '-9 days', '+3 hours')),

    ('880e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440001',
     'Goldfish can actually remember things for months! Studies show they can learn complex tasks. Welcome!',
     '770e8400-e29b-41d4-a716-446655440043', NULL, NULL, 'VERIFIED', 0.96,
     '{"sources":["Plymouth University study","Animal cognition research"],"claim":"Goldfish memory months","verdict":"Confirmed by multiple studies"}',
     1, 34, 1, 5, datetime('now', '-3 days', '+1 hours')),

    ('880e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440007',
     'The 3-second myth likely comes from a 1950s advertising campaign. Another example of how misinformation spreads!',
     '880e8400-e29b-41d4-a716-446655440008', NULL, NULL, 'LIKELY_TRUE', 0.75,
     '{"sources":["Historical research"],"claim":"Myth from 1950s ads","verdict":"Plausible origin but hard to verify"}',
     1, 28, 0, 3, datetime('now', '-3 days', '+2 hours')),

    ('880e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440005',
     'How do you verify screenshots? Is there a tool you recommend for beginners?',
     '770e8400-e29b-41d4-a716-446655440015', NULL, NULL, 'UNCHECKED', NULL, NULL, 0, 12, 1, 0, datetime('now', '-4 days', '+1 hours')),

    ('880e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440002',
     'Great question! 1) Check the original source 2) Use reverse image search 3) Look at metadata 4) Be extra skeptical of things that confirm your biases.',
     '880e8400-e29b-41d4-a716-446655440010', NULL, NULL, 'UNCHECKED', NULL, NULL, 0, 67, 0, 15, datetime('now', '-4 days', '+2 hours')),

    ('880e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440004',
     'Interesting that you mention prediction markets. What is your take on Polymarket accuracy?',
     '770e8400-e29b-41d4-a716-446655440040', NULL, NULL, 'UNCHECKED', NULL, NULL, 0, 19, 0, 1, datetime('now', '-3 days', '+1 hours'));

-- ============================================================================
-- LIKES (75 total)
-- ============================================================================

INSERT INTO likes (id, user_id, post_id, created_at)
VALUES
    ('990e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440001', datetime('now', '-29 days', '+1 hour')),
    ('990e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440007', '770e8400-e29b-41d4-a716-446655440001', datetime('now', '-29 days', '+2 hours')),
    ('990e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440008', '770e8400-e29b-41d4-a716-446655440001', datetime('now', '-29 days', '+3 hours')),
    ('990e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440003', '770e8400-e29b-41d4-a716-446655440001', datetime('now', '-28 days')),
    ('990e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440005', '770e8400-e29b-41d4-a716-446655440001', datetime('now', '-27 days')),
    ('990e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440002', datetime('now', '-25 days', '+1 hour')),
    ('990e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440007', '770e8400-e29b-41d4-a716-446655440002', datetime('now', '-25 days', '+2 hours')),
    ('990e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440008', '770e8400-e29b-41d4-a716-446655440002', datetime('now', '-24 days')),
    ('990e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440003', datetime('now', '-20 days', '+1 hour')),
    ('990e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440004', '770e8400-e29b-41d4-a716-446655440003', datetime('now', '-20 days', '+2 hours')),
    ('990e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440005', '770e8400-e29b-41d4-a716-446655440003', datetime('now', '-19 days')),
    ('990e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440006', '770e8400-e29b-41d4-a716-446655440003', datetime('now', '-18 days')),
    ('990e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440009', datetime('now', '-24 days', '+1 hour')),
    ('990e8400-e29b-41d4-a716-446655440014', '550e8400-e29b-41d4-a716-446655440007', '770e8400-e29b-41d4-a716-446655440009', datetime('now', '-24 days', '+2 hours')),
    ('990e8400-e29b-41d4-a716-446655440015', '550e8400-e29b-41d4-a716-446655440008', '770e8400-e29b-41d4-a716-446655440009', datetime('now', '-23 days')),
    ('990e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440003', '770e8400-e29b-41d4-a716-446655440009', datetime('now', '-22 days')),
    ('990e8400-e29b-41d4-a716-446655440017', '550e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440010', datetime('now', '-22 days', '+1 hour')),
    ('990e8400-e29b-41d4-a716-446655440018', '550e8400-e29b-41d4-a716-446655440004', '770e8400-e29b-41d4-a716-446655440010', datetime('now', '-21 days')),
    ('990e8400-e29b-41d4-a716-446655440019', '550e8400-e29b-41d4-a716-446655440005', '770e8400-e29b-41d4-a716-446655440010', datetime('now', '-20 days')),
    ('990e8400-e29b-41d4-a716-446655440020', '550e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440016', datetime('now', '-2 days', '+1 hour')),
    ('990e8400-e29b-41d4-a716-446655440021', '550e8400-e29b-41d4-a716-446655440007', '770e8400-e29b-41d4-a716-446655440016', datetime('now', '-2 days', '+2 hours')),
    ('990e8400-e29b-41d4-a716-446655440022', '550e8400-e29b-41d4-a716-446655440008', '770e8400-e29b-41d4-a716-446655440016', datetime('now', '-2 days', '+3 hours')),
    ('990e8400-e29b-41d4-a716-446655440023', '550e8400-e29b-41d4-a716-446655440003', '770e8400-e29b-41d4-a716-446655440016', datetime('now', '-1 days')),
    ('990e8400-e29b-41d4-a716-446655440024', '550e8400-e29b-41d4-a716-446655440004', '770e8400-e29b-41d4-a716-446655440016', datetime('now', '-1 days', '+1 hour')),
    ('990e8400-e29b-41d4-a716-446655440025', '550e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440017', datetime('now', '-27 days', '+1 hour')),
    ('990e8400-e29b-41d4-a716-446655440026', '550e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440017', datetime('now', '-27 days', '+2 hours')),
    ('990e8400-e29b-41d4-a716-446655440027', '550e8400-e29b-41d4-a716-446655440008', '770e8400-e29b-41d4-a716-446655440017', datetime('now', '-26 days')),
    ('990e8400-e29b-41d4-a716-446655440028', '550e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440018', datetime('now', '-23 days', '+1 hour')),
    ('990e8400-e29b-41d4-a716-446655440029', '550e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440018', datetime('now', '-22 days')),
    ('990e8400-e29b-41d4-a716-446655440030', '550e8400-e29b-41d4-a716-446655440003', '770e8400-e29b-41d4-a716-446655440018', datetime('now', '-21 days')),
    ('990e8400-e29b-41d4-a716-446655440031', '550e8400-e29b-41d4-a716-446655440006', '770e8400-e29b-41d4-a716-446655440018', datetime('now', '-20 days')),
    ('990e8400-e29b-41d4-a716-446655440032', '550e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440021', datetime('now', '-6 days', '+1 hour')),
    ('990e8400-e29b-41d4-a716-446655440033', '550e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440021', datetime('now', '-6 days', '+2 hours')),
    ('990e8400-e29b-41d4-a716-446655440034', '550e8400-e29b-41d4-a716-446655440003', '770e8400-e29b-41d4-a716-446655440021', datetime('now', '-5 days')),
    ('990e8400-e29b-41d4-a716-446655440035', '550e8400-e29b-41d4-a716-446655440005', '770e8400-e29b-41d4-a716-446655440021', datetime('now', '-4 days')),
    ('990e8400-e29b-41d4-a716-446655440036', '550e8400-e29b-41d4-a716-446655440004', '770e8400-e29b-41d4-a716-446655440029', datetime('now', '-19 days', '+1 hour')),
    ('990e8400-e29b-41d4-a716-446655440037', '550e8400-e29b-41d4-a716-446655440008', '770e8400-e29b-41d4-a716-446655440029', datetime('now', '-19 days', '+2 hours')),
    ('990e8400-e29b-41d4-a716-446655440038', '550e8400-e29b-41d4-a716-446655440006', '770e8400-e29b-41d4-a716-446655440029', datetime('now', '-18 days')),
    ('990e8400-e29b-41d4-a716-446655440039', '550e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440033', datetime('now', '-7 days', '+1 hour')),
    ('990e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440033', datetime('now', '-7 days', '+2 hours')),
    ('990e8400-e29b-41d4-a716-446655440041', '550e8400-e29b-41d4-a716-446655440004', '770e8400-e29b-41d4-a716-446655440033', datetime('now', '-6 days')),
    ('990e8400-e29b-41d4-a716-446655440042', '550e8400-e29b-41d4-a716-446655440007', '770e8400-e29b-41d4-a716-446655440033', datetime('now', '-5 days')),
    ('990e8400-e29b-41d4-a716-446655440043', '550e8400-e29b-41d4-a716-446655440008', '770e8400-e29b-41d4-a716-446655440033', datetime('now', '-4 days')),
    ('990e8400-e29b-41d4-a716-446655440044', '550e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440035', datetime('now', '-1 days', '+1 hour')),
    ('990e8400-e29b-41d4-a716-446655440045', '550e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440035', datetime('now', '-1 days', '+2 hours')),
    ('990e8400-e29b-41d4-a716-446655440046', '550e8400-e29b-41d4-a716-446655440008', '770e8400-e29b-41d4-a716-446655440035', datetime('now', '-1 days', '+3 hours')),
    ('990e8400-e29b-41d4-a716-446655440047', '550e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440023', datetime('now', '-17 days', '+1 hour')),
    ('990e8400-e29b-41d4-a716-446655440048', '550e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440023', datetime('now', '-17 days', '+2 hours')),
    ('990e8400-e29b-41d4-a716-446655440049', '550e8400-e29b-41d4-a716-446655440003', '770e8400-e29b-41d4-a716-446655440023', datetime('now', '-16 days')),
    ('990e8400-e29b-41d4-a716-446655440050', '550e8400-e29b-41d4-a716-446655440004', '770e8400-e29b-41d4-a716-446655440023', datetime('now', '-15 days')),
    ('990e8400-e29b-41d4-a716-446655440051', '550e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440024', datetime('now', '-14 days', '+1 hour')),
    ('990e8400-e29b-41d4-a716-446655440052', '550e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440024', datetime('now', '-14 days', '+2 hours')),
    ('990e8400-e29b-41d4-a716-446655440053', '550e8400-e29b-41d4-a716-446655440003', '770e8400-e29b-41d4-a716-446655440024', datetime('now', '-13 days')),
    ('990e8400-e29b-41d4-a716-446655440054', '550e8400-e29b-41d4-a716-446655440007', '770e8400-e29b-41d4-a716-446655440024', datetime('now', '-12 days')),
    ('990e8400-e29b-41d4-a716-446655440055', '550e8400-e29b-41d4-a716-446655440003', '770e8400-e29b-41d4-a716-446655440038', datetime('now', '-9 days', '+1 hour')),
    ('990e8400-e29b-41d4-a716-446655440056', '550e8400-e29b-41d4-a716-446655440006', '770e8400-e29b-41d4-a716-446655440038', datetime('now', '-9 days', '+2 hours')),
    ('990e8400-e29b-41d4-a716-446655440057', '550e8400-e29b-41d4-a716-446655440008', '770e8400-e29b-41d4-a716-446655440038', datetime('now', '-8 days')),
    ('990e8400-e29b-41d4-a716-446655440058', '550e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440041', datetime('now', '-1 days', '+1 hour')),
    ('990e8400-e29b-41d4-a716-446655440059', '550e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440041', datetime('now', '-1 days', '+2 hours')),
    ('990e8400-e29b-41d4-a716-446655440060', '550e8400-e29b-41d4-a716-446655440007', '770e8400-e29b-41d4-a716-446655440041', datetime('now', '-1 days', '+3 hours')),
    ('990e8400-e29b-41d4-a716-446655440061', '550e8400-e29b-41d4-a716-446655440008', '770e8400-e29b-41d4-a716-446655440041', datetime('now', '-1 days', '+4 hours')),
    ('990e8400-e29b-41d4-a716-446655440062', '550e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440042', datetime('now', '-4 days', '+1 hour')),
    ('990e8400-e29b-41d4-a716-446655440063', '550e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440042', datetime('now', '-4 days', '+2 hours')),
    ('990e8400-e29b-41d4-a716-446655440064', '550e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440044', datetime('now', '-2 days', '+1 hour')),
    ('990e8400-e29b-41d4-a716-446655440065', '550e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440044', datetime('now', '-2 days', '+2 hours')),
    ('990e8400-e29b-41d4-a716-446655440066', '550e8400-e29b-41d4-a716-446655440007', '770e8400-e29b-41d4-a716-446655440044', datetime('now', '-2 days', '+3 hours')),
    ('990e8400-e29b-41d4-a716-446655440067', '550e8400-e29b-41d4-a716-446655440003', '770e8400-e29b-41d4-a716-446655440046', datetime('now', '-7 days', '+1 hour')),
    ('990e8400-e29b-41d4-a716-446655440068', '550e8400-e29b-41d4-a716-446655440004', '770e8400-e29b-41d4-a716-446655440046', datetime('now', '-7 days', '+2 hours')),
    ('990e8400-e29b-41d4-a716-446655440069', '550e8400-e29b-41d4-a716-446655440008', '770e8400-e29b-41d4-a716-446655440046', datetime('now', '-6 days')),
    ('990e8400-e29b-41d4-a716-446655440070', '550e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440049', datetime('now', '-2 days', '+1 hour')),
    ('990e8400-e29b-41d4-a716-446655440071', '550e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440049', datetime('now', '-2 days', '+2 hours')),
    ('990e8400-e29b-41d4-a716-446655440072', '550e8400-e29b-41d4-a716-446655440003', '770e8400-e29b-41d4-a716-446655440049', datetime('now', '-2 days', '+3 hours')),
    ('990e8400-e29b-41d4-a716-446655440073', '550e8400-e29b-41d4-a716-446655440004', '770e8400-e29b-41d4-a716-446655440049', datetime('now', '-2 days', '+4 hours')),
    ('990e8400-e29b-41d4-a716-446655440074', '550e8400-e29b-41d4-a716-446655440007', '770e8400-e29b-41d4-a716-446655440049', datetime('now', '-1 days')),
    ('990e8400-e29b-41d4-a716-446655440075', '550e8400-e29b-41d4-a716-446655440008', '770e8400-e29b-41d4-a716-446655440049', datetime('now', '-1 days', '+1 hour'));

-- ============================================================================
-- DEBATES (1 completed, 1 active in voting, 1 active in progress)
-- ============================================================================

-- Debate 1: COMPLETED - skeptic challenged scientist on climate data
INSERT INTO debates (id, topic, challenger_id, defender_id, status, current_round, whose_turn_id, winner_id, votes_challenger, votes_defender, votes_tie, voting_ends_at, created_at)
VALUES
    ('aa0e8400-e29b-41d4-a716-446655440001',
     'Is the 1.1C temperature rise figure reliable given measurement methodology changes?',
     '550e8400-e29b-41d4-a716-446655440004',
     '550e8400-e29b-41d4-a716-446655440001',
     'COMPLETED',
     3,
     NULL,
     '550e8400-e29b-41d4-a716-446655440001',
     12, 28, 5,
     datetime('now', '-24 days'),
     datetime('now', '-28 days'));

-- Debate 2: VOTING - analyst challenged techie on AI job replacement
INSERT INTO debates (id, topic, challenger_id, defender_id, status, current_round, whose_turn_id, winner_id, votes_challenger, votes_defender, votes_tie, voting_ends_at, created_at)
VALUES
    ('aa0e8400-e29b-41d4-a716-446655440002',
     'Will AI really replace 40% of jobs in 10 years, or is this an exaggeration?',
     '550e8400-e29b-41d4-a716-446655440008',
     '550e8400-e29b-41d4-a716-446655440003',
     'VOTING',
     3,
     NULL,
     NULL,
     8, 6, 3,
     datetime('now', '+12 hours'),
     datetime('now', '-18 days'));

-- Debate 3: ACTIVE - contrarian challenged historian on medieval bathing
INSERT INTO debates (id, topic, challenger_id, defender_id, status, current_round, whose_turn_id, winner_id, votes_challenger, votes_defender, votes_tie, voting_ends_at, created_at)
VALUES
    ('aa0e8400-e29b-41d4-a716-446655440003',
     'Did medieval people really bathe regularly, or is this revisionist history?',
     '550e8400-e29b-41d4-a716-446655440006',
     '550e8400-e29b-41d4-a716-446655440007',
     'ACTIVE',
     2,
     '550e8400-e29b-41d4-a716-446655440006',
     NULL,
     0, 0, 0,
     NULL,
     datetime('now', '-5 days'));

-- ============================================================================
-- DEBATE ARGUMENTS
-- ============================================================================

-- Debate 1 Arguments (COMPLETED - all 6 arguments)
INSERT INTO debate_arguments (id, debate_id, user_id, round_number, content, fact_check_status, fact_check_score, fact_check_data, created_at)
VALUES
    -- Round 1: Challenger (skeptic) first
    ('bb0e8400-e29b-41d4-a716-446655440001',
     'aa0e8400-e29b-41d4-a716-446655440001',
     '550e8400-e29b-41d4-a716-446655440004',
     1,
     'The temperature measurement methodology has changed significantly since pre-industrial times. We are comparing ship bucket measurements to satellite data. How can we trust a 1.1C figure with such inconsistent methods?',
     'LIKELY_TRUE', 0.72,
     '{"sources":["journals.ametsoc.org"],"claim":"Methodology changed significantly","verdict":"True that methods changed, but adjustments are made"}',
     datetime('now', '-28 days', '+1 hour')),

    -- Round 1: Defender (scientist) responds
    ('bb0e8400-e29b-41d4-a716-446655440002',
     'aa0e8400-e29b-41d4-a716-446655440001',
     '550e8400-e29b-41d4-a716-446655440001',
     1,
     'Great question! Scientists use homogenization techniques to account for measurement changes. Multiple independent datasets (NASA, NOAA, Berkeley Earth) using different methods all converge on the same 1.1C figure.',
     'VERIFIED', 0.95,
     '{"sources":["NASA GISS","NOAA","Berkeley Earth"],"claim":"Independent datasets converge","verdict":"Confirmed - multiple independent analyses agree"}',
     datetime('now', '-28 days', '+3 hours')),

    -- Round 2: Defender (scientist) first
    ('bb0e8400-e29b-41d4-a716-446655440003',
     'aa0e8400-e29b-41d4-a716-446655440001',
     '550e8400-e29b-41d4-a716-446655440001',
     2,
     'Furthermore, we have proxy data from ice cores, tree rings, and coral that independently verify the temperature record. These natural archives show the same warming pattern.',
     'VERIFIED', 0.93,
     '{"sources":["PAGES 2k","Nature Geoscience"],"claim":"Proxy data confirms warming","verdict":"Multiple proxy records support temperature reconstruction"}',
     datetime('now', '-27 days')),

    -- Round 2: Challenger (skeptic) responds
    ('bb0e8400-e29b-41d4-a716-446655440004',
     'aa0e8400-e29b-41d4-a716-446655440001',
     '550e8400-e29b-41d4-a716-446655440004',
     2,
     'But homogenization itself introduces assumptions. And urban heat island effects could bias ground stations upward. Satellites show less warming than surface stations.',
     'DISPUTED', 0.55,
     '{"sources":["Various"],"claim":"Satellites show less warming","verdict":"After corrections, satellite and surface data largely agree"}',
     datetime('now', '-26 days', '+12 hours')),

    -- Round 3: Challenger (skeptic) first
    ('bb0e8400-e29b-41d4-a716-446655440005',
     'aa0e8400-e29b-41d4-a716-446655440001',
     '550e8400-e29b-41d4-a716-446655440004',
     3,
     'I concede the convergence point is compelling. However, the uncertainty ranges in these measurements are larger than often acknowledged. Should we be making trillion-dollar policy decisions based on 0.1C precision?',
     'LIKELY_TRUE', 0.68,
     '{"sources":["IPCC uncertainty analysis"],"claim":"Large uncertainty ranges","verdict":"Uncertainty exists but is quantified and accounted for"}',
     datetime('now', '-25 days')),

    -- Round 3: Defender (scientist) responds
    ('bb0e8400-e29b-41d4-a716-446655440006',
     'aa0e8400-e29b-41d4-a716-446655440001',
     '550e8400-e29b-41d4-a716-446655440001',
     3,
     'Urban heat island is accounted for - rural-only stations show the same trend. As for satellites: after correcting for orbital decay and calibration issues, UAH and RSS satellite data now closely match surface records. The 1.1C figure has well-quantified uncertainty of plus or minus 0.1C.',
     'VERIFIED', 0.96,
     '{"sources":["carbonbrief.org","RSS","UAH"],"claim":"Satellite data now matches surface","verdict":"After corrections, good agreement between datasets"}',
     datetime('now', '-24 days', '+6 hours'));

-- Debate 2 Arguments (VOTING - all 6 arguments complete)
INSERT INTO debate_arguments (id, debate_id, user_id, round_number, content, fact_check_status, fact_check_score, fact_check_data, created_at)
VALUES
    -- Round 1: Challenger (analyst) first
    ('bb0e8400-e29b-41d4-a716-446655440007',
     'aa0e8400-e29b-41d4-a716-446655440002',
     '550e8400-e29b-41d4-a716-446655440008',
     1,
     'The 40% figure seems to conflate tasks automated with jobs eliminated. McKinsey estimates 15% displacement, 30% significant change. That is very different from 40% replacement.',
     'VERIFIED', 0.88,
     '{"sources":["McKinsey Global Institute"],"claim":"McKinsey says 15% displacement","verdict":"Accurate citation of McKinsey report"}',
     datetime('now', '-18 days', '+1 hour')),

    -- Round 1: Defender (techie) responds
    ('bb0e8400-e29b-41d4-a716-446655440008',
     'aa0e8400-e29b-41d4-a716-446655440002',
     '550e8400-e29b-41d4-a716-446655440003',
     1,
     'Fair distinction on terminology. But historical patterns show augmentation often becomes replacement in 5-10 years. Bank tellers, travel agents, switchboard operators - all were augmented before being largely replaced.',
     'LIKELY_TRUE', 0.72,
     '{"sources":["BLS historical data"],"claim":"Augmentation leads to replacement","verdict":"Pattern exists in some industries, not universal"}',
     datetime('now', '-17 days')),

    -- Round 2: Defender (techie) first
    ('bb0e8400-e29b-41d4-a716-446655440009',
     'aa0e8400-e29b-41d4-a716-446655440002',
     '550e8400-e29b-41d4-a716-446655440003',
     2,
     'Consider the pace of change. GPT-3 to GPT-4 happened in 18 months. We went from AI cannot write code to AI writes production code in 3 years. Exponential improvement means predictions based on linear extrapolation will be wrong.',
     'LIKELY_TRUE', 0.70,
     '{"sources":["OpenAI timeline"],"claim":"Exponential AI improvement","verdict":"Rapid progress documented, exponential vs linear debatable"}',
     datetime('now', '-15 days')),

    -- Round 2: Challenger (analyst) responds
    ('bb0e8400-e29b-41d4-a716-446655440010',
     'aa0e8400-e29b-41d4-a716-446655440002',
     '550e8400-e29b-41d4-a716-446655440008',
     2,
     'Those examples took 20-30 years, not 10. And they were narrow automation. LLMs are general-purpose but still make significant errors. Radiologists were supposed to be replaced 5 years ago.',
     'VERIFIED', 0.85,
     '{"sources":["Historical employment data","AI radiology studies"],"claim":"Automation takes longer than predicted","verdict":"Multiple examples of overestimated automation timelines"}',
     datetime('now', '-13 days')),

    -- Round 3: Challenger (analyst) first
    ('bb0e8400-e29b-41d4-a716-446655440011',
     'aa0e8400-e29b-41d4-a716-446655440002',
     '550e8400-e29b-41d4-a716-446655440008',
     3,
     'The radiology example is telling. In 2016, Hinton said we should stop training radiologists. Today there are more radiologists than ever. AI became a tool, not a replacement. This pattern will repeat.',
     'VERIFIED', 0.91,
     '{"sources":["Hinton 2016 quote","BLS radiology employment"],"claim":"Radiologist employment grew despite AI","verdict":"Accurate - radiologist employment has increased"}',
     datetime('now', '-11 days')),

    -- Round 3: Defender (techie) responds
    ('bb0e8400-e29b-41d4-a716-446655440012',
     'aa0e8400-e29b-41d4-a716-446655440002',
     '550e8400-e29b-41d4-a716-446655440003',
     3,
     'The radiology prediction was premature, I will grant that. But GPT-4 to GPT-5 was a bigger jump than GPT-3 to GPT-4. The capability curve is steepening. I maintain significant disruption will occur within 10 years.',
     'DISPUTED', 0.52,
     '{"sources":["OpenAI benchmarks"],"claim":"GPT-5 bigger jump than GPT-4","verdict":"Subjective - depends on metrics used"}',
     datetime('now', '-9 days'));

-- Debate 3 Arguments (ACTIVE - Round 2 in progress, waiting for challenger)
INSERT INTO debate_arguments (id, debate_id, user_id, round_number, content, fact_check_status, fact_check_score, fact_check_data, created_at)
VALUES
    -- Round 1: Challenger (contrarian) first
    ('bb0e8400-e29b-41d4-a716-446655440013',
     'aa0e8400-e29b-41d4-a716-446655440003',
     '550e8400-e29b-41d4-a716-446655440006',
     1,
     'The dirty medieval myth exists for a reason. Public bathhouses closed during plague outbreaks because they spread disease. By the late medieval period, bathing was rare in most of Europe.',
     'DISPUTED', 0.48,
     '{"sources":["Medieval history texts"],"claim":"Bathing rare in late medieval","verdict":"Oversimplified - bathing practices varied by region and class"}',
     datetime('now', '-5 days', '+2 hours')),

    -- Round 1: Defender (historian) responds
    ('bb0e8400-e29b-41d4-a716-446655440014',
     'aa0e8400-e29b-41d4-a716-446655440003',
     '550e8400-e29b-41d4-a716-446655440007',
     1,
     'The bathhouse closures during plague were temporary and localized. Archaeological evidence shows widespread use of bathing implements throughout the medieval period. Personal hygiene manuals from the era emphasize cleanliness.',
     'VERIFIED', 0.89,
     '{"sources":["Archaeological surveys","Medieval hygiene manuscripts"],"claim":"Widespread bathing evidence","verdict":"Multiple sources confirm bathing was common"}',
     datetime('now', '-4 days')),

    -- Round 2: Defender (historian) first
    ('bb0e8400-e29b-41d4-a716-446655440015',
     'aa0e8400-e29b-41d4-a716-446655440003',
     '550e8400-e29b-41d4-a716-446655440007',
     2,
     'The dirty medieval stereotype was largely created during the Renaissance as propaganda to make the prior era seem backward. Its similar to how the dark ages myth was constructed. Primary sources from the period tell a different story.',
     'VERIFIED', 0.86,
     '{"sources":["Historiography studies"],"claim":"Renaissance propaganda created myth","verdict":"Scholarly consensus supports this interpretation"}',
     datetime('now', '-3 days'));

-- ============================================================================
-- DEBATE VOTES (for completed and voting debates)
-- ============================================================================

INSERT INTO debate_votes (id, debate_id, user_id, vote, created_at)
VALUES
    -- Votes for Debate 1 (COMPLETED)
    ('cc0e8400-e29b-41d4-a716-446655440001', 'aa0e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', 'DEFENDER', datetime('now', '-25 days')),
    ('cc0e8400-e29b-41d4-a716-446655440002', 'aa0e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440003', 'DEFENDER', datetime('now', '-25 days', '+1 hour')),
    ('cc0e8400-e29b-41d4-a716-446655440003', 'aa0e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', 'CHALLENGER', datetime('now', '-25 days', '+2 hours')),
    ('cc0e8400-e29b-41d4-a716-446655440004', 'aa0e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440007', 'DEFENDER', datetime('now', '-24 days', '+6 hours')),
    ('cc0e8400-e29b-41d4-a716-446655440005', 'aa0e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440008', 'DEFENDER', datetime('now', '-24 days', '+8 hours')),

    -- Votes for Debate 2 (VOTING)
    ('cc0e8400-e29b-41d4-a716-446655440006', 'aa0e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', 'CHALLENGER', datetime('now', '-8 days')),
    ('cc0e8400-e29b-41d4-a716-446655440007', 'aa0e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002', 'CHALLENGER', datetime('now', '-7 days')),
    ('cc0e8400-e29b-41d4-a716-446655440008', 'aa0e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440004', 'TIE', datetime('now', '-6 days')),
    ('cc0e8400-e29b-41d4-a716-446655440009', 'aa0e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440006', 'DEFENDER', datetime('now', '-5 days')),
    ('cc0e8400-e29b-41d4-a716-446655440010', 'aa0e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440007', 'CHALLENGER', datetime('now', '-4 days'));

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- Users: 8
-- Follows: 17
-- Posts: 62 (50 original + 12 threaded replies)
-- Likes: 75
-- Debates: 3 (1 completed, 1 voting, 1 active)
-- Debate Arguments: 15 (6 + 6 + 3)
-- Debate Votes: 10
--
-- Fact-Check Status Distribution:
--   VERIFIED: 23
--   LIKELY_TRUE: 10
--   DISPUTED: 6
--   FALSE: 3
--   UNCHECKED: 20
