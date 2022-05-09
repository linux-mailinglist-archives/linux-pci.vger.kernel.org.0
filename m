Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD0551FC7D
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 14:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiEIMUh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 08:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbiEIMUe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 08:20:34 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7B0204;
        Mon,  9 May 2022 05:16:38 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 31E24FF80A;
        Mon,  9 May 2022 12:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652098597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qoCf4Wu4TqA+u/PSfELR7TgbBmtF/N1rQp/oz416fcs=;
        b=lM4jlzlfFyfyh/PdAMN2fWKwoEgxqk5m7hsvU0WkxpMWSrrWn9SNfZvrG1Kof0yaKgjd55
        TvHaJc6iMUWASLRKKAm8BYqdxSwjWfuRoDX4++qDt/ahyK9PY0OxVapUb+Y1dlYEZOq3ii
        qZh8Op0B2V6xdaYR53ZahLR6Zr4OHz5Ld9HDu4Y5YfGbzeAP3n/Te15w52t4Kyn11CnF20
        uXFGbfEcM5Lnl+UtFvWIzPcLVO7g1qtgrgI7OPrAere4a8L9GHGEsbPWklK5E6hg6GtETf
        LN+4BuE5Ckxsm1UI9ILAfyfZzSp+RDjFHAZ6R+AoXU9G89Ic6btWRySTZv6xDQ==
Date:   Mon, 9 May 2022 14:16:34 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazonni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] add dynamic PCI device of_node creation for overlay
Message-ID: <20220509141634.16158c38@xps-bootlin>
In-Reply-To: <96db62bb-18be-f44a-6f53-05b22319f23a@gmail.com>
References: <20220427094502.456111-1-clement.leger@bootlin.com>
        <96db62bb-18be-f44a-6f53-05b22319f23a@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le Fri, 6 May 2022 13:33:22 -0500,
Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :

> On 4/27/22 04:44, Cl=C3=A9ment L=C3=A9ger wrote:
> > This series adds foundation work to support the lan9662 PCIe card.
> > This card is meant to be used an ethernet switch with 2 x RJ45
> > ports and 2 x 2.5G SFPs. The lan966x SoCs can be used in two
> > different ways:
> >=20
> >  - It can run Linux by itself, on ARM64 cores included in the SoC.
> > This use-case of the lan966x is currently being upstreamed, using a
> >    traditional Device Tree representation of the lan996x HW blocks
> > [1] A number of drivers for the different IPs of the SoC have
> > already been merged in upstream Linux.
> >=20
> >  - It can be used as a PCIe endpoint, connected to a separate
> > platform that acts as the PCIe root complex. In this case, all the
> > devices that are embedded on this SoC are exposed through PCIe BARs
> > and the ARM64 cores of the SoC are not used. Since this is a PCIe
> > card, it can be plugged on any platform, of any architecture
> > supporting PCIe.
> >=20
> > The problem that arose is that we want to reuse all the existing OF
> > compatible drivers that are used when in SoC mode to instantiate the
> > PCI device when in PCIe endpoint mode.
> >=20
> > A previous attempt to tackle this problem was made using fwnode [1].
> > However, this proved being way too invasive and it required
> > modifications in both subsystems and drivers to support fwnode.
> > First series did not lead to a consensus and multiple ideas to
> > support this use-case were mentioned (ACPI overlay, fwnode,
> > device-tree overlay). Since it only seemed that fwnode was not a
> > totally silly idea, we continued on this way.
> >=20
> > However, on the series that added fwnode support to the reset
> > subsystem, Rob Herring mentioned the fact that OF overlay might
> > actually be the best way to probe PCI devices and populate platform
> > drivers using this overlay. He also provided a branch containing
> > some commits that helped =20
>=20
> I need to go look at the various email threads mentioned above before
> I continue reading this patch series.
>=20
> I do have serious concerns with this approach.  I need to investigate
> more fully before I can determine whether the concerns are addressed
> sufficiently.
>=20
> To give some background to my longstanding response to similar
> proposals, here is my old statement from
> https://elinux.org/Device_Tree_Reference:
>=20
>    Overlays
>    Mainline Linux Support
>    Run time overlay apply and run time overlay remove from user space
> are not supported in the mainline kernel. There   are out of tree
> patches to implement this feature via an overlay manager. The overlay
> manager is used successfully by many users for specific overlays on
> specific boards with specific environments and use cases. However,
> there are many issues with the Linux kernel overlay implementation
> due to incomplete and incorrect code. The overlay manager has not
> been accepted in mainline due to these issues. Once these issues are
> resolved, it is expected that some method of run time overlay apply
> and overlay removal from user space will be supported by the Linux
> kernel.
>=20
>    There is a possibility that overlay apply and overlay remove
> support could be phased in slowly, feature by feature, as specific
> issues are resolved.

