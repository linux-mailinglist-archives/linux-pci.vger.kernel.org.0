Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3849E51DF1F
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 20:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbiEFSek (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 14:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiEFSek (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 14:34:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66646D4DD;
        Fri,  6 May 2022 11:30:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6263662154;
        Fri,  6 May 2022 18:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BC9C385A8;
        Fri,  6 May 2022 18:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651861854;
        bh=FkN04EloTtuPxgR0bSvk+Lk4xOANic4or5xe50i6rY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IFtpYuRKscAivolwJtsnW7BAYle6d72Agn3W+8Qw3RtCtoAl4gGJt38HJqXj8vUE9
         VtNgxvlQFPOw1b1pMQxNc5AT821G/+oPNFMWoVktJezoyoOaV5IPreIR9kPvAZpPwz
         Mmz/Pcay+ufBdQLsSVN75dbcmv8eMo8b7RpsnKGQ1/OIjpU1L3JCIjVDvc/9F4R29t
         14dCzpGPA4tUbXno8/nHTXibHkmi8qhMro7m0lcwzZuoLCsQUChB51UGS4r2FOEN8c
         YH7BcrR3vaCjZl6oiWwWHCYkUaQgUvHaL2mOhYYbVupSlZkgJIkieNB3b/8rdAR8B6
         ynvi1RAe6UTDg==
Received: by pali.im (Postfix)
        id 676471141; Fri,  6 May 2022 20:30:51 +0200 (CEST)
Date:   Fri, 6 May 2022 20:30:51 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/6] irqchip/armada-370-xp: Implement SoC Error interrupts
Message-ID: <20220506183051.wimo7p4nuqfnl2aj@pali>
References: <20220506134029.21470-1-pali@kernel.org>
 <20220506134029.21470-3-pali@kernel.org>
 <87mtfu7ccd.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mtfu7ccd.wl-maz@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 06 May 2022 19:19:46 Marc Zyngier wrote:
> On Fri, 06 May 2022 14:40:25 +0100,
> Pali Rohár <pali@kernel.org> wrote:
> > 
> > MPIC IRQ 4 is used as SoC Error Summary interrupt and provides access to
> > another hierarchy of SoC Error interrupts. Implement a new IRQ chip and
> > domain for accessing this IRQ hierarchy.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  drivers/irqchip/irq-armada-370-xp.c | 213 +++++++++++++++++++++++++++-
> >  1 file changed, 210 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
> > index ebd76ea1c69b..71578b65f5c8 100644
> > --- a/drivers/irqchip/irq-armada-370-xp.c
> > +++ b/drivers/irqchip/irq-armada-370-xp.c
> > @@ -117,6 +117,8 @@
> >  /* Registers relative to main_int_base */
> >  #define ARMADA_370_XP_INT_CONTROL		(0x00)
> >  #define ARMADA_370_XP_SW_TRIG_INT_OFFS		(0x04)
> > +#define ARMADA_370_XP_INT_SOC_ERR_0_CAUSE_OFFS	(0x20)
> > +#define ARMADA_370_XP_INT_SOC_ERR_1_CAUSE_OFFS	(0x24)
> >  #define ARMADA_370_XP_INT_SET_ENABLE_OFFS	(0x30)
> >  #define ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS	(0x34)
> >  #define ARMADA_370_XP_INT_SOURCE_CTL(irq)	(0x100 + irq*4)
> > @@ -130,6 +132,8 @@
> >  #define ARMADA_370_XP_CPU_INTACK_OFFS		(0x44)
> >  #define ARMADA_370_XP_INT_SET_MASK_OFFS		(0x48)
> >  #define ARMADA_370_XP_INT_CLEAR_MASK_OFFS	(0x4C)
> > +#define ARMADA_370_XP_INT_SOC_ERR_0_MASK_OFF	(0x50)
> > +#define ARMADA_370_XP_INT_SOC_ERR_1_MASK_OFF	(0x54)
> >  #define ARMADA_370_XP_INT_FABRIC_MASK_OFFS	(0x54)
> >  #define ARMADA_370_XP_INT_CAUSE_PERF(cpu)	(1 << cpu)
> >  
> > @@ -146,6 +150,8 @@
> >  static void __iomem *per_cpu_int_base;
> >  static void __iomem *main_int_base;
> >  static struct irq_domain *armada_370_xp_mpic_domain;
> > +static struct irq_domain *armada_370_xp_soc_err_domain;
> > +static unsigned int soc_err_irq_num_regs;
> >  static u32 doorbell_mask_reg;
> >  static int parent_irq;
> >  #ifdef CONFIG_PCI_MSI
> > @@ -156,6 +162,8 @@ static DEFINE_MUTEX(msi_used_lock);
> >  static phys_addr_t msi_doorbell_addr;
> >  #endif
> >  
> > +static void armada_370_xp_soc_err_irq_unmask(struct irq_data *d);
> > +
> >  static inline bool is_percpu_irq(irq_hw_number_t irq)
> >  {
> >  	if (irq <= ARMADA_370_XP_MAX_PER_CPU_IRQS)
> > @@ -509,6 +517,27 @@ static void armada_xp_mpic_reenable_percpu(void)
> >  		armada_370_xp_irq_unmask(data);
> >  	}
> >  
> > +	/* Re-enable per-CPU SoC Error interrupts that were enabled before suspend */
> > +	for (irq = 0; irq < soc_err_irq_num_regs * 32; irq++) {
> > +		struct irq_data *data;
> > +		int virq;
> > +
> > +		virq = irq_linear_revmap(armada_370_xp_soc_err_domain, irq);
> > +		if (virq == 0)
> > +			continue;
> > +
> > +		data = irq_get_irq_data(virq);
> > +
> > +		if (!irq_percpu_is_enabled(virq))
> > +			continue;
> > +
> > +		armada_370_xp_soc_err_irq_unmask(data);
> > +	}
> 
> So you do this loop and all these lookups, both here and in the resume
> function (duplicated code!) just to be able to call the unmask
> function?  This would be better served by two straight writes of the
> mask register, which you'd conveniently save on suspend.
> 
> Yes, you have only duplicated the existing logic. But surely there is
> something better to do.

Yes, I just used existing logic.

I'm not rewriting driver or doing big refactor of it, as this is not in
the scope of the PCIe AER interrupt support.

> > +
> > +	/* Unmask summary SoC Error Interrupt */
> > +	if (soc_err_irq_num_regs > 0)
> > +		writel(4, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
> > +
> >  	ipi_resume();
> >  }
> >  
> > @@ -546,8 +575,8 @@ static struct irq_chip armada_370_xp_irq_chip = {
> >  static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
> >  				      unsigned int virq, irq_hw_number_t hw)
> >  {
> > -	/* IRQs 0 and 1 cannot be mapped, they are handled internally */
> > -	if (hw <= 1)
> > +	/* IRQs 0, 1 and 4 cannot be mapped, they are handled internally */
> > +	if (hw <= 1 || hw == 4)
> >  		return -EINVAL;
> >  
> >  	armada_370_xp_irq_mask(irq_get_irq_data(virq));
> > @@ -577,6 +606,99 @@ static const struct irq_domain_ops armada_370_xp_mpic_irq_ops = {
> >  	.xlate = irq_domain_xlate_onecell,
> >  };
> >  
> > +static DEFINE_RAW_SPINLOCK(armada_370_xp_soc_err_lock);
> > +
> > +static void armada_370_xp_soc_err_irq_mask(struct irq_data *d)
> > +{
> > +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> > +	u32 reg, mask;
> > +
> > +	reg = hwirq >= 32 ? ARMADA_370_XP_INT_SOC_ERR_1_MASK_OFF
> > +			  : ARMADA_370_XP_INT_SOC_ERR_0_MASK_OFF;
> > +
> > +	raw_spin_lock(&armada_370_xp_soc_err_lock);
> > +	mask = readl(per_cpu_int_base + reg);
> > +	mask &= ~BIT(hwirq % 32);
> > +	writel(mask, per_cpu_int_base + reg);
> > +	raw_spin_unlock(&armada_370_xp_soc_err_lock);
> > +}
> > +
> > +static void armada_370_xp_soc_err_irq_unmask(struct irq_data *d)
> > +{
> > +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> > +	u32 reg, mask;
> > +
> > +	reg = hwirq >= 32 ? ARMADA_370_XP_INT_SOC_ERR_1_MASK_OFF
> > +			  : ARMADA_370_XP_INT_SOC_ERR_0_MASK_OFF;
> > +
> > +	raw_spin_lock(&armada_370_xp_soc_err_lock);
> > +	mask = readl(per_cpu_int_base + reg);
> > +	mask |= BIT(hwirq % 32);
> > +	writel(mask, per_cpu_int_base + reg);
> > +	raw_spin_unlock(&armada_370_xp_soc_err_lock);
> > +}
> > +
> > +static int armada_370_xp_soc_err_irq_mask_on_cpu(void *par)
> > +{
> > +	struct irq_data *d = par;
> > +	armada_370_xp_soc_err_irq_mask(d);
> > +	return 0;
> > +}
> > +
> > +static int armada_370_xp_soc_err_irq_unmask_on_cpu(void *par)
> > +{
> > +	struct irq_data *d = par;
> > +	armada_370_xp_soc_err_irq_unmask(d);
> > +	return 0;
> > +}
> > +
> > +static int armada_xp_soc_err_irq_set_affinity(struct irq_data *d,
> > +					      const struct cpumask *mask,
> > +					      bool force)
> > +{
> > +	unsigned int cpu;
> > +
> > +	cpus_read_lock();
> > +
> > +	/* First disable IRQ on all cores */
> > +	for_each_online_cpu(cpu)
> > +		smp_call_on_cpu(cpu, armada_370_xp_soc_err_irq_mask_on_cpu, d, true);
> > +
> > +	/* Select a single core from the affinity mask which is online */
> > +	cpu = cpumask_any_and(mask, cpu_online_mask);
> > +	smp_call_on_cpu(cpu, armada_370_xp_soc_err_irq_unmask_on_cpu, d, true);
> > +
> > +	cpus_read_unlock();
> > +
> > +	irq_data_update_effective_affinity(d, cpumask_of(cpu));
> > +
> > +	return IRQ_SET_MASK_OK;
> > +}
> 
> Aren't these per-CPU interrupts anyway? What does it mean to set their
> affinity? /me rolls eyes...

Yes, they are per-CPU interrupts. But to mask or unmask particular
interrupt for specific CPU is possible only from that CPU. CPU 0 just
cannot move interrupt from CPU 0 to CPU 1. CPU 0 can only mask that
interrupt and CPU 1 has to unmask it.

> > +
> > +static struct irq_chip armada_370_xp_soc_err_irq_chip = {
> > +	.name = "MPIC SOC",
> > +	.irq_mask = armada_370_xp_soc_err_irq_mask,
> > +	.irq_unmask = armada_370_xp_soc_err_irq_unmask,
> > +	.irq_set_affinity = armada_xp_soc_err_irq_set_affinity,
> > +};
> > +
> > +static int armada_370_xp_soc_err_irq_map(struct irq_domain *h,
> > +					 unsigned int virq, irq_hw_number_t hw)
> > +{
> > +	armada_370_xp_soc_err_irq_mask(irq_get_irq_data(virq));
> > +	irq_set_status_flags(virq, IRQ_LEVEL);
> > +	irq_set_percpu_devid(virq);
> > +	irq_set_chip_and_handler(virq, &armada_370_xp_soc_err_irq_chip,
> > +				 handle_percpu_devid_irq);
> > +	irq_set_probe(virq);
> > +	return 0;
> > +}
> > +
> > +static const struct irq_domain_ops armada_370_xp_soc_err_irq_ops = {
> > +	.map = armada_370_xp_soc_err_irq_map,
> > +	.xlate = irq_domain_xlate_onecell,
> > +};
> > +
> >  #ifdef CONFIG_PCI_MSI
> >  static void armada_370_xp_handle_msi_irq(struct pt_regs *regs, bool is_chained)
> >  {
> > @@ -605,6 +727,32 @@ static void armada_370_xp_handle_msi_irq(struct pt_regs *regs, bool is_chained)
> >  static void armada_370_xp_handle_msi_irq(struct pt_regs *r, bool b) {}
> >  #endif
> >  
> > +static void armada_370_xp_handle_soc_err_irq(void)
> > +{
> > +	unsigned long status, bit;
> > +	u32 mask, cause;
> > +
> > +	if (soc_err_irq_num_regs < 1)
> > +		return;
> > +
> > +	mask = readl(per_cpu_int_base + ARMADA_370_XP_INT_SOC_ERR_0_MASK_OFF);
> > +	cause = readl(main_int_base + ARMADA_370_XP_INT_SOC_ERR_0_CAUSE_OFFS);
> > +	status = cause & mask;
> > +
> > +	for_each_set_bit(bit, &status, 32)
> > +		generic_handle_domain_irq(armada_370_xp_soc_err_domain, bit);
> > +
> > +	if (soc_err_irq_num_regs < 2)
> > +		return;
> > +
> > +	mask = readl(per_cpu_int_base + ARMADA_370_XP_INT_SOC_ERR_1_MASK_OFF);
> > +	cause = readl(main_int_base + ARMADA_370_XP_INT_SOC_ERR_1_CAUSE_OFFS);
> > +	status = cause & mask;
> > +
> > +	for_each_set_bit(bit, &status, 32)
> > +		generic_handle_domain_irq(armada_370_xp_soc_err_domain, bit + 32);
> > +}
> > +
> >  static void armada_370_xp_mpic_handle_cascade_irq(struct irq_desc *desc)
> >  {
> >  	struct irq_chip *chip = irq_desc_get_chip(desc);
> > @@ -630,6 +778,11 @@ static void armada_370_xp_mpic_handle_cascade_irq(struct irq_desc *desc)
> >  			continue;
> >  		}
> >  
> > +		if (irqn == 4) {
> > +			armada_370_xp_handle_soc_err_irq();
> > +			continue;
> > +		}
> > +
> >  		generic_handle_domain_irq(armada_370_xp_mpic_domain, irqn);
> >  	}
> >  
> > @@ -649,7 +802,7 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
> >  		if (irqnr > 1022)
> >  			break;
> >  
> > -		if (irqnr > 1) {
> > +		if (irqnr > 1 && irqnr != 4) {
> >  			generic_handle_domain_irq(armada_370_xp_mpic_domain,
> >  						  irqnr);
> >  			continue;
> > @@ -659,6 +812,10 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
> >  		if (irqnr == 1)
> >  			armada_370_xp_handle_msi_irq(regs, false);
> >  
> > +		/* SoC Error handling */
> > +		if (irqnr == 4)
> > +			armada_370_xp_handle_soc_err_irq();
> > +
> >  #ifdef CONFIG_SMP
> >  		/* IPI Handling */
> >  		if (irqnr == 0) {
> > @@ -722,6 +879,26 @@ static void armada_370_xp_mpic_resume(void)
> >  		}
> >  	}
> >  
> > +	/* Re-enable per-CPU SoC Error interrupts */
> > +	for (irq = 0; irq < soc_err_irq_num_regs * 32; irq++) {
> > +		struct irq_data *data;
> > +		int virq;
> > +
> > +		virq = irq_linear_revmap(armada_370_xp_soc_err_domain, irq);
> > +		if (virq == 0)
> > +			continue;
> > +
> > +		data = irq_get_irq_data(virq);
> > +
> > +		/*
> > +		 * Re-enable on the current CPU,
> > +		 * armada_xp_mpic_reenable_percpu() will take
> > +		 * care of secondary CPUs when they come up.
> > +		 */
> > +		if (irq_percpu_is_enabled(virq))
> > +			armada_370_xp_soc_err_irq_unmask(data);
> > +	}
> 
> As I said above, this is duplicated code that should be replaced with
> a simple write to the corresponding MMIO registers.
> 
> > +
> >  	/* Reconfigure doorbells for IPIs and MSIs */
> >  	writel(doorbell_mask_reg,
> >  	       per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
> > @@ -730,6 +907,10 @@ static void armada_370_xp_mpic_resume(void)
> >  	if (doorbell_mask_reg & PCI_MSI_DOORBELL_MASK)
> >  		writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
> >  
> > +	/* Unmask summary SoC Error Interrupt */
> > +	if (soc_err_irq_num_regs > 0)
> > +		writel(4, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
> 
> Magic value?
> 
> Also, writing to this register tends to indicate that the whole thing
> should really be a chained irqchip... Maybe that's overkill in this
> instance, but the whole thing is rather oddly architected.

I used exactly same code style like it is used for MSI doorbell
interrupts.

Yes, it looks like chained irqchip, but it is overkill.

> > +
> >  	ipi_resume();
> >  }
> >  
> > @@ -742,6 +923,7 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
> >  					     struct device_node *parent)
> >  {
> >  	struct resource main_int_res, per_cpu_int_res;
> > +	struct device_node *soc_err_node;
> >  	int nr_irqs, i;
> >  	u32 control;
> >  
> > @@ -775,12 +957,37 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
> >  	BUG_ON(!armada_370_xp_mpic_domain);
> >  	irq_domain_update_bus_token(armada_370_xp_mpic_domain, DOMAIN_BUS_WIRED);
> >  
> > +	soc_err_node = of_get_next_child(node, NULL);
> > +	if (!soc_err_node) {
> > +		pr_warn("Missing SoC Error Interrupt Controller node\n");
> > +		pr_warn("Extended interrupts are not supported\n");
> > +	} else {
> > +		pr_info("Registering MPIC SoC Error Interrupt Controller\n");
> > +		/*
> > +		 * Armada 370 and XP have only 32 SoC Error IRQs in one register
> > +		 * and other Armada platforms have 64 IRQs in two registers.
> > +		 */
> > +		soc_err_irq_num_regs =
> > +			of_machine_is_compatible("marvell,armada-370-xp") ? 1 : 2;
> 
> Don't you have an actual compatible string for the interrupt
> controller?  It seems odd to rely on the SoC name.

Compatible string is same for all those 32-bit Armada SoCs. So it cannot
be used to distinguish between XP and 385. That is why I used
of_machine_is_compatible.

> > +		armada_370_xp_soc_err_domain =
> > +			irq_domain_add_hierarchy(armada_370_xp_mpic_domain, 0,
> > +						 soc_err_irq_num_regs * 32,
> > +						 soc_err_node,
> > +						 &armada_370_xp_soc_err_irq_ops,
> > +						 NULL);
> > +		BUG_ON(!armada_370_xp_soc_err_domain);
> > +	}
> > +
> >  	/* Setup for the boot CPU */
> >  	armada_xp_mpic_perf_init();
> >  	armada_xp_mpic_smp_cpu_init();
> >  
> >  	armada_370_xp_msi_init(node, main_int_res.start);
> >  
> > +	/* Unmask summary SoC Error Interrupt */
> > +	if (soc_err_irq_num_regs > 0)
> > +		writel(4, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
> > +
> 
> Magic value, duplicated this time?
> 
> >  	parent_irq = irq_of_parse_and_map(node, 0);
> >  	if (parent_irq <= 0) {
> >  		irq_set_default_host(armada_370_xp_mpic_domain);
> > -- 
> > 2.20.1
> > 
> > 
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
