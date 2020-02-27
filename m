Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC13F1726F7
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2020 19:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgB0SWK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Feb 2020 13:22:10 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2475 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729142AbgB0SWJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Feb 2020 13:22:09 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 99F00611DC9F15BD25C9;
        Thu, 27 Feb 2020 18:22:08 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 27 Feb 2020 18:22:07 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 27 Feb
 2020 18:22:07 +0000
Date:   Thu, 27 Feb 2020 18:22:06 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-mm@kvack.org>,
        <mark.rutland@arm.com>, <kevin.tian@intel.com>,
        <jacob.jun.pan@linux.intel.com>, <catalin.marinas@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>, <robh+dt@kernel.org>,
        <yi.l.liu@intel.com>, <zhangfei.gao@linaro.org>, <will@kernel.org>,
        <christian.koenig@amd.com>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 00/26] iommu: Shared Virtual Addressing and SMMUv3
 support
Message-ID: <20200227182206.000075aa@Huawei.com>
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 24 Feb 2020 19:23:35 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> Shared Virtual Addressing (SVA) allows to share process page tables with
> devices using the IOMMU. Add a generic implementation of the IOMMU SVA
> API, and add support in the Arm SMMUv3 driver.
> 
> Previous versions of this patchset were sent over a year ago [1][2] but
> we've made a lot of progress since then:
> 
> * ATS support for SMMUv3 was merged in v5.2.
> * The bind() and fault reporting APIs have been merged in v5.3.
> * IOASID were added in v5.5.
> * SMMUv3 PASID was added in v5.6, with some pending for v5.7.
> 
> * The first user of the bind() API will be merged in v5.7 [3]. The zip
>   accelerator is also the first piece of hardware that I've been able to
>   use for testing (previous versions were developed with software models)
>   and I now have tools for evaluating SVA performance. Unfortunately I
>   still don't have hardware that supports ATS and PRI; the zip accelerator
>   uses stall.
> 
> These are the remaining changes for SVA support in SMMUv3. Since v3 [1]
> I fixed countless bugs and - I think - addressed everyone's comments.
> Thanks to recent MMU notifier rework, iommu-sva.c is a lot more
> straightforward. I'm still unhappy with the complicated locking in the
> SMMUv3 driver resulting from patch 12 (Seize private ASID), but I
> haven't found anything better.
> 
> Please find all SVA patches on branches sva/current and sva/zip-devel at
> https://jpbrucker.net/git/linux
> 
> [1] https://lore.kernel.org/linux-iommu/20180920170046.20154-1-jean-philippe.brucker@arm.com/
> [2] https://lore.kernel.org/linux-iommu/20180511190641.23008-1-jean-philippe.brucker@arm.com/
> [3] https://lore.kernel.org/linux-iommu/1581407665-13504-1-git-send-email-zhangfei.gao@linaro.org/

Hi Jean-Phillippe.

Great to see this progressing.  Other than the few places I've commented
it all looks good to me.

Thanks,

Jonathan

> 
> Jean-Philippe Brucker (26):
>   mm/mmu_notifiers: pass private data down to alloc_notifier()
>   iommu/sva: Manage process address spaces
>   iommu: Add a page fault handler
>   iommu/sva: Search mm by PASID
>   iommu/iopf: Handle mm faults
>   iommu/sva: Register page fault handler
>   arm64: mm: Pin down ASIDs for sharing mm with devices
>   iommu/io-pgtable-arm: Move some definitions to a header
>   iommu/arm-smmu-v3: Manage ASIDs with xarray
>   arm64: cpufeature: Export symbol read_sanitised_ftr_reg()
>   iommu/arm-smmu-v3: Share process page tables
>   iommu/arm-smmu-v3: Seize private ASID
>   iommu/arm-smmu-v3: Add support for VHE
>   iommu/arm-smmu-v3: Enable broadcast TLB maintenance
>   iommu/arm-smmu-v3: Add SVA feature checking
>   iommu/arm-smmu-v3: Add dev_to_master() helper
>   iommu/arm-smmu-v3: Implement mm operations
>   iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
>   iommu/arm-smmu-v3: Add support for Hardware Translation Table Update
>   iommu/arm-smmu-v3: Maintain a SID->device structure
>   iommu/arm-smmu-v3: Ratelimit event dump
>   dt-bindings: document stall property for IOMMU masters
>   iommu/arm-smmu-v3: Add stall support for platform devices
>   PCI/ATS: Add PRI stubs
>   PCI/ATS: Export symbols of PRI functions
>   iommu/arm-smmu-v3: Add support for PRI
> 
>  .../devicetree/bindings/iommu/iommu.txt       |   18 +
>  arch/arm64/include/asm/mmu.h                  |    1 +
>  arch/arm64/include/asm/mmu_context.h          |   11 +-
>  arch/arm64/kernel/cpufeature.c                |    1 +
>  arch/arm64/mm/context.c                       |  103 +-
>  drivers/iommu/Kconfig                         |   13 +
>  drivers/iommu/Makefile                        |    2 +
>  drivers/iommu/arm-smmu-v3.c                   | 1354 +++++++++++++++--
>  drivers/iommu/io-pgfault.c                    |  533 +++++++
>  drivers/iommu/io-pgtable-arm.c                |   27 +-
>  drivers/iommu/io-pgtable-arm.h                |   30 +
>  drivers/iommu/iommu-sva.c                     |  596 ++++++++
>  drivers/iommu/iommu-sva.h                     |   64 +
>  drivers/iommu/iommu.c                         |    1 +
>  drivers/iommu/of_iommu.c                      |    5 +-
>  drivers/misc/sgi-gru/grutlbpurge.c            |    4 +-
>  drivers/pci/ats.c                             |    4 +
>  include/linux/iommu.h                         |   73 +
>  include/linux/mmu_notifier.h                  |   10 +-
>  include/linux/pci-ats.h                       |    8 +
>  mm/mmu_notifier.c                             |    6 +-
>  21 files changed, 2699 insertions(+), 165 deletions(-)
>  create mode 100644 drivers/iommu/io-pgfault.c
>  create mode 100644 drivers/iommu/io-pgtable-arm.h
>  create mode 100644 drivers/iommu/iommu-sva.c
>  create mode 100644 drivers/iommu/iommu-sva.h
> 


