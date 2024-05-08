Return-Path: <linux-pci+bounces-7246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5378BFF6F
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 15:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7384128666D
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 13:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DD284DED;
	Wed,  8 May 2024 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBjZRZgN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A6984E10;
	Wed,  8 May 2024 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176147; cv=none; b=mOKOKhmSi1P54ukle/lUpVTRWm7lieFc+BsqHKRU/dbSuhAKCuDgIt4fxESuDxxLc46laH8JfQ7zoXNZB6OPoGu8i+Kuu0Ix5FOjNXrPF2J1Ud0UO07jfZwqa/eL9F839hy/DHT3+kuRaSHRo9DgfozSRB3d5bhJsj1U+QRVSRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176147; c=relaxed/simple;
	bh=xMnbfMG6UmzXbuF6YbxMeVAejwYiEOepI7+TGS2R2lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGE88Ymkflwe1SQRuIWVsk6d6sSvDfamnL/oPwhN+Vnc4VYzkUCIwCwvHJc0gVYsPnE3iZ5KFHhuoS6SHtQ71sZ5F8JA2f8EDyWUd4U6X5Mt6dIgb4SlBSQJGBN0sa7QDECSJVqOm4qYURK9wv0m4KVBltJ40xCcaxBEPymyw6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fBjZRZgN; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715176145; x=1746712145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xMnbfMG6UmzXbuF6YbxMeVAejwYiEOepI7+TGS2R2lk=;
  b=fBjZRZgNUD0XQrXejB/scFqirSrSELVTnWjvc6BzFIMZUNC8g34YWQ3D
   YqMBdVVobhSVP9aIWILtM7FXRIOVGdwEw4b7BPJEgMP8vo52oc0AFvKac
   7mFld5soX95zRzl9tAO1c+Z9b9dXfCPTy/CRQqpwpwshjb/yNmUOTSt85
   mops5hI5HZWDS7M2BTxOtSsSO8FXCd1Fde0mCPOi3K8KYjd3pcFiCPYy3
   q0kKwe4nUu4y/A/fM4iT2bS40qGf3egOei4H6oVEPWV8YRxovfZ+oUaiX
   v59ZHH1s4dg9++NN+7qnYQNdpM9f80XgqRF6hkmZrSaxyxmQxk37GU5ga
   g==;
X-CSE-ConnectionGUID: lZl1aPcjSXaUcoMGM+6ORQ==
X-CSE-MsgGUID: gBa6DYFFQKOzSkpHcHQRYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="28512762"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28512762"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 06:49:05 -0700
X-CSE-ConnectionGUID: q++t7zISRcqjDW17LK/ubQ==
X-CSE-MsgGUID: +YwBOEczQSmAJYzWTtoHcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28983324"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.80])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 06:49:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v5 5/8] PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller
Date: Wed,  8 May 2024 16:47:41 +0300
Message-Id: <20240508134744.52134-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240508134744.52134-1-ilpo.jarvinen@linux.intel.com>
References: <20240508134744.52134-1-ilpo.jarvinen@linux.intel.com>
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
---
 MAINTAINERS                      |   6 +
 drivers/pci/hotplug/pciehp_pci.c |   2 +
 drivers/pci/pci.h                |  11 ++
 drivers/pci/pcie/Kconfig         |  12 ++
 drivers/pci/pcie/Makefile        |   1 +
 drivers/pci/pcie/bwctrl.c        | 185 +++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.c       |   9 +-
 drivers/pci/pcie/portdrv.h       |  10 +-
 drivers/pci/quirks.c             |   7 +-
 include/linux/pci.h              |   4 +
 10 files changed, 240 insertions(+), 7 deletions(-)
 create mode 100644 drivers/pci/pcie/bwctrl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..bd420cb09821 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17099,6 +17099,12 @@ F:	include/linux/of_pci.h
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
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index ad12515a4a12..406d77d76310 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -133,5 +133,7 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 		pci_dev_put(dev);
 	}
 
+	pcie_reset_lbms_count(ctrl->pcie->port);
+
 	pci_unlock_rescan_remove();
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 664191768395..416540baf27b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -608,6 +608,17 @@ static inline void pcie_set_ecrc_checking(struct pci_dev *dev) { }
 static inline void pcie_ecrc_get_policy(char *str) { }
 #endif
 
