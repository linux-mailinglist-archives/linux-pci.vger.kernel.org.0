Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E72C41CF66
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 00:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347134AbhI2Wsj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 18:48:39 -0400
Received: from mail-mw2nam10on2081.outbound.protection.outlook.com ([40.107.94.81]:24570
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346734AbhI2Wsj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 18:48:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChD1BCuurnMQ61llboNRMK3lAtyuVwAuq045CJjXZ++N3nAs/XLUdUh0PvN/zwxE60vLo50bEBqEgrDsVIg0dJuA9RxNRaKBRVIz1T+STfhQeI9nrQxUudloyEOztktGpUO71wLqC/OtoTpiKPhXqndOX0azoFOpp8oTjQh/STUcZvBSV3d8LfGk5ZvH9q/sDqyEK388i5pljitkp3wsFLZrWyNV+V9Na/Ad7XU+2uJyNGtM2BgmefdZKstA8F+NMz7u+n0sf5WLFWl1pXc8ayeY31WZ2vj8HIkLi1L8ELxpYzzShq6Nc4xE4///SWqX2weJWgG+IPas8gRdUVjzJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=39hkb7d82Oah1HBIAxb7+aO9nkxSWCSKn8ZZmqRbEvM=;
 b=GFwhAABN0LvQid/wkIH8bKZcNb6+T+XXlI/qKHNiDOqoxVLnxbLAjoCBHJ5rhcvUu9/QY9kIHGlzahgECbkBRr7RnfCMdbqCMWf6v80LTeTz6CMEY6V19sgh6pCpzX5ZWU3Vlhk1tiMmURId0nO0+/J4O8H+S+gITj4ME0Z6Uh8hfWooe0MBt4VHnSx2s4Ks95I4R2Uf0pVFG4jRJAQQG6ZKHBE5fCSz8rX5sAzopB0d/GwFZ67hNq5ktCaYgmzkiaGN5ukmcplRLKQHy8MwA0UzeYX3TuFudVBBey6tQ8kd+bGxGnydumzAjP+1vJqaLyysRjyXINROfBf792D5zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39hkb7d82Oah1HBIAxb7+aO9nkxSWCSKn8ZZmqRbEvM=;
 b=JWR3uLYRE/3DeWezsZlSd8XZlUsZddvZoyLTLJ1fr/orVH8zsubYuOpdk+Y8kgOaRq5jDWDS+R3twq9nd1swcRlAynvmcVFcQYtgBsqvuZidX6W7jafgLSQZNnVmus+KU3hNAGptRa5S+gctjcAboUSHuJJqjrD36X2qY5G8SFW3sYOEec0v11TXEarNQEK1ks3OnbRwPM+ZDETIsWYaBljpCqx7YKEV6pM5tG05THd8z/fEy19t7VnEAPQ+bpG9EpEb3uLQHWNZjz7QM7nQrC+tr9h5ulvip0gWlzYgjk2mcatVLQEbPfDkvffHiPbRQfpIVraxsCJ1WU3ZnNdUjg==
Authentication-Results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Wed, 29 Sep
 2021 22:46:55 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4566.015; Wed, 29 Sep 2021
 22:46:55 +0000
Date:   Wed, 29 Sep 2021 19:46:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 4/20] PCI/P2PDMA: introduce helpers for dma_map_sg
 implementations
Message-ID: <20210929224653.GZ964074@nvidia.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-5-logang@deltatee.com>
 <20210928220502.GA1738588@nvidia.com>
 <91469404-fd20-effa-2e01-aa79d9d4b9b5@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91469404-fd20-effa-2e01-aa79d9d4b9b5@deltatee.com>
