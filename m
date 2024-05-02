Return-Path: <linux-pci+bounces-6995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 558E58B9816
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 11:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863AD1C22A78
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 09:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E376655C3C;
	Thu,  2 May 2024 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jd3w0RFf"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E414286;
	Thu,  2 May 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643463; cv=none; b=qR+MJePCnoYEadEeznukCFfc+cARmr/Y1LQeyvHlpwLXTFZYRDi3I/CQu5C7xMnykx13ylkkDzhTTopNqyP8nxcJLQGxhRSipHOefY0ZVLRLi2i8BIbKca3Bk9w25uV05WCSBBqJwvzUoHPr6CbTBpmpEQM80PfqMLq1Ul7VBBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643463; c=relaxed/simple;
	bh=BAFP/ofSa+AEwTY25adE8qwMB+9ibYQI/GHdkMUufIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9ZQxHujyre4JNCSlhlXvom0JqmNzZp5vXPng34EXdDfifq8QacItHo1V/TvrtNdANPp8d8iBWDXIaN7rpQTWiZWY2rAi9IM2TilQTmhYJTiiDfH/4x2BtQSeZOB4PA/9Z5aEZudPQg5MLEEEQkxiNaXBdIsGDIRAQGNbCm9SkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jd3w0RFf; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C38B9C0009;
	Thu,  2 May 2024 09:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714643453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=61+EepSzB2Xshk8/s0Q2YxSx5UzzAr0zhhrwm9xlmf4=;
	b=Jd3w0RFfaXI6YAgvOAyWxHBzF+vjVQCLYETaT9/W0kFojht3mdm7JCaRdaNV6lKeEInGXH
	EECIQsIrCq8D+zccHu5xleCHIZ4Faeuj3/EJMxdvTrGicWFrpXP8lLZD7fJITyOy1L29MH
	bUy7IFKHz9P5FEd9XpmRSUdxbkz6dGgc5iYE5REU5Qchv9X6uBYrXDaxQL7W7DPwLnJ6ZX
	HhmFUJl6xqQt9sftzhFhvh5fI+Pdk3dW+8iEK+mE+wmZdNNcMwjCOraOp23mtCBaXVEV4B
	SD7qzmtrCO8Qk2SbucLBJKVwAW2lVILqtq+uMC0R/xQogM8tJhcRa2Z0KtTvrQ==
Date: Thu, 2 May 2024 11:50:43 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lee Jones <lee@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Saravana Kannan
 <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>, Steen
 Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Allan
 Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 06/17] dt-bindings: net: mscc-miim: Add resets property
Message-ID: <20240502115043.37a1a33a@bootlin.com>
In-Reply-To: <2b01ed8a-1169-4928-952e-1645935aca2f@lunn.ch>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
	<20240430083730.134918-7-herve.codina@bootlin.com>
	<5d899584-38ed-4eee-9ba5-befdedbc5734@lunn.ch>
	<20240430174023.4d15a8a4@bootlin.com>
	<2b01ed8a-1169-4928-952e-1645935aca2f@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Andrew,

On Tue, 30 Apr 2024 18:31:46 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > We have the same construction with the pinctrl driver used in the LAN966x
> >   Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
> > 
> > The reset name is 'switch' in the pinctrl binding.
> > I can use the same description here as the one present in the pinctrl binding:
> >   description: Optional shared switch reset.
> > and keep 'switch' as reset name here (consistent with pinctrl reset name).
> > 
> > What do you think about that ?  
> 
> It would be good to document what it is shared with. So it seems to be
> the switch itself, pinctl and MDIO? Anything else?
> 

To be honest, I know that the GPIO controller (microchip,sparx5-sgpio) is
impacted but I don't know if anything else is impacted by this reset.
I can update the description with:
  description:
    Optional shared switch reset.
    This reset is shared with at least pinctrl, GPIO, MDIO and the switch
    itself.

Does it sound better ?

Best regards
Hervé

