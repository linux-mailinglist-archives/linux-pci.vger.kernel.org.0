Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8862E571F82
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 17:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiGLPgj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jul 2022 11:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiGLPgi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2022 11:36:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCDABFAE3
        for <linux-pci@vger.kernel.org>; Tue, 12 Jul 2022 08:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657640197; x=1689176197;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yrF58gChqBY99kdHiy9JGDlzQsBwjktPmg2NlpqYhJ4=;
  b=OSUtRRVmhckBqYBbrypJWmf1HZSLmgUw983GVu82HqOwzb4r5jVEm33g
   7nK6PA6BjWKaqS3qtbK0iwoyE1PP0bPoi5ameUU/BX0WWJQJ0QabdS+Sb
   433WKsdJV1o0r9StnHo3w+19TdqgtRx0suQewKeQpReV0wOJcXZoDqnt9
   A16FZI7RwfgyYzS0VTpSTUSyqgFoUuyIfeDEMmlvn83YD1EO1RCBYcJaE
   Qs5uw0ulWjgQwPUKlq/rUwKgPqpU6fLyzMoiSXpLxb3Vr5mDlrapQVKse
   lV1u7OSwFYIsp+ia14ZrqcB1YzmTTsSwHHIvUJ0iNFucszcvRG/dhDuLg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="371278983"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="371278983"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 08:36:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="722009337"
Received: from dsa1.ch.intel.com ([143.182.137.99])
  by orsmga004.jf.intel.com with ESMTP; 12 Jul 2022 08:36:16 -0700
From:   Paul Luse <paul.e.luse@intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, paul luse <paul.e.luse@intel.com>,
        Jing Liu <jing2.liu@intel.com>, Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v7] PCI: Add save and restore capability for TPH config space
Date:   Tue, 12 Jul 2022 08:36:41 -0400
Message-Id: <20220712123641.2319-1-paul.e.luse@intel.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

This was discovered working on the SPDK Project (Storage Performance
Development Kit, see https://spdk.io/) where we typically unbind devices
from their native kernel driver and bind to VFIO for use with our own
user space drivers. The process of binding to VFIO results in the loss
of TPH settings due to the resulting PCI reset.

Co-developed-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: paul luse <paul.e.luse@intel.com>
---
Log: v1-v3: Misc review feedback before I knew to add a log
 V4: Changed tph declaration from int to u16
 V5: Removed TPH as a kernel option
 V6: Updated commit message per feedback, added log
 V7: Added kernel option back in, one minor sizeof change

 drivers/pci/pci.c             |  2 +
 drivers/pci/pci.h             | 10 ++++
 drivers/pci/pcie/Kconfig      |  8 +++
 drivers/pci/pcie/Makefile     |  1 +
 drivers/pci/pcie/tph.c        | 93 +++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c           |  1 +
 include/uapi/linux/pci_regs.h |  2 +
 7 files changed, 117 insertions(+)
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
index e10cdec6c56e..0c9151e150a3 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -514,6 +514,16 @@ static inline void pci_restore_ptm_state(struct pci_dev *dev) { }
 static inline void pci_disable_ptm(struct pci_dev *dev) { }
 #endif
 
+#ifdef CONFIG_PCIE_TPH
+void pci_save_tph_state(struct pci_dev *dev);
+void pci_restore_tph_state(struct pci_dev *dev);
+void pci_tph_init(struct pci_dev *dev);
+#else
+static inline void pci_save_tph_state(struct pci_dev *dev) { }
+static inline void pci_restore_tph_state(struct pci_dev *dev) { }
+static inline void pci_tph_init(struct pci_dev *dev) { }
+#endif
+
 unsigned long pci_cardbus_resource_alignment(struct resource *);
 
 static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 788ac8df3f9d..16c95b859023 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -142,3 +142,11 @@ config PCIE_EDR
 	  the PCI Firmware Specification r3.2.  Enable this if you want to
 	  support hybrid DPC model which uses both firmware and OS to
 	  implement DPC.
+
+config PCIE_TPH
+	bool "PCI TPH (Transaction Layer Processing Hints) capability support"
+	help
+	  This enables PCI Express TPH (Transaction Layer Processing Hints) by
+	  making sure they are saved and restored across resets. Enable this if your
+	  hardware uses the PCI Express TPH capabilities. For more information please
+	  refer to PCIe r6.0 sec 6.17.
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 5783a2f79e6a..c91986da9337 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
 obj-$(CONFIG_PCIE_EDR)		+= edr.o
+obj-$(CONFIG_PCIE_TPH)		+= tph.o
diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
new file mode 100644
index 000000000000..d4fd30aea69c
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
+	save_size = sizeof(u32) + num_entries * sizeof(u16);
+	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_TPH, save_size);
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 17a969942d37..d6e289a07416 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2464,6 +2464,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_aer_init(dev);		/* Advanced Error Reporting */
 	pci_dpc_init(dev);		/* Downstream Port Containment */
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
+	pci_tph_init(dev);              /* Transaction Layer Processing Hints */
 
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

