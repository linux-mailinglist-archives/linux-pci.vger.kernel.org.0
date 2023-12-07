Return-Path: <linux-pci+bounces-637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 830208095C0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 23:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC7E5B20DA0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 22:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741F8840F9;
	Thu,  7 Dec 2023 22:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnOmXd6J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586BD5732B
	for <linux-pci@vger.kernel.org>; Thu,  7 Dec 2023 22:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4100C433C8;
	Thu,  7 Dec 2023 22:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701989530;
	bh=HGADqaQgJ+Ygr3T4IO/0dGsxAN2q2tX+T8CN+umeUWA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NnOmXd6J55uZV5c/Q8lnyXY+WrZAYHCXvvLCSD+sb+IJe/FyfuWaSQDmufnULAsj6
	 uSvIfYlALZYlwCM1kPyEqu5Uhzsmmbbqz72UVCXOlcvJzNAm/uL5p9D5k+zrFUuCOd
	 rb0UrsAY34/ZjP2vcOgpuSjO1MRBnfOhafqvwFJ14eku0I/Y9OikWfJ4E8DrOz0VOy
	 t89C3KQvK2mSNYedx2kGc/bcvRKrH58r/LVHJlLcDDnW04c0j8Cg/PmsVdijlWPRdy
	 2gAtdSkokCW/87z/lKlwFsw7TcNWbYOpv7r91uVpOIpv3yp1Mga84VN/BuTRHzk3KX
	 Ld0V0ouH62qnA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50be10acaf9so1323969e87.1;
        Thu, 07 Dec 2023 14:52:10 -0800 (PST)
X-Gm-Message-State: AOJu0YwkHmgcheK8oe/pXEnn4UA5N1+Ih3wA3bSJTD+FjNO7qbLbB1Bt
	0XZfvbQfJMlbxKTqO/ZFzQh6boJCPBn+W5WF/w==
X-Google-Smtp-Source: AGHT+IGtv5yRJd+8qa8B+2DYoZIs3gnXSm5VdhX0PVbXigUGSFcxjSpk5PW7GY618HkpowugjuqIZuaaWItXoxh9+e4=
X-Received: by 2002:a19:8c5d:0:b0:50b:e73c:b574 with SMTP id
 i29-20020a198c5d000000b0050be73cb574mr3136537lfj.32.1701989528934; Thu, 07
 Dec 2023 14:52:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130165700.685764-1-herve.codina@bootlin.com>
 <CAL_JsqJvt6FpXK+FgAwE8xN3G5Z23Ktq=SEY-K7VA7nM5XgZRg@mail.gmail.com>
 <20231204134335.3ded3d46@bootlin.com> <CAL_JsqLtCS3otZ1sfiPEWwrWB4dyNpu4e0xANWJriCEUYr+4Og@mail.gmail.com>
 <20231204163014.4da383f2@bootlin.com> <CAL_JsqJJ64513pyQggU71agTzawNWPpm6ZpWMB6e0zu-tWL8yw@mail.gmail.com>
 <20231205090452.7c601eb5@bootlin.com>
In-Reply-To: <20231205090452.7c601eb5@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 7 Dec 2023 16:51:56 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+je7+9ATR=B6jXHjEJHjn24vQFs4Tvi9=vhDeK9n42Aw@mail.gmail.com>
Message-ID: <CAL_Jsq+je7+9ATR=B6jXHjEJHjn24vQFs4Tvi9=vhDeK9n42Aw@mail.gmail.com>
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

On Tue, Dec 5, 2023 at 2:05=E2=80=AFAM Herve Codina <herve.codina@bootlin.c=
om> wrote:
>
> On Mon, 4 Dec 2023 17:03:21 -0600
> Rob Herring <robh@kernel.org> wrote:
>
> > On Mon, Dec 4, 2023 at 9:30=E2=80=AFAM Herve Codina <herve.codina@bootl=
in.com> wrote:
> > >
> > > Hi Rob,
> > >
> > > On Mon, 4 Dec 2023 07:59:09 -0600
> > > Rob Herring <robh@kernel.org> wrote:
> > >
> > > [...]
> > >
> > > > > > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > > > > > index 9c2137dae429..46b252bbe500 100644
> > > > > > --- a/drivers/pci/bus.c
> > > > > > +++ b/drivers/pci/bus.c
> > > > > > @@ -342,8 +342,6 @@ void pci_bus_add_device(struct pci_dev *dev=
)
> > > > > >          */
> > > > > >         pcibios_bus_add_device(dev);
> > > > > >         pci_fixup_device(pci_fixup_final, dev);
> > > > > > -       if (pci_is_bridge(dev))
> > > > > > -               of_pci_make_dev_node(dev);
> > > > > >         pci_create_sysfs_dev_files(dev);
> > > > > >         pci_proc_attach_device(dev);
> > > > > >         pci_bridge_d3_update(dev);
> > > > > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > > > > index 51e3dd0ea5ab..e15eaf0127fc 100644
> > > > > > --- a/drivers/pci/of.c
> > > > > > +++ b/drivers/pci/of.c
> > > > > > @@ -31,6 +31,8 @@ int pci_set_of_node(struct pci_dev *dev)
> > > > > >                 return 0;
> > > > > >
> > > > > >         node =3D of_pci_find_child_device(dev->bus->dev.of_node=
, dev->devfn);
> > > > > > +       if (!node && pci_is_bridge(dev))
> > > > > > +               of_pci_make_dev_node(dev);
> > > > > >         if (!node)
> > > > > >                 return 0;
> > > > >
> > > > > Maybe it is too early.
> > > > > of_pci_make_dev_node() creates a node and fills some properties b=
ased on
> > > > > some already set values available in the PCI device such as its s=
truct resource
> > > > > values.
> > > > > We need to have some values set by the PCI infra in order to crea=
te our DT node
> > > > > with correct values.
> > > >
> > > > Indeed, that's probably the issue I'm having. In that case,
> > > > DECLARE_PCI_FIXUP_HEADER should work. That's later, but still befor=
e
> > > > device_add().
> > > >
> > > > I think modifying sysfs after device_add() is going to race with
> > > > userspace. Userspace is notified of a new device, and then the of_n=
ode
> > > > link may or may not be there when it reads sysfs. Also, not sure if
> > > > we'll need DT modaliases with PCI devices, but they won't work if t=
he
> > > > DT node is not set before device_add().
> > >
> > > Ok, we can try using DECLARE_PCI_FIXUP_HEADER.
> > > On your side, is moving from DECLARE_PCI_FIXUP_EARLY to DECLARE_PCI_F=
IXUP_HEADER
> > > fix your QEMU unittest ?
> >
> > No...

