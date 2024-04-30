Return-Path: <linux-pci+bounces-6893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C50F8B7BF7
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 17:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68DE71C22BCA
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 15:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029051581E1;
	Tue, 30 Apr 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VMh3nULY"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BF0770F5;
	Tue, 30 Apr 2024 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491657; cv=none; b=VoAODF7EX3AK9dANg3177nulZfnEh1YTMkIpkGuolaInGhz3CoKSPW2CElQK/zqbptvcEZ2IBGBtdjSenwXnQpXjjiaKgLH+zPoTmuOOHUm7BZtEbRCrn4n7OPeCke8EyM9os229vyZqQLuacjsLxgQlf8yFrkBEFV4WBQbL23I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491657; c=relaxed/simple;
	bh=Bqw3IsZ8vcRPqDodfPPnFBRWgVK31l21uLdf4lwzVEM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/Y6zyQ+mC9p6bbQ1rgnDjGPKrDpzJrD0nCDSouu1Yp8EUZhkfVKaQviGMXp/skd6tPmgIZo5hQd4PGZdcijHfGj45r1c2s4wEGd7ZzwWqCa6ZtCEM6B14FFn8VyARi3bzU6e3Mbu/SD1Muqxn5mDn3ucmuYwcM3DXrblM1DC0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VMh3nULY; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4733C1C0003;
	Tue, 30 Apr 2024 15:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714491647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0CBebPXkOcJbQJyeGur7JrerjS7KJc+NjEpyOTbDoI=;
	b=VMh3nULYKBzJIBVAFVTlMWkdIcZ+reJKsiZ0V0jPi72UTrWXlChhWgDXg3eE9SIA85Wl2j
	VczEh72WUPIYeF0/qlHU2dA5NvL58G4x10XgWKFuBVBxgqnhvAx3fJAYfak1fX9mOVzqma
	L7tkgp4biVVl6gyO5P1TGLI0XlALQkbEGUnoOlgZ75P4ycMfbBUnS/dXCjpkbfIylprdWs
	Mma8zxDmSadEn9l2NsiYXyRcHBL04zgrkRe9hKDVtVCGPYKW5y4rQeCXDLq6S9+Yxc8jAY
	V4mP/TKsCe04bwwjflLmyosk8vsxalY7bsE5QxkVnIQdgLYzGaiJZ7WmN8fb5Q==
Date: Tue, 30 Apr 2024 17:40:44 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lee Jones <lee@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Saravana Kannan
 <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>, Steen
 Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Allan
 Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 07/17] net: mdio: mscc-miim: Handle the switch reset
Message-ID: <20240430174044.606c2ed4@bootlin.com>
In-Reply-To: <74e40e5d-e71f-4909-811e-7e9fc1120360@lunn.ch>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
	<20240430083730.134918-8-herve.codina@bootlin.com>
	<74e40e5d-e71f-4909-811e-7e9fc1120360@lunn.ch>
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

Hi Andrew,

On Tue, 30 Apr 2024 15:46:18 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Tue, Apr 30, 2024 at 10:37:16AM +0200, Herve Codina wrote:
> > The mscc-miim device can be impacted by the switch reset, at least when
> > this device is part of the LAN966x PCI device.  
> 
> Just to be sure i understand this correctly. The MDIO bus master can
> be reset using the "switch" reset. So you are adding code to ensure
> the "switch" reset is out of reset state, so the MDIO bus master
> works.

Exactly.

> 
> Given that this is a new property, maybe give it a better name to
> indicate it resets both the switch and the MDIO bus master?
> 

Replied in the patch in the same series introducing the property
  [PATCH 06/17] dt-bindings: net: mscc-miim: Add resets property

Thanks for the feedback.
Best regards,
Hervé

