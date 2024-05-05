Return-Path: <linux-pci+bounces-7100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB558BC28B
	for <lists+linux-pci@lfdr.de>; Sun,  5 May 2024 18:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3FD1C208E0
	for <lists+linux-pci@lfdr.de>; Sun,  5 May 2024 16:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BD91EF1D;
	Sun,  5 May 2024 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RwxA+vx/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076B31E507;
	Sun,  5 May 2024 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714927167; cv=none; b=RL1pfqjsdUJTvtYCMc1JaGBCcEwjjeQ0hSwCpRhlonmIIwVN9o3NV/v23pHb0/BMGIx8za7QDbjq9oeFl0TZbEElQy1gpubtJ/bQTSfggmQ45BWSWzPAcnJ44L2DMowzLUI0f0smH+2C/1wbKpmf9LAgYlbotdch1HzEIQMN1TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714927167; c=relaxed/simple;
	bh=kfKXHsxZpF+ohAZMyTjXIDnhZqSbZn+bac6cfKTHkgg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g3dxzB8wnECAX03Z+aogcH/SYNm1zxrafBbv9cH9TP44g3SHaUeMoCgpW+W0zxK5BSMh6tjT76PgFH7AfNX/CQ39OKvFYsir2/k6oEup7duYxbzqhxOKuzmFRHcbcofZ2NLPDQwaeploT04I3JqDDfY7DOrxuR93S0JW6JyA+i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RwxA+vx/; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id ABE35C2DCA;
	Sun,  5 May 2024 16:38:49 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 822D71BF207;
	Sun,  5 May 2024 16:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714927122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4oR805m/O43MhiiUQYpyBvILz6b9mCgwbwDtZtP5xc=;
	b=RwxA+vx/Ap0JKSoDtcYRQg8T8QW3rjO+LAXTvOTaEUyIJNyTbuRMjUV+e/G1oP3Ib1VbJd
	SC/wz1ERcUIelc+VHFI+izQDvdElNrdLR0XJxrbJR76CUV8/DQq5ag+iZ46fd/ruO5qeQ4
	noJo4VCh8V0crYcp7dbNgu59HM9kabEMTFn00xyG4X2scMqFoPpnC9xTsbP8ZXfRw2CIzX
	QHg1RGB55bw7stR1omuc41CUTrMLGdIUp214h6fElup5GXNfR6PfvZugHMbwukHFc7DYgk
	50VIrsd8JVI5gh4gLJ5vJ1ljlMW1uuCYaON74uG22jE8LKpz/MWLk4ojVznIcg==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo
 Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Andrew Lunn
 <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 03/10] ARM: orion5x: Pass devfn to
 orion5x_pci_hw_{rd,wr}_conf()
In-Reply-To: <20240429104633.11060-4-ilpo.jarvinen@linux.intel.com>
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
 <20240429104633.11060-4-ilpo.jarvinen@linux.intel.com>
Date: Sun, 05 May 2024 18:38:40 +0200
Message-ID: <87plu0nrhr.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gregory.clement@bootlin.com

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> writes:

> Pass the usual devfn instead of individual components into
> orion5x_pci_hw_{rd,wr}_conf() to make the change into
> pci_conf1_offset() in an upcoming commit easier.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>


Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

As some other patches of the series depend on patches in the PCIe
subsystem, the best approach would be to let you apply the series
through the PCIe subsystem.

Thanks,

Gregory


