Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53AC713AF62
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 17:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgANQaQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 11:30:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52111 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgANQaP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2020 11:30:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id d73so14537174wmd.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2020 08:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FxzudKMd6YPzfM/0BCFYKKllAjp2Gts8h1iV+G6imWk=;
        b=s+Iyq+RN5AGDwxAr+7mKSPO+f5dVtM5aGFjxvkHZQBHQwXAqMg2vwzQPELgT1uodlp
         JXy/DuVb0oRdwbqTf/mCxgl+cpu3UILK2AlyUaBXvCpExWHPCFV6DjDsEzNGUIwTZ5yM
         izcUzJzY0MkhGcHsS3VehJ5SVpR5GInPz9A9d6+sBta87TRrKVLGgT/8YECNLDXfV+wN
         deCf8GyzR05dexz2K+saRt/Eaug/UCfoJzH/YhFoJBGXqiTHp5FJxeXIrnqS8DzEb7YA
         xOg8gP/zZKWgb5mblk2brIQs9wCO4ujce8asFWCePfF4zyW1ssuhO8NuuUWvdyKNz3K7
         xxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FxzudKMd6YPzfM/0BCFYKKllAjp2Gts8h1iV+G6imWk=;
        b=BtdBASQiaRol+UIK7oeKt3lnWGK/XUN4NsfKiEuzo3GaZ26LVFZueTHiW1DDyUdFlu
         1Oul9Ff+AynCCVfIflVV4F+DvzhZHcYqep1+fbJZrr5jmajwmDMuHee2XuqdHklg5ZFX
         C7HmwvoLD9lHa1Onlm/MsCMPBKYeBoQzNRx1t40lfAwO66VhzVtkg9VncFPX/cLd7ya3
         6FDsEWteGjXFZVA06aa9oHEh0XzVh7HQygvzuN22fk9Rr+XQiezIFdxWh8tgTnMF5USq
         2ewbDWMtvG9/L0pEZFXFIkiolJKXPElp0b5FVYXDHQ68b2I53rqmpcbzM7zq5LJxAadS
         j2xA==
X-Gm-Message-State: APjAAAXuvek+f/nD76+HCx3OS167hAWzByaCut8o7BvW8BfBRHiriTTl
        mPBH1FJZ31iqVUur1pIcy7RDNw==
X-Google-Smtp-Source: APXvYqxmcTGf2eTNhXZGx1ouob2jWFN+Aj7RA5BSt55FfOJCn9ALBt2Ou920JluYTTjGalcW0fwmLw==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr29763542wmc.78.1579019414216;
        Tue, 14 Jan 2020 08:30:14 -0800 (PST)
Received: from myrica ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id u18sm19852028wrt.26.2020.01.14.08.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 08:30:13 -0800 (PST)
Date:   Tue, 14 Jan 2020 17:30:09 +0100
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
Subject: Re: [PATCH v4 07/13] iommu/arm-smmu-v3: Add support for Substream IDs
Message-ID: <20200114163009.GA5319@myrica>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
 <20191219163033.2608177-8-jean-philippe@linaro.org>
 <20200114123819.GC29222@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114123819.GC29222@willie-the-truck>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 14, 2020 at 12:38:19PM +0000, Will Deacon wrote:
> > +static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
> > +			     int ssid, bool leaf)
> > +{
> > +	size_t i;
> > +	unsigned long flags;
> > +	struct arm_smmu_master *master;
> > +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> > +	struct arm_smmu_cmdq_ent cmd = {
> > +		.opcode	= CMDQ_OP_CFGI_CD,
> > +		.cfgi	= {
> > +			.ssid	= ssid,
> > +			.leaf	= leaf,
> > +		},
> > +	};
> > +
> > +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> > +	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> > +		for (i = 0; i < master->num_sids; i++) {
> > +			cmd.cfgi.sid = master->sids[i];
> > +			arm_smmu_cmdq_issue_cmd(smmu, &cmd);
> > +		}
> > +	}
> > +	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> > +
> > +	arm_smmu_cmdq_issue_sync(smmu);
> 
> Can you send a follow-up patch converting this to batch submission, please?

Ok

