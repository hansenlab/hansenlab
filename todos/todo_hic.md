# Reconstruction paper

- Do an analysis of open/closed compartments vs. blocks and PMDs.
- Extend the cancer analysis to all 11 cancers.
- Include 450k code in minfi package.
- Does our approach work for primary (non-cancer, non-cell culture) samples?

# Extensions

- When we analyze DNase-seq data, can we go higher resolution.  Or perhaps said better: can we discover higher resolution type of patterns (TADs for example) using DNase?

# Analysis of HiC

## Loops

- Can we do better at finding loops by smoothing the data carefully, perhaps with a smoother which respects the gradient of the contact matrix?
- Can we find loops in lower resolution (cheaper) data, for example by smoothing?
- Perhaps we can do better by smoothing base-pair resolution data, and then aggregate as opposed to starting with binning at arbitrary breakpoints (also read HIC-Five paper).
- Take existing enhancer-promoter pairs and check if they fall into loops.  Not sure Rao 2014 did this well.

## Data analysis

- What happens with contact matrices if we remove the compartment pattern (follow-up: remove TAD pattern etc etc).
- How do we do differential analysis?  Somehow we probably want to do differential analysis at different resolutions, and how is that handled.  And visualized.  Probably clear that HICdiff is not the answer.
- Take the compartment pattern, add the decay of the contact matrix into this pattern and see if it explains the HiC contact matrix, assuming Poisson noise. (hopefully the answer is no).
- Bigger Q: are (very) long-range interactions BS?
