Return-Path: <linux-pci+bounces-37642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F097CBBFB31
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 00:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D99189D023
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 22:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24848288A2;
	Mon,  6 Oct 2025 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aAAQob1y"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F2D1F3FF8
	for <linux-pci@vger.kernel.org>; Mon,  6 Oct 2025 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759790346; cv=none; b=aGciM9g0LtF0dfWYmv+O4AcepzLi/wR3LIinxzvp1ZOjOLTgpDO9QoDgZTUabti/nBLZmF7bmhiMZ1kqjYBDbH+s77JQ3vvrizpa1SjfML78MM3fQnl3shj249OVXufBebzMesOO7kgONOp4KvOEm9eUQnESuliJfR7yw4eenk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759790346; c=relaxed/simple;
	bh=TSoEXVGwGQTmt/R3uJU3qgFeaYS7lSb+1JzZBPmh6w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwJEx7pyEJOdoSimpCHig3/HOnEiNxZpOt8l4En0WEe/ku1Fmc7NsIHdaWxqzZLpfnolH9P6iReouk6BxMzZig8sqGOLHdrdkceNp1Az19QT0DPOrm/Iow7KVdyu+1ODHfy0sKICIDT39xMHImmko1NAAozqVNP3FG8TCs2Vmv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aAAQob1y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759790343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3uPgca4hOojSsFSrTZWBDCLo3ELrEuCKrgpTwuDMzo=;
	b=aAAQob1yVZKAHn+qk4EZoMhlaPkYeVMDM2zFXepRV3HbyaynfN2n4woTro3wccVB/EwkUe
	0o1OaXQ101Avl3Dt1iJCb9tIfONSXRtbS+6ROwEfOdUKMyCHX9bQqZV0tmkYPPRCSYKSqx
	eJBvLL/Lmza0QPlK3/luLxeQEeGrIUo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-A3vTskSnPFeeit_3iyJJrQ-1; Mon,
 06 Oct 2025 18:39:00 -0400
X-MC-Unique: A3vTskSnPFeeit_3iyJJrQ-1
X-Mimecast-MFC-AGG-ID: A3vTskSnPFeeit_3iyJJrQ_1759790338
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 329F51800366;
	Mon,  6 Oct 2025 22:38:58 +0000 (UTC)
Received: from thinkpad-p1.kanata.rendec.net (unknown [10.22.90.133])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 417A11800447;
	Mon,  6 Oct 2025 22:38:55 +0000 (UTC)
From: Radu Rendec <rrendec@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Daniel Tsai <danielsftsai@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Brian Masney <bmasney@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Alessandro Carminati <acarmina@redhat.com>,
	Jared Kangas <jkangas@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] genirq: Add interrupt redirection infrastructure
Date: Mon,  6 Oct 2025 18:38:11 -0400
Message-ID: <20251006223813.1688637-2-rrendec@redhat.com>
In-Reply-To: <20251006223813.1688637-1-rrendec@redhat.com>
References: <20251006223813.1688637-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Thomas Gleixner <tglx@linutronix.de>

Add infrastructure to redirect interrupt handler execution to a
different CPU when the current CPU is not part of the interrupt's CPU
affinity mask.

This is primarily aimed at (de)multiplexed interrupts, where the child
interrupt handler runs in the context of the parent interrupt handler,
and therefore CPU affinity control for the child interrupt is typically
not available.

With the new infrastructure, the child interrupt is allowed to freely
change its affinity setting, independently of the parent. If the
interrupt handler happens to be triggered on an "incompatible" CPU (a
CPU that's not part of the child interrupt's affinity mask), the handler
is redirected and runs in IRQ work context on a "compatible" CPU.

No functional change is being made to any existing irqchip driver, and
irqchip drivers must be explicitly modified to use the newly added
infrastructure to support interrupt redirection.

This is a direct follow up to the patches that Thomas Gleixner proposed
in https://lore.kernel.org/linux-pci/878qpg4o4t.ffs@tglx/

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/linux-pci/878qpg4o4t.ffs@tglx/
Co-developed-by: Radu Rendec <rrendec@redhat.com>
Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 include/linux/irq.h     | 10 ++++++++
 include/linux/irqdesc.h | 11 ++++++++-
 kernel/irq/chip.c       | 22 +++++++++++++++++-
 kernel/irq/irqdesc.c    | 51 +++++++++++++++++++++++++++++++++++++++--
 kernel/irq/manage.c     | 16 +++++++++++--
 5 files changed, 104 insertions(+), 6 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c67e76fbcc077..3e5a6ffb1e551 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -459,6 +459,8 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  *			checks against the supplied affinity mask are not
  *			required. This is used for CPU hotplug where the
  *			target CPU is not yet set in the cpu_online_mask.
