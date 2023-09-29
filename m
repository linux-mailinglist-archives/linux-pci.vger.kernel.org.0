Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3C57B31E7
	for <lists+linux-pci@lfdr.de>; Fri, 29 Sep 2023 13:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjI2L7W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 07:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjI2L7T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 07:59:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DBD1B7;
        Fri, 29 Sep 2023 04:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695988756; x=1727524756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WxEVy4hdhGkm4tL7rKxsWilDBWWfyowIoUWmNvGZdbc=;
  b=aAxZiSENfNHaIzCg5nj4ezwC/hTMFKO9w99+Pw/DNh+zFp+kNkxWWM09
   NsPP/wOGeN4E7n3a4n5BfXf51x1DYact6IaupgHap8loQwhJn+jbODCSo
   fb9y+eIlLpFaz12xGwlaRiO7Fdiq0wO5Ak1PSC/n47eQt65QM/yYSjxne
   1zDy4vYHPQYKeLuct4VX5WYtgxMerri32kcX4we9B0Aahp9iDnq1F2dRm
   z5g4CYxdstPjjcXJoAAbbibNwVv7GZKFrWgP+e5SONKvhBPEKncUeyNOq
   CSaBA/zoy3GMeKyfBkuuXdMvE2alimI5hLXEaCH4lfZ68gAgo47mbN/Ge
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="362528114"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="362528114"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 04:59:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="815581168"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="815581168"
Received: from valeks2x-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.242])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 04:59:07 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 07/10] PCI/LINK: Re-add BW notification portdrv as PCIe BW controller
Date:   Fri, 29 Sep 2023 14:57:20 +0300
Message-Id: <20230929115723.7864-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com>
References: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This mostly reverts b4c7d2076b4e ("PCI/LINK: Remove bandwidth
notification"), however, there are small tweaks:

1) Call it PCIe bwctrl (bandwidth controller) instead of just
   bandwidth notifications.
2) Don't print the notifications into kernel log, just keep the current
   link speed updated.
3) Use concurrency safe LNKCTL RMW operations.
4) Read link speed after enabling the notification to ensure the
   current link speed is correct from the start.
5) Add local variable in probe for srv->port.
6) Handle link speed read and LBMS write race in
   pcie_bw_notification_irq().

The reason for 1) is to indicate the increased scope of the driver. A
subsequent commit extends the driver to allow controlling PCIe
bandwidths from user space upon crossing thermal thresholds.

While 2) is somewhat unfortunate, the log spam was the source of
complaints that eventually lead to the removal of the bandwidth
notifications driver (see the links below for further information).
After re-adding this driver back the userspace can, if it wishes to,
observe the link speed changes using the current bus speed files under
sysfs.

Link: https://lore.kernel.org/all/20190429185611.121751-1-helgaas@kernel.org/
Link: https://lore.kernel.org/linux-pci/20190501142942.26972-1-keith.busch@intel.com/
Link: https://lore.kernel.org/linux-pci/20200115221008.GA191037@google.com/
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/Kconfig   |   8 +++
 drivers/pci/pcie/Makefile  |   1 +
 drivers/pci/pcie/bwctrl.c  | 131 +++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.c |   9 +--
 drivers/pci/pcie/portdrv.h |  10 ++-
 5 files changed, 153 insertions(+), 6 deletions(-)
 create mode 100644 drivers/pci/pcie/bwctrl.c

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 228652a59f27..1ef8073fa89a 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -137,6 +137,14 @@ config PCIE_PTM
 	  This is only useful if you have devices that support PTM, but it
 	  is safe to enable even if you don't.
 
