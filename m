Return-Path: <linux-pci+bounces-14060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1013899660F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 11:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3B41F22E47
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 09:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5E218DF83;
	Wed,  9 Oct 2024 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QIZF1XXe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6764018E023;
	Wed,  9 Oct 2024 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467616; cv=none; b=YRN5RmlNx1Bl0wN+V6rPjrH4I4OwmsqSReVuoSdrNboeWS4agQYuoWzJG3JjgQMxIR/ELFkTcjf77Z/L5S2bzNUuKVh7jTl1mi+qFdlKWMSH3dNfbFlcRaWqVf4n0F1R5uCy3nQe3vvJq84ljZr/dKNXN+PM/skR0sNjDVf+Nkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467616; c=relaxed/simple;
	bh=/mgzEhVEkRpewq2GLUy7xReJHynAQplsS5Th7njqnWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RA6YyZawYVEuRY/7C79a3nGXM1K9U2/Yqoptgqh3uzXh7Yg92E9brxzu6iFLPAeqQRd9k4i0K18O85MT/Z2yk2Pfhu/tBUPs8I6CAeHY5SDwLSCG7sJ9/ykNPVa7+ld8DnkHPJNfqc19A7bgH4VrcWQBP5E59H5KzPrZkS2gmRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QIZF1XXe; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728467614; x=1760003614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/mgzEhVEkRpewq2GLUy7xReJHynAQplsS5Th7njqnWs=;
  b=QIZF1XXe5OswMB5K34pHtEDV1lpI1xboJY+7/IphoyGC1BpgV9kPr7No
   XQbMpgM/L+0dKOQrdf7BCTNF0d4D7WxvRQJhZB73yoLZWw5RuMDdXXR20
   53WNU9pP+/cmC8uaRmtLEsB/YZKBSHqMVS3sOHRL26MUWzV8eBJBABZ/R
   ftwlDI0z4xO3YWcGGnjCjiDAgz7hAJY/L6sdE4aMTclJoiduhSUQJPsvf
   bju6jmSxj+f0SYJu2/rCVPXpaAy/sINhyevYQu+v1iuw0Hp8fP1fv771a
   EkT1G0AOae5JeaACv3VnDSqzKxTit8iB+dHhbCdS9QdeZYpKgxt+wizrP
   w==;
X-CSE-ConnectionGUID: Ri2H/p8mQkqZdUjmhNuoMg==
X-CSE-MsgGUID: RTNUzE/kQcGIYlP2u4zipw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38322969"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="38322969"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 02:53:33 -0700
X-CSE-ConnectionGUID: Wq+GEJidQIKRe+OoXEGgVA==
X-CSE-MsgGUID: RYO6iU4pSiGHSnBcWuTvfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76506888"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.41])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 02:53:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 5/8] PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller
Date: Wed,  9 Oct 2024 12:52:20 +0300
Message-Id: <20241009095223.7093-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241009095223.7093-1-ilpo.jarvinen@linux.intel.com>
References: <20241009095223.7093-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This mostly reverts the commit b4c7d2076b4e ("PCI/LINK: Remove
bandwidth notification"). An upcoming commit extends this driver
building PCIe bandwidth controller on top of it.

The PCIe bandwidth notification were first added in the commit
e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth
notification") but later had to be removed. The significant changes
compared with the old bandwidth notification driver include:

1) Don't print the notifications into kernel log, just keep the Link
   Speed cached into the struct pci_bus updated. While somewhat
   unfortunate, the log spam was the source of complaints that
   eventually lead to the removal of the bandwidth notifications driver
   (see the links below for further information).

2) Besides the Link Bandwidth Management Interrupt, enable also Link
   Autonomous Bandwidth Interrupt to cover the other source of
   bandwidth changes.

3) Use threaded IRQ with IRQF_ONESHOT to handle Bandwidth Notification
   Interrupts to address the problem fixed in the commit 3e82a7f9031f
   ("PCI/LINK: Supply IRQ handler so level-triggered IRQs are acked")).

4) Handle Link Speed updates robustly. Refresh the cached Link Speed
   when enabling Bandwidth Notification Interrupts, and solve the race
   between Link Speed read and LBMS/LABS update in
   pcie_bwnotif_irq_thread().

5) Use concurrency safe LNKCTL RMW operations.

