Return-Path: <linux-pci+bounces-8395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 129288FE406
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 12:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82EE1F23F0E
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 10:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7921194ADF;
	Thu,  6 Jun 2024 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vt+2Tjzz"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C746D1922E6;
	Thu,  6 Jun 2024 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668987; cv=none; b=VlLRJZS+N2nG2KzrQX0owKgfEyXHjw3DllZ5NwhfSlTnFPoBvOWj+WsVZobxJ7+buBvfcGRAQ4O70ZfdFIoRJQ6NXHdpJ7FUTUYrNWwRkcRw9ItxIWaZqn6K+5CDjSAsbUihcDyVo+G8XAXkqAMo5iwvxxCUW0XqDzqFakBk8tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668987; c=relaxed/simple;
	bh=TNXQqXOK0vZauoDoKBlQ1r923hP5FVOWyGW1tQfI9Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ovwdy6GTpWnKD0bRCt3oB2493pl5tLcLESJtoLEaP0BF0W0k786+Ne9jlSAywLwAh6qWrWw8N/QDZzQvN7bmR/FfIxKhIH0taaNXZwG7a1yaCfhW9GgnYkB3W5UphhTqAjkctTYJKbYz32IuVvfrdiFOrFAK72BUWDD7UNyTnbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vt+2Tjzz; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 963CBE000B;
	Thu,  6 Jun 2024 10:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717668982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j2h0D3OMhz7wpGy+JkAY94boI0RbGnCtt4jE0xdb+Is=;
	b=Vt+2TjzzzJf3t9GSoFPTGEhH/bh9FYCKoiqm9LKD05/iRy0oGnTXiwZq+8fALq2tMDJzoa
	WqM5Abq6eMYXx/4e7bFgFfkzsrCDpjCbU5QV75eQnntjcvliOLtY0QvHqJ4Kyc/JNdhUpN
	z9HodfvxYu+xIok0w39tH5PF8ZCH1AnehMDO3h4NAzSBK7PJt+OWCWQlR1S6zwKMpwT7zp
	4IW+wIn5moQjVp+XU/FBA42iRLhVGO2mYIqzk3+2UmBqTmG+N3VFMZjICbX78FSP9dQvWn
	XsySalCA1q4Zi3k1gZZ1eZv6foOXbSqX/GGyTQqM+WEoW1SKvSTeTQIEW4NA8g==
Date: Thu, 6 Jun 2024 12:16:16 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Sai Krishna Gajula
 <saikrishnag@marvell.com>, Thomas Gleixner <tglx@linutronix.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
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
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 09/19] irqdomain: Add missing parameter descriptions
 in docs
Message-ID: <20240606121616.20113726@bootlin.com>
In-Reply-To: <CAHp75Vex7M0htYQiALN3SVy4XHv8bQ-6QQaX21vS_BFF7Sn_Gw@mail.gmail.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
	<20240527161450.326615-10-herve.codina@bootlin.com>
	<ZmDEVoC9NUh7Gg7k@surfacebook.localdomain>
	<20240606091446.03f262fa@bootlin.com>
	<CAHp75Vex7M0htYQiALN3SVy4XHv8bQ-6QQaX21vS_BFF7Sn_Gw@mail.gmail.com>
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

On Thu, 6 Jun 2024 11:46:25 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Jun 6, 2024 at 10:14 AM Herve Codina <herve.codina@bootlin.com> wrote:
> > On Wed, 5 Jun 2024 23:02:30 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> 
> ...
> 
> > Yes indeed, I missed the return values.
> > Will be updated in the next iteration.  
> 
> Note, Thomas already applied this version, so it should be just a follow up.

Indeed, I saw that.

Thanks,
Hervé

