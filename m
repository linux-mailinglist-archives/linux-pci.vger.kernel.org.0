Return-Path: <linux-pci+bounces-31922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36D9B01967
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 12:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC5D1895EA2
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 10:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DB5279DA0;
	Fri, 11 Jul 2025 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QV74Uy0l"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E76D1F4282;
	Fri, 11 Jul 2025 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228673; cv=none; b=KGXCPqK4p8AQgwuPo5qjqguq+zJDHEf+ZyIhFrjrwUcnTxvuvCicfRYbL8qlmU03n2iBiGsu195X4sizRPmC0Hbqc9tNidGwHqA8K+ulALnK1gEhr+EvPqbFyOSmr3X37oEVREM4JNreQWWn3r2awMc8Z/64gT6k2mygSFEqdAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228673; c=relaxed/simple;
	bh=vd0ZRNXtz080sUlOKI4p1+BCTJ3WxrrVuyY7GlXseEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axfstvfjl8R7gFS7cSov0nV3Nk7F9UwEzyfbj5aNxVyJHznV/V3LnYnOmn3mueDQyDneMnd07Fnj8w5LxjhXrvvD15vJh2llvZn+8Nhz3xLYW7AMOutNzadhEoVXOfoSMbtVBMlRAsFb9zKRF6tYycqSkoTM/dXqPl3/8X4Fr/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QV74Uy0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1562C4CEF5;
	Fri, 11 Jul 2025 10:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752228672;
	bh=vd0ZRNXtz080sUlOKI4p1+BCTJ3WxrrVuyY7GlXseEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QV74Uy0lfygDsMaur3m+g4YkQUr5dxzmxt4kErRm29ibBKKFiRmw+HbxrR+a/lOwM
	 8EJDZm3/wgBYi2AwZ816h/4BIvBbift1UHJ8ohCkQn9Em54vz/pSPhbIgQpyWyY11t
	 ywSl4gY/GMIvNmGljXdTVN9gqBnn1JLblBoIQbz2MiQT7uMq/T6i/RBliSvx7xy8AY
	 ssv3ClD7wBWsc69kZnQ2Wb4wwRVzpBAxrqSD2vgzmpVK7tSHceT5ezKaof+VsBzUxt
	 +NsAshVIYe86WTVZqzJtyEbdwSGhRGflADnJzV5clBvpxupIAlhvlicO6NtuRS2da1
	 LaRMv2STqXfhA==
Date: Fri, 11 Jul 2025 12:11:02 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Toan Le <toan@os.amperecomputing.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 09/13] PCI: xgene-msi: Sanitise MSI allocation and
 affinity setting
Message-ID: <aHDjNr59aMzVQ5iA@lpieralisi>
References: <20250708173404.1278635-1-maz@kernel.org>
 <20250708173404.1278635-10-maz@kernel.org>
 <aHDfhVRa1lhu7qPg@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHDfhVRa1lhu7qPg@lpieralisi>

On Fri, Jul 11, 2025 at 11:55:17AM +0200, Lorenzo Pieralisi wrote:
> On Tue, Jul 08, 2025 at 06:34:00PM +0100, Marc Zyngier wrote:

[...]

> We could use MSInRx_HWIRQ_MASK, I can update it.
> 
> More importantly, what code would set data->hwirq[6:4] (and
> data->hwirq[7:7] below) ?

Forget it. It is the hwirq allocation itself that sets those bits,
256 HWIRQs you use the effective cpu affinity to steer the frame,
it makes sense now.

I can update the code to use the mask above and merge it.

Sorry for the noise,
Lorenzo

