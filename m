Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2FA17BDC4
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 14:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgCFNIr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 08:08:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53326 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgCFNIp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2020 08:08:45 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jACiX-0003g0-8l; Fri, 06 Mar 2020 14:08:41 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 8ECE8104085;
        Fri,  6 Mar 2020 14:08:39 +0100 (CET)
Message-Id: <20200306130624.098374457@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 06 Mar 2020 14:03:48 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [patch 7/7] PCI/AER: Fix the broken interrupt injection
References: <20200306130341.199467200@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The AER error injection mechanism just blindly abuses generic_handle_irq()
which is really not meant for consumption by random drivers. The include of
linux/irq.h should have been a red flag in the first place. Driver code,
unless implementing interrupt chips or low level hypervisor functionality
has absolutely no business with that.

Invoking generic_handle_irq() from non interrupt handling context can have
nasty side effects at least on x86 due to the hardware trainwreck which
makes interrupt affinity changes a fragile beast. Sathyanarayanan triggered
a NULL pointer dereference in the low level APIC code that way. While the
particular pointer could be checked this would only paper over the issue
because there are other ways to trigger warnings or silently corrupt state.

Invoke the new irq_inject_interrupt() mechanism, which has the necessary
sanity checks in place and injects the interrupt via the irq_retrigger()
mechanism, which is at least halfways safe vs. the fragile x86 affinity
change mechanics.

It's safe on x86 as it does not corrupt state, but it still can cause a
premature completion of an interrupt affinity change causing the interrupt
line to become stale. Very unlikely, but possible.

For regular operations this is a non issue as AER error injection is meant
for debugging and testing and not for usage on production systems. People
using this should better know what they are doing.

Fixes: 390e2db82480 ("PCI/AER: Abstract AER interrupt handling")
Reported-by: sathyanarayanan.kuppuswamy@linux.intel.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/pcie/Kconfig      |    1 +
 drivers/pci/pcie/aer_inject.c |    6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -34,6 +34,7 @@ config PCIEAER
 config PCIEAER_INJECT
 	tristate "PCI Express error injection support"
 	depends on PCIEAER
+	select GENERIC_IRQ_INJECTION
 	help
 	  This enables PCI Express Root Port Advanced Error Reporting
 	  (AER) software error injector.
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -16,7 +16,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/irq.h>
+#include <linux/interrupt.h>
 #include <linux/miscdevice.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -468,9 +468,7 @@ static int aer_inject(struct aer_error_i
 		}
 		pci_info(edev->port, "Injecting errors %08x/%08x into device %s\n",
 			 einj->cor_status, einj->uncor_status, pci_name(dev));
-		local_irq_disable();
-		generic_handle_irq(edev->irq);
-		local_irq_enable();
+		ret = irq_inject_interrupt(edev->irq);
 	} else {
 		pci_err(rpdev, "AER device not found\n");
 		ret = -ENODEV;

