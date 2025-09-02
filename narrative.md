# UFHCC Bioinformatics Unit - 45 Min Presentation Script

## Outline:

### Presentation Hub
Intro - @jobrant

### Slides
Title + About Us + Collaboration Model + Strengthening Grant + Experience @jobrant
Project Life Cycle + Experience across Assays + Quality Control @kshirlekar
Experimental Design + Track Record of Success + Resources @hkates

### Demos
Resources + Reporting (atacreporter and html report) @hkates
cluster-picker + heat path + DECODeR overview + upload + DE @kshirlekar
DECODeR visualiations + pathway analysis @jobrant

### Slides
Wrap-up + Contact + Discisson @jason

### [Central Hub] @jobrant

Thank you all for joining us today. We're excited to share what makes the Cancer Center's BCB-SR Bioinformatics unit unique - our expertise, our approach to collaboration, and the tools we've developed to advance your research.

We've structured our presentation as this hub-and-spoke diagram to illustrate the multiple, complementary ways BCB-SR Bioinformatics advances research at the UF Health Cancer Center.

### [Expertise Section] @jobrant

We'll start by walking through our core philosophy: how we approach cancer bioinformatics to maximize reproducibility and research impact. You'll see why partnering with us from day one of your project gives your omics research the best chance of success and publication.

### [Resources Section] @jobrant

Next, we'll explore the comprehensive resources we've built - from documentation hubs to web applications - and how these resources are designed to support and accelerate research across the entire cancer center community.

### [Demos Section] @jobrant

Finally, we'll demonstrate some of our custom applications and analysis tools. This isn't just about showing you what we've built - it's about illustrating our collaborative approach and our ability to develop tailored solutions for your specific research questions.

------------------------------------------------------------------------

## Slides.html: Expertise – 8 minutes

### Slide 1: Meet Your Bioinformatics Team @jobrant

We're a collaborative team of three bioinformaticians with complementary expertise spanning computational biology, statistics, and cancer genomics. Together, we bring over 20 years of combined experience in omics analysis, from method development to clinical applications. We work as an integrated unit - when you collaborate with one of us, you benefit from all of our collective knowledge and different perspectives on your research questions.

### Slide 2: Our Collaboration Model @jobrant

We're not a service core - we're collaborators. We participate as key personnel on grants, helping you secure funding and ensuring bioinformatics considerations are built into your project from conception. We're funded through your grants, plus we provide walk-in consulting hours, monthly journal clubs, and comprehensive resources to the entire cancer center community. This model ensures we're curious about your research, invested in your success and available when you need us.

### Slide 3: Strengthening Your Grant Applications @jobrant

NIH increasingly emphasizes robust data management and data analysis plans. Grants with dedicated bioinformatics expertise demonstrate scientific rigor and feasibility. We help you craft compelling data management and sharing plans, justify your analytical approaches, and budget appropriately for computational resources. Our involvement signals to reviewers that you've thought carefully about the analytical challenges ahead.

### Slide 4: Experience You Can Trust @jobrant

Can a postdoc or ambitious graduate student analyze a perfectly designed study with a simple design and high quality data? Probably.

