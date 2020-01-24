Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77E5C148973
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2020 15:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbgAXOex (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jan 2020 09:34:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42565 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731074AbgAXOes (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jan 2020 09:34:48 -0500
Received: from [5.158.153.53] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iv02l-0002eQ-Qz; Fri, 24 Jan 2020 15:34:43 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 67F5E103089; Fri, 24 Jan 2020 15:34:43 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Evan Green <evgreen@chromium.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Subject: Re: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
In-Reply-To: <CAE=gft7MqQ3Mej5oCT=gw6ZLMSTHoSyMGOFz=-hae-eRZvXLxA@mail.gmail.com>
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid> <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com> <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com> <87y2tytv5i.fsf@nanos.tec.linutronix.de> <87eevqkpgn.fsf@nanos.tec.linutronix.de> <CAE=gft6YiM5S1A7iJYJTd5zmaAa8=nhLE3B94JtWa+XW-qVSqQ@mail.gmail.com> <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com> <CAE=gft7MqQ3Mej5oCT=gw6ZLMSTHoSyMGOFz=-hae-eRZvXLxA@mail.gmail.com>
Date:   Fri, 24 Jan 2020 15:34:43 +0100
Message-ID: <87d0b82a9o.fsf@nanos.tec.linutronix.de>
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

Evan Green <evgreen@chromium.org> writes:
> I did another experiment that I think lends credibility to my torn MSI
> hypothesis. I have the following change:
>
> And indeed, I get a machine check, despite the fact that MSI_DATA is
> overwritten just after address is updated.

I don't have to understand why a SoC released in 2019 still has
unmaskable MSI especially as Inhell's own XHCI spec clearly documents
and recommends MSI-X.

While your workaround (disabling MSI) works in this particular case it's
not really a good option:

 1) Quite some devices have a bug where the legacy INTX disable does not
    work reliably or is outright broken. That means MSI disable will
    reroute to INTX.

 2) I digged out old debug data which confirms that some silly devices
    lose interrupts accross MSI disable/reenable if the INTX fallback is
    disabled.

    And no, it's not a random weird device, it's part of a chipset which
    was pretty popular a few years ago. I leave it as an excercise for
    the reader to guess the vendor.

Can you please apply the patch below? It enforces an IPI to the new
vector/target CPU when the interrupt is MSI w/o masking. It should
cure the issue. It goes without saying that I'm not proud of it.

Thanks,

        tglx

8<--------------

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -498,6 +498,7 @@ extern bool default_check_apicid_used(ph
 extern void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap);
 extern int default_cpu_present_to_apicid(int mps_cpu);
 extern int default_check_phys_apicid_present(int phys_apicid);
+extern bool apic_hotplug_force_retrigger(struct irq_data *irqd);
 
 #endif /* CONFIG_X86_LOCAL_APIC */
 
--- a/arch/x86/include/asm/irqdomain.h
+++ b/arch/x86/include/asm/irqdomain.h
@@ -10,6 +10,7 @@ enum {
 	/* Allocate contiguous CPU vectors */
 	X86_IRQ_ALLOC_CONTIGUOUS_VECTORS		= 0x1,
 	X86_IRQ_ALLOC_LEGACY				= 0x2,
+	X86_IRQ_MSI_NOMASK_TRAINWRECK			= 0x4,
 };
 
 extern struct irq_domain *x86_vector_domain;
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -103,6 +103,14 @@ int pci_msi_prepare(struct irq_domain *d
 	} else {
 		arg->type = X86_IRQ_ALLOC_TYPE_MSI;
 		arg->flags |= X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
+		/*
+		 * If the MSI implementation does not provide masking
+		 * enable the workaround for the CPU hotplug forced
+		 * migration problem which is caused by the torn write of
+		 * the address/data pair.
+		 */
+		if (!desc->msi_attrib.maskbit)
+			arg->flags |= X86_IRQ_MSI_NOMASK_TRAINWRECK;
 	}
 
 	return 0;
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -34,7 +34,8 @@ struct apic_chip_data {
 	unsigned int		move_in_progress	: 1,
 				is_managed		: 1,
 				can_reserve		: 1,
-				has_reserved		: 1;
+				has_reserved		: 1,
+				force_retrigger		: 1;
 };
 
 struct irq_domain *x86_vector_domain;
@@ -99,6 +100,18 @@ struct irq_cfg *irq_cfg(unsigned int irq
 	return irqd_cfg(irq_get_irq_data(irq));
 }
 
