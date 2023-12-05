Return-Path: <linux-pci+bounces-442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDC4804BC3
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 09:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56011F214E6
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 08:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D7E3B7A8;
	Tue,  5 Dec 2023 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KNLdX44j"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11394A7;
	Tue,  5 Dec 2023 00:04:55 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 38AC06000A;
	Tue,  5 Dec 2023 08:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701763494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yOxyM1VVAEYmoQR0JhTaqTr0LD8ymtcagmKNqWRYF40=;
	b=KNLdX44jJ1CvnYYoEkUGCmh4rjw+Z0Y7cSixIcTW60z6Wjl1UpmBi2qfN9CI3LHubL6hXG
	5eH1vvgCrKDt8GIXRhanKbRHIKx+wgSrHVAlXg7zjXL/qpEOaOaYy+a6kTTs4yIP8K2Bwo
	00RqG+UdmvyRYGHsG63zHZenLSTp7V59NrAk3xon9F4MXGEMBneKaa2LJmj0lECKw8kOdv
	sim7w9oTpjhAaM7K4WwQkiBpIPS2JOialvtljLjj5NzuK3AnlsBFv+XGwi3I40glF9zYac
	ECaGH3JhFIkyv12xZgInUNj4csEzfWTzQTR7kUr7rC0IWW7nxWKsL01cyDaRog==
Date: Tue, 5 Dec 2023 09:04:52 +0100
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
Message-ID: <20231205090452.7c601eb5@bootlin.com>
In-Reply-To: <CAL_JsqJJ64513pyQggU71agTzawNWPpm6ZpWMB6e0zu-tWL8yw@mail.gmail.com>
References: <20231130165700.685764-1-herve.codina@bootlin.com>
	<CAL_JsqJvt6FpXK+FgAwE8xN3G5Z23Ktq=SEY-K7VA7nM5XgZRg@mail.gmail.com>
	<20231204134335.3ded3d46@bootlin.com>
	<CAL_JsqLtCS3otZ1sfiPEWwrWB4dyNpu4e0xANWJriCEUYr+4Og@mail.gmail.com>
	<20231204163014.4da383f2@bootlin.com>
	<CAL_JsqJJ64513pyQggU71agTzawNWPpm6ZpWMB6e0zu-tWL8yw@mail.gmail.com>
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

On Mon, 4 Dec 2023 17:03:21 -0600
Rob Herring <robh@kernel.org> wrote:

> On Mon, Dec 4, 2023 at 9:30 AM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > Hi Rob,
> >
> > On Mon, 4 Dec 2023 07:59:09 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >
> > [...]
> >  
> > > > > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > > > > index 9c2137dae429..46b252bbe500 100644
> > > > > --- a/drivers/pci/bus.c
> > > > > +++ b/drivers/pci/bus.c
> > > > > @@ -342,8 +342,6 @@ void pci_bus_add_device(struct pci_dev *dev)
> > > > >          */
> > > > >         pcibios_bus_add_device(dev);
> > > > >         pci_fixup_device(pci_fixup_final, dev);
> > > > > -       if (pci_is_bridge(dev))
> > > > > -               of_pci_make_dev_node(dev);
> > > > >         pci_create_sysfs_dev_files(dev);
> > > > >         pci_proc_attach_device(dev);
> > > > >         pci_bridge_d3_update(dev);
> > > > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > > > index 51e3dd0ea5ab..e15eaf0127fc 100644
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
> > Ok, we can try using DECLARE_PCI_FIXUP_HEADER.
> > On your side, is moving from DECLARE_PCI_FIXUP_EARLY to DECLARE_PCI_FIXUP_HEADER
> > fix your QEMU unittest ?  
> 
> No...
> 
> And testing the bridge part crashes. That's because there's a
> dependency on the bridge->subordinate to write out bus-range and
> interrupt-map. I think the fix there is we should just not write those
> properties. The bus range isn't needed because the kernel does its own
> assignments. For interrupt-map, it is only needed if "interrupts" is
> present in the child devices. If not present, then the standard PCI
> swizzling is used. Alternatively, I think the interrupt mapping could
> be simplified to just implement the standard swizzling at each level
> which isn't dependent on any of the devices on the bus. I gave that a
> go where each interrupt-map just points to the parent bridge, but ran
> into an issue that the bridge nodes don't have a phandle. That should
> be fixable, but I'd rather go with the first option. I suppose that
> depends on how the interrupts downstream of the PCI device need to get
> resolved. It could be that the PCI device serves as the interrupt
> controller and can resolve the parent interrupt on its own (which may
> be needed for ACPI host anyways).

