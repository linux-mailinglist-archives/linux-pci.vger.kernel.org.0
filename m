Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3929363ADF
	for <lists+linux-pci@lfdr.de>; Mon, 19 Apr 2021 07:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhDSFEi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Apr 2021 01:04:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:36641 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230038AbhDSFEi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Apr 2021 01:04:38 -0400
IronPort-SDR: bUQ2g8KgpMkfIcrTzo48bk6R1OhtmC/LjYcU1iGxCSOCsyqxHmjz9dexhp34GA1hsbncET2f4S
 0Rahd9Li1xpQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="195296083"
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="195296083"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2021 22:04:09 -0700
IronPort-SDR: rkZj+7hpAC8/mdIwqVQn6To9VCOggQ+nIpMBxtXDzNt0u6AIaYQ1nRC+efjUqWKyjFqLK045kP
 CZMBbEOccwNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="426366037"
Received: from ipu5-build.bj.intel.com ([10.238.232.202])
  by orsmga008.jf.intel.com with ESMTP; 18 Apr 2021 22:04:04 -0700
From:   Bingbu Cao <bingbu.cao@intel.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org, bhelgaas@google.com, rajatja@google.com,
        grundler@chromium.org, tfiga@chromium.org,
        senozhatsky@chromium.org, sakari.ailus@linux.intel.com,
        andriy.shevchenko@linux.intel.com, bingbu.cao@intel.com,
        bingbu.cao@linux.intel.com
Subject: [PATCH] iommu: Use passthrough mode for the Intel IPUs
Date:   Mon, 19 Apr 2021 12:57:05 +0800
Message-Id: <1618808225-10108-1-git-send-email-bingbu.cao@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Intel IPU(Image Processing Unit) has its own (IO)MMU hardware,
The IPU driver allocates its own page table that is not mapped
via the DMA, and thus the Intel IOMMU driver blocks access giving
this error:

DMAR: DRHD: handling fault status reg 3
DMAR: [DMA Read] Request device [00:05.0] PASID ffffffff
      fault addr 76406000 [fault reason 06] PTE Read access is not set

As IPU is not an external facing device which is not risky, so use
IOMMU passthrough mode for Intel IPUs.

Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
---
 drivers/iommu/intel/iommu.c       | 35 +++++++++++++++++++++++++++++++++++
 drivers/staging/media/ipu3/ipu3.c |  2 +-
 include/linux/pci_ids.h           |  5 +++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ee0932307d64..59222d2fe73f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -55,6 +55,12 @@
 #define IS_GFX_DEVICE(pdev) ((pdev->class >> 16) == PCI_BASE_CLASS_DISPLAY)
 #define IS_USB_DEVICE(pdev) ((pdev->class >> 8) == PCI_CLASS_SERIAL_USB)
 #define IS_ISA_DEVICE(pdev) ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA)
+#define IS_IPU_DEVICE(pdev) ((pdev)->vendor == PCI_VENDOR_ID_INTEL &&		\
+			     ((pdev)->device == PCI_DEVICE_ID_INTEL_IPU3 ||	\
+			     (pdev)->device == PCI_DEVICE_ID_INTEL_IPU6 ||	\
+			     (pdev)->device == PCI_DEVICE_ID_INTEL_IPU6SE ||	\
+			     (pdev)->device == PCI_DEVICE_ID_INTEL_IPU6SE_P ||	\
+			     (pdev)->device == PCI_DEVICE_ID_INTEL_IPU6EP))
 #define IS_AZALIA(pdev) ((pdev)->vendor == 0x8086 && (pdev)->device == 0x3a3e)
 
 #define IOAPIC_RANGE_START	(0xfee00000)
@@ -360,6 +366,7 @@ int intel_iommu_enabled = 0;
 EXPORT_SYMBOL_GPL(intel_iommu_enabled);
 
 static int dmar_map_gfx = 1;
+static int dmar_map_ipu = 1;
 static int dmar_forcedac;
 static int intel_iommu_strict;
 static int intel_iommu_superpage = 1;
@@ -368,6 +375,7 @@ static int iommu_skip_te_disable;
 
 #define IDENTMAP_GFX		2
 #define IDENTMAP_AZALIA		4
+#define IDENTMAP_IPU		8
 
 int intel_iommu_gfx_mapped;
 EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
@@ -2839,6 +2847,9 @@ static int device_def_domain_type(struct device *dev)
 
 		if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
 			return IOMMU_DOMAIN_IDENTITY;
