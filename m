Return-Path: <linux-pci+bounces-21658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C8AA38AF4
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 18:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5C21890539
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 17:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF11232363;
	Mon, 17 Feb 2025 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dBGwhhD9"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78150D528;
	Mon, 17 Feb 2025 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739814968; cv=none; b=PL8yLF/ElczI+RTyusGl5SvNucT9XfzTrEsXBkbNEzqplHGetZv4NroUABJ1lyqXHEbYDS5qp/TkVytq+pkgDZnbqhYS3Xih3x+JSL1JvTeeUjo441zfrfZ9/Y2Ir8lQqohXqHyNHdig2g/Kr7tnYcPIzMANvxJzxJYAwTJLL0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739814968; c=relaxed/simple;
	bh=v4d8g6Zss+ZZElac2aEjNvU4+9ul3z2rtSI2buTKt/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ux52ZR2gMlLsp50fK1VFyXlaSa4YtSoHAOiepaPGxq7LmCfxlGGJT2pyL2neJAFxGBIbYcf5jSTbh1IRlBbMX6T8w86CK4bQVKJ8Iv2QEUOX53dmjDmiPzXU6v36Dt6YCftfT8uUP2BlXFNwByZk6+gSLflZqQ3ak1EngqmZB94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dBGwhhD9; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9DF5A442C2;
	Mon, 17 Feb 2025 17:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739814963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+FExaZ6awrhNUR+O/77ICcKPBMvq+e06oZnkz4XEEQ=;
	b=dBGwhhD9TPznMPEScqRh19KvL6CEKEuLzlFafe7E1jnKps3zMUCBrrMRYguWZJLHPI44oV
	ekTkDtdkum0ZeJ6hkcNiQW6qr9z6y0HRLyzv2E2xoHG2N0TUiR3KEr3qiiv523eslP3GZq
	mbfJKM7PvHWK2qZ50LsuyZFxtPAjPqp70A3C84kBw9Mj0ZPcptakpKA7ulM8xWOQbXG2+g
	zxqDOf/ixcKxH8kvhJszWrMu1W1LFZi+o7u+zfWNdnkwQL3JKaID9KGRmNehk0XpsNweNv
	qlZrhiy31AlPoLJw/hDv2uNwsyWJoxEKF80XjMH2xfBJplAxm7aUMO9QpDxYcw==
Date: Mon, 17 Feb 2025 18:55:59 +0100
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
Message-ID: <20250217185559.2e56bd75@bootlin.com>
In-Reply-To: <CAMEGJJ13476pKJb441o5X0Y+rbfromj5-3V-j2KZiOt326OL4A@mail.gmail.com>
References: <CAMEGJJ3=W8_R0xBvm8r+Q7iExZx8xPBHEWWGAT9ngpGWDSKCaQ@mail.gmail.com>
	<20250213171435.1c2ce376@bootlin.com>
	<a3c5103c-829a-4301-ba53-6ef9bd1e74e7@lunn.ch>
	<CAMEGJJ3-JXhin_Ht76EqUNAwLiNisa9PrCrdUzCgj=msGZfb5A@mail.gmail.com>
	<821d4c74-09b0-4c1b-b8ef-f8c08d0f6b5b@lunn.ch>
	<CAMEGJJ0QbzCScfTRA_pw_8A=iMYMAAFs69zFNLwcOxF5Syugpw@mail.gmail.com>
	<20250213195304.3a2df02c@bootlin.com>
	<CAMEGJJ0kGCj=tjM6KswbG_+ZFkzMwPY+06BXCU0qSnbBKz0=ug@mail.gmail.com>
	<20250213220639.373da07b@bootlin.com>
	<CAMEGJJ2_HVKfsE3P22baadbzxSDAX=yTr=m76YuXa5A2cJsJig@mail.gmail.com>
	<20250217165306.3f055b94@bootlin.com>
	<CAMEGJJ13476pKJb441o5X0Y+rbfromj5-3V-j2KZiOt326OL4A@mail.gmail.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehledtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedvhfeljedtfedtjeevffegtddutdeghfettdduhfeuhfdttdffieeuiefgvdfhvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgdphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefhedprhgtphhtthhopehphhhilhesrhgrshhpsggvrhhrhihpihdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegrnhgurhgvrgdrphhorhhtrgesshhushgvrdgtohhmpdhrtghpthhtoheprghrn
 hgusegrrhhnuggsrdguvgdprhgtphhtthhopegstghmqdhkvghrnhgvlhdqfhgvvggusggrtghkqdhlihhsthessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopegsrhhglhessghguggvvhdrphhlpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomh
