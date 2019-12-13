Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E618311E8F4
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 18:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfLMRKK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 12:10:10 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2191 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728012AbfLMRKJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Dec 2019 12:10:09 -0500
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id AAD5AC95724CE7AC0041;
        Fri, 13 Dec 2019 17:10:08 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 13 Dec 2019 17:10:07 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 13 Dec
 2019 17:10:08 +0000
Date:   Fri, 13 Dec 2019 17:10:06 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, <lenb@kernel.org>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <joro@8bytes.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lorenzo.pieralisi@arm.com>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>, <rjw@rjwysocki.net>, <will@kernel.org>,
        <robin.murphy@arm.com>, <bhelgaas@google.com>,
        <eric.auger@redhat.com>, <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v3 00/13] iommu: Add PASID support to Arm SMMUv3
Message-ID: <20191213171006.00003e99@Huawei.com>
In-Reply-To: <20191209180514.272727-1-jean-philippe@linaro.org>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
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

On Mon, 9 Dec 2019 19:05:01 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> Add support for Substream ID and PASIDs to the SMMUv3 driver.
> Changes since v2 [1]:
> 
> * Split preparatory work into patches 5, 6, 8 and 9.
> 
> * Added patch 1. Not strictly relevant, but since we're moving the DMA
>   allocations and adding a new one, we might as well clean the flags
>   first.
> 
> * Fixed a double free reported by Jonathan, and other small
>   issues.
> 
> * Added patch 12. Upstream commit c6e9aefbf9db ("PCI/ATS: Remove unused
>   PRI and PASID stubs") removed the unused PASID stubs. Since the SMMU
>   driver can be built without PCI, the stubs are now needed.
> 
> [1] https://lore.kernel.org/linux-iommu/20191108152508.4039168-1-jean-philippe@linaro.org/

Hi Jean-Philippe,

Series looks great to me.  FWIW

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
for the patches I didn't comment on in this version as I couldn't find anything
to comment about ;)

Thanks

Jonathan

> 
> Jean-Philippe Brucker (13):
>   iommu/arm-smmu-v3: Drop __GFP_ZERO flag from DMA allocation
>   dt-bindings: document PASID property for IOMMU masters
>   iommu/arm-smmu-v3: Support platform SSID
>   ACPI/IORT: Support PASID for platform devices
>   iommu/arm-smmu-v3: Prepare arm_smmu_s1_cfg for SSID support
>   iommu/arm-smmu-v3: Add context descriptor tables allocators
>   iommu/arm-smmu-v3: Add support for Substream IDs
>   iommu/arm-smmu-v3: Propate ssid_bits
>   iommu/arm-smmu-v3: Handle failure of arm_smmu_write_ctx_desc()
>   iommu/arm-smmu-v3: Add second level of context descriptor table
>   iommu/arm-smmu-v3: Improve add_device() error handling
>   PCI/ATS: Add PASID stubs
>   iommu/arm-smmu-v3: Add support for PCI PASID
> 
>  .../devicetree/bindings/iommu/iommu.txt       |   6 +
>  drivers/acpi/arm64/iort.c                     |  18 +
>  drivers/iommu/arm-smmu-v3.c                   | 462 +++++++++++++++---
>  drivers/iommu/of_iommu.c                      |   6 +-
>  include/linux/iommu.h                         |   2 +
>  include/linux/pci-ats.h                       |   3 +
>  6 files changed, 437 insertions(+), 60 deletions(-)
> 