[But here's the question: when renovating your kitchen, would you rather watch YouTube tutorials and do your best, learning a lot through trial and error along the way, and in the end hoping it doesn't fall apart, or hire someone who's done hundreds of kitchens and knows exactly what problems to expect and how to solve them?]

Between our three-person team, we've collectively analyzed hundreds of datasets across most major omics assays. We've encountered - and solved - the quality control issues and need for complex analysis that often arise in your projects.

### Slide 5: Project Lifecycle @kshirlekar

[Add Text]

### Slide 6: Assay Expertise Across Assays @kshirlekar

We have deep experience with the full spectrum of cancer omics: RNA-seq for expression profiling, EM-Seq, MAPit and ATAC-seq for DNA methylation and chromatin accessibility, CUT&RUN for protein-DNA interactions, single-cell approaches for tumor heterogeneity, spatial transcriptomics for tissue architecture, CRISPR screens for functional genomics, AI-driven approaches for rare disease research. This isn't just familiarity - we understand the unique analytical challenges, optimal parameters, and common pitfalls for each platform.

### Slide 7: Quality Control That Prevents Disasters @kshirlekar

Poor quality data leads to poor conclusions - or worse, wasted months of work. We catch critical issues early: inadequate insert sizes in ATAC-seq that indicate failed library prep, high duplication rates in RNA-seq that compromise differential expression analysis, and contamination that can invalidate entire experiments. We parse the dozens of merics and plots produced by QC protocols to answer the fundamental question: "Did your experiment actually work?"

### Slide 8: Experimental Design That Works @hkates

The best analysis can't save a poorly designed experiment. We help you avoid generating unusable data by considering power calculations, batch effects, and confounding variables before you spend time and money in the lab. Equally important, we can analyze complex but well-designed studies - repeated measures, time courses, multi-factorial designs - that might overwhelm standard pipelines but yield the most biologically meaningful results.

### Slide 9: Proven Track Record @hkates

Our collaborative model delivers results: successful grant applications, high-impact publications, and research that stands up to peer review. We've helped secure millions in funding, contributed to dozens of publications, and prevented countless analytical disasters before they happen. When you work with us, you're not just getting analysis - you're getting a partnership that maximizes your research impact.

### Slide 10: Beyond Collaboration: Resources for All @hkates

Our expertise doesn't just benefit direct collaborators - we've built comprehensive resources that support the entire cancer center community. Our Bioinformatics Hub provides dynamic documentation that evolves with the field, addressing the critical gap between having access to tools and knowing how to use them effectively. We create interactive reports that transform standard pipeline outputs into comprehensive, explorable documents where every table can be filtered and every result links to additional context. Our custom applications like DECODeR for differential expression visualization, HeatPath for pathway exploration, and ClusterPicker for pattern discovery address specific bottlenecks we see repeatedly in omics research. These aren't just convenience tools - they're solutions built from our collaborative experience, making sophisticated analyses accessible while maintaining analytical rigor. This ecosystem of resources ensures that good bioinformatics practices scale beyond individual collaborations to benefit researchers across the cancer center.

------------------------------------------------------------------------

## **Resources Demos – 10 minutes**

### **Unit Webpage Demo** @hkates

Our official presence within the UF Health Cancer Center showcases who we are and how we fit into the broader research ecosystem. This webpage serves as your first point of contact - it introduces our team members, and provides the overview that investigators need when considering collaboration. You'll find our mission statement, contact information, and links to request our services directly through the UF Health system.

### **Bioinformatics Hub** @hkates

Our dynamic documentation platform that transforms institutional knowledge into accessible guidance. The Hub addresses the critical gap between having access to bioinformatics tools and knowing how to use them effectively. We continuously update this resource based on new challenges we encounter in collaborations and emerging best practices in the field.

The Hub's strength lies in its responsiveness - we regularly add new sections based on researcher requests and evolving methodological standards. Each section builds from fundamental concepts to advanced applications, whether you're planning your first RNA-seq experiment or troubleshooting complex multi-omics integration. This dynamic documentation ensures that good bioinformatics practices evolve with the field and remain relevant to current research needs.

### **Applications Landing Page Demo** @hkates

Our applications portal represents the evolution from one-off analyses to sustainable, reproducible tools. These aren't just convenience applications - they're solutions to specific bottlenecks we've identified in omics research workflows. Each tool addresses a real problem: DECODeR handles the complexity of differential expression visualization, HeatPath invites curiosity about biological patterns in data separate from statistical analysis, and our reporting tools ensure that analyses remain interpretable and reproducible months or years later.

What makes these applications particularly valuable is their integration with our consultation model. They're built from patterns we see repeatedly in our collaborative work, codifying best practices into user-friendly interfaces that maintain analytical rigor while being accessible to researchers with varying computational backgrounds.

------------------------------------------------------------------------

## **App Demos – 15 minutes**

### **Interactive Reports Introduction** @hkates

Our interactive reports transform standard bioinformatics pipeline outputs into comprehensive, explorable documents that bridge the gap between raw results and biological insight. These aren't static PDFs - they're dynamic platforms where every table can be filtered, every result links to additional context, and methods documentation ensures complete transparency about analytical choices.

#### **ATAC-seq Report Demo** (3 minutes) @hkates

This report showcases our integration with HiPerGator's reproducible nf-core/atacseq pipeline, delivering interactive exploration of chromatin accessibility data. The report provides filterable tables for differential accessibility results, direct links to visualize your peaks in UCSC browser through automatically generated track hubs, and comprehensive peak annotations that facilitate integration with RNA-seq and other omics data. Each section includes detailed methods documentation, eliminating confusion about analytical approaches while highlighting whether accessibility changes occur in promoter regions or other regulatory elements.


#### **Atac-reportR Demo** (2 minutes) @hkates

This specialized tool demonstrates our commitment to reproducible, streamlined analysis workflows. Atac-reportR generates comprehensive reports directly from nf-core/atacseq pipeline outputs with a single click. While access requires UF network connectivity and /blue storage permissions (available through collaboration with our unit), it exemplifies our approach to transforming complex pipeline outputs into immediately interpretable results - PCA plots, differential accessibility visualizations, and genome browser tracks ready for biological interpretation within minutes.

### **Custom Applications Introduction** @kshirlekar

Our custom applications address specific analytical bottlenecks we encounter repeatedly in collaborative research. These tools embody our philosophy of making sophisticated analyses accessible without sacrificing rigor - guided workflows, best-practice defaults, and extensive documentation ensure that researchers can explore their data confidently.

#### **HeatPath Demo** (2 minutes) @kshirlekar

HeatPath fills a unique niche in expression data exploration - it's not about pathway enrichment of differential expression results, but curiosity-driven exploration of known pathways in your dataset. This hypothesis-generating tool requires no specific experimental design, group structure, or replicate numbers. Simply search for cancer-related pathways like "p53 signaling" or "cell cycle" and instantly visualize how those genes behave across your samples, facilitating discovery-driven research.

#### **ClusterPicker Demo** (2 minutes) @kshirlekar

When examining heatmaps, researchers often notice gene clusters with shared expression patterns that may not correspond to known pathways. ClusterPicker makes this exploration systematic - select a k-value to define cluster number, preview the resulting clusters, and iteratively adjust until you achieve the desired granularity. Extract specific numbered clusters for downstream analysis, transforming visual pattern recognition into concrete gene lists for further investigation.

#### **DECODeR Demo** (6 minutes)

**Flexible Entry Points** @kshirlekar

DECODeR accommodates different starting points - upload pre-calculated differential expression results or begin with raw count matrices for complete analysis. For researchers with existing RNA-seq reports from our unit, the integration is seamless, jumping directly to visualization and interpretation.

**Guided Workflow Modules** @kshirlekar

Each module features comprehensive documentation and flexible, guided uploads. The interface presents informed choices without overwhelming options, reflecting years of best-practice refinement. The batch detection module exemplifies our quality-first approach - identifying potential batch effects before proceeding to differential expression, preventing misleading results.

**Advanced Visualization Features** @jobrant

The heatmap module offers extensive customization including custom gene sets, while pathway enrichment provides KEGG and GO analysis with options for combined or separate up/down-regulated gene analysis. Semantic similarity clustering reduces redundant terms, and appropriate backgrounds are automatically specified, ensuring statistically sound enrichment results.

------------------------------------------------------------------------

## **Conclusion – 5 minutes**

### **Slide 9: Wrap-up + Works in Progress** @jobrant

**Transforming Omics Research Through Partnership**

We've shown you how the UF Health Cancer Center Bioinformatics Unit addresses the complete research lifecycle - from experimental design that prevents costly mistakes, through rigorous analysis that handles complex designs, to sustainable tools and documentation that ensure reproducible results. This isn't just about having access to bioinformatics expertise; it's about embedding best practices into every stage of your research.

**Expanding Our Impact**

Our work continues to evolve. We're developing additional interactive reports for proteomics and metabolomics data, expanding our application suite based on researcher feedback, and continuously updating our documentation hub with emerging methodologies. The RNA-seq and single-cell RNA-seq reports launching soon will bring the same level of interactive exploration we've demonstrated with ATAC-seq to these critical data types.

### **Slide 10: Contact and Work With Us** @jobrant

**Ready to Elevate Your Research?**

**Getting Started:**
- Visit our unit webpage through the UF Health Cancer Center
- Explore our Bioinformatics Hub for immediate access to best practices
- Request consultation through our established UF Health channels

**Collaboration Models:**
- Project-based partnerships for specific analyses
- Ongoing consultation for complex, multi-stage studies  
- Training and capacity building for your research team
- Custom application development for specialized needs

**Contact Information:**
[Include relevant contact details and web links from the presentation hub]

### **Slide 11: Discussion and Questions** @jobrant

**Let's Discuss Your Research Challenges**

We've covered our systematic approach to omics research support, but every project brings unique challenges and opportunities. 

**Questions we're eager to explore with you:**
- What analytical bottlenecks are limiting your research progress?
- How could interactive tools and documentation accelerate your discoveries?
- What collaborations might amplify the impact of your work?

**Your turn:** What questions do you have about integrating rigorous bioinformatics into your research program?
------------------------------------------------------------------------

## Notes

-   Total presentation time: 45 minutes
-   Current sections completed: Intro (2 min) + Expertise (8 min) = 10 minutes
-   Remaining time: 35 minutes for Resources + Demos + Conclusion + 15 minutes Q&A
-   Link to presentation hub: <https://ufhcc-bcbsr.github.io/bioinfo-showcase/>
