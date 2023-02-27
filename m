Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863876A3F76
	for <lists+linux-pci@lfdr.de>; Mon, 27 Feb 2023 11:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjB0K3S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 05:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjB0K3R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 05:29:17 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C6093E8;
        Mon, 27 Feb 2023 02:29:14 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 85021FF811;
        Mon, 27 Feb 2023 10:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677493753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4vImSfKPrUKWkXa15i6OAv/IJbHNZFkDDY8XgxTTTWw=;
        b=aLQZM558UAuRIvzvtqVrd2QyzkUyWYQzCSgdViPO/8v+C80xe45ucxJyFcrH/1j9BuOVNa
        NI7H5snTJop2wbekce7Dd/NfLZSEbTucSmyt/i32qSsKRiv9yJbMGgJEC+8bhrYoxX7i5h
        Z+fBViJIJoPWQVNo4MliOldoCYe0jmZfZNJrGPxcwfsA1FK1JZqRQ7vnYe+dggOKgWRemh
        oSGCQAcw9HSTIA7iNVb3ILmRKxMe+BK5X6CWaOwK9srUDGWHfKy+CycVCmgv6f/4Qui5Uz
        nX3ihtBbawLfMexm4RJecU8IqOHXYAjeq8wK/XNAonqrwc2DXp7HUqmWKsdFcw==
Date:   Mon, 27 Feb 2023 11:31:50 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, helgaas@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        stefano.stabellini@xilinx.com, trix@redhat.com
Subject: Re: [PATCH V7 0/3] Generate device tree node for pci devices
Message-ID: <20230227113150.398dcfa7@fixe.home>
In-Reply-To: <af2a6686-ea35-e5fc-7541-27e5d6ca9311@gmail.com>
References: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
        <af2a6686-ea35-e5fc-7541-27e5d6ca9311@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le Mon, 27 Feb 2023 00:51:29 -0600,
Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :

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
> >=20
> >      Please see: https://lore.kernel.org/lkml/20220427094502.456111-1-c=
lement.leger@bootlin.com/
> >  =20
>=20
>=20
> > Normally, the PCI core discovers PCI devices and their BARs using the
> > PCI enumeration process. However, the process does not provide a way to
> > discover the hardware peripherals that are present in a PCI device, and
> > which can be accessed through the PCI BARs. Also, the enumeration proce=
ss =20
>=20
> I'm confused.  The PCI Configuration Header Registers should describe the
> hardware on the PCI card.
>=20
> Ignoring case 1 above _for the moment_ (FPGA devices are a world unto
> themselves, so I would like to analyze that case separately), does the
> second device, "Microchip LAN9662 Ethernet Controller" properly implement
> the PCI Configuration Header Registers?  What additional information is
> needed that is not provided in those registers?

Hi Frank,

I guess Lizhi wanted to say that it does not provide a way to describe
all the "platform" devices that are exposed by this PCI device. Which
is of course the whole point of the work we are doing right now. But
all the BARs are correctly described by the LAN9662 PCI card.

Cl=C3=A9ment

