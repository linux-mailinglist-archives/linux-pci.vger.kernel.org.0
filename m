Return-Path: <linux-pci+bounces-4916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA2B8802C3
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 17:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41D31F2368A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 16:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D07107B2;
	Tue, 19 Mar 2024 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxi6F/fE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B275AFC11;
	Tue, 19 Mar 2024 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867272; cv=none; b=fcdWJxpTIVItoS5t95tE/N6F2BV8o3DQlazIjjVIFHuoeK8LUSCdRLdSmDk2POUAwAdP6WvpQSicV7lULBt5PjWt7cVaKHCIsgvNbzudi2VXwNZWNXh/adTuCzRLEBnE36Qxk7T3/+81Ij0a9pe6xGA4ShHmsFcsupK76WgTqkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867272; c=relaxed/simple;
	bh=AX86/uApYODY1eC2g52++zk0AHcfVOmzwn1mtmShqm0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Xzw5Ds5Qq6uxsGPbt1BItwbVCXFOsR6LIcVW/WUWGI4EEcdHfLiid74v2Wa7Lzp6vWBwl75ZqHvrFXYkIb2v2nTuZyat8ABE5bcE2IPOxo1W2d+yaZ1LK/ls0ZdlIe+bSmRvnagzxOPJNiwdPhPF5Qimx8A9sc/nwets7FYPhfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxi6F/fE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57404C433C7;
	Tue, 19 Mar 2024 16:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710867272;
	bh=AX86/uApYODY1eC2g52++zk0AHcfVOmzwn1mtmShqm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rxi6F/fEVU5bctBaJV8eFes6+BIUxhQCW9pTS3hKs6tAuASEIhmtK++dy76bjCYh0
	 y7ZOtD27O4Ascoi2WwNSwWf8TPrrcgZsLP2O1pZg1Cf+bdDeFGhtKW1LttuwTbq4+e
	 UCmrSP8Y/+P3wtomLv3UIGkuBHkHck4mE9XiBaaRsQZ+VHvlpb9FqdtqxP6aAEklm2
	 AeiB2gjkbVVvcpxAl54waZSkq3JJ21MvYhVAtfTKbQgBIPDlKHyJtmiELiwafwy0Y/
	 irjBwqnBA/prQicVVvho4m5xf6BRTVaTXPoF/g50axeopnstK7Ub+pzUQr844fe0tp
	 Pw/Bt6g81wizA==
Date: Tue, 19 Mar 2024 11:54:30 -0500
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
Message-ID: <20240319165430.GA1233494@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319173404.019b424a@bootlin.com>

