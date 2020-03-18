Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D079C189AD5
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 12:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCRLjJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 07:39:09 -0400
Received: from mailout1.hostsharing.net ([83.223.95.204]:35583 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRLjJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Mar 2020 07:39:09 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Mar 2020 07:39:08 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 6006B10039B8E;
        Wed, 18 Mar 2020 12:33:15 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 00976608BC53;
        Wed, 18 Mar 2020 12:33:14 +0100 (CET)
X-Mailbox-Line: From cca1effa488065cb055120aa01b65719094bdcb5 Mon Sep 17 00:00:00 2001
Message-Id: <cca1effa488065cb055120aa01b65719094bdcb5.1584530321.git.lukas@wunner.de>
In-Reply-To: <DM5PR06MB313235E97731D97AB813F65D92FB0@DM5PR06MB3132.namprd06.prod.outlook.com>
References: <DM5PR06MB313235E97731D97AB813F65D92FB0@DM5PR06MB3132.namprd06.prod.outlook.com>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 18 Mar 2020 12:33:12 +0100
Subject: [PATCH] PCI: pciehp: Fix indefinite wait on sysfs requests
To:     Bjorn Helgaas <helgaas@kernel.org>,
        David Hoyer <David.Hoyer@netapp.com>
Cc:     Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

David Hoyer reports that powering pciehp slots up or down via sysfs may
hang:  The call to wait_event() in pciehp_sysfs_enable_slot() and
_disable_slot() does not return because ctrl->ist_running remains true.

This flag, which was introduced by commit 54ecb8f7028c ("PCI: pciehp:
Avoid returning prematurely from sysfs requests"), signifies that the
IRQ thread pciehp_ist() is running.  It is set to true at the top of
pciehp_ist() and reset to false at the end.  However there are two
additional return statements in pciehp_ist() before which the commit
neglected to reset the flag to false and wake up waiters for the flag.

That omission opens up the following race when powering up the slot:

* pciehp_ist() runs because a PCI_EXP_SLTSTA_PDC event was requested
  by pciehp_sysfs_enable_slot()

* pciehp_ist() turns on slot power via the following call stack:
  pciehp_handle_presence_or_link_change() -> pciehp_enable_slot() ->
  __pciehp_enable_slot() -> board_added() -> pciehp_power_on_slot()

* after slot power is turned on, the link comes up, resulting in a
  PCI_EXP_SLTSTA_DLLSC event

* the IRQ handler pciehp_isr() stores the event in ctrl->pending_events
  and returns IRQ_WAKE_THREAD

* the IRQ thread is already woken (it's bringing up the slot), but the
  genirq code remembers to re-run the IRQ thread after it has finished
  (such that it can deal with the new event) by setting IRQTF_RUNTHREAD
  via __handle_irq_event_percpu() -> __irq_wake_thread()

* the IRQ thread removes PCI_EXP_SLTSTA_DLLSC from ctrl->pending_events
  via board_added() -> pciehp_check_link_status() in order to deal with
  presence and link flaps per commit 6c35a1ac3da6 ("PCI: pciehp:
  Tolerate initially unstable link")

* after pciehp_ist() has successfully brought up the slot, it resets
  ctrl->ist_running to false and wakes up the sysfs requester

* the genirq code re-runs pciehp_ist(), which sets ctrl->ist_running
  to true but then returns with IRQ_NONE because ctrl->pending_events
  is empty

* pciehp_sysfs_enable_slot() is finally woken but notices that
  ctrl->ist_running is true, hence continues waiting

The only way to get the hung task going again is to trigger a hotplug
event which brings down the slot, e.g. by yanking out the card.

The same race exists when powering down the slot because remove_board()
likewise clears link or presence changes in ctrl->pending_events per
commit 3943af9d01e9 ("PCI: pciehp: Ignore Link State Changes after
powering off a slot") and thereby may cause a re-run of pciehp_ist()
which returns with IRQ_NONE without resetting ctrl->ist_running to false.

Fix by adding a goto label before the teardown steps at the end of
pciehp_ist() and jumping to that label from the two return statements
which currently neglect to reset the ctrl->ist_running flag.

Fixes: 54ecb8f7028c ("PCI: pciehp: Avoid returning prematurely from sysfs requests")
Reported-by: David Hoyer <David.Hoyer@netapp.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.19+
Cc: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/hotplug/pciehp_hpc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index e4627c68b30f..5f1a27bfcb19 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -663,17 +663,15 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	if (atomic_fetch_and(~RERUN_ISR, &ctrl->pending_events) & RERUN_ISR) {
 		ret = pciehp_isr(irq, dev_id);
 		enable_irq(irq);
-		if (ret != IRQ_WAKE_THREAD) {
-			pci_config_pm_runtime_put(pdev);
-			return ret;
-		}
+		if (ret != IRQ_WAKE_THREAD)
+			goto out;
 	}
 
 	synchronize_hardirq(irq);
 	events = atomic_xchg(&ctrl->pending_events, 0);
 	if (!events) {
-		pci_config_pm_runtime_put(pdev);
-		return IRQ_NONE;
+		ret = IRQ_NONE;
+		goto out;
 	}
 
 	/* Check Attention Button Pressed */
@@ -702,10 +700,12 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 		pciehp_handle_presence_or_link_change(ctrl, events);
 	up_read(&ctrl->reset_lock);
 
+	ret = IRQ_HANDLED;
+out:
 	pci_config_pm_runtime_put(pdev);
 	ctrl->ist_running = false;
 	wake_up(&ctrl->requester);
-	return IRQ_HANDLED;
+	return ret;
 }
 
 static int pciehp_poll(void *data)
-- 
2.25.0

