Return-Path: <linux-pci+bounces-4897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F69587FFCB
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 15:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1A9283ACF
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 14:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D532206E;
	Tue, 19 Mar 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dWo1Vcu7"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2C0200BF;
	Tue, 19 Mar 2024 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710859313; cv=none; b=RpJLp+wxyavKxFBAAOlfJnw+ITCeSvXwzzoSLqzEkWF/b9pEARa900+Em8Fn6K2u3pFkS2/lY8Tt8k8NR4NEGG/I3OHQndEXjzgWLmRhbZp0QraUfvGnbySx6m+nvgg9HpzoQsFwngJkntbJf470OeF9JnWSqFsGzeH7y5hq490=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710859313; c=relaxed/simple;
	bh=H86jgSj39Vt5eZQa4Li5R+8zowtHYkyrFgx+9QNPBdg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4So/z6ahM1aKmsarLjk6xNSwMM22apsfNujRDzr4akcRU8QTRYJFt1DSNUs1nSlW7a5OYmP94IhQkjJ8TObvbcSodCM6zi4XpzUkUdIj3DpAYDBPlGhQfzNsH02xmPuSjn987TRi068D9GUV4Bg8Iah/2BdIzSJgQGLiomHwOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dWo1Vcu7; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C43671BF207;
	Tue, 19 Mar 2024 14:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710859301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6pzJKG5CLK//p9ZCz9khgVEAQ5zvuh1yAWK/ALunBpk=;
	b=dWo1Vcu7aXPfdW4r+i1v7PMuMcPoEaDJJZ/kN2+CkLQf6f8e+pPsH+Q2UNnYZuxCK1SHoi
	Jv/bV9kuZmT6snZRjmg5zrYMOqEk8fWY38pHWT+DqjYD3qKCh8lAhW0yx8uV7RqT8XvVVz
	wce9oaumtggWtBp47/ahEDKKuU6+QUpQRyQQh13TwpIQyy0faEajFeTCZwRB0vNvbHsC1F
	w2eN4ZSy6BB9mrRXzA9IYNhof8chsicphGvpdAp2YQeTi0nwxG2Y2I7fA8wi+VwmZraaAB
	ETYSndIISoy/ePrtwbF9rNxNizZPK3GXBs3WlIE8G6b1LmCnZsuwC5ARwMUkPg==
Date: Tue, 19 Mar 2024 15:41:39 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou
 <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, PCI
 <linux-pci@vger.kernel.org>, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 0/2] Attach DT nodes to existing PCI devices
Message-ID: <20240319154139.03058bf3@bootlin.com>
In-Reply-To: <20231214153122.07e99a5a@bootlin.com>
References: <20231130165700.685764-1-herve.codina@bootlin.com>
	<CAL_JsqJvt6FpXK+FgAwE8xN3G5Z23Ktq=SEY-K7VA7nM5XgZRg@mail.gmail.com>
	<20231204134335.3ded3d46@bootlin.com>
	<CAL_JsqLtCS3otZ1sfiPEWwrWB4dyNpu4e0xANWJriCEUYr+4Og@mail.gmail.com>
	<20231204163014.4da383f2@bootlin.com>
	<CAL_JsqJJ64513pyQggU71agTzawNWPpm6ZpWMB6e0zu-tWL8yw@mail.gmail.com>
	<20231205090452.7c601eb5@bootlin.com>
	<CAL_Jsq+je7+9ATR=B6jXHjEJHjn24vQFs4Tvi9=vhDeK9n42Aw@mail.gmail.com>
	<20231208094840.01d74fec@bootlin.com>
	<20231214153122.07e99a5a@bootlin.com>
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

Hi Rob,

On Thu, 14 Dec 2023 15:31:22 +0100
Herve Codina <herve.codina@bootlin.com> wrote:

