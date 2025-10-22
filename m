Return-Path: <linux-pci+bounces-39064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B1CBFE16A
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 21:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C07B83442AE
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 19:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B282F0678;
	Wed, 22 Oct 2025 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyKiCIjg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB75425F7A5;
	Wed, 22 Oct 2025 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761162582; cv=none; b=Ir1ehKKqXQueuzQ5qGetTX8ooMmnuH9Rnx1fpR6HLn4yXQupELjry2PhRqDN5rf3rHmW48vNHUBfsSsv4ONMz8YXCe4hzmXEqUGVzYtv9kQ7LXURDzT0HHeWe01b8hagX69NGGE1dcZYIt9ViEeuBuWlKfCHt8eV8yRruGgIpp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761162582; c=relaxed/simple;
	bh=AIoAYtzLfIP2cEKmbA5wBFYBFjPPpObwFVg5kxuV8ac=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=djGUt+I83JidnUgeNGjKnPBSyMiz1JgtdALkb0Fy1cMRCY1vdzejBLx9ClAQt4iS9tdnGhRcII9jSGSPFG6rSIUI+6psVOtB4aYUgx7Vz4+BQh9fgWsZgKRK/+ai+eFN6D26xqaWlyP+BY51j0wezZgwM5H7zLRMl3f5+eI2aVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyKiCIjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BCEC4CEE7;
	Wed, 22 Oct 2025 19:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761162581;
	bh=AIoAYtzLfIP2cEKmbA5wBFYBFjPPpObwFVg5kxuV8ac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UyKiCIjgaK/V/4PpHQXmQDUztuRKPmzgURfcr0pbQ20/J6eDJBRWsxmPVdSF9498S
	 zbv+jui8rHR/sNZJchjE9y61k2btTNo85H9iEwMi7h8pDKtgj6/DetLb8pIczXyvDe
	 a571Xy6mUeXRv2QK6gLOpsWdv4jnl2xDbQqq3LWvIjN+CF3GcMnv1/KMkOEb9nZFrB
	 k/QqWjnmeuLXG1NhJDoZ84XPSG88+cHPry9qJ7/56xLGL/ufgGsr7n98TtP3/xMkCC
	 sFo1XxXUPgjY82DsvHFoZ5vHhWwY9rhPmliv87NpAY39XUbyfIo1ebWSscv6IN2Cqc
	 e46wJHF+O7jGA==
Date: Wed, 22 Oct 2025 14:49:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
	p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v5 2/6] PCI: rzg3s-host: Add Renesas RZ/G3S SoC host
 driver
Message-ID: <20251022194939.GA1223383@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007133657.390523-3-claudiu.beznea.uj@bp.renesas.com>

On Tue, Oct 07, 2025 at 04:36:53PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> only as a root complex, with a single-lane (x1) configuration. The
> controller includes Type 1 configuration registers, as well as IP
> specific registers (called AXI registers) required for various adjustments.

> +++ b/drivers/pci/controller/Kconfig
> @@ -266,6 +266,14 @@ config PCI_RCAR_GEN2
>  	  There are 3 internal PCI controllers available with a single
>  	  built-in EHCI/OHCI host controller present on each one.
>  
> +config PCIE_RENESAS_RZG3S_HOST
> +	bool "Renesas RZ/G3S PCIe host controller"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	select MFD_SYSCON
> +	select IRQ_MSI_LIB
> +	help
> +	  Say Y here if you want PCIe host controller support on Renesas RZ/G3S SoC.

Wrap to fit in 80 columns like the rest of the file.

> +++ b/drivers/pci/controller/pcie-rzg3s-host.c

> +#define RZG3S_PCI_MSIRCVWMSKL			0x108
> +#define RZG3S_PCI_MSIRCVWMSKL_MASK		GENMASK(31, 2)

Unfortunate to have to add _MASK here when none of the other GENMASKs
need it.  Can't think of a better name though.

> +#define RZG3S_PCI_MSIRCVWMSKU			0x10c

Unused.

> +#define RZG3S_PCI_AMEIE				0x210

Unused.

> +#define RZG3S_PCI_ASEIE1			0x220

Unused.

> +#define RZG3S_PCI_PCSTAT2_STATE_RX_DETECT	GENMASK(15, 8)

Unused.

> +/* Timeouts experimentally determined. */

No need for period at end.

> +static int rzg3s_pcie_child_read_conf(struct rzg3s_pcie_host *host,
> +				      struct pci_bus *bus,
> +				      unsigned int devfn, int where,
> +				      u32 *data)

Would fit in three lines if you want.

> +static int rzg3s_pcie_child_write_conf(struct rzg3s_pcie_host *host,
> +				       struct pci_bus *bus,
> +				       unsigned int devfn, int where,
> +				       u32 data)

Ditto.

> +static int rzg3s_pcie_msi_enable(struct rzg3s_pcie_host *host)
> +{
> +	struct platform_device *pdev = to_platform_device(host->dev);
> +	struct rzg3s_pcie_msi *msi = &host->msi;
> +	struct device *dev = host->dev;
> +	const char *devname;
> +	int irq, ret;
> +
> +	ret = devm_mutex_init(dev, &msi->map_lock);
> +	if (ret)
> +		return ret;
> +
> +	msi->irq = platform_get_irq_byname(pdev, "msi");
> +	if (msi->irq < 0)
> +		return dev_err_probe(dev, irq ? irq : -EINVAL,
> +				     "Failed to get MSI IRQ!\n");
> +
> +	devname = devm_kasprintf(dev, GFP_KERNEL, "%s-msi", dev_name(dev));
> +	if (!devname)
> +		return -ENOMEM;
> +
> +	ret = rzg3s_pcie_msi_allocate_domains(msi);
> +	if (ret)
> +		return ret;
> +
> +	ret = request_irq(msi->irq, rzg3s_pcie_msi_irq, 0, devname, host);

Should this be devm_request_irq()?  Most drivers use it, although
pci-tegra.c and pcie-apple.c do not.  Maybe there's some special rule
about using request_irq() even though the driver uses devm in general?
I dunno.

> +static int rzg3s_pcie_intx_setup(struct rzg3s_pcie_host *host)
> +{
> +	struct device *dev = host->dev;
> +
> +	for (int i = 0; i < PCI_NUM_INTX; i++) {
> +		struct platform_device *pdev = to_platform_device(dev);

Looks like this should be outside the loop.

> +		char irq_name[5] = {0};
> +		int irq;
> +
> +		scnprintf(irq_name, ARRAY_SIZE(irq_name), "int%c", 'a' + i);
> +
> +		irq = platform_get_irq_byname(pdev, irq_name);
> +		if (irq < 0)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Failed to parse and map INT%c IRQ\n",
> +					     'A' + i);
> +
> +		host->intx_irqs[i] = irq;
> +		irq_set_chained_handler_and_data(irq,
> +						 rzg3s_pcie_intx_irq_handler,
> +						 host);
> +	}

> +static int rzg3s_pcie_power_resets_deassert(struct rzg3s_pcie_host *host)
> +{
> +	const struct rzg3s_pcie_soc_data *data = host->data;
> +
> +	/*
> +	 * According to the RZ/G3S HW manual (Rev.1.10, section
> +	 * 34.5.1.2 De-asserting the Reset) the PCIe IP needs to wait 5ms from
> +	 * power on to the de-assertion of reset.
> +	 */
> +	usleep_range(5000, 5100);

Consider fsleep() so we don't have to make up the 100us interval.

