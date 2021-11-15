Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92976451D7A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 01:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344361AbhKPAaY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 19:30:24 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:51533 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238741AbhKOTap (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 14:30:45 -0500
X-Greylist: delayed 133501 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Nov 2021 14:30:45 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 5AAA8100E416C;
        Mon, 15 Nov 2021 20:27:23 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3AC132ED5FD; Mon, 15 Nov 2021 20:27:23 +0100 (CET)
Date:   Mon, 15 Nov 2021 20:27:23 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Bao, Joseph" <joseph.bao@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>, kw@linux.com
Subject: Re: HW power fault defect cause system hang on kernel 5.4.y
Message-ID: <20211115192723.GA19161@wunner.de>
References: <DM8PR11MB5702255A6A92F735D90A4446868B9@DM8PR11MB5702.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5702255A6A92F735D90A4446868B9@DM8PR11MB5702.namprd11.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 02, 2021 at 03:45:00AM +0000, Bao, Joseph wrote:
> Recently we encounter system hang (dead spinlock) when move to kernel
> linux-5.4.y. 
> 
> Finally, we use bisect to locate the suspicious commit https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=4667358dab9cc07da044d5bc087065545b1000df.
> 
> Our system has some HW defect, which will wrongly set PCI_EXP_SLTSTA_PFD
> high, and this commit will lead to infinite loop jumping to read_status
> (no chance to clear status PCI_EXP_SLTSTA_PFD bit since ctrl is not
> updated), I know this is our HW defect, but this commit makes kernel
> trapped in this isr function and leads to kernel hang (then the user
> could not get useful information to show what's wrong), which I think
> is not expected behavior, so I would like to report to you for discussion.

Thanks a lot for the report and apologies for the breakage and the delay.
Below please find a tentative fix.  Could you test whether it fixes the
issue?

I don't think this is a hardware defect.  If I'm reading the spec right
(PCIe r5.0, sec. 6.7.1.8), the PFD bit is meant to remain set and cannot
be cleared until the kernel disables slot power.

When a power fault happens, we currently only change the LEDs (Power
Indicator Off, Attention Indicator On) and emit a log message.
We otherwise leave the slot as is, even though I'd assume that the
PCI device in the slot is no longer accessible.

I'm wondering whether we should interpret a power fault as surprise
removal.  Alternatively, we could attempt recovery, i.e. turn slot
power off and back on.  Similar to what we're doing when an Uncorrectable
Error occurs.  Do you have an opinion on that?  What would be the
desired behavior for your users?

Thanks,

Lukas

-- >8 --

Subject: [PATCH] PCI: pciehp: Fix infinite loop in IRQ handler upon power
 fault

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
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.19+
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 6ac5ea5..fac6b8e 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -640,6 +640,8 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	 */
 	if (ctrl->power_fault_detected)
 		status &= ~PCI_EXP_SLTSTA_PFD;
+	else if (status & PCI_EXP_SLTSTA_PFD)
+		ctrl->power_fault_detected = true;
 
 	events |= status;
 	if (!events) {
@@ -649,7 +651,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	}
 
 	if (status) {
-		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
+		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, status);
 
 		/*
 		 * In MSI mode, all event bits must be zero before the port
@@ -723,8 +725,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
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

