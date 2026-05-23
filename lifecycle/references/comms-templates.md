<!--
  Strategy OS — Copyright (c) 2026 Joseph Fung (https://josephfung.ca)
  Licensed under the MIT License. See LICENSE file in the project root.
-->
# Phase 3 Reference: Communication

This file contains the stakeholder reframing matrix, the locked inputs extraction
method, all 5 communication prompts, and the consistency check.

---

## Step 1: Extract Locked Strategy Objects

Before generating any comms, extract these from the memo in exactly this format:

```
LOCKED STRATEGY OBJECTS — Do not modify these.

STRATEGIC OBJECTIVE:
[1-2 sentences, exact language from memo]

STRATEGIC PILLARS:
- Pillar 1: [name + 1 sentence description]
- Pillar 2: [name + 1 sentence description]
- Pillar 3: [name + 1 sentence description]

KEY TRADE-OFFS:
- We choose [X] over [Y] because [REASON].
(repeat for ALL trade-offs in the memo)
```

Rules: Copy exact language. Include all trade-offs. If a trade-off isn't in
forced-choice format, convert it.

These locked objects stay identical across every communication artifact.

---

## Step 2: Stakeholder Reframing Matrix

Fill this for 6 audiences before generating any artifacts:

| | Board | Exec Team | All-Hands | Sales | Product / Eng | Key Customers |
|---|---|---|---|---|---|---|
| **What they care about** | Returns, defensibility, capital efficiency | Clarity on priorities, resource allocation, their role | Job security, direction, whether leadership has a plan | Quota, positioning, competitive ammo | What to build, what to stop, technical direction | Roadmap relevance, reliability, stability |
| **What they fear** | Lack of focus, burning cash, blind spots | Shifting priorities, unfunded mandates | Layoffs, pivots, meaningless work | Losing deals, selling vaporware | Building wrong thing, scope creep, strategy whiplash | Being deprioritized, breaking changes |
| **What they will misunderstand** | [SPECIFIC to this memo] | [SPECIFIC] | [SPECIFIC] | [SPECIFIC] | [SPECIFIC] | [SPECIFIC] |
| **Proof they will demand** | Metrics, moats, milestones | Resource commitments, decision rights | Visible progress, consistency | Win stories, objection handling | Technical feasibility, staffing | Roadmap commitments, SLAs |
| **Best framing (1 sentence)** | [SPECIFIC] | [SPECIFIC] | [SPECIFIC] | [SPECIFIC] | [SPECIFIC] | [SPECIFIC] |
| **Worst framing (1 sentence)** | [SPECIFIC] | [SPECIFIC] | [SPECIFIC] | [SPECIFIC] | [SPECIFIC] | [SPECIFIC] |

The "what they will misunderstand" and framing rows are the most important to get
right — they must be specific to this strategy, not generic. The pre-filled rows are
starting points that should be edited to match the company.

---

## Step 3: Communication Artifacts

Generate each using the locked strategy objects + reframing matrix. All claims must
be labeled EXPLICIT / INFERRED / UNKNOWN.

### Artifact 1: CEO Narrative (1 page)

**Voice**: Direct, plain, confident without being promotional.
**Format**: Clean prose. No bullet points, no headers. ~500 words max.
**Structure**:
- Opening: Why now. What changed in the market or company.
- Middle: The choices. Pillars (what we're doing), trade-offs (what we're not), why.
- Close: What success looks like. The outcome and how we'll know.

### Artifact 2: Exec Alignment Note

**Voice**: Chief of staff drafting for the exec team.
**Format**: Structured note with clear headings. Bullets, not prose. Every item has
an owner (or [OWNER] placeholder).
**Sections**:
- Decisions made (3-5 bullets)
- Ownership: who owns each pillar and key initiative
- What changes: what stops, starts, or shifts (5-7 bullets)
- Next 30 days: most important actions with owners and deadlines (5-7 items)
- Open items: decisions still needed with owners and target dates

### Artifact 3: All-Hands Story

**Voice**: CEO speaking to the whole company.
**Format**: Talking points with headings. Short paragraphs and bullets. Conversational.
**Audience**: ICs, new hires, non-technical staff. Avoid jargon.
**Sections**:
- Why now (2-3 sentences)
- What is our strategy (objective + pillars in plain language, 3-5 sentences)
- What is changing (3-5 bullets, be specific)
- What is NOT changing (3-5 bullets — as important as what changes)
- What this means for you (2-3 sentences)
- How to ask questions

### Artifact 4: Sales Enablement

**Voice**: Sales enablement lead translating strategy for the field.
**Format**: Structured brief with headings. Bullets and short paragraphs.
**Sections**:
- Updated positioning (3-5 sentences)
- What is new: changes that affect how we sell (5-7 bullets)
- Competitive angles: positioning against top 2-3 competitors (1 paragraph each)
- Landmines: things NOT to say or promise (3-5 bullets)
- FAQ: 5-7 prospect questions with suggested answers

### Artifact 5: Board Memo

**Voice**: CEO writing to the board.
**Format**: Formal memo. Clear headings. Concise prose. Max 2 pages.
**Sections**:
- Executive summary (5 sentences)
- Strategic objective and pillars (brief)
- Key trade-offs (forced-choice format)
- Risks and assumptions (top 3 with mitigations)
- Progress and evidence (since last update; use [PLACEHOLDER] if not available)
- Explicit asks: what CEO needs from the board (2-4 specific requests)
- Open questions

---

## Step 4: Consistency Check

After generating all 5 artifacts, verify consistency:

| Artifact | Objective match | Pillars match | Trade-offs match | Drift found |
|----------|----------------|---------------|-----------------|-------------|
| CEO Narrative | Yes/No | Yes/No | Yes/No | [DESCRIBE or "None"] |
| Exec Alignment Note | Yes/No | Yes/No | Yes/No | [DESCRIBE or "None"] |
| All-Hands Story | Yes/No | Yes/No | Yes/No | [DESCRIBE or "None"] |
| Sales Enablement | Yes/No | Yes/No | Yes/No | [DESCRIBE or "None"] |
| Board Memo | Yes/No | Yes/No | Yes/No | [DESCRIBE or "None"] |

If drift is found, list the specific differences and correct them.
