Return-Path: <linux-pci+bounces-8433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94408FFDC8
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 10:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E5F9B21E7C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 08:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EDC15AD9A;
	Fri,  7 Jun 2024 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PH0J6+8z"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991A913C69B;
	Fri,  7 Jun 2024 08:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717747577; cv=none; b=QKatUUWifn/uTNSvXp+S3DiiJE1PnISy/HG7z/KiCKr7zE6Ymdo+n/stIuyLuOnfmc/6B1h3/Y3IQFYiDuEOqIRerV/cUD8aLf67IGCfqpPDRybvzIgojQZR2Tfxg7OF0FE28k0sLYXFY/Co3UFyKe5JidRdyH1Sg7awaSovAFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717747577; c=relaxed/simple;
	bh=D+/UALLSv9oy4xrGrHjWW+E2Ia6tzKVJHvFUaGkGlwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwiMoYODoGp5ua/dw5uCnvN/2vwxbstHqeFudM1qtnXT+P+JII+4BfO0nnPcR1KBalbV1I0gxp3MwuQoH4ANNPRa8OCHdU4eobYoSF3COWlG7BxZKQDnNEnzD2MGXWiN/9bZ+Uh6083yd9jFqShFyrs6dasEVk8edTCBkTAmH18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PH0J6+8z; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A06D1C0007;
	Fri,  7 Jun 2024 08:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717747571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFfuVjtrcTLRobaSH0psf6/I1QuxZBKYWSnIuQ5XmGY=;
	b=PH0J6+8ztUFADaSZDGfHF5vJoDDUoehBQuL0rnhj6Ma8m2WkOuDaQiNIaA7QAPzuAC1Ym9
	GoJdsST2eUkSP8+5iY6JrMym0qUGpiy+NqNvGnDi+/L49RlwfebD6AxcnAiQIhiyPo+sPs
	ajtCZg98h/of8iYKa75/kDuP5ls7hcE1d8j758hYYQ8MpanGim680eb9TxamL8H6JzRxnP
	gt8wsuEyueFEr94ynXLWrQvXsj+ef5qT1UD4y3ELSK4SGXLaHWnnqFYD2OmJXNu74GMXud
	afFFmhjBoHAjvKS8ge/I1ku3JNZnqjBXujksJ/hOOc/g1AVw2yxw+zgk106yLg==
Date: Fri, 7 Jun 2024 10:06:03 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Simon Horman <horms@kernel.org>, Sai Krishna Gajula
 <saikrishnag@marvell.com>, Rob Herring <robh@kernel.org>, Krzysztof
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
Subject: Re: [PATCH v2 10/19] irqdomain: Introduce irq_domain_alloc() and
 irq_domain_publish()
Message-ID: <20240607100603.660efc87@bootlin.com>
In-Reply-To: <87v82m0wms.ffs@tglx>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
	<20240527161450.326615-11-herve.codina@bootlin.com>
	<8734pr5yq1.ffs@tglx>
	<20240606175258.0e36ea98@bootlin.com>
	<87v82m0wms.ffs@tglx>
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

On Thu, 06 Jun 2024 20:11:23 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> Herve!
> 
> On Thu, Jun 06 2024 at 17:52, Herve Codina wrote:
> > On Wed, 05 Jun 2024 15:02:46 +0200
> > Thomas Gleixner <tglx@linutronix.de> wrote:  
> >> On Mon, May 27 2024 at 18:14, Herve Codina wrote:  
> >> > To avoid a window where the domain is published but not yet ready to be    
> >> 
> >> I can see the point, but why is this suddenly a problem? There are tons
> >> of interrupt chip drivers which have exactly that pattern.  
> >
> > I thing the issue was not triggered because these interrupt chip driver
> > are usually builtin compiled and the probe sequence is the linear one
> > done at boot time. Consumers/supplier are probe sequentially without any
> > parallel execution issues.
> >
> > In the LAN966x PCI device driver use case, the drivers were built as
> > modules. Modules loading and drivers .probe() calls for the irqs supplier
> > and irqs consumers are done in parallel. This reveals the race condition.  
> 
> So how is that supposed to work? There is clearly a requirement that the
> interrupt controller is ready to use when the network driver is probed, no?

Yes, EPROBE_DEFER mecanism.
The race condition window leads to an other error code instead of the
expected EPROBE_DEFER.

> 
> >> Also why is all of this burried in a series which aims to add a network
> >> driver and touches the world and some more. If you had sent the two irq
> >> domain patches seperately w/o spamming 100 people on CC then this would
> >> have been solved long ago. That's documented clearly, no?  
> >
> > Yes, the main idea of the series, as mentioned in the cover letter, is to
> > give the big picture of the LAN966x PCI device use case in order to have
> > all the impacted subsystems and drivers maintainers be aware of the global
> > use case: DT overlay on top of PCI device.
> > Of course, the plan is to split this series into smaller ones once parts
> > get discussed in the DT overlay on top of PCI use case and reach some kind
> > of maturity at least on the way to implement a solution.  
> 
> Fair enough.
> 
> > Thomas, do you prefer to have all the IRQ related patches extracted right
> > now from this big picture series ?  
> 
> I think the interrupt controller problem is completely orthogonal to the
> PCI/DT issue.
> 
> So yes, please split them out as preparatory work which is probably also
> not that interesting for the PCI/DT/net folks.
> 

Will do that.

Best regards,
Hervé