6) The driver is now called PCIe bwctrl (bandwidth controller) instead
   of just bandwidth notifications because of increased scope and
   functionality within the driver.

7) Coexist with the Target Link Speed quirk in
   pcie_failed_link_retrain(). Provide LBMS counting API for it.

8) Tweaks to variable/functions names for consistency and length
   reasons.

Bandwidth Notifications enable the cur_bus_speed in the struct pci_bus
to keep track PCIe Link Speed changes.

Link: https://lore.kernel.org/all/20190429185611.121751-1-helgaas@kernel.org/
Link: https://lore.kernel.org/linux-pci/20190501142942.26972-1-keith.busch@intel.com/
Link: https://lore.kernel.org/linux-pci/20200115221008.GA191037@google.com/
Suggested-by: Lukas Wunner <lukas@wunner.de> # Building bwctrl on top of bwnotif
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 MAINTAINERS                       |   6 +
 drivers/pci/hotplug/pciehp_ctrl.c |   5 +
 drivers/pci/pci.c                 |   2 +-
 drivers/pci/pci.h                 |  11 ++
 drivers/pci/pcie/Makefile         |   2 +-
 drivers/pci/pcie/bwctrl.c         | 190 ++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.c        |   9 +-
 drivers/pci/pcie/portdrv.h        |   6 +-
 drivers/pci/quirks.c              |   9 +-
 include/linux/pci.h               |   2 +
 10 files changed, 233 insertions(+), 9 deletions(-)
 create mode 100644 drivers/pci/pcie/bwctrl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..8c555b3325d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17933,6 +17933,12 @@ F:	include/linux/of_pci.h
 F:	include/linux/pci*
 F:	include/uapi/linux/pci*
 
+PCIE BANDWIDTH CONTROLLER
+M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
+L:	linux-pci@vger.kernel.org
+S:	Supported
+F:	drivers/pci/pcie/bwctrl.c
+
 PCIE DRIVER FOR AMAZON ANNAPURNA LABS
 M:	Jonathan Chocron <jonnyc@amazon.com>
 L:	linux-pci@vger.kernel.org
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index dcdbfcf404dd..d603a7aa7483 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -19,6 +19,8 @@
 #include <linux/types.h>
 #include <linux/pm_runtime.h>
 #include <linux/pci.h>
+
+#include "../pci.h"
 #include "pciehp.h"
 
 /* The following routines constitute the bulk of the
@@ -127,6 +129,9 @@ static void remove_board(struct controller *ctrl, bool safe_removal)
 
 	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
 			      INDICATOR_NOOP);
+
+	/* Don't carry LBMS indications across */
+	pcie_reset_lbms_count(ctrl->pcie->port);
 }
 
 static int pciehp_enable_slot(struct controller *ctrl);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b28ab4761b18..c1f9616485ae 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4740,7 +4740,7 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
 	 * to track link speed or width changes made by hardware itself
 	 * in attempt to correct unreliable link operation.
 	 */
-	pcie_capability_write_word(pdev, PCI_EXP_LNKSTA, PCI_EXP_LNKSTA_LBMS);
+	pcie_reset_lbms_count(pdev);
 	return rc;
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6e827d47aa85..33ed324d1953 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -697,6 +697,17 @@ static inline void pcie_set_ecrc_checking(struct pci_dev *dev) { }
 static inline void pcie_ecrc_get_policy(char *str) { }
 #endif
 
