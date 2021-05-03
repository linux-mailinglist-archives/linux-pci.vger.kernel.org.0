Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B061E371045
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 03:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhECBPi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 May 2021 21:15:38 -0400
Received: from mail-bn7nam10on2076.outbound.protection.outlook.com ([40.107.92.76]:2176
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232763AbhECBPh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 May 2021 21:15:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkVsWC2CyWbrEEVPjBECNANXTMt5ocqR1q+cDkOpMfMz4693ivTjryWJWgZ2dZgdtwjkoG8Bz2nxWFKEE0u2KU8gEn+dEb5Sfb0q0cdk5GFiqbCeT8r4u3C3pZDNIEesjTehdp7upfqP1zw24P41OGDGz9of2/GiqkMBXojeZ/zK+qLomT3S1anIY3+lKKYTtgOC7TbBjp8AJuMYtrOHmP+MDQvmsrmDdE9k/ZhxjOiyn69EMcpLwjV0NjqD8w/OGesvESY0jBPA1tJ6JlscBqRxfdklhWTyQYOLuddUSiPKJMf7YKMMnjjIu9srS26IrnVBlOybknVy+37qgtD1lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gjhsxq6rB1PcZhAAZv6pZgQt+q4Du84vltxdwA9ZV4w=;
 b=hNYPJ00KYOkHk/EbF96tYQ3lvU792PivzdoXoT+WrleLgMTl+g/Znuk6ViJVgHEkAzmyMblceKGIgpAddUvWOsIrTX0fTsyQckNI02vya39RN4MEGwf8ubnGu5Lz/2b398L7CGHXZcpeCbsq1fiaIk/awB8Gwm9foYfRae679rad2RCNS5L8V9rGSoFBoTkrZUUwBIFoAfrtxNYXfrZCZeXP5TGT6Nu+bm2zqX+1CL3Pojb/IliE68131IO1+w3pTfXo1YdWh2Hm4BtdmpJyJRLW93H5ioF4/eKMHKpKIBZ1AcBkCbm/r54q7ziG8mu4xshQiy++9daPR+pL7P5k/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gjhsxq6rB1PcZhAAZv6pZgQt+q4Du84vltxdwA9ZV4w=;
 b=lQ9cW1Ld5yh7oF2PFJH7sIL3PZ8n2iVmHklLfGeH6hNg2Zyd/74zKJEHHJWysr9jwOq4GTAW8LTM8V6agQirwbRQ1Udq9IUkdW65xhn2POOf4OPNspMksom0Ihc2TW42MhNtUHpJgUvufGpFMnCDlBcoV127I46I9js/lxdk+ZBwC+kVGzrkXHfkjhfzS1DB24A6Jz8Bx9ESw6PNfiKTr1dE7Cq/UbBY+kByVUK/KLV8YjeJgUXDV6E67HVDvwfzO90I9UtmHFDqdct0L1MXBa3TXvuHrhCglS6RHk+gB4GX411bM72m8ShxLpRJqdoVICAfKgoDA5l1+Whw+dowAQ==
Received: from BN6PR11CA0053.namprd11.prod.outlook.com (2603:10b6:404:f7::15)
 by SJ0PR12MB5440.namprd12.prod.outlook.com (2603:10b6:a03:3ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Mon, 3 May
 2021 01:14:42 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::e9) by BN6PR11CA0053.outlook.office365.com
 (2603:10b6:404:f7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Mon, 3 May 2021 01:14:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.32 via Frontend Transport; Mon, 3 May 2021 01:14:41 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 3 May
 2021 01:14:41 +0000
Subject: Re: [PATCH 11/16] iommu/dma: Support PCI P2PDMA pages in dma-iommu
 map_sg
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
 <20210408170123.8788-12-logang@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <560b2653-ad00-9cc3-0645-df7aff278321@nvidia.com>
Date:   Sun, 2 May 2021 18:14:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-12-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9514550f-8a37-4f67-ce2a-08d90dd0d49b
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5440:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB54407A2D7591C8CE98D09156A85B9@SJ0PR12MB5440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m8/zYhF1PF9MlVDh3FmfxvP+KsAVOGIpt9kEU7sxR9CT9XKRjq2v8yhQN0jQappNH1OK7yZHd6Dg+q0hEKXW7rmDetu5XELLxNKWfI2qcGhlhXojjij+gCBpy3G/eh2d7Cm9gFoBhrSe5KaeOz+odpwiAlDGj29k+CgxgPqlDu8DgCOHz30sE1L9kBIb5BB+zuIzTYzDjZrZkGDEImjxeXd1ekvBrJlDzhgkuUphaXABUXZ78oRHmy87+LxuawVTfjFmQt1UsoQBtecmXVgNnitl5vzZLq7783f6RQWy1oBVqD7t8DhPR6Ef5FmIb5aQqJ7imAnyJT1vtfzZToR9il11zj5wmCqUfjq2VcgYFAgPC4Mpn6rbCeeF4l/1HhXfbyigB8oV0p0c6AlO7RLtU8REIuI9y4b+BL7HliRXXz0LS9hQzE4ppwnO5o3rX4qEbVEOpf3xD5GNU/5n0IbCpFbd3jxfJxI8NIdIOi5P4YbEJ6x/RTudbmeOzlpo/dJQMDeeJPOm0veZVrm6q6w+nPRVIVbQh07uxWhujdwq6jYotCCOEpOkfg/pjemrqzoydIFysfPimTTcloiSEbJfhm0jQBImYpd16fLOMpk80TdAcHKnaRHLXO8lYafcp3WZRzHWS2m31i7YhiHfVXPMcjjhAg7z0tg1OhsamvIHlCGnh54iVqZKAf16v5zj94l2qD6o9vL/FSTOg6z1x4msLQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(36840700001)(46966006)(7416002)(83380400001)(8676002)(356005)(2906002)(316002)(478600001)(82310400003)(8936002)(16526019)(7636003)(186003)(36860700001)(31686004)(5660300002)(336012)(36906005)(82740400003)(70206006)(26005)(47076005)(54906003)(86362001)(110136005)(2616005)(36756003)(31696002)(16576012)(426003)(4326008)(53546011)(70586007)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 01:14:41.9166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9514550f-8a37-4f67-ce2a-08d90dd0d49b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5440
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
> When a PCI P2PDMA page is seen, set the IOVA length of the segment
> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
> apply the appropriate bus address to the segment. The IOVA is not
> created if the scatterlist only consists of P2PDMA pages.
> 
> Similar to dma-direct, the sg_mark_pci_p2pdma() flag is used to
> indicate bus address segments. On unmap, P2PDMA segments are skipped
> over when determining the start and end IOVA addresses.
> 
> With this change, the flags variable in the dma_map_ops is
> set to DMA_F_PCI_P2PDMA_SUPPORTED to indicate support for
> P2PDMA pages.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/iommu/dma-iommu.c | 66 ++++++++++++++++++++++++++++++++++-----
>   1 file changed, 58 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index af765c813cc8..ef49635f9819 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -20,6 +20,7 @@
>   #include <linux/mm.h>
>   #include <linux/mutex.h>
>   #include <linux/pci.h>
> +#include <linux/pci-p2pdma.h>
>   #include <linux/swiotlb.h>
>   #include <linux/scatterlist.h>
>   #include <linux/vmalloc.h>
> @@ -864,6 +865,16 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
>   		sg_dma_address(s) = DMA_MAPPING_ERROR;
>   		sg_dma_len(s) = 0;
>   
> +		if (is_pci_p2pdma_page(sg_page(s)) && !s_iova_len) {

Newbie question: I'm in the dark as to why the !s_iova_len check is there,
can you please enlighten me?

> +			if (i > 0)
> +				cur = sg_next(cur);
> +
> +			pci_p2pdma_map_bus_segment(s, cur);
> +			count++;
> +			cur_len = 0;
> +			continue;
> +		}
> +

This is really an if/else condition. And arguably, it would be better
to split out two subroutines, and call one or the other depending on
the result of if is_pci_p2pdma_page(), instead of this "continue" approach.

>   		/*
>   		 * Now fill in the real DMA data. If...
>   		 * - there is a valid output segment to append to
> @@ -961,10 +972,12 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	struct iova_domain *iovad = &cookie->iovad;
>   	struct scatterlist *s, *prev = NULL;
>   	int prot = dma_info_to_prot(dir, dev_is_dma_coherent(dev), attrs);
> +	struct dev_pagemap *pgmap = NULL;
> +	enum pci_p2pdma_map_type map_type;
>   	dma_addr_t iova;
>   	size_t iova_len = 0;
>   	unsigned long mask = dma_get_seg_boundary(dev);
> -	int i;
> +	int i, ret = 0;
>   
>   	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
>   	    iommu_deferred_attach(dev, domain))
> @@ -993,6 +1006,31 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   		s_length = iova_align(iovad, s_length + s_iova_off);
>   		s->length = s_length;
>   
> +		if (is_pci_p2pdma_page(sg_page(s))) {
> +			if (sg_page(s)->pgmap != pgmap) {
> +				pgmap = sg_page(s)->pgmap;
> +				map_type = pci_p2pdma_map_type(pgmap, dev,
> +							       attrs);
> +			}
> +
> +			switch (map_type) {
> +			case PCI_P2PDMA_MAP_BUS_ADDR:
> +				/*
> +				 * A zero length will be ignored by
> +				 * iommu_map_sg() and then can be detected
> +				 * in __finalise_sg() to actually map the
> +				 * bus address.
> +				 */
> +				s->length = 0;
> +				continue;
> +			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +				break;
> +			default:
> +				ret = -EREMOTEIO;
> +				goto out_restore_sg;
> +			}
> +		}
> +
>   		/*
>   		 * Due to the alignment of our single IOVA allocation, we can
>   		 * depend on these assumptions about the segment boundary mask:
> @@ -1015,6 +1053,9 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   		prev = s;
>   	}
>   
> +	if (!iova_len)
> +		return __finalise_sg(dev, sg, nents, 0);
> +

ohhh, we're really slicing up this function pretty severely, what with the
continue and the early out and several other control flow changes. I think
it would be better to spend some time factoring this function into two
cases, now that you're adding a second case for PCI P2PDMA. Roughly,
two subroutines would do it.

As it is, this leaves behind a routine that is extremely hard to mentally
verify as correct.


thanks,
-- 
John Hubbard
NVIDIA

>   	iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
>   	if (!iova)
>   		goto out_restore_sg;
> @@ -1032,13 +1073,13 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	iommu_dma_free_iova(cookie, iova, iova_len, NULL);
>   out_restore_sg:
>   	__invalidate_sg(sg, nents);
> -	return 0;
> +	return ret;
>   }
>   
>   static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   		int nents, enum dma_data_direction dir, unsigned long attrs)
>   {
> -	dma_addr_t start, end;
> +	dma_addr_t end, start = DMA_MAPPING_ERROR;
>   	struct scatterlist *tmp;
>   	int i;
>   
> @@ -1054,14 +1095,22 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   	 * The scatterlist segments are mapped into a single
>   	 * contiguous IOVA allocation, so this is incredibly easy.
>   	 */
> -	start = sg_dma_address(sg);
> -	for_each_sg(sg_next(sg), tmp, nents - 1, i) {
> +	for_each_sg(sg, tmp, nents, i) {
> +		if (sg_is_pci_p2pdma(tmp)) {
> +			sg_unmark_pci_p2pdma(tmp);
> +			continue;
> +		}
>   		if (sg_dma_len(tmp) == 0)
>   			break;
> -		sg = tmp;
> +
> +		if (start == DMA_MAPPING_ERROR)
> +			start = sg_dma_address(tmp);
> +
> +		end = sg_dma_address(tmp) + sg_dma_len(tmp);
>   	}
> -	end = sg_dma_address(sg) + sg_dma_len(sg);
> -	__iommu_dma_unmap(dev, start, end - start);
> +
> +	if (start != DMA_MAPPING_ERROR)
> +		__iommu_dma_unmap(dev, start, end - start);
>   }
>   
>   static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
> @@ -1254,6 +1303,7 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
>   }
>   
>   static const struct dma_map_ops iommu_dma_ops = {
> +	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
>   	.alloc			= iommu_dma_alloc,
>   	.free			= iommu_dma_free,
>   	.alloc_pages		= dma_common_alloc_pages,
> 