X-ClientProxiedBy: MN2PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:208:120::33) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR10CA0020.namprd10.prod.outlook.com (2603:10b6:208:120::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 22:46:54 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mViLm-007i5Y-04; Wed, 29 Sep 2021 19:46:54 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86646f6c-c955-45f7-e900-08d9839b0949
X-MS-TrafficTypeDiagnostic: BL1PR12MB5157:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB51571279ADB2ADD84B5C9884C2A99@BL1PR12MB5157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szMCIkVvPV6YaCm20ltVLy9ZbbM6N+ebTlQaq0EcIABKILrhF/iF9hLYS4Nmh5k06AYZoQo8cFRnV0BEMdZuyEvnuorcHomLglTWCBGGSESse/Lu2m/OJC3FnZGc8at6EDard0s0h2xAtjLirdpCu9zi6DU3rqQIln9A2p8iTBFVQed9T1MS2HnP5FlrvilqAIxUthJXKSuJOy1a/C988soUfWM3+bOI0mj/8W+jkMiANOc7IqOtZ36rCeAjyb2ANX0Tw4XtS6p5WbutNNnVX7vydPxQUjccXTLBBW9bpFKJHx9I4vDIL9WfUASjqkPSkc8vCNbQ5A4YnNQ30TVbVkcX2jd6omtFLovLH72+jHhhsu7Gp2qh6OsBizx3pKlLFXcVkuPQ8wDriUux0Odb/OEJtwSC0USL2nVvSCOe9iTJJxgUxAeKt/1P+2w8urjsPc0wmYe/gyrNzdCottnzThIuC07DrRvS3OeiSoiM7/4fL0cFDqeQvOEmclh+WJPapEGvi/Cq/NhliG4Nk6H6kWwXrajCNt1OqXh06q31jytzGMkVxGnwkUmCNqy+PQ+sCzksJQJ/G6zM8KOI2nZDOyYh7cMxsjJtZA6BcCbvuafZclaoBMQLy3XK/yqbJXwjAexUrs5h42cE5DdEwPme84efvvgsC3rndUra5GQRQbSh1MkWBKqNkM1Pek+rVq6g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(86362001)(83380400001)(186003)(53546011)(8936002)(5660300002)(8676002)(7416002)(2906002)(6916009)(66476007)(2616005)(9746002)(9786002)(36756003)(54906003)(33656002)(4326008)(66946007)(1076003)(66556008)(38100700002)(426003)(316002)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zAKSAGwOF/+LXcf4KA8i8AVc8xa4Jqrwwju9dHHATNug4j3UPBhs5KB5PXKX?=
 =?us-ascii?Q?pZGSOnqP0+/+vZNM3BAhMdGIDu2I/91rk22YlWNZ7JaQx9u9H3CnN2pAi1if?=
 =?us-ascii?Q?C3VVwo7JaDTcbpS6tSbPq5XUXpsfpUvs1ecDY2Hg7BddRJ3i/CD6XYaGcjmd?=
 =?us-ascii?Q?shR13ESMQaaosqUbGgDIYXdGwp7BzeSqp6cWuFCYrsIcZM5p5BC9DAU01x6B?=
 =?us-ascii?Q?gV2vFrPe5mHXqr3KYmAyxWIzgTmooRLhuhBXeCluSACk5UWT9If4RSZH8mev?=
 =?us-ascii?Q?cp9x4eZHrb7Jax0rotty+dR1tcEsRlC5zZwILIeORVBdWlhlEVWh/sSL2srd?=
 =?us-ascii?Q?wsbquuwIMdlTIHaAjI9jvQSOL+R+a2YsoftlvP/LbnlRVhioC9tfQtZJNyVc?=
 =?us-ascii?Q?k3JsZ1+z/PpVurhFmvieDcz878cPNEL5Fl7p1SVw+pCoSjpXOslFQc3ZeAsL?=
 =?us-ascii?Q?yrzxwp8CQYjsL2ho8rU4caP6HP8CIHNSPhkSYPruYKi0LNl3Cln+WU8rHEyv?=
 =?us-ascii?Q?/v5PMXi+YPt2zQuIUOfkf/HUQq2slOHaHJqu2NClcZ7ru5rW8goG0mOJ239t?=
 =?us-ascii?Q?v/BngBMhEQjtP4CkKajORFMkF1xXRvCAvFBGPA0+xMA+4IAp1BsPjMFUB11y?=
 =?us-ascii?Q?wSpsrICRUB5+L09AtoOuWGv0r7grgeho38xTpPbimtyC8ckmuyVLtW6DlPno?=
 =?us-ascii?Q?YUJ25A6yIh/jekmp4JDxOCAAB3OHgdWxNlKM0UnWyEFR8tVoksww6T24MPO7?=
 =?us-ascii?Q?6Wu5Y7Ih5CbWU0dHtIhezJiOe43PZgvLbkI+QCpoTpC376IrD0cyel0ni7Dd?=
 =?us-ascii?Q?loeeiN7nXBsbFfgcdMJWWTBHjKgxAo1WNgqNg+Sy28fP3XNo5Kr/j+z5DY4S?=
 =?us-ascii?Q?QK+qoCB2QcjQisAImek7k9q9Y4taPbTe0i544yCHcx94e5Z21nOfenMDrJfr?=
 =?us-ascii?Q?WXPO8NEzKLYzkqPCPNZfoh/0vO6IMAWY7E1PUvHMmQyCYaIEtGvgmcrGzitU?=
 =?us-ascii?Q?zbFVciDi2nC2UDBpuLbWsJ9f3qBbM/sLs5colTR+fSBj0Wll2JwnhJt6XeHI?=
 =?us-ascii?Q?k3TKk3hbeXSQA8KKaZ8GFZdVa9S1GA/GLASZq5cAqMqG7D2GaZis/isZurCJ?=
 =?us-ascii?Q?fa5YW4fzWaCGOtTRI4tx8gd4SvFWvfscZlRWduOhklzs+VdnFr3conYBJ6sr?=
 =?us-ascii?Q?psxND7BjeuxleHra6pyS188jXUxlHMG+RpYQMAnq9OexxgIRQ1OCLv0TQlrm?=
 =?us-ascii?Q?X4yGrg9wCs3wKivwQ7I8Bdb4Z31wv4EHqSYqh4DeeCtnq6iYmPJ865OG9+Aq?=
 =?us-ascii?Q?GNw/ruqwiL9z1qc3XR/qHn3h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86646f6c-c955-45f7-e900-08d9839b0949
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 22:46:55.0844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43/FGkTgZXWuO3F5uG4GQReo5Is3MkCg2Tv+zIOVk9Eeo0+gT1HsqIzoi3s1qxKC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5157
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 03:30:42PM -0600, Logan Gunthorpe wrote:
> 
> 
> 
> On 2021-09-28 4:05 p.m., Jason Gunthorpe wrote:
> > On Thu, Sep 16, 2021 at 05:40:44PM -0600, Logan Gunthorpe wrote:
> > 
> >> +enum pci_p2pdma_map_type
> >> +pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
> >> +		       struct scatterlist *sg)
> >> +{
> >> +	if (state->pgmap != sg_page(sg)->pgmap) {
> >> +		state->pgmap = sg_page(sg)->pgmap;
> > 
> > This has built into it an assumption that every page in the sg element
> > has the same pgmap, but AFAIK nothing enforces this rule? There is no
> > requirement that the HW has pfn gaps between the pgmaps linux decides
> > to create over it.
> 
> No, that's not a correct reading of the code. Every time there is a new
> pagemap, this code calculates the mapping type and bus offset. If a page
> comes along with a different page map,f it recalculates. This just
> reduces the overhead so that the calculation is done only every time a
> page with a different pgmap comes along and not doing it for every
> single page.

Each 'struct scatterlist *sg' refers to a range of contiguous pfns
starting at page_to_pfn(sg_page()) and going for approx sg->length/PAGE_SIZE
pfns long.

sg_page() returns the first page, but nothing says that sg_page()+1
has the same pgmap.

The code in this patch does check the first page of each sg in a
larger sgl.

> > At least sg_alloc_append_table_from_pages() and probably something in
> > the block world should be updated to not combine struct pages with
> > different pgmaps, and this should be documented in scatterlist.*
> > someplace.
> 
> There's no sane place to do this check. The code is designed to support
> mappings with different pgmaps.

All places that generate compound sg's by aggregating multiple pages
need to include this check along side the check for physical
contiguity. There are not that many places but
sg_alloc_append_table_from_pages() is one of them:

@@ -470,7 +470,8 @@ int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
 
                /* Merge contiguous pages into the last SG */
                prv_len = sgt_append->prv->length;
-               while (n_pages && page_to_pfn(pages[0]) == paddr) {
+               while (n_pages && page_to_pfn(pages[0]) == paddr &&
+                      sg_page(sgt_append->prv)->pgmap == pages[0]->pgmap) {
                        if (sgt_append->prv->length + PAGE_SIZE > max_segment)
                                break;
                        sgt_append->prv->length += PAGE_SIZE;
@@ -488,7 +489,8 @@ int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
        for (i = 1; i < n_pages; i++) {
                seg_len += PAGE_SIZE;
                if (seg_len >= max_segment ||
-                   page_to_pfn(pages[i]) != page_to_pfn(pages[i - 1]) + 1) {
+                   page_to_pfn(pages[i]) != page_to_pfn(pages[i - 1]) + 1 ||
+                   pages[i]->pgmap != pages[i - 1]->pgmap) {
                        chunks++;
                        seg_len = 0;
                }
@@ -505,9 +507,10 @@ int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
                        seg_len += PAGE_SIZE;
                        if (seg_len >= max_segment ||
                            page_to_pfn(pages[j]) !=
-                           page_to_pfn(pages[j - 1]) + 1)
+                                   page_to_pfn(pages[j - 1]) + 1 ||
+                           pages[i]->pgmap != pages[i - 1]->pgmap) {
                                break;
-               }
+                       }
 
                /* Pass how many chunks might be left */
                s = get_next_sg(sgt_append, s, chunks - i + left_pages,


