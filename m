Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301306A3F62
	for <lists+linux-pci@lfdr.de>; Mon, 27 Feb 2023 11:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjB0KU1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 05:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjB0KUZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 05:20:25 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745B1F742;
        Mon, 27 Feb 2023 02:20:20 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6786320013;
        Mon, 27 Feb 2023 10:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677493219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DfUXTiMiJzbkbOg3yszx6yBVT1O5G7pw4HlRcNmTVLI=;
        b=DRscHsonCDQrIeK9cwiYDPgRinQi++gmxh2vg4Tmj1XbdEidA+8HSGVBu1jwOJuwJ+YotK
        L9kUTk5u1pXtH5x7MQh4TRxqTVjf300XTySmZksvGHZaM0wd3t+aZIsJeHLexbLutJ54SI
        SVc9X2JnQALDGhU8oh5qUzz8dvCCqOPzdmQHMLcxDmSXSzU+PG9yitpDq2eWiQb0OJ3blX
        HRsqSMjAYoM7dBgFVK4Wi1A/LaG1NXgfbNIpXa4ZkXWX0Il4/9RlLD/KtKMx+tDmKEATx3
        4YljjOysYvDB92mIaKxGnycOiyg35yxrBfNlsGbRlq5KNAn6ztzd3wK1nGuFeQ==
Date:   Mon, 27 Feb 2023 11:22:55 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, helgaas@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        stefano.stabellini@xilinx.com, trix@redhat.com
Subject: Re: [PATCH V7 0/3] Generate device tree node for pci devices
Message-ID: <20230227112255.410c1a71@fixe.home>
In-Reply-To: <954cc40b-c484-5ba9-9039-eed3c1c722c3@gmail.com>
References: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
        <954cc40b-c484-5ba9-9039-eed3c1c722c3@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le Sun, 26 Feb 2023 16:38:58 -0600,
Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :

> Hi Cl=C3=A9ment, Hi Lizhi,
>=20
> On 1/19/23 21:02, Lizhi Hou wrote:
> > This patch series introduces OF overlay support for PCI devices which
> > primarily addresses two use cases. First, it provides a data driven met=
hod
> > to describe hardware peripherals that are present in a PCI endpoint and
> > hence can be accessed by the PCI host. Second, it allows reuse of a OF
> > compatible driver -- often used in SoC platforms -- in a PCI host based
> > system.
> >=20
> > There are 2 series devices rely on this patch:
> >=20
> >   1) Xilinx Alveo Accelerator cards (FPGA based device)
> >   2) Microchip LAN9662 Ethernet Controller
> >  =20
>=20
> Digging back through some history:
>=20
> >      Please see: https://lore.kernel.org/lkml/20220427094502.456111-1-c=
lement.leger@bootlin.com/ =20
>=20
> (I am selectively pulling two fragments, see the above link for the
> full email.)
>=20
> Includes the following:
>=20
>    A driver using this support was added and can be seen at [3]. This
>    driver embeds a builtin overlay and applies it to the live tree using
>    of_overlay_fdt_apply_to_node(). An interrupt driver is also included a=
nd
>=20
> and
>=20
>    This series was tested on a x86 kernel using CONFIG_OF under a virtual
>    machine using PCI passthrough.
>=20
>    Link: [1] https://lore.kernel.org/lkml/YhQHqDJvahgriDZK@lunn.ch/t/
>    Link: [2] https://lore.kernel.org/lkml/20220408174841.34458529@fixe.ho=
me/T/
>    Link: [3] https://github.com/clementleger/linux/tree/lan966x/of_support
>=20
> Following link 3 to see how the driver implemented the concept, I arrived
> at a git tree, with the commit be42efa "mfd: lan966x: add pci driver",
> and have been looking at the code there.
>=20
> Cl=C3=A9ment, is this still the best example of a driver implementation t=
hat
> would use the framework proposed in the "[PATCH V7 0/3] Generate device
> tree node for pci devices" patch series? And this is the driver for the
> device listed as item 2 above "2) Microchip LAN9662 Ethernet Controller"?

Hi Frank,

The driver has slightly evolved to be based on Lizhi Patches and the
interrupt driver was reworked to be a standard platform driver. I'll
clean that up and push a new branch based on this work.

This driver is indeed the driver for the LAN9662 Ethernet Controller
which allows using the 2 SFPs ports and 2 RJ45 ports successfully (which
involves multiple subsystem and drivers).

While doing this work, I found multiple of_noderefcount issues which I
fixed and that are currently being reviewed. I won't be surprised if
there are other lying around in various part of the kernel. Just saying
so you know there is actually effort to make that more robust.

Cl=C3=A9ment

>=20
> -Frank
>=20
> >=20
> > Normally, the PCI core discovers PCI devices and their BARs using the
> > PCI enumeration process. However, the process does not provide a way to
> > discover the hardware peripherals that are present in a PCI device, and
> > which can be accessed through the PCI BARs. Also, the enumeration proce=
ss
> > does not provide a way to associate MSI-X vectors of a PCI device with =
the
> > hardware peripherals that are present in the device. PCI device drivers
> > often use header files to describe the hardware peripherals and their
> > resources as there is no standard data driven way to do so. This patch
> > series proposes to use flattened device tree blob to describe the
> > peripherals in a data driven way. Based on previous discussion, using
> > device tree overlay is the best way to unflatten the blob and populate
> > platform devices. To use device tree overlay, there are three obvious
> > problems that need to be resolved.
> >=20
> > First, we need to create a base tree for non-DT system such as x86_64. A
> > patch series has been submitted for this:
> > https://lore.kernel.org/lkml/20220624034327.2542112-1-frowand.list@gmai=
l.com/
> > https://lore.kernel.org/lkml/20220216050056.311496-1-lizhi.hou@xilinx.c=
om/
> >=20
> > Second, a device tree node corresponding to the PCI endpoint is required
> > for overlaying the flattened device tree blob for that PCI endpoint.
> > Because PCI is a self-discoverable bus, a device tree node is usually n=
ot
> > created for PCI devices. This series adds support to generate a device
> > tree node for a PCI device which advertises itself using PCI quirks
> > infrastructure.
> >=20
> > Third, we need to generate device tree nodes for PCI bridges since a ch=
ild
> > PCI endpoint may choose to have a device tree node created.
> >=20
> > This patch series is made up of three patches. =20
>=20
> < snip >
>=20



--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
