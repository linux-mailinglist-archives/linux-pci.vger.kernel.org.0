Return-Path: <linux-pci+bounces-22740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7788CA4BA65
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 10:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20473ADFBC
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 09:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0844A1EB1BC;
	Mon,  3 Mar 2025 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JLzljCnw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PxMuCUMC"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF731DF721;
	Mon,  3 Mar 2025 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993008; cv=none; b=LLZfdwpkemJ918eqVzvbXj8W3uQWrui8AlVUMCcF76bkqOqX64KKaa8DF3/lzo/INAhBDTFzRDIRccybAJ9reAj9o9F0uiAWaTsvkNIMtOP//DuCe3+OMxAQkCnBIQ9bu82YPO5IDGJmTydjGk7IkO7Nxx8p9QZ3kF9FM566Ojo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993008; c=relaxed/simple;
	bh=hvQ6UFF0fy3Al/0FUWACovqLUwi5Ps7fWWttcnrP6Lc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LOQr8A2B9BYaCBA0cKJ/EqYxGtZSVH7CGnhGNDviP9dSYhyhYCg02vn/PZ+DVp8ThX8cARJi+bemYy0cDX8xJTn8vULSVPdFwJ+b2+RghIh8HMhF8igZmn/yislnHfkNyVHq6otMDMZ7JoX5cJV7aOJJPM0CHuDjx3/PzjuUQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JLzljCnw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PxMuCUMC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740993004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zjA7Lr/BJ7h7palXzLxMwb3DKcN2jgvvKLiPovQPSk=;
	b=JLzljCnwpBiZdWy7aKV0gJtiAebsYfhH7hqGmcnRkFVzIbB53tJ9kvSZ9ytWe2mcz7v2yM
	eJuUznXBqDhLkYuOfaxDS32ylNBuBMX7cAOj3ltMD+Yvwin0/UhqyD+D//3oNrcRgHeYMb
	/2rUbt4qBb1Uhhiq7BwbbtBbqxaRwUmDQ14OBdZSnewGvh5piWV+qMDFEpfv/x5iPju4Gu
	MkfqtBNML+xZb40YNhn+eBBxFtaXmimgneifIE795R4Kf89v6ZQctdw4+YnSb1quH8LrYb
	7rLaGgKebMrWWuhQFuSV4DSiL+wPfI6CaavAFsbh6E8w/8rz1Fiuf4oj0go6fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740993004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zjA7Lr/BJ7h7palXzLxMwb3DKcN2jgvvKLiPovQPSk=;
	b=PxMuCUMCr/753YDqzSM+x13d7WXAYVecjosp5zzCHkaux3Fe5L0ue1k2juUUvCxBrBBcbM
	BIY/EtA+pPJj76Bg==
To: Daniel Tsai <danielsftsai@google.com>, Jingoo Han
 <jingoohan1@gmail.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy?=
 =?utf-8?Q?=C5=84ski?=
 <kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Andrew Chant <achant@google.com>, Brian Norris
 <briannorris@google.com>, Sajid Dalvi <sdalvi@google.com>, Mark Cheng
 <markcheng@google.com>, Ben Cheng <bccheng@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Tsai Sung-Fu
 <danielsftsai@google.com>
Subject: Re: [PATCH] PCI: dwc: Chain the set IRQ affinity request back to
 the parent
