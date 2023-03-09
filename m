Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162756B1E73
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 09:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjCIInI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 03:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjCIImc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 03:42:32 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D782F5A6EB;
        Thu,  9 Mar 2023 00:42:28 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1141540002;
        Thu,  9 Mar 2023 08:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678351346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lOMLsxz0wbG36jgtfIBiMyWVZzrLsmwJtyvij7rHbfQ=;
        b=jn9W8Zy2xQsX2X+qLuYbzfxLR/Ea+nvrpMsxqrdO4qigembgIxCmalVWx9uRcAmh/5st2n
        FGlbAO/SWg/789NUvzk/g/rL4hBATR1xNjvogTXBEk7utrtLUnxA6Bn0sEFSmSuUo0Eaq5
        5aEKdFzdjwEHhkefobsHBhwJ4o75Hun3OUZ9OA8TXEjnPZqvPw50xjZK+cFGm+/UzpY3fE
        t2jRTIui/0Dtvt5lWuNZf29l2UlF257q4ytHIBzbZNY4aZBZhgX3fXeWGoZiW7/N2aMfgZ
        LFg4zgNS6k7/wayTkLe2r2DC7GcznO0+CZuxPj657vormEljoMA4pz6kczRqIw==
Date:   Thu, 9 Mar 2023 09:45:07 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, helgaas@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        stefano.stabellini@xilinx.com, trix@redhat.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>,
        "Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
        "Allan.Nielsen@microchip.com" <Allan.Nielsen@microchip.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH V7 0/3] Generate device tree node for pci devices
Message-ID: <20230309094507.62d7c35e@fixe.home>
In-Reply-To: <9b4bb45a-f6e4-c95c-d27c-21c7fecb5505@gmail.com>
References: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
        <af2a6686-ea35-e5fc-7541-27e5d6ca9311@gmail.com>
        <20230227113150.398dcfa7@fixe.home>
        <52b8f136-c73f-a97d-2bb6-48aff3755f98@gmail.com>
        <f927790dc9839cd93902c0d2e5afe5e8@bootlin.com>
        <1886b888-a0e8-b1ee-c48a-ddbc8b5b0c63@gmail.com>
        <CAL_JsqL_ER32ys-yW_7-QKLjEmKK8StOeM5yvH2ChuvX++fe5Q@mail.gmail.com>
        <9b4bb45a-f6e4-c95c-d27c-21c7fecb5505@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le Wed, 8 Mar 2023 01:31:52 -0600,
Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :

> On 3/6/23 18:52, Rob Herring wrote:
> > On Mon, Mar 6, 2023 at 3:24=E2=80=AFPM Frank Rowand <frowand.list@gmail=
.com> wrote: =20
> >> =20
>=20
> < snip >
>=20
> Hi Rob,
>=20
> I am in no position to comment intelligently on your comments until I
> understand the SoC on PCI card model I am asking to be described in
> this subthread.

Hi Frank,

Rather than answering all of the assumptions that were made in the upper
thread (that are probably doing a bit too much of inference), I will
re-explain that from scratch.

Our usecase involves the lan966x SoCs. These SoCs are mainly targeting
networking application and offers multiple SFP and RGMII interfaces.
This Soc can be used in two exclusive modes (at least for the intended
usage):

SoC mode:
   The device runs Linux by itself, on ARM64 cores included in the
   SoC. This use-case of the lan966x is currently almost upstreamed,
   using a traditional Device Tree representation of the lan996x HW
   blocks [1] A number of drivers for the different IPs of the SoC have
   already been merged in upstream Linux (see
   arch/arm/boot/dts/lan966x.dtsi)

PCI mode:
  The lan966x SoC is configured as a PCIe endpoint (PCI card),
  connected to a separate platform that acts as the PCIe root complex.
  In this case, all the IO memories that are exposed by the devices
  embedded on this SoC are exposed through PCI BARs 0 & 1 and the ARM64
  cores of the SoC are not used. Since this is a PCIe card, it can be
  plugged on any platform, of any architecture supporting PCIe.

