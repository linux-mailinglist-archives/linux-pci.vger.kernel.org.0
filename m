Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2A472009C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 13:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbjFBLsO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 07:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjFBLsM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 07:48:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC991AD;
        Fri,  2 Jun 2023 04:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685706490; x=1717242490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zLpbqNZWijW0FovPyYDarY5V8t0U65hdE+v9Mv8XiYk=;
  b=X1XxXcjU7egS+YWoz7sL/9P3HdTzrgx0rc/ZVlmaWMQUZ53+yom0Y/X3
   Tn9uGOYucPt9h+8GvwTvWlAWqyFBBLgR98sjMvbXPzvcEKo4Mf2bfebCU
   g1rGBkF8dBSoZ1bijTPttdYx98ysSFxr6qCd1jwpSfkcgCU4oeC0n8Xa3
   i1TFBT2GygOLebtua70VFXo05Hus2mQNuE238M1jj6XiEe0oejlveyqGT
   2jP2NI4SUoej5Ig3tg5g1Z3I8ZRC0GrZHL9aeddfbw6zdiOrjidumLDyG
   jzPxjMF8FK2ThDpxVZ8x5cRKK+dchEGY0uZTSfdFSh/dsk1zFXe5XTc3I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358279601"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="358279601"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 04:48:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="707819412"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="707819412"
