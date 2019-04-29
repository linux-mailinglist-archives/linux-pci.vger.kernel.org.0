Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 267BDEA8E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2019 20:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfD2S4c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Apr 2019 14:56:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728946AbfD2S4c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Apr 2019 14:56:32 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E87582075E;
        Mon, 29 Apr 2019 18:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556564191;
        bh=NBKyNbdJTrY1D6fviATmyvjCaS3CZ6qkk2gTMsUfwJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ShYIHkfsb/UAYPLI51tK8hGSx6MCtzKcLVCBS6Wt0DVNHWMKG8DIbAEjUsrDt3yTt
         X64fyiOU72uXjMYeWeFEL/EzDbDhtUWHgnfkRaZlEDhM/dqpNV8gYx6adwjdqvyt7R
         fI9oHkn0ToExtoYCEsI7XMnQDuw4TVLTzBKG1Kwc=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>,
        Sinan Kaya <okaya@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] Revert "PCI/LINK: Report degraded links via link bandwidth notification"
Date:   Mon, 29 Apr 2019 13:56:11 -0500
Message-Id: <20190429185611.121751-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190429185611.121751-1-helgaas@kernel.org>
References: <20190429185611.121751-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This reverts commit e8303bb7a75c113388badcc49b2a84b4121c1b3e.

e8303bb7a75c added logging whenever a link changed speed or width to a
state that is considered degraded.  Unfortunately, it cannot differentiate
signal integrity-related link changes from those intentionally initiated by
an endpoint driver, including drivers that may live in userspace or VMs
when making use of vfio-pci.  Some GPU drivers actively manage the link
state to save power, which generates a stream of messages like this:

  vfio-pci 0000:07:00.0: 32.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x16 link at 0000:00:02.0 (capable of 64.000 Gb/s with 5 GT/s x16 link)

We really *do* want to be alerted when the link bandwidth is reduced
because of hardware failures, but degradation by intentional link state
management is probably far more common, so the signal-to-noise ratio is
currently low.

Until we figure out a way to identify the real problems or silence the
intentional situations, revert the following commits, which include the
initial implementation (e8303bb7a75c) and subsequent fixes:

    e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth notification")
    3e82a7f9031f ("PCI/LINK: Supply IRQ handler so level-triggered IRQs are acked")
    55397ce8df48 ("PCI/LINK: Clear bandwidth notification interrupt before enabling it")
    0fa635aec9ab ("PCI/LINK: Deduplicate bandwidth reports for multi-function devices")

Link: https://lore.kernel.org/lkml/155597243666.19387.1205950870601742062.stgit@gimli.home
Link: https://lore.kernel.org/lkml/155605909349.3575.13433421148215616375.stgit@gimli.home
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Alexandru Gagniuc <mr.nuke.me@gmail.com>
CC: Lukas Wunner <lukas@wunner.de>
CC: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci.h                  |   1 -
 drivers/pci/pcie/Makefile          |   1 -
 drivers/pci/pcie/bw_notification.c | 121 -----------------------------
 drivers/pci/pcie/portdrv.h         |   6 +-
 drivers/pci/pcie/portdrv_core.c    |  17 ++--
 drivers/pci/pcie/portdrv_pci.c     |   1 -
 drivers/pci/probe.c                |   2 +-
 7 files changed, 7 insertions(+), 142 deletions(-)
 delete mode 100644 drivers/pci/pcie/bw_notification.c

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d994839a3e24..224d88634115 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -273,7 +273,6 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
 u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
 			   enum pcie_link_width *width);
 void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
