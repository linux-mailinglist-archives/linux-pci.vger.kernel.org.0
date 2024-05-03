Return-Path: <linux-pci+bounces-7044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 104538BAEEE
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 16:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E291C2160B
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB404155303;
	Fri,  3 May 2024 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z0xYgguv"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7641552F7;
	Fri,  3 May 2024 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746120; cv=none; b=eD7fHQt+Vd9pd0um7QgeUE2hO1jTfiWtIdgPveTpkmTAbnwKikiIcrCnv5tVjFVJHNSEI/cKynp6z3i8qABTfzzXp7Qq/Y/C3ptG/afSb0uOuwWLqC4TsHWLfRVHtF4B+z13fGNo2TIS/gaiv0DD0Tjv2itBKz+rAkfLcWyVYLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746120; c=relaxed/simple;
	bh=bLnPfADEwEwkOX0WWN6OPsmdt+pl5f8Iuzuh935QVFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBY1Reo0cts8a2B/OjB2UAUW7j5On9T9LdWVXFwiKhV/rms8C2at0q1exb0E2rEKi+QLPkkU0aBqo/8gYPM7cFyvYESiskVIcsdOao9qyU2WF87o+nZ7uRiqjMddK+j2WnhJgnYAIvpuJbkZA/Ij+4dhCa1qEr+WLXERxIRYzA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z0xYgguv; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA8B01C000C;
	Fri,  3 May 2024 14:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714746111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHh6D+ByoS0ChKmmLmwD9Yo2EL46j5O9IJF8s7BAGCM=;
	b=Z0xYgguvPb0niup9/7f1RVaaaXWIlXmRSf4CLDnZw2sG2oGbBxXy04KWfQKOrTKhsVP5PI
	Y5vjBKqArd7ea8kg6QmMWfW1ZHRi1Dd05z/hMq7IVwg+7dc54meeFYNZlovfV2HYg5qzpx
	5JWe/vKXETX4WtXi/zRU9NnF13ipf3kIkDoTjsQ5foUmeBnkYBIk8VfI9DqFqN3NDPCRhL
	mxCEWumgcFxzrUd5+1fNfa8LJyYR7broXXxQefbcwq0nneXfmEv9KrsottgUm4ytzg+LrT
	kBNCefmAtTEknF1b+rdHBqy2+4HMNsiiCyoWIprA3iLE8FgrCCcS+L+DzUYTYg==
Date: Fri, 3 May 2024 16:21:48 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor.dooley@microchip.com>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
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
 <daniel.machon@microchip.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Allan
 Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 06/17] dt-bindings: net: mscc-miim: Add resets property
Message-ID: <20240503162148.1dc64b9a@bootlin.com>
In-Reply-To: <202405021322091c565595@mail.local>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
	<20240430083730.134918-7-herve.codina@bootlin.com>
	<5d899584-38ed-4eee-9ba5-befdedbc5734@lunn.ch>
	<20240430174023.4d15a8a4@bootlin.com>
	<2b01ed8a-1169-4928-952e-1645935aca2f@lunn.ch>
	<20240502115043.37a1a33a@bootlin.com>
	<20240502-petted-dork-20eb02e5a8e3@wendy>
	<4f9fd16b-773d-40e7-86d8-db19e2f6da16@lunn.ch>
	<202405021322091c565595@mail.local>
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

Hi,

On Thu, 2 May 2024 15:22:09 +0200
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 02/05/2024 14:26:36+0200, Andrew Lunn wrote:
> > On Thu, May 02, 2024 at 11:31:00AM +0100, Conor Dooley wrote:  
> > > On Thu, May 02, 2024 at 11:50:43AM +0200, Herve Codina wrote:  
> > > > Hi Andrew,
> > > > 
> > > > On Tue, 30 Apr 2024 18:31:46 +0200
> > > > Andrew Lunn <andrew@lunn.ch> wrote:
> > > >   
> > > > > > We have the same construction with the pinctrl driver used in the LAN966x
> > > > > >   Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
> > > > > > 
> > > > > > The reset name is 'switch' in the pinctrl binding.
> > > > > > I can use the same description here as the one present in the pinctrl binding:
> > > > > >   description: Optional shared switch reset.
> > > > > > and keep 'switch' as reset name here (consistent with pinctrl reset name).
> > > > > > 
> > > > > > What do you think about that ?    
> > > > > 
> > > > > It would be good to document what it is shared with. So it seems to be
> > > > > the switch itself, pinctl and MDIO? Anything else?
> > > > >   
> > > > 
> > > > To be honest, I know that the GPIO controller (microchip,sparx5-sgpio) is
> > > > impacted but I don't know if anything else is impacted by this reset.
> > > > I can update the description with:
> > > >   description:
> > > >     Optional shared switch reset.
> > > >     This reset is shared with at least pinctrl, GPIO, MDIO and the switch
> > > >     itself.
> > > > 
> > > > Does it sound better ?  
> > > 
> > > $dayjob hat off, bindings hat on: If you don't know, can we get someone
> > > from Microchip (there's some and a list in CC) to figure it out?  
> > 
> > That is probably a good idea, there is potential for hard to find bugs
> > here, when a device gets an unexpected reset. Change the order things
> > probe, or an unexpected EPRODE_DEFER could be interesting.
> >   
> 
> 
> The datasheet states:
> "The VCore system comprises all the blocks attached to the VCore Shared
> Bus (SBA), including the PCIe, DDR, frame DMA, SI slave, and MIIM slave
> blocks. The device includes all the blocks attached to the Switch Core
> Register Bus (CSR) including the VRAP slave. For more information about
> the VCore System blocks, see Figure 5-1."
> 
> However, the reset driver protects the VCORE itself by setting bit 5.
> Everything else is going to be reset.
> 

Right,
I will update the reset description with:
  description:
    Optional shared switch reset.
    This reset is shared with all blocks attached to the Switch Core Register
    Bus (CSR) including VRAP slave.

Is that better ?

Best regards,
Hervé
-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

