Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7781C51A8
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 11:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgEEJPo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 05:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgEEJPo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2020 05:15:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0C5C061A10
        for <linux-pci@vger.kernel.org>; Tue,  5 May 2020 02:15:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z8so888640wrw.3
        for <linux-pci@vger.kernel.org>; Tue, 05 May 2020 02:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sU7U3FhjLtetQ4yGftkHmkBqFM+M9ZWPk430QlcmjSw=;
        b=QXWA/MYxeBeYOjAoqaNN2WaAGPU0Tv3zhPwTqxa96+5wzt9CdxYYAAOCUz6pWhuzUl
         933MuJKNFPVD3w9C/QvD/C0e6iA+FZPTltexAp+raUdXk9hamFndUJbWV2K4iPOJiiz7
         mqMyTD/SmVD6T8yeuC7kKEIaQK7SAcsO3TOplzzSgBS/tPHNt0Is/ZMyXCEdT7r2D46z
         FIOLqY+T6XzzhHEgdFXwAFjHT0v74ZucOnNkxFTOaVA8+6OV7MLwC5bHsfh2sv+sT888
         szyzUg2wNsB84mYvmwLGhiEl0EZfJEPVQVC4y7fppcLdtB5gerYO6mRdLiS7XmYwmwZ0
         XEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sU7U3FhjLtetQ4yGftkHmkBqFM+M9ZWPk430QlcmjSw=;
        b=lQfwOKg/d9xoSyDlu30TBqPDJ0iX7iG9wOy1oSU3Z0a7AU9kWYQnu+ypg0buDjStpf
         ARN5M8LEhb4eYqGMJcI3YPZs/0u1XisRstNE3bzPv1bofKrEi4KDWL9mhEm0CZCVaB4a
         hJWG78WhZotVRaEv9u/CQ9i3j1dmkqHsByDS5n8x0x+Ixloe3zdmQUbCLv4Hb+WGgqju
         Jh2Qd1fNFrcRd6fho9nIK2N/xUl48F5SdmviAgPHBy/1VhjodELCBaVrBP2jzXzRUz5h
         VlnnkS7pcLmySgSDlZGUYhqDqkcyfcAawTOlknScRveH3FX98xPZliTiWH0P5ajb504D
         yJLg==
X-Gm-Message-State: AGi0PubyPiNJQ5U/nwv0cdg7yE/dVLdZj5koqhKe6w6SKRWFDso4FhOy
        S91eG6H7YvDBSQEpB3qWHWjF6Q==
X-Google-Smtp-Source: APiQypLUdwS9EMNq1wqY/xPjJM+u52dIVylq937W1BwIZPG2UftDefGXQhpqhk5pltip4j2URFGphQ==
X-Received: by 2002:a5d:4652:: with SMTP id j18mr2063792wrs.19.1588670141301;
        Tue, 05 May 2020 02:15:41 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id c190sm2856893wme.4.2020.05.05.02.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 02:15:40 -0700 (PDT)
Date:   Tue, 5 May 2020 11:15:31 +0200
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
Message-ID: <20200505091531.GA203922@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-18-jean-philippe@linaro.org>
 <20200430141617.6ad4be4c@jacob-builder>
 <20200504164351.GJ170104@myrica>
 <20200504134723.54e2ebcd@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504134723.54e2ebcd@jacob-builder>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 04, 2020 at 01:47:23PM -0700, Jacob Pan wrote:
> > > > +	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid,
> > > > &invalid_cd); +
> > > > +	arm_smmu_tlb_inv_asid(smmu_domain->smmu,
> > > > smmu_mn->cd->asid);
> > > > +	/* TODO: invalidate ATS */
> > > > +  
> > > If mm release is called after tlb invalidate range, is it still
> > > necessary to invalidate again?  
> > 
> > No, provided all mappings from the address space are unmapped and
> > invalidated. I'll double check, but in my tests invalidate range
> > didn't seem to be called for all mappings on mm exit, so I believe we
> > do need this.
> > 
> I think it is safe to invalidate again. There was a concern that mm
> release may delete IOMMU driver from the notification list and miss tlb
> invalidate range. I had a hard time to confirm that with ftrace while
> killing a process, many lost events.
> 

If it helps, I have a test that generates small DMA transactions on a SMMU
model. This is the trace for a job on a 8kB mmap'd buffer:

  smmu_bind_alloc: dev=0000:00:03.0 pasid=1
  dev_fault: IOMMU:0000:00:03.0 type=2 reason=0 addr=0x0000ffff860e6000 pasid=1 group=74 flags=3 prot=2
  dev_page_response: IOMMU:0000:00:03.0 code=0 pasid=1 group=74
  dev_fault: IOMMU:0000:00:03.0 type=2 reason=0 addr=0x0000ffff860e7000 pasid=1 group=143 flags=3 prot=2
  dev_page_response: IOMMU:0000:00:03.0 code=0 pasid=1 group=143
  smmu_mm_invalidate: pasid=1 start=0xffff860e6000 end=0xffff860e8000
  smmu_mm_invalidate: pasid=1 start=0xffff860e6000 end=0xffff860e8000
  smmu_mm_invalidate: pasid=1 start=0xffff860e8000 end=0xffff860ea000
  smmu_mm_invalidate: pasid=1 start=0xffff860e8000 end=0xffff860ea000
  smmu_unbind_free: dev=0000:00:03.0 pasid=1

And this is the same job, but the process immediately kills itself after
launching it.

  smmu_bind_alloc: dev=0000:00:03.0 pasid=1
  dev_fault: IOMMU:0000:00:03.0 type=2 reason=0 addr=0x0000ffffb9d15000 pasid=1 group=259 flags=3 prot=2
  smmu_mm_release: pasid=1
  dev_page_response: IOMMU:0000:00:03.0 code=0 pasid=1 group=259
  dev_fault: IOMMU:0000:00:03.0 type=2 reason=0 addr=0x0000ffffb9d15000 pasid=1 group=383 flags=3 prot=2
  dev_page_response: IOMMU:0000:00:03.0 code=1 pasid=1 group=383
  smmu_unbind_free: dev=0000:00:03.0 pasid=1

We don't get any invalidate_range notification in this case.

Thanks,
Jean
