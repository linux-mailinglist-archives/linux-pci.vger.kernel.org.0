Return-Path: <linux-pci+bounces-25934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5F1A8A52D
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 19:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF721901EE7
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 17:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8111821A952;
	Tue, 15 Apr 2025 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhw7DW3V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A591422AB;
	Tue, 15 Apr 2025 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744737568; cv=none; b=In09srHnd/4eUigDvbhQCX4zuPFvBlpNElXbXfFPNr6CqBo5A548eaStV0M4/EgpK2hXfnkjGQHZJnLFOLacNJkksvI73TlM4csH531P8teAgrizfVwsfyDRo40pLG7v454e1a9sRKWux/9628qNojNXCRI0Ehl3Sg9+krZShTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744737568; c=relaxed/simple;
	bh=8yka/gQeBhrlYJl1t7qkx70DxA7hHJaBmLjr/ZBHYqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcIB565tbTTck1/yUCxMsjoRQZd+PoSwpEnZSWHwoBcglAeiV6uSxn3Jm7q1ScXL807IXUnx0e5unV+f4ikkpaNw7PbBnI5A4wLVsT5Y6nQLcGNLFtTnHOM3POkHVO3ak6JtBVzUb+QmINe0dp4jO/8GhRyHYq2a4VRwrk07LFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhw7DW3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F6EC4AF09;
	Tue, 15 Apr 2025 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744737567;
	bh=8yka/gQeBhrlYJl1t7qkx70DxA7hHJaBmLjr/ZBHYqk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jhw7DW3VqHIP3oCC9zZ5B2min/ozWe4z3fTBJFePlfJBXw1PL3lvj0ebqpk47Xo1j
	 fHsMk4C7B7Nz5Z74s2p6+lz16LQGmL5KIsMKFUeVCxUr0NFUR4t0h7FtxYVzjzUYyc
	 GC8GcJxioY+WzXChQpvR+goTqMq9c/gvEsj4sa+ouSXG4WWdjFbrrOzFiwY+MSyfu6
	 1vjNOH6wflfV7QvVtylAfwhJrHe0nqdRvrjBgb2z2FAIeluoRru+P40JGUGOAXrZPq
	 SEHgAcq10VwKaQQG8nNKnKvPrdgiIQgYo43gx6PMzMgPxo3YSzCOisLK/vofeHF4dk
	 LxllEjABcYLrA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5edc07c777eso7528145a12.3;
        Tue, 15 Apr 2025 10:19:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdUv+7CK1iDP0ExWC6AVzzlOmbkYBNI4cAa/QfducYs3rWhbEmx9CEkpClIpj4PL0SP0CPUvCfoCAo@vger.kernel.org, AJvYcCVxjUKMR0UWiN6XEkqaMheyrONJ4YdDsaEUFBCWGiqIrry6Vsoe7o9DG8GsRYEHjkloXeqp+n04TBzG@vger.kernel.org, AJvYcCWjU18CYUy+fTgqvv0LW0t4Ee1OFtjxXVIMauLuAth6+PJ3TrEiZMa2yszXmm4enTyke79KnnMuiEKJ@vger.kernel.org, AJvYcCWnjnDwq8jhC6NGV5k4lr/PP6O46HXO5kiXHKXhNacVyNPKHjFrBWdW1dV6Ufr0lQAVV+gZFK1gIRqAIIBy@vger.kernel.org, AJvYcCXmQfqd9EVTU3inv2NLJyzym4Zz4MKA+XlhQtGWzBHtIU8E62boUkIUsmw1SEu6px/3+pdNsMA/cukPQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeDny2ugsASXlGS8OxcehHXWiMANC+KYuYpmgB6XifP8UohcQp
	YfFPWvXelpCk58KfYTauxxsDe36Qkh0bkXv1leg+dHs28sv4xrvV9boz6z23+Iejo/Zm+NSEl4m
	b6hDgKJrdSFaR11+5JWHM0SzucQ==
