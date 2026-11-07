# agent-browser test, 2026-11-07 (Windows 11)

## 1. Install result
agent-browser 0.41.2 was already installed globally (Chrome for Testing downloaded). `agent-browser --version` returns 0.41.2. `open`, `snapshot`, `get text`, `screenshot` and `close` all worked on Windows. `find text "Cheapest" click` failed ("No element found by text") because the tab is not exposed that way; not needed.

## 2. Test job: Google Flights, Toronto to Cancun, Dec 28 2026, 8 adults
- URL used: `https://www.google.com/travel/flights?q=Flights to Cancun from Toronto on 2026-12-28 for 8 adults`
- Google picked the return date itself: Jan 1, 2027 (round trip). The prompt gave no return date and no one-way setting, so this is a round-trip result for 8 adults.
- Cheapest (also top-ranked): Flair Airlines, nonstop YYZ-CUN, departs 2:35 PM, arrives 6:55 PM, 4 hr 20 min, **$5,497 total round trip for 8 adults** (taxes and fees included, bags extra). Currency symbol shown is "$"; the page did not state the currency, probably CAD.
- Next: Flair $5,723 (7:45 AM and 9:40 AM), Air Transat/Porter $8,048.
- Source: google.com/travel/flights page, read through agent-browser.
- Time checked: 2026-11-07 14:17 EST; re-run at 14:18 EST gave the same $5,497.
- Not verified: I did not open the Flair booking page or confirm the price on the airline site.

## 3. Cloudflare test
- nowsecure.nl (Cloudflare bot test): PASS. Page rendered "NOWSECURE BY NODRIVER", no challenge page.
- g2.com (Cloudflare plus DataDome): FAIL. `get text` returned only challenge JavaScript (`geo.captcha-delivery.com`, `__CF$cv$params`), no real content. I did not try to bypass it.

## 4. Recommendation
Use agent-browser for simple read-only jobs like this: it worked first try on Windows and snapshots are small. Switch to Playwright MCP only if you need more reliable handling of bot-protected sites, though neither tool will bypass DataDome.

## 5. What still fails
- g2.com blocked by bot protection.
- Currency of the flight price not confirmed on the page.
- Return date was chosen by Google (Jan 1, 2027), not specified.
- Independent re-check by a different agent (per the prompt's verification loop) has not been done.
