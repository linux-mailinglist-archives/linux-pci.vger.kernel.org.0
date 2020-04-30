Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF061BFE8B
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 16:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgD3OkR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 10:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727773AbgD3OkR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 10:40:17 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1436C035494
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:16 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v8so7648576wma.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YYiLFVngM44g0Fy16RMemZHwiB7tGW2h6urXa5JNeA4=;
        b=ZUmjnGJdMThCLpgu6Fn1QVEDSUT+cukEkGuOgFSAHraBV5UE619qvE7lxXPXau+0K9
         ZSHcJOrhjdN8cdq50v47XtlJcbrqef2j4U5/gGNSYSQpruy3HxooSXHs6zM0a7FPLyrf
         N1aYxP7FmR+YZG+U5qEkc7Ou5kN0muT/Fyj74HePtg+qHnxZ/OCxIli3Yg9YjITjQFh/
         9H6GKkTWgkWazMIGgQe+XWGtK1TcSG6alWleOABobFRAn+J2t7Zmt/cdYdpkh/pEJmMD
         jBY9RCioflr2sxajJ38Um+7P1crKRDbyOCc3eBs00MuEh0TbHUtzAb/LNYTvyI9xBJZf
         9UNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YYiLFVngM44g0Fy16RMemZHwiB7tGW2h6urXa5JNeA4=;
        b=smeAj04ouqAjlOAxbIlBIc4XMjqL7Jkuj0hvqSSLUisMSztPXdeKo5VuKzdr2zFAop
         nge9A6MFZ/751SS58iI9p2r6EDqZndOk7m07/ZP8weYTf/1tpOBHZEsurSTki3HvyDyq
         nvSOMPNSPzggT5LVT7f5lO7pXEl8CTyKzXtBeosG9iG6UGMCHIBwRj/2i1OCyZ/8grSt
         o9bARQQscXfkPjIN5bqewzYLQqI5VzVgYQl7L0EVlqMz3hKYn9qo4T0XKxacuZOwgcAy
         8KgSvfkpnQco3SSWzxYo7jwwB6HZzDdmjmlDkot6tPuqnOTT1GaZnVK1yOmo6bM9VvJi
         Nysg==
X-Gm-Message-State: AGi0PuYOfIy46ZaJwm/E4bDapdqNvcmgKVy+2vyF/VmSeiDiN/y+zlFH
        VNasaAOpFnuKqY6k09RpOxhlZA==
X-Google-Smtp-Source: APiQypIMxbfi2gR+oRZoSzUml7oOF8uYXg/WO7r1FPuma7Uj6M8X8kh92jUG0IVhIXNkP7USztJjJQ==
X-Received: by 2002:a7b:cfc9:: with SMTP id f9mr3419281wmm.61.1588257614425;
        Thu, 30 Apr 2020 07:40:14 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:40:12 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v6 00/25] iommu: Shared Virtual Addressing for SMMUv3
Date:   Thu, 30 Apr 2020 16:33:59 +0200
Message-Id: <20200430143424.2787566-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Shared Virtual Addressing (SVA) allows to share process page tables with
devices using the IOMMU, PASIDs and I/O page faults. Add SVA support to
the Arm SMMUv3 driver.

Since v5 [1]:

* Added patches 1-3. Patch 1 adds a PASID field to mm_struct as
  discussed in [1] and [2]. This is also needed for Intel ENQCMD. Patch
  2 adds refcounts to IOASID and patch 3 adds a couple of helpers to
  allocate the PASID.

* Dropped most of iommu-sva.c. After getting rid of io_mm following
  review of v5, there wasn't enough generic code left to justify the
  indirect branch overhead of io_mm_ops in the MMU notifiers. I ended up
  with more glue than useful code, and couldn't find an easy way to deal
  with domains in the SMMU driver (we keep PASID tables per domain,
  while x86 keeps them per device). The direct approach in patch 17 is
  nicer and a little easier to read. The SMMU driver only gained 160
  lines, while iommu-sva lost 470 lines.

  As a result I dropped the MMU notifier patch.

  Jacob, one upside of this rework is that we now free ioasids in
  blocking context, which might help with your addition of notifiers to
  ioasid.c

