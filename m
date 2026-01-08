Return-Path: <linux-pci+bounces-44288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EBDD045AF
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 17:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 46E6A30124DD
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A90E26E70E;
	Thu,  8 Jan 2026 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skB9EGoB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050282F85B;
	Thu,  8 Jan 2026 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767889355; cv=none; b=YGnfPSc8CxwJtO3xZ7rfW/cTptFO1ImQUTIMNHORyA+vld2bd/AkDfDoTxnyuSt1M8Bs5ohRZx5PZkLDEJ1usR6TLY8qg6J4dfNeZKFTtYUYUqnvhHjVyxa9u80lOR0alzz8ymQGSCSP3TlL+/BcR/wK8IrGioj/ywpYfh+eZbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767889355; c=relaxed/simple;
	bh=iOoqb1X4B3ENACSvtfeWkGsmtKi0caTFIo0G6PjDKmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6OfACItR5LhoK2K0q1z1LB9pG5hewZCGXXFCpJcRD229HS0qJvW8A2QTLax0WwfNtek5YU14PoumhKz/duYhu7xhcLTUYY1iky1UlfNn2N7ZRqWr6LPGDDhkgdJM+kedzWRxEtCB53MZJmn5l1p53hnEnxUQ8jB9q6VlXOibS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skB9EGoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837F8C16AAE;
	Thu,  8 Jan 2026 16:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767889354;
	bh=iOoqb1X4B3ENACSvtfeWkGsmtKi0caTFIo0G6PjDKmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=skB9EGoBJFX3QNSzUUfmWs600x//F5f+J9LsufiBe6Cg+At91NVFpblJefG7K/JIU
	 K7Ho4qAhhD70f69ro+fW7QV6SSmM7bbA/37zXzVQPlsGz8uSRPgUmQkoEhmE0fLN1H
	 F4yx3Ve7UdWKjh9Rp+xBYJQODaCLy4YnCP+S0W5/W1pc7y2TTpifpT9kcflxLXehHq
	 87nT/tJrIrCCvfgGnUgLsSnNJ90MTMNSQ7yTcF3uXRMBY5k+iQHv4f8Bt5/EHXtOOQ
	 RZVKZGgClOVTe43s1oKFVWuRjd9TB072kGt25CVUuWk3CUXp2lR76xgbewuZsxZogP
	 ZcH5eAbi13DAA==
Date: Thu, 8 Jan 2026 17:22:29 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 5/7] irqchip/gic-v5: Add ACPI IRS probing
Message-ID: <aV/Zxc3T8hANyBvg@lpieralisi>
References: <20251218-gicv5-host-acpi-v2-0-eec76cd1d40b@kernel.org>
 <20251218-gicv5-host-acpi-v2-5-eec76cd1d40b@kernel.org>
 <20260105132421.00000213@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105132421.00000213@huawei.com>

