Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBB1370F80
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 00:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhEBWxJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 May 2021 18:53:09 -0400
Received: from mail-dm6nam10on2089.outbound.protection.outlook.com ([40.107.93.89]:9516
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230036AbhEBWxI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 May 2021 18:53:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/3S7AnZnqXN/uUCuPy+6l5+WlSUXgn8zE2sXtubMKGyTZFxyp1KZgKB9vjL90+JXn6eKbWojhSkGqZ52/mNqPsC35A+b0Lw3R9s9badke+2C8kCOo6x2ssgzrqz8Y9l+S9xRKDpn0D2PV/yHivoAZADlcd4ZQa3ZJk3j+75Qv4cZ+xw0uO+tssefwu0pajCmeMOJgPTWUn1Hy6OlLiC0ULrdhIvIcmjz1LEUNj2iI6jRCOYPzytBbb7qofAuxR3MNtQE3GONWgYj3ZorbBIFIBcGCJByIm01lO7WzYU28vd0fbGjl8B5OMzUZWEv9Ee0lZDsY3mLPZe5s+RUWkedw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MonRR6ANVoTh06vS780zLQdfVLria4UHCRKqtcEpuwA=;
 b=UXavXehpHQNGNdfyLZLZ92DXuQUufJwrYQqXUjBqTrQPQKbz3xiWEWHd5yGcoWWWOEoXGq6yt2Ti5EJqtB19SmPpR3zzhxk3o1XLGQeCaxCfJE8N7I005X9QSmNiB1X5WGIdhH+4TQjU8NZsFkdongHzsu4guf8MkqkOqpD9+Ad1NU7Jj1LEUifSV2TTHmr9cqPTN75ibGa6tIOFicqppWG1oCTnjil1LsHPHRf9TCBF9bGlvkcPvku14Fugom1vgkiffZJKbk+u4jTG8q8vufYGGJQtK5GZBujnF1ML7eAGIX0+limsfb6uEfggkWa6iomlBy4DZFfejRackj9fag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MonRR6ANVoTh06vS780zLQdfVLria4UHCRKqtcEpuwA=;
 b=uH0agEqEFEMh+7jQDvqOVb5D+LXmdQZlwEVHH01VurAiHzwcT5NxpcWFFQDwsaIEYl2/UxfR5DUckfgTbC7kHiKQBgxuZbhaxwiLDbu3FegJO/914YQTMS4Sdn0E5lIO1FL7pxu+ALcDuluTIbyP2iXC+H5vAxZZbB52XUIvpcbyzOXwycgYpuXuSRYaUJ92JTxv2ZK+FrhgiO+MbDH+b12fh6DXZaEb/x9+04YwHsMIBc4h1VKMzEjlnFNWB0fX8/1Z/du213ZaHBun/gEKrTvB5o8MG4PCqcSqY4bekpbiZIFz9WVeh6ApyA9C+vWg0oOIbjH8J+4zzGurOTTe0A==
Received: from MWHPR12CA0052.namprd12.prod.outlook.com (2603:10b6:300:103::14)
 by BN9PR12MB5083.namprd12.prod.outlook.com (2603:10b6:408:134::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Sun, 2 May
 2021 22:52:14 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::ec) by MWHPR12CA0052.outlook.office365.com
 (2603:10b6:300:103::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Sun, 2 May 2021 22:52:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Sun, 2 May 2021 22:52:13 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 2 May
 2021 22:52:13 +0000
Subject: Re: [PATCH 08/16] PCI/P2PDMA: Introduce helpers for dma_map_sg
 implementations
To:     Logan Gunthorpe <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-mm@kvack.org>, <iommu@lists.linux-foundation.org>
CC:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
        Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-9-logang@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <090c9792-bddd-e99e-92b0-724a6fbbef03@nvidia.com>
Date:   Sun, 2 May 2021 15:52:12 -0700
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
X-MS-Office365-Filtering-Correlation-Id: b4df4d96-db96-481b-69e1-08d90dbced8a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5083:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5083718B11588F592B224088A85C9@BN9PR12MB5083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUQ/2ty3W8SWSzVOcol1P+iG8WAjYfnS0/2ST1b/pDjPViW1Yts/zFvzpBptvc7oVLxC6rMRuWFALLiHp1356SghvfnmjBYh8KV2uZLzZ+xMBJQX/vMQjgd7ZFgY2yMeDeZpNJEgyf9CW2C9tMISAH9FpcLB3bHzwU9jIEfspa9P04NPD0PFoUEM81IuBnBhmLj/9Ghj2AL5BXVUE/dHhNYYuOjPEmejgch2F3AuAQoDvuraP3KirgZBMgEaylDnfm37h5JRgJw5AEM3r8hpTLi6mZoORrX5iYcSLxAAHWoFqFPniUY8eHQCSlw9KsO/GExqGI38z3t2xB+Pl9X8ZpSv9kKAQOtXdEZRDejBR+zoUVSG1nl2ZMNphdxrCavIpsaZcwX4pTyC7I9VYsazKtIvOf0AorfmVPJoCQtopePa0cwNPdjUjXFPpGHtseG96nKLDjAILTqEyb9Kiu7KmhQ95DpVvKmbMxYvoomd7RqJXEQwm1btZHuIa7/+z9KCxzhCbQ8SvSBLI1+tN/BSWJKGFZ77mS9kacVw4RfxyaJJ8W60NIQg0d3aa+gEb4hFpw+Afwk3HQMQcg5Y/VfLIMkeoaTb1OF7HMhALSTucTB3GzHv+FLl7QSzcCZmjQngNtO4gGX7xqfwNhw9v8SsV+JmhYDE5vZfTExsu40he80xVm1k3ChfYeRvjWpBFXH8/7CRLgsRcdJ9HZju5/sYyg==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966006)(36840700001)(4326008)(70206006)(70586007)(2616005)(336012)(186003)(31686004)(426003)(5660300002)(82740400003)(16526019)(26005)(2906002)(316002)(16576012)(36906005)(7416002)(7636003)(36756003)(86362001)(8676002)(31696002)(54906003)(82310400003)(8936002)(83380400001)(356005)(36860700001)(53546011)(47076005)(478600001)(110136005)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2021 22:52:13.8110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4df4d96-db96-481b-69e1-08d90dbced8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5083
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
> Also add pci_p2pdma_map_bus_segment() which is useful for IOMMU
> dma_map_sg() implementations where the sg segment containing the page
> differs from the sg segment containing the DMA address.
> 

Hard to properly review this patch by itself, because it doesn't show
any callers of the new routine. If you end up shuffling patches and/or
refactoring for other reasons, it would be nice if the next version of
the series included a caller here. In particular, the new
pci_p2pdma_map_state concept is something I want to double-check, to
see if it hits any common pitfalls. I'm sure it doesn't, but still. :)

Meanwhile, I'll keep working through the series, and come back to this
one when I have seen the callers.

thanks,
-- 
John Hubbard
NVIDIA

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
> + * @pg_sg: scatterlist segment with the page to map
> + * @dma_sg: scatterlist segment to assign a dma address to
> + *
> + * This is a helper for iommu dma_map_sg() implementations when the
> + * segment for the dma address differs from the segment containing the
> + * source page.
> + *
> + * pci_p2pdma_map_type() must have already been called on the pg_sg and
> + * returned PCI_P2PDMA_MAP_BUS_ADDR.
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

