Return-Path: <linux-pci+bounces-4912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA9B880265
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 17:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 656E1B24317
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 16:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2EF6AC0;
	Tue, 19 Mar 2024 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pj9QGjAT"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6948489;
	Tue, 19 Mar 2024 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866054; cv=none; b=C6iUU9LZgSr7uz19G0EmFA2xixd9VOx57QTLtNKOGV5KVWMwL00ioJ7SReBhEgBU5mQhIfq/3r2F46z50mUhrSz3k4Iqnw2jfy5QLYpLi3TED5ki2paQxbEuJtLGjd2Q6NDxMznEedk5l3EO9X4EQd0NEFxhbJhFFlNOQCqRpi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866054; c=relaxed/simple;
	bh=YlAPJJDgoDVZ9sazmRhBUOaRf5OWOWpXawB/hpsB/qI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtnmAkycay5Mnbnu2pSfZwOMkuQ5a3Ti0BNUNR0c/wImiV4CsOHC321h9jAbz/fSQOa2acOcLXk3m8q+xJm8O6ie9SksZZUpiaWTbZN6M6mbgKCsG83v0lCxSzTmC5QN3hQxZpeBN26vctM2WjVqhJo6NkgOgaV6bNjIzTzMBaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pj9QGjAT; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C1171BF208;
	Tue, 19 Mar 2024 16:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710866048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYIimeHKwBqqC6DKuj5E7MDRAp7vlcQ07WCRWyQmkBA=;
	b=pj9QGjATc1a0H5dialB43VBvVSKpAUdAGAbcNJmUivGu3/45f0JBnQklJhy26AxveZhfsD
	NzjZudfp6zuWrMW3Uvy2cRbQ80GsLLjRHp46mGzWbD0LkH09L3Awtj1pmKcwHVNVieULO0
	4Nk4ZmgiCOMY8hUJp9RTM8ErwdVdo/opIrcJ9tBwzl7ntXYGl7uD1Yp0emCUd9uMTAYnlW
	D0GiVrXJ16XsRT9lqrigkoh+xvxEcMW+dKZ8hdlbXFT9prZIt/F6MBr6QP/OYO6H1k1/Jn
	kyAlMFeWGqux+z3dYUmLwZPOvaQS8eFXMzcN80Ytl9qjJ3IvRPNkRhCbwdMN2A==
Date: Tue, 19 Mar 2024 17:34:04 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>, Max
 Zhen <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>, Stefano
 Stabellini <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, PCI <linux-pci@vger.kernel.org>, Allan
 Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?=
 <kwilczynski@kernel.org>
Subject: Re: [PATCH v2 0/2] Attach DT nodes to existing PCI devices
Message-ID: <20240319173404.019b424a@bootlin.com>
In-Reply-To: <20240319152513.GA1227721@bhelgaas>
References: <20231215145207.0cf098e5@bootlin.com>
	<20240319152513.GA1227721@bhelgaas>
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

Hi Bjorn,

