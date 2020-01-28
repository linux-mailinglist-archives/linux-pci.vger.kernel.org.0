Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C227314BA78
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2020 15:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbgA1Oi4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jan 2020 09:38:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49078 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729903AbgA1Oiz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jan 2020 09:38:55 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iwS0v-0008IY-Nj; Tue, 28 Jan 2020 15:38:50 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D12F2101227; Tue, 28 Jan 2020 15:38:48 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Evan Green <evgreen@chromium.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
In-Reply-To: <878slwmpu9.fsf@nanos.tec.linutronix.de>
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid> <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com> <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com> <87y2tytv5i.fsf@nanos.tec.linutronix.de> <87eevqkpgn.fsf@nanos.tec.linutronix.de> <CAE=gft6YiM5S1A7iJYJTd5zmaAa8=nhLE3B94JtWa+XW-qVSqQ@mail.gmail.com> <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com> <CAE=gft7MqQ3Mej5oCT=gw6ZLMSTHoSyMGOFz=-hae-eRZvXLxA@mail.gmail.com> <87d0b82a9o.fsf@nanos.tec.linutronix.de> <CAE=gft7C5HTmcTLsXqXbCtcYDeKG6bCJ0gmgwVNc0PDHLJ5y_A@mail.gmail.com> <878slwmpu9.fsf@nanos.tec.linutronix.de>
Date:   Tue, 28 Jan 2020 15:38:48 +0100
Message-ID: <87imkv63yf.fsf@nanos.tec.linutronix.de>
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
> It's worthwhile, but that needs some deep thoughts about locking and
> ordering plus the inevitable race conditions this creates. If it would
> be trivial, I surely wouldn't have hacked up the retrigger mess.

So after staring at it for a while, I came up with the patch below.

Your idea of going through some well defined transition vector is just
not feasible due to locking and life-time issues.

I'm taking a similar but easier to handle approach.

    1) Move the interrupt to the new vector on the old (local) CPU

    2) Move it to the new CPU

    3) Check if the new vector is pending on the local CPU. If yes
       retrigger it on the new CPU.

That might give a spurious interrupt if the new vector on the local CPU
is in use. But as I said before this is nothing to worry about. If the
affected device driver fails to handle that spurious interrupt then it
is broken anyway.

In theory we could teach the vector allocation logic to search for an
unused pair of vectors on both CPUs, but the required code for that is
hardly worth the trouble. In the end the situation that no pair is found
has to be handled anyway. So rather than making this the corner case
which is never tested and then leads to hard to debug issues, I prefer
to make it more likely to happen.

The patch is only lightly tested, but so far it survived.

Thanks,

        tglx

8<----------------
 arch/x86/include/asm/apic.h |    8 +++
 arch/x86/kernel/apic/msi.c  |  115 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/irq.h         |   18 ++++++
 include/linux/irqdomain.h   |    7 ++
 kernel/irq/debugfs.c        |    1 
 kernel/irq/msi.c            |    5 +
 6 files changed, 150 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -452,6 +452,14 @@ static inline void ack_APIC_irq(void)
 	apic_eoi();
 }
 
