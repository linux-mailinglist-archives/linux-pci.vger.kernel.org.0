Return-Path: <linux-pci+bounces-31621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E47AFB72D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 17:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE85B42129D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 15:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801472E266B;
	Mon,  7 Jul 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8IvYfkC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575E72E2656;
	Mon,  7 Jul 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901771; cv=none; b=bGioTIFfk8xSmBJDL2mFisB5dHi0NBCCHsvDjwnvuaSIUxQEUfbECCV+v9xP2s7aA1klt0fVCZgF6F9SB3HlNjDzwHRda9lV8vsU0Vv0FwKYMw7DZrE63Bf2kIfQn8XWwtI8zne/VJIVlN72iA85fUjA4l7tpes77KTfdHuAru8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901771; c=relaxed/simple;
	bh=bF9Cnd3Mk8tDrG07Arguno79t51AF/xFLBMyBLuaJGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wh0fnT5iSi2s6JwHcb2mCND3NUKtlJZVFmy9IfuhYcLgZQirr4dADP8zUveWsCWiLECpX8OZH11TyyGoqL0JlVsI/+XCJ3/x6oIMsORCGjkRS5DwGuMkPbcl6B4jWTWOVrMSJpmrSdgnyOXWp4E5Cn306yhO7yBSwO2jCBGk3HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8IvYfkC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E59FC4CEE3;
	Mon,  7 Jul 2025 15:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751901770;
	bh=bF9Cnd3Mk8tDrG07Arguno79t51AF/xFLBMyBLuaJGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e8IvYfkCRwo5yMKdPg6eD6myowFXc9eC4dXKePHqDJ+9NklmBW7k6xEqYC3FUC8hs
	 vuzgYKoA4OJz3CcoqIDSLH66LS/qMvYC7z2SFKSp3fZtYr4kX0JsZqQ0SMsBe9RZ9L
	 mvb4KrSap5UQhO2+1/op3FTcOXydr1yf6JLeWRwL3p8qrblabFSpc07nVm+wsMH6tp
	 2sYET44ehOPw4qF+W/+QEGsTW12AW6t2Z+TxydOZmWePxo20k84Yj2Ratzm6Skmngt
	 Z43KwuyHvar82tPkjQiMejMYD3COb67mJGsSBJZIqess/aCLWXU5xX8vQlbcDOECic
	 bMTPxIbbM5bog==
Date: Mon, 7 Jul 2025 17:22:43 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Toan Le <toan@os.amperecomputing.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 08/12] PCI: xgene-msi: Get rid of intermediate tracking
 structure
Message-ID: <aGvmQ0fjM6HWq6Qv@lpieralisi>
References: <20250628173005.445013-1-maz@kernel.org>
 <20250628173005.445013-9-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628173005.445013-9-maz@kernel.org>

On Sat, Jun 28, 2025 at 06:30:01PM +0100, Marc Zyngier wrote:
> The xgene-msi driver uses an odd construct in the form of an
> intermediate tracking structure, evidently designed to deal with
> multiple instances of the MSI widget. However, the existing HW
> only has one set, and it is obvious that there won't be new HW
> coming down that particular line.
> 
> Simplify the driver by using a bit of pointer arithmetic instead,
> directly tracking the interrupt and avoiding extra memory allocation.

A couple of nits, nothing else.

> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/pci/controller/pci-xgene-msi.c | 58 ++++++++------------------
>  1 file changed, 17 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
> index b3ac0125b3b40..4be79b9ff80df 100644
> --- a/drivers/pci/controller/pci-xgene-msi.c
> +++ b/drivers/pci/controller/pci-xgene-msi.c
> @@ -24,19 +24,13 @@
>  #define NR_HW_IRQS		16
>  #define NR_MSI_VEC		(IDX_PER_GROUP * IRQS_PER_IDX * NR_HW_IRQS)
>  
> -struct xgene_msi_group {
> -	struct xgene_msi	*msi;
> -	int			gic_irq;
> -	u32			msi_grp;
> -};
> -
>  struct xgene_msi {
>  	struct irq_domain	*inner_domain;
>  	u64			msi_addr;
>  	void __iomem		*msi_regs;
>  	unsigned long		*bitmap;
>  	struct mutex		bitmap_lock;
> -	struct xgene_msi_group	*msi_groups;
> +	unsigned int		gic_irq[NR_HW_IRQS];
>  };
>  
>  /* Global data */
> @@ -261,27 +255,20 @@ static int xgene_msi_init_allocator(struct device *dev)
>  
>  	mutex_init(&xgene_msi_ctrl->bitmap_lock);
>  
> -	xgene_msi_ctrl->msi_groups = devm_kcalloc(dev, NR_HW_IRQS,
> -						  sizeof(struct xgene_msi_group),
> -						  GFP_KERNEL);
> -	if (!xgene_msi_ctrl->msi_groups)
> -		return -ENOMEM;
> -
>  	return 0;
>  }
>  
>  static void xgene_msi_isr(struct irq_desc *desc)
>  {
> +	unsigned int *irqp = irq_desc_get_handler_data(desc);
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>  	struct xgene_msi *xgene_msi = xgene_msi_ctrl;
> -	struct xgene_msi_group *msi_groups;
>  	int msir_index, msir_val, hw_irq, ret;
>  	u32 intr_index, grp_select, msi_grp;
>  
>  	chained_irq_enter(chip, desc);
>  
> -	msi_groups = irq_desc_get_handler_data(desc);
> -	msi_grp = msi_groups->msi_grp;
> +	msi_grp = irqp - xgene_msi->gic_irq;
>  
>  	/*
>  	 * MSIINTn (n is 0..F) indicates if there is a pending MSI interrupt
> @@ -341,35 +328,31 @@ static void xgene_msi_remove(struct platform_device *pdev)
>  		cpuhp_remove_state(pci_xgene_online);
>  	cpuhp_remove_state(CPUHP_PCI_XGENE_DEAD);
>  
> -	kfree(msi->msi_groups);
> -
>  	xgene_free_domains(msi);
>  }
>  
>  static int xgene_msi_hwirq_alloc(unsigned int cpu)
>  {
> -	struct xgene_msi *msi = xgene_msi_ctrl;
> -	struct xgene_msi_group *msi_group;
>  	int i;
>  	int err;
>  
>  	for (i = cpu; i < NR_HW_IRQS; i += num_possible_cpus()) {
> -		msi_group = &msi->msi_groups[i];
> +		unsigned int irq = xgene_msi_ctrl->gic_irq[i];
>  
>  		/*
>  		 * Statically allocate MSI GIC IRQs to each CPU core.
>  		 * With 8-core X-Gene v1, 2 MSI GIC IRQs are allocated
>  		 * to each core.
>  		 */
> -		irq_set_status_flags(msi_group->gic_irq, IRQ_NO_BALANCING);
> -		err = irq_set_affinity(msi_group->gic_irq, cpumask_of(cpu));
> +		irq_set_status_flags(irq, IRQ_NO_BALANCING);
> +		err = irq_set_affinity(irq, cpumask_of(cpu));
>  		if (err) {
>  			pr_err("failed to set affinity for GIC IRQ");
>  			return err;
>  		}
>  
> -		irq_set_chained_handler_and_data(msi_group->gic_irq,
> -			xgene_msi_isr, msi_group);
> +		irq_set_chained_handler_and_data(irq, xgene_msi_isr,
> +						 &xgene_msi_ctrl->gic_irq[i]);
>  	}
>  
>  	return 0;
> @@ -378,15 +361,12 @@ static int xgene_msi_hwirq_alloc(unsigned int cpu)
>  static int xgene_msi_hwirq_free(unsigned int cpu)
>  {
>  	struct xgene_msi *msi = xgene_msi_ctrl;
> -	struct xgene_msi_group *msi_group;
>  	int i;
>  
>  	for (i = cpu; i < NR_HW_IRQS; i += num_possible_cpus()) {
> -		msi_group = &msi->msi_groups[i];
> -		if (!msi_group->gic_irq)
> +		if (!msi->gic_irq[i])

In patch 5 we removed this check in xgene_msi_hwirq_alloc(), if it
superfluous there it should be here too.

>  			continue;
> -		irq_set_chained_handler_and_data(msi_group->gic_irq, NULL,
> -						 NULL);
> +		irq_set_chained_handler_and_data(msi->gic_irq[i], NULL, NULL);
>  	}
>  	return 0;
>  }
> @@ -399,10 +379,9 @@ static const struct of_device_id xgene_msi_match_table[] = {
>  static int xgene_msi_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
> -	int rc, irq_index;

Just noticed, insignificant nit: don't see why moving irq_index to a
local loop variable is required in this patch - fine to leave the
code in the patch as-is - reporting it to make sure I have not
missed anything.

Lorenzo

>  	struct xgene_msi *xgene_msi;
> -	int virt_msir;
>  	u32 msi_val, msi_idx;
> +	int rc;
>  
>  	xgene_msi_ctrl = devm_kzalloc(&pdev->dev, sizeof(*xgene_msi_ctrl),
>  				      GFP_KERNEL);
> @@ -432,15 +411,12 @@ static int xgene_msi_probe(struct platform_device *pdev)
>  		goto error;
>  	}
>  
> -	for (irq_index = 0; irq_index < NR_HW_IRQS; irq_index++) {
> -		virt_msir = platform_get_irq(pdev, irq_index);
> -		if (virt_msir < 0) {
> -			rc = virt_msir;
> +	for (int irq_index = 0; irq_index < NR_HW_IRQS; irq_index++) {
> +		rc = platform_get_irq(pdev, irq_index);
> +		if (rc < 0)
>  			goto error;
> -		}
> -		xgene_msi->msi_groups[irq_index].gic_irq = virt_msir;
> -		xgene_msi->msi_groups[irq_index].msi_grp = irq_index;
> -		xgene_msi->msi_groups[irq_index].msi = xgene_msi;
> +
> +		xgene_msi->gic_irq[irq_index] = rc;
>  	}
>  
>  	/*
> @@ -448,7 +424,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
>  	 * interrupt handlers, read all of them to clear spurious
>  	 * interrupts that may occur before the driver is probed.
>  	 */
> -	for (irq_index = 0; irq_index < NR_HW_IRQS; irq_index++) {
> +	for (int irq_index = 0; irq_index < NR_HW_IRQS; irq_index++) {
>  		for (msi_idx = 0; msi_idx < IDX_PER_GROUP; msi_idx++)
>  			xgene_msi_ir_read(xgene_msi, irq_index, msi_idx);
>  
> -- 
> 2.39.2
> 

