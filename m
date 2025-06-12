Return-Path: <linux-pci+bounces-29611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1595AD7C6F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 22:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E929B1888ECF
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 20:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB5C2D8785;
	Thu, 12 Jun 2025 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h74ewMVu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE131D95B3;
	Thu, 12 Jun 2025 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749760429; cv=none; b=KBBIkKINUyOkvwkjNxRdKxjy2tGMowvQkwTL1C7Pb+71AHxANBlHzXdEf0BLpkNNOKA+kL8485PELXONd7UviBi8uLnzNOLtZNC0Z4tTW0HsQqzyWrFsPj6I3cHXT4Lkul801HQJoqO1EIpBuhpnBHzG63HL1l7mQiBzzR6GPLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749760429; c=relaxed/simple;
	bh=dMuKn6Rn360CgpuHNtCLvFamVrOZjcTNMmRJ123llfY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=USrpwb7d4aAAOc6TGgobor+L4NmjmNylVVxH36NIIMqjCCItRb6wnYK82hDP62e8KmBZKpwb65YYACHw5YbKFBcUqkBgz5if+3RgBC3o9hlFsTDgMsEFeuXO7zoRkUDejPQZrJ3xGjoarSOtiY4FbqVvnlGYD+K2Bu9h9+AajIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h74ewMVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4E8C4CEEA;
	Thu, 12 Jun 2025 20:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749760429;
	bh=dMuKn6Rn360CgpuHNtCLvFamVrOZjcTNMmRJ123llfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=h74ewMVuthSJK1rceReZR/j0/hAfGmtaq60OaOswKCDEZ0eVTNe4jZYJXBezkDbDy
	 UQnrGDfmB78E8OEYqdFq+ZMfxjso1AfILFHyCFzm1wNxEHKRMa8ZmjMi7k2f+xWL37
	 csmU+cqFNimFc/f/0fdjRkqhpwWbgO7PONs5qCRGL/gy8CUmszMKDtU1p8j/9ylyKc
	 MkDUfWkvY551iGC/+I0SlN1OwbNraTFZz2GHd0zS9aKkbdmS8azCQ9SEWNOLFkX+Li
	 qvNwghpxaphtSyUj5gR2UGc4I9aHkK1UhEkYDAzA6O7cl0Wvyf3yyuvAvNlWa9ov0K
	 JlqWB0JYe0bGQ==
Date: Thu, 12 Jun 2025 15:33:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, cassel@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com,
	bharat.kumar.gogada@amd.com, thippeswamy.havalige@amd.com
Subject: Re: [RESEND PATCH v7 2/2] PCI: xilinx-cpm: Add support for PCIe RP
 PERST# signal
Message-ID: <20250612203347.GA926120@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414032304.862779-3-sai.krishna.musham@amd.com>

On Mon, Apr 14, 2025 at 08:53:04AM +0530, Sai Krishna Musham wrote:
> Add support for handling the PCIe Root Port (RP) PERST# signal using
> the GPIO framework, along with the PCIe IP reset. This reset is
> managed by the driver and occurs after the Initial Power Up sequence
> (PCIe CEM r6.0, 2.2.1) is handled in hardware before the driver's probe
> function is called.

Please say something specific here about what this does.  I *think* it
asserts both the PCIe IP reset (which I assume resets the host
controller) and PERST# (which resets any devices connected to the Root
Port), but only for devices that implement the CPM Clock and Reset
Control Registers AND describe the address of those registers via
DT "cpm_crx" AND describe a GPIO connected to PERST# via DT "reset".

> This reset mechanism is particularly useful in warm reset scenarios,
> where the power rails remain stable and only PERST# signal is toggled
> through the driver. Applying both the PCIe IP reset and the PERST#
> improves the reliability of the reset process by ensuring that both
> the Root Port controller and the Endpoint are reset synchronously
> and avoid lane errors.
> 
> Adapt the implementation to use the GPIO framework for reset signal
> handling and make this reset handling optional, along with the
> `cpm_crx` property, to maintain backward compatibility with existing
> device tree binaries (DTBs).

> Additionally, clear Firewall after the link reset for CPM5NC to allow
> further PCIe transactions.

