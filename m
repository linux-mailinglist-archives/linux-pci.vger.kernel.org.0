Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B82A114EE63
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2020 15:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgAaO1H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jan 2020 09:27:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55683 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgAaO1H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jan 2020 09:27:07 -0500
Received: from [195.177.82.11] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ixXG7-000731-9Q; Fri, 31 Jan 2020 15:26:59 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 150DF105BE6; Fri, 31 Jan 2020 15:26:52 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Evan Green <evgreen@chromium.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org, Marc Zyngier <maz@kernel.org>
Subject: [PATCH V2] x86/apic/msi: Plug non-maskable MSI affinity race
In-Reply-To: <87lfpn50id.fsf@nanos.tec.linutronix.de>
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
 <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com>
 <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com>
 <87y2tytv5i.fsf@nanos.tec.linutronix.de>
 <87eevqkpgn.fsf@nanos.tec.linutronix.de>
 <CAE=gft6YiM5S1A7iJYJTd5zmaAa8=nhLE3B94JtWa+XW-qVSqQ@mail.gmail.com>
 <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com>
 <CAE=gft7MqQ3Mej5oCT=gw6ZLMSTHoSyMGOFz=-hae-eRZvXLxA@mail.gmail.com>
 <87d0b82a9o.fsf@nanos.tec.linutronix.de>
 <CAE=gft7C5HTmcTLsXqXbCtcYDeKG6bCJ0gmgwVNc0PDHLJ5y_A@mail.gmail.com>
 <878slwmpu9.fsf@nanos.tec.linutronix.de>
 <87imkv63yf.fsf@nanos.tec.linutronix.de>
 <CAE=gft7Gu0ah4qcbsEB1X+kUMagCzPR+cdCfn2caofcGV+tBjA@mail.gmail.com>
 <87pnf342pr.fsf@nanos.tec.linutronix.de>
 <CAE=gft69hQcbmT46b1T8eLdPFyb9Pp-sDYd5JfPsZ2JWL4PXqQ@mail.gmail.com>
 <877e1a2d11.fsf@nanos.tec.linutronix.de>
 <CAE=gft7mLAU3G+f8gi_etRSpUijoCh7_6ni9Ob2JqjW7Q1n3yQ@mail.gmail.com>
 <874kwd3lbn.fsf@nanos.tec.linutronix.de>
 <CAE=gft52iBTJyyvDTXeHdEYnpSSROvrQsweuXjd6OuaLO47ACw@mail.gmail.com>
 <87lfpn50id.fsf@nanos.tec.linutronix.de>
Date:   Fri, 31 Jan 2020 15:26:52 +0100
Message-ID: <87imkr4s7n.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

Evan tracked down a subtle race between the update of the MSI message and
the device raising an interrupt internally on PCI devices which do not
support MSI masking. The update of the MSI message is non-atomic and
consists of either 2 or 3 sequential 32bit wide writes to the PCI config
space. 

   - Write address low 32bits
   - Write address high 32bits (If supported by device)
   - Write data

When an interrupt is migrated then both address and data might change, so
the kernel attempts to mask the MSI interrupt first. But for MSI masking is
optional, so there exist devices which do not provide it. That means that
if the device raises an interrupt internally between the writes and MSI
message is sent built from half updated state.

On x86 this can lead to spurious interrupts on the wrong interrupt
vector when the affinity setting changes both address and data. As a
consequence the device interrupt can be lost causing the device to
become stuck or malfunctioning.

Evan tried to handle that by disabling MSI accross an MSI message
update. That's not feasible because disabling MSI has issues on its own:

 If MSI is disabled the PCI device is routing an interrupt to the legacy
 INTx mechanism. The INTx delivery can be disabled, but the disablement is
 not working on all devices.

 Some devices lose interrupts when both MSI and INTx delivery are disabled.

Another way to solve this would be to enforce the allocation of the same
vector on all CPUs in the system for this kind of screwed devices. That
could be done, but it would bring back the vector space exhaustion problems
which got solved a few years ago.