On Tue, 19 Mar 2024 10:25:13 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Krzysztof]
> 
> On Fri, Dec 15, 2023 at 02:52:07PM +0100, Herve Codina wrote:
> > On Mon, 4 Dec 2023 07:59:09 -0600
> > Rob Herring <robh@kernel.org> wrote:  
> > > On Mon, Dec 4, 2023 at 6:43 AM Herve Codina <herve.codina@bootlin.com> wrote:  
> > > > On Fri, 1 Dec 2023 16:26:45 -0600
> > > > Rob Herring <robh@kernel.org> wrote:  
> > > > > On Thu, Nov 30, 2023 at 10:57 AM Herve Codina <herve.codina@bootlin.com> wrote:  
> > > > > ...  
> 
> > > > > --- a/drivers/pci/of.c
> > > > > +++ b/drivers/pci/of.c
> > > > > @@ -31,6 +31,8 @@ int pci_set_of_node(struct pci_dev *dev)
> > > > >                 return 0;
> > > > >
> > > > >         node = of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
> > > > > +       if (!node && pci_is_bridge(dev))
> > > > > +               of_pci_make_dev_node(dev);
> > > > >         if (!node)
> > > > >                 return 0;    
> > > >
> > > > Maybe it is too early.
> > > > of_pci_make_dev_node() creates a node and fills some properties based on
> > > > some already set values available in the PCI device such as its struct resource
> > > > values.
> > > > We need to have some values set by the PCI infra in order to create our DT node
> > > > with correct values.    
> > > 
> > > Indeed, that's probably the issue I'm having. In that case,
> > > DECLARE_PCI_FIXUP_HEADER should work. That's later, but still before
> > > device_add().
> > > 
> > > I think modifying sysfs after device_add() is going to race with
> > > userspace. Userspace is notified of a new device, and then the of_node
> > > link may or may not be there when it reads sysfs. Also, not sure if
> > > we'll need DT modaliases with PCI devices, but they won't work if the
> > > DT node is not set before device_add().  
> > 
> > DECLARE_PCI_FIXUP_HEADER is too early as well as doing the DT node creation
> > just before the device_add() call.
> > Indeed, in order to fill the DT properties, resources need to be assigned
> > (needed for the 'ranges' property used for addresses translation).
> > The resources assignment is done after the call to device_add().  
> 
> Do we need to know the actual address *value* before creating the
> sysfs file, or is it enough to know that the file should *exist*, even
> if the value may be changed later?

I think, the problematic file is 'of_node'.
This file is a symlink present in the device directory pointing to the
node in a device-tree subdir.

How can we create this of_node symlink without having the device-tree
subdir available ?

> 
> > Some PCI sysfs files are already created after adding the device by the
> > pci_create_sysfs_dev_files() call:
> >   https://elixir.bootlin.com/linux/v6.6/source/drivers/pci/bus.c#L347
> > 
> > Is it really an issue to add the of_node link to sysfs on an already
> > present device ?  
> 
> Yes, I think this would be an issue.  We've been trying to get rid of
> pci_create_sysfs_dev_files() altogether because there's a long history
> of race issues related to it:
> 
>   https://lore.kernel.org/r/1271099285.9831.13.camel@localhost/ WARNING: at fs/sysfs/dir.c:451 sysfs_add_one: sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:01.0/slot'
>   https://lore.kernel.org/r/19461.26166.427857.612983@pilspetsen.it.uu.se/ [2.6.35-rc1 regression] sysfs: cannot create duplicate filename ... XVR-600 related?
>   https://lore.kernel.org/r/20200716110423.xtfyb3n6tn5ixedh@pali/ PCI: Race condition in pci_create_sysfs_dev_files
>   https://lore.kernel.org/r/m3eebg9puj.fsf@t19.piap.pl/ PCI: Race condition in pci_create_sysfs_dev_files (can't boot)
>   https://bugzilla.kernel.org/show_bug.cgi?id=215515 sysfs: cannot create duplicate filename '.../0000:e0'
> 
> And several previous attempts to fix them:
> 
>   https://lore.kernel.org/r/4469eba2-188b-aab7-07d1-5c77313fc42f@gmail.com/ Guard pci_create_sysfs_dev_files with atomic value
>   https://lore.kernel.org/r/20230316103036.1837869-1-alexander.stein@ew.tq-group.com PCI/sysfs: get rid of pci_sysfs_init late_initcall
>   https://lore.kernel.org/r/1702093576-30405-1-git-send-email-ssengar@linux.microsoft.com/ PCI/sysfs: Fix race in pci sysfs creation
> 

I am not sure we are facing in the same kind of issues.
The ones you mentioned are related to some sysfs duplication.
In the of_node case, the issue (if any) is that the symlink will be created
after the other device's file. Not sure that it can lead to some file
duplication.

Best regards,
Hervé
-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