+#ifdef CONFIG_PCIE_BWCTRL
+void pcie_reset_lbms_count(struct pci_dev *port);
+int pcie_lbms_count(struct pci_dev *port, unsigned long *val);
+#else
+static inline void pcie_reset_lbms_count(struct pci_dev *port) { }
+static inline int pcie_lbms_count(struct pci_dev *port, unsigned long *val)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 struct pci_dev_reset_methods {
 	u16 vendor;
 	u16 device;
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 8999fcebde6a..6dff10332a13 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -146,6 +146,18 @@ config PCIE_PTM
 	  This is only useful if you have devices that support PTM, but it
 	  is safe to enable even if you don't.
 
+config PCIE_BWCTRL
+	bool "PCI Express Bandwidth Controller"
+	depends on PCIEPORTBUS
+	help
+	  This enables PCI Express Bandwidth Controller. The Bandwidth
+	  Controller allows controlling PCIe Link Speed and listens for Link
+	  Bandwidth Change Notifications. The current Link Speed is available
+	  through /sys/bus/pci/devices/.../current_link_speed.
+
+	  If you know Link Width or Speed changes occur (e.g., to correct
+	  unreliable links), you may answer Y.
+
 config PCIE_EDR
 	bool "PCI Express Error Disconnect Recover support"
 	depends on PCIE_DPC && ACPI
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 6461aa93fe76..6357bc219632 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -12,4 +12,5 @@ obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
+obj-$(CONFIG_PCIE_BWCTRL)	+= bwctrl.o
 obj-$(CONFIG_PCIE_EDR)		+= edr.o
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
new file mode 100644
index 000000000000..5afc533dd0a9
--- /dev/null
+++ b/drivers/pci/pcie/bwctrl.c
@@ -0,0 +1,185 @@
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
+	events = link_status & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS);
+
+	if (ret != PCIBIOS_SUCCESSFUL || !events)
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
+	pci_info(port, "enabled with IRQ %d\n", srv->irq);
+
+	return 0;
+}
+
+static void pcie_bwnotif_remove(struct pcie_device *srv)
+{
+	struct pcie_bwctrl_data *data = get_service_data(srv);
+
+	scoped_guard(rwsem_write, &pcie_bwctrl_remove_rwsem)
+		srv->port->link_bwctrl = NULL;
+
+	pcie_bwnotif_disable(srv->port);
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
index 14a4b89a3b83..e8a348949d70 100644
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
@@ -829,6 +829,7 @@ static void __init pcie_init_services(void)
 	pcie_pme_init();
 	pcie_dpc_init();
 	pcie_hp_init();
+	pcie_bwctrl_init();
 }
 
 static int __init pcie_portdrv_init(void)
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 12c89ea0313b..13366175da22 100644
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
 
@@ -51,6 +51,12 @@ int pcie_dpc_init(void);
 static inline int pcie_dpc_init(void) { return 0; }
 #endif
 
+#ifdef CONFIG_PCIE_BWCTRL
+int pcie_bwctrl_init(void);
+#else
+static inline int pcie_bwctrl_init(void) { return 0; }
+#endif
+
 /* Port Type */
 #define PCIE_ANY_PORT			(~0)
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 9be942623573..d916aa2f2f4d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -35,7 +35,12 @@
 
 static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta)
 {
-	return lnksta & PCI_EXP_LNKSTA_LBMS;
+	unsigned long count;
+
+	if (pcie_lbms_count(dev, &count) < 0)
+		return lnksta & PCI_EXP_LNKSTA_LBMS;
+
+	return count > 0;
 }
 
 /*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ca06a60d4dd3..406ed87fb0aa 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -314,6 +314,7 @@ struct pci_vpd {
 };
 
 struct irq_affinity;
+struct pcie_bwctrl_data;
 struct pcie_link_state;
 struct pci_sriov;
 struct pci_p2pdma;
@@ -494,6 +495,9 @@ struct pci_dev {
 	unsigned int	dpc_rp_extensions:1;
 	u8		dpc_rp_log_size;
 #endif
+#ifdef CONFIG_PCIE_BWCTRL
+	struct pcie_bwctrl_data		*link_bwctrl;
+#endif
 #ifdef CONFIG_PCI_ATS
 	union {
 		struct pci_sriov	*sriov;		/* PF: SR-IOV info */
-- 
2.39.2


