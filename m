Return-Path: <linux-pci+bounces-6567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B358AE420
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 13:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4E3289DBA
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 11:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFFA80020;
	Tue, 23 Apr 2024 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JiafY+vV"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB4180028;
	Tue, 23 Apr 2024 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871995; cv=none; b=nfll/xw5OBZm7Dj0B4poevKbjTbIJB8nAiVMHSUCyVtPpq4mNhTacQxmoGQAHNj+9+C1mP9X3lNPrDAHS05L8sCsHmM6uCDvs4V7NhNwk6aAGnvP3oxdKmShyrdPuYI526+7l0JsU0AtVjITAhWJYkX8Bl3PhjW6nUlr19OmJBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871995; c=relaxed/simple;
	bh=WalPArk47tvAzrWfweu0jQS5mtmWIAjNBiO2qe7qn8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oNJKDkF6gamt5VW81heA2I/u8HgoMCV39FOvgR6GYOBMq7pw87TeQbedZAxeNHCpFvodEMvA2RuvUR74/qbI238nyCY1h1E4PmM7591mSegFM/f8/k3AyijrzzLxn/Pd8OZnEdQrHkHgRyx97lqFi6+ixiTBoNsnbZZNXmlyAfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JiafY+vV; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A4190240007;
	Tue, 23 Apr 2024 11:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713871985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8HXsXyT41e7zXu4VpcQhDNhTQBKrNWOKL68FJq5fIo4=;
	b=JiafY+vVwE+BJ21aRvdSR0mgf3Jvs5sy1F1rcHaH9LLzr7ZCfkbbiAxkJUTh06owGswl9b
	ckIrd0WyliaYzjDJP1oVA6C2T3hOQTcWpyaxIroFf0Zv4rvHHJVW4KzWqcPvAOR24uDkKT
	VhgGm6FR1SteFQGt3GMFObX09fXHYdvJPO1LGQOrJ5Q60A8S/2AmrJjnKqf9iDi93MeuWO
	5FHQJW38wxN+e0ysTyhqAgCMrjNOTdWBKqqZhrSfv8mrRPwPYF0NFkCWlNDN2bDiqbQpQm
	ggQtXRQYiGGHVebAAWtwbAHrxKRtiJZsDA0LSbThdVWuvT5ccUQamqSqrOPW3g==
Date: Tue, 23 Apr 2024 13:33:01 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>
Subject: Re: local bus enumeration beyond a PCI device
Message-ID: <20240423133301.217f7ab2@bootlin.com>
In-Reply-To: <b7589f13-e851-4ec3-ade7-43981b345cb1@alliedtelesis.co.nz>
References: <20240418184531.GA245970@bhelgaas>
	<b7589f13-e851-4ec3-ade7-43981b345cb1@alliedtelesis.co.nz>
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

Hi Chris,

On Tue, 23 Apr 2024 01:05:21 +0000
Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:

