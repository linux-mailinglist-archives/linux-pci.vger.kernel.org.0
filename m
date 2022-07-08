Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B57E56C0C8
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 20:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbiGHRHO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 13:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237843AbiGHRHN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 13:07:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B494C61D57
        for <linux-pci@vger.kernel.org>; Fri,  8 Jul 2022 10:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657300031; x=1688836031;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tVL7Guz7ap6xy8cfPnvhUpXmiAD+GHcZA7voLwnXY80=;
  b=ZD96nSXYL9xWD/LJVOl63FMNdrp9Xpe5uOXPH95pjgAFkxoysnAA4IOD
   lDCdTydGAq3Gty9Hv5wB3j41uolPSBewvLXfaaswTz3PC6RAhFKn0g2I1
   9v7vNqk4f3nJA5jo8g3TlUrvTUJ7DJl5p2I/k46DeXoiHZAlX6WkbaVRg
   N1T96FQVMCozuTvS0Xi7ozk3i89qN8B1botMIoCzOZ1QYiXkqizS0/5t/
   dMjIFK9MHFjX3xZQ1PRsiL0TO4fRBVnDZ2qRbXG+aB/5uaoJq62y8xKr8
   nKvDdar3zcOt2DP+lPiKCJ+ElQ5HV4lYuHX/aIoyLF38TZabtKn5BtoBz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="267362829"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="267362829"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 10:07:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="591628117"
Received: from dsa1.ch.intel.com ([143.182.137.99])
  by orsmga007.jf.intel.com with ESMTP; 08 Jul 2022 10:07:10 -0700
From:   Paul Luse <paul.e.luse@intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, paul luse <paul.e.luse@intel.com>,
        Jing Liu <jing2.liu@intel.com>
Subject: [PATCH v6] PCI: Add save and restore capability for TPH config space
Date:   Fri,  8 Jul 2022 10:07:33 -0400
Message-Id: <20220708140733.3582-1-paul.e.luse@intel.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: paul luse <paul.e.luse@intel.com>

The PCI subsystem does not currently save and restore the configuration
space for the Transaction Layer Processing Hints (TPH) capability,
leading to the possibility of configuration loss in some scenarios. For
more information please refer to PCIe r6.0 sec 6.17.

This was discovered working on the Storage Performance Development Kit
(SPDK) project (see https://spdk.io/) where we typically unbind devices
from their native kernel driver and bind to VFIO for use with our own
user space drivers. The process of binding to VFIO results in the loss
of TPH settings due to the resulting PCI reset.

Co-developed-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: paul luse <paul.e.luse@intel.com>
---
Log: v1-v3: Misc review feedback before I knew to add a log
 V4: changed tph declaration from int to u16
 V5: removed TPH as a kernel option
 V6: Updated commit message per feedback, added log

 drivers/pci/pci.c             |  2 +
 drivers/pci/pci.h             |  4 ++
 drivers/pci/pcie/Makefile     |  1 +
 drivers/pci/pcie/tph.c        | 93 +++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c           |  1 +
 include/uapi/linux/pci_regs.h |  2 +
 6 files changed, 103 insertions(+)
 create mode 100644 drivers/pci/pcie/tph.c

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index cfaf40a540a8..158712bf3069 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1670,6 +1670,7 @@ int pci_save_state(struct pci_dev *dev)
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
+	pci_save_tph_state(dev);
 	return pci_save_vc_state(dev);
 }
 EXPORT_SYMBOL(pci_save_state);
@@ -1782,6 +1783,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_rebar_state(dev);
 	pci_restore_dpc_state(dev);
 	pci_restore_ptm_state(dev);
+	pci_restore_tph_state(dev);
 
 	pci_aer_clear_status(dev);
 	pci_restore_aer_state(dev);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e10cdec6c56e..e6214c8e8cb7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -514,6 +514,10 @@ static inline void pci_restore_ptm_state(struct pci_dev *dev) { }
 static inline void pci_disable_ptm(struct pci_dev *dev) { }
 #endif
 
