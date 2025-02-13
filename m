Return-Path: <linux-pci+bounces-21381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52857A34F24
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 21:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 118AE7A43F8
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 20:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E278E24BBFC;
	Thu, 13 Feb 2025 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="no4ZKzWc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5B924BBEB
	for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477722; cv=none; b=b68VR0GU9CRpuB5TVQU+rxXqbN7JWQvBf0nk1vsjTU9oiVvQr82Q4nsYicVOQ0FlPWBdEZvWcinwffvJnVmQLW+5NiZ9jAe+1g1ZZNdvbinrugyAGnLa/ltrTAB64COoRAXrYomP1AFwsXzu1rU1/w+kfabk5kuYPyDgZDdcVk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477722; c=relaxed/simple;
	bh=Ku4ZpP8E0qi67O0cpk28B8iLxY+880CliqOyg+p90OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQT1wwqD34zKZtPF8o9I6fTCND2tNTGaaF0AcDwijvzfumj4KkiSA/GTkPPy4ZKCBlGJvXbPlgqPGSZzsVJtwAG2E3uiHr8VoxfKexOmfURGWkl3Gl6yjGiDRqpepIvc8BgMUSKCvWsQBUsGb3WEXDzNYIDS/XOGiSB+9yWuT5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=no4ZKzWc; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7c501bbecso192860366b.2
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 12:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1739477719; x=1740082519; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ku4ZpP8E0qi67O0cpk28B8iLxY+880CliqOyg+p90OQ=;
        b=no4ZKzWc/LOkvUyqWR0AQdkzJcUgEE7TFl8r2EDvyFoKJqOHeZ2e3FTrjurl/g+Bq8
         X/K+7tr1sUR8WL0P1DC+5UPkLxiANyp+3FNGmsv1TRol0m0SVBz2NoobCUnBIPSfxlOu
         zs9faBPz58s/RFKrX0/iqYKs8g12m0GGdISX2ua2RbzpAeDlFNZimAqCiEunvX9fVBDJ
         z8gN0zRie4AmRNXKgLCnk9WdHs8szYX70HCellANQj2piokQEsjw6RqaBNBydzGDPW6m
         psTkAk949ew5+62kc6Rit1V4oEs8MxaUkSrBhZ8TtWAigAmZvdM6EYoJM/i63hbCBZN4
         FoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739477719; x=1740082519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ku4ZpP8E0qi67O0cpk28B8iLxY+880CliqOyg+p90OQ=;
        b=JBV+9h8aNzvclaihT9xoULu3SF1XwmK9fLVNaBMBU67c5IddN2/cADa8MaKUvtn5pT
         gPTg+b50GXsiNI6a0buKx51DFc2ydwEeEMepzP4Mt4AOhUpTQuotORrQjb2Y5u6NOTKU
         qZF2NZ0Q30JW4D+Iv8q1yFXmZ+oNIt8ERswsZh/dII17EwvaOrXpgyWvYxfKmof1EhxB
         doeYmulcOT9HLqDUExtO5YAIyB96a9TkVkuYnhrVcOpEGAzMZUlVscoWTc+JPDGSUD4O
         c6bosiSXg+XC5TsefFLELliX4/VzC6UOhq5ynPMKhrOPJoQApN+F1pru4X4wsnYeY4IQ
         D42Q==
X-Forwarded-Encrypted: i=1; AJvYcCWb7CkpfoiAFz/XERXSU4+vEmUFHOv3wiVAuLbZ95BY8huRSa0+yU3OvtfXibs5gasaNbrkNdqjja0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuCfacPzhRPGlbx1TPWE3dQltf37dxuAizxocpVWPLxBU6nc0f
	27LQXiTYujA6u+lVMeXIKZ1g7fnAes3jc8cCxOo9aWQfhUqzLd09IwbSQKj0ypfr/oEM5ZL+1ju
	oMqhhlakVPUgLU8NU4R07SUY06iafmKLBDopE2Q==
X-Gm-Gg: ASbGncsLNxtaPOlomfK5uNrdgrSjauxuUCdGXO3dvtmq8XSoEPFZMRQcagA2Vn1uoIy
	gL3JEwM4/Egf9mOnrRCdiijVj3qBTKgcWf9vRRWSxRuT4YdfnPc4vU/Pe5JWOA0kUwbi7Y//J
X-Google-Smtp-Source: AGHT+IHL8CM7ylsZCGYbhhurWPgsNzVEPTt0GbzqEVuFP8DGsWzaxgWDYP0kYEVOuE1FqVkeFZtnMkkFkhc6Mpf6ALQ=
X-Received: by 2002:a17:907:94c5:b0:aab:740f:e467 with SMTP id
 a640c23a62f3a-ab7f33459c8mr965659466b.8.1739477719051; Thu, 13 Feb 2025
 12:15:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMEGJJ3=W8_R0xBvm8r+Q7iExZx8xPBHEWWGAT9ngpGWDSKCaQ@mail.gmail.com>
 <20250213171435.1c2ce376@bootlin.com> <a3c5103c-829a-4301-ba53-6ef9bd1e74e7@lunn.ch>
 <CAMEGJJ3-JXhin_Ht76EqUNAwLiNisa9PrCrdUzCgj=msGZfb5A@mail.gmail.com>
 <821d4c74-09b0-4c1b-b8ef-f8c08d0f6b5b@lunn.ch> <CAMEGJJ0QbzCScfTRA_pw_8A=iMYMAAFs69zFNLwcOxF5Syugpw@mail.gmail.com>
 <20250213195304.3a2df02c@bootlin.com>
