Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF792172913
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2020 20:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbgB0T7P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Feb 2020 14:59:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35203 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbgB0T7P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Feb 2020 14:59:15 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j7PJJ-0004HJ-3F; Thu, 27 Feb 2020 20:59:05 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E24DD1040A9; Thu, 27 Feb 2020 20:59:03 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 1/1] x86/apic/vector: Fix NULL pointer exception in irq_complete_move()
In-Reply-To: <f54208d62407901b5de15ce8c3d078c70fc7a1d0.1582313239.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <f54208d62407901b5de15ce8c3d078c70fc7a1d0.1582313239.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Thu, 27 Feb 2020 20:59:03 +0100
Message-ID: <87tv3bls3c.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

sathyanarayanan.kuppuswamy@linux.intel.com writes:
> If an IRQ is scheduled using generic_handle_irq() function in a non IRQ
> path, the irq_regs per CPU variable will not be set. Hence calling
> irq_complete_move() function in this scenario leads to NULL pointer
> de-reference exception. One example for this issue is, triggering fake
> AER errors using PCIe aer_inject framework. So add addition check for

What?

This is completely broken to begin with. You are fixing the wrong
end. The broken commit is:

390e2db82480 ("PCI/AER: Abstract AER interrupt handling")

I have to admit that it was already broken before that commit because
calling just the interrupt handler w/o serialization is as wrong as it
gets, but then calling a random function just because it's accessible
and does not explode in the face is not much better.

> [   58.368269]  handle_edge_irq+0x7d/0x1e0
> [   58.368272]  generic_handle_irq+0x27/0x30
> [   58.368278]  aer_inject_write+0x53a/0x720
> [   58.368283]  __vfs_write+0x36/0x1b0
> [   58.368289]  ? common_file_perm+0x47/0x130
> [   58.368293]  ? security_file_permission+0x2e/0xf0
> [   58.368295]  vfs_write+0xa5/0x180
> [   58.368296]  ksys_write+0x52/0xc0
> [   58.368300]  do_syscall_64+0x48/0x120
> [   58.368307]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Calling generic_handle_irq() through a sysfs write is in the worst case
going to corrupt state and that NULL pointer dereference is just one
particular effect which made this bogosity visible.

Even if you "fixed" this particular case, invoking this when an
interrupt affinity change is scheduled will also wreckage state. In the
best case it will only trigger the already existing WARN_ON() in the MSI
code when the interrupt in question is MSI and the invocation happens on
the wrong CPU. But there are worse things which can happen.

We are neither going to paper over it by just silently preventing this
particular NULL pointer dereference nor are we going to sprinkle more
checks all over the place just to deal with this. The interrupt delivery
hardware trainwreck of x86 CPUs is fragile as hell and we have enough
horrible code already to deal with that. No need for self inflicted
horrors.

The proper fix for this is below as it prevents the abuse of this
interface.

This will not break the AER error injection as it has been broken
forever. It just makes sure that the brokeness is not propagating
through the core code.

The right thing to make AER injection work is to inject the interrupt
via the retrigger mechanism, which will send an IPI. There is no core
interface for this, but that's a solvable problem.

Thanks,

        tglx

8<-----------------
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 2c5676b0a6e7..d7c4a3b815a6 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -556,6 +556,7 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 		irqd->chip_data = apicd;
 		irqd->hwirq = virq + i;
 		irqd_set_single_target(irqd);
+		irqd_set_handle_enforce_irqctx(irqd);
 		/*
 		 * Legacy vectors are already assigned when the IOAPIC
 		 * takes them over. They stay on the same vector. This is
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 3ed5a055b5f4..9315fbb87db3 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -211,6 +211,8 @@ struct irq_data {
  * IRQD_CAN_RESERVE		- Can use reservation mode
  * IRQD_MSI_NOMASK_QUIRK	- Non-maskable MSI quirk for affinity change
  *				  required
+ * IRQD_HANDLE_ENFORCE_IRQCTX	- Enforce that handle_irq_*() is only invoked
+ *				  from actual interrupt context.
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -234,6 +236,7 @@ enum {
 	IRQD_DEFAULT_TRIGGER_SET	= (1 << 25),
 	IRQD_CAN_RESERVE		= (1 << 26),
 	IRQD_MSI_NOMASK_QUIRK		= (1 << 27),
+	IRQD_HANDLE_ENFORCE_IRQCTX	= (1 << 28),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -303,6 +306,16 @@ static inline bool irqd_is_single_target(struct irq_data *d)
 	return __irqd_to_state(d) & IRQD_SINGLE_TARGET;
 }
 
+static inline void irqd_set_handle_enforce_irqctx(struct irq_data *d)
+{
+	__irqd_to_state(d) |= IRQD_HANDLE_ENFORCE_IRQCTX;
+}
+
+static inline bool irqd_is_handle_enforce_irqctx(struct irq_data *d)
+{
+	return __irqd_to_state(d) & IRQD_HANDLE_ENFORCE_IRQCTX;
+}
+
 static inline bool irqd_is_wakeup_set(struct irq_data *d)
 {
 	return __irqd_to_state(d) & IRQD_WAKEUP_STATE;
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 3924fbe829d4..4561f971bc74 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -427,6 +427,10 @@ static inline struct cpumask *irq_desc_get_pending_mask(struct irq_desc *desc)
 {
 	return desc->pending_mask;
 }
+static inline bool handle_enforce_irqctx(struct irq_data *data)
+{
+	return irqd_is_handle_enforce_irqctx(data);
+}
 bool irq_fixup_move_pending(struct irq_desc *desc, bool force_clear);
 #else /* CONFIG_GENERIC_PENDING_IRQ */
 static inline bool irq_can_move_pcntxt(struct irq_data *data)
@@ -453,6 +457,10 @@ static inline bool irq_fixup_move_pending(struct irq_desc *desc, bool fclear)
 {
 	return false;
 }
+static inline bool handle_enforce_irqctx(struct irq_data *data)
+{
+	return false;
+}
 #endif /* !CONFIG_GENERIC_PENDING_IRQ */
 
 #if !defined(CONFIG_IRQ_DOMAIN) || !defined(CONFIG_IRQ_DOMAIN_HIERARCHY)
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 98a5f10d1900..b3e9a66dd079 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -638,9 +638,15 @@ void irq_init_desc(unsigned int irq)
 int generic_handle_irq(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
+	struct irq_data *data;
 
 	if (!desc)
 		return -EINVAL;
+
+	data = irq_desc_get_irq_data(desc);
+	if (WARN_ON_ONCE(!in_irq() && handle_enforce_irqctx(data)))
+		return -EPERM;
+
 	generic_handle_irq_desc(desc);
 	return 0;
 }


