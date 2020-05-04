Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02AC1C487C
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 22:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgEDUlT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 16:41:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:60857 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbgEDUlT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 May 2020 16:41:19 -0400
IronPort-SDR: QJc+W2ybiCeenEWRxEOYIiq75tUfrrIfuhnA9iM/SONlYd1h4hjTuLKWjtm+mn4adk+7Kpfzau
 DrnqlAJJr17A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 13:41:18 -0700
IronPort-SDR: b4DyWmhiDhy4qxtR8Pb8m1iBlCjvqLUinJbs4j14tT12w8H1CCchpLkLEJWAuUWDjBBLTawzxM
 Tb80S8PufxpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,353,1583222400"; 
   d="scan'208";a="338437724"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 04 May 2020 13:41:18 -0700
Date:   Mon, 4 May 2020 13:47:23 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        christian.koenig@amd.com, felix.kuehling@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        fenghua.yu@intel.com, hch@infradead.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v6 17/25] iommu/arm-smmu-v3: Implement
 iommu_sva_bind/unbind()
Message-ID: <20200504134723.54e2ebcd@jacob-builder>
In-Reply-To: <20200504164351.GJ170104@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
        <20200430143424.2787566-18-jean-philippe@linaro.org>
        <20200430141617.6ad4be4c@jacob-builder>
        <20200504164351.GJ170104@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 4 May 2020 18:43:51 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Thu, Apr 30, 2020 at 02:16:17PM -0700, Jacob Pan wrote:
> > > +static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
> > > +					 struct mm_struct *mm,
> > > +					 unsigned long start,
> > > unsigned long end) +{
> > > +	/* TODO: invalidate ATS */
> > > +}
> > > +
> > > +static void arm_smmu_mm_release(struct mmu_notifier *mn, struct
> > > mm_struct *mm) +{
> > > +	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
> > > +	struct arm_smmu_domain *smmu_domain;
> > > +
> > > +	mutex_lock(&arm_smmu_sva_lock);
> > > +	if (smmu_mn->cleared) {
> > > +		mutex_unlock(&arm_smmu_sva_lock);
> > > +		return;
> > > +	}
> > > +
> > > +	smmu_domain = smmu_mn->domain;
> > > +
> > > +	/*
> > > +	 * DMA may still be running. Keep the cd valid but
> > > disable
> > > +	 * translation, so that new events will still result in
> > > stall.
> > > +	 */  
> > Does "disable translation" also disable translated requests?  
> 
> No it doesn't disable translated requests, it only prevents the SMMU
> from accessing the pgd.
> 
OK. same as VT-d.

> > I guess
> > release is called after tlb invalidate range, so assuming no more
> > devTLB left to generate translated request?  
> 
> I'm counting on the invalidate below (here a TODO, implemented in next
> patch) to drop all devTLB entries. After that invalidate, the device:
> * issues a Translation Request, returns with R=W=0 because we disabled
>   translation (and it isn't present in the SMMU TLB).
> * issues a Page Request, returns with InvalidRequest because
>   mmget_not_zero() fails.
> 
Same flow. Thanks for the explanation.

> >   
> > > +	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid,
> > > &invalid_cd); +
> > > +	arm_smmu_tlb_inv_asid(smmu_domain->smmu,
> > > smmu_mn->cd->asid);
> > > +	/* TODO: invalidate ATS */
> > > +  
> > If mm release is called after tlb invalidate range, is it still
> > necessary to invalidate again?  
> 
> No, provided all mappings from the address space are unmapped and
> invalidated. I'll double check, but in my tests invalidate range
> didn't seem to be called for all mappings on mm exit, so I believe we
> do need this.
> 
I think it is safe to invalidate again. There was a concern that mm
release may delete IOMMU driver from the notification list and miss tlb
invalidate range. I had a hard time to confirm that with ftrace while
killing a process, many lost events.


> Thanks,
> Jean
> 

[Jacob Pan]
