Return-Path: <linux-pci+bounces-9173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CD5914485
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 10:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1ED2810DC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 08:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C244AED4;
	Mon, 24 Jun 2024 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cxujiqvb"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9AF49645;
	Mon, 24 Jun 2024 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217212; cv=none; b=asA2WTtPnwn1wiWhnULlHEbCbWcflnXL8Y4CcJL4Hhnh9AmAdIETGTnj1gqFPXxknFsm2ijqRFmyBXDXCvrW/mZBG/sh1VO52g0mB7Tgdu5kTepQocutRSkuC9VabqUD49554x274Bd34uvGzcSQYtJzjKci1II6Rx+Fmnxdb9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217212; c=relaxed/simple;
	bh=pq0cmcBY/X2RNBjl7vh86+Fi/2499fm8ZPDUFHIfztc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tn6tgIRmhvGMdUH8cgc8jacrL8kkwWObN/ESYqshQ2X6Oy4TbiM03fwoqEu5v3cRpbc17uh0ao4cKEC6Zctiym8gzDPLBtth6pzZbPPJRpwDXEan4KbSCkYmtBcV24yruG/FIMo9zqIzvHXY12SvG9xg6Va+kLdCcr8tsfb0a8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cxujiqvb; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5563FC0009;
	Mon, 24 Jun 2024 08:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719217207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vpj1bjYXlBzUfYOefDTjh4xiC9L+rWuuQmo0xQfNisQ=;
	b=cxujiqvbjQcjSYkwhcOwJAczyZeKLHaVrwYHhoxhQTlS84njHLtQU7WqYt0TVoLRyIsj/L
	7b9nOKN5UR7d/5EIQAZ7hEEcyhn0Cq+6hJ3IfkQniOqC7/JJyuIgqQamKLH2mhQ7NOQuh9
	Bwd3PaIEVlv/8MPvj+C2QLY6hLlABB1P+K4ceJxNEy59dzQIB8t9FyVXIKmlA3YikrJZmh
	MtHsGb/kZflAGcFqL0O13KM/Hnm0pJ5l2xFN212IJL1m373ToUZfXE1Xq7oNN1cRC82Djb
	9KGd+YUl4ms/PHS4Zds9ogBeUkZsyvcmGDX34hHAE1a5rk4uYg2iAebmKSH0qw==
Date: Mon, 24 Jun 2024 10:20:03 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Sai Krishna Gajula
 <saikrishnag@marvell.com>, Thomas Gleixner <tglx@linutronix.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lee Jones <lee@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Saravana
 Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Allan
 Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 18/19] mfd: Add support for LAN966x PCI device
Message-ID: <20240624102003.3b11a8cc@bootlin.com>
In-Reply-To: <CAHp75VdeoNXRTmMoK-S6qecU1nOQWDZVONeHU+imFiwcTxe8xg@mail.gmail.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
 <20240527161450.326615-19-herve.codina@bootlin.com>
 <ZmDJi__Ilp7zd-yJ@surfacebook.localdomain>
 <20240620175646.24455efb@bootlin.com>
 <CAHp75VdDkv-dxWa60=OLfXAQ8T5CkFiKALbDHaVVKQOK3gJehA@mail.gmail.com>
 <20240620184309.6d1a29a1@bootlin.com>
 <20240620191923.3d62c128@bootlin.com>
 <CAHp75VdeoNXRTmMoK-S6qecU1nOQWDZVONeHU+imFiwcTxe8xg@mail.gmail.com>
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

On Fri, 21 Jun 2024 17:45:05 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Jun 20, 2024 at 7:19 PM Herve Codina <herve.codina@bootlin.com> wrote:
> > On Thu, 20 Jun 2024 18:43:09 +0200
> > Herve Codina <herve.codina@bootlin.com> wrote:  
> > > On Thu, 20 Jun 2024 18:07:16 +0200
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > > On Thu, Jun 20, 2024 at 5:56 PM Herve Codina <herve.codina@bootlin.com> wrote:  
> > > > > On Wed, 5 Jun 2024 23:24:43 +0300
> > > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > > > > Mon, May 27, 2024 at 06:14:45PM +0200, Herve Codina kirjoitti:  
> 
> ...
> 
> > > > > > > +   if (!dev->of_node) {
> > > > > > > +           dev_err(dev, "Missing of_node for device\n");
> > > > > > > +           return -EINVAL;
> > > > > > > +   }  
> > > > > >
> > > > > > Why do you need this? The code you have in _create_intr_ctrl() will take care
> > > > > > already for this case.  
> > > > >
> > > > > The code in _create_intr_ctrl checks for fwnode and not an of_node.
> > > > >
> > > > > The check here is to ensure that an of_node is available as it will be use
> > > > > for DT overlay loading.  
> > > >
> > > > So, what exactly do you want to check? fwnode check covers this.
> > > >  
> > > > > I will keep the check here and use dev_of_node() instead of dev->of_node.  
> > > >
> > > > It needs to be well justified as from a coding point of view this is a
> > > > duplication.  
> >
> > On DT based system, if a fwnode is set it is an of_node.
> > On ACPI, if a fwnode is set is is an acpi_node.
> >
> > The core PCI, when it successfully creates the DT node for a device
> > (CONFIG_PCI_DYNAMIC_OF_NODES) set the of_node of this device.
> > So we can have a device with:
> >  - fwnode from ACPI
> >  - of_node from core PCI creation  
> 
> Does PCI device creation not set fwnode?

No and IMHO it is correct.
This device has the fwnode that point to an ACPI node: The description used
for device creation.

The of_node set is created based on PCI known information.
This of_node, at PCI level is not used to create the PCI device but is created
based on an already existing PCI device.

> 
> > This driver needs the of_node to load the overlay.
> > Even if the core PCI cannot create a DT node for the PCI device right
> > now, I don't expect this LAN855x PCI driver updated when the core PCI
> > is able to create this PCI device DT node.  
> 
> If it's really needed, I think the correct call here is is_of_node()
> to show exactly why it's not a duplication. It also needs a comment on
> top of this call.

is_of_node() will not returns the expected result.
It will return false as the fwnode->ops of the device is not related to 
of_node ops but ACPI node ops :(

What do you thing it I keep the of_node test using dev_of_node() and add the
following comment:
	--- 8< ---
	/*
	 * On ACPI system, fwnode can point to the ACPI node.
	 * This driver needs an of_node to be used as the device-tree overlay
	 * target. This of_node should be set by the PCI core if it succeeds in
	 * creating it (CONFIG_PCI_DYNAMIC_OF_NODES feature).
	 * Check here for the validity of the of_node.
	 */
	if (!dev_of_node(dev)) {
		dev_err(dev, "Missing of_node for device\n");
		return -EINVAL;
	}
	--- 8< ---

Let me know if this can be ok.

Hervé

