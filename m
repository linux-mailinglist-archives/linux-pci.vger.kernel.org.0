Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B38F3124CC8
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2019 17:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfLRQKe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Dec 2019 11:10:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38730 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfLRQKe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Dec 2019 11:10:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so2915034wrh.5
        for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2019 08:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c8CBYJotaME8s7Ii/JzatZyff2J7fay7KXQVz82AJFg=;
        b=Sxy90pGkAdWmS2Fgg1g9dDmRYM88EKGHw+3sHdVzrc/jXY1im07pY4qUv1tGNMFQQk
         IcekmR8ZcC3tFNKeEjDAkEGo31sQzuifBkI1yTZSgyo4SKdsyJsWbVwWFYGXwlPpAkhx
         XRuhpq4pljIs7U5JvYnTtLM4nZitTnXapzCw5DQHNgB6SeKoZJeGkQ1klqygxkp7+RpW
         WjEwhJC4iCG1aEKCSznQiMBQpuy+m+bSMgY28JLRnV8cBMrn15RqbaEHWG6RiNnqDhbN
         nih4Ob9CXvxvj259j4M6yjk+0zriLR+qz1v/rwXtQ0kpWi6stqyzl02mE7nywETjkOB5
         IjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c8CBYJotaME8s7Ii/JzatZyff2J7fay7KXQVz82AJFg=;
        b=rKidrZSx/Y02w41EpnYhY0aV4iQMsoVo1IfqafVhd3ns+3BxR8lhcjbO9EmhoPBirl
         kmu/giStRIVhRTKPOXL+WBPvuOrS7nO/QC/Ct6BAVEFv97YjcKNJ/RoyJrzin0oH7Ja7
         WWRUarXM5OfH6m9aJm8/QQWjsDrsbf/EGgm6CaNAbbRUBJlG4E7WoeRYIjqOWEE1VwdN
         OZ669X59emko2epjRArp/b7yxzYqJWwOE15kRI+J7eUPz0AStAo6kQPvWJBctBwm9/Ve
         /O2dXovNO3Ijd2Te1QkOrhb7c0mrdk/9KOVCRvLlFmR4Pkt665tjYFgXy5cVJeS6zDHF
         62Vg==
X-Gm-Message-State: APjAAAXT28jc5TBwTmU0HoVNbTxt9KyQEBcnwGFbi6qo+gvCzYs4bhDU
        buTe3H9trqCYH0SOQjpaO57oqA==
X-Google-Smtp-Source: APXvYqzsaGjamve7e+ufvEcnCPaUD5lFGwfiwdLCMRmGmU/OQUapuquuTDlM74GkdPYUKGdDnOKsEA==
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr3895866wru.318.1576685432128;
        Wed, 18 Dec 2019 08:10:32 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
        by smtp.gmail.com with ESMTPSA id 60sm3115391wrn.86.2019.12.18.08.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 08:10:31 -0800 (PST)
Date:   Wed, 18 Dec 2019 17:10:26 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: Re: [PATCH v3 10/13] iommu/arm-smmu-v3: Add second level of context
 descriptor table
Message-ID: <20191218161026.GH2371701@myrica>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
 <20191209180514.272727-11-jean-philippe@linaro.org>
 <26230082-03d2-5c01-389a-9e32dd281b57@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26230082-03d2-5c01-389a-9e32dd281b57@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 18, 2019 at 10:59:36AM +0100, Auger Eric wrote:
> >  struct arm_smmu_s1_cfg {
> > -	struct arm_smmu_cd_table	table;
> > +	struct arm_smmu_cd_table	*tables;
> > +	size_t				num_tables;
> > +	__le64				*l1ptr;
> you may add a comment saying that l1ptr and l1ptr_dma are only set/used
> in non linear case and one comment saying that "tables" represent leaf
> tables.

I now have
	/* Leaf tables or linear table */
and
	/* First level tables, when two level are used */
but I'm not entirely convinced it adds value

> > +	dma_addr_t			l1ptr_dma;
> >  	struct arm_smmu_ctx_desc	cd;
> >  	u8				s1fmt;
> >  	u8				s1cdmax;
> > @@ -1521,9 +1538,53 @@ static void arm_smmu_free_cd_leaf_table(struct arm_smmu_device *smmu,
> >  {
> >  	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
> >  
> > +	if (!table->ptr)
> > +		return;
> >  	dmam_free_coherent(smmu->dev, size, table->ptr, table->ptr_dma);
> >  }
> >  
> > +static void arm_smmu_write_cd_l1_desc(__le64 *dst,
> > +				      struct arm_smmu_cd_table *table)
> > +{
> > +	u64 val = (table->ptr_dma & CTXDESC_L1_DESC_L2PTR_MASK) |
> > +		  CTXDESC_L1_DESC_VALID;
> > +
> > +	WRITE_ONCE(*dst, cpu_to_le64(val));
> > +}
> > +
> > +static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
> > +				   u32 ssid)
> > +{
> > +	__le64 *l1ptr;
> > +	unsigned int idx;
> > +	struct arm_smmu_cd_table *table;
> > +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> > +	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
> > +
> > +	if (cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR) {
> > +		table = &cfg->tables[0];
> > +		idx = ssid;
> > +	} else {
> nit: you may avoid this extra indent by either returning above or go to
> a label.
> > +		idx = ssid >> CTXDESC_SPLIT;
> > +		if (idx >= cfg->num_tables)
> > +			return NULL;
> > +
> > +		table = &cfg->tables[idx];
> > +		if (!table->ptr) {
> > +			if (arm_smmu_alloc_cd_leaf_table(smmu, table,
> > +							 CTXDESC_L2_ENTRIES))
> > +				return NULL;
> > +
> > +			l1ptr = cfg->l1ptr + idx * CTXDESC_L1_DESC_DWORDS;
> > +			arm_smmu_write_cd_l1_desc(l1ptr, table);
> > +			/* An invalid L1CD can be cached */
> > +			arm_smmu_sync_cd(smmu_domain, ssid, false);
> > +		}
> > +		idx = ssid & (CTXDESC_L2_ENTRIES - 1);
> > +	}
> > +	return table->ptr + idx * CTXDESC_CD_DWORDS;> +}
> > +
> >  static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
> >  {
> >  	u64 val = 0;
> > @@ -1556,8 +1617,10 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
> >  	u64 val;
> >  	bool cd_live;
> >  	struct arm_smmu_device *smmu = smmu_domain->smmu;
> > -	__le64 *cdptr = smmu_domain->s1_cfg.table.ptr + ssid *
> > -			CTXDESC_CD_DWORDS;
> > +	__le64 *cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
> > +
> > +	if (!cdptr)
> > +		return -ENOMEM;
> -ENOMEM does not fit well with (idx >= cfg->num_tables) case
> Besides the idx is checked against the max table capacity only in non
> linear mode. Can't you check the ssid against cfg->s1cdmax earlier?

Ok, I'll move that check here

Thanks,
Jean
