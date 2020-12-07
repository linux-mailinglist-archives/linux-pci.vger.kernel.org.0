Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C507B2D1D95
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 23:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgLGWmJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 17:42:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:13249 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgLGWmI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 17:42:08 -0500
IronPort-SDR: EcBKmFVhC3VDtbmKQpdydzyzDNblFpWAnYaqVR0Vc0aKDbLPc46YpyW8vr1BU1g+z0P7V1qbdM
 Rngwc3fZi85w==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="153602432"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="153602432"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 14:40:22 -0800
IronPort-SDR: OBD43kayQ22wHahBPlKpvk/ewoZJu4NUMN4S/xIztFAXm8eE0dmk1qe54iJ+I86MNoCGevXqOb
 IaHkwawSS8IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="318016353"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2020 14:40:22 -0800
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 1B56C5805B9;
        Mon,  7 Dec 2020 14:40:22 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     bhelgaas@google.com, rafael@kernel.org, len.brown@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 1/2] Add save/restore of Precision Time Measurement capability
Date:   Mon,  7 Dec 2020 14:39:50 -0800
Message-Id: <20201207223951.19667-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI subsystem does not currently save and restore the configuration
space for the Precision Time Measurement (PTM) PCIe extended capability
leading to the possibility of the feature returning disabled on S3 resume.
This has been observed on Intel Coffee Lake desktops. Add save/restore of
the PTM control register. This saves the PTM Enable, Root Select, and
Effective Granularity bits.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

Changes from V1:
	- Move save/restore functions to ptm.c
	- Move pci_add_ext_cap_sve_buffer() to pci_ptm_init in ptm.c
	
 drivers/pci/pci.c      |  2 ++
 drivers/pci/pci.h      |  8 ++++++++
 drivers/pci/pcie/ptm.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e578d34095e9..12ba6351c05b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1566,6 +1566,7 @@ int pci_save_state(struct pci_dev *dev)
 	pci_save_ltr_state(dev);
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
+	pci_save_ptm_state(dev);
 	return pci_save_vc_state(dev);
 }
 EXPORT_SYMBOL(pci_save_state);
@@ -1677,6 +1678,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_vc_state(dev);
 	pci_restore_rebar_state(dev);
 	pci_restore_dpc_state(dev);
+	pci_restore_ptm_state(dev);
 
 	pci_aer_clear_status(dev);
 	pci_restore_aer_state(dev);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f86cae9aa1f4..62cdacba5954 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -516,6 +516,14 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
 
 #endif /* CONFIG_PCI_IOV */
 
+#ifdef CONFIG_PCIE_PTM
+void pci_save_ptm_state(struct pci_dev *dev);
+void pci_restore_ptm_state(struct pci_dev *dev);
+#else
+static inline void pci_save_ptm_state(struct pci_dev *dev) {}
+static inline void pci_restore_ptm_state(struct pci_dev *dev) {}
+#endif
+
 unsigned long pci_cardbus_resource_alignment(struct resource *);
 
 static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 357a454cafa0..6b24a1c9327a 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -29,6 +29,47 @@ static void pci_ptm_info(struct pci_dev *dev)
 		 dev->ptm_root ? " (root)" : "", clock_desc);
 }
 
+void pci_save_ptm_state(struct pci_dev *dev)
+{
+	int ptm;
+	struct pci_cap_saved_state *save_state;
+	u16 *cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
+	if (!ptm)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
+	if (!save_state) {
+		pci_err(dev, "no suspend buffer for PTM\n");
+		return;
+	}
+
+	cap = (u16 *)&save_state->cap.data[0];
+	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, cap);
+}
+
+void pci_restore_ptm_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	int ptm;
+	u16 *cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
+	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
+	if (!save_state || !ptm)
+		return;
+
+	cap = (u16 *)&save_state->cap.data[0];
+	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
+}
+
 void pci_ptm_init(struct pci_dev *dev)
 {
 	int pos;
@@ -65,6 +106,8 @@ void pci_ptm_init(struct pci_dev *dev)
 	if (!pos)
 		return;
 
+	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_PTM, sizeof(u16));
+
 	pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
 	local_clock = (cap & PCI_PTM_GRANULARITY_MASK) >> 8;
 
-- 
2.20.1

