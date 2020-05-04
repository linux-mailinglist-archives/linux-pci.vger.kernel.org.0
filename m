Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8801C4058
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 18:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgEDQoE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 12:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbgEDQoD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2020 12:44:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED4BC061A0F
        for <linux-pci@vger.kernel.org>; Mon,  4 May 2020 09:44:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so16670668wra.7
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2020 09:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nKcmHJjl9tIFKl3vh2WZWbQ1a6qf0OFNOmjvKAG+T5w=;
        b=GVujRTu9LfTtfSzWvR/blDgA6L4wRuxbhYL/JkbyHQuSK8LBG1AbIRX7hrdeiN0O7Z
         8Baza83dK07XMfbk20Q4GjHiYd4X4taXQr82nh40jV8dNTlKcvoKIZtYRHESbkJA0Mei
         m0JLe0wL6lKWe3B00KhI1No1bnfAYcK4FWXAj0PDFUuXEgS3N/NCSXdao12JT6mYvX7R
         wWA8cKGRE8zdnC3olLE8Amc6l6swWxcCLhl/UAEav9UYx2rkCZQF3jq3haIKHqp/B/Tc
         bv20hTPber8xWSwz5soOC6sjFXModYLMxNromwl4JxU9GswTWo613kfBFwjSkE/8acrI
         lxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nKcmHJjl9tIFKl3vh2WZWbQ1a6qf0OFNOmjvKAG+T5w=;
        b=FGUSa9QHxaEUODejHprldVLVLlXLKPBKG7VKe6k6BPMtC7XPuT0xycgF1IonamUpWz
         0Wsu+KDRAy+WDMCJMKm+npu8xiqN1FYPvRunk3BmEGcWqsGCH4on/VxAWb8mIwhiHFN4
         vBJJf/FYblqxelhO+wOnkFUkV+lqPCVHqFym6p2BlVEnXDmuM/TkcgyKxdbdCq6/6zKf
         OIs+ZNsqX8JuhcTlb3mW7htwkBNpt3xLGAj3S0nUTwEkQgIppxR70O4ax/4U1N/lM84Z
         1Wp2QSuWwQVwPQzGS8YA8Ntae8pVimAum0jEd61kRNXI2srFEfPgfaDhJGVEjWC6BpEE
         a0KA==
X-Gm-Message-State: AGi0PuZ8rrfR3S+C/lux8/Dw2Ex1rQr8vNJjIwubXbozZ3A6WkLkayc+
        tbPx+2KksjxJ0RJ9eaoON4HbVnThTCQ=
X-Google-Smtp-Source: APiQypIoWxNfvYjKhhuxv6cQDK75SO+JQ8441jozvjondQeZtyDNRGUJBpfXr2gHhMn+rcM5zZPzpw==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr12708701wrt.215.1588610642110;
        Mon, 04 May 2020 09:44:02 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id n12sm7101170wrj.95.2020.05.04.09.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 09:44:01 -0700 (PDT)
Date:   Mon, 4 May 2020 18:43:51 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        christian.koenig@amd.com, felix.kuehling@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        fenghua.yu@intel.com, hch@infradead.org
Subject: Re: [PATCH v6 17/25] iommu/arm-smmu-v3: Implement
 iommu_sva_bind/unbind()
Message-ID: <20200504164351.GJ170104@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-18-jean-philippe@linaro.org>
 <20200430141617.6ad4be4c@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430141617.6ad4be4c@jacob-builder>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 30, 2020 at 02:16:17PM -0700, Jacob Pan wrote:
> > +static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
> > +					 struct mm_struct *mm,
> > +					 unsigned long start,
> > unsigned long end) +{
> > +	/* TODO: invalidate ATS */
> > +}
> > +
> > +static void arm_smmu_mm_release(struct mmu_notifier *mn, struct
> > mm_struct *mm) +{
> > +	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
> > +	struct arm_smmu_domain *smmu_domain;
> > +
> > +	mutex_lock(&arm_smmu_sva_lock);
> > +	if (smmu_mn->cleared) {
> > +		mutex_unlock(&arm_smmu_sva_lock);
> > +		return;
> > +	}
> > +
> > +	smmu_domain = smmu_mn->domain;
> > +
> > +	/*
> > +	 * DMA may still be running. Keep the cd valid but disable
> > +	 * translation, so that new events will still result in
> > stall.
> > +	 */
> Does "disable translation" also disable translated requests?

No it doesn't disable translated requests, it only prevents the SMMU from
accessing the pgd.

> I guess
> release is called after tlb invalidate range, so assuming no more
> devTLB left to generate translated request?

I'm counting on the invalidate below (here a TODO, implemented in next
patch) to drop all devTLB entries. After that invalidate, the device:
* issues a Translation Request, returns with R=W=0 because we disabled
  translation (and it isn't present in the SMMU TLB).
* issues a Page Request, returns with InvalidRequest because
  mmget_not_zero() fails.

> 
> > +	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, &invalid_cd);
> > +
> > +	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
> > +	/* TODO: invalidate ATS */
> > +
> If mm release is called after tlb invalidate range, is it still
> necessary to invalidate again?

No, provided all mappings from the address space are unmapped and
invalidated. I'll double check, but in my tests invalidate range didn't
seem to be called for all mappings on mm exit, so I believe we do need
this.

Thanks,
Jean

