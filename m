Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8D46AD97C
	for <lists+linux-pci@lfdr.de>; Tue,  7 Mar 2023 09:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCGIog (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Mar 2023 03:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjCGIoc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Mar 2023 03:44:32 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FB84DBC5;
        Tue,  7 Mar 2023 00:44:29 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A612CC000A;
        Tue,  7 Mar 2023 08:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678178668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHHGD3vxN/HN9NgcgMPOm3LFBQXpX9MgGJrX5d/hkK8=;
        b=mn/YabZ+wIcq/c8mgEdxUKsilEsLVJp7N/sOni3dvJtZb7YdPMWg5ak1ELlvfkTTQYKAoG
        3d0l1vFljsDswx5wHCNdD3/zbRonayeedVzBTho4HVZidF0m7I8moXrrcY5Ub1lr8CthBJ
        1mPMYsk/FCEHvdbxboG+tgSRbnib3ipdtSt8STJILOFfhPR7F0Xvf4ijL/V8okMVIJHFUN
        CTbpcy3yBbrj2QZ2eaL62bKQj6CvdQEIHDvXKNihZ7jGmycrJAoOhLGznZtnSMpPSG4Bfy
        8g17Zk5Vao8GNHpNVBbs4ecUCcZCoWybHmlfH0F+ddf0DHjrLM8vDVN/rky+dA==
Date:   Tue, 7 Mar 2023 09:47:09 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        helgaas@kernel.org, max.zhen@amd.com, sonal.santan@amd.com,
        larry.liu@amd.com, brian.xu@amd.com, stefano.stabellini@xilinx.com,
        trix@redhat.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>,
        "Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
        "Allan.Nielsen@microchip.com" <Allan.Nielsen@microchip.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH V7 0/3] Generate device tree node for pci devices
Message-ID: <20230307094709.7f5020fe@fixe.home>
In-Reply-To: <CAL_JsqL_ER32ys-yW_7-QKLjEmKK8StOeM5yvH2ChuvX++fe5Q@mail.gmail.com>
References: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
        <af2a6686-ea35-e5fc-7541-27e5d6ca9311@gmail.com>
        <20230227113150.398dcfa7@fixe.home>
        <52b8f136-c73f-a97d-2bb6-48aff3755f98@gmail.com>
        <f927790dc9839cd93902c0d2e5afe5e8@bootlin.com>
        <1886b888-a0e8-b1ee-c48a-ddbc8b5b0c63@gmail.com>
        <CAL_JsqL_ER32ys-yW_7-QKLjEmKK8StOeM5yvH2ChuvX++fe5Q@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le Mon, 6 Mar 2023 18:52:42 -0600,
Rob Herring <robh@kernel.org> a =C3=A9crit :

> On Mon, Mar 6, 2023 at 3:24=E2=80=AFPM Frank Rowand <frowand.list@gmail.c=
om> wrote:
> >
> > On 3/6/23 02:35, clement.leger@bootlin.com wrote: =20
> > > Le 2023-03-04 00:42, Frank Rowand a =C3=A9crit : =20
> > >> On 2/27/23 04:31, Cl=C3=A9ment L=C3=A9ger wrote: =20
> > >>> Le Mon, 27 Feb 2023 00:51:29 -0600,
> > >>> Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :
> > >>> =20
> > >>>> On 1/19/23 21:02, Lizhi Hou wrote: =20
> > >>>>> This patch series introduces OF overlay support for PCI devices
> > >>>>> which
> > >>>>> primarily addresses two use cases. First, it provides a data driv=
en
> > >>>>> method
> > >>>>> to describe hardware peripherals that are present in a PCI endpoi=
nt
> > >>>>> and
> > >>>>> hence can be accessed by the PCI host. Second, it allows reuse of=
 a