+
+		if ((iommu_identity_mapping & IDENTMAP_IPU) && IS_IPU_DEVICE(pdev))
+			return IOMMU_DOMAIN_IDENTITY;
 	}
 
 	return 0;
@@ -3278,6 +3289,9 @@ static int __init init_dmars(void)
 	if (!dmar_map_gfx)
 		iommu_identity_mapping |= IDENTMAP_GFX;
 
+	if (!dmar_map_ipu)
+		iommu_identity_mapping |= IDENTMAP_IPU;
+
 	check_tylersburg_isoch();
 
 	ret = si_domain_init(hw_pass_through);
@@ -5622,6 +5636,15 @@ static void quirk_iommu_igfx(struct pci_dev *dev)
 	dmar_map_gfx = 0;
 }
 
+static void quirk_iommu_ipu(struct pci_dev *dev)
+{
+	if (risky_device(dev))
+		return;
+
+	pci_info(dev, "Passthrough IOMMU for integrated Intel IPU\n");
+	dmar_map_ipu = 0;
+}
+
 /* G4x/GM45 integrated gfx dmar support is totally busted. */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2a40, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e00, quirk_iommu_igfx);
@@ -5657,6 +5680,18 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1632, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163A, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
 
+/* disable IPU dmar support */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IPU3,
+			 quirk_iommu_ipu);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IPU6EP,
+			 quirk_iommu_ipu);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IPU6SE_P,
+			 quirk_iommu_ipu);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IPU6,
+			 quirk_iommu_ipu);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IPU6SE,
+			 quirk_iommu_ipu);
+
 static void quirk_iommu_rwbf(struct pci_dev *dev)
 {
 	if (risky_device(dev))
diff --git a/drivers/staging/media/ipu3/ipu3.c b/drivers/staging/media/ipu3/ipu3.c
index ee1bba6bdcac..aee1130ac042 100644
--- a/drivers/staging/media/ipu3/ipu3.c
+++ b/drivers/staging/media/ipu3/ipu3.c
@@ -16,7 +16,7 @@
 #include "ipu3-dmamap.h"
 #include "ipu3-mmu.h"
 
-#define IMGU_PCI_ID			0x1919
+#define IMGU_PCI_ID			PCI_DEVICE_ID_INTEL_IPU3
 #define IMGU_PCI_BAR			0
 #define IMGU_DMA_MASK			DMA_BIT_MASK(39)
 #define IMGU_MAX_QUEUE_DEPTH		(2 + 2)
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a76ccb697bef..951315892608 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2716,6 +2716,7 @@
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_BRIDGE  0x1576
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_NHI     0x1577
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_BRIDGE  0x1578
+#define PCI_DEVICE_ID_INTEL_IPU3	0x1919
 #define PCI_DEVICE_ID_INTEL_80960_RP	0x1960
 #define PCI_DEVICE_ID_INTEL_QAT_C3XXX	0x19e2
 #define PCI_DEVICE_ID_INTEL_QAT_C3XXX_VF	0x19e3
@@ -2982,6 +2983,8 @@
 #define PCI_DEVICE_ID_INTEL_SBRIDGE_BR		0x3cf5	/* 13.6 */
 #define PCI_DEVICE_ID_INTEL_SBRIDGE_SAD1	0x3cf6	/* 12.7 */
 #define PCI_DEVICE_ID_INTEL_IOAT_SNB	0x402f
+#define PCI_DEVICE_ID_INTEL_IPU6EP	0x465d
+#define PCI_DEVICE_ID_INTEL_IPU6SE_P	0x4e19
 #define PCI_DEVICE_ID_INTEL_5100_16	0x65f0
 #define PCI_DEVICE_ID_INTEL_5100_19	0x65f3
 #define PCI_DEVICE_ID_INTEL_5100_21	0x65f5
@@ -3032,6 +3035,8 @@
 #define PCI_DEVICE_ID_INTEL_IXP4XX	0x8500
 #define PCI_DEVICE_ID_INTEL_IXP2800	0x9004
 #define PCI_DEVICE_ID_INTEL_VMD_9A0B	0x9a0b
+#define PCI_DEVICE_ID_INTEL_IPU6	0x9a19
+#define PCI_DEVICE_ID_INTEL_IPU6SE	0x9a39
 #define PCI_DEVICE_ID_INTEL_S21152BB	0xb152
 
 #define PCI_VENDOR_ID_SCALEMP		0x8686
-- 
2.7.4

