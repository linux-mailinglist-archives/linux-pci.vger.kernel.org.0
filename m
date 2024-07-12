Return-Path: <linux-pci+bounces-10205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7670792FAED
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 15:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F461281CD8
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 13:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D8F16F278;
	Fri, 12 Jul 2024 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bq2GtCDc"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B38A15957E;
	Fri, 12 Jul 2024 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720789897; cv=none; b=rpYBInvux3jtzlY9AbOfVlZjOqnBDbFpJ6NAZaUWhIXCgfMQkKueumffBKaBmo9NT3/lggYFQjy8vwDP5n2ekGA58NKO79NzOzuaCI11GJbF1KDE2bekM5PwRiBQudj9Wf6aU/Ei69ac9e2s4BSM0vKB9vSjg+dPctSosDMtS1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720789897; c=relaxed/simple;
	bh=HDosvXuSleQyB8lYY7i6tGGf2MEJMbnXC05n5hsQSt8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WwXOylrJQnvod5nN3tBfRr4gxmExn/GiOqIEByXOUA7fh6h/hCtCIU9WZ2ML+30E/c7lAHKbD/8+dMh+IMdMsr1+11PtJHn7gwlpUkwrfZQlc8+sC6+w62t2kLxG9ytJ4XKNTQfKrgcoJ26Xm42HUc9fzaaqCu8JcjTTipVH1cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bq2GtCDc; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 96204FF811;
	Fri, 12 Jul 2024 13:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720789886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=StjVOnU5djjXaehWS8TjNnExgQiHvF7T/RHfibeCJL0=;
	b=bq2GtCDc/yQX7j0iSwRzBaqUG+BHWIGjTD3RSrtHJb0WAoAbTrSv7AzYkV5jZcU5EmCBZJ
	Np7r9LOxpuWSSr7b6AWb4kTRfbNrGKOI/s8xN3nxlp7TKmLLxKDSlCS40jnjMoEp0HnQVN
	AOll4fv6Iq8q6S/lQxhqGOuSgb1TIx4p8mmhNjYYBZLaDwBtyTbkUqh8j8abIroK70Se6O
	l46i48SNnAteGnzfTvYzrwpmCPp1rJDS1vzVFn3L4k9A+nAsKUqHxUvYV8iNMUjXV9h2I3
	m9z+Irm4BA7+8Dq7XYx5V9+KUiznXlu1/XUoha+QHZfZIhPNRqQ68zwEPp6PRg==
Date: Fri, 12 Jul 2024 15:11:22 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Conor
 Dooley <conor@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones
 <lee@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Simon Horman
 <horms@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, UNGLinuxDriver@microchip.com, Saravana Kannan
 <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>, Steen
 Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 6/7] mfd: Add support for LAN966x PCI device
Message-ID: <20240712151122.67a17a94@bootlin.com>
In-Reply-To: <CAL_Jsq+1r3SSaXupdNAcXO-4rcV-_3_hwh0XJaBsB9fuX5nBCQ@mail.gmail.com>
References: <20240627091137.370572-1-herve.codina@bootlin.com>
	<20240627091137.370572-7-herve.codina@bootlin.com>
	<20240711152952.GL501857@google.com>
	<20240711184438.65446cc3@bootlin.com>
	<2024071113-motocross-escalator-e034@gregkh>
	<CAL_Jsq+1r3SSaXupdNAcXO-4rcV-_3_hwh0XJaBsB9fuX5nBCQ@mail.gmail.com>
Followup-To: linux-kernel@vger.kernel.org
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

Hi Rob, Conor,

On Thu, 11 Jul 2024 14:33:26 -0600
Rob Herring <robh@kernel.org> wrote:

> On Thu, Jul 11, 2024 at 1:08 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jul 11, 2024 at 06:44:38PM +0200, Herve Codina wrote:  
> > > Hi Lee,
> > >
> > > On Thu, 11 Jul 2024 16:29:52 +0100
> > > Lee Jones <lee@kernel.org> wrote:
> > >  
> > > > On Thu, 27 Jun 2024, Herve Codina wrote:
> > > >  
> > > > > Add a PCI driver that handles the LAN966x PCI device using a device-tree
> > > > > overlay. This overlay is applied to the PCI device DT node and allows to
> > > > > describe components that are present in the device.
> > > > >
> > > > > The memory from the device-tree is remapped to the BAR memory thanks to
> > > > > "ranges" properties computed at runtime by the PCI core during the PCI
> > > > > enumeration.
> > > > >
> > > > > The PCI device itself acts as an interrupt controller and is used as the
> > > > > parent of the internal LAN966x interrupt controller to route the
> > > > > interrupts to the assigned PCI INTx interrupt.  
> > > >
> > > > Not entirely sure why this is in MFD.  
> > >
> > > This PCI driver purpose is to instanciate many other drivers using a DT
> > > overlay. I think MFD is the right subsystem.  
> 
> It is a Multi-function Device, but it doesn't appear to use any of the
> MFD subsystem. So maybe drivers/soc/? Another dumping ground, but it
> is a driver for an SoC exposed as a PCI device.
> 

In drivers/soc, drivers/soc/microchip/ could be the right place.

Conor, are you open to have the PCI LAN966x device driver in
drivers/soc/microchip/ ?

Best regards,
Hervé


