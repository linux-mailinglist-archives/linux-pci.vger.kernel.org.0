Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 799D2156C61
	for <lists+linux-pci@lfdr.de>; Sun,  9 Feb 2020 21:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbgBIUZQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Feb 2020 15:25:16 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:54433 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbgBIUZP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Feb 2020 15:25:15 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 064102800BB92;
        Sun,  9 Feb 2020 21:25:13 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id BF09A14BAA7; Sun,  9 Feb 2020 21:25:12 +0100 (CET)
Date:   Sun, 9 Feb 2020 21:25:12 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Keith Busch <kbusch@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, narendra_k@dell.com
Subject: Re: [PATCH v3] PCI: pciehp: Make sure pciehp_isr clears interrupt
 events
Message-ID: <20200209202512.rzaqoc7tydo2ouog@wunner.de>
References: <20200207195450.52026-1-stuart.w.hayes@gmail.com>
 <20200209150328.2x2zumhqbs6fihmc@wunner.de>
 <20200209180722.ikuyjignnd7ddfp5@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200209180722.ikuyjignnd7ddfp5@wunner.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 09, 2020 at 07:07:22PM +0100, Lukas Wunner wrote:
> Actually, scratch that.  After thinking about this problem for a day
> I've come up with a much simpler and more elegant solution.  Could you
> test if the below works for you?

Sorry, I missed a few things:

* pm_runtime_put() is called too often in the MSI case.
* If only the CC bit is set or if ignore_hotplug is set, the function
  may return prematurely without re-reading the Slot Status register.
* Returning IRQ_NONE in the MSI case even though the IRQ thread was woken
  may incorrectly signal a spurious interrupt to the genirq code.
  It's better to return IRQ_HANDLED instead.

Below is another attempt.  I'll have to take a look at this with a
fresh pair of eyeballs though to verify I haven't overlooked anything
else and also to determine if this is actually simpler than Stuart's
approach.  Again, the advantage here is that processing of the events
by the IRQ thread is sped up by not delaying it until the Slot Status
register has settled.

Thanks.

-- >8 --
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index c3e3f53..db5baa5 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -530,6 +530,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	struct controller *ctrl = (struct controller *)dev_id;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	struct device *parent = pdev->dev.parent;
+	irqreturn_t ret = IRQ_NONE;
 	u16 status, events;
 
 	/*
@@ -553,6 +554,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 		}
 	}
 
+read_status:
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
 	if (status == (u16) ~0) {
 		ctrl_info(ctrl, "%s: no response from device\n", __func__);
@@ -579,13 +581,11 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	if (!events) {
 		if (parent)
 			pm_runtime_put(parent);
-		return IRQ_NONE;
+		return ret;
 	}
 
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
 	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
-	if (parent)
-		pm_runtime_put(parent);
 
 	/*
 	 * Command Completed notifications are not deferred to the
@@ -595,21 +595,33 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 		ctrl->cmd_busy = 0;
 		smp_mb();
 		wake_up(&ctrl->queue);
-
-		if (events == PCI_EXP_SLTSTA_CC)
-			return IRQ_HANDLED;
-
 		events &= ~PCI_EXP_SLTSTA_CC;
 	}
 
 	if (pdev->ignore_hotplug) {
 		ctrl_dbg(ctrl, "ignoring hotplug event %#06x\n", events);
-		return IRQ_HANDLED;
+		events = 0;
 	}
 
 	/* Save pending events for consumption by IRQ thread. */
 	atomic_or(events, &ctrl->pending_events);
-	return IRQ_WAKE_THREAD;
+
+	/*
+	 * In MSI mode, all event bits must be zero before the port will send
+	 * a new interrupt (PCIe Base Spec r5.0 sec 6.7.3.4).  So re-read the
+	 * Slot Status register in case a bit was set between read and write.
+	 */
+	if (pci_dev_msi_enabled(pdev) && !pciehp_poll_mode) {
+		irq_wake_thread(irq, ctrl);
+		ret = IRQ_HANDLED;
+		goto read_status;
+	}
+
+	if (parent)
+		pm_runtime_put(parent);
+	if (events)
+		return IRQ_WAKE_THREAD;
+	return IRQ_HANDLED;
 }
 
 static irqreturn_t pciehp_ist(int irq, void *dev_id)