+config PCIE_BW
+	bool "PCI Express Bandwidth Change Notification"
+	depends on PCIEPORTBUS
+	help
+	  This enables PCI Express Bandwidth Change Notification.  If
+	  you know link width or rate changes occur to correct unreliable
+	  links, you may answer Y.
+
 config PCIE_EDR
 	bool "PCI Express Error Disconnect Recover support"
 	depends on PCIE_DPC && ACPI
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 8de4ed5f98f1..175065a495cf 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -12,4 +12,5 @@ obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
+obj-$(CONFIG_PCIE_BW)		+= bwctrl.o
 obj-$(CONFIG_PCIE_EDR)		+= edr.o
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
new file mode 100644
index 000000000000..4fc6718fc0e5
--- /dev/null
+++ b/drivers/pci/pcie/bwctrl.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PCI Express Link Bandwidth Notification services driver
+ * Author: Alexandru Gagniuc <mr.nuke.me@gmail.com>
+ *
+ * Copyright (C) 2019, Dell Inc
+ *
+ * The PCIe Link Bandwidth Notification provides a way to notify the
+ * operating system when the link width or data rate changes.  This
+ * capability is required for all root ports and downstream ports
+ * supporting links wider than x1 and/or multiple link speeds.
+ *
+ * This service port driver hooks into the bandwidth notification interrupt
+ * watching for link speed changes or links becoming degraded in operation
+ * and updates the cached link speed exposed to user space.
+ */
+
+#define dev_fmt(fmt) "bwctrl: " fmt
+
+#include "../pci.h"
+#include "portdrv.h"
+
+static bool pcie_link_bandwidth_notification_supported(struct pci_dev *dev)
+{
+	int ret;
+	u32 lnk_cap;
+
+	ret = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnk_cap);
+	return (ret == PCIBIOS_SUCCESSFUL) && (lnk_cap & PCI_EXP_LNKCAP_LBNC);
+}
+
+static void pcie_enable_link_bandwidth_notification(struct pci_dev *dev)
+{
+	u16 link_status;
+	int ret;
+
+	pcie_capability_write_word(dev, PCI_EXP_LNKSTA, PCI_EXP_LNKSTA_LBMS);
+	pcie_capability_set_word(dev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LBMIE);
+
+	/* Read after enabling notifications to ensure link speed is up to date */
+	ret = pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &link_status);
+	if (ret == PCIBIOS_SUCCESSFUL)
+		pcie_update_link_speed(dev->subordinate, link_status);
+}
+
+static void pcie_disable_link_bandwidth_notification(struct pci_dev *dev)
+{
+	pcie_capability_clear_word(dev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LBMIE);
+}
+
+static irqreturn_t pcie_bw_notification_irq(int irq, void *context)
+{
+	struct pcie_device *srv = context;
+	struct pci_dev *port = srv->port;
+	u16 link_status, events;
+	int ret;
+
+	ret = pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
+	events = link_status & PCI_EXP_LNKSTA_LBMS;
+
+	if (ret != PCIBIOS_SUCCESSFUL || !events)
+		return IRQ_NONE;
+
+	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
+
+	/*
+	 * The write to clear LBMS prevents getting interrupt from the
+	 * latest link speed when the link speed changes between the above
+	 * LNKSTA read and write. Therefore, re-read the speed before
+	 * updating it.
+	 */
+	ret = pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return IRQ_HANDLED;
+	pcie_update_link_speed(port->subordinate, link_status);
+
+	return IRQ_HANDLED;
+}
+
+static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
+{
+	struct pci_dev *port = srv->port;
+	int ret;
+
+	/* Single-width or single-speed ports do not have to support this. */
+	if (!pcie_link_bandwidth_notification_supported(port))
+		return -ENODEV;
+
+	ret = request_irq(srv->irq, pcie_bw_notification_irq,
+			  IRQF_SHARED, "PCIe BW ctrl", srv);
+	if (ret)
+		return ret;
+
+	pcie_enable_link_bandwidth_notification(port);
+	pci_info(port, "enabled with IRQ %d\n", srv->irq);
+
+	return 0;
+}
+
+static void pcie_bandwidth_notification_remove(struct pcie_device *srv)
+{
+	pcie_disable_link_bandwidth_notification(srv->port);
+	free_irq(srv->irq, srv);
+}
+
+static int pcie_bandwidth_notification_suspend(struct pcie_device *srv)
+{
+	pcie_disable_link_bandwidth_notification(srv->port);
+	return 0;
+}
+
+static int pcie_bandwidth_notification_resume(struct pcie_device *srv)
+{
+	pcie_enable_link_bandwidth_notification(srv->port);
+	return 0;
+}
+
+static struct pcie_port_service_driver pcie_bandwidth_notification_driver = {
+	.name		= "pcie_bwctrl",
+	.port_type	= PCIE_ANY_PORT,
+	.service	= PCIE_PORT_SERVICE_BWCTRL,
+	.probe		= pcie_bandwidth_notification_probe,
+	.suspend	= pcie_bandwidth_notification_suspend,
+	.resume		= pcie_bandwidth_notification_resume,
+	.remove		= pcie_bandwidth_notification_remove,
+};
+
+int __init pcie_bwctrl_init(void)
+{
+	return pcie_port_service_register(&pcie_bandwidth_notification_driver);
+}
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 46fad0d813b2..ed33049bffd6 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -67,7 +67,7 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
 	 */
 
 	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP |
