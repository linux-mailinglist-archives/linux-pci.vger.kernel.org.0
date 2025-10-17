Return-Path: <linux-pci+bounces-38484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A7EBE95F9
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 16:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88AB4258E3
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 14:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A09433711A;
	Fri, 17 Oct 2025 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NN54Td8G"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869AB337117;
	Fri, 17 Oct 2025 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713007; cv=none; b=fGcgdOdn27gwnEay6ua6vPsCkauRYqKWBLc98GLnn/AqlPSaXJ/Ql0ne+JmQ2YATmKAaFipWIwZNkQdgaIZARtJeUwWkK2DayTAXhUb31qqBiSsOR8zpDR7rtKTnWkZ5WrK91g0N9/ViQp9eVUSEi2VzQTmNYIJh44nyouTWFzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713007; c=relaxed/simple;
	bh=mK9ZbonMbWsp633o910gNhAdgygON/96T9uAKGz/UkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZ5P374PxPtrSZWOqCDs2zd2tm3AgquNX3yA6gBljydT6Y/LGTY1A7jDWpD3cqzQ9movlgyIke2YDBa4RqHwxpIKSJKMoS1q9m5VjknLtNCmfsMj6cZShGH1/I+DdDsxkrB8/aOi+la42lIggrO2GNqed5K2/L8lFsBMMbVu8nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NN54Td8G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0iQ5uE1LF/9zrVlIEvBCEHh+yAwilCOCDNUE/+lsYd4=; b=NN54Td8GpX/6qu3eC9n9KLc0e7
	UdzjNrtf2+m6LjnRy+XewIM6D+E+zI3KKlbsuLEsR9mRmnAP9ZF/9eIMYcar2BfC/SRUWV7KzS51C
	IwvjJOfSkKdAgDjK9UBCnRwkQEc9n/7e1UqLyu8FcIXtYkiDx3JzN2mTU98vMqn8dDl0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v9lsV-00BID6-6i; Fri, 17 Oct 2025 16:56:23 +0200
Date: Fri, 17 Oct 2025 16:56:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yao Zi <ziyao@disroot.org>
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
Message-ID: <81124574-48ab-4297-9a74-bba7df68b973@lunn.ch>
References: <20251014164746.50696-2-ziyao@disroot.org>
 <20251014164746.50696-5-ziyao@disroot.org>
 <f1de6600-4de9-4914-95e6-8cdb3481e364@lunn.ch>
 <aPJMsNKwBYyrr-W-@pie>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPJMsNKwBYyrr-W-@pie>

> > > +static void motorcomm_reset_phy(struct dwmac_motorcomm_priv *priv)
> > > +{
> > > +	u32 reg = readl(priv->base + EPHY_CTRL);
> > > +
> > > +	reg &= ~EPHY_RESET;
> > > +	writel(reg, priv->base + EPHY_CTRL);
> > > +
> > > +	reg |= EPHY_RESET;
> > > +	writel(reg, priv->base + EPHY_CTRL);
> > > +}
> > 
> > How does this differ to the PHY doing its own reset via BMCR?
> 
> It's named as EPHY_RESET according to the vendor driver, but with my
> testing, it seems to reset at least the internal MDIO bus as well: with
> this reset asserted (which is the default state after power on or
> resumption from D3hot), mdiobus_scan() considers each possible MDIO
> address corresponds to a PHY, while no one could be connected
> successfully.
> 
> > We need to be careful of lifetimes here. It would be better if the PHY
> > controlled its own reset. We don't want phylib to configure the PHY
> > and then the MAC driver reset it etc.
> 
> Though it's still unclear the exact effect of the bit on the PHY since
> there's no public documentation, it's essential to deassert it in MAC
> code before registering and scanning the MDIO bus, or we could even not
> probe the PHY correctly.
> 
> For the motorcomm_reset_phy() performed in probe function, it happens
> before the registration of MDIO bus, and the PHY isn't probed yet, thus
> I think it should be okay.

Since it resets more than the PHY, it probably should have a different
name, and maybe a comment describing what is actually resets.

And maybe rather than asserting and then deasserting reset, maybe just
deassert the reset? That makes it less dangerous in terms of
lifetimes.

> > > +static int motorcomm_resume(struct device *dev, void *bsp_priv)
> > > +{
> > > +	struct dwmac_motorcomm_priv *priv = bsp_priv;
> > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > +	int ret;
> > > +
> > > +	pci_restore_state(pdev);
> > > +	pci_set_power_state(pdev, PCI_D0);
> > > +
> > > +	ret = pcim_enable_device(pdev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	pci_set_master(pdev);
> > > +
> > > +	motorcomm_reset_phy(priv);
> > 
> > Does the PHY support WoL? You probably should not be touching it if it
> > can wake the system.
> 
> Yes, it supports WoL, though the functionality isn't implemented in this
> series.
>
> As I mentioned before, it's necesasry to at least deassert EPHY_RESET
> after resuming from D3hot state, or phy_check_link_status() will always
> fail with -EBUSY for the PHY and it cannot be correctly resumed.

When WoL is implemented, what state will the MAC and the PHY be in? Is
it possible to put the MAC into a deeper suspend state than the PHY,
since the MAC is probably not needed? The PHY obviously needs to keep
working, so it cannot be put into a reset state. So resume should not
need to take it out of reset. Also, i _think_ the phylib core will
assume a PHY used for WoL is kept alive and configured, so it will not
reconfigure it on resume.

So it seems like this code will need some changes when WoL is
implemented. So leave it as is for the moment.

> > Is this required? If you look at other glue drivers which allocate
> > such a structure, they set members in it:
> > 
> > dwmac-intel.c:	plat->mdio_bus_data->needs_reset = true;
> > dwmac-loongson.c:		plat->mdio_bus_data->needs_reset = true;
> > dwmac-tegra.c:	plat->mdio_bus_data->needs_reset = true;
> > stmmac_pci.c:	plat->mdio_bus_data->needs_reset = true;
> > stmmac_platform.c:		plat->mdio_bus_data->needs_reset = true;
> > 
> > You don't set anything.
> 
> Yes, it's required, since stmmac_mdio.c won't register a MDIO bus if
> plat_stmmacenet_data.mdio_bus_data is NULL.

Why? Maybe zoom out, look at the big picture for this driver, and
figure out if that is the correct behaviour for stmmac_mdio to
implement. Is it possible to synthesizer this IP without MDIO?

I was also wondering about all the other parameters you set. Why have
i not seen any other glue driver with similar code? What makes this
glue driver different?

	   Andrew