+bool apic_hotplug_force_retrigger(struct irq_data *irqd)
+{
+	struct apic_chip_data *apicd;
+
+	irqd = __irq_domain_get_irq_data(x86_vector_domain, irqd);
+	if (!irqd)
+		return false;
+
+	apicd = apic_chip_data(irqd);
+	return apicd && apicd->force_retrigger;
+}
+
 static struct apic_chip_data *alloc_apic_chip_data(int node)
 {
 	struct apic_chip_data *apicd;
@@ -552,6 +565,8 @@ static int x86_vector_alloc_irqs(struct
 		}
 
 		apicd->irq = virq + i;
+		if (info->flags & X86_IRQ_MSI_NOMASK_TRAINWRECK)
+			apicd->force_retrigger = true;
 		irqd->chip = &lapic_controller;
 		irqd->chip_data = apicd;
 		irqd->hwirq = virq + i;
@@ -624,6 +639,7 @@ static void x86_vector_debug_show(struct
 	seq_printf(m, "%*scan_reserve:      %u\n", ind, "", apicd.can_reserve ? 1 : 0);
 	seq_printf(m, "%*shas_reserved:     %u\n", ind, "", apicd.has_reserved ? 1 : 0);
 	seq_printf(m, "%*scleanup_pending:  %u\n", ind, "", !hlist_unhashed(&apicd.clist));
+	seq_printf(m, "%*sforce_retrigger:  %u\n", ind, "", apicd.force_retrigger ? 1 : 0);
 }
 #endif
 
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -350,6 +350,7 @@ void fixup_irqs(void)
 	struct irq_desc *desc;
 	struct irq_data *data;
 	struct irq_chip *chip;
+	bool retrigger;
 
 	irq_migrate_all_off_this_cpu();
 
@@ -370,24 +371,29 @@ void fixup_irqs(void)
 	 * nothing else will touch it.
 	 */
 	for (vector = FIRST_EXTERNAL_VECTOR; vector < NR_VECTORS; vector++) {
-		if (IS_ERR_OR_NULL(__this_cpu_read(vector_irq[vector])))
+		desc = __this_cpu_read(vector_irq[vector]);
+		if (IS_ERR_OR_NULL(desc))
 			continue;
 
+		raw_spin_lock(&desc->lock);
+		data = irq_desc_get_irq_data(desc);
+		retrigger = apic_hotplug_force_retrigger(data);
+
 		irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
-		if (irr  & (1 << (vector % 32))) {
-			desc = __this_cpu_read(vector_irq[vector]);
+		if (irr  & (1 << (vector % 32)))
+			retrigger = true;
 
-			raw_spin_lock(&desc->lock);
-			data = irq_desc_get_irq_data(desc);
+		if (!retrigger) {
+			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
+		} else {
 			chip = irq_data_get_irq_chip(data);
 			if (chip->irq_retrigger) {
 				chip->irq_retrigger(data);
-				__this_cpu_write(vector_irq[vector], VECTOR_RETRIGGERED);
+				__this_cpu_write(vector_irq[vector],
+						 VECTOR_RETRIGGERED);
 			}
-			raw_spin_unlock(&desc->lock);
 		}
-		if (__this_cpu_read(vector_irq[vector]) != VECTOR_RETRIGGERED)
-			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
+		raw_spin_unlock(&desc->lock);
 	}
 }
 #endif
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -432,6 +432,8 @@ int irq_reserve_ipi(struct irq_domain *d
 int irq_destroy_ipi(unsigned int irq, const struct cpumask *dest);
 
 /* V2 interfaces to support hierarchy IRQ domains. */
+struct irq_data *__irq_domain_get_irq_data(struct irq_domain *domain,
+					   struct irq_data *irq_data);
 extern struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
 						unsigned int virq);
 extern void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1165,6 +1165,21 @@ static int irq_domain_alloc_irq_data(str
 }
 
 /**
+ * __irq_domain_get_irq_data - Get irq_data associated with @domain for @data
+ * @domain:	domain to match
+ * @irq_data:	initial irq data to start hierarchy search
+ */
+struct irq_data *__irq_domain_get_irq_data(struct irq_domain *domain,
+					   struct irq_data *irq_data)
+{
+	for (; irq_data; irq_data = irq_data->parent_data) {
+		if (irq_data->domain == domain)
+			return irq_data;
+	}
+	return NULL;
+}
+
+/**
  * irq_domain_get_irq_data - Get irq_data associated with @virq and @domain
  * @domain:	domain to match
  * @virq:	IRQ number to get irq_data
@@ -1172,14 +1187,7 @@ static int irq_domain_alloc_irq_data(str
 struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
 					 unsigned int virq)
 {
-	struct irq_data *irq_data;
-
-	for (irq_data = irq_get_irq_data(virq); irq_data;
-	     irq_data = irq_data->parent_data)
-		if (irq_data->domain == domain)
-			return irq_data;
-
-	return NULL;
+	return __irq_domain_get_irq_data(domain, irq_get_irq_data(virq));
 }
 EXPORT_SYMBOL_GPL(irq_domain_get_irq_data);
 
