Return-Path: <linux-pci+bounces-6155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026A28A208A
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 22:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35E25B2287C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 20:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E1317584;
	Thu, 11 Apr 2024 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgC9U2w0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9DD3B295;
	Thu, 11 Apr 2024 20:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869075; cv=none; b=PBp6dOUospfxWYd3vMmkOeMsP2gaxlZFLbv0P3uh1uhV2TU4w7eexD6CkUyudcA0NRLwKDydV+xirj46gEFsJIlUeXesT/NT1nBctm+9t34IvvzjzG5gZZF7uKPE6mppAHec3zkBj5ChXfHbRLGk4V0igB/TJuoytfTq/NQWYr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869075; c=relaxed/simple;
	bh=+JAoN2Qmwk2NB53yW+S7JV82ikw/tfWwk2KOxm2jbH8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YESRCmhgFqZZpW1cUwGNpPPUH6S3OXjSZKrWHfeKeiOqdL9njkIut26oR2weVTD2fXO5vImwozHEOxmYwUEG0iDW4Sni21+sjsvL/bvIqSWq1S+o+urO39HPg8jwrRdVdlkzRwKnO9PTduPTiKAkOfIsiywAR0oyWBsc0Nr1F80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgC9U2w0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB61C072AA;
	Thu, 11 Apr 2024 20:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712869074;
	bh=+JAoN2Qmwk2NB53yW+S7JV82ikw/tfWwk2KOxm2jbH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HgC9U2w0VnsyeUs0d5E4xvzPxUJRfD0oSwtJn7iO0KbRV6P6KyXsPBI5579rdqazI
	 TinSJTYEcgF4vRG+BKHpfUOdxBIlZnXC/6CM1j7mSIMEA6wjD81oHGF0bvVTJwUtYQ
	 PusMLAt2z1OkK8r7yV7fvyoevH7Q+Ql0G4eWhCVUUNbEBJhAROb0AkzCO5AIpYOlgI
	 KwWpeNmbwOW48mrIYwTczVpZrNvekIRmE5yMcAxCEpGV0eVkBF+vMhmdMSlhf3w9P1
	 TJCFSa7yYvPTuRneXjpLB38EHq/fz7XmRLQUZ2t0p5CBPKH5WlAGe2dOQem9DXiVLr
	 vzYgbG98Vh7cg==
Date: Thu, 11 Apr 2024 15:57:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
	Max Zhen <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>,
	Stefano Stabellini <stefano.stabellini@xilinx.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	PCI <linux-pci@vger.kernel.org>,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v2 0/2] Attach DT nodes to existing PCI devices
Message-ID: <20240411205752.GA2199968@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240411160548.06fa9b11@bootlin.com>