X-Google-Smtp-Source: AGHT+IFg/mg5Nw4gYKzUIV+g5HCy+mWdlEB6aIaPRaMh7pw+ii1aBxtkyH5Y0FGsRMWegnVV9LP1TH52Q9jz/Bmp/K4=
X-Received: by 2002:a05:6402:84d:b0:5e5:c3bc:f4e0 with SMTP id
 4fb4d7f45d1cf-5f370118051mr12498419a12.29.1744737566354; Tue, 15 Apr 2025
 10:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742418429.git.andrea.porta@suse.com> <3fbc487bc0e4b855ffbee8ed62cfb6bf3b0592e8.1742418429.git.andrea.porta@suse.com>
 <2025041557-masculine-abrasive-c372@gregkh> <20250415165505.0c05bc61@bootlin.com>
 <2025041531-dubiously-duchess-276a@gregkh> <Z_5-Jjbu6XoHGmxN@apocalypse> <2025041530-random-cheek-125d@gregkh>
In-Reply-To: <2025041530-random-cheek-125d@gregkh>
From: Rob Herring <robh@kernel.org>
Date: Tue, 15 Apr 2025 12:19:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJbdvMrUEVwp4_yC4efhwuK4eCLYWFpGdvrVcbr213aqg@mail.gmail.com>
X-Gm-Features: ATxdqUHTw0_CVItdYBRikaW5EF3D0YJ32XibO0ClmZMuosKXRosNhnaQkfoIVa4
Message-ID: <CAL_JsqJbdvMrUEVwp4_yC4efhwuK4eCLYWFpGdvrVcbr213aqg@mail.gmail.com>
Subject: Re: [PATCH v8 08/13] misc: rp1: RaspberryPi RP1 misc driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrea della Porta <andrea.porta@suse.com>, Herve Codina <herve.codina@bootlin.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczynski <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, 
	Stefan Wahren <wahrenst@gmx.net>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
	Phil Elwell <phil@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	kernel-list@raspberrypi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 11:14=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Apr 15, 2025 at 05:41:26PM +0200, Andrea della Porta wrote:
> > Hi Greg,
> >
> > On 17:14 Tue 15 Apr     , Greg Kroah-Hartman wrote:
> > > On Tue, Apr 15, 2025 at 04:55:05PM +0200, Herve Codina wrote:
> > > > Hi Greg,
> > > >
> > > > On Tue, 15 Apr 2025 16:06:43 +0200
> > > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > > On Wed, Mar 19, 2025 at 10:52:29PM +0100, Andrea della Porta wrot=
e:
> > > > > > The RaspberryPi RP1 is a PCI multi function device containing
> > > > > > peripherals ranging from Ethernet to USB controller, I2C, SPI
> > > > > > and others.
> > > > >
> > > > > So shouldn't this be using the auxbus code?  That's designed to "=
split
> > > > > up" PCI devices such that you can share them this way.
> > > > >
> > > > > Or did that get rejected somewhere previously?
> > > > >
> > > >
> > > > It doesn't use auxbus probably for the exact same reason that the
> > > > one given for the LAN966x PCI device driver [0] and [1].
> > > >
> > > > Avoid all boiler plate needed with auxbus whereas drivers already e=
xist
> > > > as platform drivers. Internal devices are handled by those platform=
 drivers.
> > > > Those devi just need to be described as platform devices and device=
-tree is
> > > > fully relevant for that description.
> > > >
> > > > [0] https://lore.kernel.org/all/CAL_Jsq+1r3SSaXupdNAcXO-4rcV-_3_hwh=
0XJaBsB9fuX5nBCQ@mail.gmail.com/
> > > > [1] https://lore.kernel.org/all/Y9kuxrL3XaCG+blk@kroah.com/
> > >
> > > I really hate creating platform devices below a PCI device, so I'll k=
eep
> > > complaining about this every time people try to do it.
> >
> > I agree with you, but as Herve has already pointed out this would mean =
incurring
> > in significant work to adapt drivers for all the peripherals (there are=
 quite a
> > few), while with this approach they would be left untouched.
>
> We have no problem with reworking existing drivers, especially if they
> will be doing the correct thing.  Don't let that be an excuse, it
> doesn't work with me, sorry :)

Let me resurrect of_platform_bus so we can stop repeating the same
conversation... MMIO based devices using DT (and ACPI) are platform
devices. There is no other answer in the kernel today.

Rob

