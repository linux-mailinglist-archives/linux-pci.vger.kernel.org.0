Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A295813BCAF
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 10:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgAOJpg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 04:45:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52436 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbgAOJpg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 04:45:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so17102991wmc.2
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2020 01:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9wkd2dirzcLFMZe8FU543qaw7ijLSERXETdbeouxTnU=;
        b=IDC5rTxOPsqytGko2kQMljlQZBwBuNt8KKgY8q6IVAW/ySemHw5OtVmZYZGFvfjk5l
         GlWXT2vBGCuAa2XIepytG7BISG5MAAQp4FClvQ+7Gxplg445NhK4ii3kFHCOsiYlGxrU
         A0ERCUq5C0NZDeEOmSipXTQkvujaqr4xuaaKREBVgZZJy16KyNEVMT81TD3kMfVjcAOQ
         BQFv4WUk6iuqMyuL27FXeIOxm/zELox0Uo4Fk771+4DoDhhuNYKEaxHul726afcE1Z+w
         7D2oyg9fcoJ5C8vJmJqnq6dIH9xPcEYIil5AL4CwSHtlP9I6O7Q/Ll2kfdeCGqGL66gx
         6wMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9wkd2dirzcLFMZe8FU543qaw7ijLSERXETdbeouxTnU=;
        b=ZUpGU8iP9teUa2q0JZ0nGQ5mewQuh8MFtB05pw2PQW9vH43J3QXK4OIasjpYE94eYw
         ozUM1TF74p1aKj0GJsUYE+Yb/qlHqM9a5dvf8/YS5aVARcg2TdyB+5FXc7+IN7VQVJ/q
         GWltx7iYe9pKMDG1waqvxgpun9bBJ2rN781M/3lzb4aqDnkW8ZZU3qTxVnAL6e1A58gw
         O/9R7cOqJaZ9YD0DxInT9xa/eWhG4LmiV+cRr3Zur62KeQBliuf3BEfhe9L8RFDoWLXy
         zfkEYZnksLeQJ+azBqh9LPHk4lFPnYQOuUgacqBmqdffFjmGSUjdL2FG7yO3og7wfBYl
         Z6kQ==
X-Gm-Message-State: APjAAAUMs59/KdPoz/nGsv4lcfqLESS2e3mRKeTkKybBNsEcL24X7tKs
        fqhcxm70xfqOQH7dLTLLRTRXqA==
X-Google-Smtp-Source: APXvYqxR2npzUP0k42uJhm9Im1rL58AtIxFUtjkScu/sxkhhW7+4pJhKUdhG5rM9VQoJWl4fFZgc9A==
X-Received: by 2002:a1c:488a:: with SMTP id v132mr31093095wma.153.1579081533150;
        Wed, 15 Jan 2020 01:45:33 -0800 (PST)
Received: from myrica ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id j2sm22908749wmk.23.2020.01.15.01.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 01:45:32 -0800 (PST)
Date:   Wed, 15 Jan 2020 10:45:27 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Will Deacon <will@kernel.org>
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
Message-ID: <20200115094527.GB32782@myrica>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
 <20191219163033.2608177-11-jean-philippe@linaro.org>
 <20200114150435.GA2579@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114150435.GA2579@willie-the-truck>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 14, 2020 at 03:04:36PM +0000, Will Deacon wrote:
> On Thu, Dec 19, 2019 at 05:30:30PM +0100, Jean-Philippe Brucker wrote:
> > The SMMU can support up to 20 bits of SSID. Add a second level of page
> > tables to accommodate this. Devices that support more than 1024 SSIDs now
> > have a table of 1024 L1 entries (8kB), pointing to tables of 1024 context
> > descriptors (64kB), allocated on demand.
> > 
> > Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 154 +++++++++++++++++++++++++++++++++---
> >  1 file changed, 144 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > index b825a5639afc..bf106a7b53eb 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -224,6 +224,7 @@
> >  
> >  #define STRTAB_STE_0_S1FMT		GENMASK_ULL(5, 4)
> >  #define STRTAB_STE_0_S1FMT_LINEAR	0
> > +#define STRTAB_STE_0_S1FMT_64K_L2	2
> >  #define STRTAB_STE_0_S1CTXPTR_MASK	GENMASK_ULL(51, 6)
> >  #define STRTAB_STE_0_S1CDMAX		GENMASK_ULL(63, 59)
> >  
> > @@ -263,7 +264,20 @@
> >  
> >  #define STRTAB_STE_3_S2TTB_MASK		GENMASK_ULL(51, 4)
> >  
> > -/* Context descriptor (stage-1 only) */
> > +/*
> > + * Context descriptors.
> > + *
> > + * Linear: when less than 1024 SSIDs are supported
> > + * 2lvl: at most 1024 L1 entries,
> > + *       1024 lazy entries per table.
> > + */
> > +#define CTXDESC_SPLIT			10
> > +#define CTXDESC_L2_ENTRIES		(1 << CTXDESC_SPLIT)
> > +
> > +#define CTXDESC_L1_DESC_DWORDS		1
> > +#define CTXDESC_L1_DESC_VALID		1
> 
> 	#define CTXDESC_L1_DESC_V	(1UL << 0)
> 
> fits better with the rest of the driver and also ensures that the thing
> is unsigned (we should probably switch over the BIT macros, but that's a
> separate cleanup patch).
> 
> > +#define CTXDESC_L1_DESC_L2PTR_MASK	GENMASK_ULL(51, 12)
> > +
> >  #define CTXDESC_CD_DWORDS		8
> >  #define CTXDESC_CD_0_TCR_T0SZ		GENMASK_ULL(5, 0)
> >  #define ARM64_TCR_T0SZ			GENMASK_ULL(5, 0)
> > @@ -575,7 +589,12 @@ struct arm_smmu_cd_table {
> >  };
> >  
> >  struct arm_smmu_s1_cfg {
> > -	struct arm_smmu_cd_table	table;
> > +	/* Leaf tables or linear table */
> > +	struct arm_smmu_cd_table	*tables;
> > +	size_t				num_tables;
> > +	/* First level tables, when two levels are used */
> > +	__le64				*l1ptr;
> > +	dma_addr_t			l1ptr_dma;
> 
> It probably feels like a nit, but I think this is all a little hard to read
> because it differs unnecessarily from the way the stream table is handled.
> 
> Could we align the two as follows? (I've commented things with what they
> refer to in your patch):
> 
> 
> struct arm_smmu_l1_ctx_desc {				// arm_smmu_cd_table
> 	__le64				*l2ptr;		// ptr
> 	dma_addr_t			l2ptr_dma;	// ptr_dma
> };
> 
> struct arm_smmu_ctx_desc_cfg {
> 	__le64				*cdtab;		// l1ptr
> 	dma_addr_t			cdtab_dma;	// l1ptr_dma
> 	struct arm_smmu_l1_ctx_desc	*l1_desc;	// tables
> 	unsigned int			num_l1_ents;	// num_tables
> };
> 
> struct arm_smmu_s1_cfg {
> 	struct arm_smmu_ctx_desc_cfg	cdcfg;
> 	struct arm_smmu_ctx_desc	cd;
> 	u8				s1fmt;
> 	u8				s1cdmax;
> };
> 
> 
> I don't know whether you'd then want to move s1fmt and s1cdmax into the
> cdcfg, I'll leave that up to you. Similarly if you want any functions
> to operate on arm_smmu_ctx_desc_cfg in preference to arm_smmu_s1_cfg.
> 
> Thoughts?

No problem, it looks cleaner overall.

Thanks,
Jean