+void pci_save_tph_state(struct pci_dev *dev);
+void pci_restore_tph_state(struct pci_dev *dev);
+void pci_tph_init(struct pci_dev *dev);
+
 unsigned long pci_cardbus_resource_alignment(struct resource *);
 
 static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 5783a2f79e6a..1287ec65fb30 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -3,6 +3,7 @@
 # Makefile for PCI Express features and port driver
 
 pcieportdrv-y			:= portdrv_core.o portdrv_pci.o rcec.o
+obj-y                           += tph.o
 
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
 
diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
new file mode 100644
index 000000000000..c0d2f20b7d53
--- /dev/null
+++ b/drivers/pci/pcie/tph.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Express Transaction Layer Packet Processing Hints
+ * Copyright (c) 2022, Intel Corporation.
+ */
+
+#include "../pci.h"
+
+static unsigned int pci_get_tph_st_num_entries(struct pci_dev *dev, u16 tph)
+{
+	int num_entries = 0;
+	u32 cap;
+
+	pci_read_config_dword(dev, tph + PCI_TPH_CAP, &cap);
+	if ((cap & PCI_TPH_CAP_LOC_MASK) == PCI_TPH_LOC_CAP) {
+		/* per PCI spec, table entries is encoded as N-1 */
+		num_entries = ((cap & PCI_TPH_CAP_ST_MASK) >> PCI_TPH_CAP_ST_SHIFT) + 1;
+	}
+
+	return num_entries;
+}
+
+void pci_save_tph_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	int num_entries, i, offset;
+	u16 *st_entry, tph;
+	u32 *cap;
+
+	tph = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_TPH);
+	if (!tph)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_TPH);
+	if (!save_state)
+		return;
+
+	/* Save control register as well as all ST entries */
+	cap = &save_state->cap.data[0];
+	pci_read_config_dword(dev, tph + PCI_TPH_CTL, cap++);
+	st_entry = (u16 *)cap;
+	offset = PCI_TPH_ST_TBL;
+	num_entries = pci_get_tph_st_num_entries(dev, tph);
+	for (i = 0; i < num_entries; i++) {
+		pci_read_config_word(dev, tph + offset, st_entry++);
+		offset += sizeof(u16);
+	}
+}
+
+void pci_restore_tph_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	int num_entries, i, offset;
+	u16 *st_entry, tph;
+	u32 *cap;
+
+	tph = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_TPH);
+	if (!tph)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_TPH);
+	if (!save_state)
+		return;
+
+	/* Restore control register as well as all ST entries */
+	cap = &save_state->cap.data[0];
+	pci_write_config_dword(dev, tph + PCI_TPH_CTL, *cap++);
+	st_entry = (u16 *)cap;
+	offset = PCI_TPH_ST_TBL;
+	num_entries = pci_get_tph_st_num_entries(dev, tph);
+	for (i = 0; i < num_entries; i++) {
+		pci_write_config_word(dev, tph + offset, *st_entry++);
+		offset += sizeof(u16);
+	}
+}
+
+void pci_tph_init(struct pci_dev *dev)
+{
+	int num_entries;
+	u32 save_size;
+	u16 tph;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	tph = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_TPH);
+	if (!tph)
+		return;
+
+	num_entries = pci_get_tph_st_num_entries(dev, tph);
+	save_size = sizeof(int) + num_entries * sizeof(u16);
+	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_TPH, save_size);
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 17a969942d37..1f5da3dbf128 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2464,6 +2464,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_aer_init(dev);		/* Advanced Error Reporting */
 	pci_dpc_init(dev);		/* Downstream Port Containment */
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
+	pci_tph_init(dev);              /* Transaction Layer Packet Processing Hints */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 108f8523fa04..2d8b719adbab 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1020,6 +1020,8 @@
 #define   PCI_TPH_LOC_MSIX	0x400	/* in MSI-X */
 #define PCI_TPH_CAP_ST_MASK	0x07FF0000	/* ST table mask */
 #define PCI_TPH_CAP_ST_SHIFT	16	/* ST table shift */
+#define PCI_TPH_CTL             8       /* control offset */
+#define PCI_TPH_ST_TBL          0xc     /* ST table offset */
 #define PCI_TPH_BASE_SIZEOF	0xc	/* size with no ST table */
 
 /* Downstream Port Containment */
-- 
2.34.3

