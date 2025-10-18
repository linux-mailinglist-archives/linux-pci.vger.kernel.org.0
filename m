Return-Path: <linux-pci+bounces-38564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AA1BEC9C7
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 10:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465AC625BBE
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 08:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C100F248891;
	Sat, 18 Oct 2025 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="N8fOkXt/"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1B723EA8A;
	Sat, 18 Oct 2025 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760775406; cv=none; b=MdZA0j3X8nq44M9tePb9twRnWjiRfy9+zHdNbbp60J2DT0xGw27ST4XIELSPEYHQr6v2RwpcVzC3JH0v60x3N1YKincPNANz0Rjc5ys+P5fr7hbmhibDHf/9oUy7qnSfnDwZEH94aMy/25MnkiKzjKGDHTJ7v3+iXwlgkDtL8Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760775406; c=relaxed/simple;
	bh=EQ6AUTFBznxRaDva/ec65uweQZOgsX7ncqbOh2GxYhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2jJlsdzqgU0PyeBcfHm29cRflMUptFTseknOgzvxAuCFaCs0c8MulbSF//VTQHYzL3AamyfCFuyYiZFqvNOWeyfJvUxl4xzFlWLpO2Gq2CoamVYpYUR5kIFsqJKdxwwuEBQQeAvcvVhdOwnLyCBwzVQN9AiVDz23OEY1wPsaFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=N8fOkXt/; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A9D9025E08;
	Sat, 18 Oct 2025 10:16:40 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id flIiLKxwqYeY; Sat, 18 Oct 2025 10:16:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1760775399; bh=EQ6AUTFBznxRaDva/ec65uweQZOgsX7ncqbOh2GxYhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N8fOkXt/r412ShWMUDG7u5JbyYznuNyKedG0VyLlq0hTYcbmg8Mr2TWjo7juWJ+J8
	 SVSvAtoNypJKvrHFlTG9WREXe2mIkWGGT7xxBn+rfcmFFX+Xz42dg5dR2iBtkOsGeB
	 vdlBpTqm1kzZLjSp8eMVFdkWRezg3Y4yibtXYgpxEwulDL87lMkQnSVmU8aZsKiJfM
	 WqODy4DcOyR+tV9zdSq+Jlk9rXVXTcnQLzMr5dLhN1pIfHO0L09cXIYg1xyonjOEG+
	 Mb+b0vo2X+D57GlK5CJTs9dO4uQNmVw/PkP5LsVQ2p6RPyFG6++3HEuy8JKmMq4dGC
	 3T+YO8IBhPOYQ==
Date: Sat, 18 Oct 2025 08:16:22 +0000
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
Message-ID: <aPNM1jeKfMPNsO4N@pie>
References: <20251014164746.50696-2-ziyao@disroot.org>
 <20251014164746.50696-5-ziyao@disroot.org>
 <f1de6600-4de9-4914-95e6-8cdb3481e364@lunn.ch>
 <aPJMsNKwBYyrr-W-@pie>
 <81124574-48ab-4297-9a74-bba7df68b973@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81124574-48ab-4297-9a74-bba7df68b973@lunn.ch>

On Fri, Oct 17, 2025 at 04:56:23PM +0200, Andrew Lunn wrote:
> > > > +static void motorcomm_reset_phy(struct dwmac_motorcomm_priv *priv)
> > > > +{
> > > > +	u32 reg = readl(priv->base + EPHY_CTRL);
> > > > +
> > > > +	reg &= ~EPHY_RESET;
> > > > +	writel(reg, priv->base + EPHY_CTRL);
> > > > +
> > > > +	reg |= EPHY_RESET;
> > > > +	writel(reg, priv->base + EPHY_CTRL);
> > > > +}
> > > 
> > > How does this differ to the PHY doing its own reset via BMCR?
> > 
> > It's named as EPHY_RESET according to the vendor driver, but with my
> > testing, it seems to reset at least the internal MDIO bus as well: with
> > this reset asserted (which is the default state after power on or
> > resumption from D3hot), mdiobus_scan() considers each possible MDIO
> > address corresponds to a PHY, while no one could be connected
> > successfully.
> > 
> > > We need to be careful of lifetimes here. It would be better if the PHY
> > > controlled its own reset. We don't want phylib to configure the PHY
> > > and then the MAC driver reset it etc.
> > 
> > Though it's still unclear the exact effect of the bit on the PHY since
> > there's no public documentation, it's essential to deassert it in MAC
> > code before registering and scanning the MDIO bus, or we could even not
> > probe the PHY correctly.
> > 
> > For the motorcomm_reset_phy() performed in probe function, it happens
> > before the registration of MDIO bus, and the PHY isn't probed yet, thus
> > I think it should be okay.
> 
> Since it resets more than the PHY, it probably should have a different
> name, and maybe a comment describing what is actually resets.

