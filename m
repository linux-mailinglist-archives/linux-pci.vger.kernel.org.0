Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D845845508E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 23:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241377AbhKQWfM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 17:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241302AbhKQWfI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 17:35:08 -0500
X-Greylist: delayed 593 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 Nov 2021 14:32:08 PST
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B09C061764
        for <linux-pci@vger.kernel.org>; Wed, 17 Nov 2021 14:32:07 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 1BAFF101920DB;
        Wed, 17 Nov 2021 23:22:13 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id E6BF963330BA;
        Wed, 17 Nov 2021 23:22:12 +0100 (CET)
X-Mailbox-Line: From 66eaeef31d4997ceea357ad93259f290ededecfd Mon Sep 17 00:00:00 2001
Message-Id: <66eaeef31d4997ceea357ad93259f290ededecfd.1637187226.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 17 Nov 2021 23:22:09 +0100
Subject: [PATCH] PCI: pciehp: Fix infinite loop in IRQ handler upon power
 fault
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Joseph Bao <joseph.bao@intel.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>, kw@linux.com,
        linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Power Fault Detected bit in the Slot Status register differs from
all other hotplug events in that it is sticky:  It can only be cleared
after turning off slot power.  Per PCIe r5.0, sec. 6.7.1.8:

  If a power controller detects a main power fault on the hot-plug slot,
  it must automatically set its internal main power fault latch [...].
  The main power fault latch is cleared when software turns off power to
  the hot-plug slot.

The stickiness used to cause interrupt storms and infinite loops which
were fixed in 2009 by commits 5651c48cfafe ("PCI pciehp: fix power fault
interrupt storm problem") and 99f0169c17f3 ("PCI: pciehp: enable
software notification on empty slots").

Unfortunately in 2020 the infinite loop issue was inadvertently
reintroduced by commit 8edf5332c393 ("PCI: pciehp: Fix MSI interrupt
race"):  The hardirq handler pciehp_isr() clears the PFD bit until
pciehp's power_fault_detected flag is set.  That happens in the IRQ
thread pciehp_ist(), which never learns of the event because the hardirq
handler is stuck in an infinite loop.  Fix by setting the
power_fault_detected flag already in the hardirq handler.

Fixes: 8edf5332c393 ("PCI: pciehp: Fix MSI interrupt race")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=214989
Link: https://lore.kernel.org/linux-pci/DM8PR11MB5702255A6A92F735D90A4446868B9@DM8PR11MB5702.namprd11.prod.outlook.com
Reported-by: Joseph Bao <joseph.bao@intel.com>
Tested-by: Joseph Bao <joseph.bao@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.19+
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 83a0fa119cae..9535c61cbff3 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -642,6 +642,8 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	 */
 	if (ctrl->power_fault_detected)
 		status &= ~PCI_EXP_SLTSTA_PFD;
+	else if (status & PCI_EXP_SLTSTA_PFD)
+		ctrl->power_fault_detected = true;
 
 	events |= status;
 	if (!events) {
@@ -651,7 +653,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	}
 
 	if (status) {
-		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
+		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, status);
 
 		/*
 		 * In MSI mode, all event bits must be zero before the port
@@ -725,8 +727,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	}
 
 	/* Check Power Fault Detected */
-	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
-		ctrl->power_fault_detected = 1;
+	if (events & PCI_EXP_SLTSTA_PFD) {
 		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(ctrl));
 		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
 				      PCI_EXP_SLTCTL_ATTN_IND_ON);
-- 
2.33.0

