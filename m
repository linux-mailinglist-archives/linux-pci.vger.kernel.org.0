Return-Path: <linux-pci+bounces-7099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C7E8BC289
	for <lists+linux-pci@lfdr.de>; Sun,  5 May 2024 18:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45CB281548
	for <lists+linux-pci@lfdr.de>; Sun,  5 May 2024 16:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888AC1EF1D;
	Sun,  5 May 2024 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BLM6gx56"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC11E1E507;
	Sun,  5 May 2024 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714927147; cv=none; b=hGpzdvHKMvi+jBGQtl35zKtKYJRPzA1aDq1Mwbkii9DXK1qGFR/Mo5TMk4SYmGeeFGkTOGKPQgPNdv1MX/LPPI1ZB0MA1BLoqC8N3CusHj+QuYv7JpmE0rp1e6URUAHnJA+dFepJLT6LE+eEkICpJWMKRpzdlyYS/McfT6yOsbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714927147; c=relaxed/simple;
	bh=mGMR3zbRHo7GcNNXrdN7F6LIT0kaOYWv3hS7+obaE1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XKFnQ1ini6Cs+SNpDsCFZtJUmEu+Xq887Q9TZOzPDnuL3xcBkpndLNr/lQeJct/1HkdWMA1DuOu8QnWPEa69kpLacjS7DK6iqdYq2CD6hb40L9H0s11lS96n/eoeL8LK8/FrIyCAQNpOl01+ARqsHTaQOMY6s/Vlal94staWJKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BLM6gx56; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5F375240003;
	Sun,  5 May 2024 16:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714927143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZA0lJB0aUxCAoUAUeihK7wWJnfv9ZZF1p31PdCbAD+0=;
	b=BLM6gx560wnKO+IIUvfRT5Y5t3Jt6rBKIhk0Zf4ssRNgCRT0at1YPUy0TIqyHVxUfvuIjq
	Oiyn+VdtgdyOwWuZrABlpM8RIjTUVEp5D2YYlVr3562FYCLeVM8W3YNkyqx9s2aPh7ReZc
	jiU/4sB8PmFIDshLuGS2NfqywT+d1p+vE8BJ+qSLCN5p2rRm16G4Blk3bUXjc20wkfzcKn
	0Msth0i9K0jnB1RDTUgq51ZyhGQ6JA6cnhcKvQ4yRaoRs36f4+mBNbmTXi7D8ZMoebgAZk
	0AXBsd23AlCJ32zLOpGR/90cQo+0LRT+BOleE829XsXyT0fw9Jh4FHruBb4t7g==
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
Subject: Re: [PATCH 04/10] ARM: orion5x: Use generic PCI Conf Type 1 helper
In-Reply-To: <20240429104633.11060-5-ilpo.jarvinen@linux.intel.com>
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
 <20240429104633.11060-5-ilpo.jarvinen@linux.intel.com>
Date: Sun, 05 May 2024 18:39:00 +0200
Message-ID: <87msp4nrh7.fsf@BLaptop.bootlin.com>
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

> Convert orion5x PCI code to use pci_conf1_ext_addr() from PCI core to
> calculate PCI Configuration Type 1 address.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

As some other patches of the series depend on patches in the PCIe
subsystem, the best approach would be to let you apply the series
through the PCIe subsystem.

Thanks,

Gregory

> ---
>  arch/arm/mach-orion5x/pci.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
> index 6376e1db6386..8b7d67549adf 100644
> --- a/arch/arm/mach-orion5x/pci.c
> +++ b/arch/arm/mach-orion5x/pci.c
> @@ -216,15 +216,6 @@ static int __init pcie_setup(struct pci_sys_data *sy=
s)
>  #define PCI_P2P_DEV_OFFS		24
>  #define PCI_P2P_DEV_MASK		(0x1f << PCI_P2P_DEV_OFFS)
>=20=20
> -/*
> - * PCI_CONF_ADDR bits
> - */
> -#define ORION5X_PCI_CONF_REG(reg)	((reg) & 0xfc)
> -#define ORION5X_PCI_CONF_FUNC(func)	(((func) & 0x3) << 8)
> -#define PCI_CONF_DEV(dev)		(((dev) & 0x1f) << 11)
> -#define PCI_CONF_BUS(bus)		(((bus) & 0xff) << 16)
> -#define PCI_CONF_ADDR_EN		(1 << 31)
> -
>  /*
>   * Internal configuration space
>   */
> @@ -276,9 +267,7 @@ static int orion5x_pci_hw_rd_conf(int bus, u8 devfn, =
u32 where,
>  	unsigned long flags;
>  	spin_lock_irqsave(&orion5x_pci_lock, flags);
>=20=20
> -	writel(PCI_CONF_BUS(bus) |
> -		PCI_CONF_DEV(PCI_SLOT(devfn)) | ORION5X_PCI_CONF_REG(where) |
> -		ORION5X_PCI_CONF_FUNC(PCI_FUNC(devfn)) | PCI_CONF_ADDR_EN, PCI_CONF_AD=
DR);
> +	writel(pci_conf1_addr(bus, devfn, where, true), PCI_CONF_ADDR);
>=20=20
>  	*val =3D readl(PCI_CONF_DATA);
>=20=20
> @@ -300,9 +289,7 @@ static int orion5x_pci_hw_wr_conf(int bus, u8 devfn, =
u32 where,
>=20=20
>  	spin_lock_irqsave(&orion5x_pci_lock, flags);
>=20=20
> -	writel(PCI_CONF_BUS(bus) |
> -		PCI_CONF_DEV(PCI_SLOT(devfn)) | ORION5X_PCI_CONF_REG(where) |
> -		ORION5X_PCI_CONF_FUNC(PCI_FUNC(devfn)) | PCI_CONF_ADDR_EN, PCI_CONF_AD=
DR);
> +	writel(pci_conf1_addr(bus, devfn, where, true), PCI_CONF_ADDR);
>=20=20
>  	if (size =3D=3D 4) {
>  		__raw_writel(val, PCI_CONF_DATA);
> --=20
> 2.39.2