Okay, it's reasonable and I'll do in v2.

> And maybe rather than asserting and then deasserting reset, maybe just
> deassert the reset? That makes it less dangerous in terms of
> lifetimes.

It's okay to only deassert the bit before MDIO bus scan and after
resuming from D3hot, and I'll change to so it in v2.

> > > > +static int motorcomm_resume(struct device *dev, void *bsp_priv)
> > > > +{
> > > > +	struct dwmac_motorcomm_priv *priv = bsp_priv;
> > > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > > +	int ret;
> > > > +
> > > > +	pci_restore_state(pdev);
> > > > +	pci_set_power_state(pdev, PCI_D0);
> > > > +
> > > > +	ret = pcim_enable_device(pdev);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	pci_set_master(pdev);
> > > > +
> > > > +	motorcomm_reset_phy(priv);
> > > 
> > > Does the PHY support WoL? You probably should not be touching it if it
> > > can wake the system.
> > 
> > Yes, it supports WoL, though the functionality isn't implemented in this
> > series.
> >
> > As I mentioned before, it's necesasry to at least deassert EPHY_RESET
> > after resuming from D3hot state, or phy_check_link_status() will always
> > fail with -EBUSY for the PHY and it cannot be correctly resumed.
> 
> When WoL is implemented, what state will the MAC and the PHY be in? Is
> it possible to put the MAC into a deeper suspend state than the PHY,
> since the MAC is probably not needed?

Honestly saying, I don't have an accurate answer. Vendor driver's WoL
functionality doesn't work for me, thus I don't have the environment to
test the hardware behavior.

The vendor driver requires both the PHY and MAC to be online for WoL,
and configures the remote wake-up packet filter integrated in MAC. The
standalone YT8531S PHY does have a dedeciated interrupt line and could
be configured to detect magic packets as well, but I'm not sure whether
interrupt of the one integrated in YT6801 is correctly routed.

> The PHY obviously needs to keep
> working, so it cannot be put into a reset state. So resume should not
> need to take it out of reset. Also, i _think_ the phylib core will
> assume a PHY used for WoL is kept alive and configured, so it will not
> reconfigure it on resume.

Agree, and the WoL scheme implemented in vendor driver does require the
PHY to keep working during suspension. A possible explanation for the
automatically-asserted reset is that it's asserted when the controller
is brought out of suspended D3hot state, but not when entering it, so
the PHY just keeps working until the system is resumed. Still I don't
have a working WoL environment to confirm the guess.

> So it seems like this code will need some changes when WoL is
> implemented. So leave it as is for the moment.

Thanks, I could work on WoL support later when I have more time to dig
the controller further.

> > > Is this required? If you look at other glue drivers which allocate
> > > such a structure, they set members in it:
> > > 
> > > dwmac-intel.c:	plat->mdio_bus_data->needs_reset = true;
> > > dwmac-loongson.c:		plat->mdio_bus_data->needs_reset = true;
> > > dwmac-tegra.c:	plat->mdio_bus_data->needs_reset = true;
> > > stmmac_pci.c:	plat->mdio_bus_data->needs_reset = true;
> > > stmmac_platform.c:		plat->mdio_bus_data->needs_reset = true;
> > > 
> > > You don't set anything.
> > 
> > Yes, it's required, since stmmac_mdio.c won't register a MDIO bus if
> > plat_stmmacenet_data.mdio_bus_data is NULL.
> 
> Why? Maybe zoom out, look at the big picture for this driver, and
> figure out if that is the correct behaviour for stmmac_mdio to
> implement. Is it possible to synthesizer this IP without MDIO?

Yes, I think it should be possible, as described in the datasheet of
DesignWare Ethernet Quality-of-Service Controller IP[1],

> Optional MDIO (Clause 22 and Clause 45) master interface for PHY
> device configuration and management

The MDIO interface is described as "optional". I don't have access to
the IP's userbook or code, so couldn't confirm it.

> I was also wondering about all the other parameters you set. Why have
> i not seen any other glue driver with similar code? What makes this
> glue driver different?

Most glue drivers are for SoC-integrated IPs, for which
stmmac_pltfr_probe() helper could be used to retrieve configuration
arguments from devicetree to fill plat_stmmacenet_data. However, YT6801
is a PCIe-based controller, and we couldn't rely on devicetree to carry
these parameters.

You could find similar parameter setup code in stmmac_pltfr_probe(), and
also other glue drivers for PCIe-based controllers, like dwmac-intel.c
(intel_mgbe_common_data) and dwmac-loongson.c (loongson_default_data).

> 	   Andrew

Thanks,
Yao Zi

[1]: https://www.synopsys.com/dw/doc.php/ds/c/dwc_ether_qos.pdf

