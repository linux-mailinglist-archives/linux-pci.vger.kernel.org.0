Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 124BEEFB48
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 11:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388729AbfKEKcb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 05:32:31 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63627 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388583AbfKEKca (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2019 05:32:30 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 647da8bd74dd8b11; Tue, 5 Nov 2019 11:32:27 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/5] PCI: PM: Use pci_power_up() in pci_set_power_state()
Date:   Tue, 05 Nov 2019 11:27:49 +0100
Message-ID: <2520019.OZ1nXS5aSj@kreacher>
In-Reply-To: <2771503.n70vfTtcVb@kreacher>
References: <2771503.n70vfTtcVb@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make it explicitly clear that the code to put devices into D0 in
pci_set_power_state() and in pci_pm_default_resume_early() is the
same by making the latter use pci_power_up() for transitions into
D0.

Code rearrangement, no intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is on top of https://patchwork.kernel.org/patch/11223673/

---
 drivers/pci/pci.c |   25 +++++++++++++------------
 drivers/pci/pci.h |    2 +-
 2 files changed, 14 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1033,6 +1033,16 @@ static void __pci_start_power_transition
 }
 
 /**
+ * pci_power_up - Put the given device into D0
+ * @dev: PCI device to power up
+ */
+int pci_power_up(struct pci_dev *dev)
+{
+	__pci_start_power_transition(dev, PCI_D0);
+	return pci_raw_set_power_state(dev, PCI_D0);
+}
+
+/**
  * __pci_dev_set_current_state - Set current state of a PCI device
  * @dev: Device to handle
  * @data: pointer to state to be set
@@ -1117,6 +1127,9 @@ int pci_set_power_state(struct pci_dev *
 	if (dev->current_state == state)
 		return 0;
 
+	if (state == PCI_D0)
+		return pci_power_up(dev);
+
 	/*
 	 * This device is quirked not to be put into D3, so don't put it in
 	 * D3
@@ -1124,8 +1137,6 @@ int pci_set_power_state(struct pci_dev *
 	if (state >= PCI_D3hot && (dev->dev_flags & PCI_DEV_FLAGS_NO_D3))
 		return 0;
 
-	__pci_start_power_transition(dev, state);
-
 	/*
 	 * To put device in D3cold, we put device into D3hot in native
 	 * way, then put device into D3cold with platform ops
@@ -1141,16 +1152,6 @@ int pci_set_power_state(struct pci_dev *
 EXPORT_SYMBOL(pci_set_power_state);
 
 /**
- * pci_power_up - Put the given device into D0 forcibly
- * @dev: PCI device to power up
- */
-void pci_power_up(struct pci_dev *dev)
-{
-	__pci_start_power_transition(dev, PCI_D0);
-	pci_raw_set_power_state(dev, PCI_D0);
-}
-
-/**
  * pci_choose_state - Choose the power state of a PCI device
  * @dev: PCI device to be suspended
  * @state: target sleep state for the whole system. This is the value
Index: linux-pm/drivers/pci/pci.h
===================================================================
--- linux-pm.orig/drivers/pci/pci.h
+++ linux-pm/drivers/pci/pci.h
@@ -85,7 +85,7 @@ struct pci_platform_pm_ops {
 int pci_set_platform_pm(const struct pci_platform_pm_ops *ops);
 void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
 void pci_refresh_power_state(struct pci_dev *dev);
-void pci_power_up(struct pci_dev *dev);
+int pci_power_up(struct pci_dev *dev);
 void pci_disable_enabled_device(struct pci_dev *dev);
 int pci_finish_runtime_suspend(struct pci_dev *dev);
 void pcie_clear_root_pme_status(struct pci_dev *dev);



