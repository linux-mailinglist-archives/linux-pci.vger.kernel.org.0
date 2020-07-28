Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2575C23137C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 22:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgG1UHG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 16:07:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:63202 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728421AbgG1UHF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 16:07:05 -0400
IronPort-SDR: uv+JI5eEbsTkgzlWxgaRUQqaOk8HS+YSN9ffry8LLrM7WBZSrVe3gCCFQOpfYifTKqE1UnJuKp
 9EE+2/0PoKoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="151287327"
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="151287327"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 13:07:03 -0700
IronPort-SDR: 27nCk82vQTr6XvoYppITQDkHqjYZLDtGbmecCHbwPGBzPWuY1yaWCnoWqE0ddMzHtE8gmVKQV3
 +CF6CsUA2Alw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="312756374"
Received: from unknown (HELO nsgsw-wilsonpoint.lm.intel.com) ([10.232.116.124])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2020 13:07:03 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH 1/6] PCI: vmd: Create physical offset helper
Date:   Tue, 28 Jul 2020 13:49:40 -0600
Message-Id: <20200728194945.14126-2-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728194945.14126-1-jonathan.derrick@intel.com>
References: <20200728194945.14126-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Moves the guest-passthrough physical offset discovery code to a new
helper. No functional changes.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 105 +++++++++++++++++++++--------------
 1 file changed, 62 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index f69ef8c89f72..44b2db789eff 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -417,6 +417,60 @@ static int vmd_find_free_domain(void)
 	return domain + 1;
 }
 
+static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
+				resource_size_t *offset1,
+				resource_size_t *offset2)
+{
+	struct pci_dev *dev = vmd->dev;
+	u64 phys1, phys2;
+
+	if (native_hint) {
+		u32 vmlock;
+		int ret;
+
+		ret = pci_read_config_dword(dev, PCI_REG_VMLOCK, &vmlock);
+		if (ret || vmlock == ~0)
+			return -ENODEV;
+
+		if (MB2_SHADOW_EN(vmlock)) {
+			void __iomem *membar2;
+
+			membar2 = pci_iomap(dev, VMD_MEMBAR2, 0);
+			if (!membar2)
+				return -ENOMEM;
+			phys1 = readq(membar2 + MB2_SHADOW_OFFSET);
+			phys2 = readq(membar2 + MB2_SHADOW_OFFSET + 8);
+			pci_iounmap(dev, membar2);
+		} else
+			return 0;
+	} else {
+		/* Hypervisor-Emulated Vendor-Specific Capability */
+		int pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
+		u32 reg, regu;
+
+		pci_read_config_dword(dev, pos + 4, &reg);
+
+		/* "SHDW" */
+		if (pos && reg == 0x53484457) {
+			pci_read_config_dword(dev, pos + 8, &reg);
+			pci_read_config_dword(dev, pos + 12, &regu);
+			phys1 = (u64) regu << 32 | reg;
+
+			pci_read_config_dword(dev, pos + 16, &reg);
+			pci_read_config_dword(dev, pos + 20, &regu);
+			phys2 = (u64) regu << 32 | reg;
+		} else
+			return 0;
+	}
+
+	*offset1 = dev->resource[VMD_MEMBAR1].start -
+			(phys1 & PCI_BASE_ADDRESS_MEM_MASK);
+	*offset2 = dev->resource[VMD_MEMBAR2].start -
+			(phys2 & PCI_BASE_ADDRESS_MEM_MASK);
+
+	return 0;
+}
+
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
@@ -428,6 +482,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
 	struct pci_bus *child;
+	int ret;
 
 	/*
 	 * Shadow registers may exist in certain VMD device ids which allow
@@ -436,50 +491,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	 * or 0, depending on an enable bit in the VMD device.
 	 */
 	if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
-		u32 vmlock;
-		int ret;
-
 		membar2_offset = MB2_SHADOW_OFFSET + MB2_SHADOW_SIZE;
-		ret = pci_read_config_dword(vmd->dev, PCI_REG_VMLOCK, &vmlock);
-		if (ret || vmlock == ~0)
-			return -ENODEV;
-
-		if (MB2_SHADOW_EN(vmlock)) {
-			void __iomem *membar2;
-
-			membar2 = pci_iomap(vmd->dev, VMD_MEMBAR2, 0);
-			if (!membar2)
-				return -ENOMEM;
-			offset[0] = vmd->dev->resource[VMD_MEMBAR1].start -
-					(readq(membar2 + MB2_SHADOW_OFFSET) &
-					 PCI_BASE_ADDRESS_MEM_MASK);
-			offset[1] = vmd->dev->resource[VMD_MEMBAR2].start -
-					(readq(membar2 + MB2_SHADOW_OFFSET + 8) &
-					 PCI_BASE_ADDRESS_MEM_MASK);
-			pci_iounmap(vmd->dev, membar2);
-		}
-	}
-
-	if (features & VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP) {
-		int pos = pci_find_capability(vmd->dev, PCI_CAP_ID_VNDR);
-		u32 reg, regu;
-
-		pci_read_config_dword(vmd->dev, pos + 4, &reg);
-
-		/* "SHDW" */
-		if (pos && reg == 0x53484457) {
-			pci_read_config_dword(vmd->dev, pos + 8, &reg);
-			pci_read_config_dword(vmd->dev, pos + 12, &regu);
-			offset[0] = vmd->dev->resource[VMD_MEMBAR1].start -
-					(((u64) regu << 32 | reg) &
-					 PCI_BASE_ADDRESS_MEM_MASK);
-
-			pci_read_config_dword(vmd->dev, pos + 16, &reg);
-			pci_read_config_dword(vmd->dev, pos + 20, &regu);
-			offset[1] = vmd->dev->resource[VMD_MEMBAR2].start -
-					(((u64) regu << 32 | reg) &
-					 PCI_BASE_ADDRESS_MEM_MASK);
-		}
+		ret = vmd_get_phys_offsets(vmd, true, &offset[0], &offset[1]);
+		if (ret)
+			return ret;
+	} else if (features & VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP) {
+		ret = vmd_get_phys_offsets(vmd, false, &offset[0], &offset[1]);
+		if (ret)
+			return ret;
 	}
 
 	/*
-- 
2.27.0

