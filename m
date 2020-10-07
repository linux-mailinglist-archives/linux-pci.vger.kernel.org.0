Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35B92865D4
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 19:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgJGRX7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 13:23:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:1354 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbgJGRX7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Oct 2020 13:23:59 -0400
IronPort-SDR: XejR/9Mbmw6bTXi00mTdvFcXXvW7H7Iu2Lb/jKLy7d/EEPiEaBUwyU5fT62lkUjjIarNomLzrB
 NetAGuBRXJEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="165087285"
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="165087285"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 09:48:57 -0700
IronPort-SDR: JS5WF/ZWWJ6drdqE9KPrrDpGO1nBnyE4kYAX0TQWWs/O+DP5LvoNAnanbch5hAQcdmV4FDKhDy
 /8xYVEACsEgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="311818207"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 07 Oct 2020 09:48:56 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 01586580867;
        Wed,  7 Oct 2020 09:48:56 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     bhelgaas@google.com, len.brown@intel.com, rafael@kernel.org
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Disable PTM during suspend on Intel PCI bridges
Date:   Wed,  7 Oct 2020 09:48:51 -0700
Message-Id: <20201007164851.1218-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Intel Platform Controller Hubs (PCH) since Cannon Lake, the Precision
Time Measurement (PTM) capability can prevent PCIe root ports from power
gating during suspend-to-idle, causing increased power consumption on
systems that suspend using Low Power S0 Idle [1]. The issue is yet to be
root caused but believed to be coming from a race condition in the suspend
flow as the incidence rate varies for different platforms on Linux but the
issue does not occur at all in other operating systems. For now, disable
the feature on suspend on all Intel root ports and enable again on resume.

Link: https://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf
Bug: https://bugzilla.kernel.org/show_bug.cgi?id=209361
Tested-by: Len Brown <len.brown@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/pci/quirks.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index bdf9b52567e0..e82b1f60c7a1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5632,3 +5632,60 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
 			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
+
+#ifdef CONFIG_PCIE_PTM
+/*
+ * On Intel Platform Controller Hubs (PCH) since Cannon Lake, the Precision
+ * Time Measurement (PTM) capability can prevent the PCIe root port from
+ * power gating during suspend-to-idle, causing increased power consumption.
+ * So disable the feature on suspend on all Intel root ports and enable
+ * again on resume.
+ */
+static void quirk_intel_ptm_disable_suspend(struct pci_dev *dev)
+{
+	int pos;
+	u32 ctrl;
+
+	if (!(dev->ptm_enabled && dev->ptm_root))
+		return;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
+	if (!pos)
+		return;
+
+	pci_dbg(dev, "quirk: disabling PTM\n");
+
+	dev->ptm_enabled = 0;
+	dev->ptm_root = 0;
+
+	pci_read_config_dword(dev, pos + PCI_PTM_CTRL, &ctrl);
+	ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
+	pci_write_config_dword(dev, pos + PCI_PTM_CTRL, ctrl);
+}
+
+static void quirk_intel_ptm_enable_resume(struct pci_dev *dev)
+{
+	int pos;
+	u32 ctrl;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
+	if (!pos)
+		return;
+
+	pci_dbg(dev, "quirk: re-enabling PTM\n");
+
+	pci_read_config_dword(dev, pos + PCI_PTM_CTRL, &ctrl);
+	ctrl |= PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT;
+	pci_write_config_dword(dev, pos + PCI_PTM_CTRL, ctrl);
+
+	dev->ptm_enabled = 1;
+	dev->ptm_root = 1;
+}
+
+DECLARE_PCI_FIXUP_CLASS_SUSPEND(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
+				PCI_CLASS_BRIDGE_PCI, 8,
+				quirk_intel_ptm_disable_suspend)
+DECLARE_PCI_FIXUP_CLASS_RESUME(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
+			       PCI_CLASS_BRIDGE_PCI, 8,
+			       quirk_intel_ptm_enable_resume)
+#endif
-- 
2.20.1

