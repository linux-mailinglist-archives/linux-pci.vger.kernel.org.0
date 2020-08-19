Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18662249D1D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 14:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgHSMB3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 08:01:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:49568 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbgHSL7x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 07:59:53 -0400
IronPort-SDR: UUz4j6ybe5JRGO0NbWNzCbgpvxEenyVMPWEH1q4zFtRZm7g6OnwXPUct+/IMCwmp4FgOEOIv3b
 xH3KfRtnz4Vg==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="239922677"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="239922677"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 04:59:17 -0700
IronPort-SDR: aDIf1b0oZyDRsTxu1NRQT3+ecP3BgVbcoqkhLqALQQaAY/1TKR5udU/hBumleY+scJ4zs52UXp
 Jm+uO7zJDtLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="329310785"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 19 Aug 2020 04:59:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id E81B436D; Wed, 19 Aug 2020 14:59:06 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Dana Alkattan <dana.alkattan@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 16/19] PCI / thunderbolt: Switch to use device links instead of PCI quirk
Date:   Wed, 19 Aug 2020 14:59:02 +0300
Message-Id: <20200819115905.59834-17-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
References: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On older Apple systems there is currently a PCI quirk in place to block
resume of tunneled PCIe ports until NHI (Thunderbolt controller) is
resumed. This makes sure the PCIe tunnels are re-established before PCI
core notices it.

With device links the same thing can be done without quirks. The driver
core will make sure the supplier (NHI) is resumed before consumers (PCIe
downstream ports).

For this reason switch the Thunderbolt driver to use device links and
remove the PCI quirk.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/quirks.c      | 57 ---------------------------------
 drivers/thunderbolt/nhi.c | 66 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 57 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index bdf9b52567e0..a25471436523 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3673,63 +3673,6 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
 			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
 			       quirk_apple_poweroff_thunderbolt);
-
-/*
- * Apple: Wait for the Thunderbolt controller to reestablish PCI tunnels
- *
- * During suspend the Thunderbolt controller is reset and all PCI
- * tunnels are lost. The NHI driver will try to reestablish all tunnels
- * during resume. We have to manually wait for the NHI since there is
- * no parent child relationship between the NHI and the tunneled
- * bridges.
- */
-static void quirk_apple_wait_for_thunderbolt(struct pci_dev *dev)
-{
-	struct pci_dev *sibling = NULL;
-	struct pci_dev *nhi = NULL;
-
-	if (!x86_apple_machine)
-		return;
-	if (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)
-		return;
-
-	/*
-	 * Find the NHI and confirm that we are a bridge on the Thunderbolt
-	 * host controller and not on a Thunderbolt endpoint.
-	 */
-	sibling = pci_get_slot(dev->bus, 0x0);
-	if (sibling == dev)
-		goto out; /* we are the downstream bridge to the NHI */
-	if (!sibling || !sibling->subordinate)
-		goto out;
-	nhi = pci_get_slot(sibling->subordinate, 0x0);
-	if (!nhi)
-		goto out;
-	if (nhi->vendor != PCI_VENDOR_ID_INTEL
-		    || (nhi->device != PCI_DEVICE_ID_INTEL_LIGHT_RIDGE &&
-			nhi->device != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C &&
-			nhi->device != PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI &&
-			nhi->device != PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI)
-		    || nhi->class != PCI_CLASS_SYSTEM_OTHER << 8)
-		goto out;
-	pci_info(dev, "quirk: waiting for Thunderbolt to reestablish PCI tunnels...\n");
-	device_pm_wait_for_dev(&dev->dev, &nhi->dev);
-out:
-	pci_dev_put(nhi);
-	pci_dev_put(sibling);
-}
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
-			       PCI_DEVICE_ID_INTEL_LIGHT_RIDGE,
-			       quirk_apple_wait_for_thunderbolt);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
-			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
-			       quirk_apple_wait_for_thunderbolt);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
-			       PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_BRIDGE,
-			       quirk_apple_wait_for_thunderbolt);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
-			       PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_BRIDGE,
-			       quirk_apple_wait_for_thunderbolt);
 #endif
 
 /*
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 24d2b7eff59b..e499fe78756b 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/property.h>
+#include <linux/platform_data/x86/apple.h>
 
 #include "nhi.h"
 #include "nhi_regs.h"
@@ -1069,6 +1070,69 @@ static bool nhi_imr_valid(struct pci_dev *pdev)
 	return true;
 }
 
+/*
+ * During suspend the Thunderbolt controller is reset and all PCIe
+ * tunnels are lost. The NHI driver will try to reestablish all tunnels
+ * during resume. This adds device links between the tunneled PCIe
+ * downstream ports and the NHI so that the device core will make sure
+ * NHI is resumed first before the rest.
+ */
+static void tb_apple_add_links(struct tb_nhi *nhi)
+{
+	struct pci_dev *upstream, *pdev;
+
+	if (!x86_apple_machine)
+		return;
+
+	switch (nhi->pdev->device) {
+	case PCI_DEVICE_ID_INTEL_LIGHT_RIDGE:
+	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C:
+	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI:
+	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI:
+		break;
+	default:
+		return;
+	}
+
+	upstream = pci_upstream_bridge(nhi->pdev);
+	while (upstream) {
+		if (!pci_is_pcie(upstream))
+			return;
+		if (pci_pcie_type(upstream) == PCI_EXP_TYPE_UPSTREAM)
+			break;
+		upstream = pci_upstream_bridge(upstream);
+	}
+
+	if (!upstream)
+		return;
+
+	/*
+	 * For each hotplug downstream port, create add device link
+	 * back to NHI so that PCIe tunnels can be re-established after
+	 * sleep.
+	 */
+	for_each_pci_bridge(pdev, upstream->subordinate) {
+		const struct device_link *link;
+
+		if (!pci_is_pcie(pdev))
+			continue;
+		if (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM ||
+		    !pdev->is_hotplug_bridge)
+			continue;
+
+		link = device_link_add(&pdev->dev, &nhi->pdev->dev,
+				       DL_FLAG_AUTOREMOVE_SUPPLIER |
+				       DL_FLAG_PM_RUNTIME);
+		if (link) {
+			dev_dbg(&nhi->pdev->dev, "created link from %s\n",
+				dev_name(&pdev->dev));
+		} else {
+			dev_warn(&nhi->pdev->dev, "device link creation from %s failed\n",
+				 dev_name(&pdev->dev));
+		}
+	}
+}
+
 static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct tb_nhi *nhi;
@@ -1134,6 +1198,8 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			return res;
 	}
 
+	tb_apple_add_links(nhi);
+
 	tb = icm_probe(nhi);
 	if (!tb)
 		tb = tb_probe(nhi);
-- 
2.28.0

