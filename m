Return-Path: <linux-pci+bounces-8607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FBB9044D4
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 21:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4090B289144
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 19:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CBA7E78B;
	Tue, 11 Jun 2024 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8bCdtln"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2BA3839C;
	Tue, 11 Jun 2024 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718134434; cv=none; b=h8XwiUqmzJpPgCsZSoers4K1vosnquPI+W84e+pZpeK+Q8Gri9HMuCc4XZ64e9JjGdACXtvH8+mOM1fnLAPbQ6fDILq8vgyp/CxkABxfWcMM1Cw+bKHYl9Pu1V0jDjqMjLGzEPN2RqhBgVKI8k7iwl6rwc2wstq4gTjh1J3voFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718134434; c=relaxed/simple;
	bh=+EFgFUSyU77OeDo23wZTQQSJd8WsSmFqgJx2eI4etnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDp5Wvo9UWlABr25f2Hg+8f+uIqPjgirR4Wk2yOD2Bd1AJNi4s13xOt+fj4reRt5SMNj9XD9WOybwlfWyLmSjlb+vG8HayFGfRJZ/qCYscHTyoH838askvz0v3vWDfnn27/qk6O+tp5XzAPoDGIJ6ecwI0SE+PlzHoGPyMhhBlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8bCdtln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2463C2BD10;
	Tue, 11 Jun 2024 19:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718134433;
	bh=+EFgFUSyU77OeDo23wZTQQSJd8WsSmFqgJx2eI4etnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H8bCdtlnV1PKPoYsXCinarlBu4cxYs9DVegPRf+75RuZClFXsTjCljzkiqEnS+wdE
	 3oDTJspMhj0GR3klaRjrKzNfknmP9Dg7qcrptayhAs96i7sF3+2YrmD4Aqz2GLRnpo
	 Jk2Rrfzg6tTeOGm4It/JuxPD5rEKxmo0krCTzbdtrhZeBEVkHyQiDSR25fAEAm0eN0
	 42wgUt1fO6G/dAPpngnPvNb5ZPBiyqnnLVLReciefnJ6jIdiG8gtSYxFrnSGOsHNB2
	 G/NFqeJXuf0PZuayfuxlVqZdJbjcsw2ST5503buhYWQ7ShEfWmijBjhJK3766oFe3j
	 vIh3owb9VJ/5w==
Date: Tue, 11 Jun 2024 13:33:51 -0600
From: Rob Herring <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Simon Horman <horms@kernel.org>,
	Sai Krishna Gajula <saikrishnag@marvell.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 00/19] Add support for the LAN966x PCI device using a
 DT overlay
Message-ID: <20240611193351.GA2953067-robh@kernel.org>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527161450.326615-1-herve.codina@bootlin.com>

On Mon, May 27, 2024 at 06:14:27PM +0200, Herve Codina wrote:
> Hi,
> 
> This series adds support for the LAN966x chip when used as a PCI
> device.
> 
> For reference, the LAN996x chip is a System-on-chip that integrates an
> Ethernet switch and a number of other traditional hardware blocks such
> as a GPIO controller, I2C controllers, SPI controllers, etc. The
> LAN996x can be used in two different modes:
> 
> - With Linux running on its Linux built-in ARM cores.
>   This mode is already supported by the upstream Linux kernel, with the
>   LAN996x described as a standard ARM Device Tree in
>   arch/arm/boot/dts/microchip/lan966x.dtsi. Thanks to this support,
>   all hardware blocks in the LAN996x already have drivers in the
>   upstream Linux kernel.
> 
> - As a PCI device, thanks to its built-in PCI endpoint controller.
>   In this case, the LAN996x ARM cores are not used, but all peripherals
>   of the LAN996x can be accessed by the PCI host using memory-mapped
>   I/O through the PCI BARs.
> 
> This series aims at supporting this second use-case. As all peripherals
> of the LAN996x already have drivers in the Linux kernel, our goal is to
> re-use them as-is to support this second use-case.
> 
> Therefore, this patch series introduces a PCI driver that binds on the
> LAN996x PCI VID/PID, and when probed, instantiates all devices that are
> accessible through the PCI BAR. As the list and characteristics of such
> devices are non-discoverable, this PCI driver loads a Device Tree
> overlay that allows to teach the kernel about which devices are
> available, and allows to probe the relevant drivers in kernel, re-using
> all existing drivers with no change.
> 
> This patch series for now adds a Device Tree overlay that describes an
> initial subset of the devices available over PCI in the LAN996x, and
> follow-up patch series will add support for more once this initial
> support has landed.
> 
> In order to add this PCI driver, a number of preparation changes are
> needed:
> 
>  - Patches 1 to 5 allow the reset driver used for the LAN996x to be
>    built as a module. Indeed, in the case where Linux runs on the ARM
>    cores, it is common to have the reset driver built-in. However, when
>    the LAN996x is used as a PCI device, it makes sense that all its
>    drivers can be loaded as modules.
> 
>  - Patches 6 and 7 improve the MDIO controller driver to properly
>    handle its reset signal.
> 
>  - Patches 8 to 12 introduce the internal interrupt controller used in
>    the LAN996x. It is one of the few peripherals in the LAN996x that
>    are only relevant when the LAN996x is used as a PCI device, which is
>    why this interrupt controller did not have a driver so far.
> 
>  - Patches 13 to 16 make some small additions to the OF core and
>    PCI/OF core to consider the PCI device as an interrupt controller.
>    This topic was previously mentioned in [1] to avoid the need of
>    phandle interrupt parents which are not available at some points.
> 
>  - Patches 17 and 18 introduce the LAN996x PCI driver itself, together
>    with its DT bindings.
> 
> We believe all items from the above list can be merged separately, with
> no build dependencies. We expect:
> 
>  - Patches 1 to 5 to be taken by reset maintainers
> 
>  - Patches 6 and 7 to be taken by network driver maintainers
> 
>  - Patches 8 to 12 to be taken by irqchip maintainers
> 
>  - Patch 13 to 17 to be taken by DT/PCI maintainers

I've applied patches 13-17.

Rob

