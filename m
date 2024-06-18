Return-Path: <linux-pci+bounces-8919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D795F90D96E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 18:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0746B23FB2
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 15:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DD42E3F2;
	Tue, 18 Jun 2024 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GH1xLuWs"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08645D299;
	Tue, 18 Jun 2024 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726148; cv=none; b=FJKeQibxLPNyZs/aphdNVHzB58FCGviQhlXjAipYvBqImlZtYrYI9QPzy/5Vl6ntYbMBJTNojMzvg1wuUTnarXJEadVODJ3t4VoLCw/NPLGkykNn8D8P+M5qeqM+7595IVQ9u1NSXjliuzEs0KJeaIshFNpxlsj+5HZABWc8bXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726148; c=relaxed/simple;
	bh=lhjj25VP5M4sTOzHNNjscKcLGzs0m0KUFagNmmsLVCY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndhp3YFugIpjo7o4053ZIYxfPCjVRPDwuVKXFAylRmw6lG9VknPeQQH8ByZrIXJiAjapzgyhkGcipa8qqfRT2zRqhbNxn8XkKbhu6zgvZgAgEWxWXPr8DGSSkfH07SjkqI734JcNyZoRFrL8ecrGE9wfk3DF4aoOuuYjXFann7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GH1xLuWs; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 833B11BF204;
	Tue, 18 Jun 2024 15:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718726137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2KE/O5mxQyzYGqNyk0NZy+aO7Wf1mUhJbeharOTLWU=;
	b=GH1xLuWsQxAhseqDqFHZLD/PAHYZJjFDGtEsCC1ScJeUUlB6N1r9kc7jpvEKmvzMil1ZLw
	N7wVAJzKpSnPXXL/hbSWtz0+ILKsU1RIIZRu/IrIfG75FCcKItUgfR+M54pq6bbI7L4dtr
	IX0N3HpabnDfVqLo0OzGu7jQVD00B2p5g9HSkO5PrG0kZdPRe1U3u/NepoJIeZqKetZj43
	L5QZaneld0T0Npc8RpVNG6z6+EdYPoreOCeTyULCfvm6IJEp3OOJTx8tqRAoZVp5vYufPZ
	JeobUn7bnS1yOLi9zePgor/7ilQKJspTnQn9BfPegr1Wx3fffcDxqFTbXCIZIQ==
Date: Tue, 18 Jun 2024 17:55:33 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Simon Horman" <horms@kernel.org>, "Sai Krishna Gajula"
 <saikrishnag@marvell.com>, "Thomas Gleixner" <tglx@linutronix.de>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Lee Jones"
 <lee@kernel.org>, "Horatiu Vultur" <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, "Andrew Lunn" <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, "Russell King" <linux@armlinux.org.uk>,
 "Saravana Kannan" <saravanak@google.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Philipp Zabel" <p.zabel@pengutronix.de>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, "Steen Hegelund"
 <Steen.Hegelund@microchip.com>, "Daniel Machon"
 <daniel.machon@microchip.com>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Allan
 Nielsen" <allan.nielsen@microchip.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Clement Leger" <clement.leger@bootlin.com>
Subject: Re: [PATCH v2 01/19] mfd: syscon: Add reference counting and device
 managed support
Message-ID: <20240618175533.3e1534ca@bootlin.com>
In-Reply-To: <b685d5e5-09d3-4916-ad0b-d329c166e149@app.fastmail.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
	<20240527161450.326615-2-herve.codina@bootlin.com>
	<b685d5e5-09d3-4916-ad0b-d329c166e149@app.fastmail.com>
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

Hi Arnd,

On Tue, 18 Jun 2024 16:53:30 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Mon, May 27, 2024, at 18:14, Herve Codina wrote:
> > From: Clément Léger <clement.leger@bootlin.com>
> >
> > Syscon releasing is not supported.
> > Without release function, unbinding a driver that uses syscon whether
> > explicitly or due to a module removal left the used syscon in a in-use
> > state.
> >
> > For instance a syscon_node_to_regmap() call from a consumer retrieve a
> > syscon regmap instance. Internally, syscon_node_to_regmap() can create
> > syscon instance and add it to the existing syscon list. No API is
> > available to release this syscon instance, remove it from the list and
> > free it when it is not used anymore.
> >
> > Introduce reference counting in syscon in order to keep track of syscon
> > usage using syscon_{get,put}() and add a device managed version of
> > syscon_regmap_lookup_by_phandle(), to automatically release the syscon
> > instance on the consumer removal.
> >
> > Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>  
> 
> This all looks correct from an implementation perspective,
> but it does add a lot of complexity if now every syscon user
> feels compelled to actually free up their resources again,
> while nothing else should actually depend on this.
> 
> The only reference I found in your series here is the
> reset controller, and it only does a single update to
> the regmap in the probe function.
> 
> Would it be possible to just make the syscon support in
> the reset driver optional and instead poke the register
> in the mfd driver itself when this is used as a pci device?
> Or do you expect to see the syscon get used in other
> places in the future for the PCI case?
> 

IMHO, I don't think that poking the register in the mfd driver and so
avoiding syscon usage is the right solution.

Indeed, additional devices can be added in the DT overlay and an other
syscon user can be present.

Also, overlays can be used on other PCI devices in the future and these PCI
devices can use drivers that are syscon users. In that case, the same kind
of workaround will be needed and maybe a quite more complex one depending on
syscon users.

The root issue is that syscon does not support removal.
I prefer fixing this root issue instead of finding a kind of workaround.

Even if all syscon users are not fixed right now (and probably don't need to
be fixed), a solution with the new devm_syscon_regmap_lookup_by_phandle() is
available and drivers that need to release their resources because of a
device removal can easily move to devm_syscon_regmap_lookup_by_phandle().

Best regards,
Hervé

