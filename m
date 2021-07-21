Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6D43D171A
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 21:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbhGUSrx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 14:47:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49056 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240246AbhGUSrw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jul 2021 14:47:52 -0400
Message-Id: <20210721192650.867877313@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626895707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5qrlEv3rvmev48WbnJCr7JBARBHjEzrTBEeyqZzyuic=;
        b=BkzKRIYsmCo9nDvtb5bf00bT+AO8kSlr8bXjrysAyaBwRtFcHOYXMe4f+hLHwtwjNkpKSm
        UIpKxaV6OpbNIbNMZ89PFzXP6/o6nHMsJGQtS/Vq1vsc0uM25GA3j8nmClrjdnpEREjsPW
        3tTUtBSv46HCaw0cQMEsvpTNc/e6ld9JG2lcxRtnncqUp8RoykanDI/diO+sNkgGEyxUB4
        Dh+YnE7GWQHSDeazJHPfnH9s1zJMMFnT0Qwm/xvXP2ZHUjy64ZMo/PT4xrkRdQgmU0AxWZ
        rUzw+dBdPh/DzqaL2GkQyWiydf6h3HPNgkCB7o/rmzP4y+J8ASV1j7s1xbaD3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626895707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5qrlEv3rvmev48WbnJCr7JBARBHjEzrTBEeyqZzyuic=;
        b=j+Plk8DTQ1tF2yqN0XdqRI0R18BoLcNcHr8753Q4wcT2AKGUNOgI8SpzhDqTm86CVjHf5s
        NXfErO75q0V+ozDg==
Date:   Wed, 21 Jul 2021 21:11:34 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Subject: [patch 8/8] x86/msi: Force affinity setup before startup
References: <20210721191126.274946280@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The X86 MSI mechanism cannot handle interrupt affinity changes safely after
startup other than from an interrupt handler, unless interrupt remapping is
enabled. The startup sequence in the generic interrupt code violates that
assumption.

Mark the irq chips with the new IRQCHIP_AFFINITY_PRE_STARTUP flag so that
the default interrupt setting happens before the interrupt is started up
for the first time.

While the interrupt remapping MSI chip does not require this, there is no
point in treating it differently as this might spare an interrupt to a CPU
which is not in the default affinity mask.

For the non-remapping case go to the direct write path when the interrupt
is not yet started similar to the not yet activated case.

Fixes: 18404756765c ("genirq: Expose default irq affinity mask (take 3)")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/msi.c |   11 ++++++++---
 arch/x86/kernel/hpet.c     |    2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -58,11 +58,13 @@ msi_set_affinity(struct irq_data *irqd,
 	 *   The quirk bit is not set in this case.
 	 * - The new vector is the same as the old vector
 	 * - The old vector is MANAGED_IRQ_SHUTDOWN_VECTOR (interrupt starts up)
+	 * - The interrupt is not yet started up
 	 * - The new destination CPU is the same as the old destination CPU
 	 */
 	if (!irqd_msi_nomask_quirk(irqd) ||
 	    cfg->vector == old_cfg.vector ||
 	    old_cfg.vector == MANAGED_IRQ_SHUTDOWN_VECTOR ||
+	    !irqd_is_started(irqd) ||
 	    cfg->dest_apicid == old_cfg.dest_apicid) {
 		irq_msi_update_msg(irqd, cfg);
 		return ret;
@@ -150,7 +152,8 @@ static struct irq_chip pci_msi_controlle
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_affinity	= msi_set_affinity,
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.flags			= IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
@@ -219,7 +222,8 @@ static struct irq_chip pci_msi_ir_contro
 	.irq_mask		= pci_msi_mask_irq,
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.flags			= IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
 static struct msi_domain_info pci_msi_ir_domain_info = {
@@ -273,7 +277,8 @@ static struct irq_chip dmar_msi_controll
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_compose_msi_msg	= dmar_msi_compose_msg,
 	.irq_write_msi_msg	= dmar_msi_write_msg,
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.flags			= IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
 static int dmar_msi_init(struct irq_domain *domain,
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -508,7 +508,7 @@ static struct irq_chip hpet_msi_controll
 	.irq_set_affinity = msi_domain_set_affinity,
 	.irq_retrigger = irq_chip_retrigger_hierarchy,
 	.irq_write_msi_msg = hpet_msi_write_msg,
-	.flags = IRQCHIP_SKIP_SET_WAKE,
+	.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
 static int hpet_msi_init(struct irq_domain *domain,

