Return-Path: <linux-pci+bounces-7011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C00D8B9BA8
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 15:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFAA1C21A57
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 13:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE5713C660;
	Thu,  2 May 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CFPX8R1q"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ABB136983;
	Thu,  2 May 2024 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714656608; cv=none; b=tTannOJzYnL5Zn2sL3cr3OW/QL36t8hwp2wyinkGxwVCPmfyD1Ebm+0EeF10u/N4PliR23HD42TtyyQvyGC5FzHs0TBVSOEOU1scCIQktmg+9hXDuy5WhtjS+v6srDzHm+iih3V2DOMSt32l/NbjYsdC7ZEqkhEhfkLAuswpis0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714656608; c=relaxed/simple;
	bh=PfjUyPZ7cHA7KbStN9u6kyGPZaL+kQ7+YZSzdHDgG3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lTcBhhQWVrNqkGfH8HKBCC4EuhO5ayseUu8IhvMhPGok+1q9vdR8plFsutVB6rjNa3POSlD+AqBGVULhlEbQ1mJKYLMea2vptLU7N2EvsPZlBBfJT2A8YYMnaZTdeE2nrBspPTIciNLZENVU3vM79NPDFasME61jqJpJnG6Xnp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CFPX8R1q; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F48C2000E;
	Thu,  2 May 2024 13:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714656597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vwrm4S0Ih5PpaqUNiO4eRTzk3ezfnoEAdiTyaXRqncI=;
	b=CFPX8R1ql3GnmkhvKGDoe41e+9U+fjRW29kbiW6Ru522JUrZbdmDMT0DZ7DAwBYt2fiLSR
	TkfyrC7BjBWjQMlI8uAloCKWwfuXCQsqAfV9zH+Xe7Ij0PMczXazPWsbx97VccbUCee0bn
	vjkSM7C90klbvF+rix0sWfEIyCn2r3iqwRx7V54N0QWzNCEW6KazMvyvPSLRAg3FLQQp66
	DtksUGHVvle6J3epnv81q0D8nqlxYunBHf+sDdqfr63O/sBQclGyh05EpL5a/UmE/poyDi
	C2zI5dn9CoCNfkm0f6uQa2/IiSkb7Uh5JtbGxPZ7/v8vf+uqm9uSx3Dvu6FuDQ==
Date: Thu, 2 May 2024 15:29:53 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lee Jones <lee@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Saravana
 Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Allan
 Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <clement.leger@bootlin.com>
Subject: Re: [PATCH 01/17] mfd: syscon: Add reference counting and device
 managed support
Message-ID: <20240502152953.75cc502b@bootlin.com>
In-Reply-To: <20240430203443.GG2575892@kernel.org>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
	<20240430083730.134918-2-herve.codina@bootlin.com>
	<20240430203443.GG2575892@kernel.org>
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

Hi Simon,

On Tue, 30 Apr 2024 21:34:43 +0100
Simon Horman <horms@kernel.org> wrote:

...

> > +static intline void syscon_put_regmap(struct regmap *regmap)  
> 
> intline -> inline

Sure, this will be fixed in the next iteration.

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

