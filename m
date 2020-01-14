Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1CB113AD02
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 16:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgANPEn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 10:04:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:46266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbgANPEn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 10:04:43 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7433222C4;
        Tue, 14 Jan 2020 15:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579014282;
        bh=41bJSGrfq4ZIM0M/ydUTdPdKoDOXm3woHYUUSROZmos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PWMQZFvdmogw0QY+S9fXChT2b/pn5YqBxZgzZLBEeu/5yDuLgd0uiB6/KdoJ1DsZD
         HaknwZUOoXN8vIaorFP8b/Dwc2HJzgQ2oBc9ig/GGYIxBhX/2XVr8FWi2u1B1bi1zt
         VQjR3YyEs4nPsQmYFWMkOQW9psUJebD+WbrPb9Ko=
Date:   Tue, 14 Jan 2020 15:04:36 +0000
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com, eric.auger@redhat.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: Re: [PATCH v4 10/13] iommu/arm-smmu-v3: Add second level of context
 descriptor table
Message-ID: <20200114150435.GA2579@willie-the-truck>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
 <20191219163033.2608177-11-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219163033.2608177-11-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 19, 2019 at 05:30:30PM +0100, Jean-Philippe Brucker wrote:
> The SMMU can support up to 20 bits of SSID. Add a second level of page
> tables to accommodate this. Devices that support more than 1024 SSIDs now
> have a table of 1024 L1 entries (8kB), pointing to tables of 1024 context
> descriptors (64kB), allocated on demand.
> 
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 154 +++++++++++++++++++++++++++++++++---
>  1 file changed, 144 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index b825a5639afc..bf106a7b53eb 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -224,6 +224,7 @@
>  
>  #define STRTAB_STE_0_S1FMT		GENMASK_ULL(5, 4)
>  #define STRTAB_STE_0_S1FMT_LINEAR	0
> +#define STRTAB_STE_0_S1FMT_64K_L2	2
>  #define STRTAB_STE_0_S1CTXPTR_MASK	GENMASK_ULL(51, 6)
>  #define STRTAB_STE_0_S1CDMAX		GENMASK_ULL(63, 59)
>  
> @@ -263,7 +264,20 @@
>  
>  #define STRTAB_STE_3_S2TTB_MASK		GENMASK_ULL(51, 4)
>  
> -/* Context descriptor (stage-1 only) */
> +/*
> + * Context descriptors.
> + *
> + * Linear: when less than 1024 SSIDs are supported
> + * 2lvl: at most 1024 L1 entries,
> + *       1024 lazy entries per table.
> + */
> +#define CTXDESC_SPLIT			10
> +#define CTXDESC_L2_ENTRIES		(1 << CTXDESC_SPLIT)
> +
> +#define CTXDESC_L1_DESC_DWORDS		1
> +#define CTXDESC_L1_DESC_VALID		1

	#define CTXDESC_L1_DESC_V	(1UL << 0)

fits better with the rest of the driver and also ensures that the thing
is unsigned (we should probably switch over the BIT macros, but that's a
separate cleanup patch).

> +#define CTXDESC_L1_DESC_L2PTR_MASK	GENMASK_ULL(51, 12)
> +
>  #define CTXDESC_CD_DWORDS		8
>  #define CTXDESC_CD_0_TCR_T0SZ		GENMASK_ULL(5, 0)
>  #define ARM64_TCR_T0SZ			GENMASK_ULL(5, 0)
> @@ -575,7 +589,12 @@ struct arm_smmu_cd_table {
>  };
>  
>  struct arm_smmu_s1_cfg {
> -	struct arm_smmu_cd_table	table;
> +	/* Leaf tables or linear table */
> +	struct arm_smmu_cd_table	*tables;
> +	size_t				num_tables;
> +	/* First level tables, when two levels are used */
> +	__le64				*l1ptr;
> +	dma_addr_t			l1ptr_dma;

It probably feels like a nit, but I think this is all a little hard to read
because it differs unnecessarily from the way the stream table is handled.

Could we align the two as follows? (I've commented things with what they
refer to in your patch):


struct arm_smmu_l1_ctx_desc {				// arm_smmu_cd_table
	__le64				*l2ptr;		// ptr
	dma_addr_t			l2ptr_dma;	// ptr_dma
};

struct arm_smmu_ctx_desc_cfg {
	__le64				*cdtab;		// l1ptr
	dma_addr_t			cdtab_dma;	// l1ptr_dma
	struct arm_smmu_l1_ctx_desc	*l1_desc;	// tables
	unsigned int			num_l1_ents;	// num_tables
};

struct arm_smmu_s1_cfg {
	struct arm_smmu_ctx_desc_cfg	cdcfg;
	struct arm_smmu_ctx_desc	cd;
	u8				s1fmt;
	u8				s1cdmax;
};


I don't know whether you'd then want to move s1fmt and s1cdmax into the
cdcfg, I'll leave that up to you. Similarly if you want any functions
to operate on arm_smmu_ctx_desc_cfg in preference to arm_smmu_s1_cfg.

Thoughts?

Will
