Return-Path: <linux-pci+bounces-7420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A8F8C40D9
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 14:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876B51F2299F
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 12:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA7314F9E5;
	Mon, 13 May 2024 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HXv3Gdot"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27F573502;
	Mon, 13 May 2024 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715603851; cv=none; b=M6/s0jFDfjcM7gnJ7OCJ2ypxRJ7zO/zQ77s/jRNOcLHIJMh50UYK0wVRUHtNZxqcLqL2e1dd7hMBivNzTvBlj2/08OgnkJvVohotVF0/AVdArbDufTTAq3lWDu0vwEIISNGJgtIEJd9SkPLb/vnmE9BARfuq4KQTG+IW1g5OwK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715603851; c=relaxed/simple;
	bh=nl1DpT1BDZi8DFXU9HIaI+on9YNafC0xihrZQMTvP+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1A4OZBIC+1vBsbpNS8Xr2IsDt4Wqn5tTIxx+cO9oecaVZkx+5+iv8y4JY7Zba+AbaAp0hhYSYRAGtI9AbZu+8h/6/OZzFe09jPzBW7TedM1DjQAldPA3sKqZN2CgsoTnkzJy49r4GwQZwLM72ZoCnLfrEIM/g6bR3ajltAb5rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HXv3Gdot; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3EEE64000F;
	Mon, 13 May 2024 12:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715603845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7Y92ld/TlnX/m+7U7B7yO+h4PpB1aDrcf1Fi2kJ1+A=;
	b=HXv3GdotVSbWET4GN1hq1ZyvMDQmZLcu45Xg3CgPRLPMvDnVo4WW7OO6bodJg3SrXuYlMz
	izc0mDKH98w4uSZbDRP6vejT7yJC5lO33vJxbMVmlMCLuKMDMEnLUoV/X6Kwi1sPDj9Hkt
	rKg7ZS26oHIKxUcbx5v6RzEa+HQovtNgMB1R+f0/YrfMhFyk4FwOP9EMBPs1TowUV0F6Ha
	lNJKbFM4tj6gfvovWzZZITOFYDxHOntbmHQHSDTsrs5zFSfjqtJaNp9rwHqP8/oXRnTEIE
	Hp14hgbGqPl+kAULT87uKZKHmQAjtINh/VbNvftb9XIPz9mJX5s+gDem/nH3uA==
Date: Mon, 13 May 2024 14:37:20 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lee Jones
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
Subject: Re: [PATCH 09/17] dt-bindings: interrupt-controller: Add support
 for Microchip LAN966x OIC
Message-ID: <20240513143720.1174306a@bootlin.com>
In-Reply-To: <20240507152806.GA505222-robh@kernel.org>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
	<20240430083730.134918-10-herve.codina@bootlin.com>
	<20240507152806.GA505222-robh@kernel.org>
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

Hi Rob,

On Tue, 7 May 2024 10:28:06 -0500
Rob Herring <robh@kernel.org> wrote:

...
> > +examples:
> > +  - |
> > +    interrupt-controller@e00c0120 {
> > +        compatible = "microchip,lan966x-oic";
> > +        reg = <0xe00c0120 0x190>;  
> 
> Looks like this is part of some larger block?
> 

According to the registers information document:
  https://microchip-ung.github.io/lan9662_reginfo/reginfo_LAN9662.html?select=cpu,intr

The interrupt controller is mapped at offset 0x48 (offset in number of
32bit words).
-> Address offset: 0x48 * 4 = 0x120
-> size: (0x63 + 1) *  4 = 0x190

IMHO, the reg property value looks correct.

Best regards,
Hervé

