Return-Path: <linux-pci+bounces-38584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E062BED1C7
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 16:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10388189F519
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 14:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95F4277C98;
	Sat, 18 Oct 2025 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RLk795UI"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B3A1B423B;
	Sat, 18 Oct 2025 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760799213; cv=none; b=ZtPmc3J1mnLJZPl6/K9UqMWOXItXtk1Z9QACgXqYI4pnX2mjJ+jfBTEsCb+1pMzjx2SpZdAZUB6W3K/YXyHICYtGcX7PCFitDvlrGTPJoUAAPJO2YDs3pEYhtpyh4dSXOvrYQB5VjeEOvHcxB4ZCJQ/7i8eCccblj4Oq9Hw13UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760799213; c=relaxed/simple;
	bh=qa1RCmp5XD+r2YD7uwya/F4rfz6ZyF4Sz1iDHUBFr6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rj6yjWFA4YGA4FZVINGKbmiRhC1zOCZOFrXa6SwgBRlcU1LfkXAplBEkXVgopsn23J9cEVSaC/h4RL8yrdytnCEm587oozhulR09B2zMkcjbe1gpG5akfzVbWdpJ+5pICT1o3oomcQ1hfOLbD72bcvgVIiaOPvGg8LPfoTA0BN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RLk795UI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IjwECEO8cLj2+B6qGCD3ufgiJC6kdAjaM4X3QYkATeM=; b=RLk795UIV4XtZJvKAKsn7fb1O4
	PwXC2GO684f6kmFf0M+TcD8E5qnzewNcCkq3deQ0MYA+7iAOO019PKJi4U3PLnpZ8pfOyIL6HE9Tb
	NKuw9RMP5K2btEHbqVpCmnjU1ITZL0e+pcVSxRfnM6krLkyQD74FDeWtOuKtDjKP8sZg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vA8Iq-00BNjq-6C; Sat, 18 Oct 2025 16:53:04 +0200
Date: Sat, 18 Oct 2025 16:53:04 +0200
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
Message-ID: <cc564a19-7236-40d4-bf3c-6a24f7d00bec@lunn.ch>
References: <20251014164746.50696-2-ziyao@disroot.org>
 <20251014164746.50696-5-ziyao@disroot.org>
 <f1de6600-4de9-4914-95e6-8cdb3481e364@lunn.ch>
 <aPJMsNKwBYyrr-W-@pie>
 <81124574-48ab-4297-9a74-bba7df68b973@lunn.ch>
 <aPNM1jeKfMPNsO4N@pie>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPNM1jeKfMPNsO4N@pie>

> > I was also wondering about all the other parameters you set. Why have
> > i not seen any other glue driver with similar code? What makes this
> > glue driver different?
> 
> Most glue drivers are for SoC-integrated IPs, for which
> stmmac_pltfr_probe() helper could be used to retrieve configuration
> arguments from devicetree to fill plat_stmmacenet_data. However, YT6801
> is a PCIe-based controller, and we couldn't rely on devicetree to carry
> these parameters.
> 
> You could find similar parameter setup code in stmmac_pltfr_probe(), and
> also other glue drivers for PCIe-based controllers, like dwmac-intel.c
> (intel_mgbe_common_data) and dwmac-loongson.c (loongson_default_data).

Is there anything common with these two drivers? One of the problems
stmmac has had in the past is that glue driver writers just
copy/paste, rather than refactor other glue drivers to share code.  If
there is shared code, maybe move it into stmmac_pci.c as helpers?

	Andrew

