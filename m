Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A257B6D095B
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 17:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjC3PVs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 11:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjC3PVr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 11:21:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643132683;
        Thu, 30 Mar 2023 08:20:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C1F0B82808;
        Thu, 30 Mar 2023 15:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB8FC433D2;
        Thu, 30 Mar 2023 15:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680189586;
        bh=LbHVIvsYsKCKNmDEDCwVnwigvxAibQVlB7WTysFB6Kw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hEHI/uGoey/Gnwh0++c3Xv4dZYwqzhyX3dbUv4ySSa2w8PWuMod2usCB0UhM3cgmH
         ye8vaUC5s0J2FmpKhTufFvV/FNFKAIj9MBrv3QfTyQF48btT8TvNw8WOUrJugFB0aA
         0QabMJ62IYRrQOCJVSHiBCweDYkkQeNQSFiLVULY9hnCtpbkms8LCUJsqrYBht7h/x
         ZrMH1CMDNOWyOX59O8YFone7/tFEvP9X5V/p90LF6A4tHcEMkhWYJ1Hrai0hqT9Swt
         crkr1sVRr48MoByHGnG1Ggb34ncSH5hqcIVZebnu+G5iJalDRCMpV/nUrbSv5IYVb7
         PPgYMjHdQ6EmA==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-536af432ee5so361205237b3.0;
        Thu, 30 Mar 2023 08:19:45 -0700 (PDT)
X-Gm-Message-State: AAQBX9eDeqAkYoG8Z/hZn+W+I1d83m1pFK2k1vtmKNWVlDlXDQvfYIgp
        pnIRoAa+QUuTJaxHc94BFmIeNYRDENhWn6cDjw==
X-Google-Smtp-Source: AKy350ZUb+XdJHS2eNfADBB8Em95KxiFW/4Kk/FnJ4x/2GHOGVUtqa5nAz1gajZIh2PmZU/nM57s3ynjDrP/I5ABRUk=
X-Received: by 2002:a81:4410:0:b0:545:a7d8:f278 with SMTP id
 r16-20020a814410000000b00545a7d8f278mr11224036ywa.5.1680189584873; Thu, 30
 Mar 2023 08:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
 <af2a6686-ea35-e5fc-7541-27e5d6ca9311@gmail.com> <20230227113150.398dcfa7@fixe.home>
 <52b8f136-c73f-a97d-2bb6-48aff3755f98@gmail.com> <f927790dc9839cd93902c0d2e5afe5e8@bootlin.com>
 <1886b888-a0e8-b1ee-c48a-ddbc8b5b0c63@gmail.com> <CAL_JsqL_ER32ys-yW_7-QKLjEmKK8StOeM5yvH2ChuvX++fe5Q@mail.gmail.com>
 <9b4bb45a-f6e4-c95c-d27c-21c7fecb5505@gmail.com> <20230309094507.62d7c35e@fixe.home>
 <fed57536-cd2c-bf9b-37bc-7a653685cbf2@gmail.com>
In-Reply-To: <fed57536-cd2c-bf9b-37bc-7a653685cbf2@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 30 Mar 2023 10:19:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL+HLQVs-MoHYaVTnoNHE2DGnYZnUThp00r0vuZArwCsw@mail.gmail.com>
Message-ID: <CAL_JsqL+HLQVs-MoHYaVTnoNHE2DGnYZnUThp00r0vuZArwCsw@mail.gmail.com>
Subject: Re: [PATCH V7 0/3] Generate device tree node for pci devices
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 29, 2023 at 11:51=E2=80=AFAM Frank Rowand <frowand.list@gmail.c=
om> wrote:
>
> On 3/9/23 02:45, Cl=C3=A9ment L=C3=A9ger wrote:
> > Le Wed, 8 Mar 2023 01:31:52 -0600,
> > Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :
> >
> >> On 3/6/23 18:52, Rob Herring wrote:
> >>> On Mon, Mar 6, 2023 at 3:24=E2=80=AFPM Frank Rowand <frowand.list@gma=
il.com> wrote:
> >>>>
> >>
> >> < snip >
> >>
> >> Hi Rob,
> >>
> >> I am in no position to comment intelligently on your comments until I
> >> understand the SoC on PCI card model I am asking to be described in
> >> this subthread.
> >
> > Hi Frank,
> >
> > Rather than answering all of the assumptions that were made in the uppe=
r
> > thread (that are probably doing a bit too much of inference), I will
> > re-explain that from scratch.
>
> Thanks!  The below answers a lot of my questions.
> >
> > Our usecase involves the lan966x SoCs. These SoCs are mainly targeting
> > networking application and offers multiple SFP and RGMII interfaces.
> > This Soc can be used in two exclusive modes (at least for the intended
> > usage):
> >
> > SoC mode:
> >    The device runs Linux by itself, on ARM64 cores included in the
> >    SoC. This use-case of the lan966x is currently almost upstreamed,
> >    using a traditional Device Tree representation of the lan996x HW
> >    blocks [1] A number of drivers for the different IPs of the SoC have
> >    already been merged in upstream Linux (see
> >    arch/arm/boot/dts/lan966x.dtsi)
> >
> > PCI mode:
> >   The lan966x SoC is configured as a PCIe endpoint (PCI card),
> >   connected to a separate platform that acts as the PCIe root complex.
> >   In this case, all the IO memories that are exposed by the devices
> >   embedded on this SoC are exposed through PCI BARs 0 & 1 and the ARM64
> >   cores of the SoC are not used. Since this is a PCIe card, it can be
> >   plugged on any platform, of any architecture supporting PCIe.
> >
> > This work only focus on the *PCI mode* usage. In this mode, we have the
> > following prerequisites:
> > - Should work on all architectures (x86, ARM64, etc)
> > - Should be self-contained in the driver
>
> > - Should be able to reuse all existing platform drivers
>
> I've said before (in different words) that using an existing platform
> driver for hardware on a PCI card requires shims, which have been
> strongly rejected by the Linux kernel.

