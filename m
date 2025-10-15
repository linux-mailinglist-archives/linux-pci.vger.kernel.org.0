Return-Path: <linux-pci+bounces-38222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42698BDEC9B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 15:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3085E4E4F6E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 13:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C973F22B8C5;
	Wed, 15 Oct 2025 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="PpEwZzlg"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB0C229B2E;
	Wed, 15 Oct 2025 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760535715; cv=none; b=OW0EA2g1gJFT6suLIpVb/4BZSD1lUuPEv70X9gYXzZZJfmu11nn3lS3btnNiapy2B8Dm4rpGS41LwQO+dae1WioF/m9j8x7Yqld+rEBxab72V7OH17ZcBGn6n5MwPfKOraS2fsxp01fWAc40YOwX+oEKgZu3EjRq96GyhfAoS88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760535715; c=relaxed/simple;
	bh=0+udvwqXk3pMUuV5a3E5/kGYHpUynWhFjTBJiTghSno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5cDAx/lZpoMmApceU9d17RR+Y3oxksDaKKOrXkf61GtXBEGG9FQV8zrTJ225Ph/V6LsvXQ1vBFt93kkQMv6ArvVW91qWHkIyVQswAtiBW/MoDpjvORpbL4FShdQ3MpmQ2NF5aBQbmF3ogDRzwQ4vT//Z/yhZWUKQyqoHbGQalA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=PpEwZzlg; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1448F22F40;
	Wed, 15 Oct 2025 15:41:51 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E3_5OJxubVeS; Wed, 15 Oct 2025 15:41:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1760535710; bh=0+udvwqXk3pMUuV5a3E5/kGYHpUynWhFjTBJiTghSno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PpEwZzlg/BI/Hcu/apLLJ3kweCff9EOMZxnrgY5bOpuzbDqccQExq6wYKeuQofRO+
	 mY7lXrUNGF6VJohT/qGVoBSByDuCt7XqQZoS/G95emBvViDaROxbUstGqse9DFF0wx
	 gkDAzng9Hkg0NeGGKv4hlxSefXYKUELcj3TRDXKy5CWM0HUX4e7wqHK0UFYwOAWhld
	 mdSap61d8i/zp692PPtqoXeoNro/rpY5iH2fUGGdNIM8qSkknwFNqsu6EYaw3px6bH
	 IhuY9wrfZPwiyy8e9fSJ0I4oTMBvOHMRRyBOoPfrgSX/0u8ZPsUsshUKEU6lXAZ+bk
	 ki+5cpE/qh6gA==
Date: Wed, 15 Oct 2025 13:41:31 +0000
From: Yao Zi <ziyao@disroot.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
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
Subject: Re: [PATCH net-next 2/4] net: phy: motorcomm: Support YT8531S PHY in
 YT6801 Ethernet controller
Message-ID: <aO-kH5-CVt5Gbd3C@pie>
References: <20251014164746.50696-2-ziyao@disroot.org>
 <20251014164746.50696-4-ziyao@disroot.org>
 <aO6Dk0rK0nobGClc@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO6Dk0rK0nobGClc@shell.armlinux.org.uk>

On Tue, Oct 14, 2025 at 06:08:35PM +0100, Russell King (Oracle) wrote:
> On Tue, Oct 14, 2025 at 04:47:45PM +0000, Yao Zi wrote:
> > YT6801's internal PHY is confirmed as a GMII-capable variant of YT8531S
> > by a previous series[1] and reading PHY ID. Add support for
> > PHY_INTERFACE_MODE_INTERNAL for YT8531S to allow the Ethernet driver to
> > reuse the PHY code for its internal PHY.
> 
> If it's known to be connected via a GMII interface, even if it's on the
> SoC, please use PHY_INTERFACE_MODE_GMII in preference to
> PHY_INTERFACE_MODE_INTERNAL. PHY_INTERFACE_MODE_INTERNAL is really for
> "we don't know what the internal interface is".

I use PHY_INTERFACE_MODE_INTERNAL for the driver based on Andrew's
feedback[1] on the series submitted by Motorcomm people,

> Is it really GMII? If so, add GMII to the yt8531 driver.
>
> Often this is described as PHY_INTERFACE_MODE_INTERNAL, meaning it
> does not matter what is being used between the MAC and the PHY, it is
> internal to the SoC. You might want to add that to the PHY driver.

Does PHY_INTERFACE_MODE_INTERNAL mean "unknown interface" or "interface
that doesn't matter"? I think this could lead to different choices for
the mode in YT6801's case.

Thanks for your answer,

Best regards,
Yao Zi

> Thanks.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

[1]: https://lore.kernel.org/all/fde04f06-df39-41a8-8f74-036e315e9a8b@lunn.ch/