Received: from rspatil-mobl3.gar.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.208.112])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 04:48:05 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC PATCH v1 01/13] PCI/ASPM: Disable ASPM when driver requests it
Date:   Fri,  2 Jun 2023 14:47:38 +0300
Message-Id: <20230602114751.19671-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602114751.19671-1-ilpo.jarvinen@linux.intel.com>
References: <20230602114751.19671-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI core/ASPM service driver allows controlling ASPM state through
pci_disable_link_state() and pci_enable_link_state() API. It was
decided earlier (see the Link below), to not allow ASPM changes when OS
does not have control over it but only log a warning about the problem
(commit 2add0ec14c25 ("PCI/ASPM: Warn when driver asks to disable ASPM,
but we can't do it")). Similarly, if ASPM is not enabled through
config, ASPM cannot be disabled.

A number of drivers have added workarounds to force ASPM off with own
writes into the Link Control Register (some even with comments
explaining why PCI core does not disable it under some circumstances).
According to the comments, some drivers require ASPM to be off for
reliable operation.

Having custom ASPM handling in drivers is problematic because the state
kept in the ASPM service driver is not updated by the changes made
outside the link state management API.

As the first step to address this issue, make pci_disable_link_state()
to unconditionally disable ASPM so the motivation for drivers to come
up with custom ASPM handling code is eliminated.

Place the minimal ASPM disable handling into own file as it is too
complicated to fit into a header as static inline and it has almost no
overlap with the existing, more complicated ASPM code in
drivers/pci/pce/aspm.c.

Make pci_disable_link_state() function comment to comply kerneldoc
formatting while changing the description.

Link: https://lore.kernel.org/all/CANUX_P3F5YhbZX3WGU-j1AGpbXb_T9Bis2ErhvKkFMtDvzatVQ@mail.gmail.com/
Link: https://lore.kernel.org/all/20230511131441.45704-1-ilpo.jarvinen@linux.intel.com/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

A few open questions:

- If somebody has better suggestion for where to place the code, please
let me know?

- When OS does not have control, should all states be disabled (instead
  of the ones the driver requested)?

 drivers/pci/pcie/Makefile       |  1 +
 drivers/pci/pcie/aspm.c         | 33 ++++++++++-------
 drivers/pci/pcie/aspm_minimal.c | 66 +++++++++++++++++++++++++++++++++
 include/linux/pci.h             |  6 +--
 4 files changed, 88 insertions(+), 18 deletions(-)
 create mode 100644 drivers/pci/pcie/aspm_minimal.c

diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 8de4ed5f98f1..ec7f04037b01 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -6,6 +6,7 @@ pcieportdrv-y			:= portdrv.o rcec.o
 
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
 
+obj-y				+= aspm_minimal.o
 obj-$(CONFIG_PCIEASPM)		+= aspm.o
 obj-$(CONFIG_PCIEAER)		+= aer.o err.o
 obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 02b47e2cc774..51d6693d7171 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1089,16 +1089,23 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 		return -EINVAL;
 	/*
 	 * A driver requested that ASPM be disabled on this device, but
-	 * if we don't have permission to manage ASPM (e.g., on ACPI
+	 * if we might not have permission to manage ASPM (e.g., on ACPI
 	 * systems we have to observe the FADT ACPI_FADT_NO_ASPM bit and
-	 * the _OSC method), we can't honor that request.  Windows has
-	 * a similar mechanism using "PciASPMOptOut", which is also
-	 * ignored in this situation.
+	 * the _OSC method), previously we chose to not honor disable
+	 * request in that case. Windows has a similar mechanism using
+	 * "PciASPMOptOut", which is also ignored in this situation.
+	 *
+	 * Not honoring the requests to disable ASPM, however, led to
+	 * drivers forcing ASPM off on their own. As such changes of ASPM
+	 * state are not tracked by this service driver, the state kept here
+	 * became out of sync.
+	 *
+	 * Therefore, honor ASPM disable requests even when OS does not have
+	 * ASPM control. Plain disable for ASPM is assumed to be slightly
+	 * safer than fully managing it.
 	 */
-	if (aspm_disabled) {
-		pci_warn(pdev, "can't disable ASPM; OS doesn't have ASPM control\n");
-		return -EPERM;
-	}
+	if (aspm_disabled)
+		pci_warn(pdev, "OS doesn't have ASPM control, disabling ASPM anyway\n");
 
 	if (sem)
 		down_read(&pci_bus_sem);
@@ -1135,13 +1142,13 @@ int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
 EXPORT_SYMBOL(pci_disable_link_state_locked);
 
 /**
- * pci_disable_link_state - Disable device's link state, so the link will
- * never enter specific states.  Note that if the BIOS didn't grant ASPM
- * control to the OS, this does nothing because we can't touch the LNKCTL
- * register. Returns 0 or a negative errno.
- *
+ * pci_disable_link_state - Disable device's link state
  * @pdev: PCI device
  * @state: ASPM link state to disable
+ *
+ * Disable device's link state so the link will never enter specific states.
+ *
+ * Return: 0 or a negative errno
  */
 int pci_disable_link_state(struct pci_dev *pdev, int state)
 {
diff --git a/drivers/pci/pcie/aspm_minimal.c b/drivers/pci/pcie/aspm_minimal.c
new file mode 100644
index 000000000000..4e4f63e51b21
--- /dev/null
+++ b/drivers/pci/pcie/aspm_minimal.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Minimal PCIe ASPM handling when CONFIG_PCIEASPM is not set.
+ *
+ * Copyright (C) 2023 Intel Corporation.
+ */
+
+#include <linux/pci.h>
+
+#include "../pci.h"
+
+#ifndef CONFIG_PCIEASPM
+/*
+ * Always disable ASPM when requested, even when CONFIG_PCIEASPM is
+ * not build to avoid drivers adding code to do it on their own
+ * which caused issues when core does not know about the out-of-band
+ * ASPM state changes.
+ */
+int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
+{
+	struct pci_dev *parent = pdev->bus->self;
+	struct pci_bus *linkbus = pdev->bus;
+	struct pci_dev *child;
+	u16 aspm_enabled, linkctl;
+	int ret;
+
+	if (!parent)
+		return -ENODEV;
+
+	ret = pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &linkctl);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return pcibios_err_to_errno(ret);
+	aspm_enabled = linkctl & PCI_EXP_LNKCTL_ASPMC;
+
+	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &linkctl);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return pcibios_err_to_errno(ret);
+	aspm_enabled |= linkctl & PCI_EXP_LNKCTL_ASPMC;
+
+	/* If no states need to be disabled, don't touch LNKCTL */
+	if (state & aspm_enabled)
+		return 0;
+
+	ret = pcie_capability_clear_word(parent, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASPMC);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return pcibios_err_to_errno(ret);
+	list_for_each_entry(child, &linkbus->devices, bus_list)
+		pcie_capability_clear_word(child, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASPMC);
+
+	return 0;
+}
+EXPORT_SYMBOL(pci_disable_link_state_locked);
+
+int pci_disable_link_state(struct pci_dev *pdev, int state)
+{
+	int ret;
+
+	down_read(&pci_bus_sem);
+	ret = pci_disable_link_state_locked(pdev, state);
+	up_read(&pci_bus_sem);
+
+	return ret;
+}
+EXPORT_SYMBOL(pci_disable_link_state);
+
+#endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ab7682ed172f..1878f55b2aa6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1774,18 +1774,14 @@ extern bool pcie_ports_native;
 					 PCIE_LINK_STATE_L1_2 | PCIE_LINK_STATE_L1_1_PCIPM |\
 					 PCIE_LINK_STATE_L1_2_PCIPM)
 
-#ifdef CONFIG_PCIEASPM
 int pci_disable_link_state(struct pci_dev *pdev, int state);
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
+#ifdef CONFIG_PCIEASPM
 int pci_enable_link_state(struct pci_dev *pdev, int state);
 void pcie_no_aspm(void);
 bool pcie_aspm_support_enabled(void);
 bool pcie_aspm_enabled(struct pci_dev *pdev);
 #else
-static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
-{ return 0; }
-static inline int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
-{ return 0; }
 static inline int pci_enable_link_state(struct pci_dev *pdev, int state)
 { return 0; }
 static inline void pcie_no_aspm(void) { }
-- 
2.30.2

