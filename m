Return-Path: <linux-pci+bounces-38481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD91BE9178
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 16:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0DFF1883B5F
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 14:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F9B369967;
	Fri, 17 Oct 2025 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="TRPVp80C"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9742F6926;
	Fri, 17 Oct 2025 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760709845; cv=none; b=c+TVwWPITNg07jM1CthpkT83rMcLwckUYSeuWE4N1l/0Vbbi9E50lWasf8B6xpYa+GxD2Aj+9uC5LMAVOJbIk9rfRNpoVVhZSBv38jKoJRPNoRecuOFdxnlrDiZw+lYJuZcJNHIPm2gz/qBssubQbNzmD8aRsQwX8Wl8pVtdwR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760709845; c=relaxed/simple;
	bh=vyAH6K5eo5+Ah1ymnHww5b79QpFLa3f+68MTLxyvqvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DP4mFjxqRkfL/dXUj1yIH9GGNiRDFOhY3bmUzlKw7Ehc9WzTgaAF1UZSCwaGYjcHQxcReQ3jQnCPWTPT1XgEcJpi2yJNsx7sqyA6tf2dI4b+ed6SyzvimON0JIRxaLHXjVil5bFCggt4lWQq5LHghRlfPCrAe7wclqT0EkTMKFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=TRPVp80C; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1053F25C64;
	Fri, 17 Oct 2025 16:03:54 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pucKqm3C4dNh; Fri, 17 Oct 2025 16:03:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1760709833; bh=vyAH6K5eo5+Ah1ymnHww5b79QpFLa3f+68MTLxyvqvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TRPVp80C/vD9p2PeDYvQlxAn6ZePrKZ46Uvs4YDVLBhHgBi58AJHQB507gHIgzJZv
	 4UzsYeHEbA6NVI/7gxranSqze4y5gY5qulCXhPk21E5ciZovn0wvoP/8F4GrIxfQW0
	 PIeGogJprdbvkCl2xxI9v9cRTE7ftwJ0mYHEaJ31R+Kz1We46FrAGnyarUCntS5LJk
	 ci5kB9vyF8ERO3nqcVuVBM3fVTOEm7H6wNbSwide28d8uKn4Sk74WAmVQmjvfsf4Eh
	 KcTyRHzf7RL2j2wHXi76xn8CweVZhxV0Al5y+/EVic81gKQ3al86h7to/NgQ6Tky96
	 ZfqjxrOdGk5KQ==
Date: Fri, 17 Oct 2025 14:03:28 +0000
From: Yao Zi <ziyao@disroot.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: stmmac: Add glue driver for Motorcomm
 YT6801 ethernet controller
Message-ID: <aPJMsNKwBYyrr-W-@pie>
References: <20251014164746.50696-2-ziyao@disroot.org>
 <20251014164746.50696-5-ziyao@disroot.org>
 <f1de6600-4de9-4914-95e6-8cdb3481e364@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1de6600-4de9-4914-95e6-8cdb3481e364@lunn.ch>

On Thu, Oct 16, 2025 at 10:11:02PM +0200, Andrew Lunn wrote:
> > +static int motorcomm_efuse_read_byte(struct dwmac_motorcomm_priv *priv,
> > +				     u8 offset, u8 *byte)
> > +{
> > +	u32 reg;
> > +	int ret;
> > +
> > +	writel(FIELD_PREP(EFUSE_OP_MODE, EFUSE_OP_ROW_READ)	|
> > +	       FIELD_PREP(EFUSE_OP_ADDR, offset)		|
> > +	       EFUSE_OP_START, priv->base + EFUSE_OP_CTRL_0);
> > +
> > +	ret = readl_poll_timeout(priv->base + EFUSE_OP_CTRL_1,
> > +				 reg, reg & EFUSE_OP_DONE, 2000,
> > +				 EFUSE_READ_TIMEOUT_US);
> > +
> > +	reg = readl(priv->base + EFUSE_OP_CTRL_1);
> 
> Do you actually need this read? The documentation says:
> 
>  * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
>  * case, the last read value at @addr is stored in @val.

Oops, the extra call to readl() is indeed unnecessary. Will remove it in
next version.

> > +	*byte = FIELD_GET(EFUSE_OP_RD_DATA, reg);
> > +
> > +	return ret;
> > +}
> 
> > +static void motorcomm_reset_phy(struct dwmac_motorcomm_priv *priv)
> > +{
> > +	u32 reg = readl(priv->base + EPHY_CTRL);
> > +
> > +	reg &= ~EPHY_RESET;
> > +	writel(reg, priv->base + EPHY_CTRL);
> > +
> > +	reg |= EPHY_RESET;
> > +	writel(reg, priv->base + EPHY_CTRL);
> > +}
> 
> How does this differ to the PHY doing its own reset via BMCR?

It's named as EPHY_RESET according to the vendor driver, but with my
testing, it seems to reset at least the internal MDIO bus as well: with
this reset asserted (which is the default state after power on or
resumption from D3hot), mdiobus_scan() considers each possible MDIO
address corresponds to a PHY, while no one could be connected
successfully.

> We need to be careful of lifetimes here. It would be better if the PHY
> controlled its own reset. We don't want phylib to configure the PHY
> and then the MAC driver reset it etc.

Though it's still unclear the exact effect of the bit on the PHY since
there's no public documentation, it's essential to deassert it in MAC
code before registering and scanning the MDIO bus, or we could even not
probe the PHY correctly.

For the motorcomm_reset_phy() performed in probe function, it happens
before the registration of MDIO bus, and the PHY isn't probed yet, thus
I think it should be okay.

> > +static int motorcomm_resume(struct device *dev, void *bsp_priv)
> > +{
> > +	struct dwmac_motorcomm_priv *priv = bsp_priv;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	int ret;
> > +
> > +	pci_restore_state(pdev);
> > +	pci_set_power_state(pdev, PCI_D0);
> > +
> > +	ret = pcim_enable_device(pdev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pci_set_master(pdev);
> > +
> > +	motorcomm_reset_phy(priv);
> 
> Does the PHY support WoL? You probably should not be touching it if it
> can wake the system.

Yes, it supports WoL, though the functionality isn't implemented in this
series.

As I mentioned before, it's necesasry to at least deassert EPHY_RESET
after resuming from D3hot state, or phy_check_link_status() will always
fail with -EBUSY for the PHY and it cannot be correctly resumed.

Do you think it's acceptable to only deassert the EPHY_RESET without
asserting it manually in the resume hook? With this scheme, even though
EPHY_RESET does affect some PHY functionalities, we're not making the
situation worse, since it's already asserted automatically by hardware
after resuming from D3hot.

> > +		return NULL;
> > +
> > +	plat->mdio_bus_data = devm_kzalloc(dev, sizeof(*plat->mdio_bus_data),
> > +					   GFP_KERNEL);
> > +	if (!plat->mdio_bus_data)
> > +		return NULL;
> 
> Is this required? If you look at other glue drivers which allocate
> such a structure, they set members in it:
> 
> dwmac-intel.c:	plat->mdio_bus_data->needs_reset = true;
> dwmac-loongson.c:		plat->mdio_bus_data->needs_reset = true;
> dwmac-tegra.c:	plat->mdio_bus_data->needs_reset = true;
> stmmac_pci.c:	plat->mdio_bus_data->needs_reset = true;
> stmmac_platform.c:		plat->mdio_bus_data->needs_reset = true;
> 
> You don't set anything.

Yes, it's required, since stmmac_mdio.c won't register a MDIO bus if
plat_stmmacenet_data.mdio_bus_data is NULL.

> 
> 	Andrew

Thanks,
Yao Zi

