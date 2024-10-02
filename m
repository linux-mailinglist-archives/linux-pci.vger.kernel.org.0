Return-Path: <linux-pci+bounces-13710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B16B98D109
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 12:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EAA2284692
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 10:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3811CEE98;
	Wed,  2 Oct 2024 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kuVp1nDN"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D77194AFE;
	Wed,  2 Oct 2024 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727864408; cv=none; b=rgdNMYjmPVW2q1wqZc+OJG/QmzuDbCM0hx6oPQBK8xSI+r8kjG3juxBz71zLtw/PxiubOWM3O/I9uangnPQNiH0af/+U0LObjfCSvJgOgrOdk1lOGcoVqBu60woD598pmtc2SwCtxXQcYnZbqPWltqKAn77rDX47HKQRQDfs4YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727864408; c=relaxed/simple;
	bh=spporCEuuqaLQHIllwZn/rEyv+ce3d3Uw4ieOTkMQ4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbsPjhltq28+sAK5UYLqyUfHCEACWaDaI2cdqeNBLlkUOQus3OjpIpz8iPVS8XrCndxSd5R4PSlzUcNNwQaTz6Q2VefC/tGGj+HMbPJnF07f7ajtOUpmX++s4Ne7X227gxdmygYtzt+pldZsoGk7XoqLz4fpC0L9WGeqRlxhysk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kuVp1nDN; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 489451BF203;
	Wed,  2 Oct 2024 10:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727864402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1YkZWklw874sJSFjl4cJH9cXJK3orr7YNOO08V6uy0E=;
	b=kuVp1nDNd5O1mXz+J9aoIJJCfxxZUHR2U8mvD0mG0+NuADt8G7pVl0N2hKb5ZV8a0RgR8e
	ttNEPpX92g5RGfek90DE7wZWueREOem4Qf7bULa/5BPggAMYI9wiopQK+ZoP/nJOb2og46
	sxRMLxUqYXex3teddVysf8vFX3UpdhC+tTPRdsGUIq7Oh1SqOyKinQa8+qcwB8/9p1iQ1N
	yvUUSpTmZt4MAeT0duKEkWedm9o/rrEcwQ947rWZziQgnLqhDcrf5S/lFr/jxGdnV5I0OJ
	Yfp6meHyMqfQi6SfPObkTT2FWQYrjVTZT8SkhOndhJF8WrJzqZGoKOphaP1p6A==
Date: Wed, 2 Oct 2024 12:19:57 +0200
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
Message-ID: <20241002121957.1f10bf8e@bootlin.com>
In-Reply-To: <bd40a139-6222-48c5-ab9a-172034ebc0e9@app.fastmail.com>
References: <20240930121601.172216-1-herve.codina@bootlin.com>
	<20240930121601.172216-3-herve.codina@bootlin.com>
	<d244471d-b85e-49e8-8359-60356024ce8a@app.fastmail.com>
	<20240930162616.2241e46f@bootlin.com>
	<20241001183038.1cc77490@bootlin.com>
	<bd40a139-6222-48c5-ab9a-172034ebc0e9@app.fastmail.com>
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

On Wed, 02 Oct 2024 09:29:35 +0000
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Tue, Oct 1, 2024, at 16:30, Herve Codina wrote:
> > On Mon, 30 Sep 2024 16:26:16 +0200
> > Herve Codina <herve.codina@bootlin.com> wrote:
> > --- 8< ---
> >
> > In mchp_sparx5_map_syscon(), I will call the syscon API or the local
> > function based on the device compatible string:
> > 	--- 8< ---
> > 	if (of_device_is_compatible(pdev->dev.of_node, 
> > "microchip,lan966x-switch-reset"))
> > 		regmap = mchp_lan966x_syscon_to_regmap(&pdev->dev, syscon_np);
> > 	else
> > 		regmap = syscon_node_to_regmap(syscon_np);
> > 	--- 8< ---
> >
> > Is this kind of solution you were expecting?
> > If you have thought about something different, can you give me some pointers?  
> 
> Hi Hervé,
> 
> The way I had imagined this was to not need an if() check
> at all but unconditionally map the syscon registers in the
> reset driver.
> 
> The most important part here is to have sensible bindings
> that don't need to describe the difference between PCI
> and SoC mode. This seems fine for the lan966x case, but
> I'm not sure why you need to handle sparx5 differently here.
> Do you expect the syscon to be shared with other drivers
> on sparx5 but not lan966x?

Thanks for this reply.

Exactly, on sparx5 syscon is shared...
$ git grep 'microchip,sparx5-cpu-syscon'
...
arch/arm64/boot/dts/microchip/sparx5.dtsi:                      compatible = "microchip,sparx5-cpu-syscon", "syscon",
drivers/mmc/host/sdhci-of-sparx5.c:     const char *syscon = "microchip,sparx5-cpu-syscon";
drivers/power/reset/ocelot-reset.c:     .syscon          = "microchip,sparx5-cpu-syscon",
drivers/spi/spi-dw-mmio.c:      const char *syscon_name = "microchip,sparx5-cpu-syscon";
$

> 
> I don't thinkt this bit matters too much and what you suggest
> works fine, I just want to be sure I understand what you are
> doing.
> 
>       Arnd

Best regards,
Hervé

