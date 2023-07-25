Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87741762729
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 01:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjGYXFO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 19:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjGYXFN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 19:05:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770B5E7;
        Tue, 25 Jul 2023 16:05:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 132DB61926;
        Tue, 25 Jul 2023 23:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790C3C433C7;
        Tue, 25 Jul 2023 23:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690326311;
        bh=8u87rzOYUB7/c0OvMvcaBKrY8ZfQ238ZrdAu8eLiTwg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hsDb2Qjx8BUPWaF60ohr/F1CAxiNAoYO7jMn5YnLaysGynJ+IZm/QXijsZDnt1HPA
         08j6hV8YMhhfQjtB3GaOiC6C1YyBtgcy5XG65sPdmuDKHCFmSNKgReuEgpcXocFQ1T
         7j0TrtViuUMXIISXWkBd/7eh47cxhlcm9JEHq3jVd8hvvjF1lmEpWyyWWMHFVzoAMO
         Wcq+/YOGCwbym2N/CK/9NJB1LyYRLs5f0IH0ykG5WOGnUr+Rz5A/cL/ZZszkedH3uI
         20IaHZDrDMZAxmfg1NRj1Mr5fDkABbYj/MPkbSJ06vKVr/wiQEx1bz1M0w2mTehfL1
         k1v9V9DuZp6wg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b933bbd3eeso90630761fa.1;
        Tue, 25 Jul 2023 16:05:11 -0700 (PDT)
X-Gm-Message-State: ABy/qLaaG97ixLESOiv+kDbzXjxD6RgeeccdQe3Q5+4WpWAiXbQQf9L+
        nN4suHDRtjnLbk2W/BS6h8MfSkY1J3cX2GhVuA==
X-Google-Smtp-Source: APBJJlGiuk90Ip8gZC0eU2XxptJIjyvn4OaCBsXt9I6gU9jTBi07iiZP0B89Sux6tgm+ZK1Mh1tlaz8wsswH5R/ur4Y=
X-Received: by 2002:a2e:9556:0:b0:2b6:c2e4:a57a with SMTP id
 t22-20020a2e9556000000b002b6c2e4a57amr110000ljh.38.1690326309410; Tue, 25 Jul
 2023 16:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <1690323318-6103-1-git-send-email-lizhi.hou@amd.com> <1690323318-6103-3-git-send-email-lizhi.hou@amd.com>
