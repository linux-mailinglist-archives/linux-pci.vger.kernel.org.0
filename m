Return-Path: <linux-pci+bounces-8405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 957AA8FF145
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 17:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1547D285C25
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 15:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAACC197534;
	Thu,  6 Jun 2024 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CHGEsgFQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12F3196C7C;
	Thu,  6 Jun 2024 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689187; cv=none; b=FsQwW8NTo8JBhQTRROPh1s/GS1HES5b9Lx/bfnjZ/bZS789ruVTnW+VwCNJ/urOJ9Vkr8PybW+4Qmu3b4x9p++RgSBUr537nTrMOs8qYTwfQcIKMGKLA4Dwi9Yv9mpvy0bAUEkFQ9HzvK15fkeDkiBrx5+1hJBiBzn0LTbSiS1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689187; c=relaxed/simple;
	bh=tTjASRihTSAqBdBo4miDRMTZLE7izCWc3a5OMOafW7I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUKdSVsartIT9vnrRmndwDNWL7uuC110CBNJzsiuNIFSQM71xJ2WFr13zTnyCL1n4Jb3IomENf0TZoYw2pHVhZGx/nGr7rXuThEGLlfJbTcCQb0mqFzijJudLExupe0z6AN4LCuiVYomzI2sxFmmWqkR/U/XILFnlKwsTanoY1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CHGEsgFQ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B8271BF20C;
	Thu,  6 Jun 2024 15:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717689183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1gsWIzttywwUfj8wVOsf1uZZgWknP5y8TDFvRDuZYk=;
	b=CHGEsgFQhxmgI9kit9UsDWhmeYkm1SMTfF4HSpSA7M8iIVcSVCK/UyOZq6Gy2jZ2rR87iy
	i4WYz6XtCmH99jmROTw+zPCWzvlakd/VZY3uWUitL6Mt0gOFiK65awIY1gDXmquhgHUcQW
	iO3ZNIG1VIWM/NyCMHeGs3p2//LfaVeliifa5/9HOfF7+fgLu+v0nRcnXDd+yJKrmUL19n
	dUhzhZNUZaWDNr8ORmOT+uj1yZFosizfn1V2Xh+hoHzgxLCwWnG0QGXkUct43JfJJ+rGu4
	nU6OLVOZCMEDcgiCpaXDkS6Zkx6JvL154FuLaogp03TvT6quaxAiSbmgDQqBMQ==
Date: Thu, 6 Jun 2024 17:52:58 +0200
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
Message-ID: <20240606175258.0e36ea98@bootlin.com>
In-Reply-To: <8734pr5yq1.ffs@tglx>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
 <20240527161450.326615-11-herve.codina@bootlin.com>
 <8734pr5yq1.ffs@tglx>
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

Hi Thomas,

On Wed, 05 Jun 2024 15:02:46 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, May 27 2024 at 18:14, Herve Codina wrote:
> > The irq_domain_add_*() family functions create an irq_domain and also
> > publish this newly created to domain. Once an irq_domain is published,
> > consumers can request IRQ in order to use them.
> >
> > Some interrupt controller drivers have to perform some more operations
> > with the created irq_domain in order to have it ready to be used.
> > For instance:
> >   - Allocate generic irq chips with irq_alloc_domain_generic_chips()
> >   - Retrieve the generic irq chips with irq_get_domain_generic_chip()
> >   - Initialize retrieved chips: set register base address and offsets,
> >     set several hooks such as irq_mask, irq_unmask, ...
> >
> > To avoid a window where the domain is published but not yet ready to be  
> 
> I can see the point, but why is this suddenly a problem? There are tons
> of interrupt chip drivers which have exactly that pattern.
> 

I thing the issue was not triggered because these interrupt chip driver
are usually builtin compiled and the probe sequence is the linear one
done at boot time. Consumers/supplier are probe sequentially without any
parallel execution issues.

In the LAN966x PCI device driver use case, the drivers were built as
modules. Modules loading and drivers .probe() calls for the irqs supplier
and irqs consumers are done in parallel. This reveals the race condition.

> Also why is all of this burried in a series which aims to add a network
> driver and touches the world and some more. If you had sent the two irq
> domain patches seperately w/o spamming 100 people on CC then this would
> have been solved long ago. That's documented clearly, no?

Yes, the main idea of the series, as mentioned in the cover letter, is to
give the big picture of the LAN966x PCI device use case in order to have
all the impacted subsystems and drivers maintainers be aware of the global
use case: DT overlay on top of PCI device.
Of course, the plan is to split this series into smaller ones once parts
get discussed in the DT overlay on top of PCI use case and reach some kind
of maturity at least on the way to implement a solution.

Thomas, do you prefer to have all the IRQ related patches extracted right
now from this big picture series ?

> 
> >  void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
> > +struct irq_domain *irq_domain_alloc(struct fwnode_handle *fwnode, unsigned int size,
> > +				    irq_hw_number_t hwirq_max, int direct_max,
> > +				    const struct irq_domain_ops *ops,
> > +				    void *host_data);
> > +
> > +static inline struct irq_domain *irq_domain_alloc_linear(struct fwnode_handle *fwnode,
> > +							 unsigned int size,
> > +							 const struct irq_domain_ops *ops,
> > +							 void *host_data)
> > +{
> > +	return irq_domain_alloc(fwnode, size, size, 0, ops, host_data);
> > +}  
> 
> So this creates exactly one wrapper, which means we'll grow another ton
> of wrappers if that becomes popular for whatever reason. We have already
> too many of variants for creating domains.
> 
> But what's worse is that this does not work for hierarchical domains and
> is just an ad hoc scratch my itch solution.
> 
> Also looking at the irq chip drivers which use generic interrupt
> chips. There are 24 instances of irq_alloc_domain_generic_chips() and
> most of this code is just boilerplate.
> 
> So what we really want is a proper solution to get rid of this mess
> instead of creating interfaces which just proliferate and extend it.
> 
> Something like the uncompiled below allows to convert all the
> boilerplate into a template based setup/remove.
> 
> I just converted a random driver over to it and the result is pretty
> neutral in terms of lines, but the amount of code to get wrong is
> significantly smaller. I'm sure that more complex drivers will benefit
> even more and your problem should be completely solved by that.
> 
> The below is just an initial sketch which allows further consolidation
> in the irqdomain space. You get the idea.

Got it, thanks a lot for the idea, the sketch and the way to use it in
drivers. I will rework my patches in that way.

Thanks,
Hervé

