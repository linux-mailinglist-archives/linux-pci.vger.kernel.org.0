Return-Path: <linux-pci+bounces-9032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89884910D62
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 18:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E13B1F21B89
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 16:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3E01B374B;
	Thu, 20 Jun 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EN3Rla40"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14571B3739;
	Thu, 20 Jun 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901796; cv=none; b=koK2EOCKTvlAYJf16715QhgV3H8laybtSPxjZ62OHS4nWYKiVrkFEZKUP36QhftX+rnapWU0CyoBT0mamyukyfcxOFcV6RV9bPUnwVl1112b2crNQDDSWv5IFbcpi5BM21W8RtCoPxAeoqC42sldl6TPP6CPJWab037bVQl7U9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901796; c=relaxed/simple;
	bh=GK4MNvX4+1JfczyTRdZTg9XT+qi0+8xD3AsZHcZ8Fqo=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cChLcAOUOFKatvBuCgyQfBmpeW3avuLXIebA7TO0PkQQovsZPM65E/tv/BXjZUmBy2aXPU4jysPspI1phCPlDYyvcOG+z6JasrjF8UrfkxgMLY+S308bBTq4slEM9+tgNAfR17UDtFesrkfeYrP9u9UPLjojhgeG8VT2j44YLUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EN3Rla40; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 632AB240005;
	Thu, 20 Jun 2024 16:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718901791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zCnekOgzHJ5CtNqqN1hEHsWUPpfbXDdutXGhUVlconY=;
	b=EN3Rla40J76rp4uxb98AiJsO9bmSyCfqNZia+LcMqKEdmZcebP+27tab//3SrxFUcHQBJL
	3AU25VosnRi/zgpew0HqncZXezZAmh/Rr8sTw6x0XqfcigIUDpZBcSfMJPIxqw5KSP6cIo
	+H+nxgh/087GcC7gnPTifJnz/6pzWsICipD04n0Emsa+cGigFc+rh7ld2BtNq4YYpPKd6N
	C+sNoxdVYLtvZmFf1WIA1K08UnP7KbBn3jRiMg/YFD7N7/G+J8MCW36V7MSgBMA5Jt4lgk
	y2T1T/ldqmbj1TcVxIfCImdFJjKEyU+9v0MV1/x0kNazRDKJgHOIMeQfYKmM3A==
Date: Thu, 20 Jun 2024 18:43:09 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Simon Horman
 <horms@kernel.org>, Sai Krishna Gajula <saikrishnag@marvell.com>, Thomas
 Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lee Jones
 <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Saravana Kannan <saravanak@google.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Lars
 Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Allan
 Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 18/19] mfd: Add support for LAN966x PCI device
Message-ID: <20240620184309.6d1a29a1@bootlin.com>
In-Reply-To: <CAHp75VdDkv-dxWa60=OLfXAQ8T5CkFiKALbDHaVVKQOK3gJehA@mail.gmail.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
	<20240527161450.326615-19-herve.codina@bootlin.com>
	<ZmDJi__Ilp7zd-yJ@surfacebook.localdomain>
	<20240620175646.24455efb@bootlin.com>
	<CAHp75VdDkv-dxWa60=OLfXAQ8T5CkFiKALbDHaVVKQOK3gJehA@mail.gmail.com>
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

My bad, I wrongly answered first in private.
I already eesend my answers with people in Cc

Now, this is the Andy's your reply.

Sorry for this mistake.

Herve

On Thu, 20 Jun 2024 18:07:16 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Jun 20, 2024 at 5:56 PM Herve Codina <herve.codina@bootlin.com> wrote:
> > On Wed, 5 Jun 2024 23:24:43 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > Mon, May 27, 2024 at 06:14:45PM +0200, Herve Codina kirjoitti:  
> 
> ...
> 
> > > > +   if (!dev->of_node) {
> > > > +           dev_err(dev, "Missing of_node for device\n");
> > > > +           return -EINVAL;
> > > > +   }  
> > >
> > > Why do you need this? The code you have in _create_intr_ctrl() will take care
> > > already for this case.  
> >
> > The code in _create_intr_ctrl checks for fwnode and not an of_node.
> >
> > The check here is to ensure that an of_node is available as it will be use
> > for DT overlay loading.  
> 
> So, what exactly do you want to check? fwnode check covers this.
> 
> > I will keep the check here and use dev_of_node() instead of dev->of_node.  
> 
> It needs to be well justified as from a coding point of view this is a
> duplication.
> 
> ...
> 
> > > > +   pci_set_master(pdev);  
> > >
> > > You don't use MSI, what is this for?  
> >
> > DMA related.
> > Allows the PCI device to be master on the bus and so initiate transactions.
> >
> > Did I misunderstood ?  
> 
> So, you mean that the PCI device may initiate DMA transactions and
> they are not related to MSI, correct?
> 
> ...
> 
> > > > +static struct pci_device_id lan966x_pci_ids[] = {
> > > > +   { PCI_DEVICE(0x1055, 0x9660) },  
> > >
> > > Don't you have VENDOR_ID defined somewhere?  
> >
> > No and 0x1055 is taken by PCI_VENDOR_ID_EFAR in pci-ids.h
> > but SMSC acquired EFAR late 1990's and MCHP acquired SMSC in 2012
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/microchip/lan743x_main.h#L851
> >
> > I will patch pci-ids.h to create:
> >   #define PCI_VENDOR_ID_SMSC PCI_VENDOR_ID_EFAR
> >   #define PCI_VENDOR_ID_MCHP PCI_VENDOR_ID_SMSC
> > As part of this patch, I will update lan743x_main.h to remove its own #define
> >
> > And use PCI_VENDOR_ID_MCHP in this series.  
> 
> Okay, but I don't think (but I haven't checked) we have something like
> this ever done there. In any case it's up to Bjorn how to implement
> this.
> 
> > > > +   { 0, }  
> > >
> > > Unneeded ' 0, ' part  
> >
> > Will be removed.
> >  
> > > > +};  
> 