In-Reply-To: <1690323318-6103-3-git-send-email-lizhi.hou@amd.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 25 Jul 2023 17:04:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLoJzqnXtJ4BZZo6Y5fVz7PW701968K1VkZX93oKzxf5w@mail.gmail.com>
Message-ID: <CAL_JsqLoJzqnXtJ4BZZo6Y5fVz7PW701968K1VkZX93oKzxf5w@mail.gmail.com>
Subject: Re: [PATCH V11 2/5] PCI: Create device tree node for bridge
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 25, 2023 at 4:15=E2=80=AFPM Lizhi Hou <lizhi.hou@amd.com> wrote=
:
>
> The PCI endpoint device such as Xilinx Alveo PCI card maps the register
> spaces from multiple hardware peripherals to its PCI BAR. Normally,
> the PCI core discovers devices and BARs using the PCI enumeration process=
.
> There is no infrastructure to discover the hardware peripherals that are
> present in a PCI device, and which can be accessed through the PCI BARs.
>
> Apparently, the device tree framework requires a device tree node for the
> PCI device. Thus, it can generate the device tree nodes for hardware
> peripherals underneath. Because PCI is self discoverable bus, there might
> not be a device tree node created for PCI devices. Furthermore, if the PC=
I
> device is hot pluggable, when it is plugged in, the device tree nodes for
> its parent bridges are required. Add support to generate device tree node
> for PCI bridges.
>
> Add an of_pci_make_dev_node() interface that can be used to create device
> tree node for PCI devices.
>
> Add a PCI_DYNAMIC_OF_NODES config option. When the option is turned on,
> the kernel will generate device tree nodes for PCI bridges unconditionall=
y.
>
> Initially, add the basic properties for the dynamically generated device
> tree nodes which include #address-cells, #size-cells, device_type,
> compatible, ranges, reg.
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>  drivers/pci/Kconfig       |  12 ++
>  drivers/pci/Makefile      |   1 +
>  drivers/pci/bus.c         |   2 +
>  drivers/pci/of.c          |  96 +++++++++++++++-
>  drivers/pci/of_property.c | 232 ++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h         |  12 ++
>  drivers/pci/remove.c      |   1 +
>  7 files changed, 354 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/pci/of_property.c
>
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 3c07d8d214b3..49bd09c7dd0a 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -194,6 +194,18 @@ config PCI_HYPERV
>           The PCI device frontend driver allows the kernel to import arbi=
trary
>           PCI devices from a PCI backend to support PCI driver domains.
>
> +config PCI_DYNAMIC_OF_NODES
> +       bool "Create device tree nodes for PCI devices"
> +       depends on OF
> +       select OF_DYNAMIC
> +       help
> +         This option enables support for generating device tree nodes fo=
r some
> +         PCI devices. Thus, the driver of this kind can load and overlay
> +         flattened device tree for its downstream devices.
> +
> +         Once this option is selected, the device tree nodes will be gen=
erated
> +         for all PCI bridges.
> +
>  choice
>         prompt "PCI Express hierarchy optimization setting"
>         default PCIE_BUS_DEFAULT
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 2680e4c92f0a..cc8b4e01e29d 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_PCI_P2PDMA)      +=3D p2pdma.o
>  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) +=3D xen-pcifront.o
>  obj-$(CONFIG_VGA_ARB)          +=3D vgaarb.o
>  obj-$(CONFIG_PCI_DOE)          +=3D doe.o
> +obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) +=3D of_property.o
>
>  # Endpoint library must be initialized before its users
>  obj-$(CONFIG_PCI_ENDPOINT)     +=3D endpoint/
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 5bc81cc0a2de..ab7d06cd0099 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -340,6 +340,8 @@ void pci_bus_add_device(struct pci_dev *dev)
>          */
>         pcibios_bus_add_device(dev);
>         pci_fixup_device(pci_fixup_final, dev);
> +       if (pci_is_bridge(dev))
> +               of_pci_make_dev_node(dev);
>         pci_create_sysfs_dev_files(dev);
>         pci_proc_attach_device(dev);
>         pci_bridge_d3_update(dev);
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index e51219f9f523..11d3be165e32 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -495,8 +495,21 @@ static int of_irq_parse_pci(const struct pci_dev *pd=
ev, struct of_phandle_args *
>                  * to rely on this function (you ship a firmware that doe=
sn't
>                  * create device nodes for all PCI devices).
>                  */
> -               if (ppnode)
> -                       break;
> +               if (ppnode) {
> +                       /*
> +                        * When PCI_DYNAMIC_OF_NODES is on, a device tree
> +                        * node will be generated for PCI bridge. For the
> +                        * dynamically generated node, interrupt mapping =
is
> +                        * not supported. Thus, it needs to check interru=
pt-map
> +                        * property and set ppnode to NULL to do standard
> +                        * swizzling if interrupt-map does not present.
> +                        */
> +                       if (IS_ENABLED(CONFIG_PCI_DYNAMIC_OF_NODES) &&
> +                           !of_property_present(ppnode, "interrupt-map")=
)
> +                               ppnode =3D NULL;

We cannot use a kconfig option to determine behavior. You don't get to
decide the value of the kconfig option. The OS distro does. As I've
said in the past, the kconfig option is not a long term solution. You
need things to work the same way whether PCI nodes were populated
before the kernel runs or dynamically.

Perhaps what you need to do is read PCI_INTERRUPT_PIN and if it's
non-zero for a device, populate 'interrupts' property using the value.
Then the standard DT interrupt parsing code should work. That code
will walk up nodes until it finds the host bridge interrupt-map.

Rob
