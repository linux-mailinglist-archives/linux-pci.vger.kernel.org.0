Return-Path: <linux-pci+bounces-1068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8E58149A8
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 14:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6237228204A
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 13:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57092DB8F;
	Fri, 15 Dec 2023 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AhQMg725"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE0E30321;
	Fri, 15 Dec 2023 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3536CC0002;
	Fri, 15 Dec 2023 13:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702648330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67tH9Lo75qwYdI0cY5235H5ZCDe4KzYpnxFS6WHpsZU=;
	b=AhQMg725HDtwge0C7ZYbVFamrWIvnnqMmX5bOvdVGgduFneloWsGRK1qTb482V1QEmwiIY
	N3LvDMKW1IoEsIAoA8zdYBNPFUee4OH32mov7xifnXCJzuDuYDlgw+w//JdQ44chBc8ZyL
	kYlGPI9g8wFfi5OQ5x9S8Z3Sslnqievz7esEZsytFuoa4Ud6tQyXce8FnjuxAgixBuXAh1
	Vy3MbELUnRB0UBnpSG82Z5lN7Ed7tjqdJL7uRkftBj/YmpUs2hIz5M6n2C54ZrkfwUVxLm
	GWLR3vVlmJtDN4KiXP4CibygA9z81a4y9EQbjqVYgecH6orHbfnPp6ui48SIxw==
Date: Fri, 15 Dec 2023 14:52:07 +0100
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
Message-ID: <20231215145207.0cf098e5@bootlin.com>
In-Reply-To: <CAL_JsqLtCS3otZ1sfiPEWwrWB4dyNpu4e0xANWJriCEUYr+4Og@mail.gmail.com>
References: <20231130165700.685764-1-herve.codina@bootlin.com>
	<CAL_JsqJvt6FpXK+FgAwE8xN3G5Z23Ktq=SEY-K7VA7nM5XgZRg@mail.gmail.com>
	<20231204134335.3ded3d46@bootlin.com>
	<CAL_JsqLtCS3otZ1sfiPEWwrWB4dyNpu4e0xANWJriCEUYr+4Og@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
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

On Mon, 4 Dec 2023 07:59:09 -0600
Rob Herring <robh@kernel.org> wrote:

> On Mon, Dec 4, 2023 at 6:43 AM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > Hi Rob,
> >
> > On Fri, 1 Dec 2023 16:26:45 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >  
> > > On Thu, Nov 30, 2023 at 10:57 AM Herve Codina <herve.codina@bootlin.com> wrote:  
> > > >
> > > > Hi,
> > > >
> > > > The commit 407d1a51921e ("PCI: Create device tree node for bridge")
> > > > creates of_node for PCI devices.
> > > > During the insertion handling of these new DT nodes done by of_platform,
> > > > new devices (struct device) are created.
> > > > For each PCI devices a struct device is already present (created and
> > > > handled by the PCI core).
> > > > Creating a new device from a DT node leads to some kind of wrong struct
> > > > device duplication to represent the exact same PCI device.
> > > >
> > > > This patch series first introduces device_{add,remove}_of_node() in
> > > > order to add or remove a newly created of_node to an already existing
> > > > device.
> > > > Then it fixes the DT node creation for PCI devices to add or remove the
> > > > created node to the existing PCI device without any new device creation.  
> > >
> > > I think the simpler solution is to get the DT node created earlier. We
> > > are just asking for pain if the DT node is set for the device at
> > > different times compared to static DT nodes.
> > >
> > > The following fixes the lack of of_node link. The DT unittest fails
> > > with the change though and I don't see why.
> > >
> > > Also, no idea if the bridge part works because my qemu setup doesn't
> > > create bridges (anyone got a magic cmdline to create them?).
> > >
> > > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > > index 9c2137dae429..46b252bbe500 100644
> > > --- a/drivers/pci/bus.c
> > > +++ b/drivers/pci/bus.c
> > > @@ -342,8 +342,6 @@ void pci_bus_add_device(struct pci_dev *dev)
> > >          */
> > >         pcibios_bus_add_device(dev);
> > >         pci_fixup_device(pci_fixup_final, dev);
> > > -       if (pci_is_bridge(dev))
> > > -               of_pci_make_dev_node(dev);
> > >         pci_create_sysfs_dev_files(dev);
> > >         pci_proc_attach_device(dev);
> > >         pci_bridge_d3_update(dev);
> > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > index 51e3dd0ea5ab..e15eaf0127fc 100644
> > > --- a/drivers/pci/of.c
> > > +++ b/drivers/pci/of.c
> > > @@ -31,6 +31,8 @@ int pci_set_of_node(struct pci_dev *dev)
> > >                 return 0;
> > >
> > >         node = of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
> > > +       if (!node && pci_is_bridge(dev))
> > > +               of_pci_make_dev_node(dev);
> > >         if (!node)
> > >                 return 0;  
> >
> > Maybe it is too early.
> > of_pci_make_dev_node() creates a node and fills some properties based on
> > some already set values available in the PCI device such as its struct resource
> > values.
> > We need to have some values set by the PCI infra in order to create our DT node
> > with correct values.  
> 
> Indeed, that's probably the issue I'm having. In that case,
> DECLARE_PCI_FIXUP_HEADER should work. That's later, but still before
> device_add().
> 
> I think modifying sysfs after device_add() is going to race with
> userspace. Userspace is notified of a new device, and then the of_node
> link may or may not be there when it reads sysfs. Also, not sure if
> we'll need DT modaliases with PCI devices, but they won't work if the
> DT node is not set before device_add().
> 
> Rob

DECLARE_PCI_FIXUP_HEADER is too early as well as doing the DT node creation
just before the device_add() call.
Indeed, in order to fill the DT properties, resources need to be assigned
(needed for the 'ranges' property used for addresses translation).
The resources assignment is done after the call to device_add().

Some PCI sysfs files are already created after adding the device by the
pci_create_sysfs_dev_files() call:
  https://elixir.bootlin.com/linux/v6.6/source/drivers/pci/bus.c#L347

Is it really an issue to add the of_node link to sysfs on an already present
device ?

Maybe we can add the of_node link before the device_add() call and add the
'ranges' property in the DT node later, once resources are assigned.
In that case, the race condition is not fixed but moved from the PCI device
to the DT node the device is pointing to.
With DT overlays and of_changeset_*(), modifying nodes is a normal behavior.
Is that acceptable for the 'ranges' property in this use-case ?

Best regards,
Hervé