I think the problem is we aren't setting the fwnode, just the of_node
ptr, but I haven't had a chance to verify that.

> > And testing the bridge part crashes. That's because there's a
> > dependency on the bridge->subordinate to write out bus-range and
> > interrupt-map. I think the fix there is we should just not write those
> > properties. The bus range isn't needed because the kernel does its own
> > assignments. For interrupt-map, it is only needed if "interrupts" is
> > present in the child devices. If not present, then the standard PCI
> > swizzling is used. Alternatively, I think the interrupt mapping could
> > be simplified to just implement the standard swizzling at each level
> > which isn't dependent on any of the devices on the bus. I gave that a
> > go where each interrupt-map just points to the parent bridge, but ran
> > into an issue that the bridge nodes don't have a phandle. That should
> > be fixable, but I'd rather go with the first option. I suppose that
> > depends on how the interrupts downstream of the PCI device need to get
> > resolved. It could be that the PCI device serves as the interrupt
> > controller and can resolve the parent interrupt on its own (which may
> > be needed for ACPI host anyways).
>
> About interrupt, I am a bit stuck on my side.
> My dtso (applied at PCI device level) contains the following:
>         fragment@0 {
>                 target-path=3D"";
>                 __overlay__ {
>                         pci-ep-bus@0 {
>                                 compatible =3D "simple-bus";
>                                 #address-cells =3D <1>;
>                                 #size-cells =3D <1>;
>
>                                 /*
>                                  * map @0xe2000000 (32MB) to BAR0 (CPU)
>                                  * map @0xe0000000 (16MB) to BAR1 (AMBA)
>                                  */
>                                 ranges =3D <0xe2000000 0x00 0x00 0x00 0x2=
000000
>                                           0xe0000000 0x01 0x00 0x00 0x100=
0000>;
>
>                                 itc: itc {
>                                         compatible =3D "microchip,lan966x=
-itc";
>                                         #interrupt-cells =3D <1>;
>                                         interrupt-controller;
>                                         reg =3D <0xe00c0120 0x190>;
>                                 };
>
>                                 ...
>                          };
>                 };
>         };
>
> I have a 'simple-bus' with a 'ranges' property to translate the BAR addre=
sses
> then several devices. Among them a interrupt controller (itc). Its parent
> interrupt is the one used by the PCI device (INTA).
> I cannot describe this parent interrupt in the dtso because to that I nee=
d the
> parent interrupt phandle which will be know only at runtime.

But you don't. The logic to find the interrupt parent is walk up the
parent nodes until you find 'interrupt-parent' or
'#interrupt-controller' (and interrupt-map always has
#interrupt-controller). So your overlay just needs 'interrupts =3D <1>'
for INTA and it should all just work.

That of course implies that we need interrupt properties in all the
bridges which I was hoping to avoid. In the ACPI case, for DT
interrupt parsing to work, we're going to need to end up in an
'interrupt-controller' node somewhere. I think the options are either
we walk interrupt-map properties up to the host bridge which then
points to something or the PCI device is the interrupt controller. I
think the PCI device is the right place. How the downstream interrupts
are routed to PCI interrupts are defined by the device. That would
work the same way for both DT and ACPI. If you are concerned about
implementing in each driver needing this, some library functions can
mitigate that.

I'm trying to play around with the IRQ domains and get this to work,
but not having any luck yet.

> Of course, I can modified the overlay applied to tweak the 'interrupt' an=
d
> 'interrupt-parent' in the itc node from my PCI device driver at runtime b=
ut I
> would like to avoid this kind of tweak in the PCI device driver.
> This kind of tweak is overlay dependent and needs to be done by each PCI
> device driver that need to work with interrupts.
>
> For BAR addresses translation, we use the 'ranges' property at the PCI de=
vice
> node to translate 0 0 0 to BAR0, 1 0 0 to BAR1, ...
> What do you think about a new 'irq-ranges' property to translate the irq =
number
> and get the irq parent controller base.
>
> irq-ranges =3D <child_irq_spec parent_irq_spec length>;

Seems fragile as you have to know something about the parent (the # of
cells), but you don't have the phandle. If you needed multiple
entries, you couldn't parse this.

Rob