Fortunately the high address (if supported by the device) is only relevant
when X2APIC is enabled which implies interrupt remapping. In the interrupt
remapping case the affinity setting is happening at the interrupt remapping
unit and the PCI MSI message is programmed only once when the PCI device is
initialized.

That makes it possible to solve it with a two step update:

  1) Target the MSI msg to the new vector on the current target CPU

  2) Target the MSI msg to the new vector on the new target CPU

In both cases writing the MSI message is only changing a single 32bit word
which prevents the issue of inconsistency.

After writing the final destination it is necessary to check whether the
device issued an interrupt while the intermediate state #1 (new vector,
current CPU) was in effect.

This is possible because the affinity change is always happening on the
current target CPU. The code runs with interrupts disabled, so the
interrupt can be detected by checking the IRR of the local APIC. If the
vector is pending in the IRR then the interrupt is retriggered on the new
target CPU by sending an IPI for the associated vector on the target CPU.

This can cause spurious interrupts on both the local and the new target
CPU.

 1) If the new vector is not in use on the local CPU and the device
    affected by the affinity change raised an interrupt during the
    transitional state (step #1 above) then interrupt entry code will
    ignore that spurious interrupt. The vector is marked so that the
    'No irq handler for vector' warning is supressed once.

 2) If the new vector is in use already on the local CPU then the IRR check
    might see an pending interrupt from the device which is using this
    vector. The IPI to the new target CPU will then invoke the handler of
    the device, which got the affinity change, even if that device did not
    issue an interrupt

 3) If the new vector is in use already on the local CPU and the device
    affected by the affinity change raised an interrupt during the
    transitional state (step #1 above) then the handler of the device which
    uses that vector on the local CPU will be invoked.

#1 is uninteresting and has no unintended side effects. #2 and #3 might
expose issues in device driver interrupt handlers which are not prepared to
handle a spurious interrupt correctly. This not a regression, it's just
exposing something which was already broken as spurious interrupts can
happen for a lot of reasons and all driver handlers need to be able to deal
with them.

Reported-by: Evan Green <evgreen@chromium.org>
Debugged-by: Evan Green <evgreen@chromium.org>                                                                                        Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Rajat Jain <rajatja@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: x86@kernel.org
Cc: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---

V2: Add the missing bracket ....

@stable: The Fixes tag is missing intentionally, as this problem has
been there forever. The rework of the vector allocation logic just made
it more likely to be observable.

---
 arch/x86/include/asm/apic.h |    8 ++
 arch/x86/kernel/apic/msi.c  |  128 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/irq.h         |   18 ++++++
 include/linux/irqdomain.h   |    7 ++
 kernel/irq/debugfs.c        |    1 
 kernel/irq/msi.c            |    5 +
 6 files changed, 163 insertions(+), 4 deletions(-)

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
@@ -47,6 +45,127 @@ static void irq_msi_compose_msg(struct i
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
+	 * vector/CPU.
+	 *
+	 * Drop vector lock before testing whether the temporary assignment
+	 * to the local CPU was hit by an interrupt raised in the device,
+	 * because the retrigger function acquires vector lock again.
+	 */
+	unlock_vector_lock();
+
+	/*
+	 * Check whether the transition raced with a device interrupt and
+	 * is pending in the local APICs IRR. It is safe to do this outside
+	 * of vector lock as the irq_desc::lock of this interrupt is still
+	 * held and interrupts are disabled: The check is not accessing the
+	 * underlying vector store. It's just checking the local APIC's
+	 * IRR.
+	 */
+	if (lapic_vector_set_in_irr(cfg->vector))
+		irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);
+
+	return ret;
+}
+
 /*
  * IRQ Chip for MSI PCI/PCI-X/PCI-Express Devices,
  * which implement the MSI or MSI-X Capability Structure.
@@ -58,6 +177,7 @@ static struct irq_chip pci_msi_controlle
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_compose_msi_msg	= irq_msi_compose_msg,
+	.irq_set_affinity	= msi_set_affinity,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
@@ -146,6 +266,8 @@ void __init arch_init_msi_domain(struct
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
