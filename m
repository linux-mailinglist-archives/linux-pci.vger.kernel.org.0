Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C172156BF9
	for <lists+linux-pci@lfdr.de>; Sun,  9 Feb 2020 19:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgBISHZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Feb 2020 13:07:25 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:42517 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbgBISHY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Feb 2020 13:07:24 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0296530002521;
        Sun,  9 Feb 2020 19:07:23 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CC881132E50; Sun,  9 Feb 2020 19:07:22 +0100 (CET)
Date:   Sun, 9 Feb 2020 19:07:22 +0100
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
Message-ID: <20200209180722.ikuyjignnd7ddfp5@wunner.de>
References: <20200207195450.52026-1-stuart.w.hayes@gmail.com>
 <20200209150328.2x2zumhqbs6fihmc@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200209150328.2x2zumhqbs6fihmc@wunner.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 09, 2020 at 04:03:28PM +0100, Lukas Wunner wrote:
> Using a for (;;) or do/while loop that you jump out of if
> (!status || !pci_dev_msi_enabled(pdev)) might be more readable
> than a goto, but I'm not sure.

Actually, scratch that.  After thinking about this problem for a day
I've come up with a much simpler and more elegant solution.  Could you
test if the below works for you?

This solution has the added benefit that the IRQ thread is started up
once the first event bits have been collected.  If more event bits are
found in the additional loop iterations, they're added to the collected
event bits and the IRQ thread will pick them up asynchronously.  Once no
more bits are found, the hardirq handler exits with IRQ_NONE.  This means
that the genirq code won't wake the IRQ thread but that doesn't matter
because the ISR has already done that itself.  Should also work correctly
in poll mode and the behavior in INTx mode should be as before.

-- >8 --
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index c3e3f53..707324d 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -553,6 +553,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 		}
 	}
 
+read_status:
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
 	if (status == (u16) ~0) {
 		ctrl_info(ctrl, "%s: no response from device\n", __func__);
@@ -609,6 +610,17 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 
 	/* Save pending events for consumption by IRQ thread. */
 	atomic_or(events, &ctrl->pending_events);
+
+	/*
+	 * In MSI mode, all event bits must be zero before the port will send
+	 * a new interrupt (PCIe Base Spec r5.0 sec 6.7.3.4).  So re-read the
+	 * Slot Status register in case a bit was set between read and write.
+	 */
+	if (pci_dev_msi_enabled(pdev) && !pciehp_poll_mode) {
+		irq_wake_thread(irq, ctrl);
+		goto read_status;
+	}
+
 	return IRQ_WAKE_THREAD;
 }
 
