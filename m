Return-Path: <linux-pci+bounces-21365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B283A34B6C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 18:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42FD164178
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 17:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872F9202F61;
	Thu, 13 Feb 2025 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SIO/nQJZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB73202C4C;
	Thu, 13 Feb 2025 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466462; cv=none; b=njKsgs1rW0h/sWLjEcn4/Ff0UURyaMa8HtlPA0ssNJWnKs5cWyII6b2txl1oqL9llTX3Cn1rC6YQPgdFUxbINYHaFFeFCapv6tE/zLSujcGlVVAxMLQXEPfhvgRjfxwir9f4kCkLZ/tmOKCz5qo/V+WTK5UrVhDdS6JArDnDQN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466462; c=relaxed/simple;
	bh=W4OErFGysDwGXaHwpzIF3REBjPTSH176IPgpfA/4uJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dx5pHIT1jWLtPbBA5vVTA+SexOV5kaFHBwYdsWeXkBPkPT4v8W97NoYpcCck7ZrKGZy90JnTkz4GTOGhc4qC1XVIkzGnag4jnwVJ5stM/J3D19mcuxGcNfDGEM4OlTY0yd8w3kiMULLJq8uk6XbWKXBqyRJ8jo+bBIVGWydRD6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SIO/nQJZ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 393344445D;
	Thu, 13 Feb 2025 17:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739466457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkRWv4JP/idAuAK+mR/AdT1Zif8+aeGhHShLWeul7BY=;
	b=SIO/nQJZv43iVUadTFzcCneOf8JkXKitdCkSooThMyMJzhEtByvC05ZJRe+qnJb/hviIcI
	DH1RlVBOcZUqBeq9xEK6DmbHgonpPz9mVKmv4RhCMF9auDacoaHaLoXmEuBwuRv9JFluok
	R+vvrhaltCo9NJVrf1vIjkj1uum3p2wE0077wC72ivgzPLxTyM/tZOoCphmdDWNcgUliLM
	ArcBDF9EmKibqx6ABf+zoGTTDy6zLJFFstjH4YZCudasC5tLxeNCZcnWE4sS3bBeDS/SY6
	FPPv3yskQLPfHk+3OFCdoLIf7LGAA5/lAAvIaGp0Ave040GhGpDoHn4d3HfKIQ==
Date: Thu, 13 Feb 2025 18:07:33 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Phil Elwell <phil@raspberrypi.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrea della Porta
 <andrea.porta@suse.com>, Arnd Bergmann <arnd@arndb.de>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, bhelgaas@google.com,
 brgl@bgdev.pl, Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley
 <conor+dt@kernel.org>, derek.kiernan@amd.com, devicetree@vger.kernel.org,
 dragan.cvetic@amd.com, Florian Fainelli <florian.fainelli@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, krzk+dt@kernel.org,
 kw@linux.com, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "open
 list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>, "moderated list:BROADCOM BCM2711/BCM2835 ARM
 ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
 lpieralisi@kernel.org, luca.ceresoli@bootlin.com,
 manivannan.sadhasivam@linaro.org, masahiroy@kernel.org, Michael Turquette
 <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 saravanak@google.com, Stephen Boyd <sboyd@kernel.org>,
 thomas.petazzoni@bootlin.com, Stefan Wahren <wahrenst@gmx.net>, Will Deacon
 <will@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v6 00/10] Add support for RaspberryPi RP1 PCI device
 using a DT overlay
Message-ID: <20250213180733.11999e07@bootlin.com>
In-Reply-To: <CAMEGJJ3-JXhin_Ht76EqUNAwLiNisa9PrCrdUzCgj=msGZfb5A@mail.gmail.com>
References: <CAMEGJJ3=W8_R0xBvm8r+Q7iExZx8xPBHEWWGAT9ngpGWDSKCaQ@mail.gmail.com>
	<20250213171435.1c2ce376@bootlin.com>
	<a3c5103c-829a-4301-ba53-6ef9bd1e74e7@lunn.ch>
	<CAMEGJJ3-JXhin_Ht76EqUNAwLiNisa9PrCrdUzCgj=msGZfb5A@mail.gmail.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjeeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeviefffeegiedtleelieeghfejleeuueevkeevteegffehledtkeegudeigffgvdenucfkphepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfeehpdhrtghpthhtohepphhhihhlsehrrghsphgsvghrrhihphhirdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtoheprghnughrvggrrdhpohhrthgrsehsuhhsvgdrtghomhdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtoheps
 ggtmhdqkhgvrhhnvghlqdhfvggvuggsrggtkhdqlhhishhtsegsrhhorggutghomhdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhm
X-GND-Sasl: herve.codina@bootlin.com

On Thu, 13 Feb 2025 16:30:44 +0000
Phil Elwell <phil@raspberrypi.com> wrote:

> Hi Andrew,
> 
> On Thu, 13 Feb 2025 at 16:27, Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Thu, Feb 13, 2025 at 05:14:35PM +0100, Herve Codina wrote:  
> > > Hi Phil,
> > >
> > > On Thu, 13 Feb 2025 15:18:45 +0000
> > > Phil Elwell <phil@raspberrypi.com> wrote:
> > >  
> > > > Hi Andrea,
> > > >
> > > > The problem with this approach (loading an overlay from the RP1 PCIe
> > > > driver), and it's one that I have raised with you offline, is that
> > > > (unless anyone can prove otherwise) it becomes impossible to create a
> > > > Pi 5 DTS file which makes use of the RP1's resources. How do you
> > > > declare something as simple as a button wired to an RP1 GPIO, or fan
> > > > connected to a PWM output?  
> >
> > Where is this button or fan? On a pluggable board? Isn't that what
> > overlays are for, and they are stackable. So when you probe the
> > pluggable board via its eeprom etc, you find the overlay and load it?  
> 
> In the Raspberry Pi ecosystem it would be the firmware that applies
> the overlay, and it can't do that if the resources the overlay refers
> to are not yet present in the dtb.

What do you mean by the 'the resources are not yet present in the dtb' ?

Also what you call the 'firmware' is the bootloader ? the kernel ?
Can you tell me who is the 'firmware' what is the mecanisme it uses to
load the overlay.

Best regards,
Hervé


> 
> > Or do you mean a custom board, which has a CPU, RP1 and the button and
> > fan are directly on this custom board? You then want a board DTS which
> > includes all these pieces?  
> 
> That depends on whether you count the Raspberry Pi 5 as a custom board.
> 

