Return-Path: <linux-pci+bounces-38565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B450ABEC9D7
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 10:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 679734E313E
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 08:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C35287511;
	Sat, 18 Oct 2025 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="KVOUzmFL"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7654323BD1A;
	Sat, 18 Oct 2025 08:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760775734; cv=none; b=eCxJb+2QcAp54dMO+aN7wYKxNOax3xUywzZT1UWxc1y/dXUmi7xpS8QlFS8FTT5GdTxlbDhZQbx0iyYKxsQWAhoN7lixqAmGjDPh+qbuAqCHZ7Wm/PfgVAdeZYIV0/C9hFfGp7lKpNoAbTb4AnO9ouEiaWP4Fkpitq6VkPuj4tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760775734; c=relaxed/simple;
	bh=zlh7pE36P5hDs/RResT8p3nlvHibYI5JBcrutF56fek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6xuZgLTNvFGai87sMKfDzEeE7S4pmwZHM52xLQGOKMMqonpFPHgy1zzqnGTi5JU1cg1UkZMMjiL4x3lxvNLm6V/yGelxFxM+c1p/tdiIhCLvrq7ygAw+gdE1r7v16XIFmztFLeL6Q3xHjnOYtCocdDZignLs/FfDAR1vNd114M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=KVOUzmFL; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 01C542645D;
	Sat, 18 Oct 2025 10:22:11 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q5c0JjZb2sYr; Sat, 18 Oct 2025 10:22:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1760775730; bh=zlh7pE36P5hDs/RResT8p3nlvHibYI5JBcrutF56fek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KVOUzmFLsU+/r3KIWEuOWlm81vHg39jW+Fv9ar0/s38qFbK6xJGkUSQw9Oy+sfGQX
	 1N5HzoeenKEWJuf4wUAJlqi1W6mb0iLXJ/c8Tth8FPEnr6qJZayCmx18FdsKyF88T0
	 nLTlhTNpRgy04dOJgUC66ATKgTYlsema30bzgBWhLiRwUgL1uCRPrtLQTkK4f/XS4c
	 oAqzqYQHNfkgHeOWvQ/c6K4JFhqCvJVI05pxxt4BkIn5TrNBMt5vIgXR5JYNV7Hb9l
	 AtIFlnTOGR/Vlnht9KpCngOEKbCArU3AtCGY2lHXUfYausleWljZzH/WAFtzLZtKGY
	 jriT8yFXu386Q==
Date: Sat, 18 Oct 2025 08:21:58 +0000
From: Yao Zi <ziyao@disroot.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: stmmac: Add glue driver for Motorcomm
 YT6801 ethernet controller
Message-ID: <aPNOJs9ogd9GLZLg@pie>
References: <20251014164746.50696-2-ziyao@disroot.org>
 <20251014164746.50696-5-ziyao@disroot.org>
 <f1de6600-4de9-4914-95e6-8cdb3481e364@lunn.ch>
 <aPJMsNKwBYyrr-W-@pie>
 <81124574-48ab-4297-9a74-bba7df68b973@lunn.ch>
 <aPJa4u2OWhVGs58k@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPJa4u2OWhVGs58k@shell.armlinux.org.uk>

On Fri, Oct 17, 2025 at 04:04:02PM +0100, Russell King (Oracle) wrote:
> On Fri, Oct 17, 2025 at 04:56:23PM +0200, Andrew Lunn wrote:
> > > Though it's still unclear the exact effect of the bit on the PHY since
> > > there's no public documentation, it's essential to deassert it in MAC
> > > code before registering and scanning the MDIO bus, or we could even not
> > > probe the PHY correctly.
> > > 
> > > For the motorcomm_reset_phy() performed in probe function, it happens
> > > before the registration of MDIO bus, and the PHY isn't probed yet, thus
> > > I think it should be okay.
> > 
> > Since it resets more than the PHY, it probably should have a different
> > name, and maybe a comment describing what is actually resets.
> 
> I want to back Andrew's comment here up very strongly.
> 
> You will not be the only one looking at this code. There are other
> people (e.g. me) who are looking at e.g. the core stmmac code, making
> changes to it, which impact the platform glue as well.
> 
> The platform glue needs to be understandable to those of us who don't
> have knowledge of your platform, so that we can make sense of it and
> know what it's actually doing, and thus be able to adapt it when we
> push out changes to the core that affect platform glue.

Thanks, that's a really reasonable point to me. At the time of writing
these register offsets, their exact effects are still unclear to me and
I just copied their names from the vendor driver.

Will comment about the effects of EPHY_RESET and give the offset a more
self-descriptive name (maybe MDIO_PHY_RESET) in v2.

> Sadly, it seems 99.9% of platform glue is "dump it into the kernel
> and run away".
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

Best regards,
Yao Zi