* Simplified io-pgfault a bit, since flush() isn't called from mm exit
  path anymore.

* Fixed a bug in patch 17 (don't clear the stall bit when stall is
  forced).

You can find the latest version on https://jpbrucker.net/git/linux
branch sva/current, and sva/zip-devel for the Hisilicon zip accelerator.

[1] https://lore.kernel.org/linux-iommu/20200414170252.714402-1-jean-philippe@linaro.org/
[2] https://lore.kernel.org/linux-iommu/1585596788-193989-6-git-send-email-fenghua.yu@intel.com/

Jean-Philippe Brucker (25):
  mm: Add a PASID field to mm_struct
  iommu/ioasid: Add ioasid references
  iommu/sva: Add PASID helpers
  iommu: Add a page fault handler
  iommu/iopf: Handle mm faults
  arm64: mm: Add asid_gen_match() helper
  arm64: mm: Pin down ASIDs for sharing mm with devices
  iommu/io-pgtable-arm: Move some definitions to a header
  iommu/arm-smmu-v3: Manage ASIDs with xarray
  arm64: cpufeature: Export symbol read_sanitised_ftr_reg()
  iommu/arm-smmu-v3: Share process page tables
  iommu/arm-smmu-v3: Seize private ASID
  iommu/arm-smmu-v3: Add support for VHE
  iommu/arm-smmu-v3: Enable broadcast TLB maintenance
  iommu/arm-smmu-v3: Add SVA feature checking
  iommu/arm-smmu-v3: Add SVA device feature
  iommu/arm-smmu-v3: Implement iommu_sva_bind/unbind()
  iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
  iommu/arm-smmu-v3: Add support for Hardware Translation Table Update
  iommu/arm-smmu-v3: Maintain a SID->device structure
  dt-bindings: document stall property for IOMMU masters
  iommu/arm-smmu-v3: Add stall support for platform devices
  PCI/ATS: Add PRI stubs
  PCI/ATS: Export PRI functions
  iommu/arm-smmu-v3: Add support for PRI

 drivers/iommu/Kconfig                         |   11 +
 drivers/iommu/Makefile                        |    2 +
 .../devicetree/bindings/iommu/iommu.txt       |   18 +
 arch/arm64/include/asm/mmu.h                  |    1 +
 arch/arm64/include/asm/mmu_context.h          |   11 +-
 drivers/iommu/io-pgtable-arm.h                |   30 +
 drivers/iommu/iommu-sva.h                     |   15 +
 include/linux/ioasid.h                        |   10 +-
 include/linux/iommu.h                         |   53 +
 include/linux/mm_types.h                      |    4 +
 include/linux/pci-ats.h                       |    8 +
 arch/arm64/kernel/cpufeature.c                |    1 +
 arch/arm64/mm/context.c                       |  103 +-
 drivers/iommu/arm-smmu-v3.c                   | 1554 +++++++++++++++--
 drivers/iommu/io-pgfault.c                    |  458 +++++
 drivers/iommu/io-pgtable-arm.c                |   27 +-
 drivers/iommu/ioasid.c                        |   30 +-
 drivers/iommu/iommu-sva.c                     |   85 +
 drivers/iommu/of_iommu.c                      |    5 +-
 drivers/pci/ats.c                             |    4 +
 MAINTAINERS                                   |    3 +-
 21 files changed, 2275 insertions(+), 158 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm.h
 create mode 100644 drivers/iommu/iommu-sva.h
 create mode 100644 drivers/iommu/io-pgfault.c
 create mode 100644 drivers/iommu/iommu-sva.c

-- 
2.26.2

