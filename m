Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC2D17BDC8
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 14:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgCFNIo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 08:08:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53321 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgCFNIo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2020 08:08:44 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jACiV-0003fr-IV; Fri, 06 Mar 2020 14:08:39 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id E62CA10409D;
        Fri,  6 Mar 2020 14:08:38 +0100 (CET)
Message-Id: <20200306130623.775200917@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 06 Mar 2020 14:03:45 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [patch 4/7] genirq: Add return value to check_irq_resend()
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

In preparation for an interrupt injection interface which can be used
safely by error injection mechanisms. e.g. PCI-E/ AER, add a return value
to check_irq_resend() so errors can be propagated to the caller.

Split out the software resend code so the ugly #ifdef in check_irq_resend()
goes away and the whole thing becomes readable.

Fix up the caller in debugfs. The caller in irq_startup() does not care
about the return value as this is unconditionally invoked for all
interrupts and the resend is best effort anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/debugfs.c   |    3 -
 kernel/irq/internals.h |    2 -
 kernel/irq/resend.c    |   83 ++++++++++++++++++++++++++++---------------------
 3 files changed, 51 insertions(+), 37 deletions(-)

--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -218,8 +218,7 @@ static ssize_t irq_debug_write(struct fi
 			err = -EINVAL;
 		} else {
 			desc->istate |= IRQS_PENDING;
-			check_irq_resend(desc);
-			err = 0;
+			err = check_irq_resend(desc);
 		}
 
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -108,7 +108,7 @@ irqreturn_t handle_irq_event_percpu(stru
 irqreturn_t handle_irq_event(struct irq_desc *desc);
 
 /* Resending of interrupts :*/
-void check_irq_resend(struct irq_desc *desc);
+int check_irq_resend(struct irq_desc *desc);
 bool irq_wait_for_poll(struct irq_desc *desc);
 void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action);
 
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -47,6 +47,43 @@ static void resend_irqs(unsigned long ar
 /* Tasklet to handle resend: */
 static DECLARE_TASKLET(resend_tasklet, resend_irqs, 0);
 
+static int irq_sw_resend(struct irq_desc *desc)
+{
+	unsigned int irq = irq_desc_get_irq(desc);
+
+	/*
+	 * Validate whether this interrupt can be safely injected from
+	 * non interrupt context
+	 */
+	if (handle_enforce_irqctx(&desc->irq_data))
+		return -EINVAL;
+
+	/*
+	 * If the interrupt is running in the thread context of the parent
+	 * irq we need to be careful, because we cannot trigger it
+	 * directly.
+	 */
+	if (irq_settings_is_nested_thread(desc)) {
+		/*
+		 * If the parent_irq is valid, we retrigger the parent,
+		 * otherwise we do nothing.
+		 */
+		if (!desc->parent_irq)
+			return -EINVAL;
+		irq = desc->parent_irq;
+	}
+
+	/* Set it pending and activate the softirq: */
+	set_bit(irq, irqs_resend);
+	tasklet_schedule(&resend_tasklet);
+	return 0;
+}
+
+#else
+static int irq_sw_resend(struct irq_desc *desc)
+{
+	return -EINVAL;
+}
 #endif
 
 /*
@@ -54,50 +91,28 @@ static DECLARE_TASKLET(resend_tasklet, r
  *
  * Is called with interrupts disabled and desc->lock held.
  */
-void check_irq_resend(struct irq_desc *desc)
+int check_irq_resend(struct irq_desc *desc)
 {
 	/*
-	 * We do not resend level type interrupts. Level type
-	 * interrupts are resent by hardware when they are still
-	 * active. Clear the pending bit so suspend/resume does not
-	 * get confused.
+	 * We do not resend level type interrupts. Level type interrupts
+	 * are resent by hardware when they are still active. Clear the
+	 * pending bit so suspend/resume does not get confused.
 	 */
 	if (irq_settings_is_level(desc)) {
 		desc->istate &= ~IRQS_PENDING;
-		return;
+		return -EINVAL;
 	}
+
 	if (desc->istate & IRQS_REPLAY)
-		return;
+		return -EBUSY;
+
 	if (desc->istate & IRQS_PENDING) {
 		desc->istate &= ~IRQS_PENDING;
 		desc->istate |= IRQS_REPLAY;
 
-		if ((!desc->irq_data.chip->irq_retrigger ||
-		    !desc->irq_data.chip->irq_retrigger(&desc->irq_data)) &&
-		    !handle_enforce_irqctx(&desc->irq_data)) {
-#ifdef CONFIG_HARDIRQS_SW_RESEND
-			unsigned int irq = irq_desc_get_irq(desc);
-
-			/*
-			 * If the interrupt is running in the thread
-			 * context of the parent irq we need to be
-			 * careful, because we cannot trigger it
-			 * directly.
-			 */
-			if (irq_settings_is_nested_thread(desc)) {
-				/*
-				 * If the parent_irq is valid, we
-				 * retrigger the parent, otherwise we
-				 * do nothing.
-				 */
-				if (!desc->parent_irq)
-					return;
-				irq = desc->parent_irq;
-			}
-			/* Set it pending and activate the softirq: */
-			set_bit(irq, irqs_resend);
-			tasklet_schedule(&resend_tasklet);
-#endif
-		}
+		if (!desc->irq_data.chip->irq_retrigger ||
+		    !desc->irq_data.chip->irq_retrigger(&desc->irq_data))
+		    return irq_sw_resend(desc);
 	}
+	return 0;
 }