-void pcie_report_downtraining(struct pci_dev *dev);
 
 /* Single Root I/O Virtualization */
 struct pci_sriov {
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index f1d7bc1e5efa..ab514083d5d4 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -3,7 +3,6 @@
 # Makefile for PCI Express features and port driver
 
 pcieportdrv-y			:= portdrv_core.o portdrv_pci.o err.o
-pcieportdrv-y			+= bw_notification.o
 
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
 
diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
deleted file mode 100644
index 4fa9e3523ee1..000000000000
--- a/drivers/pci/pcie/bw_notification.c
+++ /dev/null
@@ -1,121 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * PCI Express Link Bandwidth Notification services driver
- * Author: Alexandru Gagniuc <mr.nuke.me@gmail.com>
- *
- * Copyright (C) 2019, Dell Inc
- *
- * The PCIe Link Bandwidth Notification provides a way to notify the
- * operating system when the link width or data rate changes.  This
- * capability is required for all root ports and downstream ports
- * supporting links wider than x1 and/or multiple link speeds.
- *
- * This service port driver hooks into the bandwidth notification interrupt
- * and warns when links become degraded in operation.
- */
-
-#include "../pci.h"
-#include "portdrv.h"
-
-static bool pcie_link_bandwidth_notification_supported(struct pci_dev *dev)
-{
-	int ret;
-	u32 lnk_cap;
-
-	ret = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnk_cap);
-	return (ret == PCIBIOS_SUCCESSFUL) && (lnk_cap & PCI_EXP_LNKCAP_LBNC);
-}
-
-static void pcie_enable_link_bandwidth_notification(struct pci_dev *dev)
-{
-	u16 lnk_ctl;
-
-	pcie_capability_write_word(dev, PCI_EXP_LNKSTA, PCI_EXP_LNKSTA_LBMS);
-
-	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnk_ctl);
-	lnk_ctl |= PCI_EXP_LNKCTL_LBMIE;
-	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnk_ctl);
-}
-
-static void pcie_disable_link_bandwidth_notification(struct pci_dev *dev)
-{
-	u16 lnk_ctl;
-
-	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnk_ctl);
-	lnk_ctl &= ~PCI_EXP_LNKCTL_LBMIE;
-	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnk_ctl);
-}
-
-static irqreturn_t pcie_bw_notification_irq(int irq, void *context)
-{
-	struct pcie_device *srv = context;
-	struct pci_dev *port = srv->port;
-	u16 link_status, events;
-	int ret;
-
-	ret = pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
-	events = link_status & PCI_EXP_LNKSTA_LBMS;
-
-	if (ret != PCIBIOS_SUCCESSFUL || !events)
-		return IRQ_NONE;
-
-	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
-	pcie_update_link_speed(port->subordinate, link_status);
-	return IRQ_WAKE_THREAD;
-}
-
-static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
-{
-	struct pcie_device *srv = context;
-	struct pci_dev *port = srv->port;
-	struct pci_dev *dev;
-
-	/*
-	 * Print status from downstream devices, not this root port or
-	 * downstream switch port.
-	 */
-	down_read(&pci_bus_sem);
-	list_for_each_entry(dev, &port->subordinate->devices, bus_list)
-		pcie_report_downtraining(dev);
-	up_read(&pci_bus_sem);
-
-	return IRQ_HANDLED;
-}
-
-static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
-{
-	int ret;
-
-	/* Single-width or single-speed ports do not have to support this. */
-	if (!pcie_link_bandwidth_notification_supported(srv->port))
-		return -ENODEV;
-
-	ret = request_threaded_irq(srv->irq, pcie_bw_notification_irq,
-				   pcie_bw_notification_handler,
-				   IRQF_SHARED, "PCIe BW notif", srv);
-	if (ret)
-		return ret;
-
-	pcie_enable_link_bandwidth_notification(srv->port);
-
-	return 0;
-}
-
-static void pcie_bandwidth_notification_remove(struct pcie_device *srv)
-{
-	pcie_disable_link_bandwidth_notification(srv->port);
-	free_irq(srv->irq, srv);
-}
-
-static struct pcie_port_service_driver pcie_bandwidth_notification_driver = {
-	.name		= "pcie_bw_notification",
-	.port_type	= PCIE_ANY_PORT,
-	.service	= PCIE_PORT_SERVICE_BWNOTIF,
-	.probe		= pcie_bandwidth_notification_probe,
-	.remove		= pcie_bandwidth_notification_remove,
-};
-
-int __init pcie_bandwidth_notification_init(void)
-{
-	return pcie_port_service_register(&pcie_bandwidth_notification_driver);
-}
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 1d50dc58ac40..fbbf00b0992e 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -20,10 +20,8 @@
 #define PCIE_PORT_SERVICE_HP		(1 << PCIE_PORT_SERVICE_HP_SHIFT)
 #define PCIE_PORT_SERVICE_DPC_SHIFT	3	/* Downstream Port Containment */
 #define PCIE_PORT_SERVICE_DPC		(1 << PCIE_PORT_SERVICE_DPC_SHIFT)
-#define PCIE_PORT_SERVICE_BWNOTIF_SHIFT	4	/* Bandwidth notification */
-#define PCIE_PORT_SERVICE_BWNOTIF	(1 << PCIE_PORT_SERVICE_BWNOTIF_SHIFT)
 
-#define PCIE_PORT_DEVICE_MAXSERVICES   5
+#define PCIE_PORT_DEVICE_MAXSERVICES   4
 
 #ifdef CONFIG_PCIEAER
 int pcie_aer_init(void);
@@ -49,8 +47,6 @@ int pcie_dpc_init(void);
 static inline int pcie_dpc_init(void) { return 0; }
 #endif
 
-int pcie_bandwidth_notification_init(void);
-
 /* Port Type */
 #define PCIE_ANY_PORT			(~0)
 
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 7d04f9d087a6..f458ac9cb70c 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -99,7 +99,7 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
  */
 static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 {
-	int nr_entries, nvec, pcie_irq;
+	int nr_entries, nvec;
 	u32 pme = 0, aer = 0, dpc = 0;
 
 	/* Allocate the maximum possible number of MSI/MSI-X vectors */
@@ -135,13 +135,10 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 			return nr_entries;
 	}
 
-	/* PME, hotplug and bandwidth notification share an MSI/MSI-X vector */
-	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP |
-		    PCIE_PORT_SERVICE_BWNOTIF)) {
-		pcie_irq = pci_irq_vector(dev, pme);
-		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pcie_irq;
-		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pcie_irq;
-		irqs[PCIE_PORT_SERVICE_BWNOTIF_SHIFT] = pcie_irq;
+	/* PME and hotplug share an MSI/MSI-X vector */
+	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
+		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, pme);
+		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, pme);
 	}
 
 	if (mask & PCIE_PORT_SERVICE_AER)
@@ -253,10 +250,6 @@ static int get_port_device_capability(struct pci_dev *dev)
 	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER)
 		services |= PCIE_PORT_SERVICE_DPC;
 
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
-	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
-		services |= PCIE_PORT_SERVICE_BWNOTIF;
-
 	return services;
 }
 
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 0a87091a0800..99d2abe88d0b 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -240,7 +240,6 @@ static void __init pcie_init_services(void)
 	pcie_pme_init();
 	pcie_dpc_init();
 	pcie_hp_init();
-	pcie_bandwidth_notification_init();
 }
 
 static int __init pcie_portdrv_init(void)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7e12d0163863..2ec0df04e0dc 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2388,7 +2388,7 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	return dev;
 }
 
-void pcie_report_downtraining(struct pci_dev *dev)
+static void pcie_report_downtraining(struct pci_dev *dev)
 {
 	if (!pci_is_pcie(dev))
 		return;
-- 
2.21.0.593.g511ec345e18-goog

