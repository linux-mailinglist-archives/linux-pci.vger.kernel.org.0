Return-Path: <linux-pci+bounces-13717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8622098E00C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 18:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329271F21A34
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 16:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0DC1D0E0D;
	Wed,  2 Oct 2024 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y7ZFDe3Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81771D0B88;
	Wed,  2 Oct 2024 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884939; cv=none; b=VVoZaVB211qBgfxiS3MidvAI6r/fo7siQlVQO4pDQL+Vp0jqnanUsrOqaOESNnC9F07kgpGrXds6Be+U5Cbc5iR3N1yMty8pqcEsuUKyv0eKJJvCqA2f3i2Loxw6pYmk2dbOEtEZKudY6hY7mw4erv6vhEVS89G85B5viIINBg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884939; c=relaxed/simple;
	bh=zfvEMiGi3OWlIY/pUBW+RpmzYW8vFnzIKQEPYoIhFng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjEYbRpmovcgTtKwnEwOXq2iROkJRX6uxG1XAAxus8eDwmi8c+r86T76RblqdZGT61JzwD1qnV2pRVpS5Nhm3dCPVq/rNsN9xYeFTryMNSXi/9BkwIuvgPZ0Uk69XQIFnD9FgCzhZjTK3MNOFHqd6fKB905qW3e8P5HTXZV+qr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y7ZFDe3Y; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 283EC20009;
	Wed,  2 Oct 2024 16:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727884933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tWok2bNeEgvlRS2Fbg5hLuPkTCb5xkbJGALutssM5Y=;
	b=Y7ZFDe3Yp6ievVkmBjmO+efxu/CRrFYn2knnsPIe8WcPk4uHSdyluYtjBSewabxMDu448n
	7URRD7Q+geaOvCDFJSY8cPRcwPAejsnubbQNLv6v+uovZrK91Tm6zch5pNrbaEMgSBVcmr
	1pd87n9sqg6h+IgbmBUKTTNIs4xik65dr6wfKvSgVYN422PUpT9EOI3kn2/zM+RCJWgV1p
	rVQAJO++rKQAkMcr8meohHFNW6Kx7qQootIiaPV5J6AW9kjRzhbmutBIXpqfjKKLlf13V5
	ZhdAFXCYsMizEIZIrnpv3HobwATMro1xlIa+YRbZ81m1Wd7QnH+766uS9IHnzQ==
Date: Wed, 2 Oct 2024 18:02:07 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Andy Shevchenko"
 <andy.shevchenko@gmail.com>, "Simon Horman" <horms@kernel.org>, "Lee Jones"
 <lee@kernel.org>, "derek.kiernan@amd.com" <derek.kiernan@amd.com>,
 "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Lars Povlsen"
 <lars.povlsen@microchip.com>, "Steen Hegelund"
 <Steen.Hegelund@microchip.com>, "Daniel Machon"
 <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Saravana Kannan" <saravanak@google.com>,
 "David S . Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Horatiu Vultur" <horatiu.vultur@microchip.com>,
 "Andrew Lunn" <andrew@lunn.ch>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Allan
 Nielsen" <allan.nielsen@microchip.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 3/7] misc: Add support for LAN966x PCI device
Message-ID: <20241002180207.550e4cbb@bootlin.com>
In-Reply-To: <3e21a3ba-623e-4b75-959b-3cdf906ee1bd@app.fastmail.com>
References: <20240930121601.172216-1-herve.codina@bootlin.com>
	<20240930121601.172216-4-herve.codina@bootlin.com>
	<b4602de6-bf45-4daf-8b52-f06cc6ff67ef@app.fastmail.com>
	<20241002144119.45c78aa7@bootlin.com>
	<3e21a3ba-623e-4b75-959b-3cdf906ee1bd@app.fastmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

On Wed, 02 Oct 2024 14:31:13 +0000
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Wed, Oct 2, 2024, at 12:41, Herve Codina wrote:
> > On Wed, 02 Oct 2024 11:08:15 +0000
> > "Arnd Bergmann" <arnd@arndb.de> wrote:  
> >> On Mon, Sep 30, 2024, at 12:15, Herve Codina wrote:
> >>   
> >> > +			pci-ep-bus@0 {
> >> > +				compatible = "simple-bus";
> >> > +				#address-cells = <1>;
> >> > +				#size-cells = <1>;
> >> > +
> >> > +				/*
> >> > +				 * map @0xe2000000 (32MB) to BAR0 (CPU)
> >> > +				 * map @0xe0000000 (16MB) to BAR1 (AMBA)
> >> > +				 */
> >> > +				ranges = <0xe2000000 0x00 0x00 0x00 0x2000000
> >> > +				          0xe0000000 0x01 0x00 0x00 0x1000000>;    
> >> 
> >> I was wondering about how this fits into the PCI DT
> >> binding, is this a child of the PCI device, or does the
> >> "pci-ep-bus" refer to the PCI device itself?  
> >
> > This is a child of the PCI device.
> > The overlay is applied at the PCI device node and so, the pci-ep-bus is
> > a child of the PCI device node.  
> 
> Ok
> 
> > 				/*
> > 				 * Ranges items allow to reference BAR0,
> > 				 * BAR1, ... from children nodes.
> > 				 * The property is created by the PCI core
> > 				 * during the PCI bus scan.
> > 				 */
> > 				ranges = <0x00 0x00 0x00 0x82010000 0x00 0xe8000000 0x00 0x2000000
> > 					  0x01 0x00 0x00 0x82010000 0x00 0xea000000 0x00 0x1000000
> > 					  0x02 0x00 0x00 0x82010000 0x00 0xeb000000 0x00 0x800000  
> 
> >
> > Hope this full picture helped to understand the address translations
> > involved.  
> 
> Right, that makes a lot of sense now, I wasn't aware of those
> range properties getting set. Now I have a new question though:
> 
> Is this designed to work both on hosts using devicetree and on
> those not using it? If this is used on devicetree on a board
> that has a hardwired lan966x, we may want to include the
> overlay contents in the board dts file itself in order to
> describe any possible connections between the lan966x chip
> and other onboard components such as additional GPIOs or
> ethernet PHY chips, right?
> 
>       Arnd

On host with the base hardware described without device-tree (ACPI on
x86 for instance), I have a couple of patches not yet sent upstream.
With those patches, I have a the LAN966x PCI board working on x86.
I plan to send them as soon as this series is applied.

Rob said that before looking at ACPI, we need to have a working system
on DT based systems.
  https://lore.kernel.org/all/CAL_JsqKNC1Qv+fucobnzoXmxUYNockWR=BbGhds2tNAYZWqgOA@mail.gmail.com/

If hardwired on a board, the same LAN966x PCI driver could be used.
A possible improvement of the driver could be to request the overlay
from the user-space using request_firmware().
With that, the overlay can be extended with specific onboard parts the
LAN966x PCI device is connected to.

This improvement can be done later when the use case appears.

Best regards,
Hervé

