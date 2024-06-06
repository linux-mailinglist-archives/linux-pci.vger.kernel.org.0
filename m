Return-Path: <linux-pci+bounces-8407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA26A8FF461
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 20:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E041F23E5C
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 18:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFDC199382;
	Thu,  6 Jun 2024 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QiPBf+kf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vMrg0N6/"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B551198E77;
	Thu,  6 Jun 2024 18:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697488; cv=none; b=H3qytlFNfVIgnMxM6ekeauqVpyqOEmN7fShYNLZvieBtjQDjqQbUS15Jbr/8zDVGwkRU4p+FGD82IR+vi+OGe6LFoOsBnmmNEfvo3v67KpLjIa+3WkWDidLTJv5T8GJYvk6uvlHfigXUnhClorhBQ8OITNos7KsXHojoxeSM+kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697488; c=relaxed/simple;
	bh=89Ru1MLL6Cw+HAnFNn4QiwBAQvIvZ9iwfGCkgjAjm7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pE3sKZZcuRwf976zAn7euuEwnfYwZ+glRFFJSxsnyM2n1QBG5WgC/EIjbw5X3TqgCRqiBivOubh7IohxXPc6ynpRkmrVNnHVBhRyRsUpO7iY61Bzbzo99RHr6MyIe5vyE43TvtLeYojpyxoVaclLQXidZVO2V7j+kcfY2r5yloY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QiPBf+kf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vMrg0N6/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717697483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=frfCPswA5SjtUbmGVelHx9IJDTg2Th8/q6fkTUzp43c=;
	b=QiPBf+kfR3zAriOR0mOk1x5Wyxn/wc9za+nQXOB0mLq8Re+DgHNl2AOOWGnZyPM+8MFxBP
	K3j2oKjG+HB3ATQPAJe2U3xPSqVPpY185Gn6Epju80mscIHQiR0kDbKGdrEzxHWoDd7ge6
	5uNiOcMN7/DpKtOhi2IbGTsStdEMQ/M2AQ7VyGkW5TojCbrNUEsUJZXhmoyq/KdTjfM2JP
	XF8ZI7VK0VnDztd9gvLOZvCaAnNdM9yXBal4vnXNM8QrTNBiK9p1O8YIrzFNKXgc9Y9b0t
	+w7H97VK+TzovFRKmD0TOfvttYOGzq8RufL1sh2QGhli5/+5pnosD9NxhSLYow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717697483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=frfCPswA5SjtUbmGVelHx9IJDTg2Th8/q6fkTUzp43c=;
	b=vMrg0N6/F32h/+a1DZ4ylDqXYjFaK+sYf6iWmGib1GdhW3obULexnVUhwOg1Rbes/reboj
	6oT7igbzdKdpZEAA==
To: Herve Codina <herve.codina@bootlin.com>
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
In-Reply-To: <20240606175258.0e36ea98@bootlin.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
 <20240527161450.326615-11-herve.codina@bootlin.com> <8734pr5yq1.ffs@tglx>
 <20240606175258.0e36ea98@bootlin.com>
Date: Thu, 06 Jun 2024 20:11:23 +0200
Message-ID: <87v82m0wms.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Herve!

On Thu, Jun 06 2024 at 17:52, Herve Codina wrote:
> On Wed, 05 Jun 2024 15:02:46 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Mon, May 27 2024 at 18:14, Herve Codina wrote:
>> > To avoid a window where the domain is published but not yet ready to be  
>> 
>> I can see the point, but why is this suddenly a problem? There are tons
>> of interrupt chip drivers which have exactly that pattern.
>
> I thing the issue was not triggered because these interrupt chip driver
> are usually builtin compiled and the probe sequence is the linear one
> done at boot time. Consumers/supplier are probe sequentially without any
> parallel execution issues.
>
> In the LAN966x PCI device driver use case, the drivers were built as
> modules. Modules loading and drivers .probe() calls for the irqs supplier
> and irqs consumers are done in parallel. This reveals the race condition.

So how is that supposed to work? There is clearly a requirement that the
interrupt controller is ready to use when the network driver is probed, no?

>> Also why is all of this burried in a series which aims to add a network
>> driver and touches the world and some more. If you had sent the two irq
>> domain patches seperately w/o spamming 100 people on CC then this would
>> have been solved long ago. That's documented clearly, no?
>
> Yes, the main idea of the series, as mentioned in the cover letter, is to
> give the big picture of the LAN966x PCI device use case in order to have
> all the impacted subsystems and drivers maintainers be aware of the global
> use case: DT overlay on top of PCI device.
> Of course, the plan is to split this series into smaller ones once parts
> get discussed in the DT overlay on top of PCI use case and reach some kind
> of maturity at least on the way to implement a solution.

Fair enough.

> Thomas, do you prefer to have all the IRQ related patches extracted right
> now from this big picture series ?

I think the interrupt controller problem is completely orthogonal to the
PCI/DT issue.

So yes, please split them out as preparatory work which is probably also
not that interesting for the PCI/DT/net folks.

If the template approach holds, then the infrastructure change is
definitely worth it on its own and the actual driver just falls in place
and is off your backlog list.

Thanks,

        tglx