> -static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
> +static int xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
>  {
>  	const struct xilinx_cpm_variant *variant = port->variant;
> +	struct device *dev = port->dev;
> +	struct gpio_desc *reset_gpio;
> +	bool do_reset = false;
> +
> +	if (port->crx_base && (variant->version < CPM5NC_HOST ||
> +			       (variant->version == CPM5NC_HOST &&
> +				port->cpm5nc_fw_base))) {

Would be nicer if you could simply test for the feature, not the
specific variants, e.g.,

  if (port->crx_base && port->perst_gpio) {
    writel_relaxed(0x1, port->crx_base + variant->cpm_pcie_rst);
    udelay(100);
    writel_relaxed(0x0, port->crx_base + variant->cpm_pcie_rst);
    gpiod_set_value(port->perst_gpio, 0);
    mdelay(PCIE_T_RRS_READY_MS);
  }

  if (port->firewall_base) {
    /* Clear Firewall */
  }

If you need to check the variants vs "cpm_crx", I think that should go
in xilinx_cpm_pcie_parse_dt().

> +		/* Request the GPIO for PCIe reset signal and assert */
> +		reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +		if (IS_ERR(reset_gpio))
> +			return dev_err_probe(dev, PTR_ERR(reset_gpio),
> +					     "Failed to request reset GPIO\n");
> +		if (reset_gpio)
> +			do_reset = true;
> +	}

Maybe the devm_gpiod_get_optional() could go in
xilinx_cpm_pcie_parse_dt() along with other DT stuff, as is done in
starfive_pcie_parse_dt()/starfive_pcie_host_init()?

You'd have to save the port->reset_gpio pointer so we could use it
here, but wouldn't have to return error from
xilinx_cpm_pcie_init_port().

> +
> +	if (do_reset) {
> +		/* Assert the PCIe IP reset */
> +		writel_relaxed(0x1, port->crx_base + variant->cpm_pcie_rst);
> +
> +		/*
> +		 * "PERST# active time", as per Table 2-10: Power Sequencing
> +		 * and Reset Signal Timings of the PCIe Electromechanical
> +		 * Specification, Revision 6.0, symbol "T_PERST".
> +		 */
> +		udelay(100);

Whatever we need here, this should be a #define from drivers/pci/pci.h
instead of 100.

> +
> +		/* Deassert the PCIe IP reset */
> +		writel_relaxed(0x0, port->crx_base + variant->cpm_pcie_rst);
> +
> +		/* Deassert the reset signal */
> +		gpiod_set_value(reset_gpio, 0);

I think reset_gpio controls PERST#.  If so, it would be nice to have
"perst" in the name to make it less ambiguous.

> +		mdelay(PCIE_T_RRS_READY_MS);

We only wait PCIE_T_RRS_READY_MS for certain variants and only when
the optional "cpm_crx" and "reset" properties are present.

What about the other cases?  Unless there's something that guarantees
a delay after the link comes up before we call pci_host_probe(), that
sounds like a bug in the existing driver.  If it is a bug, you should
fix it in its own separate patch.

> +		if (variant->version == CPM5NC_HOST &&
> +		    port->cpm5nc_fw_base) {

Unnecessary to test both variant->version and port->cpm5nc_fw_base
here, since only CPM5NC_HOST sets cpm5nc_fw_base.

The function of the "Firewall" should be explained in the commit log,
and it seems like the sort of thing that's likely to appear in future
variants, so "cpm5nc_" seems like it might be unnecessarily specific.
Maybe consider naming these "firewall_base" and "firewall_reset" so
the test and the writes wouldn't have to change for future variants.

> +			/* Clear Firewall */
> +			writel_relaxed(0x00, port->cpm5nc_fw_base +
> +				       variant->cpm5nc_fw_rst);
> +			writel_relaxed(0x01, port->cpm5nc_fw_base +
> +				       variant->cpm5nc_fw_rst);
> +			writel_relaxed(0x00, port->cpm5nc_fw_base +
> +				       variant->cpm5nc_fw_rst);
> +		}
> +	}
>  
>  	if (variant->version == CPM5NC_HOST)

You didn't change this test, but it would be better if you could test
for a *feature* instead of a specific variant.  Then you can avoid
changes when future chips have the same feature.

> -		return;
> +		return 0;
>  
>  	if (cpm_pcie_link_up(port))
>  		dev_info(port->dev, "PCIe Link is UP\n");
> @@ -512,6 +574,8 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
>  	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
>  		   XILINX_CPM_PCIE_REG_RPSC_BEN,
>  		   XILINX_CPM_PCIE_REG_RPSC);
> +
> +	return 0;
>  }

