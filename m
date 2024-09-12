Return-Path: <linux-pci+bounces-13126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F850976F41
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 19:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826241C23B6F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 17:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF09F156F44;
	Thu, 12 Sep 2024 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDF/dz1e"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D2449654;
	Thu, 12 Sep 2024 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726160455; cv=none; b=Kt+I6RlttKVY6RBrhFvxUN0DLQmOROvgkB/DmQIw21ihsuwB1Biy06/o5t100emtKhE4PXav7Oox39malKrTffIpu4/E/EhB86e4GSzNmwU9PgMuMJ3AHera0ovQDDFCGH9PZfChIxLSW3EtBA6oFIHRQoFqqLXNobKEdC+MpmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726160455; c=relaxed/simple;
	bh=UDKMDUCUwWVXn9aUo/LFf70emdXSaz9qd8L0RE6dHN4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hu8dQvygcCeFBu2YgzPT09172CoZ3GkWU0U7juhnOACAgeC49JabMnDnQVbfEGCmcwzhDu+ll7+bMyqq+ELPrG24p2NC10JVQDvETbFD/lmAtFO3MKwbnIytMWnBOKHfu7ElLuv+KkKe1OAct1sfEMWpbQgm6kDuNHCSWec0nek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDF/dz1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14CEC4CEC3;
	Thu, 12 Sep 2024 17:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726160455;
	bh=UDKMDUCUwWVXn9aUo/LFf70emdXSaz9qd8L0RE6dHN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mDF/dz1ec0OQiVPo0b5i0DSy1dXUfD1Gg5jPKs0WrFVVfZc09uFPI1Mj14yfCInfy
	 tiGWr3CN1aHP5AX/whkpHWZmq9iBz4pvwTUX5oxrG1X1V5Ilz5hcOeHVkkiNDoEFE8
	 7LXONGdrCPS1+ta3kPL8deLye8eDnGBW+kwkbvGhcwj8PK+IqxTgSUAzV95wgnE4hC
	 PB/Pmrso03xFZsC2dVmfj9/uOd8gLUf1046rjlvdfA9ZBE/g/sWH6YXk0PmmCCEmkq
	 b3VaDl7zEbHn1LtDCht/sYhdKbd3i6nr5DZeZdJ8OvQR4QNOGKb8Y7ZX/A/bsuhyCq
	 3Jwd5J6pdG6DQ==
Date: Thu, 12 Sep 2024 12:00:52 -0500
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
	Saravana Kannan <saravanak@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 1/8] misc: Add support for LAN966x PCI device
Message-ID: <20240912170052.GA677163@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808154658.247873-2-herve.codina@bootlin.com>

On Thu, Aug 08, 2024 at 05:46:50PM +0200, Herve Codina wrote:
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
> ---
>  drivers/misc/Kconfig          |  24 ++++
>  drivers/misc/Makefile         |   3 +
>  drivers/misc/lan966x_pci.c    | 215 ++++++++++++++++++++++++++++++++++
>  drivers/misc/lan966x_pci.dtso | 167 ++++++++++++++++++++++++++
>  drivers/pci/quirks.c          |   1 +

Acked-by: Bjorn Helgaas <bhelgaas@google.com> # drivers/pci/quirks.c

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index a2ce4e08edf5..bae2dd99017c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6245,6 +6245,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa76e, dpc_log_size);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, of_pci_make_dev_node);
>  
>  /*
>   * Devices known to require a longer delay before first config space access
> -- 
> 2.45.0
> 