+#ifdef CONFIG_PCIEPORTBUS
+void pcie_reset_lbms_count(struct pci_dev *port);
+int pcie_lbms_count(struct pci_dev *port, unsigned long *val);
+#else
+static inline void pcie_reset_lbms_count(struct pci_dev *port) {}
+static inline int pcie_lbms_count(struct pci_dev *port, unsigned long *val)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 struct pci_dev_reset_methods {
 	u16 vendor;
 	u16 device;
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 6461aa93fe76..53ccab62314d 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -4,7 +4,7 @@
 
 pcieportdrv-y			:= portdrv.o rcec.o
 
-obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
+obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
 
 obj-y				+= aspm.o
 obj-$(CONFIG_PCIEAER)		+= aer.o err.o
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
new file mode 100644
index 000000000000..1b11b5da79d4
--- /dev/null
+++ b/drivers/pci/pcie/bwctrl.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PCIe bandwidth controller
+ *
+ * Author: Alexandru Gagniuc <mr.nuke.me@gmail.com>
+ *
+ * Copyright (C) 2019 Dell Inc
+ * Copyright (C) 2023-2024 Intel Corporation
+ *
+ * This service port driver hooks into the Bandwidth Notification interrupt
+ * watching for changes or links becoming degraded in operation. It updates
+ * the cached Current Link Speed that is exposed to user space through sysfs.
+ */
+
+#define dev_fmt(fmt) "bwctrl: " fmt
+
+#include <linux/atomic.h>
+#include <linux/cleanup.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/rwsem.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "../pci.h"
+#include "portdrv.h"
+
+/**
+ * struct pcie_bwctrl_data - PCIe bandwidth controller
+ * @lbms_count:		Count for LBMS (since last reset)
+ */
+struct pcie_bwctrl_data {
+	atomic_t lbms_count;
+};
+
+/* Prevents port removal during link speed changes and LBMS count accessors */
+static DECLARE_RWSEM(pcie_bwctrl_remove_rwsem);
+
+static void pcie_bwnotif_enable(struct pcie_device *srv)
+{
+	struct pcie_bwctrl_data *data = get_service_data(srv);
+	struct pci_dev *port = srv->port;
+	u16 link_status;
+	int ret;
+
+	/* Count LBMS seen so far as one */
+	ret = pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
+	if (ret == PCIBIOS_SUCCESSFUL && link_status & PCI_EXP_LNKSTA_LBMS)
+		atomic_inc(&data->lbms_count);
+
+	pcie_capability_set_word(port, PCI_EXP_LNKCTL,
+				 PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
+	pcie_capability_write_word(port, PCI_EXP_LNKSTA,
+				   PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS);
+
+	/*
+	 * Update after enabling notifications & clearing status bits ensures
+	 * link speed is up to date.
+	 */
+	pcie_update_link_speed(port->subordinate);
+}
+
+static void pcie_bwnotif_disable(struct pci_dev *port)
+{
+	pcie_capability_clear_word(port, PCI_EXP_LNKCTL,
+				   PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
+}
+
+static irqreturn_t pcie_bwnotif_irq_thread(int irq, void *context)
+{
+	struct pcie_device *srv = context;
+	struct pcie_bwctrl_data *data = get_service_data(srv);
+	struct pci_dev *port = srv->port;
+	u16 link_status, events;
+	int ret;
+
+	ret = pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return IRQ_NONE;
+
+	events = link_status & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS);
+	if (!events)
+		return IRQ_NONE;
+
+	if (events & PCI_EXP_LNKSTA_LBMS)
+		atomic_inc(&data->lbms_count);
+
+	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
+
+	/*
+	 * Interrupts will not be triggered from any further Link Speed
+	 * change until LBMS is cleared by the write. Therefore, re-read the
+	 * speed (inside pcie_update_link_speed()) after LBMS has been
+	 * cleared to avoid missing link speed changes.
+	 */
+	pcie_update_link_speed(port->subordinate);
+
+	return IRQ_HANDLED;
+}
+
+void pcie_reset_lbms_count(struct pci_dev *port)
+{
+	struct pcie_bwctrl_data *data;
+
+	guard(rwsem_read)(&pcie_bwctrl_remove_rwsem);
+	data = port->link_bwctrl;
+	if (data)
+		atomic_set(&data->lbms_count, 0);
+	else
+		pcie_capability_write_word(port, PCI_EXP_LNKSTA, PCI_EXP_LNKSTA_LBMS);
+}
+
+int pcie_lbms_count(struct pci_dev *port, unsigned long *val)
+{
+	struct pcie_bwctrl_data *data;
+
+	guard(rwsem_read)(&pcie_bwctrl_remove_rwsem);
+	data = port->link_bwctrl;
+	if (!data)
+		return -ENOTTY;
+
+	*val = atomic_read(&data->lbms_count);
+
+	return 0;
+}
+
+static int pcie_bwnotif_probe(struct pcie_device *srv)
+{
+	struct pci_dev *port = srv->port;
+	int ret;
+
+	struct pcie_bwctrl_data *data __free(kfree) =
+				kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	set_service_data(srv, data);
+
+	ret = request_threaded_irq(srv->irq, NULL, pcie_bwnotif_irq_thread,
+				   IRQF_SHARED | IRQF_ONESHOT, "PCIe bwctrl", srv);
+	if (ret)
+		return ret;
+
+	port->link_bwctrl = no_free_ptr(data);
+	pcie_bwnotif_enable(srv);
+
+	pci_dbg(port, "enabled with IRQ %d\n", srv->irq);
+
+	return 0;
+}
+
+static void pcie_bwnotif_remove(struct pcie_device *srv)
+{
+	struct pcie_bwctrl_data *data = get_service_data(srv);
+
+	pcie_bwnotif_disable(srv->port);
+	scoped_guard(rwsem_write, &pcie_bwctrl_remove_rwsem)
+		srv->port->link_bwctrl = NULL;
+
+	free_irq(srv->irq, srv);
+	kfree(data);
+}
+
+static int pcie_bwnotif_suspend(struct pcie_device *srv)
+{
+	pcie_bwnotif_disable(srv->port);
+	return 0;
+}
+
+static int pcie_bwnotif_resume(struct pcie_device *srv)
+{
+	pcie_bwnotif_enable(srv);
+	return 0;
+}
+
+static struct pcie_port_service_driver pcie_bwctrl_driver = {
+	.name		= "pcie_bwctrl",
+	.port_type	= PCIE_ANY_PORT,
+	.service	= PCIE_PORT_SERVICE_BWCTRL,
+	.probe		= pcie_bwnotif_probe,
+	.suspend	= pcie_bwnotif_suspend,
+	.resume		= pcie_bwnotif_resume,
+	.remove		= pcie_bwnotif_remove,
+};
+
+int __init pcie_bwctrl_init(void)
+{
+	return pcie_port_service_register(&pcie_bwctrl_driver);
+}
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 6af5e0425872..5e10306b6308 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -68,7 +68,7 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
 	 */
 
 	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP |
-		    PCIE_PORT_SERVICE_BWNOTIF)) {
+		    PCIE_PORT_SERVICE_BWCTRL)) {
 		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
 		*pme = FIELD_GET(PCI_EXP_FLAGS_IRQ, reg16);
 		nvec = *pme + 1;
@@ -150,11 +150,11 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 
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
@@ -271,7 +271,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 
 		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
 		if (linkcap & PCI_EXP_LNKCAP_LBNC)
-			services |= PCIE_PORT_SERVICE_BWNOTIF;
+			services |= PCIE_PORT_SERVICE_BWCTRL;
 	}
 
 	return services;
