Return-Path: <linux-pci+bounces-422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD7E8035BD
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 14:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC4B280F29
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 13:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F81025751;
	Mon,  4 Dec 2023 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvUKm6gE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144F2249ED
	for <linux-pci@vger.kernel.org>; Mon,  4 Dec 2023 13:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896D7C433CB;
	Mon,  4 Dec 2023 13:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701698363;
	bh=bYySYTrY6km8QqIBfS1jsCvf7BxtvotE514DmN2BI3g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dvUKm6gEnRW/J2hJ2oXjEQevmQcNzI85MBDgq1ep44eZv3hCnekO1VJHRylY64pBZ
	 +kkCz/e1jnXaI+mV0ssMZRFKAMLRxiM/YJTjAGhY14jDoswMm2pNyCC6SXyjQEBVAK
	 avfydmD6j5hKbP2YrwYdrmghVLgS98T5Me9Tf/URFMSd07P5BRQXIi2/MKU0dOGvBB
	 m00W6gakm4+Z0Ombnbn+/zyWp8ehNyYIh88kfsKLXOizXam0s709XNJyFTcCnj8akb
	 XX7HH62V4I4j/u4ZN+QL+6zWky9HeFSZ05yMHcwGAfNom8KOFikiRnnlbElvddsKKt
	 a+nI1ZVO8x8Cw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50be0f13aa6so2389491e87.1;
        Mon, 04 Dec 2023 05:59:23 -0800 (PST)
X-Gm-Message-State: AOJu0Yx8T3rX1fCjod1rF4edzuf4DHrpqW/+gQkv1P+IBOqyRuiWf7UW
	PS2XmSFKxGL1uETuss/NgjT7if6C/hxp9zNQCA==
X-Google-Smtp-Source: AGHT+IHuLivC4GXamj5oh/MQSiPcrWiOW16KFkNBu3Zbi06bV91fPOeuY+xFcDhir6rlKE98/glumC1DZxfX5xrl5Pw=
X-Received: by 2002:a05:6512:3711:b0:50b:ffd7:d7b8 with SMTP id
 z17-20020a056512371100b0050bffd7d7b8mr57741lfr.21.1701698361702; Mon, 04 Dec
 2023 05:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130165700.685764-1-herve.codina@bootlin.com>
 <CAL_JsqJvt6FpXK+FgAwE8xN3G5Z23Ktq=SEY-K7VA7nM5XgZRg@mail.gmail.com> <20231204134335.3ded3d46@bootlin.com>
In-Reply-To: <20231204134335.3ded3d46@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 4 Dec 2023 07:59:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLtCS3otZ1sfiPEWwrWB4dyNpu4e0xANWJriCEUYr+4Og@mail.gmail.com>
Message-ID: <CAL_JsqLtCS3otZ1sfiPEWwrWB4dyNpu4e0xANWJriCEUYr+4Og@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Attach DT nodes to existing PCI devices
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, 
	Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, PCI <linux-pci@vger.kernel.org>, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 6:43=E2=80=AFAM Herve Codina <herve.codina@bootlin.c=
om> wrote:
>
> Hi Rob,
>
> On Fri, 1 Dec 2023 16:26:45 -0600
> Rob Herring <robh@kernel.org> wrote:
>
> > On Thu, Nov 30, 2023 at 10:57=E2=80=AFAM Herve Codina <herve.codina@boo=
tlin.com> wrote:
> > >
> > > Hi,
> > >
> > > The commit 407d1a51921e ("PCI: Create device tree node for bridge")
> > > creates of_node for PCI devices.
> > > During the insertion handling of these new DT nodes done by of_platfo=
rm,
> > > new devices (struct device) are created.
> > > For each PCI devices a struct device is already present (created and
> > > handled by the PCI core).
> > > Creating a new device from a DT node leads to some kind of wrong stru=
ct
> > > device duplication to represent the exact same PCI device.
> > >
> > > This patch series first introduces device_{add,remove}_of_node() in
> > > order to add or remove a newly created of_node to an already existing
> > > device.
> > > Then it fixes the DT node creation for PCI devices to add or remove t=
he
> > > created node to the existing PCI device without any new device creati=
on.
> >
> > I think the simpler solution is to get the DT node created earlier. We
> > are just asking for pain if the DT node is set for the device at
> > different times compared to static DT nodes.
> >
> > The following fixes the lack of of_node link. The DT unittest fails
> > with the change though and I don't see why.
> >
> > Also, no idea if the bridge part works because my qemu setup doesn't
> > create bridges (anyone got a magic cmdline to create them?).
> >
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 9c2137dae429..46b252bbe500 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -342,8 +342,6 @@ void pci_bus_add_device(struct pci_dev *dev)
> >          */
> >         pcibios_bus_add_device(dev);
> >         pci_fixup_device(pci_fixup_final, dev);
> > -       if (pci_is_bridge(dev))
> > -               of_pci_make_dev_node(dev);
> >         pci_create_sysfs_dev_files(dev);
> >         pci_proc_attach_device(dev);
> >         pci_bridge_d3_update(dev);
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index 51e3dd0ea5ab..e15eaf0127fc 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -31,6 +31,8 @@ int pci_set_of_node(struct pci_dev *dev)
> >                 return 0;
> >
> >         node =3D of_pci_find_child_device(dev->bus->dev.of_node, dev->d=
evfn);
> > +       if (!node && pci_is_bridge(dev))
> > +               of_pci_make_dev_node(dev);
> >         if (!node)
> >                 return 0;
>
> Maybe it is too early.
> of_pci_make_dev_node() creates a node and fills some properties based on
> some already set values available in the PCI device such as its struct re=
source
> values.
> We need to have some values set by the PCI infra in order to create our D=
T node
> with correct values.

Indeed, that's probably the issue I'm having. In that case,
DECLARE_PCI_FIXUP_HEADER should work. That's later, but still before
device_add().

I think modifying sysfs after device_add() is going to race with
userspace. Userspace is notified of a new device, and then the of_node
link may or may not be there when it reads sysfs. Also, not sure if
we'll need DT modaliases with PCI devices, but they won't work if the
DT node is not set before device_add().

Rob

