Return-Path: <linux-pci+bounces-38485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B8DBE9912
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 17:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDB5744254
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 15:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57313336EC5;
	Fri, 17 Oct 2025 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="E8IaqNfI"
X-Original-To: linux-pci@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3031A332917;
	Fri, 17 Oct 2025 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713471; cv=none; b=sy3JG0+v0m0abRMgeUzfZqc191cwz34YzGlGaD1tRPT8Q90ob/zlEeEEYV2ufmrks8vnhptKK+urgcA/IXiqlfqCz+MyM2W5nN3P+jD1rgPs1Xr584Z4U7xcI0tupJM27oPrM19ymegKQ+lZJSO87UyKEFfM5ali18Huam3bfJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713471; c=relaxed/simple;
	bh=h+cFtCNZjm5oVOld1YdQrQM9D2eUkV7N5lgtdPUuNcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jApvZo/WK0Tt+HLnrvLo+TBtE+Vk0kWAJ9E5/DfkJlXM2w5dAwl5vebU8oZ7K+wUjpOma5VShjnEWDSXJ7miOkerWp3vBTifOfAyxcHAQpoaY02tmY72+qX3L87ae8ScI3iDMgs023etQYkIaFBCHlv5fifTfgPV37cOk3m8KYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=E8IaqNfI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/w51uT33nvziBRi/h4QPWG8nuY0Qq+uvl5/Q7nsmkwY=; b=E8IaqNfIzoEoDLp3v5yNSsTVAY
	lfEkHP8X+CO8QjHl/FV+ttq2CTNvfuoIh6giq0CAhKk+mEJ4whYlSViXc6W35wb7kl4x5emmuISWV
	82XSzMhnLhSm+LiINFhXwDTZeztF3HCn9R0QdTaU7loz8NDfIL30tKM7bIRcvhR1R56SiKOnbep7k
	B12rALuM1IBZ96pmidIrqabdjHA42qLDK9nCKQ1957f6Et15vlU/PbSEoUGbRhsX2zgidUKQ9W3zV
	44NqPPcc09mwPbaC/50ur8ljPobEUmjKNeRbXlLmSVRiwU8fyAOuotx3fsdR0/GhhDPfuBszVB1xE
	XRNHqp+w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38494)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v9m04-0000000082h-33VO;
	Fri, 17 Oct 2025 16:04:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v9lzu-000000004O7-1HP8;
	Fri, 17 Oct 2025 16:04:02 +0100
Date: Fri, 17 Oct 2025 16:04:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yao Zi <ziyao@disroot.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
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
Message-ID: <aPJa4u2OWhVGs58k@shell.armlinux.org.uk>
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
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 17, 2025 at 04:56:23PM +0200, Andrew Lunn wrote:
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

I want to back Andrew's comment here up very strongly.

You will not be the only one looking at this code. There are other
people (e.g. me) who are looking at e.g. the core stmmac code, making
changes to it, which impact the platform glue as well.

The platform glue needs to be understandable to those of us who don't
have knowledge of your platform, so that we can make sense of it and
know what it's actually doing, and thus be able to adapt it when we
push out changes to the core that affect platform glue.

Sadly, it seems 99.9% of platform glue is "dump it into the kernel
and run away".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