+
+static inline bool lapic_vector_set_in_irr(unsigned int vector)
+{
+	u32 irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
+
+	return !!(irr & (1U << (vector % 32)));
+}
+
 static inline unsigned default_get_apic_id(unsigned long x)
 {
 	unsigned int ver = GET_APIC_VERSION(apic_read(APIC_LVR));
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -23,10 +23,8 @@
 
 static struct irq_domain *msi_default_domain;
 
-static void irq_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
+static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg)
 {
-	struct irq_cfg *cfg = irqd_cfg(data);
-
 	msg->address_hi = MSI_ADDR_BASE_HI;
 
 	if (x2apic_enabled())
@@ -47,6 +45,114 @@ static void irq_msi_compose_msg(struct i
 		MSI_DATA_VECTOR(cfg->vector);
 }
 
+static void irq_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	__irq_msi_compose_msg(irqd_cfg(data), msg);
+}
+
+static void irq_msi_update_msg(struct irq_data *irqd, struct irq_cfg *cfg)
+{
+	struct msi_msg msg[2] = { [1] = { }, };
+
+	__irq_msi_compose_msg(cfg, msg);
+	irq_data_get_irq_chip(irqd)->irq_write_msi_msg(irqd, msg);
+}
+
+static int
+msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
+{
+	struct irq_cfg old_cfg, *cfg = irqd_cfg(irqd);
+	struct irq_data *parent = irqd->parent_data;
+	unsigned int cpu;
+	int ret;
+
+	/* Save the current configuration */
+	cpu = cpumask_first(irq_data_get_effective_affinity_mask(irqd));
+	old_cfg = *cfg;
+
+	/* Allocate a new target vector */
+	ret = parent->chip->irq_set_affinity(parent, mask, force);
+	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
+		return ret;
+
+	/*
+	 * For non-maskable and non-remapped MSI interrupts the migration
+	 * to a different destination CPU and a different vector has to be
+	 * done careful to handle the possible stray interrupt which can be
+	 * caused by the non-atomic update of the address/data pair.
+	 *
+	 * Direct update is possible when:
+	 * - The MSI is maskable (remapped MSI does not use this code path)).
+	 *   The quirk bit is not set in this case.
+	 * - The new vector is the same as the old vector
+	 * - The old vector is MANAGED_IRQ_SHUTDOWN_VECTOR (interrupt starts up)
+	 * - The new destination CPU is the same as the old destination CPU
+	 */
+	if (!irqd_msi_nomask_quirk(irqd) ||
+	    cfg->vector == old_cfg.vector ||
+	    old_cfg.vector == MANAGED_IRQ_SHUTDOWN_VECTOR ||
+	    cfg->dest_apicid == old_cfg.dest_apicid) {
+		irq_msi_update_msg(irqd, cfg);
+		return ret;
+	}
+
+	/*
+	 * Paranoia: Validate that the interrupt target is the local
+	 * CPU.
+	 */
+	if (WARN_ON_ONCE(cpu != smp_processor_id())) {
+		irq_msi_update_msg(irqd, cfg);
+		return ret;
+	}
+
+	/*
+	 * Redirect the interrupt to the new vector on the current CPU
+	 * first. This might cause a spurious interrupt on this vector if
+	 * the device raises an interrupt right between this update and the
+	 * update to the final destination CPU.
+	 *
+	 * If the vector is in use then the installed device handler will
+	 * denote it as spurious which is no harm as this is a rare event
+	 * and interrupt handlers have to cope with spurious interrupts
+	 * anyway. If the vector is unused, then it is marked so it won't
+	 * trigger the 'No irq handler for vector' warning in do_IRQ().
+	 *
+	 * This requires to hold vector lock to prevent concurrent updates to
+	 * the affected vector.
+	 */
+	lock_vector_lock();
+
+	/*
+	 * Mark the new target vector on the local CPU if it is currently
+	 * unused. Reuse the VECTOR_RETRIGGERED state which is also used in
+	 * the CPU hotplug path for a similar purpose. This cannot be
+	 * undone here as the current CPU has interrupts disabled and
+	 * cannot handle the interrupt before the whole set_affinity()
+	 * section is done. In the CPU unplug case, the current CPU is
+	 * about to vanish and will not handle any interrupts anymore. The
+	 * vector is cleaned up when the CPU comes online again.
+	 */
+	if (IS_ERR_OR_NULL(this_cpu_read(vector_irq[cfg->vector])))
+		this_cpu_write(vector_irq[cfg->vector], VECTOR_RETRIGGERED);
+
+	/* Redirect it to the new vector on the local CPU temporarily */
+	old_cfg.vector = cfg->vector;
+	irq_msi_update_msg(irqd, &old_cfg);
+
+	/* Now transition it to the target CPU */
+	irq_msi_update_msg(irqd, cfg);
+
+	/*
+	 * All interrupts after this point are now targeted at the new
+	 * vector/CPU. Check whether the transition raced with a device
+	 * interrupt and is pending in the local APICs IRR.
+	 */
+	if (lapic_vector_set_in_irr(cfg->vector))
+		irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);
+	unlock_vector_lock();
+	return ret;
+}
+
 /*
  * IRQ Chip for MSI PCI/PCI-X/PCI-Express Devices,
  * which implement the MSI or MSI-X Capability Structure.
@@ -58,6 +164,7 @@ static struct irq_chip pci_msi_controlle
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_compose_msi_msg	= irq_msi_compose_msg,
+	.irq_set_affinity	= msi_set_affinity,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
@@ -146,6 +253,8 @@ void __init arch_init_msi_domain(struct
 	}
 	if (!msi_default_domain)
 		pr_warn("failed to initialize irqdomain for MSI/MSI-x.\n");
+	else
+		msi_default_domain->flags |= IRQ_DOMAIN_MSI_NOMASK_QUIRK;
 }
 
 #ifdef CONFIG_IRQ_REMAP
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -209,6 +209,8 @@ struct irq_data {
  * IRQD_SINGLE_TARGET		- IRQ allows only a single affinity target
  * IRQD_DEFAULT_TRIGGER_SET	- Expected trigger already been set
  * IRQD_CAN_RESERVE		- Can use reservation mode
+ * IRQD_MSI_NOMASK_QUIRK	- Non-maskable MSI quirk for affinity change
+ *				  required
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -231,6 +233,7 @@ enum {
 	IRQD_SINGLE_TARGET		= (1 << 24),
 	IRQD_DEFAULT_TRIGGER_SET	= (1 << 25),
 	IRQD_CAN_RESERVE		= (1 << 26),
+	IRQD_MSI_NOMASK_QUIRK		= (1 << 27),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -390,6 +393,21 @@ static inline bool irqd_can_reserve(stru
 	return __irqd_to_state(d) & IRQD_CAN_RESERVE;
 }
 
+static inline void irqd_set_msi_nomask_quirk(struct irq_data *d)
+{
+	__irqd_to_state(d) |= IRQD_MSI_NOMASK_QUIRK;
+}
+
+static inline void irqd_clr_msi_nomask_quirk(struct irq_data *d)
+{
+	__irqd_to_state(d) &= ~IRQD_MSI_NOMASK_QUIRK;
+}
+
+static inline bool irqd_msi_nomask_quirk(struct irq_data *d)
+{
+	return __irqd_to_state(d) & IRQD_MSI_NOMASK_QUIRK;
+}
+
 #undef __irqd_to_state
 
 static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -207,6 +207,13 @@ enum {
 	IRQ_DOMAIN_FLAG_MSI_REMAP	= (1 << 5),
 
 	/*
+	 * Quirk to handle MSI implementations which do not provide
+	 * masking. Currently known to affect x86, but partially
+	 * handled in core code.
+	 */
+	IRQ_DOMAIN_MSI_NOMASK_QUIRK	= (1 << 6),
+
+	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the
 	 * core code.
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -114,6 +114,7 @@ static const struct irq_bit_descr irqdat
 	BIT_MASK_DESCR(IRQD_AFFINITY_MANAGED),
 	BIT_MASK_DESCR(IRQD_MANAGED_SHUTDOWN),
 	BIT_MASK_DESCR(IRQD_CAN_RESERVE),
+	BIT_MASK_DESCR(IRQD_MSI_NOMASK_QUIRK),
 
 	BIT_MASK_DESCR(IRQD_FORWARDED_TO_VCPU),
 
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -453,8 +453,11 @@ int msi_domain_alloc_irqs(struct irq_dom
 			continue;
 
 		irq_data = irq_domain_get_irq_data(domain, desc->irq);
-		if (!can_reserve)
+		if (!can_reserve) {
 			irqd_clr_can_reserve(irq_data);
+			if (domain->flags & IRQ_DOMAIN_MSI_NOMASK_QUIRK)
+				irqd_set_msi_nomask_quirk(irq_data);
+		}
 		ret = irq_domain_activate_irq(irq_data, can_reserve);
 		if (ret)
 			goto cleanup;
