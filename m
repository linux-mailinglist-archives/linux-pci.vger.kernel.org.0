Return-Path: <linux-pci+bounces-21360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6737BA3496A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 17:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE329188BE65
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 16:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF5F1FFC5C;
	Thu, 13 Feb 2025 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o/ragaeq"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E96D155326;
	Thu, 13 Feb 2025 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463283; cv=none; b=Ba/sOifu0MnOPiDwu8Jz7IYi9GG6+m7OSG8QJp4uaq7FXt1n3sBCqIk2+BbvUEom9ucAZzpIAFg0M1GFjolBms0RQuRLkRhnMo7kTFxXKMbaOiljCckOsrKpvNxDHbuuaLLAtj4bt2cuQnF0U6duGlU9Rw8pCSPfEjcqP1h0lK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463283; c=relaxed/simple;
	bh=vGJnb1m4SzGUIvD8C7Q70RDN83mTiA+BJaGjQwL7LEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uuOACICQBD7QZc41KJo4DNMVeNA3Sm5/SOG5ME0ILN3VXAMDSPboIt2lOnL2vCG9xDuATwC/EIn5idZ6TDEiKPPygnsxjv4hf0Qy4/tAMohsiydIBNRcv8Qum01JSa199dFDpzigxrYCbJZFCmExn7FVUYMUjizgopA9EoyMC3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o/ragaeq; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25360441D0;
	Thu, 13 Feb 2025 16:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739463278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0TVSfnhO/D9vf7kVKocZCtgHhLvkRIYScp2kiZ0Rn5s=;
	b=o/ragaeqE14+pkiUyeerhxStHnHzUEuBaR1MDzBW+7wdy/u3tp+KketwFkv6a1sl29X91R
	bazTwFPopWFSaJGSUnKpDZQLBGOmVuo2ndmrlnYUDCz/CfzWgQ3cFrXnEsLh/o5rj6Vzn4
	VVkvrSy7CFWtMgXit8j7dBcts6buJjY42hvgI8s8rJOqOX6cPCwaWN1Rs4f9k222J2ouyg
	g8hqm/3JkLHGpxJAL0LWtcSlVMlhaRHgSzcKAdhZtP9y9aopwC7UfNpKr9ixsbQlI3cumA
	81i+wvtWy8TucWElCaV+3PwElF+2fBxbpdNArU7gYJqnCwdZinWA3a/2fuPrjw==
Date: Thu, 13 Feb 2025 17:14:35 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Phil Elwell <phil@raspberrypi.com>
Cc: Andrea della Porta <andrea.porta@suse.com>, andrew@lunn.ch, Arnd
 Bergmann <arnd@arndb.de>, "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
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
Message-ID: <20250213171435.1c2ce376@bootlin.com>
In-Reply-To: <CAMEGJJ3=W8_R0xBvm8r+Q7iExZx8xPBHEWWGAT9ngpGWDSKCaQ@mail.gmail.com>
References: <CAMEGJJ3=W8_R0xBvm8r+Q7iExZx8xPBHEWWGAT9ngpGWDSKCaQ@mail.gmail.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjedvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeviefffeegiedtleelieeghfejleeuueevkeevteegffehledtkeegudeigffgvdenucfkphepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfeehpdhrtghpthhtohepphhhihhlsehrrghsphgsvghrrhihphhirdgtohhmpdhrtghpthhtoheprghnughrvggrrdhpohhrthgrsehsuhhsvgdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtoheps
 ggtmhdqkhgvrhhnvghlqdhfvggvuggsrggtkhdqlhhishhtsegsrhhorggutghomhdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhm
X-GND-Sasl: herve.codina@bootlin.com

Hi Phil,

On Thu, 13 Feb 2025 15:18:45 +0000
Phil Elwell <phil@raspberrypi.com> wrote:

> Hi Andrea,
> 
> The problem with this approach (loading an overlay from the RP1 PCIe
> driver), and it's one that I have raised with you offline, is that
> (unless anyone can prove otherwise) it becomes impossible to create a
> Pi 5 DTS file which makes use of the RP1's resources. How do you
> declare something as simple as a button wired to an RP1 GPIO, or fan
> connected to a PWM output?

The driver could be improved in a second step.
For instance, it could load the dtbo from user-space using request_firmare()
instead of loading the embedded dtbo.

> 
> If this is the preferred route to upstream adoption, I would prefer it
> if rp1.dtso could be split in two - an rp1.dtsi similar to what we
> have downstream, and an rp1.dtso that #includes it. In this way we can
> keep the patching and duplication to a minimum.

Indeed, having a rp1.dtsi avoid duplication but how the rp1.dtso in
the the kernel sources could include user customization (button, fan, ...)
without being modified ?
At least we have to '#include <my_rp1_customizations.dtsi>'.

Requesting the dtbo from user-space allows to let the user to create
its own dtso without the need to modify the one in kernel sources.

Does it make sense ?

Best regards,
Hervé

