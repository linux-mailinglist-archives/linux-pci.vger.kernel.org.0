Return-Path: <linux-pci+bounces-21171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CC7A31425
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DD5188108C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 18:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493A9250BF5;
	Tue, 11 Feb 2025 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKgo+8NE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2DD1E5B61;
	Tue, 11 Feb 2025 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739298813; cv=none; b=mcqWN/+6EiLdckqVL9bidgwcbeYBWeWdREvViQjwRY6sB5vKN++CPmRWOEe49jgtdbR6EiyWBZaRFda+te2A8YyAfu8Z3FKJr2j0fiPmWLG3sF2EyEHulxcBtYw8EqVQ86n1ZjVAw5pyI0PKBwpnhxb2BZCo3ROsFThzb+E/GmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739298813; c=relaxed/simple;
	bh=m3qI+jHz4EWEqPbg0v6yeoH8WinZ6oxAZYote1vdVOs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hfBReUVCyX8OzSAY5j5NtJyoS5O8ycRJ3QFZ7xxrluJFVGMSIkQophqSnWmITB6kTKgPG2B89N8GhtIl0qSopVsaQwek8pycqAWkxdV7DKS8YjHjFSI/eYgbQubR4Q0cx0UYTqAfqaMx2qzgHaGTt1wD4K3XlKZ8+k2ZVhDCBf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKgo+8NE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5013EC4CEE4;
	Tue, 11 Feb 2025 18:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739298812;
	bh=m3qI+jHz4EWEqPbg0v6yeoH8WinZ6oxAZYote1vdVOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aKgo+8NEfkvRjplkya/E5gE5cKRAgXUplY2Dr5k2IP5SooE3iTQbzsrP8djx/S7Ji
	 cXV7Pxcjjp5J9s1HBW/WNYa60mGNtP07q1wKissM9PmI9ztsBCOtWUdYzvhsNfATp1
	 I5J5AMlyJAHnYIRIsXqnRFC8Uir1A1loyf66A/aqAT701jLU5VA+RnWXsCryHfalgc
	 UGChQROj8NFsRe2nBhcdV28c/TGquwlZcPzGMtZjcHQF7FpCOQ2qtEoHhkTp/rFeNQ
	 iUfq9IuS6qFMz2C8l7HzH55BR8IJiNtboVpIhVhCkGFRA4Ms1NTylBbpw5DtIwKZQq
	 2m8ukscxAvp/w==
Date: Tue, 11 Feb 2025 12:33:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jingoohan1@gmail.com, michal.simek@amd.com,
	bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v10 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Message-ID: <20250211183330.GA50291@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211063852.319566-4-thippeswamy.havalige@amd.com>

On Tue, Feb 11, 2025 at 12:08:51PM +0530, Thippeswamy Havalige wrote:
> Add support for AMD MDB (Multimedia DMA Bridge) IP core as Root Port.

> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -27,6 +27,17 @@ config PCIE_AL
>  	  required only for DT-based platforms. ACPI platforms with the
>  	  Annapurna Labs PCIe controller don't need to enable this.
>  
> +config PCIE_AMD_MDB
> +	bool "AMD MDB Versal2 PCIe Host controller"
> +	depends on OF || COMPILE_TEST
> +	depends on PCI && PCI_MSI
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here if you want to enable PCIe controller support on AMD
> +	  Versal2 SoCs. The AMD MDB Versal2 PCIe controller is based on DesignWare
> +	  IP and therefore the driver re-uses the Designware core functions to
> +	  implement the driver.

Wrap to fit in 75-78 columns like the rest of the file.  This gets
chopped off in an 80 column menuconfig window.

> +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c

> +#define AMD_MDB_TLP_PCIE_INTX_MASK	GENMASK(23, 16)
> +
> +#define AMD_MDB_PCIE_INTX_BIT(x) FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK, BIT(x))
> +
> +#define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)	BIT((x) * 2)
> +#define AMD_MDB_PCIE_INTR_INTX_DEASSERT(x)	BIT(((x) * 2) + 1)

