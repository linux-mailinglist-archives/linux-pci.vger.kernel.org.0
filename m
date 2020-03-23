Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB9A18F691
	for <lists+linux-pci@lfdr.de>; Mon, 23 Mar 2020 15:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgCWOKT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 10:10:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41496 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgCWOKS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Mar 2020 10:10:18 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jGNmD-0008KI-Na; Mon, 23 Mar 2020 15:10:02 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B7B181040AA; Mon, 23 Mar 2020 15:10:00 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>, x86@kernel.org
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Evan Green <evgreen@chromium.org>,
        "Ghorai\, Sukumar" <sukumar.ghorai@intel.com>,
        "Amara\, Madhusudanarao" <madhusudanarao.amara@intel.com>,
        "Nandamuri\, Srikanth" <srikanth.nandamuri@intel.com>
Subject: Re: MSI interrupt for xhci still lost on 5.6-rc6 after cpu hotplug
In-Reply-To: <b9fbd55a-7f97-088d-2cc2-4e4ea86d9440@linux.intel.com>
References: <806c51fa-992b-33ac-61a9-00a606f82edb@linux.intel.com> <87d0974akk.fsf@nanos.tec.linutronix.de> <b9fbd55a-7f97-088d-2cc2-4e4ea86d9440@linux.intel.com>
Date:   Mon, 23 Mar 2020 15:10:00 +0100
Message-ID: <87r1xjp3gn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Mathias,

Mathias Nyman <mathias.nyman@linux.intel.com> writes:
> Full function trace with patch is huge, can be found compressed at
>
> This time xhci interrupts stopped after
> migration/3-24    [003] d..1    48.530271: msi_set_affinity: twostep update msi, irq 122, vector 33 -> 34, apicid: 6 -> 4

thanks for providing the data. I think I decoded the issue. Can you
please test the patch below?

Thanks,

        tglx
----
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 159bd0cb8548..49aec92fa35b 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -63,12 +63,13 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
 {
 	struct irq_cfg old_cfg, *cfg = irqd_cfg(irqd);
 	struct irq_data *parent = irqd->parent_data;
-	unsigned int cpu;
+	unsigned int cpu, old_vector;
 	int ret;
 
 	/* Save the current configuration */
 	cpu = cpumask_first(irq_data_get_effective_affinity_mask(irqd));
 	old_cfg = *cfg;
+	old_vector = old_cfg.vector;
 
 	/* Allocate a new target vector */
 	ret = parent->chip->irq_set_affinity(parent, mask, force);
@@ -90,10 +91,10 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
 	 */
 	if (!irqd_msi_nomask_quirk(irqd) ||
 	    cfg->vector == old_cfg.vector ||
-	    old_cfg.vector == MANAGED_IRQ_SHUTDOWN_VECTOR ||
+	    old_vector == MANAGED_IRQ_SHUTDOWN_VECTOR ||
 	    cfg->dest_apicid == old_cfg.dest_apicid) {
 		irq_msi_update_msg(irqd, cfg);
-		return ret;
+		goto check_old;
 	}
 
 	/*
@@ -102,7 +103,7 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
 	 */
 	if (WARN_ON_ONCE(cpu != smp_processor_id())) {
 		irq_msi_update_msg(irqd, cfg);
-		return ret;
+		goto check_old;
 	}
 
 	/*
@@ -163,6 +164,11 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
 	if (lapic_vector_set_in_irr(cfg->vector))
 		irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);
 
+check_old:
+	if (!in_irq() && old_vector != MANAGED_IRQ_SHUTDOWN_VECTOR &&
+	    irqd_msi_nomask_quirk(irqd) && lapic_vector_set_in_irr(old_vector))
+		irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);
+
 	return ret;
 }
 