@@ -828,6 +828,7 @@ static void __init pcie_init_services(void)
 	pcie_aer_init();
 	pcie_pme_init();
 	pcie_dpc_init();
+	pcie_bwctrl_init();
 	pcie_hp_init();
 }
 
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 12c89ea0313b..bd29d1cc7b8b 100644
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
 
@@ -51,6 +51,8 @@ int pcie_dpc_init(void);
 static inline int pcie_dpc_init(void) { return 0; }
 #endif
 
+int pcie_bwctrl_init(void);
+
 /* Port Type */
 #define PCIE_ANY_PORT			(~0)
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a560ea403b8e..e6d502dca939 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -35,7 +35,14 @@
 
 static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta)
 {
-	return lnksta & PCI_EXP_LNKSTA_LBMS;
+	unsigned long count;
+	int ret;
+
+	ret = pcie_lbms_count(dev, &count);
+	if (ret < 0)
+		return lnksta & PCI_EXP_LNKSTA_LBMS;
+
+	return count > 0;
 }
 
 /*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a02b77fe7865..5f9de226be13 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -314,6 +314,7 @@ struct pci_vpd {
 };
 
 struct irq_affinity;
+struct pcie_bwctrl_data;
 struct pcie_link_state;
 struct pci_sriov;
 struct pci_p2pdma;
@@ -503,6 +504,7 @@ struct pci_dev {
 	unsigned int	dpc_rp_extensions:1;
 	u8		dpc_rp_log_size;
 #endif
+	struct pcie_bwctrl_data		*link_bwctrl;
 #ifdef CONFIG_PCI_ATS
 	union {
 		struct pci_sriov	*sriov;		/* PF: SR-IOV info */
-- 
2.39.5


