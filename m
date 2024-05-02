Return-Path: <linux-pci+bounces-7008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B96BC8B9B85
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 15:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E85281FF3
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 13:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831D584A4A;
	Thu,  2 May 2024 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CKT2s9Xl"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A42C8F3;
	Thu,  2 May 2024 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714656144; cv=none; b=Dgo5sXMuPJBtJ1r9pOcPUSaOAN/HCyHkfVNVqbxKlCcaYB0iOrY0KN9Ra3i8NwD0cqP79XhsMGbEzec0W7KgGHoWhEsVhf5lstZKZ16+gz+rJW3VtKYGRILPM31iI1JHnAFxwiOPAs/WO80QpghVRsXH0rs+wjIs9X9zo2HGwuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714656144; c=relaxed/simple;
	bh=90uiPCOml9cuv02qcxvScdAgGt3XGm+ofdWR9z4E6EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqmgvl5D7KaevkzE6ihQuttd7U/PiNIrJw13ub/x2grlhJEbmDWzUnBwWXwvhqhQku48sm2OTBlUtThttwZBBv4Pkilt3JPXYbak66RfgqaN0XBqoKYu6a2x9hl2Gph4eHaf3/HFLmxiz2INvpn3Y347ZBdFG1T/ztKwcuAzfws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CKT2s9Xl; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1DA9DE0005;
	Thu,  2 May 2024 13:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714656132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ORq0qiQpLZgKtWOoETilQNGiO5BJ+bL1ZtI++EWsyfQ=;
	b=CKT2s9XlZ2gUQpEw6SkCR/ZoPZ9xIE5ic3HXncXsBrKZs8aLGI0ARdIlZtlfMc6C18Atgx
	rPSqWwiKS3NjaJ65OzI7abb+hdhYKE5Q6nTapPJWYPUvtfbZBkvqrxHVa/L3M/Bz4duSzy
	kkCpiR/SU4YH2V+vcRuDVS0PZEmMIiclqnhBbKZarrm78LOnAWa8h3YvOD/rbvl/NZIyO5
	iakFdnBJDcc9iBevW1bB713zU8pQlNuL/lVxSMPSO7fKSZ7ImuGd71XTYn4Mfz6IH0LsYn
	m/b5yb/NeRQEIRkmLU3sFIcXl0poRXFbXgZf44p9BO0DXj5WiQxVwLQZHM4pDA==
Date: Thu, 2 May 2024 15:22:09 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
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
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 06/17] dt-bindings: net: mscc-miim: Add resets property
Message-ID: <202405021322091c565595@mail.local>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
 <20240430083730.134918-7-herve.codina@bootlin.com>
 <5d899584-38ed-4eee-9ba5-befdedbc5734@lunn.ch>
 <20240430174023.4d15a8a4@bootlin.com>
 <2b01ed8a-1169-4928-952e-1645935aca2f@lunn.ch>
 <20240502115043.37a1a33a@bootlin.com>
 <20240502-petted-dork-20eb02e5a8e3@wendy>
 <4f9fd16b-773d-40e7-86d8-db19e2f6da16@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f9fd16b-773d-40e7-86d8-db19e2f6da16@lunn.ch>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 02/05/2024 14:26:36+0200, Andrew Lunn wrote:
> On Thu, May 02, 2024 at 11:31:00AM +0100, Conor Dooley wrote:
> > On Thu, May 02, 2024 at 11:50:43AM +0200, Herve Codina wrote:
> > > Hi Andrew,
> > > 
> > > On Tue, 30 Apr 2024 18:31:46 +0200
> > > Andrew Lunn <andrew@lunn.ch> wrote:
> > > 
> > > > > We have the same construction with the pinctrl driver used in the LAN966x
> > > > >   Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
> > > > > 
> > > > > The reset name is 'switch' in the pinctrl binding.
> > > > > I can use the same description here as the one present in the pinctrl binding:
> > > > >   description: Optional shared switch reset.
> > > > > and keep 'switch' as reset name here (consistent with pinctrl reset name).
> > > > > 
> > > > > What do you think about that ?  
> > > > 
> > > > It would be good to document what it is shared with. So it seems to be
> > > > the switch itself, pinctl and MDIO? Anything else?
> > > > 
> > > 
> > > To be honest, I know that the GPIO controller (microchip,sparx5-sgpio) is
> > > impacted but I don't know if anything else is impacted by this reset.
> > > I can update the description with:
> > >   description:
> > >     Optional shared switch reset.
> > >     This reset is shared with at least pinctrl, GPIO, MDIO and the switch
> > >     itself.
> > > 
> > > Does it sound better ?
> > 
> > $dayjob hat off, bindings hat on: If you don't know, can we get someone
> > from Microchip (there's some and a list in CC) to figure it out?
> 
> That is probably a good idea, there is potential for hard to find bugs
> here, when a device gets an unexpected reset. Change the order things
> probe, or an unexpected EPRODE_DEFER could be interesting.
> 


The datasheet states:
"The VCore system comprises all the blocks attached to the VCore Shared
Bus (SBA), including the PCIe, DDR, frame DMA, SI slave, and MIIM slave
blocks. The device includes all the blocks attached to the Switch Core
Register Bus (CSR) including the VRAP slave. For more information about
the VCore System blocks, see Figure 5-1."

However, the reset driver protects the VCORE itself by setting bit 5.
Everything else is going to be reset.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