> Hi,
> 
> On 19/04/24 06:45, Bjorn Helgaas wrote:
> > [+cc Herve]
> >
> > On Thu, Apr 18, 2024 at 12:24:06AM +0000, Chris Packham wrote:  
> >> Hi,
> >>
> >> We've got a custom x86_64 based design that is using an ASIX9100 to
> >> provide a PCI to local bus bridge. Attached to that local bus is an FPGA
> >> which mostly provides some GPIOs accessed via registers on the local
> >> bus. Right now we've got a custom driver that bundles everything
> >> together so effectively we've got a PCI device that provides GPIOs.  
> > What's the local bus?  The ASIX9100 (for which Google doesn't find any
> > details) would have a PCI interface on the primary (upstream) side.
> > What's the local bus on the secondary (downstream) side?  Below you
> > mention "PCI bridge", which normally means both the primary and
> > secondary sides are PCI buses.  
> 
> The ASIX9100 is a multi purpose chip with a few options for providing 
> GPIO/I2C/SPI/etc. In our hardware configuration we're using it to 
> provide a 16-bit parallel bus which we're using for register access to 
> the FPGA. There's an outside chance someone might ask us to hang other 
> parallel devices like an SRAM or some NOR Flash off it as well. These 
> are all things we've done on other products with more traditional 
> embedded SoCs that have a parallel bus interface.
> 
> > If the local bus is not PCI, I guess the ASIX9100 would look to the OS
> > like an endpoint, i.e., PCI_HEADER_TYPE_NORMAL, and the ASIX9100
> > driver would handle any "bridge" functionality completely internally?  
> 
> I might be using the terminology wrong. Essentially the ASIX9100 is a 
> PCI-e endpoint (so a device from the PCI subsystems point of view) but 
> that device can be a I2C, SPI or parallel bus controller onto which 
> other devices are connected.Hence it's providing a bridge between PCI 
> and 16-bit parallel busses.
> 
> > Maybe Herve's work at
> > https://lore.kernel.org/r/20240325153919.199337-1-herve.codina@bootlin.com
> > would be relevant?  
> 
> I've had a quick look at that series. I'm not 100% sure it'll help. The 
> platform I'm dealing with is x86_64 and doesn't have device tree support 
> (if someone can say "hey do xyz and you'll get DT on x86" that'd be 
> great).But I'll take a closer look at it and at the original "Generate 
> device tree node for pci devices" series.

You can have DT support on x86.
CONFIG_OF=y
CONFIG_PCI_DYNAMIC_OF_NODES = y

I use a PCIe board from Microchip (Lan966x) and I describe the internal board
IPs using a DT overlay.
My PCI driver loads the overlay at probe() and call of_platform_default_populate()
to instantiate the devices.

My DT overlay contains nodes for:
- clock controller
- reset
- i2c bus
- pinctrl and gpio
- Network switch
- MDIO controller

I have it working on x86 system.
What is mainly missing upstream for x86 system is the DT node creation for the
host PCI bridge (root complex). Indeed, on x86 the description comes from ACPI
and a DT description of this root bridge is needed.
Got a draft code locally (not sent upstream yet) that creates this first bridge
on ACPI based systems.

PCI-to-PCI bridges and PCI devices are already handled:
  https://elixir.bootlin.com/linux/v6.9-rc5/source/drivers/pci/of.c#L625
At runtime, based on the PCI enumeration, corresponding DT nodes are created.

Best regards,
Hervé

> 
> >> But as things can change based on the FPGA program I'd like some
> >> flexibility to treat it separately from the PCI bridge. So really I'd
> >> like to have a PCI device driver for the ASIX9100 that provides a local
> >> bus controller and a (platform?) driver for the FPGA that provides the
> >> GPIOs where I can have different compatibles for the different
> >> implementations.
> >>
> >> Then in the ACPI overlay I'd have something like
> >>
> >>       Scope (\_SB.PCI0.D0B0)
> >>       {
> >>           Device (ASIX)
> >>           {
> >>               Name (_ADR, 0x0000)
> >>
> >>               Device (FPGA)
> >>               {
> >>                           Name (_HID, "PRP0001")
> >>                           Name (_DSD, Package ()
> >>                           {
> >> ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >>                                       Package ()
> >>                                       {
> >>                                                   Package () {
> >> "compatible", "my-platform-driver-for-fpga" },
> >>                                       }
> >>                           })
> >>               }
> >>           }
> >>       }
> >>
> >>      Scope(\_SB)
> >>      {
> >>           Device(OTHR)
> >>           {
> >>               GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
> >> "\\_SB.PCI0.D0B0.ASIX.FPGA",) { 0 }
> >>           }
> >>      }
> >>
> >> Is it even possible to register a host controller for another platform bus?

With DT overlay, you can register any devices available on your PCI board.
You just need to describe them in the overlay and be sure that a driver exist to
handle them based on their compatible property.

Also, this solution was designed to work on both DT and ACPI based systems.
My Microchip board works on x86 and ARM.

Best regards,
Hervé

