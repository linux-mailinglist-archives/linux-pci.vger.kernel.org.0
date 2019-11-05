Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFFAEEFB4F
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 11:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388707AbfKEKc3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 05:32:29 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43855 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388700AbfKEKc3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2019 05:32:29 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 6bc7cd40211169eb; Tue, 5 Nov 2019 11:32:27 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 3/5] PCI: PM: Fold __pci_start_power_transition() into its caller
Date:   Tue, 05 Nov 2019 11:29:16 +0100
Message-ID: <3458080.lsoDbfkST9@kreacher>
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

Because pci_power_up() has become the only caller of
__pci_start_power_transition(), there is no need for the latter to
be a separate function any more, so fold it into the former, drop a
redundant check and reduce the number of lines of code somewhat.

Code rearrangement, no intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c |   48 ++++++++++++++++++------------------------------
 1 file changed, 18 insertions(+), 30 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1003,42 +1003,30 @@ void pci_wakeup_bus(struct pci_bus *bus)
 }
 
 /**
- * __pci_start_power_transition - Start power transition of a PCI device
- * @dev: PCI device to handle.
- * @state: State to put the device into.
+ * pci_power_up - Put the given device into D0
+ * @dev: PCI device to power up
  */
-static void __pci_start_power_transition(struct pci_dev *dev, pci_power_t state)
+int pci_power_up(struct pci_dev *dev)
 {
-	if (state == PCI_D0) {
-		pci_platform_power_transition(dev, PCI_D0);
+	pci_platform_power_transition(dev, PCI_D0);
+
+	/*
+	 * Mandatory power management transition delays, see PCI Express Base
+	 * Specification Revision 2.0 Section 6.6.1: Conventional Reset.  Do not
+	 * delay for devices powered on/off by corresponding bridge, because
+	 * have already delayed for the bridge.
+	 */
+	if (dev->runtime_d3cold) {
+		if (dev->d3cold_delay && !dev->imm_ready)
+			msleep(dev->d3cold_delay);
 		/*
-		 * Mandatory power management transition delays, see
-		 * PCI Express Base Specification Revision 2.0 Section
-		 * 6.6.1: Conventional Reset.  Do not delay for
-		 * devices powered on/off by corresponding bridge,
-		 * because have already delayed for the bridge.
+		 * When powering on a bridge from D3cold, the whole hierarchy
+		 * may be powered on into D0uninitialized state, resume them to
+		 * give them a chance to suspend again
 		 */
-		if (dev->runtime_d3cold) {
-			if (dev->d3cold_delay && !dev->imm_ready)
-				msleep(dev->d3cold_delay);
-			/*
-			 * When powering on a bridge from D3cold, the
-			 * whole hierarchy may be powered on into
-			 * D0uninitialized state, resume them to give
-			 * them a chance to suspend again
-			 */
-			pci_wakeup_bus(dev->subordinate);
-		}
+		pci_wakeup_bus(dev->subordinate);
 	}
-}
 
-/**
- * pci_power_up - Put the given device into D0
- * @dev: PCI device to power up
- */
-int pci_power_up(struct pci_dev *dev)
-{
-	__pci_start_power_transition(dev, PCI_D0);
 	return pci_raw_set_power_state(dev, PCI_D0);
 }
 