-		    PCIE_PORT_SERVICE_BWNOTIF)) {
+		    PCIE_PORT_SERVICE_BWCTRL)) {
 		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
 		*pme = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
 		nvec = *pme + 1;
@@ -149,11 +149,11 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 
 	/* PME, hotplug and bandwidth notification share an MSI/MSI-X vector */
 	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP |
-		    PCIE_PORT_SERVICE_BWNOTIF)) {
+		    PCIE_PORT_SERVICE_BWCTRL)) {
 		pcie_irq = pci_irq_vector(dev, pme);
 		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pcie_irq;
 		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pcie_irq;
-		irqs[PCIE_PORT_SERVICE_BWNOTIF_SHIFT] = pcie_irq;
+		irqs[PCIE_PORT_SERVICE_BWCTRL_SHIFT] = pcie_irq;
 	}
 
 	if (mask & PCIE_PORT_SERVICE_AER)
@@ -270,7 +270,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 
 		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
 		if (linkcap & PCI_EXP_LNKCAP_LBNC)
-			services |= PCIE_PORT_SERVICE_BWNOTIF;
+			services |= PCIE_PORT_SERVICE_BWCTRL;
 	}
 
 	return services;
@@ -828,6 +828,7 @@ static void __init pcie_init_services(void)
 	pcie_pme_init();
 	pcie_dpc_init();
 	pcie_hp_init();
+	pcie_bwctrl_init();
 }
 
 static int __init pcie_portdrv_init(void)
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 58a2b1a1cae4..f622c8a02a5b 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -20,8 +20,8 @@
 #define PCIE_PORT_SERVICE_HP		(1 << PCIE_PORT_SERVICE_HP_SHIFT)
 #define PCIE_PORT_SERVICE_DPC_SHIFT	3	/* Downstream Port Containment */
 #define PCIE_PORT_SERVICE_DPC		(1 << PCIE_PORT_SERVICE_DPC_SHIFT)
-#define PCIE_PORT_SERVICE_BWNOTIF_SHIFT	4	/* Bandwidth notification */
-#define PCIE_PORT_SERVICE_BWNOTIF	(1 << PCIE_PORT_SERVICE_BWNOTIF_SHIFT)
+#define PCIE_PORT_SERVICE_BWCTRL_SHIFT	4	/* Bandwidth Controller (notifications) */
+#define PCIE_PORT_SERVICE_BWCTRL	(1 << PCIE_PORT_SERVICE_BWCTRL_SHIFT)
 
 #define PCIE_PORT_DEVICE_MAXSERVICES   5
 
@@ -53,6 +53,12 @@ int pcie_dpc_init(void);
 static inline int pcie_dpc_init(void) { return 0; }
 #endif
 
+#ifdef CONFIG_PCIE_BW
+int pcie_bwctrl_init(void);
+#else
+static inline int pcie_bwctrl_init(void) { return 0; }
+#endif
+
 /* Port Type */
 #define PCIE_ANY_PORT			(~0)
 
-- 
2.30.2

