Return-Path: <linux-pci+bounces-20673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246DBA2626F
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 19:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0E33A681F
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 18:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7EA1C1AAA;
	Mon,  3 Feb 2025 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZBsriQZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42D820E02A;
	Mon,  3 Feb 2025 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738607304; cv=none; b=Bbc4vQ+Rc4qgZuHbbL7GOE/iXX+HuWfUE5LXSJ9gI38K53njWozy6fymqOvFi/XGukq3uoE+o5/tYsmFt3MFB50iLXqzrIkZ85pfB1qoXWEHEbMAVeGaYzlKkKrbzCQoTSdGrZjmaLG5XikaJoQCM7632/eQOf3aqLXmTtUiTzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738607304; c=relaxed/simple;
	bh=1c8bbSUiSo4k8NW3nonAQq0DtXPO5ln/b9UfOacx1H8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BcJcveia5+qFHUgPsOLSR5N+zqm6eldvUcuv51ZXk5XPZpfWhR39WzXxMQFfA9HuzhD0PL0781x7B9/O3B8sYWlp9NW2UyXBs+PmID9HwgHdvP+ses6QkIaYdajF7QGiJmiLYBX7lo1m2T9cdp468d/Db/OpI1DbknzQFkrEWRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZBsriQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265CAC4CED2;
	Mon,  3 Feb 2025 18:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738607304;
	bh=1c8bbSUiSo4k8NW3nonAQq0DtXPO5ln/b9UfOacx1H8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cZBsriQZS1EwV0AZh5a0GP9X+ElOuP4MjVxLs9jgJi7FkWZb2mN3+1JtGmjoAWp43
	 uxKpNOplcQiQKkYWc3XPI9lj11Apz8ognBtTHtE2kztPhAYrddwkCXhedx/mSewdjg
	 YZTEynI2WTmFBgo3X1Vj/uw97PQIWOoKWO/wOr2TmNq98RNB2sXYpj6yoQTnlFtH1N
	 hL3slYQfbzsQqKi/o9RuX8KWXSTao6sGaEVs4fh0EcByDQfnrcvZ1Vbd6QV7JHGsil
	 7EYXoYeabyNYQGfRRu3MAmeVeyCb1AQUBOn85y8XRLYgs2VygAjTZQhrrZNek7ejSo
	 TDJMRoCUnoXsg==
Date: Mon, 3 Feb 2025 12:28:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jingoohan1@gmail.com, michal.simek@amd.com,
	bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Message-ID: <20250203182822.GA793389@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129113029.64841-4-thippeswamy.havalige@amd.com>

On Wed, Jan 29, 2025 at 05:00:29PM +0530, Thippeswamy Havalige wrote:
> Add support for AMD MDB (Multimedia DMA Bridge) IP core as Root Port.

> +#define AMD_MDB_TLP_IR_STATUS_MISC		0x4C0
> +#define AMD_MDB_TLP_IR_MASK_MISC		0x4C4
> +#define AMD_MDB_TLP_IR_ENABLE_MISC		0x4C8
> +
> +#define AMD_MDB_PCIE_IDRN_SHIFT			16

Remove this _SHIFT #define and use something like this instead:

  #define AMD_MDB_PCIE_INTX_BIT(x) FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK, BIT(x))

I don't know what exactly the right name for that is; it looks like
maybe these bits apply to all the above registers
(AMD_MDB_TLP_IR_STATUS_MISC, AMD_MDB_TLP_IR_MASK_MISC,
AMD_MDB_TLP_IR_ENABLE_MISC)

> +#define AMD_MDB_PCIE_INTR_INTA_ASSERT		16
> +#define AMD_MDB_PCIE_INTR_INTB_ASSERT		18
> +#define AMD_MDB_PCIE_INTR_INTC_ASSERT		20
> +#define AMD_MDB_PCIE_INTR_INTD_ASSERT		22

It's kind of weird that these skip the odd-numbered bits, since
dw_pcie_rp_intx_flow(), amd_mdb_mask_intx_irq(),
amd_mdb_unmask_intx_irq() only use bits 19:16.  Something seems wrong
and needs either a fix or a comment about why this is the way it is.

> +#define IMR(x) BIT(AMD_MDB_PCIE_INTR_ ##x)
> +#define AMD_MDB_PCIE_IMR_ALL_MASK			\
> +	(						\
> +		IMR(CMPL_TIMEOUT)	|		\
> +		IMR(INTA_ASSERT)	|		\
> +		IMR(INTB_ASSERT)	|		\
> +		IMR(INTC_ASSERT)	|		\
> +		IMR(INTD_ASSERT)	|		\
> +		IMR(PM_PME_RCVD)	|		\
> +		IMR(PME_TO_ACK_RCVD)	|		\
> +		IMR(MISC_CORRECTABLE)	|		\
> +		IMR(NONFATAL)		|		\
> +		IMR(FATAL)				\
> +	)
> +
> +#define AMD_MDB_TLP_PCIE_INTX_MASK	GENMASK(23, 16)