+ * @irq_pre_redirect:	Optional function to be invoked before redirecting
+ *			an interrupt via irq_work.
  * @irq_retrigger:	resend an IRQ to the CPU
  * @irq_set_type:	set the flow type (IRQ_TYPE_LEVEL/etc.) of an IRQ
  * @irq_set_wake:	enable/disable power-management wake-on of an IRQ
@@ -503,6 +505,7 @@ struct irq_chip {
 	void		(*irq_eoi)(struct irq_data *data);
 
 	int		(*irq_set_affinity)(struct irq_data *data, const struct cpumask *dest, bool force);
+	void		(*irq_pre_redirect)(struct irq_data *data);
 	int		(*irq_retrigger)(struct irq_data *data);
 	int		(*irq_set_type)(struct irq_data *data, unsigned int flow_type);
 	int		(*irq_set_wake)(struct irq_data *data, unsigned int on);
@@ -688,6 +691,13 @@ extern int irq_chip_set_vcpu_affinity_parent(struct irq_data *data,
 extern int irq_chip_set_type_parent(struct irq_data *data, unsigned int type);
 extern int irq_chip_request_resources_parent(struct irq_data *data);
 extern void irq_chip_release_resources_parent(struct irq_data *data);
+#ifdef CONFIG_SMP
+void irq_chip_pre_redirect_parent(struct irq_data *data);
+#endif
+#endif
+
+#ifdef CONFIG_SMP
+int irq_chip_redirect_set_affinity(struct irq_data *data, const struct cpumask *dest, bool force);
 #endif
 
 /* Disable or mask interrupts during a kernel kexec */
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index fd091c35d5721..aeead91884668 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -2,9 +2,10 @@
 #ifndef _LINUX_IRQDESC_H
 #define _LINUX_IRQDESC_H
 
-#include <linux/rcupdate.h>
+#include <linux/irq_work.h>
 #include <linux/kobject.h>
 #include <linux/mutex.h>
+#include <linux/rcupdate.h>
 
 /*
  * Core internal functions to deal with irq descriptors
@@ -29,6 +30,11 @@ struct irqstat {
 #endif
 };
 
+struct irq_redirect {
+	struct irq_work	work;
+	unsigned int	fallback_cpu;
+};
+
 /**
  * struct irq_desc - interrupt descriptor
  * @irq_common_data:	per irq and chip data passed down to chip functions
@@ -46,6 +52,7 @@ struct irqstat {
  * @threads_handled:	stats field for deferred spurious detection of threaded handlers
  * @threads_handled_last: comparator field for deferred spurious detection of threaded handlers
  * @lock:		locking for SMP
+ * @redirect:		Facility for redirecting interrupts via irq_work
  * @affinity_hint:	hint to user space for preferred irq affinity
  * @affinity_notify:	context for notification of affinity changes
  * @pending_mask:	pending rebalanced interrupts
@@ -84,6 +91,7 @@ struct irq_desc {
 	struct cpumask		*percpu_enabled;
 	const struct cpumask	*percpu_affinity;
 #ifdef CONFIG_SMP
+	struct irq_redirect	redirect;
 	const struct cpumask	*affinity_hint;
 	struct irq_affinity_notify *affinity_notify;
 #ifdef CONFIG_GENERIC_PENDING_IRQ
@@ -186,6 +194,7 @@ int generic_handle_irq_safe(unsigned int irq);
 int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq);
 int generic_handle_domain_irq_safe(struct irq_domain *domain, unsigned int hwirq);
 int generic_handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq);
+bool generic_handle_demux_domain_irq(struct irq_domain *domain, unsigned int hwirq);
 #endif
 
 /* Test to see if a driver has successfully requested an irq */
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 3ffa0d80ddd19..b6b2ce29d0ce1 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1143,7 +1143,7 @@ void irq_cpu_offline(void)
 }
 #endif
 
-#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 
 #ifdef CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS
 /**
@@ -1215,6 +1215,15 @@ EXPORT_SYMBOL_GPL(handle_fasteoi_mask_irq);
 
 #endif /* CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS */
 
+#ifdef CONFIG_SMP
+void irq_chip_pre_redirect_parent(struct irq_data *data)
+{
+	data = data->parent_data;
+	data->chip->irq_pre_redirect(data);
+}
+EXPORT_SYMBOL_GPL(irq_chip_pre_redirect_parent);
+#endif
+
 /**
  * irq_chip_set_parent_state - set the state of a parent interrupt.
  *
@@ -1497,6 +1506,17 @@ void irq_chip_release_resources_parent(struct irq_data *data)
 		data->chip->irq_release_resources(data);
 }
 EXPORT_SYMBOL_GPL(irq_chip_release_resources_parent);
+#endif /* CONFIG_IRQ_DOMAIN_HIERARCHY */
+
+#ifdef CONFIG_SMP
+int irq_chip_redirect_set_affinity(struct irq_data *data, const struct cpumask *dest, bool force)
+{
+	struct irq_redirect *redir = &irq_data_to_desc(data)->redirect;
+
+	WRITE_ONCE(redir->fallback_cpu, cpumask_first(dest));
+	return IRQ_SET_MASK_OK;
+}
+EXPORT_SYMBOL_GPL(irq_chip_redirect_set_affinity);
 #endif
 
 /**
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index db714d3014b5f..d704025751315 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -78,8 +78,12 @@ static int alloc_masks(struct irq_desc *desc, int node)
 	return 0;
 }
 
-static void desc_smp_init(struct irq_desc *desc, int node,
-			  const struct cpumask *affinity)
+static void irq_redirect_work(struct irq_work *work)
+{
+	handle_irq_desc(container_of(work, struct irq_desc, redirect.work));
+}
+
+static void desc_smp_init(struct irq_desc *desc, int node, const struct cpumask *affinity)
 {
 	if (!affinity)
 		affinity = irq_default_affinity;
@@ -91,6 +95,7 @@ static void desc_smp_init(struct irq_desc *desc, int node,
 #ifdef CONFIG_NUMA
 	desc->irq_common_data.node = node;
 #endif
+	desc->redirect.work = IRQ_WORK_INIT_HARD(irq_redirect_work);
 }
 
 static void free_masks(struct irq_desc *desc)
@@ -766,6 +771,48 @@ int generic_handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq)
 	WARN_ON_ONCE(!in_nmi());
 	return handle_irq_desc(irq_resolve_mapping(domain, hwirq));
 }
+
+static bool demux_redirect_remote(struct irq_desc *desc)
+{
+#ifdef CONFIG_SMP
+	const struct cpumask *m = irq_data_get_effective_affinity_mask(&desc->irq_data);
+	unsigned int target_cpu = READ_ONCE(desc->redirect.fallback_cpu);
+
+	if (!cpumask_test_cpu(smp_processor_id(), m)) {
+		/* Protect against shutdown */
+		if (desc->action)
+			irq_work_queue_on(&desc->redirect.work, target_cpu);
+		return true;
+	}
+#endif
+	return false;
+}
+
+/**
+ * generic_handle_demux_domain_irq - Invoke the handler for a hardware interrupt
+ *				     of a demultiplexing domain.
+ * @domain:	The domain where to perform the lookup
+ * @hwirq:	The hardware interrupt number to convert to a logical one
+ *
+ * Returns:	True on success, or false if lookup has failed
+ */
+bool generic_handle_demux_domain_irq(struct irq_domain *domain, unsigned int hwirq)
+{
+	struct irq_desc *desc = irq_resolve_mapping(domain, hwirq);
+
+	if (unlikely(!desc))
+		return false;
+
+	scoped_guard(raw_spinlock, &desc->lock) {
+		if (desc->irq_data.chip->irq_pre_redirect)
+			desc->irq_data.chip->irq_pre_redirect(&desc->irq_data);
+		if (demux_redirect_remote(desc))
+			return true;
+	}
+	return !handle_irq_desc(desc);
+}
+EXPORT_SYMBOL_GPL(generic_handle_demux_domain_irq);
+
 #endif
 
 /* Dynamic interrupt handling */
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c94837382037e..ed8f8b2667b0b 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -35,6 +35,16 @@ static int __init setup_forced_irqthreads(char *arg)
 early_param("threadirqs", setup_forced_irqthreads);
 #endif
 
