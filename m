Return-Path: <linux-pci+bounces-17476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 340F39DECA3
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 21:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D3216140E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 20:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316F5155300;
	Fri, 29 Nov 2024 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dF5gR/Nw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA9E545;
	Fri, 29 Nov 2024 20:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732911726; cv=none; b=BttE128UzlBSA32yf6RyPsphavLzVGNu6n03DYKvdBjfOVO5fbIkGsMZGfS9H2giOujc1mG59t+/AzJx2pr2XTSFxdvp3kY+lgRUu/Le+GKzYUjTGeeBF74AlsZgJwZwm3b1YXPdeRhpemWM9/ZwHR+2lz+cIuSAoZrcktMlqfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732911726; c=relaxed/simple;
	bh=fy4e/x1/Z0FUaIbDJiNmJ65itWjY8DZ/a4+SMqhGJfI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pgarCHc5XtVvLY7jCkJa7BPW5TO3+dND35gW97r/imJ39KSEAm7dLtfDxcWNeiQsHXENyAqVig6kYBURDR5shepJlStZBp+GHNFeqX+Am+xq8Uz2uc4/wJSN38iOBWFlyZyN0UigUM1vQ0QopmwqyeCTr1hn9NNkvYPadeTRp7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dF5gR/Nw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4671FC4CECF;
	Fri, 29 Nov 2024 20:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732911725;
	bh=fy4e/x1/Z0FUaIbDJiNmJ65itWjY8DZ/a4+SMqhGJfI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dF5gR/NwNESWEs8RCeEsxA+oTOQI4tl8Sfx7PNrT8uARwlI8bpuHLjHFSEmgkR5i0
	 EhdoUDMFyKfM1q0ijxfIAwS/ult2roPBfLrem8CczQl5ACq6ElC1j9XYTdjydfJm1Y
	 HOnvtLldocaYxILFtO3VK+lT4q0LfrOkayEhE66dRJxaGf92XFKsDvnACbeMWUI+Ud
	 siz/fIGR+jVXxksRDR+YwAKBfbvqIvrVsn9jFmaU3qD77PnBoXU1PgkcQFaz4xxq9e
	 MNMfT4bDChJjYZSV1xyaf+X1DSCEX4Qtls9lZJf8MzC2IYKE7BEVw782MvaBhMSD4E
	 IhuvvuHRyfFew==
Date: Fri, 29 Nov 2024 14:22:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jingoohan1@gmail.com, michal.simek@amd.com,
	bharat.kumar.gogada@amd.com
Subject: Re: [PATCH 2/2] PCI: amd-mdb: Add AMD MDB Root Port driver
Message-ID: <20241129202202.GA2771092@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127115804.2046576-3-thippeswamy.havalige@amd.com>

On Wed, Nov 27, 2024 at 05:28:04PM +0530, Thippeswamy Havalige wrote:
> Add support for AMD MDB(Multimedia DMA Bridge) IP core as Root Port.
> 
> The Versal2 devices include MDB Module. The integrated block for MDB along
> with the integrated bridge can function as PCIe Root Port controller at
> Gen5 speed.

What speed is Gen5?  Please include the numeric speed so we don't have
to Google it.

> Bridge error and legacy interrupts in Versal2 MDB are handled using Versal2
> MDB specific interrupt line.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
>  drivers/pci/controller/dwc/Kconfig        |  10 +
>  drivers/pci/controller/dwc/Makefile       |   1 +
>  drivers/pci/controller/dwc/pcie-amd-mdb.c | 455 ++++++++++++++++++++++
>  3 files changed, 466 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index b6d6778b0698..e7ddab8da2c4 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -14,6 +14,16 @@ config PCIE_DW_EP
>  	bool
>  	select PCIE_DW
>  
> +config PCIE_AMD_MDB
> +	bool "AMD PCIe controller (host mode)"
> +	depends on OF || COMPILE_TEST
> +	depends on PCI && PCI_MSI
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here to enable PCIe controller support on AMD SoCs. The
> +	  PCIe controller is based on DesignWare Hardware and uses AMD
> +	  hardware wrappers.

Alphabetize by vendor name.  I suppose "Advanced" *would* sort before
"Amazon", but since "AMD" isn't spelled out, I think we have to sort
by the initialism and put "Ama" before "AMD".

>  config PCIE_AL
>  	bool "Amazon Annapurna Labs PCIe controller"
>  	depends on OF && (ARM64 || COMPILE_TEST)

> +static void amd_mdb_mask_leg_irq(struct irq_data *data)

s/_leg_/_intx_/

> +{
> +	struct dw_pcie_rp *port = irq_data_get_irq_chip_data(data);
> +	struct amd_mdb_pcie *pcie;
> +	unsigned long flags;
> +	u32 mask, val;
> +
> +	pcie = get_mdb_pcie(port);

Here and elsewhere, this could be done in the automatic variable list
above since this is non-interesting setup.

> +static void amd_mdb_unmask_leg_irq(struct irq_data *data)

Ditto.

> +static struct irq_chip amd_mdb_leg_irq_chip = {

Ditto.

> +static int amd_mdb_pcie_rp_intx_map(struct irq_domain *domain,
> +				    unsigned int irq, irq_hw_number_t hwirq)

"_rp_" in name unnecessary.

> +static irqreturn_t amd_mdb_pcie_rp_intr_handler(int irq, void *dev_id)
> +{
> +	struct dw_pcie_rp *port = dev_id;
> +	struct amd_mdb_pcie *pcie;
> +	struct device *dev;
> +	struct irq_data *d;
> +
> +	pcie = get_mdb_pcie(port);
> +	dev = pcie->pci.dev;
> +
> +	d = irq_domain_get_irq_data(pcie->mdb_domain, irq);
> +	if (intr_cause[d->hwirq].str)
> +		dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
> +	else
> +		dev_warn(dev, "Unknown IRQ %ld\n", d->hwirq);
> +
> +	return IRQ_HANDLED;

I see that some of these messages are "Correctable/Non-Fatal/Fatal
error message"; I assume this Root Port doesn't have an AER
Capability, and this interrupt is the "System Error" controlled by the
Root Control Error Enable bits in the PCIe Capability?  (See PCIe
r6.0, sec 6.2.6)

Is there any way to hook this into the AER handling so we can do
something about it, since the devices *below* the Root Port may
support AER and may have useful information logged?

Since this is DWC-based, I suppose these are general questions that
apply to all the similar drivers.

> +static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
> +				 struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *pp = &pci->pp;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	pp->ops = &amd_mdb_pcie_host_ops;

This is dw-related initialization; move it down just before the first
use at dw_pcie_host_init().

> +	pcie->mdb_base = devm_platform_ioremap_resource_byname(pdev, "mdb_pcie_slcr");
> +	if (IS_ERR(pcie->mdb_base))
> +		return PTR_ERR(pcie->mdb_base);
> +
> +	ret = amd_mdb_pcie_rp_init_irq_domain(pcie, pdev);

Other drivers use "*_pcie_init_irq_domain" (without "rp").  It's
helpful to use similar names so it's easier to compare
implementations.

Since amd_mdb_pcie_free_irq_domains() cleans this up, I think both
should end with "domains" (with an "s") so they match.

> +	if (ret)
> +		return ret;
> +
> +	amd_mdb_pcie_rp_init_port(pcie, pdev);

Other drivers use "*_pcie_init_port" (without "rp").

> +	ret = amd_mdb_setup_irq(pcie, pdev);
> +	if (ret) {
> +		dev_err(dev, "Failed to set up interrupts\n");
> +		goto out;
> +	}
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

Bjorn