About interrupt, I am a bit stuck on my side.
My dtso (applied at PCI device level) contains the following:
	fragment@0 {
		target-path="";
		__overlay__ {
			pci-ep-bus@0 {
				compatible = "simple-bus";
				#address-cells = <1>;
				#size-cells = <1>;

				/*
				 * map @0xe2000000 (32MB) to BAR0 (CPU)
				 * map @0xe0000000 (16MB) to BAR1 (AMBA)
				 */
				ranges = <0xe2000000 0x00 0x00 0x00 0x2000000
				          0xe0000000 0x01 0x00 0x00 0x1000000>;

				itc: itc {
					compatible = "microchip,lan966x-itc";
					#interrupt-cells = <1>;
					interrupt-controller;
					reg = <0xe00c0120 0x190>;
				};
				
				...
			 };
		};
	};

I have a 'simple-bus' with a 'ranges' property to translate the BAR addresses
then several devices. Among them a interrupt controller (itc). Its parent
interrupt is the one used by the PCI device (INTA).
I cannot describe this parent interrupt in the dtso because to that I need the
parent interrupt phandle which will be know only at runtime.
Of course, I can modified the overlay applied to tweak the 'interrupt' and
'interrupt-parent' in the itc node from my PCI device driver at runtime but I
would like to avoid this kind of tweak in the PCI device driver.
This kind of tweak is overlay dependent and needs to be done by each PCI
device driver that need to work with interrupts.

For BAR addresses translation, we use the 'ranges' property at the PCI device
node to translate 0 0 0 to BAR0, 1 0 0 to BAR1, ...
What do you think about a new 'irq-ranges' property to translate the irq number
and get the irq parent controller base.

irq-ranges = <child_irq_spec parent_irq_spec length>;

The idea would be to translate the child irq specifier (irq number +
possible flags) parent DT node.
if 'irq-ranges' present in parent translate irq spec then:
1) 'interrupt' present in parent.
   In that case, if the translation match, we use the translated irq spec
   and resolve the parent interrupt controller using existing ways from this
   node. If it does not match: error.
2) 'interrupt-map' present in parent.
   We use existing ways from this node with the translated irq spec to get the
   parent interrupt controller.
3) 'interrupt-controller' present in parent.
   We use this node as parent interrupt controller and the translated irq spec
4) no specific property present, update parent taking the parent's parent and
   go again.

With this the overlay becomes:
	pci-ep-bus@0 {
		compatible = "simple-bus";
		#address-cells = <1>;
		#size-cells = <1>;
		#interrupt-cells = <1>;

		/*
		 * map @0xe2000000 (32MB) to BAR0 (CPU)
		 * map @0xe0000000 (16MB) to BAR1 (AMBA)
		 */
		ranges = <0xe2000000 0x00 0x00 0x00 0x2000000
		          0xe0000000 0x01 0x00 0x00 0x1000000>;

		/* Translate PCI IRQ*/
		irq-ranges = <1 1 1>;

		itc: itc {
			compatible = "microchip,lan966x-itc";
			#interrupt-cells = <1>;
			interrupts = <1>;
			interrupt-controller;
			reg = <0xe00c0120 0x190>;
		};
		
		...
	 };

And the PCI device node built at runtime:
	dev@0,0 {
		#address-cells = <0x03>;
		interrupts = <0x01>;  <-- use parent interrupt-map
		#size-cells = <0x02>;
		compatible = "pci1055,9660\0pciclass,020000\0pciclass,0200";
		ranges = ...;
		irq-ranges = <1 0x01 1>
		reg = <0x10000 0x00 0x00 0x00 0x00>;
	};
or
	dev@0,0 {
		#address-cells = <0x03>;
		interrupts = <NN>;
		interrupts-parent = <phandle'
		#size-cells = <0x02>;
		compatible = "pci1055,9660\0pciclass,020000\0pciclass,0200";
		ranges = ...;
		irq-ranges = <1 NN 1>
		reg = <0x10000 0x00 0x00 0x00 0x00>;
	};

In the second case, interrup-map in bridges nodes is still needed to build the
'interrupts' / 'interrupts-parent' in devices nodes.
and irq-ranges (if it makes sense on your side) allow to get and interrupt from
the overlay without the need to know the irq parent phandle.

Regards,
Hervé

> 
> > We have to note that between the pci_fixup_device(pci_fixup_header, dev) call
> > and the device_add() call, the call to pci_set_msi_domain() is present.
> > MSIs are not supported currently but in the future ...  
> 
> MSI's aren't ever described in PCI nodes. Only the host bridge. So I
> don't think we should have problems there.
> 
> > Related to DT modaliases, I don't think they are needed.
> > All drivers related to PCI device should be declared as pci_driver.
> > Correct me if I am wrong but I think that the core PCI will load the correct
> > module without any DT modalias.  
> 
> Yes, you are probably right.
> 
> Rob



-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

