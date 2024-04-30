Return-Path: <linux-pci+bounces-6898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D602C8B7D02
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 18:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CEE9B2548B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49841802A5;
	Tue, 30 Apr 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lo9Ygd8V"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E1917F38C;
	Tue, 30 Apr 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494723; cv=none; b=Y2Hb//gT0LpTdRIPyqtNwTxxDx7aTp5tTLMl2dorr092x8hmsZGstFz0ZwU1DP2JV3DOlARAUs+mbjXFJRZMlaTm0tCbTipjVfsVm2o7GLQT2DFwEQFlOK9/txkwLSCgrpME/tJLCWmTPc3e5zTufqOofPbp0iH889sMaN+MfPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494723; c=relaxed/simple;
	bh=VkkpzsJprISmtYUc+TA6qOHr+ByoaUmlZ1YxntQ0LXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COS6RIpxFHMEtW2wS7tWIEg4wuR7+djaC/tT7VPQjgRkL2WZ5ZLY0jQPHkb/nba2Qfvpj1MJcnE+L7v302Mdz9sUAk83RMV89E4P5QU5PMSOkhjDwEM34dMOlz2bDHUf9EBsalCI0Ngqzg8LlaQK8S3wbT5fdVb3BAR8ehhcFi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lo9Ygd8V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mT9X8XxEhdVId5LCLAyWK0SaWlOcI+5k2YpzrCEzpcc=; b=lo9Ygd8VvCtkhrWLQSkc9WRxm5
	izdHwlIin29YSQpzkR70osYqugMijrSi6bsa8XfUPttWdHC4+bj7kM1/o/y0OEESp2HoNGN/NfBpt
	4vFtCwuRMETDTVWSoxeBzL77Q/3JnP7kxF4s32Oq0WuEp+Gg7PpZ7XVZnKMBMF2lBqYg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1qOQ-00EMfF-CZ; Tue, 30 Apr 2024 18:31:46 +0200
Date: Tue, 30 Apr 2024 18:31:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 06/17] dt-bindings: net: mscc-miim: Add resets property
Message-ID: <2b01ed8a-1169-4928-952e-1645935aca2f@lunn.ch>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
 <20240430083730.134918-7-herve.codina@bootlin.com>
 <5d899584-38ed-4eee-9ba5-befdedbc5734@lunn.ch>
 <20240430174023.4d15a8a4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430174023.4d15a8a4@bootlin.com>

> We have the same construction with the pinctrl driver used in the LAN966x
>   Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
> 
> The reset name is 'switch' in the pinctrl binding.
> I can use the same description here as the one present in the pinctrl binding:
>   description: Optional shared switch reset.
> and keep 'switch' as reset name here (consistent with pinctrl reset name).
> 
> What do you think about that ?

It would be good to document what it is shared with. So it seems to be
the switch itself, pinctl and MDIO? Anything else?

    Andrew