> ---
>  arch/arm/mach-orion5x/pci.c | 45 +++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
> index 77ddab90f448..6376e1db6386 100644
> --- a/arch/arm/mach-orion5x/pci.c
> +++ b/arch/arm/mach-orion5x/pci.c
> @@ -270,15 +270,15 @@ static int orion5x_pci_local_bus_nr(void)
>  	return((conf & PCI_P2P_BUS_MASK) >> PCI_P2P_BUS_OFFS);
>  }
>=20=20
> -static int orion5x_pci_hw_rd_conf(int bus, int dev, u32 func,
> -					u32 where, u32 size, u32 *val)
> +static int orion5x_pci_hw_rd_conf(int bus, u8 devfn, u32 where,
> +				  u32 size, u32 *val)
>  {
>  	unsigned long flags;
>  	spin_lock_irqsave(&orion5x_pci_lock, flags);
>=20=20
>  	writel(PCI_CONF_BUS(bus) |
> -		PCI_CONF_DEV(dev) | ORION5X_PCI_CONF_REG(where) |
> -		ORION5X_PCI_CONF_FUNC(func) | PCI_CONF_ADDR_EN, PCI_CONF_ADDR);
> +		PCI_CONF_DEV(PCI_SLOT(devfn)) | ORION5X_PCI_CONF_REG(where) |
> +		ORION5X_PCI_CONF_FUNC(PCI_FUNC(devfn)) | PCI_CONF_ADDR_EN, PCI_CONF_AD=
DR);
>=20=20
>  	*val =3D readl(PCI_CONF_DATA);
>=20=20
> @@ -292,8 +292,8 @@ static int orion5x_pci_hw_rd_conf(int bus, int dev, u=
32 func,
>  	return PCIBIOS_SUCCESSFUL;
>  }
>=20=20
> -static int orion5x_pci_hw_wr_conf(int bus, int dev, u32 func,
> -					u32 where, u32 size, u32 val)
> +static int orion5x_pci_hw_wr_conf(int bus, u8 devfn, u32 where,
> +				  u32 size, u32 val)
>  {
>  	unsigned long flags;
>  	int ret =3D PCIBIOS_SUCCESSFUL;
> @@ -301,8 +301,8 @@ static int orion5x_pci_hw_wr_conf(int bus, int dev, u=
32 func,
>  	spin_lock_irqsave(&orion5x_pci_lock, flags);
>=20=20
>  	writel(PCI_CONF_BUS(bus) |
> -		PCI_CONF_DEV(dev) | ORION5X_PCI_CONF_REG(where) |
> -		ORION5X_PCI_CONF_FUNC(func) | PCI_CONF_ADDR_EN, PCI_CONF_ADDR);
> +		PCI_CONF_DEV(PCI_SLOT(devfn)) | ORION5X_PCI_CONF_REG(where) |
> +		ORION5X_PCI_CONF_FUNC(PCI_FUNC(devfn)) | PCI_CONF_ADDR_EN, PCI_CONF_AD=
DR);
>=20=20
>  	if (size =3D=3D 4) {
>  		__raw_writel(val, PCI_CONF_DATA);
> @@ -347,8 +347,7 @@ static int orion5x_pci_rd_conf(struct pci_bus *bus, u=
32 devfn,
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>=20=20
> -	return orion5x_pci_hw_rd_conf(bus->number, PCI_SLOT(devfn),
> -					PCI_FUNC(devfn), where, size, val);
> +	return orion5x_pci_hw_rd_conf(bus->number, devfn, where, size, val);
>  }
>=20=20
>  static int orion5x_pci_wr_conf(struct pci_bus *bus, u32 devfn,
> @@ -357,8 +356,7 @@ static int orion5x_pci_wr_conf(struct pci_bus *bus, u=
32 devfn,
>  	if (!orion5x_pci_valid_config(bus->number, devfn))
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>=20=20
> -	return orion5x_pci_hw_wr_conf(bus->number, PCI_SLOT(devfn),
> -					PCI_FUNC(devfn), where, size, val);
> +	return orion5x_pci_hw_wr_conf(bus->number, devfn, where, size, val);
>  }
>=20=20
>  static struct pci_ops pci_ops =3D {
> @@ -375,12 +373,14 @@ static void __init orion5x_pci_set_bus_nr(int nr)
>  		 * PCI-X mode
>  		 */
>  		u32 pcix_status, bus, dev;
> +		u8 devfn;
>  		bus =3D (p2p & PCI_P2P_BUS_MASK) >> PCI_P2P_BUS_OFFS;
>  		dev =3D (p2p & PCI_P2P_DEV_MASK) >> PCI_P2P_DEV_OFFS;
> -		orion5x_pci_hw_rd_conf(bus, dev, 0, PCIX_STAT, 4, &pcix_status);
> +		devfn =3D PCI_DEVFN(dev, 0);
> +		orion5x_pci_hw_rd_conf(bus, devfn, PCIX_STAT, 4, &pcix_status);
>  		pcix_status &=3D ~PCIX_STAT_BUS_MASK;
>  		pcix_status |=3D (nr << PCIX_STAT_BUS_OFFS);
> -		orion5x_pci_hw_wr_conf(bus, dev, 0, PCIX_STAT, 4, pcix_status);
> +		orion5x_pci_hw_wr_conf(bus, devfn, PCIX_STAT, 4, pcix_status);
>  	} else {
>  		/*
>  		 * PCI Conventional mode
> @@ -393,15 +393,16 @@ static void __init orion5x_pci_set_bus_nr(int nr)
>=20=20
>  static void __init orion5x_pci_master_slave_enable(void)
>  {
> -	int bus_nr, func, reg;
> +	int bus_nr, reg;
> +	u8 devfn;
>  	u32 val;
>=20=20
>  	bus_nr =3D orion5x_pci_local_bus_nr();
> -	func =3D PCI_CONF_FUNC_STAT_CMD;
> +	devfn =3D PCI_DEVFN(0, PCI_CONF_FUNC_STAT_CMD);
>  	reg =3D PCI_CONF_REG_STAT_CMD;
> -	orion5x_pci_hw_rd_conf(bus_nr, 0, func, reg, 4, &val);
> +	orion5x_pci_hw_rd_conf(bus_nr, devfn, reg, 4, &val);
>  	val |=3D (PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
> -	orion5x_pci_hw_wr_conf(bus_nr, 0, func, reg, 4, val | 0x7);
> +	orion5x_pci_hw_wr_conf(bus_nr, devfn, reg, 4, val | 0x7);
>  }
>=20=20
>  static void __init orion5x_setup_pci_wins(void)
> @@ -424,7 +425,7 @@ static void __init orion5x_setup_pci_wins(void)
>=20=20
>  	for (i =3D 0; i < dram->num_cs; i++) {
>  		const struct mbus_dram_window *cs =3D dram->cs + i;
> -		u32 func =3D PCI_CONF_FUNC_BAR_CS(cs->cs_index);
> +		u8 devfn =3D PCI_DEVFN(0, PCI_CONF_FUNC_BAR_CS(cs->cs_index));
>  		u32 reg;
>  		u32 val;
>=20=20
> @@ -432,15 +433,15 @@ static void __init orion5x_setup_pci_wins(void)
>  		 * Write DRAM bank base address register.
>  		 */
>  		reg =3D PCI_CONF_REG_BAR_LO_CS(cs->cs_index);
> -		orion5x_pci_hw_rd_conf(bus, 0, func, reg, 4, &val);
> +		orion5x_pci_hw_rd_conf(bus, devfn, reg, 4, &val);
>  		val =3D (cs->base & 0xfffff000) | (val & 0xfff);
> -		orion5x_pci_hw_wr_conf(bus, 0, func, reg, 4, val);
> +		orion5x_pci_hw_wr_conf(bus, devfn, reg, 4, val);
>=20=20
>  		/*
>  		 * Write DRAM bank size register.
>  		 */
>  		reg =3D PCI_CONF_REG_BAR_HI_CS(cs->cs_index);
> -		orion5x_pci_hw_wr_conf(bus, 0, func, reg, 4, 0);
> +		orion5x_pci_hw_wr_conf(bus, devfn, reg, 4, 0);
>  		writel((cs->size - 1) & 0xfffff000,
>  			PCI_BAR_SIZE_DDR_CS(cs->cs_index));
>  		writel(cs->base & 0xfffff000,
> --=20
> 2.39.2

