Return-Path: <linux-pci+bounces-648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2442809E94
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDE2281306
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 08:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7AD10975;
	Fri,  8 Dec 2023 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OtKH0ven"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAF9172C;
	Fri,  8 Dec 2023 00:48:45 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C12FC0002;
	Fri,  8 Dec 2023 08:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702025322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BI/a9kd3lyurB+jcttNXOa/XaS8zgyXI4PkPmj1fYQc=;
	b=OtKH0venALl7A2QhgJRFyZltpGLlG6YDjqcRcLP4+ioDu0kWHpTJr7n3+Wa5f/AVb52L7v
	sQ7xGzfKdbCtD08vVBb51WHnzOL3YHE5LkOkDckyEQ0+BAvqF3DTjaKc1lBvl+zfLKH/DQ
	OcfO7uJKt7/KrgNwd3r0ixqzVUurngPx1s2jzs6NkdLdw1oBqerOmYZXzmL+xaZgp5fCbN
	bWmUIPLxW8MTcTgGkR20ktTBrCtFZmKap1/tA4jJ55F+BiAB686jtCitOt3Gflw8Lt9u++
	UNBmL9m61OycftBOiWT2nG9x+ph228aFBSQ58iwT084dfGCt8Iihheplhhdsxw==
Date: Fri, 8 Dec 2023 09:48:40 +0100
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
Message-ID: <20231208094840.01d74fec@bootlin.com>
In-Reply-To: <CAL_Jsq+je7+9ATR=B6jXHjEJHjn24vQFs4Tvi9=vhDeK9n42Aw@mail.gmail.com>
References: <20231130165700.685764-1-herve.codina@bootlin.com>
	<CAL_JsqJvt6FpXK+FgAwE8xN3G5Z23Ktq=SEY-K7VA7nM5XgZRg@mail.gmail.com>
	<20231204134335.3ded3d46@bootlin.com>
	<CAL_JsqLtCS3otZ1sfiPEWwrWB4dyNpu4e0xANWJriCEUYr+4Og@mail.gmail.com>
	<20231204163014.4da383f2@bootlin.com>
	<CAL_JsqJJ64513pyQggU71agTzawNWPpm6ZpWMB6e0zu-tWL8yw@mail.gmail.com>
	<20231205090452.7c601eb5@bootlin.com>
	<CAL_Jsq+je7+9ATR=B6jXHjEJHjn24vQFs4Tvi9=vhDeK9n42Aw@mail.gmail.com>
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