> > +}
> > +
> >  static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
> >  					struct arm_smmu_cd_table *table,
> >  					size_t num_entries)
> > @@ -1498,34 +1541,65 @@ static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
> >  	return val;
> >  }
> >  
> > -static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
> > -				    struct arm_smmu_s1_cfg *cfg)
> > +static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
> > +				   int ssid, struct arm_smmu_ctx_desc *cd)
> >  {
> > -	u64 val;
> > -	__le64 *cdptr = cfg->table.ptr;
> > -
> >  	/*
> > -	 * We don't need to issue any invalidation here, as we'll invalidate
> > -	 * the STE when installing the new entry anyway.
> > +	 * This function handles the following cases:
> > +	 *
> > +	 * (1) Install primary CD, for normal DMA traffic (SSID = 0).
> > +	 * (2) Install a secondary CD, for SID+SSID traffic.
> > +	 * (3) Update ASID of a CD. Atomically write the first 64 bits of the
> > +	 *     CD, then invalidate the old entry and mappings.
> > +	 * (4) Remove a secondary CD.
> >  	 */
> > -	val = arm_smmu_cpu_tcr_to_cd(cfg->cd.tcr) |
> > -#ifdef __BIG_ENDIAN
> > -	      CTXDESC_CD_0_ENDI |
> > -#endif
> > -	      CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET |
> > -	      CTXDESC_CD_0_AA64 | FIELD_PREP(CTXDESC_CD_0_ASID, cfg->cd.asid) |
> > -	      CTXDESC_CD_0_V;
> > +	u64 val;
> > +	bool cd_live;
> > +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> > +	__le64 *cdptr = smmu_domain->s1_cfg.table.ptr + ssid *
> > +			CTXDESC_CD_DWORDS;
> >  
> > -	/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
> > -	if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
> > -		val |= CTXDESC_CD_0_S;
> > +	val = le64_to_cpu(cdptr[0]);
> > +	cd_live = !!(val & CTXDESC_CD_0_V);
> >  
> > -	cdptr[0] = cpu_to_le64(val);
> > +	if (!cd) { /* (4) */
> > +		val = 0;
> > +	} else if (cd_live) { /* (3) */
> > +		val &= ~CTXDESC_CD_0_ASID;
> > +		val |= FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid);
> > +		/*
> > +		 * Until CD+TLB invalidation, both ASIDs may be used for tagging
> > +		 * this substream's traffic
> > +		 */
> 
> I don't think you need to change anything here, but I do find it a little
> scary that we can modify live CDs like this. However, given that the
> hardware is permitted to cache the structures regardless of validity, it
> appears to be the only option. Terrifying!
> 
> > +	} else { /* (1) and (2) */
> > +		cdptr[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
> 
> Can you use FIELD_PREP here too?

No, FIELD_PREP will shift ttbr left by 4 bits

> > +		cdptr[2] = 0;
> > +		cdptr[3] = cpu_to_le64(cd->mair);
> > +
> > +		/*
> > +		 * STE is live, and the SMMU might read dwords of this CD in any
> > +		 * order. Ensure that it observes valid values before reading
> > +		 * V=1.
> > +		 */
> > +		arm_smmu_sync_cd(smmu_domain, ssid, true);
> >  
> > -	val = cfg->cd.ttbr & CTXDESC_CD_1_TTB0_MASK;
> > -	cdptr[1] = cpu_to_le64(val);
> > +		val = arm_smmu_cpu_tcr_to_cd(cd->tcr) |
> > +#ifdef __BIG_ENDIAN
> > +			CTXDESC_CD_0_ENDI |
> > +#endif
> > +			CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET |
> > +			CTXDESC_CD_0_AA64 |
> > +			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
> > +			CTXDESC_CD_0_V;
> >  
> > -	cdptr[3] = cpu_to_le64(cfg->cd.mair);
> > +		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
> > +		if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
> > +			val |= CTXDESC_CD_0_S;
> > +	}
> > +
> > +	WRITE_ONCE(cdptr[0], cpu_to_le64(val));
> 
> Can you add a comment here citing 3.21.3 ("Configuration structures and
> configuration invalidation completion") please? Specifically, the note that
> states:
> 
>   | The size of single-copy atomic reads made by the SMMU is IMPLEMENTATION
>   | DEFINED but must be at least 64 bits.
> 
> Because that's really crucial to the WRITE_ONCE() above!
> 
> Shouldn't we also do the same thing for the STE side of things? I think so,
> and you can just comment of them with the quote and cite the comment from
> the other callsite.

Yes, makes sense

Thanks,
Jean