>=20
> -Frank
>=20
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
> > This patch series is made up of three patches.
> >=20
> > The first patch is adding OF interface to create or destroy OF node
> > dynamically.
> >=20
> > The second patch introduces a kernel option, CONFIG_DYNAMIC_PCI_OF_NODE=
X.
> > When the option is turned on, the kernel will generate device tree nodes
> > for all PCI bridges unconditionally. The patch also shows how to use the
> > PCI quirks infrastructure, DECLARE_PCI_FIXUP_FINAL to generate a device
> > tree node for a device. Specifically, the patch generates a device tree
> > node for Xilinx Alveo U50 PCIe accelerator device. The generated device
> > tree nodes do not have any property.
> >=20
> > The third patch adds basic properties ('reg', 'compatible' and
> > 'device_type') to the dynamically generated device tree nodes. More
> > properties can be added in the future.
> >=20
> > Here is the example of device tree nodes generated within the ARM64 QEM=
U.
> > # lspci -t   =20
> > -[0000:00]-+-00.0
> >            +-01.0-[01]--
> >            +-01.1-[02]----00.0
> >            +-01.2-[03]----00.0
> >            +-01.3-[04]----00.0
> >            +-01.4-[05]----00.0
> >            +-01.5-[06]--
> >            +-01.6-[07]--
> >            +-01.7-[08]--
> >            +-02.0-[09-0b]----00.0-[0a-0b]----00.0-[0b]--+-00.0
> >            |                                            \-00.1
> >            +-02.1-[0c]--
> >            \-03.0-[0d-0e]----00.0-[0e]----01.0
> >=20
> > # tree /sys/firmware/devicetree/base/pcie\@10000000
> > /sys/firmware/devicetree/base/pcie@10000000
> > |-- #address-cells
> > |-- #interrupt-cells
> > |-- #size-cells
> > |-- bus-range
> > |-- compatible
> > |-- device_type
> > |-- dma-coherent
> > |-- interrupt-map
> > |-- interrupt-map-mask
> > |-- linux,pci-domain
> > |-- msi-parent
> > |-- name
> > |-- pci@1,0
> > |   |-- #address-cells
> > |   |-- #size-cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- ranges
> > |   `-- reg
> > |-- pci@1,1
> > |   |-- #address-cells
> > |   |-- #size-cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- ranges
> > |   `-- reg
> > |-- pci@1,2
> > |   |-- #address-cells
> > |   |-- #size-cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- ranges
> > |   `-- reg
> > |-- pci@1,3
> > |   |-- #address-cells
> > |   |-- #size-cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- ranges
> > |   `-- reg
> > |-- pci@1,4
> > |   |-- #address-cells
> > |   |-- #size-cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- ranges
> > |   `-- reg
> > |-- pci@1,5
> > |   |-- #address-cells
> > |   |-- #size-cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- ranges
> > |   `-- reg
> > |-- pci@1,6
> > |   |-- #address-cells
> > |   |-- #size-cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- ranges
> > |   `-- reg
> > |-- pci@1,7
> > |   |-- #address-cells
> > |   |-- #size-cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- ranges
> > |   `-- reg
> > |-- pci@2,0
> > |   |-- #address-cells
> > |   |-- #size-cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- pci@0,0
> > |   |   |-- #address-cells
> > |   |   |-- #size-cells
> > |   |   |-- compatible
> > |   |   |-- device_type
> > |   |   |-- pci@0,0
> > |   |   |   |-- #address-cells
> > |   |   |   |-- #size-cells
> > |   |   |   |-- compatible
> > |   |   |   |-- dev@0,0
> > |   |   |   |   |-- compatible
> > |   |   |   |   `-- reg
> > |   |   |   |-- dev@0,1
> > |   |   |   |   |-- compatible
> > |   |   |   |   `-- reg
> > |   |   |   |-- device_type
> > |   |   |   |-- ranges
> > |   |   |   `-- reg
> > |   |   |-- ranges
> > |   |   `-- reg
> > |   |-- ranges
> > |   `-- reg
> > |-- pci@2,1
> > |   |-- #address-cells
> > |   |-- #size-cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- ranges
> > |   `-- reg
> > |-- pci@3,0
> > |   |-- #address-cells
> > |   |-- #size-cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- pci@0,0
> > |   |   |-- #address-cells
> > |   |   |-- #size-cells
> > |   |   |-- compatible
> > |   |   |-- device_type
> > |   |   |-- ranges
> > |   |   `-- reg
> > |   |-- ranges
> > |   `-- reg
> > |-- ranges
> > `-- reg
> >=20
> > Changes since v6:
> > - Removed single line wrapper functions
> > - Added Signed-off-by Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.co=
m>
> >=20
> > Changes since v5:
> > - Fixed code review comments
> > - Fixed incorrect 'ranges' and 'reg' properties and verified address
> >   translation.
> >=20
> > Changes since RFC v4:
> > - Fixed code review comments
> >=20
> > Changes since RFC v3:
> > - Split the Xilinx Alveo U50 PCI quirk to a separate patch
> > - Minor changes in commit description and code comment
> >=20
> > Changes since RFC v2:
> > - Merged patch 3 with patch 2
> > - Added OF interfaces of_changeset_add_prop_* and use them to create
> >   properties.
> > - Added '#address-cells', '#size-cells' and 'ranges' properties.
> >=20
> > Changes since RFC v1:
> > - Added one patch to create basic properties.
> > - To move DT related code out of PCI subsystem, replaced of_node_alloc()
> >   with of_create_node()/of_destroy_node()
> >=20
> > Lizhi Hou (3):
> >   of: dynamic: Add interfaces for creating device node dynamically
> >   PCI: Create device tree node for selected devices
> >   PCI: Add PCI quirks to generate device tree node for Xilinx Alveo U50
> >=20
> >  drivers/of/dynamic.c        | 197 +++++++++++++++++++++++++++++++++
> >  drivers/pci/Kconfig         |  12 ++
> >  drivers/pci/Makefile        |   1 +
> >  drivers/pci/bus.c           |   2 +
> >  drivers/pci/msi/irqdomain.c |   6 +-
> >  drivers/pci/of.c            |  71 ++++++++++++
> >  drivers/pci/of_property.c   | 212 ++++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci-driver.c    |   3 +-
> >  drivers/pci/pci.h           |  19 ++++
> >  drivers/pci/quirks.c        |  11 ++
> >  drivers/pci/remove.c        |   1 +
> >  include/linux/of.h          |  24 ++++
> >  12 files changed, 556 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/pci/of_property.c
> >  =20
>=20



--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