On Thu, 7 Dec 2023 16:51:56 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, Dec 5, 2023 at 2:05 AM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > On Mon, 4 Dec 2023 17:03:21 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >  
> > > On Mon, Dec 4, 2023 at 9:30 AM Herve Codina <herve.codina@bootlin.com> wrote:  
> > > >
> > > > Hi Rob,
> > > >
> > > > On Mon, 4 Dec 2023 07:59:09 -0600
> > > > Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > [...]
> > > >  
> > > > > > > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > > > > > > index 9c2137dae429..46b252bbe500 100644
> > > > > > > --- a/drivers/pci/bus.c
> > > > > > > +++ b/drivers/pci/bus.c
> > > > > > > @@ -342,8 +342,6 @@ void pci_bus_add_device(struct pci_dev *dev)
> > > > > > >          */
> > > > > > >         pcibios_bus_add_device(dev);
> > > > > > >         pci_fixup_device(pci_fixup_final, dev);
> > > > > > > -       if (pci_is_bridge(dev))
> > > > > > > -               of_pci_make_dev_node(dev);
> > > > > > >         pci_create_sysfs_dev_files(dev);
> > > > > > >         pci_proc_attach_device(dev);
> > > > > > >         pci_bridge_d3_update(dev);
> > > > > > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > > > > > index 51e3dd0ea5ab..e15eaf0127fc 100644
> > > > > > > --- a/drivers/pci/of.c
> > > > > > > +++ b/drivers/pci/of.c
> > > > > > > @@ -31,6 +31,8 @@ int pci_set_of_node(struct pci_dev *dev)
> > > > > > >                 return 0;
> > > > > > >
> > > > > > >         node = of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
> > > > > > > +       if (!node && pci_is_bridge(dev))
> > > > > > > +               of_pci_make_dev_node(dev);
> > > > > > >         if (!node)
> > > > > > >                 return 0;  
> > > > > >
> > > > > > Maybe it is too early.
> > > > > > of_pci_make_dev_node() creates a node and fills some properties based on
> > > > > > some already set values available in the PCI device such as its struct resource
> > > > > > values.
> > > > > > We need to have some values set by the PCI infra in order to create our DT node
> > > > > > with correct values.  
> > > > >
> > > > > Indeed, that's probably the issue I'm having. In that case,
> > > > > DECLARE_PCI_FIXUP_HEADER should work. That's later, but still before
> > > > > device_add().
> > > > >
> > > > > I think modifying sysfs after device_add() is going to race with
> > > > > userspace. Userspace is notified of a new device, and then the of_node
> > > > > link may or may not be there when it reads sysfs. Also, not sure if
> > > > > we'll need DT modaliases with PCI devices, but they won't work if the
> > > > > DT node is not set before device_add().  
> > > >
> > > > Ok, we can try using DECLARE_PCI_FIXUP_HEADER.
> > > > On your side, is moving from DECLARE_PCI_FIXUP_EARLY to DECLARE_PCI_FIXUP_HEADER
> > > > fix your QEMU unittest ?  
> > >
> > > No...  
> 
> I think the problem is we aren't setting the fwnode, just the of_node
> ptr, but I haven't had a chance to verify that.
> 
> > > And testing the bridge part crashes. That's because there's a
> > > dependency on the bridge->subordinate to write out bus-range and
> > > interrupt-map. I think the fix there is we should just not write those
> > > properties. The bus range isn't needed because the kernel does its own
> > > assignments. For interrupt-map, it is only needed if "interrupts" is
> > > present in the child devices. If not present, then the standard PCI
> > > swizzling is used. Alternatively, I think the interrupt mapping could
> > > be simplified to just implement the standard swizzling at each level
> > > which isn't dependent on any of the devices on the bus. I gave that a
> > > go where each interrupt-map just points to the parent bridge, but ran
> > > into an issue that the bridge nodes don't have a phandle. That should
> > > be fixable, but I'd rather go with the first option. I suppose that
> > > depends on how the interrupts downstream of the PCI device need to get
> > > resolved. It could be that the PCI device serves as the interrupt
> > > controller and can resolve the parent interrupt on its own (which may
> > > be needed for ACPI host anyways).  
> >
> > About interrupt, I am a bit stuck on my side.
> > My dtso (applied at PCI device level) contains the following:
> >         fragment@0 {
> >                 target-path="";
> >                 __overlay__ {
> >                         pci-ep-bus@0 {
> >                                 compatible = "simple-bus";
> >                                 #address-cells = <1>;
> >                                 #size-cells = <1>;
> >
> >                                 /*
> >                                  * map @0xe2000000 (32MB) to BAR0 (CPU)
> >                                  * map @0xe0000000 (16MB) to BAR1 (AMBA)
> >                                  */
> >                                 ranges = <0xe2000000 0x00 0x00 0x00 0x2000000
> >                                           0xe0000000 0x01 0x00 0x00 0x1000000>;
> >
> >                                 itc: itc {
> >                                         compatible = "microchip,lan966x-itc";
> >                                         #interrupt-cells = <1>;
> >                                         interrupt-controller;
> >                                         reg = <0xe00c0120 0x190>;
> >                                 };
> >
> >                                 ...
> >                          };
> >                 };
> >         };
> >
> > I have a 'simple-bus' with a 'ranges' property to translate the BAR addresses
> > then several devices. Among them a interrupt controller (itc). Its parent
> > interrupt is the one used by the PCI device (INTA).
> > I cannot describe this parent interrupt in the dtso because to that I need the
> > parent interrupt phandle which will be know only at runtime.  
> 
> But you don't. The logic to find the interrupt parent is walk up the
> parent nodes until you find 'interrupt-parent' or
> '#interrupt-controller' (and interrupt-map always has
> #interrupt-controller). So your overlay just needs 'interrupts = <1>'
> for INTA and it should all just work.

Yes, I tried some stuffs in that way...
> 
> That of course implies that we need interrupt properties in all the
> bridges which I was hoping to avoid. In the ACPI case, for DT
> interrupt parsing to work, we're going to need to end up in an
> 'interrupt-controller' node somewhere. I think the options are either

... and I went up to that point.
Further more with that way, we need to update the addr value retrieved
from the device requesting the interrupt.
  https://elixir.bootlin.com/linux/latest/source/drivers/of/irq.c#L343
Indeed, with the current 'interrupt-map' at bridges level, a addr value
update is needed at the PCI device level if the interrupt is requested
from some PCI device children.
This is were my (not so good) interrupt-ranges property could play a
role.

> we walk interrupt-map properties up to the host bridge which then
> points to something or the PCI device is the interrupt controller. I
> think the PCI device is the right place. How the downstream interrupts

Agree, the PCI device seems to be the best candidate.

> are routed to PCI interrupts are defined by the device. That would
> work the same way for both DT and ACPI. If you are concerned about
> implementing in each driver needing this, some library functions can
> mitigate that.
> 
> I'm trying to play around with the IRQ domains and get this to work,
> but not having any luck yet.

May I help you on some points?

Got a system with a real hardware (Lan966x) and a setup using an ARM platform (full
DT) and an other one using an x86 platform (ACPI).
Also, I have some piece of code to create the PCI host bridge node.
Of course, this need to be first working on a full DT system but I can do some test
to be sure that can be still ok on a ACPI system.

> 
> > Of course, I can modified the overlay applied to tweak the 'interrupt' and
> > 'interrupt-parent' in the itc node from my PCI device driver at runtime but I
> > would like to avoid this kind of tweak in the PCI device driver.
> > This kind of tweak is overlay dependent and needs to be done by each PCI
> > device driver that need to work with interrupts.
> >
> > For BAR addresses translation, we use the 'ranges' property at the PCI device
> > node to translate 0 0 0 to BAR0, 1 0 0 to BAR1, ...
> > What do you think about a new 'irq-ranges' property to translate the irq number
> > and get the irq parent controller base.
> >
> > irq-ranges = <child_irq_spec parent_irq_spec length>;  
> 
> Seems fragile as you have to know something about the parent (the # of
> cells), but you don't have the phandle. If you needed multiple
> entries, you couldn't parse this.
> 

Right.
With the PCI device seen as an interrupt controller, there is no more need of
this interrup-ranges property.

Best regards,
Hervé