In-Reply-To: <20250213195304.3a2df02c@bootlin.com>
From: Phil Elwell <phil@raspberrypi.com>
Date: Thu, 13 Feb 2025 20:15:06 +0000
X-Gm-Features: AWEUYZmyv_HkHTHpV0OY_0Sgq0DOC92t4GTNRz9-9baWq02Pyp8uQAKZdY6LeEY
Message-ID: <CAMEGJJ0kGCj=tjM6KswbG_+ZFkzMwPY+06BXCU0qSnbBKz0=ug@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Add support for RaspberryPi RP1 PCI device using
 a DT overlay
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrea della Porta <andrea.porta@suse.com>, Arnd Bergmann <arnd@arndb.de>, 
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, bhelgaas@google.com, brgl@bgdev.pl, 
	Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, derek.kiernan@amd.com, 
	devicetree@vger.kernel.org, dragan.cvetic@amd.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, krzk+dt@kernel.org, kw@linux.com, 
	Linus Walleij <linus.walleij@linaro.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, lpieralisi@kernel.org, 
	luca.ceresoli@bootlin.com, manivannan.sadhasivam@linaro.org, 
	masahiroy@kernel.org, Michael Turquette <mturquette@baylibre.com>, 
	Rob Herring <robh@kernel.org>, saravanak@google.com, Stephen Boyd <sboyd@kernel.org>, 
	thomas.petazzoni@bootlin.com, Stefan Wahren <wahrenst@gmx.net>, 
	Will Deacon <will@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"

Once more, with plain text, which I'd hoped the Android GMail client
would work out for itself.

On Thu, 13 Feb 2025, 18:53 Herve Codina, <herve.codina@bootlin.com> wrote:
>
> Hi Phil,
>
> On Thu, 13 Feb 2025 17:57:37 +0000
> Phil Elwell <phil@raspberrypi.com> wrote:
>
> > On Thu, 13 Feb 2025 at 17:45, Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > > > Or do you mean a custom board, which has a CPU, RP1 and the button and
> > > > > fan are directly on this custom board? You then want a board DTS which
> > > > > includes all these pieces?
> > > >
> > > > That depends on whether you count the Raspberry Pi 5 as a custom board.
> > >
> > > So you mean the Pi 5 board would itself make use of the resources the
> > > RP1 device has? They are not simply connected to headers for plugin
> > > boards, but used by the main board? Hence you want to describe them in
> > > the board .DTS file.
> >
> > That's correct. But even for plug-in devices, those which are on
> > non-discoverable buses need overlays to declare them, which causes a
> > problem when the overlay application happens before the kernel is
> > started.
> >
>
> Hum, I see.
>
> We worked on overlay usage on non-discoverable buses wired to a connector
> and we did a talk about issues we are facing on at Plumber [0].
>
> You can also find our big picture in [1] and a last contribution introducing
> export-symbols feature in [2]. export-symbols is also under discussion on
> some other threads.
>
> Also, we proposed the i2c bus extensions feature [3] whose goal is to allow
> an addon board to add devices on an i2c bus provided by a base board and
> wired to an connector the addon board is connected to.
>
> Maybe in your case, you can decouple resources (gpio, pwm) provided by the
> addon board and used by the base board using also nexus node.
>
> We use a nexus node [4] (not presented at the Plumbers talk because the idea
> came during 'out of talk' discussions in Plumbers) in order to allow our
> addon board to use resources provided by the base board.
>
> In your case, if I understood, you are in the other direction but why not
> using also a nexus node to decouple and translate resources in this other
> direction ?
>
> Don't know if this idea can help but feel free to ask for some more
> information if needed.

Nexus nodes look interesting - I see them as adding a layer of
abstraction such that, for example, boards can declare which of their
specific resources performs a common function so that clients can
treat them all the same. We do the same thing in a limited way by
using common labels on nodes, but this goes much further.

In the case of Pi 5 and RP1, I imagine you are proposing that the Pi 5
dtb declares the connector node and the overlay fills in the content
with references to its GPIO controller, PWM controller etc. However, I
think the overlay would also have to be board specific because it's
not possible to patch part of a property from an overlay, so you'd end
up overwriting the GPIO number as well as the controller reference.

What is needed to make this work is the ability to cope with
unresolved references in the base dtb, to be resolved as each overlay
is applied, with runtime checking that each reference is resolved
before it is used, all of which sounds like a nightmare. Plus, we
really don't want to have to change the way all our camera and display
overlays work on all Raspberry Pis just to accommodate somebody's idea
of how RP1 should be handled.

Besides, Occam's razor surely applies.

Phil

