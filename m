Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66EE1C08E6
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 23:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgD3VMP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 17:12:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:55366 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbgD3VMO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Apr 2020 17:12:14 -0400
IronPort-SDR: dfV4DXO6d/2nWIN4qfBqkpFgm3mt489hMfbAGL1WcE8PTrYKZOkSHYt1KRsHqBy4rVgD/hP635
 EaHemQfxkFVg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 14:12:13 -0700
IronPort-SDR: LVHsRMgJ7GdSWX064ocXY72QKgePGf1G+/dA+XVa/E+wyPTuvCryaG2DXe8fDKuW9WtKlwUhjb
 MeYme43Pk+/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,337,1583222400"; 
   d="scan'208";a="460080601"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga006.fm.intel.com with ESMTP; 30 Apr 2020 14:12:13 -0700
Date:   Thu, 30 Apr 2020 14:18:16 -0700
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
        jacob.jun.pan@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 00/25] iommu: Shared Virtual Addressing for SMMUv3
Message-ID: <20200430141816.595b758f@jacob-builder>
In-Reply-To: <20200430143424.2787566-1-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 30 Apr 2020 16:33:59 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> Shared Virtual Addressing (SVA) allows to share process page tables
> with devices using the IOMMU, PASIDs and I/O page faults. Add SVA
> support to the Arm SMMUv3 driver.
> 
> Since v5 [1]:
> 
> * Added patches 1-3. Patch 1 adds a PASID field to mm_struct as
>   discussed in [1] and [2]. This is also needed for Intel ENQCMD.
> Patch 2 adds refcounts to IOASID and patch 3 adds a couple of helpers
> to allocate the PASID.
> 
> * Dropped most of iommu-sva.c. After getting rid of io_mm following
>   review of v5, there wasn't enough generic code left to justify the
>   indirect branch overhead of io_mm_ops in the MMU notifiers. I ended
> up with more glue than useful code, and couldn't find an easy way to
> deal with domains in the SMMU driver (we keep PASID tables per domain,
>   while x86 keeps them per device). The direct approach in patch 17 is
>   nicer and a little easier to read. The SMMU driver only gained 160
>   lines, while iommu-sva lost 470 lines.
> 
>   As a result I dropped the MMU notifier patch.
> 
>   Jacob, one upside of this rework is that we now free ioasids in
>   blocking context, which might help with your addition of notifiers
> to ioasid.c
> 
Thanks for the note. It does make notifier much easier, plus the
refcount can alleviate the constraint on ordering.

I guess we don't share mmu notifier code for now :)

> * Simplified io-pgfault a bit, since flush() isn't called from mm exit
>   path anymore.
> 
> * Fixed a bug in patch 17 (don't clear the stall bit when stall is
>   forced).
> 
> You can find the latest version on https://jpbrucker.net/git/linux
> branch sva/current, and sva/zip-devel for the Hisilicon zip
> accelerator.
> 
> [1]
> https://lore.kernel.org/linux-iommu/20200414170252.714402-1-jean-philippe@linaro.org/
> [2]
> https://lore.kernel.org/linux-iommu/1585596788-193989-6-git-send-email-fenghua.yu@intel.com/
> 
> Jean-Philippe Brucker (25):
>   mm: Add a PASID field to mm_struct
>   iommu/ioasid: Add ioasid references
>   iommu/sva: Add PASID helpers
>   iommu: Add a page fault handler
>   iommu/iopf: Handle mm faults
>   arm64: mm: Add asid_gen_match() helper
>   arm64: mm: Pin down ASIDs for sharing mm with devices
>   iommu/io-pgtable-arm: Move some definitions to a header
>   iommu/arm-smmu-v3: Manage ASIDs with xarray
>   arm64: cpufeature: Export symbol read_sanitised_ftr_reg()
>   iommu/arm-smmu-v3: Share process page tables
>   iommu/arm-smmu-v3: Seize private ASID
>   iommu/arm-smmu-v3: Add support for VHE
>   iommu/arm-smmu-v3: Enable broadcast TLB maintenance
>   iommu/arm-smmu-v3: Add SVA feature checking
>   iommu/arm-smmu-v3: Add SVA device feature
>   iommu/arm-smmu-v3: Implement iommu_sva_bind/unbind()
>   iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
>   iommu/arm-smmu-v3: Add support for Hardware Translation Table Update
>   iommu/arm-smmu-v3: Maintain a SID->device structure
>   dt-bindings: document stall property for IOMMU masters
>   iommu/arm-smmu-v3: Add stall support for platform devices
>   PCI/ATS: Add PRI stubs
>   PCI/ATS: Export PRI functions
>   iommu/arm-smmu-v3: Add support for PRI
> 
>  drivers/iommu/Kconfig                         |   11 +
>  drivers/iommu/Makefile                        |    2 +
>  .../devicetree/bindings/iommu/iommu.txt       |   18 +
>  arch/arm64/include/asm/mmu.h                  |    1 +
>  arch/arm64/include/asm/mmu_context.h          |   11 +-
>  drivers/iommu/io-pgtable-arm.h                |   30 +
>  drivers/iommu/iommu-sva.h                     |   15 +
>  include/linux/ioasid.h                        |   10 +-
>  include/linux/iommu.h                         |   53 +
>  include/linux/mm_types.h                      |    4 +
>  include/linux/pci-ats.h                       |    8 +
>  arch/arm64/kernel/cpufeature.c                |    1 +
>  arch/arm64/mm/context.c                       |  103 +-
>  drivers/iommu/arm-smmu-v3.c                   | 1554
> +++++++++++++++-- drivers/iommu/io-pgfault.c                    |
> 458 +++++ drivers/iommu/io-pgtable-arm.c                |   27 +-
>  drivers/iommu/ioasid.c                        |   30 +-
>  drivers/iommu/iommu-sva.c                     |   85 +
>  drivers/iommu/of_iommu.c                      |    5 +-
>  drivers/pci/ats.c                             |    4 +
>  MAINTAINERS                                   |    3 +-
>  21 files changed, 2275 insertions(+), 158 deletions(-)
>  create mode 100644 drivers/iommu/io-pgtable-arm.h
>  create mode 100644 drivers/iommu/iommu-sva.h
>  create mode 100644 drivers/iommu/io-pgfault.c
>  create mode 100644 drivers/iommu/iommu-sva.c
> 

[Jacob Pan]
