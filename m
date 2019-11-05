Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7BFEFB44
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 11:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388465AbfKEKc0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 05:32:26 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44247 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388583AbfKEKcY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2019 05:32:24 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 31dc8ebde46860d1; Tue, 5 Nov 2019 11:32:21 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] PCI: PM: Avoid exporting __pci_complete_power_transition()
Date:   Tue, 05 Nov 2019 11:30:36 +0100
Message-ID: <1731661.ykamz2Tiuf@kreacher>
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

Notice that radeon_set_suspend(), which is the only caller of
__pci_complete_power_transition() outside of pci.c, really only
cares about the pci_platform_power_transition() invoked by it,
so export the latter instead of it, update the radeon driver to
call pci_platform_power_transition() directly and make
__pci_complete_power_transition() static.

Code rearrangement, no intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c                   |    6 +++---
 drivers/video/fbdev/aty/radeon_pm.c |    2 +-
 include/linux/pci.h                 |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -963,7 +963,7 @@ void pci_refresh_power_state(struct pci_
  * @dev: PCI device to handle.
  * @state: State to put the device into.
  */
-static int pci_platform_power_transition(struct pci_dev *dev, pci_power_t state)
+int pci_platform_power_transition(struct pci_dev *dev, pci_power_t state)
 {
 	int error;
 
@@ -979,6 +979,7 @@ static int pci_platform_power_transition
 
 	return error;
 }
+EXPORT_SYMBOL_GPL(pci_platform_power_transition);
 
 /**
  * pci_wakeup - Wake up a PCI device
@@ -1061,7 +1062,7 @@ void pci_bus_set_current_state(struct pc
  *
  * This function should not be called directly by device drivers.
  */
-int __pci_complete_power_transition(struct pci_dev *dev, pci_power_t state)
+static int __pci_complete_power_transition(struct pci_dev *dev, pci_power_t state)
 {
 	int ret;
 
@@ -1073,7 +1074,6 @@ int __pci_complete_power_transition(stru
 		pci_bus_set_current_state(dev->subordinate, PCI_D3cold);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(__pci_complete_power_transition);
 
 /**
  * pci_set_power_state - Set the power state of a PCI device
Index: linux-pm/drivers/video/fbdev/aty/radeon_pm.c
===================================================================
--- linux-pm.orig/drivers/video/fbdev/aty/radeon_pm.c
+++ linux-pm/drivers/video/fbdev/aty/radeon_pm.c
@@ -2593,7 +2593,7 @@ static void radeon_set_suspend(struct ra
 		 * calling pci_set_power_state()
 		 */
 		radeonfb_whack_power_state(rinfo, PCI_D2);
-		__pci_complete_power_transition(rinfo->pdev, PCI_D2);
+		pci_platform_power_transition(rinfo->pdev, PCI_D2);
 	} else {
 		printk(KERN_DEBUG "radeonfb (%s): switching to D0 state...\n",
 		       pci_name(rinfo->pdev));
Index: linux-pm/include/linux/pci.h
===================================================================
--- linux-pm.orig/include/linux/pci.h
+++ linux-pm/include/linux/pci.h
@@ -1232,7 +1232,7 @@ struct pci_cap_saved_state *pci_find_sav
 int pci_add_cap_save_buffer(struct pci_dev *dev, char cap, unsigned int size);
 int pci_add_ext_cap_save_buffer(struct pci_dev *dev,
 				u16 cap, unsigned int size);
-int __pci_complete_power_transition(struct pci_dev *dev, pci_power_t state);
+int pci_platform_power_transition(struct pci_dev *dev, pci_power_t state);
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
 pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state);
 bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);



