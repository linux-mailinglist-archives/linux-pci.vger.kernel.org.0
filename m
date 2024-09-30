Return-Path: <linux-pci+bounces-13651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ECB98A6F1
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 16:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0F31C2178B
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 14:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069FB190068;
	Mon, 30 Sep 2024 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lJk5Id0U"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BC813D539;
	Mon, 30 Sep 2024 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727706384; cv=none; b=t9OeU5T6vVj/zKMH9cWt0/qxnsqAh4+9riWghhgnfFM95LeShZzhhbckYPTlI8ta1yESEqdRjFGmgZGWap0cTQdIf3JE/jo65IQLR2KFAcY7TruN9tHpanNcQALjTxjmKh4Jtdk+c4JlAmX5ZvtbIxh6uPiAft2L57sRskBie4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727706384; c=relaxed/simple;
	bh=D/K4G0cY8c9Tt7CPwn45PDwSHjjMdVwTLalAuFeMgGc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iu8jjlMfTw1XT+xHKwyc90vW2sQDZEt6MYsPk+u1ITypLDzRFAmB8ltLY9zqnxl5RgbLLaqalA0zwelCoeRxUHTbBb9vPCmSaouMabHZ14uLZzS2WksdNT8C6P1SA/AfUzdQNUwZZgla6qPEHy6yAID+5KM1o9rJL900p+5VaX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lJk5Id0U; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 877491BF203;
	Mon, 30 Sep 2024 14:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727706379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHMb96CYM+I+SvYzsm1sJNO/ARCPSEaKP4XT+TbHTIM=;
	b=lJk5Id0UepP86gzHpP/dlKkKwbypXwcEBW3CFsDfgEeBQifjRwKcN7ldV4IH7iiKc6SheF
	/nI8Pep9ZoT15NkY1KJ2XDfoPvV5TxqWN12eizzTfvlYIb1ZwL74iK59lKnbbTvOjVVDaa
	1nQGU9RgCeQg/W9xEi8UlyhF9jtTd5YvN4o0kcQ1FqeO4IlTYF6wXr3cNYUYo4dcNxX3zD
	ql9MmxvShpL4H432wVUQchnzC3n6LFq48khfjvzg2ITiBneBHmbf2L4WeM6Th90n3SFCDC
	Hmn+SA9CDyq6dkLkKj2G+Jw/kT8BHsEqa6khY+XcggMgeCpjJlyGiJQJ8jW4Nw==
Date: Mon, 30 Sep 2024 16:26:16 +0200
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
Message-ID: <20240930162616.2241e46f@bootlin.com>
In-Reply-To: <d244471d-b85e-49e8-8359-60356024ce8a@app.fastmail.com>
References: <20240930121601.172216-1-herve.codina@bootlin.com>
	<20240930121601.172216-3-herve.codina@bootlin.com>
	<d244471d-b85e-49e8-8359-60356024ce8a@app.fastmail.com>
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

On Mon, 30 Sep 2024 13:57:01 +0000
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Mon, Sep 30, 2024, at 12:15, Herve Codina wrote:
> > In the LAN966x PCI device use case, syscon cannot be used as syscon
> > devices do not support removal [1]. A syscon device is a core "system"
> > device and not a device available in some addon boards and so, it is not
> > supposed to be removed.
> >
> > In order to remove the syscon usage, use a local mapping of a reg
> > address range when cpu-syscon is not present.
> >
> > Link: https://lore.kernel.org/all/20240923100741.11277439@bootlin.com/ [1]
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---  
> 
> >>  	err = mchp_sparx5_map_syscon(pdev, "cpu-syscon", &ctx->cpu_ctrl);  
> > -	if (err)
> > +	switch (err) {
> > +	case 0:
> > +		break;
> > +	case -ENODEV:  
> 
> I was expecting a patch that would read the phandle and map the
> syscon node to keep the behavior unchanged, but I guess this one
> works as well.
> 
> The downside of your approach is that it requires an different
> DT binding, which only works as long as there are no other
> users of the syscon registers.

Yes, I knwow but keeping the binding with the syscon device (i.e. compatible
= "...", "syscon";) leads to confusion.
Indeed, the syscon API cannot be used because using this API leads issues
when the syscon device is removed.
That means the you have a "syscon" node (compatible = "syscon") but we cannot
use the syscon API (include/linux/mfd/syscon.h) with this node.

Also, in order to share resources between several consumers of the "syscon"
registers, we need exactly what is done in syscon. I mean we need to map
resources only once, provide this resource throught a regmap an share this
regmap between the consumers. Indeed a lock needs to be shared in order to
protect against registers RMW accesses done by several consumers.
In other word, we need to copy/paste syscon code with support for removal
implemented (feature needed in the LAN966x PCI device use case).

So, I found really simpler and less confusing to fully discard the syscon node
and handle registers directly in the only one consumer.

With all of these, do you thing my approach can be acceptable ?

Best regards,
Hervé