> > > 
> > > But you don't. The logic to find the interrupt parent is walk up the
> > > parent nodes until you find 'interrupt-parent' or
> > > '#interrupt-controller' (and interrupt-map always has
> > > #interrupt-controller). So your overlay just needs 'interrupts = <1>'
> > > for INTA and it should all just work.    
> > 
> > Yes, I tried some stuffs in that way...  
> > > 
> > > That of course implies that we need interrupt properties in all the
> > > bridges which I was hoping to avoid. In the ACPI case, for DT
> > > interrupt parsing to work, we're going to need to end up in an
> > > 'interrupt-controller' node somewhere. I think the options are either    
> > 
> > ... and I went up to that point.
> > Further more with that way, we need to update the addr value retrieved
> > from the device requesting the interrupt.
> >   https://elixir.bootlin.com/linux/latest/source/drivers/of/irq.c#L343
> > Indeed, with the current 'interrupt-map' at bridges level, a addr value
> > update is needed at the PCI device level if the interrupt is requested
> > from some PCI device children.
> > This is were my (not so good) interrupt-ranges property could play a
> > role.
> >   
> > > we walk interrupt-map properties up to the host bridge which then
> > > points to something or the PCI device is the interrupt controller. I
> > > think the PCI device is the right place. How the downstream interrupts    
> > 
> > Agree, the PCI device seems to be the best candidate.
> >   
> > > are routed to PCI interrupts are defined by the device. That would
> > > work the same way for both DT and ACPI. If you are concerned about
> > > implementing in each driver needing this, some library functions can
> > > mitigate that.
> > > 
> > > I'm trying to play around with the IRQ domains and get this to work,
> > > but not having any luck yet.    
> >   
> 
> Got some piece of code creating an interrupt controller at PCI device level.
> To have it working, '#interrupt-cell = <1>' and 'interrupt-controller'
> properties need to be set in the PCI device DT node.
> 
> I can set them when the PCI device DT node is created (add them in
> of_pci_add_properties()) but as this interrupt controller is specific to the
> PCI device driver (it needs to be created after the pci_enable_device() call
> and will probably be device specific with MSI), it would make sense to have
> these properties set by the PCI device driver itself or in the overlay it
> applies.
> 
> But these properties creation done by the device driver itself (or the
> overlay) lead to memory leaks.
> Indeed, we cannot add properties to an existing node without memory
> leaks. When a property is removed, the property is not freed but moved
> to the node->deadprops list (of_remove_property()).
> The properties present in the list will be free once the node itself is
> removed.
> In our use-case, the node (PCI device node) is not removed when the driver
> is removed and probe again (rmmod/insmod).
> 
> Do you have any opinion about the '#interrupt-cell' and
> 'interrupt-controller' properties creation:
> 
> - Created by of_pci_add_properties():
>   No mem leak but done outside the specific device driver itself and done for
>   all PCI devices.
>   Maybe the driver will not create the interrupt controller, maybe it will
>   prefer an other value for '#interrupt-cell', maybe it will handle MSI and
>   will need to set other properties, ... All of these are device specific.
> 
> - Created by the device driver itself (or the overlay it applies):
>   The mem leak is present. Any idea about a way to fix that or at least having
>   a fix for some properties ?
>   I was thinking about avoiding to export properties (of_find_property()) and
>   so avoid references properties or introducing refcount on properties but
>   these modifications touch a lot of drivers and subsystems and are subject
>   to errors.
>   That's said, checking a property presence based on its name can be done without
>   exporting the property, as well as getting a single value. Iterating over array
>   values need some more complicated code.
> 

I revive this quite old topic.

The primary goal of this series was to avoid a struct device duplication due
to the insertion of DT nodes related to PCI devices.
The series added the sysfs of_node symlink once the device is visible from
sysfs.
You proposed to create the DT node earlier, DECLARE_PCI_FIXUP_EARLY() instead
of DECLARE_PCI_FIXUP_FINAL() in order to have it set before the device_add()
call.
This raised some new issues because the DT node creation needs some information
set by the PCI core. DECLARE_PCI_FIXUP_HEADER() was the new candidate.
Issues were still present.
The 'ranges' property is needed and information needed for its computation
are set by the PCI core after the device_add() call.

At this point the discussion continued also on interrupts with the idea to
add the 'interrupt-controller' property in the PCI device node in order to
bypass all the interrupt mapping done in DT nodes.
Indeed, in order to have a working DT mapping, an 'interrupt-parent' phandle
is needed at some points and will be problematic with ACPI.

On my side I've got a piece of code to consider the PCI device as an interrup
controller. This work with the 'interrupt-controller' property.

The question raised:
Which part of code set the interrupt-controller property ?
- DT node creation:
  Common to all PCI devices even if the interrupt are not handled by the PCI
  device driver. Also '#interrupt-cells' is really device specific.
- Added by the PCI device driver itself
  Seems the good place but we enter in overlay memleak issues

What is your opinion related to the best candidate for the
'interrupt-controller' and '#interrupt-cells' property creation ?

Back to the of_node link addition to sysfs.
Is it really an issue to add it on an already present device ?
If so, is it acceptable (not tested on my side) to create the of_node link
to an empty node before the device_add() call and then fill this node later
when needed information are set by the PCI core ?

With your answers, I hope to move forward on these topics.
Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