> > >>>>> OF
> > >>>>> compatible driver -- often used in SoC platforms -- in a PCI host
> > >>>>> based
> > >>>>> system.
> > >>>>>
> > >>>>> There are 2 series devices rely on this patch:
> > >>>>>
> > >>>>>   1) Xilinx Alveo Accelerator cards (FPGA based device)
> > >>>>>   2) Microchip LAN9662 Ethernet Controller
> > >>>>>
> > >>>>>      Please see:
> > >>>>> https://lore.kernel.org/lkml/20220427094502.456111-1-clement.lege=
r@bootlin.com/
> > >>>>> =20
> > >>>>
> > >>>> =20
> > >>>>> Normally, the PCI core discovers PCI devices and their BARs using
> > >>>>> the
> > >>>>> PCI enumeration process. However, the process does not provide a =
way
> > >>>>> to
> > >>>>> discover the hardware peripherals that are present in a PCI devic=
e,
> > >>>>> and
> > >>>>> which can be accessed through the PCI BARs. Also, the enumeration
> > >>>>> process =20
> > >>>>
> > >>>> I'm confused.  The PCI Configuration Header Registers should descr=
ibe
> > >>>> the
> > >>>> hardware on the PCI card.
> > >>>>
> > >>>> Ignoring case 1 above _for the moment_ (FPGA devices are a world u=
nto
> > >>>> themselves, so I would like to analyze that case separately), does
> > >>>> the
> > >>>> second device, "Microchip LAN9662 Ethernet Controller" properly
> > >>>> implement
> > >>>> the PCI Configuration Header Registers?  What additional informati=
on
> > >>>> is
> > >>>> needed that is not provided in those registers? =20
> > >>>
> > >>> Hi Frank,
> > >>>
> > >>> I guess Lizhi wanted to say that it does not provide a way to descr=
ibe
> > >>> all the "platform" devices that are exposed by this PCI device. Whi=
ch
> > >>> is of course the whole point of the work we are doing right now. But
> > >>> all the BARs are correctly described by the LAN9662 PCI card.
> > >>>
> > >>> Cl=C3=A9ment =20
> > >>
> > >> I remain confused.
> > >>
> > >> [RFC 00/10] add support for fwnode in i2c mux system and sfp
> > >> https://lore.kernel.org/lkml/YhQHqDJvahgriDZK@lunn.ch/t/
> > >>
> > >>   references a PCIe driver:
> > >>   [2]
> > >> https://github.com/clementleger/linux/blob/fwnode_support/drivers/mf=
d/lan966x_pci_mfd.c
> > >>
> > >> So there is a PCIe driver that works.
> > >>
> > >> However, the RFC patch series was proposing adding fwnode support to
> > >> the driver.  My first
> > >> surface reading (just part of that one email, not the entire series =
or
> > >> the replies yet),
> > >> notes:
> > >>
> > >>   ... However, when
> > >>   plugged in a PCIe slot (on a x86), there is no device-tree support
> > >> and
> > >>   the peripherals that are present must be described in some other w=
ay.
> > >>
> > >> I am assuming that the peripherals are what you mentioned above as
> > >> '"platform"
> > >> devices'.  This is where my current confusion lies.  Are the "platfo=
rm"
> > >> devices accessed via the PCI bus or is there some other electrical
> > >> connection
> > >> between the host system and the PCIe card? =20
> > >
> > > Hi Frank,
> > >
> > > The platform devices exposed by this PCIe card are available via some
> > > BAR using PCI memory mapped areas, so it's totally standard PCI stuff.
> > > =20
> > >>
> > >> If the "platform" devices are accessed via the PCI bus, then I would
> > >> expect them
> > >> to be described by PCI configuration header registers.  Are the PCI
> > >> configuration
> > >> registers to describe the "platform" devices not present? =20
> > >
> > > I'm not sure to understand what you mean here. PCI configuration head=
ers
> > > only provides some basic registers allowing to identify the PCI device
> > > (vendor/product) and some memory areas that are exposed (BAR). They do
> > > not provides the "list" of peripherals that are exposed by the device=
s,
> > > only some BARs that can be mapped and that allows to access. =20
> >
> > Yes, "identify the PCI device (vendor/product) and some memory areas".
> > The driver for the (vendor/product) 'knows' what peripherals are exposed
> > by the device and where within the BAR to find the registers for each
> > of the devices.
> >
> > A normal PCI driver would contain this information.  If I understand the
> > proposal of this patch series, of_pci_make_dev_node() adds a node to
> > the devicetree, when invoked via a PCI quirk for certain specific
> > vendor/product cards.  This node must exist for the flattened device
> > tree (FDT) overlay for the card to be loaded.  The driver for the card
> > will get the overlay FDT from the card and load it into the kernel.
> > The driver will use the information that then exists in the devicetree
> > describing the card, instead of using information from the PCI configur=
ation
> > headers from the card. =20
>=20
> How would all the sub devices be defined by the PCI config space other
> than a VID/PID implies *everything*. That's the same as the pre-DT
> world where the ARM machine ID number (from RMK's registry) implied
> everything. These days, we can have an entire SoC exposed behind a PCI
> BAR which I think is pretty much Clement's usecase. Putting an SoC
> behind a PCI BAR is no more discoverable than a "normal" SoC.

Thanks Rob for re-explaining all of that, I thought the cover letter
at [1] explained that This is *exactly* my usecase. the lan9662 SoC can
either be used to run Linux and uses a device-tree description, or can
be configured as a PCIe endpoint card and plugged on, a PCI port, in
which case all the SoC IO memories are exposed through BAR 0 & 1.

>=20
> >
> > The intent is to be able to re-use devicetree based drivers instead of
> > having the driver be a native PCI driver. =20
>=20
> Not instead of. There's the PCI driver for the FPGA or SoC bus with
> multiple unrelated devices behind it. The PCI driver is just a bus
> driver much like we have for various custom SoC bus drivers.
>=20
> > This goes against historical Linux practice.  The idea of taking a driv=
er
> > from another environment (eg Windows, HP Unix, Sun Unix, IBM Unix, etc)
> > and adding a shim layer to translate between Linux and the other
> > environment has been rejected.  Ironically, in this case, the other
> > environment is Linux (more specifically the Linux OF implementation).
>=20
> I don't see how your example relates to this in any way whatsoever.
> We're talking about different discovery mechanisms, not different
> driver models/environments.
>=20
> > Even thought the other environment is Linux, this is still adding a
> > shim layer to translate between that other environment and the native
> > Linux PCI environment for which the driver would normally be written.

Since there is an entire SoC described behind that PCI card, we need to
link all the devcies together. So it's not as simple as saying "I want
a driver for each device to be probed", we also need to describe the
whole hierarchy & links between the devices. PCI "itself" does not
describe how to define that, only a way to access the memory and
identify the PCI device.

> >
> > In other words, this is not acceptable.  Normal alternatives would be
> > something like
> > (1) add the PCI awareness to the existing drivers, =20
>=20
> The downstream devices don't have their own PCI config space. That
> won't work. PCI drivers expect a device with PCI config space. Devices
> to drivers are always 1:1, so we couldn't share the config space among
> multiple drivers or something. For devices which are not discoverable
> like these are, our choices are DT, ACPI or s/w nodes (aka
> platform_data 2.0).

Exactly, and even though it would be possible to share the the config
space, it would mean that each driver would need to be modified to
support PCI and all the OF layer that allows to link the devcuie
together and configure the device would need to be modified in some way
to allows passing arguments, that would be going back to paltform_data
stuff.

>=20
> > (2) split the devicetree aware and PCI aware portions of the driver
> > to common code that would be invoked from separate devicetree and PCI
> > drivers, =20
>=20
> That only makes sense for something that is a single driver. Not the
> case here. For the FPGA, the devices are not known up front.
>=20
> > (3) write entirely separate devicetree and PCI drivers, or =20
>=20
> For the same reason as 1, that simply won't work.
>=20
> > (4) some other creative solution.
> >
> > Am I mis-interpretting or misunderstanding anything crucial here? =20
>=20
> Yes...
>=20
> We now have 3 different use cases all needing the same thing. The
> 3rd[1] is the recent test infrastructure change to have test devices
> added. They all have non-discoverable devices downstream of a PCI
> device. We need a solution here.

We have been going back and forth for about more than a year now and we
tested several things (software nodes, ACPI, MFD cells,
device-tree overlays). The most elegant solution (at least from the
ones we though of) has proven to be the device-tree overlays with
dynamic PCI of nodes for various reasons:

- Minimal amount of code modified
- Reusability of the existing SoC device-tree
- Already available bindings (no need to define a new standard for
  system description)
- Works on all platforms (x86, ARM, ARM64, etc)
- Ease of use for the end-user

No other solution was providing so much pros (see [1] for the history).
Of course there are some cons such as the *not so clear* status about OF
overlays statiblity when loaded/unloaded but we are clearly working
toward a better support.

I even think that a common driver to handle much of these use cases
could exists and allow to load an overlay based on the PCI VID/PID and
apply some ranges remapping depending on it, allowing to reduce the
amount of specific complex drivers for handling these usecases.

Cl=C3=A9ment

[1]
https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.=
com/
--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
