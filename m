Return-Path: <linux-pci+bounces-20200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C328A180DA
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 16:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991BB16863D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 15:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBB01F471A;
	Tue, 21 Jan 2025 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S5VkIzWd"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA6E27702;
	Tue, 21 Jan 2025 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737472526; cv=none; b=G2PumZvuBTeguMmZNIwZ24H9thEtfZwCNxMxwDOKBA7PMOKatPYgoXoCxwCN25kAZO0FOj8wiHvvat2DNr0lIfFvPaxQPDT7wGyN3R+gV3EHbfNnBse7gy9cwtRMcdDKV8ea0TQyFsiR9z8B/S7YdlwybAZOmlNKqIGCMANEYyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737472526; c=relaxed/simple;
	bh=mWbyub580L+YihAlEfrZNU4Ig9fNmwu1BljobIfUxwk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pY4B/uvt1ZsUFZMmTNAztsQ9UgDe5nyFoIw15N/1qMCZo1F5+ZW5UQgqSdt2xwRqhaGEHN2xnNF9E5whcpH8VdtXV4QjReOHgCIDLhCGegi9BMMswDzNybCk8ePR7TTpyXCifNw1UgH4cJUOxrb+gRFhCsjFtrgdUxNvFTg11uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S5VkIzWd; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7025420013;
	Tue, 21 Jan 2025 15:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737472516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X4Q4hJw5c+A/aS0RSQxPiCKAtW+pQN8zj4IF9YAn0J8=;
	b=S5VkIzWdwIvCY/+i6lnX+FglRqgvtroMLGFdMIXk4BB3QN6KHEDTA8glOOXknkPCEiDWpA
	4d4wAPAAzQ4hEdQBk83SsuarvVuDzc8lTIKBcwjbT7pv2XNIy2D41javnOdRc+xuzn2FPo
	7Q/61hfQ7ZMU3SmkR2f/PkjvDsKE3P5bkbxdDmsAFBEB1lYv0DVoZ5zYSULze92mmrc7r3
	y75Xr2sH0yYNnx2GwIhRvaEFVT7yRQA3TBVSgJMmq/fcCmnyKiwegMu/kL6SKQw1LqPlVS
	4g75aDVWjceQCeMejRE//Rufe+0QXXqItevCkqJ59nxCJBjhFY5wYgT8gPGU4g==
Date: Tue, 21 Jan 2025 16:15:12 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof Wilczynski <kw@linux.com>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Linus Walleij <linus.walleij@linaro.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>, Dragan
 Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, Saravana
 Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, Masahiro Yamada
 <masahiroy@kernel.org>, Stefan Wahren <wahrenst@gmx.net>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v6 08/10] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <20250121161512.2a3ac703@bootlin.com>
In-Reply-To: <2025012148-unused-winking-7d51@gregkh>
References: <cover.1736776658.git.andrea.porta@suse.com>
	<550590a5a0b80dd8a0c655921ec0aa41a67c8148.1736776658.git.andrea.porta@suse.com>
	<2025011722-motocross-finally-e664@gregkh>
	<Z49eOdVvwknOoD3E@apocalypse>
	<2025012143-rippling-rehydrate-581b@gregkh>
	<Z4-oORWO4BgOqibB@apocalypse>
	<2025012157-bonsai-caddie-19b2@gregkh>
	<Z4-xcjov0HLivfVX@apocalypse>
	<2025012148-unused-winking-7d51@gregkh>
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
X-GND-Sasl: herve.codina@bootlin.com

Hi Andrea,