> > +	frame	= FIELD_PREP(BIT(3), FIELD_GET(BIT(7), data->hwirq)) | cpu;
> >  
> > -/*
> > - * X-Gene v1 only has 16 MSI GIC IRQs for 2048 MSI vectors.  To maintain
> > - * the expected behaviour of .set_affinity for each MSI interrupt, the 16
> > - * MSI GIC IRQs are statically allocated to 8 X-Gene v1 cores (2 GIC IRQs
> > - * for each core).  The MSI vector is moved from 1 MSI GIC IRQ to another
> > - * MSI GIC IRQ to steer its MSI interrupt to correct X-Gene v1 core.  As a
> > - * consequence, the total MSI vectors that X-Gene v1 supports will be
> > - * reduced to 256 (2048/8) vectors.
> > - */
> > -static int hwirq_to_cpu(unsigned long hwirq)
> > -{
> > -	return (hwirq % num_possible_cpus());
> > -}
> > +	target_addr = msi->msi_addr;
> > +	target_addr += (FIELD_PREP(MSI_GROUP_MASK, frame) |
> > +			FIELD_PREP(MSI_INTR_MASK, msir));
> >  
> > -static unsigned long hwirq_to_canonical_hwirq(unsigned long hwirq)
> > -{
> > -	return (hwirq - hwirq_to_cpu(hwirq));
> > +	msg->address_hi = upper_32_bits(target_addr);
> > +	msg->address_lo = lower_32_bits(target_addr);
> > +	msg->data = FIELD_GET(DATA_HWIRQ_MASK, data->hwirq);
> >  }
> >  
> >  static int xgene_msi_set_affinity(struct irq_data *irqdata,
> >  				  const struct cpumask *mask, bool force)
> >  {
> >  	int target_cpu = cpumask_first(mask);
> > -	int curr_cpu;
> > -
> > -	curr_cpu = hwirq_to_cpu(irqdata->hwirq);
> > -	if (curr_cpu == target_cpu)
> > -		return IRQ_SET_MASK_OK_DONE;
> >  
> > -	/* Update MSI number to target the new CPU */
> > -	irqdata->hwirq = hwirq_to_canonical_hwirq(irqdata->hwirq) + target_cpu;
> > +	irq_data_update_effective_affinity(irqdata, cpumask_of(target_cpu));
> >  
> > +	/* Force the core code to regenerate the message */
> >  	return IRQ_SET_MASK_OK;
> >  }
> >  
> > @@ -173,23 +167,20 @@ static int xgene_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> >  				  unsigned int nr_irqs, void *args)
> >  {
> >  	struct xgene_msi *msi = domain->host_data;
> > -	int msi_irq;
> > +	irq_hw_number_t hwirq;
> >  
> >  	mutex_lock(&msi->bitmap_lock);
> >  
> > -	msi_irq = bitmap_find_next_zero_area(msi->bitmap, NR_MSI_VEC, 0,
> > -					     num_possible_cpus(), 0);
> > -	if (msi_irq < NR_MSI_VEC)
> > -		bitmap_set(msi->bitmap, msi_irq, num_possible_cpus());
> > -	else
> > -		msi_irq = -ENOSPC;
> > +	hwirq = find_first_zero_bit(msi->bitmap, NR_MSI_VEC);
> > +	if (hwirq < NR_MSI_VEC)
> > +		set_bit(hwirq, msi->bitmap);
> >  
> >  	mutex_unlock(&msi->bitmap_lock);
> >  
> > -	if (msi_irq < 0)
> > -		return msi_irq;
> > +	if (hwirq >= NR_MSI_VEC)
> > +		return -ENOSPC;
> >  
> > -	irq_domain_set_info(domain, virq, msi_irq,
> > +	irq_domain_set_info(domain, virq, hwirq,
> >  			    &xgene_msi_bottom_irq_chip, domain->host_data,
> >  			    handle_simple_irq, NULL, NULL);
> 
> This is something I don't get. We alloc an MSI, set a bit in the bitmap
> and the hwirq to that value, when we handle the IRQ below in
> 
> xgene_msi_isr()
> 
> hwirq = compute_hwirq(msi_grp, msir_idx, intr_idx);
> ret = generic_handle_domain_irq(xgene_msi->inner_domain, hwirq);
> 
> imagining that we changed the affinity for the IRQ so that the computed
> HWIRQ does not have zeros in bits[7:4], how would the domain HWIRQ
> matching work ?
> 
> Actually, how would an IRQ fire causing the hwirq[7:4] bits to be != 0
> in the first place ?
> 
> Forgive me if I am missing something obvious, the *current* MSI handling
> is very hard to grok, it is certain I misunderstood it entirely.
> 
> Thanks,
> Lorenzo
> 
> > @@ -201,12 +192,10 @@ static void xgene_irq_domain_free(struct irq_domain *domain,
> >  {
> >  	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> >  	struct xgene_msi *msi = irq_data_get_irq_chip_data(d);
> > -	u32 hwirq;
> >  
> >  	mutex_lock(&msi->bitmap_lock);
> >  
> > -	hwirq = hwirq_to_canonical_hwirq(d->hwirq);
> > -	bitmap_clear(msi->bitmap, hwirq, num_possible_cpus());
> > +	clear_bit(d->hwirq, msi->bitmap);
> >  
> >  	mutex_unlock(&msi->bitmap_lock);
> >  
> > @@ -263,55 +252,30 @@ static void xgene_msi_isr(struct irq_desc *desc)
> >  	unsigned int *irqp = irq_desc_get_handler_data(desc);
> >  	struct irq_chip *chip = irq_desc_get_chip(desc);
> >  	struct xgene_msi *xgene_msi = xgene_msi_ctrl;
> > -	int msir_index, msir_val, hw_irq, ret;
> > -	u32 intr_index, grp_select, msi_grp;
> > +	unsigned long grp_pending;
> > +	int msir_idx;
> > +	u32 msi_grp;
> >  
> >  	chained_irq_enter(chip, desc);
> >  
> >  	msi_grp = irqp - xgene_msi->gic_irq;
> >  
> > -	/*
> > -	 * MSIINTn (n is 0..F) indicates if there is a pending MSI interrupt
> > -	 * If bit x of this register is set (x is 0..7), one or more interrupts
> > -	 * corresponding to MSInIRx is set.
> > -	 */
> > -	grp_select = xgene_msi_int_read(xgene_msi, msi_grp);
> > -	while (grp_select) {
> > -		msir_index = ffs(grp_select) - 1;
> > -		/*
> > -		 * Calculate MSInIRx address to read to check for interrupts
> > -		 * (refer to termination address and data assignment
> > -		 * described in xgene_compose_msi_msg() )
> > -		 */
> > -		msir_val = xgene_msi_ir_read(xgene_msi, msi_grp, msir_index);
> > -		while (msir_val) {
> > -			intr_index = ffs(msir_val) - 1;
> > -			/*
> > -			 * Calculate MSI vector number (refer to the termination
> > -			 * address and data assignment described in
> > -			 * xgene_compose_msi_msg function)
> > -			 */
> > -			hw_irq = (((msir_index * IRQS_PER_IDX) + intr_index) *
> > -				 NR_HW_IRQS) + msi_grp;
> > -			/*
> > -			 * As we have multiple hw_irq that maps to single MSI,
> > -			 * always look up the virq using the hw_irq as seen from
> > -			 * CPU0
> > -			 */
> > -			hw_irq = hwirq_to_canonical_hwirq(hw_irq);
> > -			ret = generic_handle_domain_irq(xgene_msi->inner_domain, hw_irq);
> > +	grp_pending = xgene_msi_int_read(xgene_msi, msi_grp);
> > +
> > +	for_each_set_bit(msir_idx, &grp_pending, IDX_PER_GROUP) {
> > +		unsigned long msir;
> > +		int intr_idx;
> > +
> > +		msir = xgene_msi_ir_read(xgene_msi, msi_grp, msir_idx);
> > +
> > +		for_each_set_bit(intr_idx, &msir, IRQS_PER_IDX) {
> > +			irq_hw_number_t hwirq;
> > +			int ret;
> > +
> > +			hwirq = compute_hwirq(msi_grp, msir_idx, intr_idx);
> > +			ret = generic_handle_domain_irq(xgene_msi->inner_domain,
> > +							hwirq);
> >  			WARN_ON_ONCE(ret);
> > -			msir_val &= ~(1 << intr_index);
> > -		}
> > -		grp_select &= ~(1 << msir_index);
> > -
> > -		if (!grp_select) {
> > -			/*
> > -			 * We handled all interrupts happened in this group,
> > -			 * resample this group MSI_INTx register in case
> > -			 * something else has been made pending in the meantime
> > -			 */
> > -			grp_select = xgene_msi_int_read(xgene_msi, msi_grp);
> >  		}
> >  	}
> >  
> > -- 
> > 2.39.2
> > 