In-Reply-To: <20250303070501.2740392-1-danielsftsai@google.com>
References: <20250303070501.2740392-1-danielsftsai@google.com>
Date: Mon, 03 Mar 2025 10:10:04 +0100
Message-ID: <87a5a2cwer.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 03 2025 at 07:05, Daniel Tsai wrote:
> +/*
> + * The algo here honor if there is any intersection of mask of
> + * the existing MSI vectors and the requesting MSI vector. So we
> + * could handle both narrow (1 bit set mask) and wide (0xffff...)
> + * cases, return -EINVAL and reject the request if the result of
> + * cpumask is empty, otherwise return 0 and have the calculated
> + * result on the mask_to_check to pass down to the irq_chip.
> + */
> +static int dw_pci_check_mask_compatibility(struct dw_pcie_rp *pp,
> +					   unsigned long ctrl,
> +					   unsigned long hwirq_to_check,
> +					   struct cpumask *mask_to_check)
> +{
> +	unsigned long end, hwirq;
> +	const struct cpumask *mask;
> +	unsigned int virq;
> +
> +	hwirq = ctrl * MAX_MSI_IRQS_PER_CTRL;
> +	end = hwirq + MAX_MSI_IRQS_PER_CTRL;
> +	for_each_set_bit_from(hwirq, pp->msi_irq_in_use, end) {
> +		if (hwirq == hwirq_to_check)
> +			continue;
> +		virq = irq_find_mapping(pp->irq_domain, hwirq);
> +		if (!virq)
> +			continue;
> +		mask = irq_get_affinity_mask(virq);

What protects @mask against a concurrent modification?

> +		if (!cpumask_and(mask_to_check, mask, mask_to_check))
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void dw_pci_update_effective_affinity(struct dw_pcie_rp *pp,
> +					     unsigned long ctrl,
> +					     const struct cpumask *effective_mask,
> +					     unsigned long hwirq_to_check)
> +{
> +	struct irq_desc *desc_downstream;
> +	unsigned int virq_downstream;
> +	unsigned long end, hwirq;
> +
> +	/*
> +	 * Update all the irq_data's effective mask
> +	 * bind to this MSI controller, so the correct
> +	 * affinity would reflect on
> +	 * /proc/irq/XXX/effective_affinity
> +	 */
> +	hwirq = ctrl * MAX_MSI_IRQS_PER_CTRL;
> +	end = hwirq + MAX_MSI_IRQS_PER_CTRL;
> +	for_each_set_bit_from(hwirq, pp->msi_irq_in_use, end) {
> +		virq_downstream = irq_find_mapping(pp->irq_domain, hwirq);
> +		if (!virq_downstream)
> +			continue;
> +		desc_downstream = irq_to_desc(virq_downstream);
> +		irq_data_update_effective_affinity(&desc_downstream->irq_data,
> +						   effective_mask);

Same here.

> +	}
> +}
> +
> +static int dw_pci_msi_set_affinity(struct irq_data *d,
> +				   const struct cpumask *mask, bool force)
> +{
> +	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	int ret;
> +	int virq_parent;
> +	unsigned long hwirq = d->hwirq;
> +	unsigned long flags, ctrl;
> +	struct irq_desc *desc_parent;
> +	const struct cpumask *effective_mask;
> +	cpumask_var_t mask_result;
> +
> +	ctrl = hwirq / MAX_MSI_IRQS_PER_CTRL;
> +	if (!alloc_cpumask_var(&mask_result, GFP_ATOMIC))
> +		return -ENOMEM;

This does not work on a RT enabled kernel. Allocations with a raw spin
lock held are not possible.

> +	/*
> +	 * Loop through all possible MSI vector to check if the
> +	 * requested one is compatible with all of them
> +	 */
> +	raw_spin_lock_irqsave(&pp->lock, flags);
> +	cpumask_copy(mask_result, mask);
> +	ret = dw_pci_check_mask_compatibility(pp, ctrl, hwirq, mask_result);
> +	if (ret) {
> +		dev_dbg(pci->dev, "Incompatible mask, request %*pbl, irq num %u\n",
> +			cpumask_pr_args(mask), d->irq);
> +		goto unlock;
> +	}
> +
> +	dev_dbg(pci->dev, "Final mask, request %*pbl, irq num %u\n",
> +		cpumask_pr_args(mask_result), d->irq);
> +
> +	virq_parent = pp->msi_irq[ctrl];
> +	desc_parent = irq_to_desc(virq_parent);
> +	ret = desc_parent->irq_data.chip->irq_set_affinity(&desc_parent->irq_data,
> +							   mask_result, force);

Again. Completely unserialized.

Thanks,

        tglx

