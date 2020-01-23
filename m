Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBD3147090
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2020 19:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgAWSRB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jan 2020 13:17:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40736 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgAWSRA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2020 13:17:00 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iuh2G-0005bq-TU; Thu, 23 Jan 2020 19:16:57 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 3292F101623; Thu, 23 Jan 2020 19:16:56 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Evan Green <evgreen@chromium.org>, Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
In-Reply-To: <87y2tytv5i.fsf@nanos.tec.linutronix.de>
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid> <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com> <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com> <87y2tytv5i.fsf@nanos.tec.linutronix.de>
Date:   Thu, 23 Jan 2020 19:16:56 +0100
Message-ID: <87eevqkpgn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Evan,

Thomas Gleixner <tglx@linutronix.de> writes:
> This is not yet debugged fully and as this is happening on MSI-X I'm not
> really convinced yet that your 'torn write' theory holds.

can you please apply the debug patch below and run your test. When the
failure happens, stop the tracer and collect the trace.

Another question. Did you ever try to change the affinity of that
interrupt without hotplug rapidly while the device makes traffic? If
not, it would be interesting whether this leads to a failure as well.

Thanks

        tglx

8<---------------

--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -964,6 +964,8 @@ void irq_force_complete_move(struct irq_
 	if (!vector)
 		goto unlock;
 
+	trace_printk("IRQ %u vector %u irq inprogress %u\n", vector,
+		     irqd->irq, apicd->move_in_progress);
 	/*
 	 * This is tricky. If the cleanup of the old vector has not been
 	 * done yet, then the following setaffinity call will fail with
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -244,6 +244,8 @@ u64 arch_irq_stat(void)
 
 	desc = __this_cpu_read(vector_irq[vector]);
 	if (likely(!IS_ERR_OR_NULL(desc))) {
+		trace_printk("Handle vector %u IRQ %u\n", vector,
+			     desc->irq_data.irq);
 		if (IS_ENABLED(CONFIG_X86_32))
 			handle_irq(desc, regs);
 		else
@@ -252,10 +254,18 @@ u64 arch_irq_stat(void)
 		ack_APIC_irq();
 
 		if (desc == VECTOR_UNUSED) {
+			trace_printk("Handle unused vector %u\n", vector);
 			pr_emerg_ratelimited("%s: %d.%d No irq handler for vector\n",
 					     __func__, smp_processor_id(),
 					     vector);
 		} else {
+			if (desc == VECTOR_SHUTDOWN) {
+				trace_printk("Handle shutdown vector %u\n",
+					     vector);
+			} else if (desc == VECTOR_RETRIGGERED) {
+				trace_printk("Handle retriggered vector %u\n",
+					     vector);
+			}
 			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
 		}
 	}
@@ -373,9 +383,14 @@ void fixup_irqs(void)
 		if (IS_ERR_OR_NULL(__this_cpu_read(vector_irq[vector])))
 			continue;
 
+		desc = __this_cpu_read(vector_irq[vector]);
+		trace_printk("FIXUP: %u\n", desc->irq_data.irq);
+
 		irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
 		if (irr  & (1 << (vector % 32))) {
 			desc = __this_cpu_read(vector_irq[vector]);
+			trace_printk("FIXUP: %u IRR pending\n",
+				     desc->irq_data.irq);
 
 			raw_spin_lock(&desc->lock);
 			data = irq_desc_get_irq_data(desc);
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -122,6 +122,10 @@ static bool migrate_one_irq(struct irq_d
 		affinity = cpu_online_mask;
 		brokeaff = true;
 	}
+
+	trace_printk("IRQ: %d maskchip %d wasmasked %d break %d\n",
+		     d->irq, maskchip, irqd_irq_masked(d), brokeaff);
+
 	/*
 	 * Do not set the force argument of irq_do_set_affinity() as this
 	 * disables the masking of offline CPUs from the supplied affinity
