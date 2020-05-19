Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F861D9E60
	for <lists+linux-pci@lfdr.de>; Tue, 19 May 2020 20:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgESSBn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 May 2020 14:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgESSBn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 14:01:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCD8C08C5C1
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:01:43 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l17so411438wrr.4
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bX55m437g7MeykE1US3Tftk0H5lzLx6XUpXZp2Kvxoc=;
        b=M9vyZZ9mATtJfZDUOxfdmdgx0RZHnvTGKbSm5F+JwH4itQZSpjYwKXYMCkR2huFvi2
         twh626xwy7oiPNTooN5mL8olWtFlkxdKNWun/7JJy52nt9PxCNGgU3iNKo7o3OgGBjBv
         GtcGwtOW+y4rz0r0Z0/zqBdnL/m4CdO70VTsExVbCbEatxP0xilLLUZJnBsBvKMv2tyJ
         vq/V4yM3GGmE/FtHGK5VR9w0BMSpmTebXfbAaoplg6/qbzV58lFR5DsR+sAVolk1TARd
         9BUbrrk/lyNFvpD6HXmUxfASJGR586E46CfIK9SG/6YNZ8RwjVHLC9QEQCyMTEN7B8Bf
         1ctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bX55m437g7MeykE1US3Tftk0H5lzLx6XUpXZp2Kvxoc=;
        b=ETscCaBwYZZyqjPHm/a8R7c8GFZ8rMPSB6u9tyoL47Scw0w3LDa6QxMzTULQU9/Hql
         fxFtKMn0KBi7MhsWQ4Ijmo88KXfMNRaqQ2lI+9v005dlJ/XX3ToB7ogVO6i/us+jcmax
         T5T1kCsfjM71s5houeMxt9oQDVkbnAZ4y2EPVK1wMn06lcQad18mLAz1j5bFmqUALLTe
         rHW3A0TcCfGzVUWh++kfYIyWYDJYovzLsxMYeBpxsqwVnfjpnYOqJ2o57KKjZSnUperA
         5XTz97pZzdliswRpoWCrIBgWC1D11nqzxwjx0g+cydqb8xBjXe4EQXVNZkZz1Y3YnHIc
         0JZA==
X-Gm-Message-State: AOAM5331cl+O9/MoR9HCvnpx+6V3M3oILBUV4D2jz0kbGjy16DWGRdWv
        cUWSroeNUMKc9J1DroRKrYQCUg==
X-Google-Smtp-Source: ABdhPJx1fsDPOtceAXONrGmaumNlQajybGcyP41uWlcXsFpwhVtjyrg3sPruM6jEsNsAR5hEmsZ2Cw==
X-Received: by 2002:adf:ec88:: with SMTP id z8mr125600wrn.44.1589911301763;
        Tue, 19 May 2020 11:01:41 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id 1sm510496wmz.13.2020.05.19.11.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:01:41 -0700 (PDT)
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
Subject: [PATCH v7 00/24] iommu: Shared Virtual Addressing for SMMUv3
Date:   Tue, 19 May 2020 19:54:38 +0200
Message-Id: <20200519175502.2504091-1-jean-philippe@linaro.org>
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

Since v6 [1]:
* Rename ioasid_free() to ioasid_put() in patch 02, requiring changes to
  the Intel drivers.
* Use mmu_notifier_register() in patch 16 to avoid copying the ops and
  simplify the invalidate() notifier in patch 17.
* As a result, replace context spinlock with a mutex. Simplified locking in
  patch 11 (That patch still looks awful, but I think the series is more
  readable overall). And I've finally been able to remove the GFP_ATOMIC
  allocations.
* Use a single patch (04) for io-pgfault.c, since the code was simplified
  in v6. Fixed partial list in patch 04.

[1] https://lore.kernel.org/linux-iommu/20200430143424.2787566-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (24):
  mm: Add a PASID field to mm_struct
  iommu/ioasid: Add ioasid references
  iommu/sva: Add PASID helpers
  iommu: Add a page fault handler
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

 drivers/iommu/Kconfig                         |   12 +
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
 drivers/iommu/arm-smmu-v3.c                   | 1552 +++++++++++++++--
 drivers/iommu/intel-iommu.c                   |    4 +-
 drivers/iommu/intel-svm.c                     |    6 +-
 drivers/iommu/io-pgfault.c                    |  459 +++++
 drivers/iommu/io-pgtable-arm.c                |   27 +-
 drivers/iommu/ioasid.c                        |   38 +-
 drivers/iommu/iommu-sva.c                     |   85 +
 drivers/iommu/of_iommu.c                      |    5 +-
 drivers/pci/ats.c                             |    4 +
 MAINTAINERS                                   |    3 +-
 23 files changed, 2286 insertions(+), 165 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm.h
 create mode 100644 drivers/iommu/iommu-sva.h
 create mode 100644 drivers/iommu/io-pgfault.c
 create mode 100644 drivers/iommu/iommu-sva.c

-- 
2.26.2