On Tue, Mar 19, 2024 at 05:34:04PM +0100, Herve Codina wrote:
> On Tue, 19 Mar 2024 10:25:13 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Dec 15, 2023 at 02:52:07PM +0100, Herve Codina wrote:
> > > On Mon, 4 Dec 2023 07:59:09 -0600
> > > Rob Herring <robh@kernel.org> wrote:  
> > > > On Mon, Dec 4, 2023 at 6:43 AM Herve Codina <herve.codina@bootlin.com> wrote:  
> > > > > On Fri, 1 Dec 2023 16:26:45 -0600
> > > > > Rob Herring <robh@kernel.org> wrote:  
> > > > > > On Thu, Nov 30, 2023 at 10:57 AM Herve Codina <herve.codina@bootlin.com> wrote:  
> > > > > > ...  
> > 
> > > > > > --- a/drivers/pci/of.c
> > > > > > +++ b/drivers/pci/of.c
> > > > > > @@ -31,6 +31,8 @@ int pci_set_of_node(struct pci_dev *dev)
> > > > > >                 return 0;
> > > > > >
> > > > > >         node = of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
> > > > > > +       if (!node && pci_is_bridge(dev))
> > > > > > +               of_pci_make_dev_node(dev);
> > > > > >         if (!node)
> > > > > >                 return 0;    
> > > > >
> > > > > Maybe it is too early.
> > > > > of_pci_make_dev_node() creates a node and fills some properties based on
> > > > > some already set values available in the PCI device such as its struct resource
> > > > > values.
> > > > > We need to have some values set by the PCI infra in order to create our DT node
> > > > > with correct values.    
> > > > 
> > > > Indeed, that's probably the issue I'm having. In that case,
> > > > DECLARE_PCI_FIXUP_HEADER should work. That's later, but still before
> > > > device_add().
> > > > 
> > > > I think modifying sysfs after device_add() is going to race with
> > > > userspace. Userspace is notified of a new device, and then the of_node
> > > > link may or may not be there when it reads sysfs. Also, not sure if
> > > > we'll need DT modaliases with PCI devices, but they won't work if the
> > > > DT node is not set before device_add().  
> > > 
> > > DECLARE_PCI_FIXUP_HEADER is too early as well as doing the DT node creation
> > > just before the device_add() call.
> > > Indeed, in order to fill the DT properties, resources need to be assigned
> > > (needed for the 'ranges' property used for addresses translation).
> > > The resources assignment is done after the call to device_add().  
> > 
> > Do we need to know the actual address *value* before creating the
> > sysfs file, or is it enough to know that the file should *exist*, even
> > if the value may be changed later?
> 
> I think, the problematic file is 'of_node'.
> This file is a symlink present in the device directory pointing to the
> node in a device-tree subdir.
> 
> How can we create this of_node symlink without having the device-tree
> subdir available ?
> 
> > > Some PCI sysfs files are already created after adding the device by the
> > > pci_create_sysfs_dev_files() call:
> > >   https://elixir.bootlin.com/linux/v6.6/source/drivers/pci/bus.c#L347
> > > 
> > > Is it really an issue to add the of_node link to sysfs on an already
> > > present device ?  
> > 
> > Yes, I think this would be an issue.  We've been trying to get rid of
> > pci_create_sysfs_dev_files() altogether because there's a long history
> > of race issues related to it:
> > 
> >   https://lore.kernel.org/r/1271099285.9831.13.camel@localhost/ WARNING: at fs/sysfs/dir.c:451 sysfs_add_one: sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:01.0/slot'
> >   https://lore.kernel.org/r/19461.26166.427857.612983@pilspetsen.it.uu.se/ [2.6.35-rc1 regression] sysfs: cannot create duplicate filename ... XVR-600 related?
> >   https://lore.kernel.org/r/20200716110423.xtfyb3n6tn5ixedh@pali/ PCI: Race condition in pci_create_sysfs_dev_files
> >   https://lore.kernel.org/r/m3eebg9puj.fsf@t19.piap.pl/ PCI: Race condition in pci_create_sysfs_dev_files (can't boot)
> >   https://bugzilla.kernel.org/show_bug.cgi?id=215515 sysfs: cannot create duplicate filename '.../0000:e0'
> > 
> > And several previous attempts to fix them:
> > 
> >   https://lore.kernel.org/r/4469eba2-188b-aab7-07d1-5c77313fc42f@gmail.com/ Guard pci_create_sysfs_dev_files with atomic value
> >   https://lore.kernel.org/r/20230316103036.1837869-1-alexander.stein@ew.tq-group.com PCI/sysfs: get rid of pci_sysfs_init late_initcall
> >   https://lore.kernel.org/r/1702093576-30405-1-git-send-email-ssengar@linux.microsoft.com/ PCI/sysfs: Fix race in pci sysfs creation
> 
> I am not sure we are facing in the same kind of issues.
> The ones you mentioned are related to some sysfs duplication.
> In the of_node case, the issue (if any) is that the symlink will be created
> after the other device's file. Not sure that it can lead to some file
> duplication.

It sounds different and maybe not a problem.  I saw
pci_create_sysfs_dev_files() and was afraid you planned to add
something there when we're trying to remove it.

Bjorn