X-GND-Sasl: herve.codina@bootlin.com

On Mon, 17 Feb 2025 17:03:34 +0000
Phil Elwell <phil@raspberrypi.com> wrote:

> Hi Hervé,
> 
> On Mon, 17 Feb 2025 at 15:53, Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > Hi Phil,
> >
> > On Thu, 13 Feb 2025 21:12:43 +0000
> > Phil Elwell <phil@raspberrypi.com> wrote:
> >  
> > > On Thu, 13 Feb 2025, 21:06 Herve Codina, <herve.codina@bootlin.com> wrote:  
> > > >
> > > > Hi Phil,
> > > >
> > > > On Thu, 13 Feb 2025 20:15:06 +0000
> > > > Phil Elwell <phil@raspberrypi.com> wrote:
> > > >  
> > > > > Once more, with plain text, which I'd hoped the Android GMail client
> > > > > would work out for itself.
> > > > >
> > > > > On Thu, 13 Feb 2025, 18:53 Herve Codina, <herve.codina@bootlin.com> wrote:  
> > > > > >
> > > > > > Hi Phil,
> > > > > >
> > > > > > On Thu, 13 Feb 2025 17:57:37 +0000
> > > > > > Phil Elwell <phil@raspberrypi.com> wrote:
> > > > > >  
> > > > > > > On Thu, 13 Feb 2025 at 17:45, Andrew Lunn <andrew@lunn.ch> wrote:  
> > > > > > > >  
> > > > > > > > > > Or do you mean a custom board, which has a CPU, RP1 and the button and
> > > > > > > > > > fan are directly on this custom board? You then want a board DTS which
> > > > > > > > > > includes all these pieces?  
> > > > > > > > >
> > > > > > > > > That depends on whether you count the Raspberry Pi 5 as a custom board.  
> > > > > > > >
> > > > > > > > So you mean the Pi 5 board would itself make use of the resources the
> > > > > > > > RP1 device has? They are not simply connected to headers for plugin
> > > > > > > > boards, but used by the main board? Hence you want to describe them in
> > > > > > > > the board .DTS file.  
> > > > > > >
> > > > > > > That's correct. But even for plug-in devices, those which are on
> > > > > > > non-discoverable buses need overlays to declare them, which causes a
> > > > > > > problem when the overlay application happens before the kernel is
> > > > > > > started.
> > > > > > >  
> > > > > >
> > > > > > Hum, I see.
> > > > > >
> > > > > > We worked on overlay usage on non-discoverable buses wired to a connector
> > > > > > and we did a talk about issues we are facing on at Plumber [0].
> > > > > >
> > > > > > You can also find our big picture in [1] and a last contribution introducing
> > > > > > export-symbols feature in [2]. export-symbols is also under discussion on
> > > > > > some other threads.
> > > > > >
> > > > > > Also, we proposed the i2c bus extensions feature [3] whose goal is to allow
> > > > > > an addon board to add devices on an i2c bus provided by a base board and
> > > > > > wired to an connector the addon board is connected to.
> > > > > >
> > > > > > Maybe in your case, you can decouple resources (gpio, pwm) provided by the
> > > > > > addon board and used by the base board using also nexus node.
> > > > > >
> > > > > > We use a nexus node [4] (not presented at the Plumbers talk because the idea
> > > > > > came during 'out of talk' discussions in Plumbers) in order to allow our
> > > > > > addon board to use resources provided by the base board.
> > > > > >
> > > > > > In your case, if I understood, you are in the other direction but why not
> > > > > > using also a nexus node to decouple and translate resources in this other
> > > > > > direction ?
> > > > > >
> > > > > > Don't know if this idea can help but feel free to ask for some more
> > > > > > information if needed.  
> > > > >
> > > > > Nexus nodes look interesting - I see them as adding a layer of
> > > > > abstraction such that, for example, boards can declare which of their
> > > > > specific resources performs a common function so that clients can
> > > > > treat them all the same. We do the same thing in a limited way by
> > > > > using common labels on nodes, but this goes much further.
> > > > >
> > > > > In the case of Pi 5 and RP1, I imagine you are proposing that the Pi 5
> > > > > dtb declares the connector node and the overlay fills in the content
> > > > > with references to its GPIO controller, PWM controller etc. However, I
> > > > > think the overlay would also have to be board specific because it's
> > > > > not possible to patch part of a property from an overlay, so you'd end
> > > > > up overwriting the GPIO number as well as the controller reference.
> > > > >
> > > > > What is needed to make this work is the ability to cope with
> > > > > unresolved references in the base dtb, to be resolved as each overlay
> > > > > is applied, with runtime checking that each reference is resolved
> > > > > before it is used, all of which sounds like a nightmare. Plus, we
> > > > > really don't want to have to change the way all our camera and display
> > > > > overlays work on all Raspberry Pis just to accommodate somebody's idea
> > > > > of how RP1 should be handled.  
> > > >
> > > > Just to be clear, my comments were not there to tell you how RP1 should
> > > > work. I just proposed ideas without trying to force anything and I can
> > > > fully understand that ideas proposed don't feed your needs.
> > > >
> > > > Sorry if my approach was misunderstood.  
> > >
> > > I feel I've been misunderstood - I appreciate your ideas.
> > >
> > > Perhaps it would help if you could outline how you think we could
> > > apply your suggestions?
> > >  
> >
> > I was thinking about what your mentioned, i.e. the overlay fill the nexus node.
> > No sure to understand why the overlay should patch some properties.
> > Also where are the unresolved references in that case. The base DT refers to
> > the Nexus node.
> > The issue will probably be that the translation performed by the nexus node is
> > not available until the overlay is applied. The consumer will see errors other
> > than PROBE_DEFER when if probes while the overlay is not applied.  
> 
> The job of the nexus node would be to translate a generic request for
> a numbered resource to a specific request for an RP1 resource with
> arbitrary properties. The arbitrary properties could be GPIO offsets,
> which are board specific, while the node supplying the resource is
> provided by the overlay. This means that an entry in the table,
> described by a single property, could have contributions from the base
> DT and the overlay, which is not possible since overlays overwrite
> whole properties.

