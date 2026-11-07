# TREG vs Firecrawl for Andro's scraping need (checked 2026-11-07)

Tooling-fit analysis only. Not financial advice. Nothing was bought, installed or signed up for.

## What the use actually is (unknown)

Andro's Nov 3 question never said which of three uses he wants: specific subreddits, X search results, or product/competitor pages. This file does not guess. It prices all three.

## Assumed volumes (my assumption, not Andro's)

Volumes are illustrative so the prices can be compared. They are not measured needs.

- Subreddits: 10,000 posts/month.
- X search: 10,000 tweets/month.
- Product/competitor pages: 2,000 pages/month.

## Verified claims (vendor pages, fetched 2026-11-07)

| ID | Claim | Source |
|---|---|---|
| F1 | Firecrawl Hobby plan: $19/month ($16/month billed annually), 5,000 credits | firecrawl.dev/pricing, 2026-11-07 |
| F2 | Firecrawl Hobby pay-as-you-go: 1,000 extra credits per $5 | firecrawl.dev/pricing, 2026-11-07 |
| F3 | Firecrawl scrape: 1 credit/page; JSON format adds 4 credits/page (5 total) | firecrawl.dev/pricing, 2026-11-07 |
| F4 | Firecrawl Standard: $99/month ($83 annual), 100,000 credits | firecrawl.dev/pricing, 2026-11-07 |
| T1 | TREG catalog: Reddit "from $0.0002/success", 50 endpoints | treg.to/catalog, 2026-11-07 |
| T2 | TREG catalog: X (Twitter) "from $0.0001/success", 167 endpoints | treg.to/catalog, 2026-11-07 |
| T3 | TREG catalog: Open web (search, extract, crawl) "from <$0.0001/result", 243 endpoints | treg.to/catalog, 2026-11-07 |
| T4 | TREG home page: "4,100+ endpoints" across 126 providers; "+ $0.000 markup"; "$1.00 free to start" | treg.to, 2026-11-07 |
| T5 | TREG GitHub: 7.5k stars; license "Apache 2.0 with additional terms"; exact per-endpoint prices come from `treg catalog get <id>` | github.com/superdesigndev/treg, 2026-11-07 |
| T6 | TREG home page lists no per-call price for Reddit, X or scraping; the "$200/mo" shown next to X is the official X API cost, not TREG's | treg.to, 2026-11-07 |

Derived (my arithmetic from the rows above):

| ID | Derivation |
|---|---|
| D1 | Firecrawl Hobby effective rate: $19 / 5,000 = about $0.0038 per credit, so JSON (5 credits) is about $0.019/page (from F1, F3) |
| D2 | Subreddits, Firecrawl, 10,000 pages at 1 credit: 5,000 included + 5,000 extra = 5 x $5 = $25, total $44 (F1, F2, F3) |
| D3 | Subreddits, TREG: 10,000 x $0.0002 = $2.00 at the floor price (T1) |
| D4 | X search, Firecrawl: same 10,000 credits, $44 if it worked at all (F1, F2, F3) |
| D5 | X search, TREG: 10,000 x $0.0001 = $1.00 at the floor price (T2) |
| D6 | Product pages, TREG: 2,000 x <$0.0001 = under $0.20 at the floor price (T3) |
| D7 | Product pages, Firecrawl, plain scrape: 2,000 credits fit inside Hobby, $19 (F1, F3) |
| D8 | Product pages, Firecrawl, JSON: 2,000 x 5 = 10,000 credits = $19 + 5 x $5 = $44 (F1, F2, F3) |

## Price table (checked 2026-11-07)

TREG numbers are floor ("from") prices. I did not see exact per-endpoint prices, so real TREG cost is at or above these.

