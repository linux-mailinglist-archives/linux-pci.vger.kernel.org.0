Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9CBEA39E4
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2019 17:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfH3PIA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Aug 2019 11:08:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36667 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfH3PIA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Aug 2019 11:08:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so7339795wrd.3;
        Fri, 30 Aug 2019 08:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0pAZWJp00xZ1ls1Af08EI7mW5qet6OlsQR65F0SwZhs=;
        b=Uhod1U8XJp5hvgo/TUndU/vB/K3LqXxuAeZVAeuRIVdGOfTHzNRkOwN4osOc40UuE5
         1zbifQ3t/DupGF//0a//lbZHwzoTo6QVboCPsr+tvklkQoTjH1/FYdaux2SjAfGCOpZ0
         aaXT7pAXocMPWV0Xg9GtrbNyGi3SmspC4gJtWpFECD2jINQg8+kDPQEGXlrAPljAZ6MO
         Bdigb/DGLDuPQjYHP6+nOeEcj4fW4+9AgzYdVUBteNpxJsrnLzwx/E63kRUe2CI/0SzE
         heoO2mGCnXSSOoKS6wS0YDpnRrp6s8F65jBfDu0Q/tvSU+1uM06S/GMYkDzLMDPtR3BH
         HskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=0pAZWJp00xZ1ls1Af08EI7mW5qet6OlsQR65F0SwZhs=;
        b=UYlWaW3SuGuQnLo4RremvGaalLQqKpoEkTaMWEUMHm8u8fxBzZ3IcceFGgOqGcZB38
         UzIAYAVu3IiwivO9/1OioBIekor7pBjiA3G3z+0rpB8m3T0pw+sifsy5sZs6dUj9aiKe
         1KwA7RdSy6p5YbjRF8RKSncewpek9mvio5S/Jv4uhdi6jbLjtp+iitQFXo7ogxZbj/pC
         D+1TvWSg/5D0nWoaysL3yCN95ijhu30ykdAtdNLCpUHPFkMxkVNTj/x+d/yqICaeFvab
         UdjH3cW1tOzp6kEyrVG+tpt5LejFwphY0uHjkKpz8k/ucK5wsIqX4TE6gBFMfeKRGcyd
         +zSA==
X-Gm-Message-State: APjAAAURWYraYtg13je1SP0TBg//LVXi1UHuV2IbrdszThxWsQ9NLBUy
        CNPC7Q0u9wgODFARSLNz9Rc=
X-Google-Smtp-Source: APXvYqzHQGc0Wx4HRiZiz1ofDsxcHrSk8e6DnIqmyFNiH0txU8A57/I3wSP5Sr5aEeWTtm785SC13w==
X-Received: by 2002:adf:f507:: with SMTP id q7mr19297657wro.210.1567177678081;
        Fri, 30 Aug 2019 08:07:58 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id 16sm8270956wmx.45.2019.08.30.08.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 08:07:57 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: Move ATS declarations to linux/pci.h
Date:   Fri, 30 Aug 2019 17:07:56 +0200
Message-Id: <20190830150756.21305-1-kw@linux.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move ATS function prototypes from include/linux/pci-ats.h to
include/linux/pci.h so users only need to include <linux/pci.h>:

Realted to PRI capability:

  pci_enable_pri()
  pci_disable_pri()
  pci_restore_pri_state()
  pci_reset_pri()

Related to PASID capability:

  pci_enable_pasid()
  pci_disable_pasid()
  pci_restore_pasid_state()
  pci_pasid_features()
  pci_max_pasids()
  pci_prg_resp_pasid_required()

No functional changes intended.

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 drivers/iommu/amd_iommu.c   |  1 -
 drivers/iommu/arm-smmu-v3.c |  1 -
 drivers/iommu/intel-iommu.c |  1 -
 drivers/iommu/intel-pasid.c |  1 -
 drivers/iommu/intel-svm.c   |  1 -
 drivers/pci/ats.c           |  1 -
 drivers/pci/pci.c           |  1 -
 include/linux/pci-ats.h     | 77 -------------------------------------
 include/linux/pci.h         | 34 ++++++++++++++++
 9 files changed, 34 insertions(+), 84 deletions(-)
 delete mode 100644 include/linux/pci-ats.h

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 04a9f8443344..d43913386915 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -13,7 +13,6 @@
 #include <linux/acpi.h>
 #include <linux/amba/bus.h>
 #include <linux/platform_device.h>
-#include <linux/pci-ats.h>
 #include <linux/bitmap.h>
 #include <linux/slab.h>
 #include <linux/debugfs.h>
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 0ad6d34d1e96..3bd9455efc39 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -29,7 +29,6 @@
 #include <linux/of_iommu.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
-#include <linux/pci-ats.h>
 #include <linux/platform_device.h>
 
 #include <linux/amba/bus.h>
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 4658cda6f3d2..362845b5c88a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -35,7 +35,6 @@
 #include <linux/syscore_ops.h>
 #include <linux/tboot.h>
 #include <linux/dmi.h>