On Mon, Jan 05, 2026 at 01:24:21PM +0000, Jonathan Cameron wrote:
> On Thu, 18 Dec 2025 11:14:31 +0100
> Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> 
> > On ARM64 ACPI systems GICv5 IRSes are described in MADT sub-entries.
> > 
> > Add the required plumbing to parse MADT IRS firmware table entries and
> > probe the IRS components in ACPI.
> > 
> > Refactor the OF based probe so that common code paths can be reused for
> > ACPI as well in the process.
> > 
> > Augment the irqdomain_ops.translate() for PPI and SPI IRQs in order to
> > provide support for their ACPI based firmware translation.
> > 
> > Implement an irqchip ACPI based callback to initialize the global GSI
> > domain upon an MADT IRS detection.
> > 
> > The IRQCHIP_ACPI_DECLARE() entry in the top level GICv5 driver is only used
> > to trigger the IRS probing (ie the global GSI domain is initialized once on
> > the first call on multi-IRS systems); IRS probing takes place by calling
> > acpi_table_parse_madt() in the IRS sub-driver, that probes all IRSes
> > in sequence.
> > 
> > Add a new ACPI interrupt model so that it can be detected at runtime and
> > distinguished from previous GIC architecture models.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> Just a few minor comments inline.
> 
> > diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
> > index ce2732d649a3..07c3df5692af 100644
> > --- a/drivers/irqchip/irq-gic-v5-irs.c
> > +++ b/drivers/irqchip/irq-gic-v5-irs.c
> > @@ -5,6 +5,7 @@
> >  
> >  #define pr_fmt(fmt)	"GICv5 IRS: " fmt
> >  
> > +#include <linux/acpi.h>
> >  #include <linux/kmemleak.h>
> >  #include <linux/log2.h>
> >  #include <linux/of.h>
> > @@ -545,15 +546,15 @@ int gicv5_irs_register_cpu(int cpuid)
> >  
> >  static void __init gicv5_irs_init_bases(struct gicv5_irs_chip_data *irs_data,
> >  					void __iomem *irs_base,
> > -					struct fwnode_handle *handle)
> > +					struct fwnode_handle *handle,
> > +					bool noncoherent)
> >  {
> > -	struct device_node *np = to_of_node(handle);
> >  	u32 cr0, cr1;
> >  
> >  	irs_data->fwnode = handle;
> 
> Looking this again as you are touching it.
> 
> This feels a tiny bit out of place, as not obvious to me why the fwnode being
> set is related to initializing bases.  Perhaps that belongs at the caller?

Done.

> >  	irs_data->irs_base = irs_base;
> >  
> > -	if (of_property_read_bool(np, "dma-noncoherent")) {
> > +	if (noncoherent) {
> >  		/*
> >  		 * A non-coherent IRS implies that some cache levels cannot be
> >  		 * used coherently by the cores and GIC. Our only option is to mark
> > @@ -678,49 +679,13 @@ static void irs_setup_pri_bits(u32 idr1)
> >  	}
> >  }
> >  
> 
> ...
> 
> > +static int __init gicv5_irs_of_init(struct device_node *node)
> > +{
> 
> Not sure whether it would be worth it by inclination would have been
> a noop refactor patch, then the ACPI support. I'd have found it a little
> bit easier to review.

Split it into two patches.

> > +	struct gicv5_irs_chip_data *irs_data;
> > +	void __iomem *irs_base;
> > +	u8 iaffid_bits;
> > +	u32 idr;
> > +	int ret;
> > +
> > +	irs_data = kzalloc(sizeof(*irs_data), GFP_KERNEL);
> > +	if (!irs_data)
> > +		return -ENOMEM;
> > +
> > +	raw_spin_lock_init(&irs_data->spi_config_lock);
> > +
> > +	ret = of_property_match_string(node, "reg-names", "ns-config");
> > +	if (ret < 0) {
> > +		pr_err("%pOF: ns-config reg-name not present\n", node);
> > +		goto out_err;
> 
> Obviously comes form original code, but this label could give some indication
> of where we are going and why. out_free_data maybe?

I could probably change it (or better sneak it in) in this set, though
as you said it could well be a standalone change.

> Perhaps I'm just being fussy as I had to open the code up to check given
> it didn't end up in the context.
> 
> > +	}
> > +
> ...
> 
> > +static int __init gic_acpi_parse_iaffid(union acpi_subtable_headers *header,
> > +					const unsigned long end)
> > +{
> > +	struct acpi_madt_generic_interrupt *gicc = (struct acpi_madt_generic_interrupt *)header;
> > +	int cpu;
> > +
> > +	if (!(gicc->flags & (ACPI_MADT_ENABLED | ACPI_MADT_GICC_ONLINE_CAPABLE)))
> > +		return 0;
> > +
> > +	if (gicc->irs_id == current_irsid) {
> Unless this is going to get more complex I'd flip the log for an early return on
> 'not this one'
> 	if (gicc->irs_id != current_irsid)
> 		return 0;
> 
> mostly to save on long lines where they aren't needed.

Done.

> > +		cpu = get_logical_index(gicc->arm_mpidr);
> > +
> > +		if (gicc->iaffid & ~GENMASK(current_iaffid_bits - 1, 0)) {
> > +			pr_warn("CPU %d iaffid 0x%x exceeds IRS iaffid bits\n", cpu, gicc->iaffid);
> > +			return 0;
> > +		}
> > +
> > +		// Bind the IAFFID and the CPU
> > +		per_cpu(cpu_iaffid, cpu).iaffid = gicc->iaffid;
> > +		per_cpu(cpu_iaffid, cpu).valid = true;
> > +		pr_debug("Processed IAFFID %u for CPU%d", per_cpu(cpu_iaffid, cpu).iaffid, cpu);
> > +
> > +		// We also know that the CPU is connected to this IRS
> > +		per_cpu(per_cpu_irs_data, cpu) = current_irs_data;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init gicv5_irs_acpi_init_affinity(u32 irsid, struct gicv5_irs_chip_data *irs_data)
> > +{
> > +	u32 idr;
> > +
> > +	current_irsid = irsid;
> > +	current_irs_data = irs_data;
> > +
> > +	idr = irs_readl_relaxed(irs_data, GICV5_IRS_IDR1);
> > +	current_iaffid_bits = FIELD_GET(GICV5_IRS_IDR1_IAFFID_BITS, idr) + 1;
> > +
> > +	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT, gic_acpi_parse_iaffid, 0);
> > +
> > +	return 0;
> > +}
> 
> > +
> > +static int __init gic_acpi_parse_madt_irs(union acpi_subtable_headers *header,
> > +					  const unsigned long end)
> > +{
> > +	struct acpi_madt_gicv5_irs *irs = (struct acpi_madt_gicv5_irs *)header;
> > +	struct gicv5_irs_chip_data *irs_data;
> > +	void __iomem *irs_base;
> > +	struct resource *r;
> > +	int ret;
> > +
> > +	// Per-IRS data structure
> 
> It's your code to look after, so I don't care that strongly but this does
> seem to be inconsistent wrt to local style and use of C style
> single line comments.  I'd stick to /* */ throughout.

+1

> > +	irs_data = kzalloc(sizeof(*irs_data), GFP_KERNEL);
> > +	if (!irs_data)
> > +		return -ENOMEM;
> > +
> > +	// This spinlock is used for SPI config changes
> > +	raw_spin_lock_init(&irs_data->spi_config_lock);
> > +
> > +	irs_base = ioremap(irs->config_base_address, ACPI_GICV5_IRS_MEM_SIZE);
> > +	if (!irs_base) {
> > +		pr_err("Unable to map GIC IRS registers\n");
> > +		ret = -ENOMEM;
> > +		goto out_free;
> > +	}
> > +
> > +	r = gic_request_region(irs->config_base_address, ACPI_GICV5_IRS_MEM_SIZE, "GICv5 IRS");
> 
> Really minor but I wonder if this should follow the same ordering as
> of_io_request_and_map() which does the request_mem_region() before
> trying to ioremap()?

That would make sense, yes.

> Nice to have the same ordering though that would then put you at odds iwth the
> gicv3 redist code that does it in this order.  Guess can't win them all and
> an ephemeral mapping that is then torn down on error of the second call
> doesn't really matter.  
> 
> > +	if (!r) {
> > +		ret = -EBUSY;
> > +		goto out_map;
> > +	}
> > +
> > +	gicv5_irs_init_bases(irs_data, irs_base, NULL, irs->flags & ACPI_MADT_IRS_NON_COHERENT);
> > +
> > +	gicv5_irs_acpi_init_affinity(irs->irs_id, irs_data);
> > +
> > +	ret = gicv5_irs_init(irs_data);
> > +	if (ret)
> > +		goto out_release;
> > +
> > +	if (irs_data->spi_range) {
> > +		pr_info("%s @%llx detected SPI range [%u-%u]\n", "IRS", irs->config_base_address,
> > +									irs_data->spi_min,
> > +									irs_data->spi_min +
> > +									irs_data->spi_range - 1);
> > +	}
> > +
> > +	return 0;
> > +
> > +out_release:
> > +	release_mem_region(r->start, resource_size(r));
> > +out_map:
> > +	iounmap(irs_base);
> > +out_free:
> > +	kfree(irs_data);
> > +	return ret;
> > +}
> 
> > diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
> > index 41ef286c4d78..23fd551c4347 100644
> > --- a/drivers/irqchip/irq-gic-v5.c
> > +++ b/drivers/irqchip/irq-gic-v5.c
> > @@ -579,16 +579,36 @@ static __always_inline int gicv5_irq_domain_translate(struct irq_domain *d,
> >  						      unsigned int *type,
> >  						      const u8 hwirq_type)
> >  {
> > -	if (!is_of_node(fwspec->fwnode))
> > -		return -EINVAL;
> > +	unsigned int hwirq_trigger;
> > +	u8 fwspec_irq_type;
> >  
> > -	if (fwspec->param_count < 3)
> > -		return -EINVAL;
> > +	if (is_of_node(fwspec->fwnode)) {
> >  
> > -	if (fwspec->param[0] != hwirq_type)
> > -		return -EINVAL;
> > +		if (fwspec->param_count < 3)
> > +			return -EINVAL;
> >  
> > -	*hwirq = fwspec->param[1];
> > +		fwspec_irq_type = fwspec->param[0];
> > +
> > +		if (fwspec->param[0] != hwirq_type)
> > +			return -EINVAL;
> > +
> > +		*hwirq = fwspec->param[1];
> > +		hwirq_trigger = fwspec->param[2];
> > +	}
> > +
> > +	if (is_fwnode_irqchip(fwspec->fwnode)) {
> > +
> > +		if (fwspec->param_count != 2)
> > +			return -EINVAL;
> > +
> > +		fwspec_irq_type = FIELD_GET(GICV5_HWIRQ_TYPE, fwspec->param[0]);
> > +
> > +		if (fwspec_irq_type != hwirq_type)
> > +			return -EINVAL;
> > +
> > +		*hwirq = FIELD_GET(GICV5_HWIRQ_ID, fwspec->param[0]);
> > +		hwirq_trigger = fwspec->param[1];
> > +	}
> >  
> >  	switch (hwirq_type) {
> >  	case GICV5_HWIRQ_TYPE_PPI:
> > @@ -600,7 +620,7 @@ static __always_inline int gicv5_irq_domain_translate(struct irq_domain *d,
> >  							 IRQ_TYPE_EDGE_RISING;
> >  		break;
> >  	case GICV5_HWIRQ_TYPE_SPI:
> > -		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
> > +		*type = hwirq_trigger & IRQ_TYPE_SENSE_MASK;
> >  		break;
> >  	default:
> >  		BUILD_BUG_ON(1);
> > @@ -660,10 +680,18 @@ static void gicv5_irq_domain_free(struct irq_domain *domain, unsigned int virq,
> >  static int gicv5_irq_ppi_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
> >  				       enum irq_domain_bus_token bus_token)
> >  {
> > +	u32 hwirq_type;
> > +
> >  	if (fwspec->fwnode != d->fwnode)
> >  		return 0;
> >  
> > -	if (fwspec->param[0] != GICV5_HWIRQ_TYPE_PPI)
> > +	if (is_of_node(fwspec->fwnode))
> > +		hwirq_type = fwspec->param[0];
> > +
> > +	if (is_fwnode_irqchip(fwspec->fwnode))
> > +		hwirq_type = FIELD_GET(GICV5_HWIRQ_TYPE, fwspec->param[0]);
> 
> Bit borderline but maybe worth a helper for getting the irq type from
> the fwspec? Or a more generic helper that optionally gets that and the other
> stuff you need in gicv5_irq_domain_translate()

I will think about this one, first let's make sure the series is ready.

Lorenzo

> > +
> > +	if (hwirq_type != GICV5_HWIRQ_TYPE_PPI)
> >  		return 0;
> >  
> >  	return (d == gicv5_global_data.ppi_domain);
> > @@ -718,10 +746,18 @@ static int gicv5_irq_spi_domain_alloc(struct irq_domain *domain, unsigned int vi
> >  static int gicv5_irq_spi_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
> >  				       enum irq_domain_bus_token bus_token)
> >  {
> > +	u32 hwirq_type;
> > +
> >  	if (fwspec->fwnode != d->fwnode)
> >  		return 0;
> >  
> > -	if (fwspec->param[0] != GICV5_HWIRQ_TYPE_SPI)
> > +	if (is_of_node(fwspec->fwnode))
> > +		hwirq_type = fwspec->param[0];
> > +
> > +	if (is_fwnode_irqchip(fwspec->fwnode))
> > +		hwirq_type = FIELD_GET(GICV5_HWIRQ_TYPE, fwspec->param[0]);
> > +
> > +	if (hwirq_type != GICV5_HWIRQ_TYPE_SPI)
> >  		return 0;
> >  
> >  	return (d == gicv5_global_data.spi_domain);
> > @@ -1082,16 +1118,12 @@ static inline void __init gic_of_setup_kvm_info(struct device_node *node)
> >  }
> >  #endif // CONFIG_KVM
> 
> Thanks,
> 
> Jonathan
> 

