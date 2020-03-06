Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A56E117BDCC
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 14:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCFNJD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 08:09:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53319 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgCFNIo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2020 08:08:44 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jACiW-0003fz-2V; Fri, 06 Mar 2020 14:08:40 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 5AF1E1040A0;
        Fri,  6 Mar 2020 14:08:39 +0100 (CET)
Message-Id: <20200306130623.990928309@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 06 Mar 2020 14:03:47 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [patch 6/7] genirq: Provide interrupt injection mechanism
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

Error injection mechanisms need a half ways safe way to inject interrupts as
invoking generic_handle_irq() or the actual device interrupt handler
directly from e.g. a debugfs write is not guaranteed to be safe.

On x86 generic_handle_irq() is unsafe due to the hardware trainwreck which
is the base of x86 interrupt delivery and affinity management.

Move the irq debugfs injection code into a separate function which can be
used by error injection code as well.

The implementation prevents at least that state is corrupted, but it cannot
close a very tiny race window on x86 which might result in a stale and not
serviced device interrupt under very unlikely circumstances.

This is explicitly for debugging and testing and not for production use or
abuse in random driver code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/interrupt.h |    2 +
 kernel/irq/Kconfig        |    5 ++++
 kernel/irq/chip.c         |    2 -
 kernel/irq/debugfs.c      |   34 -----------------------------
 kernel/irq/internals.h    |    2 -
 kernel/irq/resend.c       |   53 ++++++++++++++++++++++++++++++++++++++++++++--
 6 files changed, 61 insertions(+), 37 deletions(-)

--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -248,6 +248,8 @@ extern void enable_percpu_nmi(unsigned i
 extern int prepare_percpu_nmi(unsigned int irq);
 extern void teardown_percpu_nmi(unsigned int irq);
 
+extern int irq_inject_interrupt(unsigned int irq);
+
 /* The following three functions are for the core kernel use only. */
 extern void suspend_device_irqs(void);
 extern void resume_device_irqs(void);
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -43,6 +43,10 @@ config GENERIC_IRQ_MIGRATION
 config AUTO_IRQ_AFFINITY
        bool
 
+# Interrupt injection mechanism
+config GENERIC_IRQ_INJECTION
+	bool
+
 # Tasklet based software resend for pending interrupts on enable_irq()
 config HARDIRQS_SW_RESEND
        bool
@@ -127,6 +131,7 @@ config SPARSE_IRQ
 config GENERIC_IRQ_DEBUGFS
 	bool "Expose irq internals in debugfs"
 	depends on DEBUG_FS
+	select GENERIC_IRQ_INJECTION
 	default n
 	---help---
 
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -278,7 +278,7 @@ int irq_startup(struct irq_desc *desc, b
 		}
 	}
 	if (resend)
-		check_irq_resend(desc);
+		check_irq_resend(desc, false);
 
 	return ret;
 }
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -190,39 +190,7 @@ static ssize_t irq_debug_write(struct fi
 		return -EFAULT;
 
 	if (!strncmp(buf, "trigger", size)) {
-		unsigned long flags;
-		int err;
-
-		/* Try the HW interface first */
-		err = irq_set_irqchip_state(irq_desc_get_irq(desc),
-					    IRQCHIP_STATE_PENDING, true);
-		if (!err)
-			return count;
-
-		/*
-		 * Otherwise, try to inject via the resend interface,
-		 * which may or may not succeed.
-		 */
-		chip_bus_lock(desc);
-		raw_spin_lock_irqsave(&desc->lock, flags);
-
-		/*
-		 * Don't allow injection when the interrupt is:
-		 *  - Level or NMI type
-		 *  - not activated
-		 *  - replaying already
-		 */
-		if (irq_settings_is_level(desc) ||
-		    !irqd_is_activated(&desc->irq_data) ||
-		    (desc->istate & (IRQS_NMI | IRQS_REPLAY)) {
-			err = -EINVAL;
-		} else {
-			desc->istate |= IRQS_PENDING;
-			err = check_irq_resend(desc);
-		}
-
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
-		chip_bus_sync_unlock(desc);
+		int err = irq_inject_interrupt(irq_desc_get_irq(desc));
 
 		return err ? err : count;
 	}
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -108,7 +108,7 @@ irqreturn_t handle_irq_event_percpu(stru
 irqreturn_t handle_irq_event(struct irq_desc *desc);
 
 /* Resending of interrupts :*/
-int check_irq_resend(struct irq_desc *desc);
+int check_irq_resend(struct irq_desc *desc, bool inject);
 bool irq_wait_for_poll(struct irq_desc *desc);
 void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action);
 
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -91,7 +91,7 @@ static int irq_sw_resend(struct irq_desc
  *
  * Is called with interrupts disabled and desc->lock held.
  */
-int check_irq_resend(struct irq_desc *desc)
+int check_irq_resend(struct irq_desc *desc, bool inject)
 {
 	int err = 0;
 
@@ -108,7 +108,7 @@ int check_irq_resend(struct irq_desc *de
 	if (desc->istate & IRQS_REPLAY)
 		return -EBUSY;
 
-	if (!(desc->istate & IRQS_PENDING))
+	if (!(desc->istate & IRQS_PENDING) && !inject)
 		return 0;
 
 	desc->istate &= ~IRQS_PENDING;
@@ -122,3 +122,52 @@ int check_irq_resend(struct irq_desc *de
 		desc->istate |= IRQS_REPLAY;
 	return err;
 }
+
+#ifdef CONFIG_GENERIC_IRQ_INJECTION
+/**
+ * irq_inject_interrupt - Inject an interrupt for testing/error injection
+ * @irq:	The interrupt number
+ *
+ * This function must only be used for debug and testing purposes!
+ *
+ * Especially on x86 this can cause a premature completion of an interrupt
+ * affinity change causing the interrupt line to become stale. Very
+ * unlikely, but possible.
+ *
+ * The injection can fail for various reasons:
+ * - Interrupt is not activated
+ * - Interrupt is NMI type or currently replaying
+ * - Interrupt is level type
+ * - Interrupt does not support hardware retrigger and software resend is
+ *   either not enabled or not possible for the interrupt.
+ */
+int irq_inject_interrupt(unsigned int irq)
+{
+	struct irq_desc *desc;
+	unsigned long flags;
+	int err;
+
+	/* Try the state injection hardware interface first */
+	if (!irq_set_irqchip_state(irq, IRQCHIP_STATE_PENDING, true))
+		return 0;
+
+	/* That failed, try via the resend mechanism */
+	desc = irq_get_desc_buslock(irq, &flags, 0);
+	if (!desc)
+		return -EINVAL;
+
+	/*
+	 * Only try to inject when the interrupt is:
+	 *  - not NMI type
+	 *  - activated
+	 */
+	if ((desc->istate & IRQS_NMI) || !irqd_is_activated(&desc->irq_data))
+		err = -EINVAL;
+	else
+		err = check_irq_resend(desc, true);
+
+	irq_put_desc_busunlock(desc, flags);
+	return err;
+}
+EXPORT_SYMBOL_GPL(irq_inject_interrupt);
+#endif

