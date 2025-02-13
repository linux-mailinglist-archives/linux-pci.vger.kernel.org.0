Return-Path: <linux-pci+bounces-21377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369AFA34E17
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 19:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D876C16C8C3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 18:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BCB245AE5;
	Thu, 13 Feb 2025 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QQFIS6Yl"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B0D28A2D4;
	Thu, 13 Feb 2025 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472796; cv=none; b=Yd/OLZcQneDF+M9s+JaOfbqpmZpLmBz3U2ksl1kxBMxlG7UUE3fu1H9DZ/2DQfNOy8+GXYFRN3UgUq/wbOG6qL68CMbk9qzCnrzsmwEJCD3C+gLWukFl2LThl+CeVKPo9s4sjoxe/AHLIv2s6CXTrLOU5tiZFHEbvUZ74Ef9j0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472796; c=relaxed/simple;
	bh=y2OXpJsSi9OIRanlMyx3KWqQShtlGo0AuzXqA9Fbzqc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZMuntwa3+cLGsp2OZzTzLmqOR+WdrSoQrs/7KL0w8Y209N8y4DScxTzJtbOJROIEah/TsqlOXSmVjoa69ggWRLqI8W/5aqZ4Fs84W64dHL/OALjZapoT0YXnqu+A5F7HeLuvQAbKg+fRNUPIGq+0e9tmYAOJJQDva8cul6e1aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QQFIS6Yl; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 44E1E4442E;
	Thu, 13 Feb 2025 18:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739472790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6qH4iFmq2eCsp4gR0alhKpvz8JxjM4NdzNRGitctoQ=;
	b=QQFIS6Yl0SPVIujgU2GPm4v6MzAaeFar1z+P8jxljvArnhEuso+Y/P/qcxiEHDYPns9Oe2
	je9+Kk9CWdf/ZsYEv5gcGV6gh9WpYb42YK62QI6bB0wAUu3we0b6aprTdQJADCNWcrSAwx
	9ycbaUf61H5QU/WHv8hmtogOn+6BAi7kQmiMc7MydcuHs8hj5eRXpVwGOvirzmuVhTb/Xp
	kqAxyCa/lZbEnmksJuVGjvMa1RbnPT5GuzchNsyUEemWs5dhkGjLVNdJ4susBSgI35TH1b
	M6SnAW8+yTKzKsCCoVguJ7nfcytgbsCz4gHn8GfhtBHVrRRIAJoC44hKvft1aw==
Date: Thu, 13 Feb 2025 19:53:04 +0100
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
Message-ID: <20250213195304.3a2df02c@bootlin.com>
In-Reply-To: <CAMEGJJ0QbzCScfTRA_pw_8A=iMYMAAFs69zFNLwcOxF5Syugpw@mail.gmail.com>
References: <CAMEGJJ3=W8_R0xBvm8r+Q7iExZx8xPBHEWWGAT9ngpGWDSKCaQ@mail.gmail.com>
	<20250213171435.1c2ce376@bootlin.com>
	<a3c5103c-829a-4301-ba53-6ef9bd1e74e7@lunn.ch>
	<CAMEGJJ3-JXhin_Ht76EqUNAwLiNisa9PrCrdUzCgj=msGZfb5A@mail.gmail.com>
	<821d4c74-09b0-4c1b-b8ef-f8c08d0f6b5b@lunn.ch>
	<CAMEGJJ0QbzCScfTRA_pw_8A=iMYMAAFs69zFNLwcOxF5Syugpw@mail.gmail.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjeehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffleegleetgedtuddugfffkefhgeeuheeugffhhfetgffhfeehkeejgeelfeetfeenucffohhmrghinheplhhptgdrvghvvghnthhspdhkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgdphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefhedprhgtphhtthhopehphhhilhesrhgrshhpsggvrhhrhihpihdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegrnhgurhgvrgdrphhor
 hhtrgesshhushgvrdgtohhmpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopegstghmqdhkvghrnhgvlhdqfhgvvggusggrtghkqdhlihhsthessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopegsrhhglhessghguggvvhdrphhlpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomh
X-GND-Sasl: herve.codina@bootlin.com

Hi Phil,

On Thu, 13 Feb 2025 17:57:37 +0000
Phil Elwell <phil@raspberrypi.com> wrote:

> On Thu, 13 Feb 2025 at 17:45, Andrew Lunn <andrew@lunn.ch> wrote:
> >  
> > > > Or do you mean a custom board, which has a CPU, RP1 and the button and
> > > > fan are directly on this custom board? You then want a board DTS which
> > > > includes all these pieces?  
> > >
> > > That depends on whether you count the Raspberry Pi 5 as a custom board.  
> >
> > So you mean the Pi 5 board would itself make use of the resources the
> > RP1 device has? They are not simply connected to headers for plugin
> > boards, but used by the main board? Hence you want to describe them in
> > the board .DTS file.  
> 
> That's correct. But even for plug-in devices, those which are on
> non-discoverable buses need overlays to declare them, which causes a
> problem when the overlay application happens before the kernel is
> started.
> 

Hum, I see.

We worked on overlay usage on non-discoverable buses wired to a connector
and we did a talk about issues we are facing on at Plumber [0].

You can also find our big picture in [1] and a last contribution introducing
export-symbols feature in [2]. export-symbols is also under discussion on
some other threads.

Also, we proposed the i2c bus extensions feature [3] whose goal is to allow
an addon board to add devices on an i2c bus provided by a base board and
wired to an connector the addon board is connected to.

Maybe in your case, you can decouple resources (gpio, pwm) provided by the
addon board and used by the base board using also nexus node.

We use a nexus node [4] (not presented at the Plumbers talk because the idea
came during 'out of talk' discussions in Plumbers) in order to allow our
addon board to use resources provided by the base board.

In your case, if I understood, you are in the other direction but why not
using also a nexus node to decouple and translate resources in this other
direction ?

Don't know if this idea can help but feel free to ask for some more
information if needed.

[0] https://lpc.events/event/18/contributions/1696/
[1] https://lore.kernel.org/lkml/20240917-hotplug-drm-bridge-v4-0-bc4dfee61be6@bootlin.com/
[2] https://lore.kernel.org/all/20241209151830.95723-1-herve.codina@bootlin.com/
[3] https://lore.kernel.org/all/20250205173918.600037-1-herve.codina@bootlin.com/
[4] https://github.com/devicetree-org/devicetree-specification/blob/v0.4/source/chapter2-devicetree-basics.rst#nexus-nodes-and-specifier-mapping

Best regards,
Hervé

