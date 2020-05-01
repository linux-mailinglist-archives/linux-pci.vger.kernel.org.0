Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A8E1C11F1
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 14:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgEAMP7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 08:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728485AbgEAMP7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 May 2020 08:15:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6F7C061A0C;
        Fri,  1 May 2020 05:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zSa9108em557MfF5cmmgHqVRvKFdEUJbROm2shmlztY=; b=jOInxxVrnrDiy9mxQpINfGYznI
        oKnrkX0pjC/ar8W6dnfZ2AtZp1BFiHtfRitE8rL3exBB2y1h8KTRLPQ/uANDrAwHgBHA8vqicquEV
        6zVPrRtSFmHRH+SSwCmNKy2wNZ6di27mGN5iKlxCI9s2LGQYJVmAe/9qZyH59xKBOLQMrVeUEuvPT
        2hrIzIuWJHImLQ0MgAXy2JjNZUoJ7H1D/BGg2Bb1eYzGN1h0noSfBxWz217c+O6uM3ykbl9sZerlS
        aQB8pnoPhkrcPfBVhAzrhmobkwqvrkHDU74ar1mGSqtlWYVzy7fKglH3UsAIq7q22z/3fTMFrmIoH
        g9y75kYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUUa8-0005TY-RH; Fri, 01 May 2020 12:15:52 +0000
Date:   Fri, 1 May 2020 05:15:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, fenghua.yu@intel.com, kevin.tian@intel.com,
        jgg@ziepe.ca, catalin.marinas@arm.com, robin.murphy@arm.com,
        hch@infradead.org, zhangfei.gao@linaro.org, felix.kuehling@amd.com,
        will@kernel.org, christian.koenig@amd.com
Subject: Re: [PATCH v6 17/25] iommu/arm-smmu-v3: Implement
 iommu_sva_bind/unbind()
Message-ID: <20200501121552.GA6012@infradead.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-18-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430143424.2787566-18-jean-philippe@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> @@ -432,6 +432,7 @@ config ARM_SMMU_V3
>  	tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
>  	depends on ARM64
>  	select IOMMU_API
> +	select IOMMU_SVA
>  	select IOMMU_IO_PGTABLE_LPAE
>  	select GENERIC_MSI_IRQ_DOMAIN

Doesn't this need to select MMU_NOTIFIER now?

> +	struct mmu_notifier_ops		mn_ops;

Note: not a pointer.

> +	/* If bind() was already called for this (dev, mm) pair, reuse it. */
> +	list_for_each_entry(bond, &master->bonds, list) {
> +		if (bond->mm == mm) {
> +			refcount_inc(&bond->refs);
> +			return &bond->sva;
> +		}
> +	}
> +
> +	mn = mmu_notifier_get(&smmu_domain->mn_ops, mm);
> +	if (IS_ERR(mn))
> +		return ERR_CAST(mn);

Which seems to be to avoid mmu_notifier_get reusing notifiers registered
by other arm_smmu_master instance right?

Either you could just use plain old mmu_notifier_register to avoid
the reuse.  Or we could enhance the mmu_notifier_get to pass a private
oaque instance ID pointer, which is checked in addition to the ops,
and you could probably kill off the bonds list and lookup.

