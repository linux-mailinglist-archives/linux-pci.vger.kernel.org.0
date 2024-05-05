Return-Path: <linux-pci+bounces-7098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CA58BC287
	for <lists+linux-pci@lfdr.de>; Sun,  5 May 2024 18:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDDB281043
	for <lists+linux-pci@lfdr.de>; Sun,  5 May 2024 16:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50B01E507;
	Sun,  5 May 2024 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LAXSVRlI"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8D01DFED;
	Sun,  5 May 2024 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714927107; cv=none; b=ievTbJCFLjAuaORt1Swjb16fjY0ijP5RH30xzPinVAyHz7KHcfjXZqWBKcVJIkfUQN9xlyk+Fhm9aRIjJtZR5PElVPTq7LphvKXQoy/4niMk5CoBXjO0nQNBZjRfsU+xupXlasw1+aJhOCpfTLB077x4kpdIAe5yXgxoBxXeNHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714927107; c=relaxed/simple;
	bh=+xOR+0GX3YwzMPsUnWygOmvVOIUlJnwfc2+rsVX2hA0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZpqmndoQvhnyjlr0eKO3cU985mTowPRa1bN1F+Hf8gLE7ET/yDDXAQ4fE6NLL2NtNzrPMuU8dTQvOqRgMbMYWO2RpbsTDMW+tc7Ke3wXaBFncjTl0i/klZlZLXb1tyfIHvAhYSF+wS9dRieJswotq49OZyeeUnIHbHePlhjSvs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LAXSVRlI; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E201140008;
	Sun,  5 May 2024 16:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714927097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2cdjuqsEJ8kja5JmwM2ue6CnHi+bPlWRpdtthK0+QAg=;
	b=LAXSVRlI687CHT8QKZZk4hTxF16H22fVxnJiIPsw6aCuyzcepB0P3HiHrYD1l3wBirJ1qj
	Hw+7TV4hdMbEFcPZH3pYJcCjBypUTsOc1sncS/2ONlyWmskDEjNdxhIrts7orgIbW4/zrz
	ze637xqW7iKbBoe2r1yeNc0HsmKRJO18ojL/H0dX2gt9vKAJx1A7LzrwoiN8va/5Ar4ypv
	PUD6dtmYgaObb3E5THHBdsTIoJo22mK1G5ZeQYnGeeYTIuFcT+/n+o16hC2hYs+OdSEn1W
	ifWLrtU782tSLX+qMChxRNaQ1ClbGaBlanonLV4UH0mH56yeRjC84n7yAmvbkw==
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
Subject: Re: [PATCH 01/10] ARM: orion5x: Rename PCI_CONF_{REG,FUNC}() out of
 the way
In-Reply-To: <20240429104633.11060-2-ilpo.jarvinen@linux.intel.com>
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
 <20240429104633.11060-2-ilpo.jarvinen@linux.intel.com>
Date: Sun, 05 May 2024 18:38:14 +0200
Message-ID: <87seywnrih.fsf@BLaptop.bootlin.com>
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

> orion5x defines PCI_CONF_REG() and PCI_CONF_FUNC() that are problematic
> because PCI core is going to introduce defines with the same names.
>
> Add ORION5X prefix to those defines to avoid name conflicts.
>
> Note: as this is part of series that replaces the code in question
> anyway, only bare minimum renaming is done and other similarly named
> macros are not touched.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

As some other patches of the series depend on patches in the PCIe
subsystem, the best approach would be to let you apply the series
through the PCIe subsystem.

Thanks,

Gregory
> ---
>  arch/arm/mach-orion5x/pci.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
> index 3313bc5a63ea..77ddab90f448 100644
> --- a/arch/arm/mach-orion5x/pci.c
> +++ b/arch/arm/mach-orion5x/pci.c
> @@ -219,8 +219,8 @@ static int __init pcie_setup(struct pci_sys_data *sys)
>  /*
>   * PCI_CONF_ADDR bits
>   */
> -#define PCI_CONF_REG(reg)		((reg) & 0xfc)
> -#define PCI_CONF_FUNC(func)		(((func) & 0x3) << 8)
> +#define ORION5X_PCI_CONF_REG(reg)	((reg) & 0xfc)
> +#define ORION5X_PCI_CONF_FUNC(func)	(((func) & 0x3) << 8)
>  #define PCI_CONF_DEV(dev)		(((dev) & 0x1f) << 11)
>  #define PCI_CONF_BUS(bus)		(((bus) & 0xff) << 16)
>  #define PCI_CONF_ADDR_EN		(1 << 31)
> @@ -277,8 +277,8 @@ static int orion5x_pci_hw_rd_conf(int bus, int dev, u=
32 func,
>  	spin_lock_irqsave(&orion5x_pci_lock, flags);
>=20=20
>  	writel(PCI_CONF_BUS(bus) |
> -		PCI_CONF_DEV(dev) | PCI_CONF_REG(where) |
> -		PCI_CONF_FUNC(func) | PCI_CONF_ADDR_EN, PCI_CONF_ADDR);
> +		PCI_CONF_DEV(dev) | ORION5X_PCI_CONF_REG(where) |
> +		ORION5X_PCI_CONF_FUNC(func) | PCI_CONF_ADDR_EN, PCI_CONF_ADDR);
>=20=20
>  	*val =3D readl(PCI_CONF_DATA);
>=20=20
> @@ -301,8 +301,8 @@ static int orion5x_pci_hw_wr_conf(int bus, int dev, u=
32 func,
>  	spin_lock_irqsave(&orion5x_pci_lock, flags);
>=20=20
>  	writel(PCI_CONF_BUS(bus) |
> -		PCI_CONF_DEV(dev) | PCI_CONF_REG(where) |
> -		PCI_CONF_FUNC(func) | PCI_CONF_ADDR_EN, PCI_CONF_ADDR);
> +		PCI_CONF_DEV(dev) | ORION5X_PCI_CONF_REG(where) |
> +		ORION5X_PCI_CONF_FUNC(func) | PCI_CONF_ADDR_EN, PCI_CONF_ADDR);
>=20=20
>  	if (size =3D=3D 4) {
>  		__raw_writel(val, PCI_CONF_DATA);
> --=20
> 2.39.2

