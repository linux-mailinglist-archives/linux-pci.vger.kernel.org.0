Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152FE371025
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 02:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhECAwK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 May 2021 20:52:10 -0400
Received: from mail-dm6nam10on2072.outbound.protection.outlook.com ([40.107.93.72]:17281
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232758AbhECAwJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 May 2021 20:52:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMOKk5SUM09NRPCZqzt6Lla35JMG52B4+LfKJ4ntWW5Ut+RMPe2sqlqKdKPVmW4bPhWQLg1jQPUDs8CEdYzlKGaCu88xKu7oyD+1xpP9z0HAFqOKOGfOwtji9Yktxa+5t5cbScmOKyhISKqQMPXHoNrVw1jPhgYknsKMaTd4vi7uu+m1gsSO3xO+sjVEhDWLoQrwjqMB0ELyuxuitViYlGe6Bqdfe6FacBfP5m8xGOLU0wX2RPNIfgR0lkOWUpOiYpxj4fXHuKuwh8TB4U5w253d6S78oVFEl5aHr9pFIKtJ+A2tWTz1Xcmb268g9dmjUZM0FctqhQTWueLb0WCg+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQzfVm21ztBgz1Z7wAR9R3g0216UxznMewupZZK/NEQ=;
 b=j57uKI2mzaTCtTLRIZKBt7kLbblai1gy784zMRWXxqWFr8Dp1+n3JB098T9QgvQ+nVerc1dyNtBfVlZoLApvYbfzwHCCeWGw0bDYseGs+bgnEWxSyWsdN75nWj5ShB1B3cn3vCvog1+jarqoYu/GHk0kftu6A5a0eab5w5S7r5IhHExylsFd1RgdiY2C6ub7tBrZ7aA/gELCUy1AE6I5acIpljfaJU0S81xWh4nIQrWg9xF3BAwSCX1KqnhDAO2DIU0DJ2/KjoQhNBNLwNY4AXzpJZUNG5g1AtVIAEDnX0RDgeySFBsK5U23iMSjsnxLlEGqjFJyHiReHCn+lMyZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQzfVm21ztBgz1Z7wAR9R3g0216UxznMewupZZK/NEQ=;
 b=JUpTa6Xa0V138nlElKcN3RUfx0hcK0knAqEb+9yM0yanMXVHzeZ1OT0lxGfSu2qrtetpt9CxKRTJDaYE27bMar/pwzGdYv+aryQWIS2zUgd29u51dhm9IqF5E2CIWPTMTI9GHeiYAJYaHMg/cIUpJQIo+VGMSIK19tbUzJtc0BAmL4yBnIRTUBvHq/Fb2lvJ8EGObHkfA/qdsvH1FprOPUFO/z7Hd7nUX9C6eUMfWTo4BgjoDsjnNVyfhVtK7lF82L5HB2vmy5xKAGiGNJAi0AxW+tIwaXBzaJUC5q4N5hpXRnlUrdu2YcVkuEnurVgH8UkcmXQLYecwv/O188UB4A==
Received: from MWHPR01CA0044.prod.exchangelabs.com (2603:10b6:300:101::30) by
 BY5PR12MB4003.namprd12.prod.outlook.com (2603:10b6:a03:196::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Mon, 3 May
 2021 00:51:15 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::40) by MWHPR01CA0044.outlook.office365.com
 (2603:10b6:300:101::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Mon, 3 May 2021 00:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 00:51:15 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 3 May
 2021 00:50:39 +0000
Subject: Re: [PATCH 08/16] PCI/P2PDMA: Introduce helpers for dma_map_sg
 implementations
To:     Logan Gunthorpe <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-mm@kvack.org>, <iommu@lists.linux-foundation.org>
CC:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Xiong Jianxin" <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-9-logang@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <e27d35f8-5c3a-39e3-9845-6d2bf15cc8b3@nvidia.com>
Date:   Sun, 2 May 2021 17:50:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-9-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69684f86-2418-4bb0-f0e1-08d90dcd8e0e
X-MS-TrafficTypeDiagnostic: BY5PR12MB4003:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4003F67E10A73855C3B6B0A5A85B9@BY5PR12MB4003.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZugO7sE0qA5o365KBwkiJZ1SaBZMZhpG9PZdsppghtNAeLCQYLoPJWmXjKPLGGRYaQU3Uba8d30nOi3tuwYruqk7z5G6ALQ9Vdl0Wczoaql1x3vedGSZKOCJRqd6cAwWl11DGWXbzCtOEBbWOXq1tITuHj63Zwmlg9vrXuDC4jO3q29hRaa1In1FjoV0693UITpR5f9SIOmCUBvsPnj705907PgMIJEzIM6UMKAefqJ0hal+qfMblHMsAMqHR4TtbRNdfe4MIYyx3w1VrgQSCEUG3SUc3MHaBJ71E/nRdXgDejxnIinSzB7zDY1i8Ym1VE2EdOFckqKU3qfd7A0RpkdJk77xZDQ65olwQNEviz44hAKnVopTLhzDIGnUMF0A/KulSLf4aDF9uUSncmsVt9D9H9+s3ARGGqhJjor+mvJw9pRbGv2AW227x67CrVEKPoi3ez2Vb02L5eRYcLWpXgsQPde7Nfu3kn7eGafBMF+a2MzubSx3/uq+Y7kNGLazCOUfpW81YooBvhhqiyqC7Mm5WAi8twWQtg9ynz0tzzLM+oX1f5eZe4lDUXo2cjz/8OKUliZn7DPspbxWVrLOxkBuKG2t3/Hg2O2s0xAHPdHK/UzOmgO6bUTqObpTZ/greQsx59h4gfaqWo/D/NoZZYqk4Y5gK8Ep/hRHfFaPma0D+oFNUo1gh2f8uteMVxqrbSzmfA0CyrQ25Q1VY9IVw==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(36840700001)(46966006)(26005)(82740400003)(5660300002)(36860700001)(53546011)(186003)(86362001)(47076005)(83380400001)(16526019)(356005)(82310400003)(31696002)(16576012)(54906003)(8936002)(8676002)(70586007)(336012)(7636003)(316002)(36906005)(478600001)(7416002)(110136005)(4326008)(31686004)(2906002)(426003)(70206006)(2616005)(36756003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 00:51:15.1417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69684f86-2418-4bb0-f0e1-08d90dcd8e0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4003
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
> Add pci_p2pdma_map_segment() as a helper for simple dma_map_sg()
> implementations. It takes an scatterlist segment that must point to a
> pci_p2pdma struct page and will map it if the mapping requires a bus
> address.
> 
> The return value indicates whether the mapping required a bus address
> or whether the caller still needs to map the segment normally. If the
> segment should not be mapped, -EREMOTEIO is returned.
> 
> This helper uses a state structure to track the changes to the
> pgmap across calls and avoid needing to lookup into the xarray for
> every page.
> 

OK, coming back to this patch, after seeing how it is used later in
the series...

> Also add pci_p2pdma_map_bus_segment() which is useful for IOMMU
> dma_map_sg() implementations where the sg segment containing the page
> differs from the sg segment containing the DMA address.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/pci/p2pdma.c       | 65 ++++++++++++++++++++++++++++++++++++++
>   include/linux/pci-p2pdma.h | 21 ++++++++++++
>   2 files changed, 86 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 38c93f57a941..44ad7664e875 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -923,6 +923,71 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>   }
>   EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
>   
> +/**
> + * pci_p2pdma_map_segment - map an sg segment determining the mapping type
> + * @state: State structure that should be declared on the stack outside of
> + *	the for_each_sg() loop and initialized to zero.

Silly fine point for the docs here: it doesn't actually have to be on
the stack, so I don't think you need to write that constraint in the
documentation. It just has be be somehow allocated and zeroed.


> + * @dev: DMA device that's doing the mapping operation
> + * @sg: scatterlist segment to map
> + * @attrs: dma mapping attributes
> + *
> + * This is a helper to be used by non-iommu dma_map_sg() implementations where
> + * the sg segment is the same for the page_link and the dma_address.
> + *
> + * Attempt to map a single segment in an SGL with the PCI bus address.
> + * The segment must point to a PCI P2PDMA page and thus must be
> + * wrapped in a is_pci_p2pdma_page(sg_page(sg)) check.

Should this be backed up with actual checks in the function, that
the prerequisites are met?

> + *
> + * Returns 1 if the segment was mapped, 0 if the segment should be mapped
> + * directly (or through the IOMMU) and -EREMOTEIO if the segment should not
> + * be mapped at all.
> + */
> +int pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state,
> +			   struct device *dev, struct scatterlist *sg,
> +			   unsigned long dma_attrs)
> +{
> +	if (state->pgmap != sg_page(sg)->pgmap) {
> +		state->pgmap = sg_page(sg)->pgmap;
> +		state->map = pci_p2pdma_map_type(state->pgmap, dev, dma_attrs);
> +		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
> +	}

I'll quote myself from patch 9, because I had a comment there that actually
was meant for this patch:

Is it worth putting this stuff on the caller's stack? I mean, is there a
noticeable performance improvement from caching the state? Because if
it's invisible, then simplicity is better. I suspect you're right, and
that it *is* worth it, but it's good to know for real.


> +
> +	switch (state->map) {
> +	case PCI_P2PDMA_MAP_BUS_ADDR:
> +		sg->dma_address = sg_phys(sg) + state->bus_off;
> +		sg_dma_len(sg) = sg->length;
> +		sg_mark_pci_p2pdma(sg);
> +		return 1;
> +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +		return 0;
> +	default:
> +		return -EREMOTEIO;
> +	}
> +}
> +
> +/**
> + * pci_p2pdma_map_bus_segment - map an sg segment pre determined to
> + *	be mapped with PCI_P2PDMA_MAP_BUS_ADDR

Or:

  * pci_p2pdma_map_bus_segment - map an SG segment that is already known
  * to be mapped with PCI_P2PDMA_MAP_BUS_ADDR

Also, should that prerequisite be backed up with checks in the function?

> + * @pg_sg: scatterlist segment with the page to map
> + * @dma_sg: scatterlist segment to assign a dma address to
> + *
> + * This is a helper for iommu dma_map_sg() implementations when the
> + * segment for the dma address differs from the segment containing the
> + * source page.
> + *
> + * pci_p2pdma_map_type() must have already been called on the pg_sg and
> + * returned PCI_P2PDMA_MAP_BUS_ADDR.

Another prerequisite, so same question: do you think that the code should
also check that this prerequisite is met?

thanks,
-- 
John Hubbard
NVIDIA

> + */
> +void pci_p2pdma_map_bus_segment(struct scatterlist *pg_sg,
> +				struct scatterlist *dma_sg)
> +{
> +	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(sg_page(pg_sg)->pgmap);
> +
> +	dma_sg->dma_address = sg_phys(pg_sg) + pgmap->bus_offset;
> +	sg_dma_len(dma_sg) = pg_sg->length;
> +	sg_mark_pci_p2pdma(dma_sg);
> +}
> +
>   /**
>    * pci_p2pdma_enable_store - parse a configfs/sysfs attribute store
>    *		to enable p2pdma
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index a06072ac3a52..49e7679403cf 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -13,6 +13,12 @@
>   
>   #include <linux/pci.h>
>   
> +struct pci_p2pdma_map_state {
> +	struct dev_pagemap *pgmap;
> +	int map;
> +	u64 bus_off;
> +};
> +
>   struct block_device;
>   struct scatterlist;
>   
> @@ -43,6 +49,11 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>   		int nents, enum dma_data_direction dir, unsigned long attrs);
>   void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>   		int nents, enum dma_data_direction dir, unsigned long attrs);
> +int pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state,
> +		struct device *dev, struct scatterlist *sg,
> +		unsigned long dma_attrs);
> +void pci_p2pdma_map_bus_segment(struct scatterlist *pg_sg,
> +				struct scatterlist *dma_sg);
>   int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
>   			    bool *use_p2pdma);
>   ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
> @@ -109,6 +120,16 @@ static inline void pci_p2pdma_unmap_sg_attrs(struct device *dev,
>   		unsigned long attrs)
>   {
>   }
> +static inline int pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state,
> +		struct device *dev, struct scatterlist *sg,
> +		unsigned long dma_attrs)
> +{
> +	return 0;
> +}
> +static inline void pci_p2pdma_map_bus_segment(struct scatterlist *pg_sg,
> +					      struct scatterlist *dma_sg)
> +{
> +}
>   static inline int pci_p2pdma_enable_store(const char *page,
>   		struct pci_dev **p2p_dev, bool *use_p2pdma)
>   {
> 