Hi Frank,

This work uses the kernel space interface (of_overlay_fdt_apply())
and the device tree overlay is builtin the driver. This interface was
used until recently by rcu-dcar driver. While the only user (sic),
this seems to work pretty well and I was able to use it successfully.

Moreover, this support targets at using this with PCI devices. This
devices are really well contained and do not interfere with other
devices. This actually consists in adding a complete subtree into the
existing device-tree and thus it limits the interactions between
potentially platform provided devices and PCI ones.

Cl=C3=A9ment

>=20
> Those are my words, not Rob's, but I thought that Rob was somewhat in
> agreement with those ideas.  Apparently either I misunderstood his
> thoughts, or his thoughts have evolved, since you say that he
> suggested overlays in one of the above email threads, and you list
> him as a co-developer.
>=20
> In the next line of the elinux info above, I provide a link to more
> detailed information:
>=20
>    Frank's thoughts on what is needed to complete basic overlay
> support
>=20
> The link goes to:
>=20
>    https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts
>=20
> That page provides an incomplete list of issues to be resolved, and
> a list of "what has been completed".
>=20
> Please read through the elinux.org page to understand the basis of
> my concerns.
>=20
> If after reading through the related email threads, and this thread,
> I agree that overlays are a good approach, I am already aware of areas
> that I will have specific comments about on the patches in this
> thread.
>=20
> -Frank
>=20
> > to implement this idea on a x86 setup. Due to the dynamic nature of
> > PCI bus enumeration, some other modifications needs to be applied
> > on the overlay to apply it correctly. Indeed, it is necessary to
> > modify the target node of the fragments to apply them correctly on
> > the PCI device that was probed. Moreover, the 'ranges' must be set
> > according to the BAR addresses in order to remap devices to the
> > correct PCI addresses. These modifications are the located into the
> > driver since the remapping is something that is specific to each
> > driver.
> >=20
> > After modifications, this proves to be successful and a full
> > support of the aforementioned lan966x PCI card was added. The
> > modifications to support that (apply an overlay on a dynamically
> > created PCI of_node) are actually minimal and only touches a few
> > places (pci/of.c). This series contains the 3 commits that are
> > necessary to do that:
> >=20
> > - First commit creates the root node if not present on a x86 setup
> >   without a firmware provided device-tree.
> > - Second one dynamically creates the PCI bus/device device-tree node
> >   hierarchy using changeset API.
> > - Finally a last commit allows to apply an overlay by targeting a
> >   specific device-tree node.
> >=20
> > Other problems that might be considered with this series is the fact
> > that CONFIG_OF is not enabled by default on x86 configuration and
> > thus the driver can't be used without rebuilding a complete kernel
> > with CONFIG_OF=3Dy. In order to fully support this PCIe card and
> > allow lambda user to use this driver, it would be almost mandatory
> > to enable CONFIG_OF by default on such setup.
> >=20
> > A driver using this support was added and can be seen at [3]. This
> > driver embeds a builtin overlay and applies it to the live tree
> > using of_overlay_fdt_apply_to_node(). An interrupt driver is also
> > included and associated to a node that is added by the overlay. The
> > driver also insert a specific "ranges" property based on the BAR
> > values which allows to remap the device-tree node to BAR addresses
> > dynamically. This is needed to allow applying the overlay without
> > depending on specific enumeration BAR addresses.
> >=20
> > This series was tested on a x86 kernel using CONFIG_OF under a
> > virtual machine using PCI passthrough.
> >=20
> > Link: [1] https://lore.kernel.org/lkml/YhQHqDJvahgriDZK@lunn.ch/t/
> > Link: [2]
> > https://lore.kernel.org/lkml/20220408174841.34458529@fixe.home/T/
> > Link: [3]
> > https://github.com/clementleger/linux/tree/lan966x/of_support
> >=20
> > Cl=C3=A9ment L=C3=A9ger (3):
> >   of: always populate a root node
> >   PCI: of: create DT nodes for PCI devices if they do not exists
> >   of: overlay: add of_overlay_fdt_apply_to_node()
> >=20
> >  drivers/of/base.c    |  16 +++-
> >  drivers/of/overlay.c |  21 +++--
> >  drivers/pci/of.c     | 184
> > +++++++++++++++++++++++++++++++++++++++++++ include/linux/of.h   |
> > 17 +++- 4 files changed, 224 insertions(+), 14 deletions(-)
> >  =20
>=20