-#include <linux/pci-ats.h>
 #include <linux/memblock.h>
 #include <linux/dma-contiguous.h>
 #include <linux/dma-direct.h>
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 040a445be300..f670315afa67 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -16,7 +16,6 @@
 #include <linux/iommu.h>
 #include <linux/memory.h>
 #include <linux/pci.h>
-#include <linux/pci-ats.h>
 #include <linux/spinlock.h>
 
 #include "intel-pasid.h"
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 780de0caafe8..ee9dfc84f925 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -13,7 +13,6 @@
 #include <linux/intel-svm.h>
 #include <linux/rculist.h>
 #include <linux/pci.h>
-#include <linux/pci-ats.h>
 #include <linux/dmar.h>
 #include <linux/interrupt.h>
 #include <linux/mm_types.h>
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index e18499243f84..3f5fb2d4a763 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/export.h>
-#include <linux/pci-ats.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f20a3de57d21..c8f2a05e6b37 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -29,7 +29,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/pci_hotplug.h>
 #include <linux/vmalloc.h>
-#include <linux/pci-ats.h>
 #include <asm/setup.h>
 #include <asm/dma.h>
 #include <linux/aer.h>
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
deleted file mode 100644
index 1ebb88e7c184..000000000000
--- a/include/linux/pci-ats.h
+++ /dev/null
@@ -1,77 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef LINUX_PCI_ATS_H
-#define LINUX_PCI_ATS_H
-
-#include <linux/pci.h>
-
-#ifdef CONFIG_PCI_PRI
-
-int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
-void pci_disable_pri(struct pci_dev *pdev);
-void pci_restore_pri_state(struct pci_dev *pdev);
-int pci_reset_pri(struct pci_dev *pdev);
-
-#else /* CONFIG_PCI_PRI */
-
-static inline int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
-{
-	return -ENODEV;
-}
-
-static inline void pci_disable_pri(struct pci_dev *pdev)
-{
-}
-
-static inline void pci_restore_pri_state(struct pci_dev *pdev)
-{
-}
-
-static inline int pci_reset_pri(struct pci_dev *pdev)
-{
-	return -ENODEV;
-}
-
-#endif /* CONFIG_PCI_PRI */
-
-#ifdef CONFIG_PCI_PASID
-
-int pci_enable_pasid(struct pci_dev *pdev, int features);
-void pci_disable_pasid(struct pci_dev *pdev);
-void pci_restore_pasid_state(struct pci_dev *pdev);
-int pci_pasid_features(struct pci_dev *pdev);
-int pci_max_pasids(struct pci_dev *pdev);
-int pci_prg_resp_pasid_required(struct pci_dev *pdev);
-
-#else  /* CONFIG_PCI_PASID */
-
-static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
-{
-	return -EINVAL;
-}
-
-static inline void pci_disable_pasid(struct pci_dev *pdev)
-{
-}
-
-static inline void pci_restore_pasid_state(struct pci_dev *pdev)
-{
-}
-
-static inline int pci_pasid_features(struct pci_dev *pdev)
-{
-	return -EINVAL;
-}
-
-static inline int pci_max_pasids(struct pci_dev *pdev)
-{
-	return -EINVAL;
-}
-
-static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
-{
-	return 0;
-}
-#endif /* CONFIG_PCI_PASID */
-
-
-#endif /* LINUX_PCI_ATS_H*/
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 463486016290..8ac142801890 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2349,6 +2349,40 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
 void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #endif
 
+#ifdef CONFIG_PCI_PRI
+int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
+void pci_disable_pri(struct pci_dev *pdev);
+void pci_restore_pri_state(struct pci_dev *pdev);
+int pci_reset_pri(struct pci_dev *pdev);
+#else /* CONFIG_PCI_PRI */
+static inline int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
+{ return -ENODEV; }
+static inline void pci_disable_pri(struct pci_dev *pdev) { }
+static inline void pci_restore_pri_state(struct pci_dev *pdev) { }
+static inline int pci_reset_pri(struct pci_dev *pdev)
+{ return -ENODEV; }
+#endif /* CONFIG_PCI_PRI */
+
+#ifdef CONFIG_PCI_PASID
+int pci_enable_pasid(struct pci_dev *pdev, int features);
+void pci_disable_pasid(struct pci_dev *pdev);
+void pci_restore_pasid_state(struct pci_dev *pdev);
+int pci_pasid_features(struct pci_dev *pdev);
+int pci_max_pasids(struct pci_dev *pdev);
+int pci_prg_resp_pasid_required(struct pci_dev *pdev);
+#else  /* CONFIG_PCI_PASID */
+static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
+{ return -EINVAL; }
+static inline void pci_disable_pasid(struct pci_dev *pdev) { }
+static inline void pci_restore_pasid_state(struct pci_dev *pdev) { }
+static inline int pci_pasid_features(struct pci_dev *pdev)
+{ return -EINVAL; }
+static inline int pci_max_pasids(struct pci_dev *pdev)
+{ return -EINVAL; }
+static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+{ return 0; }
+#endif /* CONFIG_PCI_PASID */
+
 /* Provide the legacy pci_dma_* API */
 #include <linux/pci-dma-compat.h>
 
-- 
2.22.1

