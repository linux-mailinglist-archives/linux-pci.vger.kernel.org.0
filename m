Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04CB6EFB4D
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 11:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388663AbfKEKcX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 05:32:23 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63694 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388465AbfKEKcX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2019 05:32:23 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id fa89029b01134efa; Tue, 5 Nov 2019 11:32:21 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 5/5] PCI: PM: Fold __pci_complete_power_transition() into its caller
Date:   Tue, 05 Nov 2019 11:32:02 +0100
Message-ID: <1769241.yKxyosiRnQ@kreacher>
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

Because pci_set_power_state() has become the only caller of
__pci_complete_power_transition(), there is no need for the latter to
be a separate function any more, so fold it into the former, drop a
redundant check and reduce the number of lines of code somewhat.

Code rearrangement, no intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c |   30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1056,26 +1056,6 @@ void pci_bus_set_current_state(struct pc
 }
 
 /**
- * __pci_complete_power_transition - Complete power transition of a PCI device
- * @dev: PCI device to handle.
- * @state: State to put the device into.
- *
- * This function should not be called directly by device drivers.
- */
-static int __pci_complete_power_transition(struct pci_dev *dev, pci_power_t state)
-{
-	int ret;
-
-	if (state <= PCI_D0)
-		return -EINVAL;
-	ret = pci_platform_power_transition(dev, state);
-	/* Power off the bridge may power off the whole hierarchy */
-	if (!ret && state == PCI_D3cold)
-		pci_bus_set_current_state(dev->subordinate, PCI_D3cold);
-	return ret;
-}
-
-/**
  * pci_set_power_state - Set the power state of a PCI device
  * @dev: PCI device to handle.
  * @state: PCI power state (D0, D1, D2, D3hot) to put the device into.
@@ -1094,7 +1074,7 @@ static int __pci_complete_power_transiti
  */
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
-	int error;
+	int error, ret;
 
 	/* Bound the state we're entering */
 	if (state > PCI_D3cold)
@@ -1132,10 +1112,12 @@ int pci_set_power_state(struct pci_dev *
 	error = pci_raw_set_power_state(dev, state > PCI_D3hot ?
 					PCI_D3hot : state);
 
-	if (!__pci_complete_power_transition(dev, state))
-		error = 0;
+	ret = pci_platform_power_transition(dev, state);
+	/* Powering off a bridge may power off the whole hierarchy */
+	if (!ret && state == PCI_D3cold)
+		pci_bus_set_current_state(dev->subordinate, PCI_D3cold);
 
-	return error;
+	return ret ? error : 0;
 }
 EXPORT_SYMBOL(pci_set_power_state);
 