On Thu, Apr 11, 2024 at 04:05:48PM +0200, Herve Codina wrote:
> On Wed, 10 Apr 2024 16:41:43 -0500
> Rob Herring <robh@kernel.org> wrote:
> > On Tue, Mar 19, 2024 at 11:34 AM Herve Codina <herve.codina@bootlin.com> wrote:
> > > On Tue, 19 Mar 2024 10:25:13 -0500
> > > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Fri, Dec 15, 2023 at 02:52:07PM +0100, Herve Codina wrote:  
> > > > > On Mon, 4 Dec 2023 07:59:09 -0600
> > > > > Rob Herring <robh@kernel.org> wrote:  
> > > > > > On Mon, Dec 4, 2023 at 6:43 AM Herve Codina <herve.codina@bootlin.com> wrote:  
> > > > > > > On Fri, 1 Dec 2023 16:26:45 -0600
> > > > > > > Rob Herring <robh@kernel.org> wrote:  
> > > > > > > > On Thu, Nov 30, 2023 at 10:57 AM Herve Codina <herve.codina@bootlin.com> wrote:
> > > > > > > > ...  
> > > >  
> > > > > > > > --- a/drivers/pci/of.c
> > > > > > > > +++ b/drivers/pci/of.c
> > > > > > > > @@ -31,6 +31,8 @@ int pci_set_of_node(struct pci_dev *dev)
> > > > > > > >                 return 0;
> > > > > > > >
> > > > > > > >         node = of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
> > > > > > > > +       if (!node && pci_is_bridge(dev))
> > > > > > > > +               of_pci_make_dev_node(dev);
> > > > > > > >         if (!node)
> > > > > > > >                 return 0;  
> > > > > > >
> > > > > > > Maybe it is too early.
> > > > > > > of_pci_make_dev_node() creates a node and fills some properties based on
> > > > > > > some already set values available in the PCI device such as its struct resource
> > > > > > > values.
> > > > > > > We need to have some values set by the PCI infra in order to create our DT node
> > > > > > > with correct values.  
> > > > > >
> > > > > > Indeed, that's probably the issue I'm having. In that case,
> > > > > > DECLARE_PCI_FIXUP_HEADER should work. That's later, but still before
> > > > > > device_add().
> > > > > >
> > > > > > I think modifying sysfs after device_add() is going to race with
> > > > > > userspace. Userspace is notified of a new device, and then the of_node
> > > > > > link may or may not be there when it reads sysfs. Also, not sure if
> > > > > > we'll need DT modaliases with PCI devices, but they won't work if the
> > > > > > DT node is not set before device_add().  
> > > > >
> > > > > DECLARE_PCI_FIXUP_HEADER is too early as well as doing the DT node creation
> > > > > just before the device_add() call.
> > > > > Indeed, in order to fill the DT properties, resources need to be assigned
> > > > > (needed for the 'ranges' property used for addresses translation).
> > > > > The resources assignment is done after the call to device_add().  
> > > >
> > > > Do we need to know the actual address *value* before creating the
> > > > sysfs file, or is it enough to know that the file should *exist*, even
> > > > if the value may be changed later?  
> > >
> > > I think, the problematic file is 'of_node'.
> > > This file is a symlink present in the device directory pointing to the
> > > node in a device-tree subdir.
> > >
> > > How can we create this of_node symlink without having the device-tree
> > > subdir available ?
> > >  
> > > > > Some PCI sysfs files are already created after adding the device by the
> > > > > pci_create_sysfs_dev_files() call:
> > > > >   https://elixir.bootlin.com/linux/v6.6/source/drivers/pci/bus.c#L347
> > > > >
> > > > > Is it really an issue to add the of_node link to sysfs on an already
> > > > > present device ?  
> > > >
> > > > Yes, I think this would be an issue.  We've been trying to get rid of
> > > > pci_create_sysfs_dev_files() altogether because there's a long history
> > > > of race issues related to it:
> > > >
> > > >   https://lore.kernel.org/r/1271099285.9831.13.camel@localhost/ WARNING: at fs/sysfs/dir.c:451 sysfs_add_one: sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:01.0/slot'
> > > >   https://lore.kernel.org/r/19461.26166.427857.612983@pilspetsen.it.uu.se/ [2.6.35-rc1 regression] sysfs: cannot create duplicate filename ... XVR-600 related?
> > > >   https://lore.kernel.org/r/20200716110423.xtfyb3n6tn5ixedh@pali/ PCI: Race condition in pci_create_sysfs_dev_files
> > > >   https://lore.kernel.org/r/m3eebg9puj.fsf@t19.piap.pl/ PCI: Race condition in pci_create_sysfs_dev_files (can't boot)
> > > >   https://bugzilla.kernel.org/show_bug.cgi?id=215515 sysfs: cannot create duplicate filename '.../0000:e0'
> > > >
> > > > And several previous attempts to fix them:
> > > >
> > > >   https://lore.kernel.org/r/4469eba2-188b-aab7-07d1-5c77313fc42f@gmail.com/ Guard pci_create_sysfs_dev_files with atomic value
> > > >   https://lore.kernel.org/r/20230316103036.1837869-1-alexander.stein@ew.tq-group.com PCI/sysfs: get rid of pci_sysfs_init late_initcall
> > > >   https://lore.kernel.org/r/1702093576-30405-1-git-send-email-ssengar@linux.microsoft.com/ PCI/sysfs: Fix race in pci sysfs creation
> > > >  
> > >
> > > I am not sure we are facing in the same kind of issues.
> > > The ones you mentioned are related to some sysfs duplication.
> > > In the of_node case, the issue (if any) is that the symlink will be created
> > > after the other device's file. Not sure that it can lead to some file
> > > duplication.  
> > 
> > Again, if you notify userspace and it wants to make some decisions
> > based on of_node, then it has to be there when the notification
> > happens. As Greg says frequently, you've raced with userspace and
> > lost.
> > 
> > I imagine Bjorn won't like it, but may we need another fixup point?
> 
> I'am not sure that a fixup point can fix the issue.
> 
> In order to have the of_node available before the notification, we need
> to a have the of_node set and filled before the device_add() call.
> 
> In order to create the 'ranges' property in the DT node, we need PCI
> resources computed. These resources are computed after the device_add()
> call.

I guess this is the problem that pci_assign_unassigned_resources() and
similar are called after device_add(), right?  That seems kind of
problematic in general since device_add() exposes /sys/.../resource
before they may be valid.  But I don't know how to fix that.

Bjorn