I would drop AMD_MDB_PCIE_INTR_INTA_ASSERT, etc, and just use
AMD_MDB_TLP_PCIE_INTX_MASK in the AMD_MDB_PCIE_IMR_ALL_MASK
definition.

If there are really eight bits of INTx-related things here for the
four INTx interrupts, I think you should make two #defines to separate
them out.

> +static void amd_mdb_mask_intx_irq(struct irq_data *data)
> +{
> +	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(data);
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *port = &pci->pp;
> +	unsigned long flags;
> +	u32 mask, val;
> +
> +	mask = BIT(data->hwirq + AMD_MDB_PCIE_IDRN_SHIFT);
> +
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val = pcie_read(pcie, AMD_MDB_TLP_IR_MASK_MISC);

  val &= ~AMD_MDB_PCIE_INTX_BIT(data->hwirq);
  pcie_write(pcie, val, AMD_MDB_TLP_IR_ENABLE_MISC);

> +	pcie_write(pcie, (val & (~mask)), AMD_MDB_TLP_IR_ENABLE_MISC);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static void amd_mdb_unmask_intx_irq(struct irq_data *data)
> +{
> +	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(data);
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *port = &pci->pp;
> +	unsigned long flags;
> +	u32 mask;
> +	u32 val;
> +
> +	mask = BIT(data->hwirq + AMD_MDB_PCIE_IDRN_SHIFT);
> +
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val = pcie_read(pcie, AMD_MDB_TLP_IR_MASK_MISC);

  val |= AMD_MDB_PCIE_INTX_BIT(data->hwirq);

> +	pcie_write(pcie, (val | mask), AMD_MDB_TLP_IR_ENABLE_MISC);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static struct irq_chip amd_mdb_intx_irq_chip = {
> +	.name		= "AMD MDB INTx",
> +	.irq_mask	= amd_mdb_mask_intx_irq,
> +	.irq_unmask	= amd_mdb_unmask_intx_irq,

Prefer

  .irq_mask       = amd_mdb_intx_irq_mask,
  .irq_unmask     = amd_mdb_intx_irq_unmask,

so the function names match the grep pattern of the function pointers
(".*_irq_mask").

> +static struct irq_chip amd_mdb_event_irq_chip = {
> +	.name		= "AMD MDB RC-Event",
> +	.irq_mask	= amd_mdb_mask_event_irq,
> +	.irq_unmask	= amd_mdb_unmask_event_irq,

Same function name comment.

> +static irqreturn_t dw_pcie_rp_intx_flow(int irq, void *args)
> +{
> +	struct amd_mdb_pcie *pcie = args;
> +	unsigned long val;
> +	int i;
> +
> +	val = FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK,
> +			pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC));
> +
> +	for_each_set_bit(i, &val, 4)

  for_each_set_bit(..., PCI_NUM_INTX)

> +		generic_handle_domain_irq(pcie->intx_domain, i);
> +
> +	return IRQ_HANDLED;
> +}

> +
> +static irqreturn_t amd_mdb_pcie_intr_handler(int irq, void *args)
> +{
> +	struct amd_mdb_pcie *pcie = args;
> +	struct device *dev;
> +	struct irq_data *d;
> +
> +	dev = pcie->pci.dev;
> +
> +	d = irq_domain_get_irq_data(pcie->mdb_domain, irq);
> +	if (intr_cause[d->hwirq].str)
> +		dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
> +	else
> +		dev_warn_once(dev, "Unknown IRQ %ld\n", d->hwirq);

What's the point of an interrupt handler that only logs it?

> +	return IRQ_HANDLED;
> +}

> +static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
> +				 struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *pp = &pci->pp;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	pcie->slcr = devm_platform_ioremap_resource_byname(pdev, "slcr");
> +	if (IS_ERR(pcie->slcr))
> +		return PTR_ERR(pcie->slcr);
> +
> +	ret = amd_mdb_pcie_init_irq_domains(pcie, pdev);
> +	if (ret)
> +		return ret;
> +
> +	amd_mdb_pcie_init_port(pcie);

amd_mdb_pcie_init_port() doesn't initialize anything other than
disabling/clearing/enabling interrupts.  Seems like it could be
squashed into amd_mdb_setup_irq() or called from there so it's
obvious that it's interrupt-related.

> +	ret = amd_mdb_setup_irq(pcie, pdev);
> +	if (ret) {
> +		dev_err(dev, "Failed to set up interrupts\n");
> +		goto out;
> +	}
> +
> +	pp->ops = &amd_mdb_pcie_host_ops;
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize host\n");
> +		goto out;
> +	}
> +
> +	return 0;
> +
> +out:
> +	amd_mdb_pcie_free_irq_domains(pcie);
> +	return ret;
> +}

