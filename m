Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D771E547F
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 05:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgE1DTG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 23:19:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:13839 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbgE1DTF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 May 2020 23:19:05 -0400
IronPort-SDR: giJChPAO8Y8tlxOCtVNFltsYbMaviJ6pxm9c5Swq0d4eSnJvmGK3jdGf/TF2SV2x4AOMc9Gdnd
 HjR8i5nueEIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 20:19:04 -0700
IronPort-SDR: LjFKusOUpCdcMzwd/6vY5dknjYysVFJ9uKGPyE6ATNDYCOsWRcbWrA20KhYNtHtrZily4xC4yt
 lbfVVgG7PdJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; 
   d="scan'208";a="310775953"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.74])
  by FMSMGA003.fm.intel.com with ESMTP; 27 May 2020 20:19:04 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>, qemu-devel@nongnu.org
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        virtualization@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v3 2/2] PCI: vmd: Use Shadow MEMBAR registers for QEMU/KVM guests
Date:   Wed, 27 May 2020 23:02:40 -0400
Message-Id: <20200528030240.16024-4-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200528030240.16024-1-jonathan.derrick@intel.com>
References: <20200528030240.16024-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VMD device 28C0 natively assists guest passthrough of the VMD endpoint
through the use of shadow registers that provide Host Physical Addresses
to correctly assign bridge windows. These shadow registers are only
available if VMD config space register 0x70, bit 1 is set.

In order to support this mode in existing VMD devices which don't
natively support the shadow register, it was decided that the hypervisor
could offer the shadow registers in a vendor-specific PCI capability.

QEMU has been modified to create this vendor-specific capability and
supply the shadow membar registers for VMDs which don't natively support
this feature. This patch adds this mode and updates the supported device
list to allow this feature to be used on these VMDs.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e386d4e..76d8acb 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -40,13 +40,19 @@ enum vmd_features {
 	 * membars, in order to allow proper address translation during
 	 * resource assignment to enable guest virtualization
 	 */
-	VMD_FEAT_HAS_MEMBAR_SHADOW	= (1 << 0),
+	VMD_FEAT_HAS_MEMBAR_SHADOW		= (1 << 0),
 
 	/*
 	 * Device may provide root port configuration information which limits
 	 * bus numbering
 	 */
-	VMD_FEAT_HAS_BUS_RESTRICTIONS	= (1 << 1),
+	VMD_FEAT_HAS_BUS_RESTRICTIONS		= (1 << 1),
+
+	/*
+	 * Device contains physical location shadow registers in
+	 * vendor-specific capability space
+	 */
+	VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP	= (1 << 2),
 };
 
 /*
@@ -454,6 +460,28 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		}
 	}
 
+	if (features & VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP) {
+		int pos = pci_find_capability(vmd->dev, PCI_CAP_ID_VNDR);
+		u32 reg, regu;
+
+		pci_read_config_dword(vmd->dev, pos + 4, &reg);
+
+		/* "SHDW" */
+		if (pos && reg == 0x53484457) {
+			pci_read_config_dword(vmd->dev, pos + 8, &reg);
+			pci_read_config_dword(vmd->dev, pos + 12, &regu);
+			offset[0] = vmd->dev->resource[VMD_MEMBAR1].start -
+					(((u64) regu << 32 | reg) &
+					 PCI_BASE_ADDRESS_MEM_MASK);
+
+			pci_read_config_dword(vmd->dev, pos + 16, &reg);
+			pci_read_config_dword(vmd->dev, pos + 20, &regu);
+			offset[1] = vmd->dev->resource[VMD_MEMBAR2].start -
+					(((u64) regu << 32 | reg) &
+					 PCI_BASE_ADDRESS_MEM_MASK);
+		}
+	}
+
 	/*
 	 * Certain VMD devices may have a root port configuration option which
 	 * limits the bus range to between 0-127, 128-255, or 224-255
@@ -716,16 +744,20 @@ static int vmd_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend, vmd_resume);
 
 static const struct pci_device_id vmd_ids[] = {
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
-		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c3d),
-		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
-		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
1.8.3.1

