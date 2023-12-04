Return-Path: <linux-pci+bounces-427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520778038DB
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 16:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4C45B20B11
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 15:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9322C1BD;
	Mon,  4 Dec 2023 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bfXoqu1S"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625F0B0;
	Mon,  4 Dec 2023 07:30:19 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7344C0002;
	Mon,  4 Dec 2023 15:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701703818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lC9iyWjs9SLEvLAN2a3GzP/PTmAJHX40lkoy38ZLB0k=;
	b=bfXoqu1SHr+oH1qgM13BQ42PmdEr/OrtXWgYNyd4mi0IvjPKxdaXM34KEWtWo2ZPDDOaNN
	2aVnMnk3QAOsLzzljcSKG1BwvrSt8QFxEFnvdpGstNTny56/CtegMepgR6P5DbgsDkTxE3
	U3hIxUH+Na9u6pEOwjEZ7Iapj6uZ7fi9fpDVcHvTd1PkHItobDD4/Z94fhF8qYF4YivGEW
	8W6UEkCcCdLnW/88B1GPkQMNac7/XPvL11hI+nGeWh3Kof7ZjAegaV9lHL0u/DJ9Cb9qwL
	26suZIke97jSjH1eMR2uy7yugCsBW2JIkP6o9CbX713c9oVGJYR3Rd8CzYg6rw==
Date: Mon, 4 Dec 2023 16:30:14 +0100
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
Message-ID: <20231204163014.4da383f2@bootlin.com>
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

[...]

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

Ok, we can try using DECLARE_PCI_FIXUP_HEADER.
On your side, is moving from DECLARE_PCI_FIXUP_EARLY to DECLARE_PCI_FIXUP_HEADER
fix your QEMU unittest ?

We have to note that between the pci_fixup_device(pci_fixup_header, dev) call
and the device_add() call, the call to pci_set_msi_domain() is present.
MSIs are not supported currently but in the future ...

Related to DT modaliases, I don't think they are needed.
All drivers related to PCI device should be declared as pci_driver.
Correct me if I am wrong but I think that the core PCI will load the correct
module without any DT modalias.

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