This work only focus on the *PCI mode* usage. In this mode, we have the
following prerequisites:
- Should work on all architectures (x86, ARM64, etc)
- Should be self-contained in the driver
- Should be able to reuse all existing platform drivers

In PCI mode, the card runs a firmware (not that it matters at all by
the way) which configure the card in PCI mode at boot time. In this
mode, it exposes a single PCI physical function associated with
vendor/product 0x1055/0x9660. This is not a multi-function PCI device !
This means that all the IO memories (peripheral memories, device
memories, registers, whatever you call them) are accessible using
standard readl()/writel() on the BARs that have been remapped. For
instance (not accurate), in the BAR 0, we will have this kind of memory
map:

           BAR0
   0x0 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
       =E2=94=82           =E2=94=82
       =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
       =E2=94=82   Clock   =E2=94=82
       =E2=94=82 controller=E2=94=82
       =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
       =E2=94=82           =E2=94=82
       =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
       =E2=94=82   I2C     =E2=94=82
       =E2=94=82 controller=E2=94=82
       =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
       =E2=94=82           =E2=94=82
       =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
       =E2=94=82   MDIO    =E2=94=82
       =E2=94=82 Controller=E2=94=82
       =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
       =E2=94=82           =E2=94=82
       =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
       =E2=94=82  Switch   =E2=94=82
       =E2=94=82 Controller=E2=94=82
       =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
       =E2=94=82           =E2=94=82
       =E2=94=82   ...     =E2=94=82
         =20

It also exposes either a single interrupt via the legacy interrupt
(which can then be demuxed by reading the SoC internal interrupt
controller registers), or multiple interrupts using MSI interrupts.

As stated before, all these peripherals are already supported in SoC
mode and thus, there are aleready existing platform drivers for each of
them. For more information about the devices that are exposed please
see link [1] which is the device-tree overlay used to describe the
lan9662 card.

In order to use the ethernet switch, we must configure everything that
lies around this ethernet controller, here are a few amongst all of
them:
- MDIO bus
- I2C controller for SFP modules access
- Clock controller
- Ethernet controller
- Syscon

Since all the platform drivers already exist for these devices, we
want to reuse them. Multiple solutions were thought of (fwnode, mfd,
ACPI, device-tree) and eventually ruled out for some of them and efforts
were made to try to tackle that (using fwnode [2], device-tree [3])

One way to do so is to use a device-tree overlay description that is
loaded dynamically on the PCI device OF node. This can be done using the
various device-tree series series that have been proposed (included
this one). On systems that do not provide a device-tree of_root, create
an empty of_root node (see [4]). Then during PCI enumeration, create
device-tree node matching the PCI tree that was enumerated (See [5]).
This is needed since the PCI card can be plugged on whatever port the
user wants and thus it can not be statically described using a fixed
"target-path" property in the overlay.

Finally, to glue everything together, we add a PCI driver for the
VID/PID of the PCI card (See [6]). This driver is responsible of adding
the "ranges" property in the device-tree PCI node to remap the child
nodes "reg" property to the PCI memory map. This is needed because the
PCI memory addresses differ between platform, enumeration order and so
on.Finally, the driver will load the device-tree overlay (See [1]) to
the PCI device-tree node. Eventually, a call to
of_platform_default_populate() will probe the nodes and platform
drivers.

I hope this will help you understanding what is going on here. In the
meantime, I'm also trying to obtain public documentation about the
lan966x SoC.

[1]
https://github.com/clementleger/linux/blob/bf9b4ef803d86c4ae59a4ca195a4152b=
0d5c3cea/drivers/mfd/lan966x_pci.dts
[2]
https://lore.kernel.org/netdev/YhPSkz8+BIcdb72R@smile.fi.intel.com/T/
[3]
https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.=
com/
[4]
https://lore.kernel.org/lkml/20230223213418.891942-1-frowand.list@gmail.com/
[5]
https://lore.kernel.org/lkml/1674183732-5157-1-git-send-email-lizhi.hou@amd=
.com/
[6]
https://github.com/clementleger/linux/blob/bf9b4ef803d86c4ae59a4ca195a4152b=
0d5c3cea/drivers/mfd/lan966x_pci_of.c

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