| Use | TREG (1 month) | Firecrawl (1 month) | Winner |
|---|---|---|---|
| Subreddits (10,000 posts) | $2.00 at floor (D3) | $44 (D2) | TREG, about $42 less (floor-based) |
| X search (10,000 tweets) | $1.00 at floor (D5) | $44 (D4), if it works | TREG, about $43 less (floor-based) |
| Product pages (2,000 pages), plain scrape | under $0.20 at floor (D6) | $19 (D7) | TREG, at least $18.80 less (floor-based) |
| Product pages (2,000 pages), typed JSON | typed-JSON TREG endpoint not priced (see unverified) | $44 (D8) | TREG likely, not confirmed |

## Why each wins

- Subreddits: TREG has a dedicated 50-endpoint Reddit category priced per success. Firecrawl bills a full credit per page and counts pages, not posts.
- X search: TREG has 167 X endpoints at the lowest floor. Firecrawl is a general page scraper, and X sits behind login walls, so the $44 is a best case.
- Product/competitor pages: this is Firecrawl's home ground, but even here TREG's open-web floor is far cheaper. Firecrawl's advantage is a single product with a flat, known plan price.

## The one question that settles it

"Which of these three do you want first: posts from named subreddits, X search results, or product/competitor pages?"

## Recommendation (tooling fit only)

On price alone, TREG is cheaper than Firecrawl in all three uses at the volumes assumed above. Before relying on that, check the real per-endpoint price with `treg catalog get <id>` for the one endpoint Andro would use, because the numbers above are floors. If the answer to the question is product/competitor pages with typed JSON output, Firecrawl's known $19 to $44 price is the lower-risk choice until TREG's exact price is seen. Scraping X, Reddit, LinkedIn, Upwork or Instagram can breach those sites' terms of service or hit login walls. Check each site's terms before using either tool on them.

## Research file figures versus what I verified

The earlier note (`research/agent-tools-2026-11-07.md`) and Prompt 6 say the following. These stay separate from the verified rows above.

| Prior figure | Status |
|---|---|
| Firecrawl ~$16/mo for 5k pages | Partly confirmed. $16 is the annual-billing price; monthly is $19 (F1) |
| Firecrawl ~$0.02 vs ~$0.004 per page | Consistent with D1 ($0.019 and $0.0038), but it is my derivation, not a vendor-stated price |
| TREG ~3,000+ endpoints; 3,200 vs 3,700 vs 3,338 | Not matched. Home page now says 4,100+ (T4). The catalog categories I read sum to 460 (T1-T3) |
| TREG "$1 to start" | Home page says "$1.00 free to start" (T4), a one-time signup credit, not a payment |
| TREG license AGPL | Not matched. GitHub says Apache 2.0 with additional terms (T5) |
| TREG ~7.5k stars | Confirmed (T5) |
| Apify Tweet Scraper V2 ~$0.40/1,000; Bright Data ~$1.50/1,000; PRAW/Apify Reddit advice | [UNVERIFIED] not checked here |

## Still unverified / what still fails

- [UNVERIFIED] Exact TREG per-endpoint prices for Reddit, X and web extract. Only "from" floors were seen.
- [UNVERIFIED] Whether TREG has a typed-JSON extract endpoint and what it costs.
- [UNVERIFIED] Whether Firecrawl can scrape Reddit or X at all. The D2/D4 prices assume it can.
- [UNVERIFIED] Exact meaning of "success" versus "result" billing (is one post one success?). The fetch of the catalog page was summarized, not read raw.
- [UNVERIFIED] Overflow relay pricing: one third-party blog (eesel.ai) says TREG may serve calls through a relay account at the relay's real price. Not seen on TREG's own pages.
- The earlier TREG endpoint count discrepancy is unresolved: 4,100+ on the home page versus 460 in the three categories I read.
- The verification step by a different agent was not run; this is a single-pass check.

## Claim check

Every number in the Recommendation section appears above: $19 (F1, D7), $44 (D2, D4, D8). Numbers in the price table trace to D2 to D8 and T1 to T3. The 10,000, 10,000 and 2,000 volumes are labeled as assumptions.
