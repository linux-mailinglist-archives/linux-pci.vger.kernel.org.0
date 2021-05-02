Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE0D370F79
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 00:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhEBWfN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 May 2021 18:35:13 -0400
Received: from mail-mw2nam10on2065.outbound.protection.outlook.com ([40.107.94.65]:11968
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232166AbhEBWfN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 May 2021 18:35:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bwx2JECd34Rm6FLQEtzbggXzH78hUgyrEwarbqt4287MUNbpeO34n0U8dJtqiveZA7dD7qGxfHBQ+iPvqv99SRy90ftWHM2850eoOXnQs3tWx7/ic6pYkiuvx37Khvkj1xM4X/JR82wSYbjWN+w7RPfQ34/CwcXlZ0yUgRw+fXgE66tWcTqFz0/J7Z8tvGzOH5Li5FQhcVBLjjhQLbG3X0Gb23OtBRO78Vl0+Kqowd6t5eQpJMok/Mqtu4LeT6+Wt4y4QiySWNSZNk/YondZL4KKxkZqcxpPliK++8fiFGn9iXjvK1dZE6BQQEcnHct5ui7ujy7fG1puem1rct90hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUS8/hzdI2bLakxsX4eraydP/gCVYGt1jijU0nshQWk=;
 b=C9acdelkoWWzqI+HA8BoVsoWUb1lPTW97G6WReZp/zXkw69Sffre4eBbgOUDaxn8orh6glFc03TFXdSHDYf30ikz5iIDhxuFTlPBLS/6zF1qv8PpNOdZrj5qAl/Ke6LY9AmDSPPq3PxV2lNOSwFmywMC6WurBAf276pd22x2Yz5VRAxXzXCpFqfbrT1cuW+kOTYLRv3pR6Sv1wuQ/nvH0Y7/M2t2NCGKt77vLDm6wrAbfCvyzrEtArUY/XJxsx6Jaz2KbHy/UWUHxdt64Rk8CgcSxC1ywdsS2OzR+1u7PsSNWY6Y+NBOSN3w+DV8aEJ25c9RsiGXYWtPA+GQYGzT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUS8/hzdI2bLakxsX4eraydP/gCVYGt1jijU0nshQWk=;
 b=Vfe31iAYGh3R5qzX3EJs3Es0yGgin/zujM97KIyfIG4lUpSzRtIT3Rn3MIyOvBZrc2AYw+L1RilPYVrUJhPLuiy01v9oKGFQKdrhWL5CFu30oXFiGK9tV2QvmkGPN8RfPO4f+d4VaDhwDvSmBcyGdd92qghLIkOCrzJkOVQObLlviz1KEodGVPGTMNnT2U7SWGRxxUNamdjF1t4iaJ6RHHMnmLotUXP5ITsi0acARifuyWCMn/zzzhRH3Tk2+niZG9QrCIhLvTApHXxB49HaM4SuoitS/2STdf0maT4FJvU1PceMLPIfOpVyW+saMU+Erwy3/FxwS1fteMofxV3EQw==
Received: from BN8PR04CA0025.namprd04.prod.outlook.com (2603:10b6:408:70::38)
 by CY4PR12MB1750.namprd12.prod.outlook.com (2603:10b6:903:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Sun, 2 May
 2021 22:34:19 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::c1) by BN8PR04CA0025.outlook.office365.com
 (2603:10b6:408:70::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Sun, 2 May 2021 22:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Sun, 2 May 2021 22:34:18 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 2 May
 2021 22:34:18 +0000
Subject: Re: [PATCH 06/16] lib/scatterlist: Add flag for indicating P2PDMA
 segments in an SGL
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
 <20210408170123.8788-7-logang@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <4a1f06c2-a120-56f5-37a7-e4625a5f275c@nvidia.com>
Date:   Sun, 2 May 2021 15:34:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-7-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7eee2504-ae3b-44d4-3dc8-08d90dba6cce
X-MS-TrafficTypeDiagnostic: CY4PR12MB1750:
X-Microsoft-Antispam-PRVS: <CY4PR12MB17505301FADB6367B8B6F6F4A85C9@CY4PR12MB1750.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dE4ZRi7+LyKRpCJxgyNwRThjOb79h03jQuxx/SBux5QEa3QdE8X6JsMJeE5GED/svyNNKvSssukE6HibHTxAngZh/jO0K9MmPLyIjMqYpGcG9cWAMuwg/UDUKrIypeIDCzyAY/JfKbRYdvdvFCwzkX5Mmujgc1e4Y5/1Zx3hiph1qCSXRnfeoneWOAkRQRZP+l6X4i56cZqI2KkclBGybOafPGhZri0YeIfFYAgKXfco2O6WmktW2VDCV2nCMbjAL9zKuiFNY52NUBgKJCBcYj7xm9gShNpdk+3i5WU7uHEF4OFoGFlYSFx1BDwlz6rEX2nQECHy/CMxdJDmlz2/mqiAwp+14D3dSb4mMFNksgKB8oxer21ZthGM1iOS9DiDvqm2268PTfi88t2lk43JWj7aLss5ndzMd0pP566FJ+A76voYkFrhspE8tIgt419jdFiqtxO5j4rnMn8/FpfuR9JIdOqNiphyCwAO35wtcZiF9kk5kh3Sk6BTYOAxuYsXw6F3eYkS+FmA+cV2GKO6fjB+avU+KkcmZH3tuPl34QXGjEhwzcVklMZeD84pWY1Gof3mgC1szIa7UNAYCfF506EskXeXUDISIkL+KwYLt/Sk36+oV98xa1WpA15sLx4aGVchZt8WlCAf3no0OpGJ4yZSWfnFrpFkN+bQkiEppxwUquGsOjY67NOcQ6ZylymLEAYCSEwFsoengXDXH+bU1g==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(4326008)(31686004)(8676002)(16576012)(5660300002)(110136005)(86362001)(83380400001)(26005)(36906005)(316002)(16526019)(47076005)(8936002)(7636003)(82740400003)(2906002)(36756003)(54906003)(70586007)(53546011)(70206006)(2616005)(356005)(336012)(82310400003)(7416002)(478600001)(31696002)(36860700001)(186003)(426003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2021 22:34:18.8330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eee2504-ae3b-44d4-3dc8-08d90dba6cce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1750
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
> Make use of the third free LSB in scatterlist's page_link on 64bit systems.
> 
> The extra bit will be used by dma_[un]map_sg_p2pdma() to determine when a
> given SGL segments dma_address points to a PCI bus address.
> dma_unmap_sg_p2pdma() will need to perform different cleanup when a
> segment is marked as P2PDMA.
> 
> Using this bit requires adding an additional dependency on CONFIG_64BIT to
> CONFIG_PCI_P2PDMA. This should be acceptable as the majority of P2PDMA
> use cases are restricted to newer root complexes and roughly require the
> extra address space for memory BARs used in the transactions.

Totally agree with the CONFIG_64BIT call.

Also, I have failed to find anything wrong with this patch. :)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/pci/Kconfig         |  2 +-
>   include/linux/scatterlist.h | 49 ++++++++++++++++++++++++++++++++++---
>   2 files changed, 46 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 0c473d75e625..90b4bddb3300 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -163,7 +163,7 @@ config PCI_PASID
>   
>   config PCI_P2PDMA
>   	bool "PCI peer-to-peer transfer support"
> -	depends on ZONE_DEVICE
> +	depends on ZONE_DEVICE && 64BIT
>   	select GENERIC_ALLOCATOR
>   	help
>   	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 6f70572b2938..5525d3ebf36f 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -58,6 +58,21 @@ struct sg_table {
>   #define SG_CHAIN	0x01UL
>   #define SG_END		0x02UL
>   
> +/*
> + * bit 2 is the third free bit in the page_link on 64bit systems which
> + * is used by dma_unmap_sg() to determine if the dma_address is a PCI
> + * bus address when doing P2PDMA.
> + * Note: CONFIG_PCI_P2PDMA depends on CONFIG_64BIT because of this.
> + */
> +
> +#ifdef CONFIG_PCI_P2PDMA
> +#define SG_PCI_P2PDMA	0x04UL
> +#else
> +#define SG_PCI_P2PDMA	0x00UL
> +#endif
> +
> +#define SG_PAGE_LINK_MASK (SG_CHAIN | SG_END | SG_PCI_P2PDMA)
> +
>   /*
>    * We overload the LSB of the page pointer to indicate whether it's
>    * a valid sg entry, or whether it points to the start of a new scatterlist.
> @@ -65,8 +80,9 @@ struct sg_table {
>    */
>   #define sg_is_chain(sg)		((sg)->page_link & SG_CHAIN)
>   #define sg_is_last(sg)		((sg)->page_link & SG_END)
> +#define sg_is_pci_p2pdma(sg)	((sg)->page_link & SG_PCI_P2PDMA)
>   #define sg_chain_ptr(sg)	\
> -	((struct scatterlist *) ((sg)->page_link & ~(SG_CHAIN | SG_END)))
> +	((struct scatterlist *) ((sg)->page_link & ~SG_PAGE_LINK_MASK))
>   
>   /**
>    * sg_assign_page - Assign a given page to an SG entry
> @@ -80,13 +96,13 @@ struct sg_table {
>    **/
>   static inline void sg_assign_page(struct scatterlist *sg, struct page *page)
>   {
> -	unsigned long page_link = sg->page_link & (SG_CHAIN | SG_END);
> +	unsigned long page_link = sg->page_link & SG_PAGE_LINK_MASK;
>   
>   	/*
>   	 * In order for the low bit stealing approach to work, pages
>   	 * must be aligned at a 32-bit boundary as a minimum.
>   	 */
> -	BUG_ON((unsigned long) page & (SG_CHAIN | SG_END));
> +	BUG_ON((unsigned long) page & SG_PAGE_LINK_MASK);
>   #ifdef CONFIG_DEBUG_SG
>   	BUG_ON(sg_is_chain(sg));
>   #endif
> @@ -120,7 +136,7 @@ static inline struct page *sg_page(struct scatterlist *sg)
>   #ifdef CONFIG_DEBUG_SG
>   	BUG_ON(sg_is_chain(sg));
>   #endif
> -	return (struct page *)((sg)->page_link & ~(SG_CHAIN | SG_END));
> +	return (struct page *)((sg)->page_link & ~SG_PAGE_LINK_MASK);
>   }
>   
>   /**
> @@ -222,6 +238,31 @@ static inline void sg_unmark_end(struct scatterlist *sg)
>   	sg->page_link &= ~SG_END;
>   }
>   
> +/**
> + * sg_mark_pci_p2pdma - Mark the scatterlist entry for PCI p2pdma
> + * @sg:		 SG entryScatterlist
> + *
> + * Description:
> + *   Marks the passed in sg entry to indicate that the dma_address is
> + *   a PCI bus address.
> + **/
> +static inline void sg_mark_pci_p2pdma(struct scatterlist *sg)
> +{
> +	sg->page_link |= SG_PCI_P2PDMA;
> +}
> +
> +/**
> + * sg_unmark_pci_p2pdma - Unmark the scatterlist entry for PCI p2pdma
> + * @sg:		 SG entryScatterlist
> + *
> + * Description:
> + *   Clears the PCI P2PDMA mark
> + **/
> +static inline void sg_unmark_pci_p2pdma(struct scatterlist *sg)
> +{
> +	sg->page_link &= ~SG_PCI_P2PDMA;
> +}
> +
>   /**
>    * sg_phys - Return physical address of an sg entry
>    * @sg:	     SG entry
> 
