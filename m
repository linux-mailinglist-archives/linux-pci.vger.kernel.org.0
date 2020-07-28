Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEF1230F4F
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 18:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbgG1Qbu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 12:31:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:34128 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731383AbgG1Qbt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 12:31:49 -0400
IronPort-SDR: 7Ksq8ImbIzMdX5bYfxub3ocr4icRkY/YxzDslyI90dejYtyngIHqsOQH73vxiDQrSi3SBowU6q
 UPL7T6BHMlAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="152502173"
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="152502173"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 09:31:48 -0700
IronPort-SDR: +QPBZKUrDVcXs3SicE62wIDczzMz+XCl3W2rJsusKE+NuUOdigJBcjIXvxVnQhAGp1LHubJJbJ
 E0irz+pILeUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="464536516"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.74])
  by orsmga005.jf.intel.com with ESMTP; 28 Jul 2020 09:31:45 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>
Subject: [RFC] PCI: vmd: Enable ASPM if BIOS requests it
Date:   Tue, 28 Jul 2020 12:13:21 -0400
Message-Id: <20200728161321.38229-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VMD domains are not ACPI-managed devices and do not have the necessary
ACPI hooks to enable ASPM. However if the BIOS has requested ASPM
enablement, we should try to honor that request regardless. This patch
adds the ASPM support to VMD child devices if requested by the FADT
table.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: You-Sheng Yang <vicamo.yang@canonical.com>
---


Hi,

My knowledge on these kinds of power modes is limited, and we are having
trouble bringing the Root Port child device out of L1 with this patch.

Can you help me understand the correct flow for bringing the Root Port
device out of L1 with kernel flow, and what I might be missing here?



 drivers/pci/controller/vmd.c |  9 ++++++++-
 drivers/pci/pcie/aspm.c      | 19 ++-----------------
 include/linux/pci.h          | 17 +++++++++++++++++
 3 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 76d8acbee7d5..f1b058efb642 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -14,6 +14,7 @@
 #include <linux/srcu.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
+#include <linux/acpi.h>
 
 #include <asm/irqdomain.h>
 #include <asm/device.h>
@@ -601,8 +602,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	 * and will fail pcie_bus_configure_settings() early. It can instead be
 	 * run on each of the real root ports.
 	 */
-	list_for_each_entry(child, &vmd->bus->children, node)
+	list_for_each_entry(child, &vmd->bus->children, node) {
+#if IS_ENABLED(CONFIG_PCIEASPM)
+		if (!(acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM))
+			pcie_config_aspm_link(child->self->link_state,
+					      ASPM_STATE_ALL);
+#endif
 		pcie_bus_configure_settings(child);
+	}
 
 	pci_bus_add_devices(vmd->bus);
 
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 253c30cc1967..04cdb0b5a672 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -25,22 +25,6 @@
 #endif
 #define MODULE_PARAM_PREFIX "pcie_aspm."
 
-/* Note: those are not register definitions */
-#define ASPM_STATE_L0S_UP	(1)	/* Upstream direction L0s state */
-#define ASPM_STATE_L0S_DW	(2)	/* Downstream direction L0s state */
-#define ASPM_STATE_L1		(4)	/* L1 state */
-#define ASPM_STATE_L1_1		(8)	/* ASPM L1.1 state */
-#define ASPM_STATE_L1_2		(0x10)	/* ASPM L1.2 state */
-#define ASPM_STATE_L1_1_PCIPM	(0x20)	/* PCI PM L1.1 state */
-#define ASPM_STATE_L1_2_PCIPM	(0x40)	/* PCI PM L1.2 state */
-#define ASPM_STATE_L1_SS_PCIPM	(ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1_2_PCIPM)
-#define ASPM_STATE_L1_2_MASK	(ASPM_STATE_L1_2 | ASPM_STATE_L1_2_PCIPM)
-#define ASPM_STATE_L1SS		(ASPM_STATE_L1_1 | ASPM_STATE_L1_1_PCIPM |\
-				 ASPM_STATE_L1_2_MASK)
-#define ASPM_STATE_L0S		(ASPM_STATE_L0S_UP | ASPM_STATE_L0S_DW)
-#define ASPM_STATE_ALL		(ASPM_STATE_L0S | ASPM_STATE_L1 |	\
-				 ASPM_STATE_L1SS)
-
 struct aspm_latency {
 	u32 l0s;			/* L0s latency (nsec) */
 	u32 l1;				/* L1 latency (nsec) */
@@ -748,7 +732,7 @@ static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
 					   PCI_EXP_LNKCTL_ASPMC, val);
 }
 
-static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
+void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 {
 	u32 upstream = 0, dwstream = 0;
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
@@ -798,6 +782,7 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 
 	link->aspm_enabled = state;
 }
+EXPORT_SYMBOL_GPL(pcie_config_aspm_link);
 
 static void pcie_config_aspm_path(struct pcie_link_state *link)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7a40cd5caed0..1c41781b160a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -377,6 +377,22 @@ struct pci_dev {
 	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
 
 #ifdef CONFIG_PCIEASPM
+/* Note: those are not register definitions */
+#define ASPM_STATE_L0S_UP	(1)	/* Upstream direction L0s state */
+#define ASPM_STATE_L0S_DW	(2)	/* Downstream direction L0s state */
+#define ASPM_STATE_L1		(4)	/* L1 state */
+#define ASPM_STATE_L1_1		(8)	/* ASPM L1.1 state */
+#define ASPM_STATE_L1_2		(0x10)	/* ASPM L1.2 state */
+#define ASPM_STATE_L1_1_PCIPM	(0x20)	/* PCI PM L1.1 state */
+#define ASPM_STATE_L1_2_PCIPM	(0x40)	/* PCI PM L1.2 state */
+#define ASPM_STATE_L1_SS_PCIPM	(ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1_2_PCIPM)
+#define ASPM_STATE_L1_2_MASK	(ASPM_STATE_L1_2 | ASPM_STATE_L1_2_PCIPM)
+#define ASPM_STATE_L1SS		(ASPM_STATE_L1_1 | ASPM_STATE_L1_1_PCIPM |\
+				 ASPM_STATE_L1_2_MASK)
+#define ASPM_STATE_L0S		(ASPM_STATE_L0S_UP | ASPM_STATE_L0S_DW)
+#define ASPM_STATE_ALL		(ASPM_STATE_L0S | ASPM_STATE_L1 |	\
+				 ASPM_STATE_L1SS)
+
 	struct pcie_link_state	*link_state;	/* ASPM link state */
 	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
 					   supported from root to here */
@@ -1577,6 +1593,7 @@ extern bool pcie_ports_native;
 #define PCIE_LINK_STATE_L1_2_PCIPM	BIT(6)
 
 #ifdef CONFIG_PCIEASPM
+void pcie_config_aspm_link(struct pcie_link_state *link, u32 state);
 int pci_disable_link_state(struct pci_dev *pdev, int state);
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
 void pcie_no_aspm(void);
-- 
2.18.1