Do you have an example of what you are saying has been rejected
because I have no clue what you are referring to?

The kernel already has a way to divide up a PCI device into multiple
non-PCI sub-drivers. It's auxiliary_bus. Is that not a "shim"? So why
not use that? From the docs:

 * A key requirement for utilizing the auxiliary bus is that there is no
 * dependency on a physical bus, device, register accesses or regmap suppor=
t.
 * These individual devices split from the core cannot live on the platform=
 bus
 * as they are not physical devices that are controlled by DT/ACPI.  The sa=
me
 * argument applies for not using MFD in this scenario as MFD relies on
 * individual function devices being physical devices.


In the usecases here, they are physical devices because it's the same
devices when Linux is running on the SoC.

> >
> > In PCI mode, the card runs a firmware (not that it matters at all by
> > the way) which configure the card in PCI mode at boot time. In this
> > mode, it exposes a single PCI physical function associated with
> > vendor/product 0x1055/0x9660. This is not a multi-function PCI device !
> > This means that all the IO memories (peripheral memories, device
> > memories, registers, whatever you call them) are accessible using
> > standard readl()/writel() on the BARs that have been remapped. For
> > instance (not accurate), in the BAR 0, we will have this kind of memory
> > map:
> >
> >            BAR0
> >    0x0 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> >        =E2=94=82           =E2=94=82
> >        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> >        =E2=94=82   Clock   =E2=94=82
> >        =E2=94=82 controller=E2=94=82
> >        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> >        =E2=94=82           =E2=94=82
> >        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> >        =E2=94=82   I2C     =E2=94=82
> >        =E2=94=82 controller=E2=94=82
> >        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> >        =E2=94=82           =E2=94=82
> >        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> >        =E2=94=82   MDIO    =E2=94=82
> >        =E2=94=82 Controller=E2=94=82
> >        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> >        =E2=94=82           =E2=94=82
> >        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> >        =E2=94=82  Switch   =E2=94=82
> >        =E2=94=82 Controller=E2=94=82
> >        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> >        =E2=94=82           =E2=94=82
> >        =E2=94=82   ...     =E2=94=82
> >
> >
> > It also exposes either a single interrupt via the legacy interrupt
> > (which can then be demuxed by reading the SoC internal interrupt
> > controller registers), or multiple interrupts using MSI interrupts.
> >
> > As stated before, all these peripherals are already supported in SoC
> > mode and thus, there are aleready existing platform drivers for each of
> > them. For more information about the devices that are exposed please
> > see link [1] which is the device-tree overlay used to describe the
> > lan9662 card.
> >
> > In order to use the ethernet switch, we must configure everything that
> > lies around this ethernet controller, here are a few amongst all of
> > them:
> > - MDIO bus
> > - I2C controller for SFP modules access
> > - Clock controller
> > - Ethernet controller
> > - Syscon
> >
> > Since all the platform drivers already exist for these devices, we
> > want to reuse them. Multiple solutions were thought of (fwnode, mfd,
> > ACPI, device-tree) and eventually ruled out for some of them and effort=
s
> > were made to try to tackle that (using fwnode [2], device-tree [3])
> >
>
> > One way to do so is to use a device-tree overlay description that is
> > loaded dynamically on the PCI device OF node. This can be done using th=
e
> > various device-tree series series that have been proposed (included
> > this one). On systems that do not provide a device-tree of_root, create
> > an empty of_root node (see [4]). Then during PCI enumeration, create
> > device-tree node matching the PCI tree that was enumerated (See [5]).
> > This is needed since the PCI card can be plugged on whatever port the
> > user wants and thus it can not be statically described using a fixed
> > "target-path" property in the overlay.
>
> I understand that this is a use case and a desire to implement a
> solution for the use case.  But this is a very non-standard model.
> The proposal exposes a bunch of hardware beyond the pci interface
> in a non-pci method.

It is not the proposal that exposes a bunch of hardware. This device
exposes a bunch of hardware. As you say, it is *beyond the PCI
interface*, so it has zero to do with PCI.

We already support non-discoverable h/w behind a PCI bus. It's called
ISA. There's powerpc DT files in the tree with ISA devices.

> No, just no.  Respect the pci interface boundary and do not drag
> devicetree into an effort to pierce and straddle that boundary
> (by adding information about the card, beyond the PCI controller,
> into the system devicetree).  Information about dynamically
> discoverable hardware does not belong in the devicetree.

What is discoverable? Nothing more than a VID/PID.

Your suggestion is simply use the VID/PID(s) and then the PCI driver
for the card will have all the details that implies. There's a name
for that: board files. Just like we had a single machine ID per board
registered with RMK and the kernel had to contain all the
configuration details for each machine ID. It's not just 1 card here.
This is a chip and I imagine what's used or not used or how the
downstream peripherals are configured all depend on the customer and
their specific designs.

If DT is not used here, then swnodes (DT bindings embedded in the
kernel or platform_data 2.0) will be. It's exactly the same structure
in the kernel. It's still going to be non-PCI drivers for all the sub
devices. The change in the drivers will not be making them PCI
drivers, but simply converting DT APIs to fwnode APIs which is
pointless churn IMO.

Finally, let's not forget the FPGA usecase. We already support DT
overlays for FPGAs. The fact that the FPGA sits behind a PCI interface
is pretty much irrelevant to the problem. There is simply no way the
kernel is going to contain information about what's within the FPGA
image. If not DT, how should we communicate the FPGA configuration to
the kernel?

Rob
