Return-Path: <linux-pci+bounces-13692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFFC98C36F
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 18:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4038B20A60
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 16:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35671CB32B;
	Tue,  1 Oct 2024 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KjYYpFsh"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF25A199FA2;
	Tue,  1 Oct 2024 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800245; cv=none; b=IhsYFu7jIvek+qD0iDB0XtuFnaG1zBbUuLBfv5b1VS1TA29L8p2S1aBeMN289p2cjIFeHPC9AXbLxykE7zzx1Az7FrCSZpqurC4kbWo+wdePN0SqAOnGG/ht8Q/f8Z6Ncwg8wP1Dnq2AgmJCEe0DXqe4pwBEzMcSCge8j+jpxTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800245; c=relaxed/simple;
	bh=gO2a8NpNvEzPvmNdPJOINMH8UT49BGk59qtCGnLM3aM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucIvG+HkiOzcKkcnlJI0uBLv7dN6kdZOOTw9BFVBoZKnekNkjxJWRoOPjfy9qjepXNfOWaH7iqZ59ZvduC4B07fQVitDn0GK5rwsStQfF+5PZbtsiGZtMivfV5WRrJCrinjbGCSX5WrtdNw/3lLrFwT0G6Bfg0WN9Iw+DfbrI/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KjYYpFsh; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 409204000C;
	Tue,  1 Oct 2024 16:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727800241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7nmRTjp1SB1MhQFXSfZS6mrJAanty1clfcbgm2V8i0Q=;
	b=KjYYpFsh5vAeiZ8/qraFTJOl3DzdjMcEdZ06XtJiQ8tRvijNBBmZv8HPe954qKTAimuk6b
	ccLFmE9YzYEoFZLCM2fs07NOBM31NBwEgCndFX9p4hSdVLnGmapOCw7coPshQpnRbWKRqv
	cEFfpOnOMdWINObXcvSxP+Ijbyk18g2EwgMNRUWmSRY7PIBAsBLFpN7RkSqw/upxPy1aoq
	NS6HiPLVhekYZpVMxCMxyV0sZOqnfCDFiYx4bqMbhMtxttmD1b/YDSJoqtPCnv8byj3Syf
	tF17cZItac0dIKbcuGt6wrVGWv+zE8jaK4Z2Y5RoJRWmIuy9qr8+IL0QsqLMeQ==
Date: Tue, 1 Oct 2024 18:30:38 +0200
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
Subject: Re: [PATCH v6 2/7] reset: mchp: sparx5: Use the second reg item
 when cpu-syscon is not present
Message-ID: <20241001183038.1cc77490@bootlin.com>
In-Reply-To: <20240930162616.2241e46f@bootlin.com>
References: <20240930121601.172216-1-herve.codina@bootlin.com>
	<20240930121601.172216-3-herve.codina@bootlin.com>
	<d244471d-b85e-49e8-8359-60356024ce8a@app.fastmail.com>
	<20240930162616.2241e46f@bootlin.com>
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

Hi Arnd,

On Mon, 30 Sep 2024 16:26:16 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> On Mon, 30 Sep 2024 13:57:01 +0000
> "Arnd Bergmann" <arnd@arndb.de> wrote:
> 
> > On Mon, Sep 30, 2024, at 12:15, Herve Codina wrote:  
> > > In the LAN966x PCI device use case, syscon cannot be used as syscon
> > > devices do not support removal [1]. A syscon device is a core "system"
> > > device and not a device available in some addon boards and so, it is not
> > > supposed to be removed.
> > >
> > > In order to remove the syscon usage, use a local mapping of a reg
> > > address range when cpu-syscon is not present.
> > >
> > > Link: https://lore.kernel.org/all/20240923100741.11277439@bootlin.com/ [1]
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > ---    
> >   
> > >>  	err = mchp_sparx5_map_syscon(pdev, "cpu-syscon", &ctx->cpu_ctrl);    
> > > -	if (err)
> > > +	switch (err) {
> > > +	case 0:
> > > +		break;
> > > +	case -ENODEV:    
> > 
> > I was expecting a patch that would read the phandle and map the
> > syscon node to keep the behavior unchanged, but I guess this one
> > works as well.
> > 
> > The downside of your approach is that it requires an different
> > DT binding, which only works as long as there are no other
> > users of the syscon registers.  
> 
> Yes, I knwow but keeping the binding with the syscon device (i.e. compatible
> = "...", "syscon";) leads to confusion.
> Indeed, the syscon API cannot be used because using this API leads issues
> when the syscon device is removed.
> That means the you have a "syscon" node (compatible = "syscon") but we cannot
> use the syscon API (include/linux/mfd/syscon.h) with this node.
> 
> Also, in order to share resources between several consumers of the "syscon"
> registers, we need exactly what is done in syscon. I mean we need to map
> resources only once, provide this resource throught a regmap an share this
> regmap between the consumers. Indeed a lock needs to be shared in order to
> protect against registers RMW accesses done by several consumers.
> In other word, we need to copy/paste syscon code with support for removal
> implemented (feature needed in the LAN966x PCI device use case).
> 
> So, I found really simpler and less confusing to fully discard the syscon node
> and handle registers directly in the only one consumer.
> 
> With all of these, do you thing my approach can be acceptable ?
> 

Well, the related binding has been rejected.

In the next iteration, I will keep the syscon node and implement what you
suggested (i.e. read the phandle and map the syscon node).

This will look like this:
--- 8< ---
static const struct regmap_config mchp_lan966x_syscon_regmap_config = {
       .reg_bits = 32,
       .val_bits = 32,
       .reg_stride = 4,
};

static struct regmap *mchp_lan966x_syscon_to_regmap(struct device *dev,
       	                                           struct device_node *syscon_np)
{
       struct regmap_config regmap_config = mchp_lan966x_syscon_regmap_config;
       resource_size_t size;
       void __iomem *base;

       base = devm_of_iomap(dev, syscon_np, 0, &size);
       if (IS_ERR(base))
               return ERR_CAST(base);

       regmap_config.max_register = size - 4;

       return devm_regmap_init_mmio(dev, base, &regmap_config);
}
--- 8< ---

In mchp_sparx5_map_syscon(), I will call the syscon API or the local
function based on the device compatible string:
	--- 8< ---
	if (of_device_is_compatible(pdev->dev.of_node, "microchip,lan966x-switch-reset"))
		regmap = mchp_lan966x_syscon_to_regmap(&pdev->dev, syscon_np);
	else
		regmap = syscon_node_to_regmap(syscon_np);
	--- 8< ---

Is this kind of solution you were expecting?
If you have thought about something different, can you give me some pointers?

Best regards,
Hervé