Hum, I am a bit lost.
Some DT example (base and overlay) could help me to understand.

> 
> Perhaps that particular problem could be overcome by creating a
> single-entry map, using the map-mask feature to pass through all of
> the GPIO offset and flags to the parent, so that the whole table
> becomes a proxy for RP1's GPIO controller. Is that what you had in
> mind?
> 
> > Also, the solution will lead to memory leak at runtime. Indeed, the overlay
> > add properties in an already existing node.
> > If the overlay is applied by the Kernel itself, this lead to memory leak when
> > the overlay is removed.
> > Indeed, an overlay can add/remove node without any issue but it cannot
> > add/remove properties to/from existing nodes.  
> 
> Fortunately for me I'm not arguing _for_ the use of an overlay.
> 
> > In the case described here, the nexus node is already present in the DT and the
> > overlay add/remove properties to/from this existing node.  
> 
> I think I can see how that could be made to work for GPIOs. It looks
> as though the GPIO subsystem is the only one making use of
> of_parse_phandle_with_args_map. Interrupts seem to have an open-coded
> equivalent, and iommus. What about I2C and PWM?

Support for PWM has been recently accepted.
  https://lore.kernel.org/all/ufl4kwrjyp4zid4muvghefevqc6hk3zyvxnsu72fxd4f46fzg6@hufkci2dzjid/

For i2c, nexus node is not suitable.

Nexus node works well when resources are indexed (gpio line in a gpio chip
for instance). For bus controller there is no index.
I mean we never refer a i2c bus controller using <&i2c-ctrl 12>.

For i2c, I proposed i2c bus extension:
  https://lore.kernel.org/all/20250205173918.600037-1-herve.codina@bootlin.com/

Best regards,
Hervé

