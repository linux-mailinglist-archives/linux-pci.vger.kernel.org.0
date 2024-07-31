Return-Path: <linux-pci+bounces-11073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E597794370D
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 22:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B59A1C21189
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 20:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E1D4594A;
	Wed, 31 Jul 2024 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWAtc2tf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26605182D8;
	Wed, 31 Jul 2024 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722457421; cv=none; b=D80mPbRHWAiUkPGO0ymKp22epQvuLiwR8tk083PI9mNK8rRzO31YRRWpAU5aujJiZi0gN4UYUpYB2uyhaPKQ25zzQEw0j2N1oeRY38G5xgLpy6Y2Ps9WKb4+wyM1FTb1L3GEYC11KP7vbMtWjQ/sAUXJblebsyN3vL6gd+5kzL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722457421; c=relaxed/simple;
	bh=AY5BnWdQ2yo2WR6h0ILx9cGNB0P+qWgeQPBR2YUHwvo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ty+OpNk/mzU3FtRXcgyc7DdDy0oCrAIBIeW6/IipfmMT/Jd71LvyiHHOe20EOVPymQucYjfgq1B9FD9sisz1hWuoEYgxUzibAdsVwFV1XZ8Y2nHQLaX9vLTnr9KqoT0++VQAsVkCF3iAGqXr+J9cRFywx+evWXUmvtl+Hx01A0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWAtc2tf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D6FC116B1;
	Wed, 31 Jul 2024 20:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722457420;
	bh=AY5BnWdQ2yo2WR6h0ILx9cGNB0P+qWgeQPBR2YUHwvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mWAtc2tfrspROl+zbHWZYl09LpX6URPVKntcxAbob7gPhpjZIerjxdwBfttMrXKu9
	 MBZK5Bi1Ynl8UcdoMe0xNoUapMEzotKDii6M9r8ej82LINNVKENFATnIZhht6VR0fm
	 8hgx6QLrj+NgFwRpixgXx2jSgNSQfZmPpOddURJSB7gWRluvJxG9sOWlHZrhs9QbAB
	 iggB8gYwbL3hAiEBZ4a6N1gYgpfLdialV8foX5KcuaPXrKwWvgSprGiWBxkJSw1kMy
	 qnfaSxzMSKIUnb+74rwPSWLnQIPwNdBomwYuCGBf1U4I6QmSRwy32a1xS35LUc+hYG
	 a4l6/nmRF8Teg==
Date: Wed, 31 Jul 2024 15:23:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: matthew.gerlach@linux.intel.com
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	dinguyen@kernel.org, joyce.ooi@intel.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	"D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>,
	D@bhelgaas.smtp.subspace.kernel.org,
	M@bhelgaas.smtp.subspace.kernel.org
Subject: Re: [PATCH 7/7] pci: controller: pcie-altera: Add support for Agilex
Message-ID: <20240731202338.GA78770@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731143946.3478057-8-matthew.gerlach@linux.intel.com>

In subject:

  PCI: altera: Add Agilex support

to match style of history.

>  #define TLP_CFG_DW1(pcie, tag, be)	\
> -	(((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))
> +	(((TLP_REQ_ID((pcie)->root_bus_nr,  RP_DEVFN)) << 16) | ((tag) << 8) | (be))

Seems OK, but unrelated to adding Agilex support, so it should be a
separate patch.

> +#define AGLX_RP_CFG_ADDR(pcie, reg)	\
> +	(((pcie)->hip_base) + (reg))

Fits on one line.

> +#define AGLX_BDF_REG 0x00002004
> +#define AGLX_ROOT_PORT_IRQ_STATUS 0x14c
> +#define AGLX_ROOT_PORT_IRQ_ENABLE 0x150
> +#define CFG_AER                   BIT(4)

Indent values to match #defines above.

>  static bool altera_pcie_hide_rc_bar(struct pci_bus *bus, unsigned int  devfn,
>  				    int offset)
>  {
> -	if (pci_is_root_bus(bus) && (devfn == 0) &&
> -	    (offset == PCI_BASE_ADDRESS_0))
> +	if (pci_is_root_bus(bus) && devfn == 0 && offset == PCI_BASE_ADDRESS_0)
>  		return true;

OK, but again unrelated to Agilex.

> @@ -373,7 +422,7 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
>  	 * Monitor changes to PCI_PRIMARY_BUS register on root port
>  	 * and update local copy of root bus number accordingly.
>  	 */
> -	if ((bus == pcie->root_bus_nr) && (where == PCI_PRIMARY_BUS))
> +	if (bus == pcie->root_bus_nr && where == PCI_PRIMARY_BUS)

Ditto.

> @@ -577,7 +731,7 @@ static void altera_wait_link_retrain(struct altera_pcie *pcie)
>  			dev_err(dev, "link retrain timeout\n");
>  			break;
>  		}
> -		udelay(100);
> +		usleep_range(50, 150);

Where do these values come from?  Needs a comment, ideally with a spec
citation.

How do we know a 50us delay is enough when we previously waited at
least 100us?

> @@ -590,7 +744,7 @@ static void altera_wait_link_retrain(struct altera_pcie *pcie)
>  			dev_err(dev, "link up timeout\n");
>  			break;
>  		}
> -		udelay(100);
> +		usleep_range(50, 150);

Ditto.

> +static void aglx_isr(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct altera_pcie *pcie;
> +	struct device *dev;
> +	u32 status;
> +	int ret;
> +
> +	chained_irq_enter(chip, desc);
> +	pcie = irq_desc_get_handler_data(desc);
> +	dev = &pcie->pdev->dev;
>  
> +	status = readl(pcie->hip_base + pcie->pcie_data->port_conf_offset +
> +		       pcie->pcie_data->port_irq_status_offset);
> +	if (status & CFG_AER) {
> +		ret = generic_handle_domain_irq(pcie->irq_domain, 0);
> +		if (ret)
> +			dev_err_ratelimited(dev, "unexpected IRQ,\n");

Was there supposed to be more data here, e.g., an IRQ %d or something?
Or is it just a spurious "," at the end of the line?

>  	pcie->irq_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
> -					&intx_domain_ops, pcie);
> +						 &intx_domain_ops, pcie);

Cleanup that should be in a separate patch.  *This* patch should have
the absolute minimum required to enable Agilex to make it easier to
review/backport/revert/etc.

> +static const struct altera_pcie_data altera_pcie_3_0_f_tile_data = {
> +	.ops = &altera_pcie_ops_3_0,
> +	.version = ALTERA_PCIE_V3,
> +	.cap_offset = 0x70,

It looks like this is where the PCIe Capability is?  There's no way to
discover this offset, e.g., by following the capability list like
pci_find_capability() does?

Bjorn

