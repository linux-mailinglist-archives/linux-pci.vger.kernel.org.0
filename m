Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5F3515A795
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2020 12:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgBLLTs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 12 Feb 2020 06:19:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48303 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgBLLTs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2020 06:19:48 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j1q3T-0002hT-0l; Wed, 12 Feb 2020 12:19:43 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D4D42100F5A; Wed, 12 Feb 2020 12:19:41 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Evan Green <evgreen@chromium.org>, Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: "Plug non-maskable MSI affinity race" triggers a warning with CPU hotplugs
In-Reply-To: <FE2AA412-40A7-4FA2-A9E8-C7FA2919BD1D@lca.pw>
References: <FE2AA412-40A7-4FA2-A9E8-C7FA2919BD1D@lca.pw>
Date:   Wed, 12 Feb 2020 12:19:41 +0100
Message-ID: <878sl8xdbm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Qian,

Qian Cai <cai@lca.pw> writes:

> The linux-next commit 6f1a4891a592 (“x86/apic/msi: Plug non-maskable
> MSI affinity race”) Introduced a bug which is always triggered during
> the CPU hotplugs on this server. See the trace and line numbers below.

Thanks for the report.

> WARNING: CPU: 0 PID: 2794 at arch/x86/kernel/apic/msi.c:103 msi_set_affinity+0x278/0x330 
> CPU: 0 PID: 2794 Comm: irqbalance Tainted: G             L    5.6.0-rc1-next-20200211 #1 
> irq_do_set_affinity at kernel/irq/manage.c:259
> irq_setup_affinity at kernel/irq/manage.c:474
> irq_select_affinity_usr at kernel/irq/manage.c:496
> write_irq_affinity.isra.0+0x137/0x1e0 
> irq_affinity_proc_write+0x19/0x20
...

I'm glad I added this WARN_ON(). This unearthed another long standing
bug. If user space writes a bogus affinity mask, i.e. no online CPUs
then it calls irq_select_affinity_usr().

This was introduced for ALPHA in

  eee45269b0f5 ("[PATCH] Alpha: convert to generic irq framework (generic part)")

and subsequently made available for all architectures in

  18404756765c ("genirq: Expose default irq affinity mask (take 3)")

which already introduced the circumvention of the affinity setting
restrictions for interrupts which cannot be moved in process context.

The whole exercise is bogus in various aspects:

    1) If the interrupt is already started up then there is absolutely
       no point to honour a bogus interrupt affinity setting from user
       space. The interrupt is already assigned to an online CPU and it
       does not make any sense to reassign it to some other randomly
       chosen online CPU.

    2) If the interupt is not yet started up then there is no point
       either. A subsequent startup of the interrupt will invoke
       irq_setup_affinity() anyway which will chose a valid target CPU.

So the right thing to do is to just return -EINVAL in case user space
wrote an affinity mask which does not contain any online CPUs, except for
ALPHA which has it's own magic sauce for this.

Can you please test the patch below?

Thanks,

        tglx

8<---------------
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 3924fbe829d4..c9d8eb7f5c02 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -128,8 +128,6 @@ static inline void unregister_handler_proc(unsigned int irq,
 
 extern bool irq_can_set_affinity_usr(unsigned int irq);
 
-extern int irq_select_affinity_usr(unsigned int irq);
-
 extern void irq_set_thread_affinity(struct irq_desc *desc);
 
 extern int irq_do_set_affinity(struct irq_data *data,
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 3089a60ea8f9..7eee98c38f25 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -481,23 +481,9 @@ int irq_setup_affinity(struct irq_desc *desc)
 {
 	return irq_select_affinity(irq_desc_get_irq(desc));
 }
-#endif
+#endif /* CONFIG_AUTO_IRQ_AFFINITY */
+#endif /* CONFIG_SMP */
 
-/*
- * Called when a bogus affinity is set via /proc/irq
- */
-int irq_select_affinity_usr(unsigned int irq)
-{
-	struct irq_desc *desc = irq_to_desc(irq);
-	unsigned long flags;
-	int ret;
-
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	ret = irq_setup_affinity(desc);
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
-	return ret;
-}
-#endif
 
 /**
  *	irq_set_vcpu_affinity - Set vcpu affinity for the interrupt
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 9e5783d98033..af488b037808 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -111,6 +111,28 @@ static int irq_affinity_list_proc_show(struct seq_file *m, void *v)
 	return show_irq_affinity(AFFINITY_LIST, m);
 }
 
+#ifndef CONFIG_AUTO_IRQ_AFFINITY
+static inline int irq_select_affinity_usr(unsigned int irq)
+{
+	/*
+	 * If the interrupt is started up already then this fails. The
+	 * interrupt is assigned to an online CPU already. There is no
+	 * point to move it around randomly. Tell user space that the
+	 * selected mask is bogus.
+	 *
+	 * If not then any change to the affinity is pointless because the
+	 * startup code invokes irq_setup_affinity() which will select
+	 * a online CPU anyway.
+	 */
+	return -EINVAL;
+}
+#else
+/* ALPHA magic affinity auto selector. Keep it for historical reasons. */
+static inline int irq_select_affinity_usr(unsigned int irq)
+{
+	return irq_select_affinity(irq);
+}
+#endif
 
 static ssize_t write_irq_affinity(int type, struct file *file,
 		const char __user *buffer, size_t count, loff_t *pos)
