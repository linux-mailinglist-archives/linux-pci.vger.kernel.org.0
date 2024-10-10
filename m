Return-Path: <linux-pci+bounces-14226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E287299921D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 21:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5FD1C23FAB
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 19:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7FA1C9B93;
	Thu, 10 Oct 2024 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxL8Dtpm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67962199E9B;
	Thu, 10 Oct 2024 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728588165; cv=none; b=C8dGdTiqHBWieRkpfqq0TH6N7roM5DyAaqcc69440oHztKUOR9E7qihBOz6WME5cSl72CSTxx3MTS1aaDgNGeviRZ6Iy+x5TVRRmUfHi3xc9e28ttvT9jvGBdeSRGTr5WTynFkPer1JqeSECpyUh3m+mhsNfvBc0Ew4G61x1AKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728588165; c=relaxed/simple;
	bh=BobLlBAHXvgkmTfcYJ918ZwYFw0KZ50oja9YbgYE578=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WwxjmHy0i0bV7GNCEThF4AK8PPUpXZv/0vhH6Kg4pKy+r7z6ocUvYc0icarjJe0DZQ7QfiquExmYMND2wfuIFwWSn0wkpMnTh7ACPBqdKuHCxs2A/QfKEAF4nA5BBv/ge8/0kGhVfpT8l7kmHH9rA6D7vxKdqZ97RlzXfFUZdaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxL8Dtpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EDDC4CECD;
	Thu, 10 Oct 2024 19:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728588165;
	bh=BobLlBAHXvgkmTfcYJ918ZwYFw0KZ50oja9YbgYE578=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VxL8DtpmsZ5s62//hcB6UyBuWVpNLlNZliRP1k6XpGxdgNjgkNJDpI+25sFjZnh1B
	 hZF92dbDyUbZKSPKZR5OesyedLtFqu6Zv0xzmyzeuBNkShYrobrCwSJZnWaF0rQ/xY
	 zzDxaVNBPuxseoYAbbjT3XpzqwcK33Tr7ZYMqZ32PY8JZZkzsg6DJCXlUoyYDWsb7w
	 VOOJ6NEFaEUnikP1wCdqFs1I/EeHUC3+nJrbMXcyt05oAM/MuNHhwIyJoYRWOesePb
	 1O/5LhM4vIOWCL6ft9LvN5ZND5wj2IJgJmTaCVhGpIBMJTMf0XjXF9ZR1wMkntSHiw
	 SGBfd3g0zr+tg==
Date: Thu, 10 Oct 2024 14:22:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>, Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v9 1/6] misc: Add support for LAN966x PCI device
Message-ID: <20241010192243.GA573660@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010063611.788527-2-herve.codina@bootlin.com>

On Thu, Oct 10, 2024 at 08:36:01AM +0200, Herve Codina wrote:
> Add a PCI driver that handles the LAN966x PCI device using a device-tree
> overlay. This overlay is applied to the PCI device DT node and allows to
> describe components that are present in the device.
> 
> The memory from the device-tree is remapped to the BAR memory thanks to
> "ranges" properties computed at runtime by the PCI core during the PCI
> enumeration.
> 
> The PCI device itself acts as an interrupt controller and is used as the
> parent of the internal LAN966x interrupt controller to route the
> interrupts to the assigned PCI INTx interrupt.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# quirks.c

> ---
>  drivers/misc/Kconfig          |  24 ++++
>  drivers/misc/Makefile         |   3 +
>  drivers/misc/lan966x_pci.c    | 215 ++++++++++++++++++++++++++++++++++
>  drivers/misc/lan966x_pci.dtso | 167 ++++++++++++++++++++++++++
>  drivers/pci/quirks.c          |   1 +
>  5 files changed, 410 insertions(+)
>  create mode 100644 drivers/misc/lan966x_pci.c
>  create mode 100644 drivers/misc/lan966x_pci.dtso
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 3fe7e2a9bd29..8e5b06ac9b6f 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -610,6 +610,30 @@ config MARVELL_CN10K_DPI
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called mrvl_cn10k_dpi.
>  
> +config MCHP_LAN966X_PCI
> +	tristate "Microchip LAN966x PCIe Support"
> +	depends on PCI
> +	select OF
> +	select OF_OVERLAY
> +	select IRQ_DOMAIN
> +	help
> +	  This enables the support for the LAN966x PCIe device.
> +	  This is used to drive the LAN966x PCIe device from the host system
> +	  to which it is connected.
> +
> +	  This driver uses an overlay to load other drivers to support for
> +	  LAN966x internal components.
> +	  Even if this driver does not depend on these other drivers, in order
> +	  to have a fully functional board, the following drivers are needed:

I don't think "overlay" by itself has enough context to be useful as
help text.  Maybe "device tree" or similar hint?

Add blank lines between paragraphs or reflow into a single paragraph.

> +	    - fixed-clock (COMMON_CLK)
> +	    - lan966x-oic (LAN966X_OIC)
> +	    - lan966x-cpu-syscon (MFD_SYSCON)
> +	    - lan966x-switch-reset (RESET_MCHP_SPARX5)
> +	    - lan966x-pinctrl (PINCTRL_OCELOT)
> +	    - lan966x-serdes (PHY_LAN966X_SERDES)
> +	    - lan966x-miim (MDIO_MSCC_MIIM)
> +	    - lan966x-switch (LAN966X_SWITCH)
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index dccb60c1d9cc..41dec625ed7b 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6266,6 +6266,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa76e, dpc_log_size);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, of_pci_make_dev_node);
>  
>  /*
>   * Devices known to require a longer delay before first config space access
> -- 
> 2.46.2
> 

