Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81BB1C966B
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 18:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgEGQZp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 12:25:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:21311 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgEGQZp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 May 2020 12:25:45 -0400
IronPort-SDR: dx3xesLci+fKG1o5vNeaJDaI7mzsELKq/xcLU16yRnXtFQsCozExJxOuBCMmtUdnBMG/5NmP6w
 SbUgNO+Q9pzg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 09:25:44 -0700
IronPort-SDR: UI2DdPDFZfRj74OALBpuW41w58LXZwgsjf3LGqDj+vALiCsEHXQU/Sa9YbL1TRdZwaxVQulhgj
 S1oqukCmHM3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,364,1583222400"; 
   d="scan'208";a="278651044"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 07 May 2020 09:25:43 -0700
Date:   Thu, 7 May 2020 09:31:50 -0700
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
Message-ID: <20200507093150.6da9d6fb@jacob-builder>
In-Reply-To: <20200505091531.GA203922@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
        <20200430143424.2787566-18-jean-philippe@linaro.org>
        <20200430141617.6ad4be4c@jacob-builder>
        <20200504164351.GJ170104@myrica>
        <20200504134723.54e2ebcd@jacob-builder>
        <20200505091531.GA203922@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 5 May 2020 11:15:31 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Mon, May 04, 2020 at 01:47:23PM -0700, Jacob Pan wrote:
> > > > > +	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid,
> > > > > &invalid_cd); +
> > > > > +	arm_smmu_tlb_inv_asid(smmu_domain->smmu,
> > > > > smmu_mn->cd->asid);
> > > > > +	/* TODO: invalidate ATS */
> > > > > +    
> > > > If mm release is called after tlb invalidate range, is it still
> > > > necessary to invalidate again?    
> > > 
> > > No, provided all mappings from the address space are unmapped and
> > > invalidated. I'll double check, but in my tests invalidate range
> > > didn't seem to be called for all mappings on mm exit, so I
> > > believe we do need this.
> > >   
> > I think it is safe to invalidate again. There was a concern that mm
> > release may delete IOMMU driver from the notification list and miss
> > tlb invalidate range. I had a hard time to confirm that with ftrace
> > while killing a process, many lost events.
> >   
> 
> If it helps, I have a test that generates small DMA transactions on a
> SMMU model. This is the trace for a job on a 8kB mmap'd buffer:
> 
>   smmu_bind_alloc: dev=0000:00:03.0 pasid=1
>   dev_fault: IOMMU:0000:00:03.0 type=2 reason=0
> addr=0x0000ffff860e6000 pasid=1 group=74 flags=3 prot=2
> dev_page_response: IOMMU:0000:00:03.0 code=0 pasid=1 group=74
> dev_fault: IOMMU:0000:00:03.0 type=2 reason=0 addr=0x0000ffff860e7000
> pasid=1 group=143 flags=3 prot=2 dev_page_response:
> IOMMU:0000:00:03.0 code=0 pasid=1 group=143 smmu_mm_invalidate:
> pasid=1 start=0xffff860e6000 end=0xffff860e8000 smmu_mm_invalidate:
> pasid=1 start=0xffff860e6000 end=0xffff860e8000 smmu_mm_invalidate:
> pasid=1 start=0xffff860e8000 end=0xffff860ea000 smmu_mm_invalidate:
> pasid=1 start=0xffff860e8000 end=0xffff860ea000 smmu_unbind_free:
> dev=0000:00:03.0 pasid=1
> 
> And this is the same job, but the process immediately kills itself
> after launching it.
> 
>   smmu_bind_alloc: dev=0000:00:03.0 pasid=1
>   dev_fault: IOMMU:0000:00:03.0 type=2 reason=0
> addr=0x0000ffffb9d15000 pasid=1 group=259 flags=3 prot=2
> smmu_mm_release: pasid=1 dev_page_response: IOMMU:0000:00:03.0 code=0
> pasid=1 group=259 dev_fault: IOMMU:0000:00:03.0 type=2 reason=0
> addr=0x0000ffffb9d15000 pasid=1 group=383 flags=3 prot=2
> dev_page_response: IOMMU:0000:00:03.0 code=1 pasid=1 group=383
> smmu_unbind_free: dev=0000:00:03.0 pasid=1
> 
> We don't get any invalidate_range notification in this case.
> 
Thanks for the confirmation. We do need to invalidate here.

> Thanks,
> Jean

[Jacob Pan]