> +static void amd_mdb_intx_irq_mask(struct irq_data *data)
> +{
> +	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(data);
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *port = &pci->pp;
> +	unsigned long flags;
> +	u32 val;
> +
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val = pcie_read(pcie, AMD_MDB_TLP_IR_MASK_MISC);
> +	val &= ~AMD_MDB_PCIE_INTX_BIT(data->hwirq);

This doesn't look right to me.  hwirq should be 0, 1, 2, or 3 (INTA,
INTB, INTC, or INTD):

  AMD_MDB_PCIE_INTX_BIT(0) == 0001 0000  (INTA assert)
  AMD_MDB_PCIE_INTX_BIT(1) == 0002 0000  (INTA deassert)
  AMD_MDB_PCIE_INTX_BIT(2) == 0004 0000  (INTB assert)
  AMD_MDB_PCIE_INTX_BIT(3) == 0008 0000  (INTB deassert)

Maybe the AMD_MDB_TLP_IR_ENABLE_MISC register is laid out differently
than AMD_MDB_TLP_IR_STATUS_MISC?  If so, and you're updating a
four-bit field, it needs a different GENMASK.

> +	pcie_write(pcie, val, AMD_MDB_TLP_IR_ENABLE_MISC);

This *looks* like it's supposed to be a read/modify/write of
AMD_MDB_TLP_IR_MASK_MISC, but you read AMD_MDB_TLP_IR_MASK_MISC and
then write AMD_MDB_TLP_IR_ENABLE_MISC.  Same below in
amd_mdb_intx_irq_unmask().

> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static void amd_mdb_intx_irq_unmask(struct irq_data *data)
> +{
> +	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(data);
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *port = &pci->pp;
> +	unsigned long flags;
> +	u32 val;
> +
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val = pcie_read(pcie, AMD_MDB_TLP_IR_MASK_MISC);
> +	val |= AMD_MDB_PCIE_INTX_BIT(data->hwirq);
> +	pcie_write(pcie, val, AMD_MDB_TLP_IR_ENABLE_MISC);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}

> +static irqreturn_t dw_pcie_rp_intx_flow(int irq, void *args)

It'd be nice if this were close in the source file to the INTx
mask/unmask above.

> +{
> +	struct amd_mdb_pcie *pcie = args;
> +	unsigned long val;
> +	int i;
> +
> +	val = FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK,
> +			pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC));
> +
> +	for (i = 0; i < PCI_NUM_INTX; i++) {
> +		if (val & AMD_MDB_PCIE_INTR_INTX_ASSERT(i))
> +			generic_handle_domain_irq(pcie->intx_domain, i);
> +		if (val & AMD_MDB_PCIE_INTR_INTX_DEASSERT(i)
> +			generic_handle_domain_irq(pcie->intx_domain, (i * 2) + 1);

Why call generic_handle_domain_irq() for deassert?  No other drivers
do that AFAIK.  If you do need it, "(i * 2) + 1" looks completely
wrong; it should be the hwirq value.

> +	}
> +
> +	return IRQ_HANDLED;
> +}

> +static irqreturn_t amd_mdb_pcie_intr_handler(int irq, void *args)
> +{
> +	struct amd_mdb_pcie *pcie = args;
> +	struct device *dev;
> +	struct irq_data *d;
> +
> +	dev = pcie->pci.dev;
> +
> +	/**

  /* (not /**)

> +	 * In future, error reporting will be hooked to the AER subsystem.
> +	 * Currently, the driver prints a warning message to the user.
> +	 */
> +	d = irq_domain_get_irq_data(pcie->mdb_domain, irq);
> +	if (intr_cause[d->hwirq].str)
> +		dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
> +	else
> +		dev_warn_once(dev, "Unknown IRQ %ld\n", d->hwirq);
> +
> +	return IRQ_HANDLED;
> +}

> +static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
> +			     struct platform_device *pdev)
> +{
> ...

> +
> +	/* Plug the main event handler */
> +	err = devm_request_irq(dev, pp->irq, amd_mdb_pcie_event_flow,
> +			       IRQF_SHARED | IRQF_NO_THREAD, "amd_mdb pcie_irq", pcie);

Wrap to fit in 80 columns like the rest of the file.

Bjorn