On Tue, 21 Jan 2025 15:49:04 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Tue, Jan 21, 2025 at 03:38:42PM +0100, Andrea della Porta wrote:
> > Hi Greg,
> > 
> > On 15:18 Tue 21 Jan     , Greg Kroah-Hartman wrote:  
> > > On Tue, Jan 21, 2025 at 02:59:21PM +0100, Andrea della Porta wrote:  
> > > > Hi Greg,
> > > > 
> > > > On 09:48 Tue 21 Jan     , Greg Kroah-Hartman wrote:  
> > > > > On Tue, Jan 21, 2025 at 09:43:37AM +0100, Andrea della Porta wrote:  
> > > > > > Hi Greg,
> > > > > > 
> > > > > > On 12:47 Fri 17 Jan     , Greg Kroah-Hartman wrote:  
> > > > > > > On Mon, Jan 13, 2025 at 03:58:07PM +0100, Andrea della Porta wrote:  
> > > > > > > > The RaspberryPi RP1 is a PCI multi function device containing
> > > > > > > > peripherals ranging from Ethernet to USB controller, I2C, SPI
> > > > > > > > and others.
> > > > > > > > 
> > > > > > > > Implement a bare minimum driver to operate the RP1, leveraging
> > > > > > > > actual OF based driver implementations for the on-board peripherals
> > > > > > > > by loading a devicetree overlay during driver probe.
> > > > > > > > 
> > > > > > > > The peripherals are accessed by mapping MMIO registers starting
> > > > > > > > from PCI BAR1 region.
> > > > > > > > 
> > > > > > > > With the overlay approach we can achieve more generic and agnostic
> > > > > > > > approach to managing this chipset, being that it is a PCI endpoint
> > > > > > > > and could possibly be reused in other hw implementations. The
> > > > > > > > presented approach is also used by Bootlin's Microchip LAN966x
> > > > > > > > patchset (see link) as well, for a similar chipset.
> > > > > > > > 
> > > > > > > > For reasons why this driver is contained in drivers/misc, please
> > > > > > > > check the links.  
> > > > > > > 
> > > > > > > Links aren't always around all the time, please document it here why
> > > > > > > this is needed, and then links can "add to" that summary.  
> > > > > > 
> > > > > > Ack.
> > > > > >   
> > > > > > >   
> > > > > > > > This driver is heavily based on downstream code from RaspberryPi
> > > > > > > > Foundation, and the original author is Phil Elwell.
> > > > > > > > 
> > > > > > > > Link: https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf  
> > > > > > 
> > > > > > ...
> > > > > >   
> > > > > > > > diff --git a/drivers/misc/rp1/rp1_pci.c b/drivers/misc/rp1/rp1_pci.c
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..3e8ba3fa7fd5
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/drivers/misc/rp1/rp1_pci.c
> > > > > > > > @@ -0,0 +1,305 @@
> > > > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > > > +/*
> > > > > > > > + * Copyright (c) 2018-24 Raspberry Pi Ltd.
> > > > > > > > + * All rights reserved.
> > > > > > > > + */
> > > > > > > > +
> > > > > > > > +#include <linux/err.h>
> > > > > > > > +#include <linux/interrupt.h>
> > > > > > > > +#include <linux/irq.h>
> > > > > > > > +#include <linux/irqchip/chained_irq.h>
> > > > > > > > +#include <linux/irqdomain.h>
> > > > > > > > +#include <linux/module.h>
> > > > > > > > +#include <linux/msi.h>
> > > > > > > > +#include <linux/of_platform.h>
> > > > > > > > +#include <linux/pci.h>
> > > > > > > > +#include <linux/platform_device.h>
> > > > > > > > +
> > > > > > > > +#include "rp1_pci.h"  
> > > > > > > 
> > > > > > > Why does a self-contained .c file need a .h file?  Please put it all in
> > > > > > > here.  
> > > > > > 
> > > > > > I agree with you. Indeed, the very first version of this patch had the header
> > > > > > file placed inside the .c, but I received concerns about it and some advice to
> > > > > > do it differently, as you can see here:
> > > > > > https://lore.kernel.org/all/ZtWDpaqUG9d9yPPf@apocalypse/
> > > > > > so I've changed it accordingly in V2. So right now I'm not sure what the
> > > > > > acceptable behaviour should be ...  
> > > > > 
> > > > > It's a pretty simple rule:
> > > > > 	Only use a .h file if multiple .c files need to see the symbol.
> > > > > 
> > > > > So no .h file is needed here.  
> > > > 
> > > > Perfect, I'll revert back that two lines to V1 then. Please be aware
> > > > though that this will trigger the following checkpatch warning:
> > > > 
> > > > WARNING: externs should be avoided in .c files  
> > > 
> > > Well where are those externs defined at?  Shouldn't there be a .h file
> > > for them somewhere in the tree if they really are global?  
> > 
> > Those symbols are deined in drivers/misc/rp1/rp1-pci.dtbo.S (added by
> > this patchset) and created by cmd_wrap_S_dtb in scripts/Makefile.lib.
> > They are just placeholders that contains rp1-pci.dtbo as
> > a binary blob, in order for the driver (rp1_pci.c) to be able to use
> > the binary buffer representing the overlay and address it from the
> > driver probe function.
> > So there's no other reference from outside rp1_pci.c to those two symbols.
> > In comparison, this is the very same approach used by a recently accepted
> > patch involving drivers/misc/lan966x_pci.c, which also has the two externs
> > in it and triggers the same checkpatch warning.  
> 
> Ok, that's fine, checkpatch is just a hint, not a hard-and-fast-rule.
> 

Maybe just to avoid confusion for future readers, you can add a comment as I
did for the lan966x:
  https://elixir.bootlin.com/linux/v6.13-rc3/source/drivers/misc/lan966x_pci.c#L21

This will not avoid the warning but will give an explanation to people
looking closer at this checkpatch warning.

Best regards,
Hervé