+#ifdef CONFIG_SMP
+static inline void synchronize_irqwork(struct irq_desc *desc)
+{
+	/* Synchronize pending or on the fly redirect work */
+	irq_work_sync(&desc->redirect.work);
+}
+#else
+static inline void synchronize_irqwork(struct irq_desc *desc) { }
+#endif
+
 static int __irq_get_irqchip_state(struct irq_data *d, enum irqchip_irq_state which, bool *state);
 
 static void __synchronize_hardirq(struct irq_desc *desc, bool sync_chip)
@@ -43,6 +53,8 @@ static void __synchronize_hardirq(struct irq_desc *desc, bool sync_chip)
 	bool inprogress;
 
 	do {
+		synchronize_irqwork(desc);
+
 		/*
 		 * Wait until we're out of the critical section.  This might
 		 * give the wrong answer due to the lack of memory barriers.
@@ -108,6 +120,7 @@ EXPORT_SYMBOL(synchronize_hardirq);
 static void __synchronize_irq(struct irq_desc *desc)
 {
 	__synchronize_hardirq(desc, true);
+
 	/*
 	 * We made sure that no hardirq handler is running. Now verify that no
 	 * threaded handlers are active.
@@ -217,8 +230,7 @@ static inline void irq_validate_effective_affinity(struct irq_data *data) { }
 
 static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
 
-int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
-			bool force)
+int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask, bool force)
 {
 	struct cpumask *tmp_mask = this_cpu_ptr(&__tmp_mask);
 	struct irq_desc *desc = irq_data_to_desc(data);
-- 
2.51.0


