Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7EB646438
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 23:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiLGWop (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 17:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGWoo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 17:44:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D7483E84;
        Wed,  7 Dec 2022 14:44:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 234BEB8216F;
        Wed,  7 Dec 2022 22:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB69C433B5;
        Wed,  7 Dec 2022 22:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670453079;
        bh=XAcqFqnFKkKqA599RAuFn6x75NBJPlgLtoI8Xyl5XIA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JwmxGf5VCKDlRp1Df2gEbJq9PepRvy2apeCS5vibB/MFZlHvB8UKPCDpjSHV7Iccc
         eW0jroojuCE6ICtsPD7JRf4ruzYGM0bBhLK40qxun/bJ6fs3EpE4GoyUcr7qdE11dB
         1PbEQLtv3bBi/w/c5WldelqqAhCgrZwCTYkjc1eid0ZT8LL05c6ZzONqsTP9UQ0vJW
         6PJ1ispY84S/CzFvHk/2yj0D2NmjAH2h+qL0OzMlhxJ4STVTnxwow5q19KIiQjGiro
         cDGXaGJIlvwdm3SdsDPCSD8m/qkNrvJI1N/zJkm8LqSb4hupLGDl1MS4mkJIebeqsO
         hD6M/A+BtTkSA==
Received: by mail-vs1-f42.google.com with SMTP id 125so18661510vsi.9;
        Wed, 07 Dec 2022 14:44:39 -0800 (PST)
X-Gm-Message-State: ANoB5pnUt15DbuDVAjlayEnAToAjyCIBV/egLbyt8GmpJbc+tU+TFPlF
        wdh+fxuUytUQW32KX8uZUmrkGRh/j7IStLv4rw==
X-Google-Smtp-Source: AA0mqf5oMyM7xeqCPLDzFrVzgXv7T5LEcJz0g3WYasB44gjnVAvyLWVqp9ro0y5JBb+kyHuglGfzJ1d5UArAJEdKGog=
X-Received: by 2002:a67:af07:0:b0:3b1:1713:ba12 with SMTP id
 v7-20020a67af07000000b003b11713ba12mr12265983vsl.6.1670453078525; Wed, 07 Dec
 2022 14:44:38 -0800 (PST)
MIME-Version: 1.0
References: <1669048984-56394-1-git-send-email-lizhi.hou@amd.com>
 <1669048984-56394-3-git-send-email-lizhi.hou@amd.com> <20221201211224.GA1225112-robh@kernel.org>
 <5e8eabf7-edc8-28a9-afd7-1ccf207d5018@amd.com>
In-Reply-To: <5e8eabf7-edc8-28a9-afd7-1ccf207d5018@amd.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 7 Dec 2022 16:44:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJyi3XYdSmgOQ3Xk1cnMeRXUzSsd=-SgweKiLnEsJ-9YQ@mail.gmail.com>
Message-ID: <CAL_JsqJyi3XYdSmgOQ3Xk1cnMeRXUzSsd=-SgweKiLnEsJ-9YQ@mail.gmail.com>
Subject: Re: [RESEND PATCH RFC V4 2/3] PCI: Create device tree node for
 selected devices
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, frowand.list@gmail.com,
        helgaas@kernel.org, clement.leger@bootlin.com, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        stefano.stabellini@xilinx.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 5, 2022 at 6:30 PM Lizhi Hou <lizhi.hou@amd.com> wrote:
>
>
> On 12/1/22 13:12, Rob Herring wrote:
> > On Mon, Nov 21, 2022 at 08:43:03AM -0800, Lizhi Hou wrote:
> >> The PCI endpoint device such as Xilinx Alveo PCI card maps the register
> >> spaces from multiple hardware peripherals to its PCI BAR. Normally,
> >> the PCI core discovers devices and BARs using the PCI enumeration process.
> >> There is no infrastructure to discover the hardware peripherals that are
> >> present in a PCI device, and which can be accessed through the PCI BARs.
> >>
> >> For Alveo PCI card, the card firmware provides a flattened device tree to
> >> describe the hardware peripherals on its BARs. The Alveo card driver can
> >> load this flattened device tree and leverage device tree framework to
> >> generate platform devices for the hardware peripherals eventually.
> >>
> >> Apparently, the device tree framework requires a device tree node for the
> >> PCI device. Thus, it can generate the device tree nodes for hardware
> >> peripherals underneath. Because PCI is self discoverable bus, there might
> >> not be a device tree node created for PCI devices. This patch is to add
> >> support to generate device tree node for PCI devices.
> >>
> >> Added a kernel option. When the option is turned on, the kernel will
> >> generate device tree nodes for PCI bridges unconditionally.
> >>
> >> Initially, the basic properties are added for the dynamically generated
> >> device tree nodes.
> >>
> >> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> >> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
> >> Signed-off-by: Max Zhen <max.zhen@amd.com>
> >> Reviewed-by: Brian Xu <brian.xu@amd.com>
> >> ---
> >>   drivers/pci/Kconfig         |  12 ++
> >>   drivers/pci/Makefile        |   1 +
> >>   drivers/pci/bus.c           |   2 +
> >>   drivers/pci/msi/irqdomain.c |   6 +-
> >>   drivers/pci/of.c            |  71 ++++++++++
> >>   drivers/pci/of_property.c   | 256 ++++++++++++++++++++++++++++++++++++
> >>   drivers/pci/pci-driver.c    |   3 +-
> >>   drivers/pci/pci.h           |  19 +++
> >>   drivers/pci/remove.c        |   1 +
> >>   9 files changed, 368 insertions(+), 3 deletions(-)
> >>   create mode 100644 drivers/pci/of_property.c
> >>
> >> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> >> index 55c028af4bd9..126c31b79718 100644
> >> --- a/drivers/pci/Kconfig
> >> +++ b/drivers/pci/Kconfig
> >> @@ -198,6 +198,18 @@ config PCI_HYPERV
> >>        The PCI device frontend driver allows the kernel to import arbitrary
> >>        PCI devices from a PCI backend to support PCI driver domains.
> >>
> >> +config PCI_DYNAMIC_OF_NODES
> >> +    bool "Device tree node for PCI devices"
> > Create Devicetree nodes for PCI devices
> Sure.
> >
> > But as I've said before, making this a config option doesn't really work
> > except as something to experiment with. Once you add your driver and
> > want to do a 'select PCI_DYNAMIC_OF_NODES', you've affected everyone
> > else.
>
> Do you mean we should remove PCI_DYNAMIC_OF_NODES and make
> creating dynamic tree node default?

No, I'm saying as long as it is a config option, it's not useful for
more than experimentation. A distro kernel has to decide how to set a
config option for *everyone*.

> Based on the previous discussions, the approach I am implementing
> is to create device tree nodes for all PCI bridges and devices defined
> by pci quirks. I believe a PCI endpoint which is not defined by PCI quirks
> should not to be affected because there is no device tree node is created
> for it.
>
> Are you fine with this approach?

How does that work? The quirks run when a device is discovered. At
that time you've already discovered and probed everything upstream of
the device. So the only thing controlling the upstream devices getting
a DT node is the config option, right?

> >> +    depends on OF
> >> +    select OF_DYNAMIC
> >> +    help
> >> +      This option enables support for generating device tree nodes for some
> >> +      PCI devices. Thus, the driver of this kind can load and overlay
> >> +      flattened device tree for its downstream devices.
> >> +
> >> +      Once this option is selected, the device tree nodes will be generated
> >> +      for all PCI bridges.
> >> +
> >>   choice
> >>      prompt "PCI Express hierarchy optimization setting"
> >>      default PCIE_BUS_DEFAULT
> >> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> >> index 2680e4c92f0a..cc8b4e01e29d 100644
> >> --- a/drivers/pci/Makefile
> >> +++ b/drivers/pci/Makefile
> >> @@ -32,6 +32,7 @@ obj-$(CONFIG_PCI_P2PDMA)   += p2pdma.o
> >>   obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
> >>   obj-$(CONFIG_VGA_ARB)              += vgaarb.o
> >>   obj-$(CONFIG_PCI_DOE)              += doe.o
> >> +obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
> >>
> >>   # Endpoint library must be initialized before its users
> >>   obj-$(CONFIG_PCI_ENDPOINT) += endpoint/
> >> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> >> index 3cef835b375f..8507cc32b61d 100644
> >> --- a/drivers/pci/bus.c
> >> +++ b/drivers/pci/bus.c
> >> @@ -316,6 +316,8 @@ void pci_bus_add_device(struct pci_dev *dev)
> >>       */
> >>      pcibios_bus_add_device(dev);
> >>      pci_fixup_device(pci_fixup_final, dev);
> >> +    if (pci_is_bridge(dev))
> >> +            of_pci_make_dev_node(dev);
> >>      pci_create_sysfs_dev_files(dev);
> >>      pci_proc_attach_device(dev);
> >>      pci_bridge_d3_update(dev);
> >> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> >> index e9cf318e6670..eeaf44169bfd 100644
> >> --- a/drivers/pci/msi/irqdomain.c
> >> +++ b/drivers/pci/msi/irqdomain.c
> >> @@ -230,8 +230,10 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
> >>      pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
> >>
> >>      of_node = irq_domain_get_of_node(domain);
> >> -    rid = of_node ? of_msi_map_id(&pdev->dev, of_node, rid) :
> >> -                    iort_msi_map_id(&pdev->dev, rid);
> >> +    if (of_node && !of_node_check_flag(of_node, OF_DYNAMIC))
> >> +            rid = of_msi_map_id(&pdev->dev, of_node, rid);
> >> +    else
> >> +            rid = iort_msi_map_id(&pdev->dev, rid);
> > I have no idea if this works. It looks kind of broken already if
> > !of_node calls iort_msi_map_id(). With a DT only system, I would think
> > we'd always call of_msi_map_id(). Have you tested MSIs?
> >
> > With a mixed system, I have no idea what happens. That needs to be
> > understood for MSI, DMA, and interrupts.
>
> Yes, I tested MSI in VM.
>
> # cat
> /sys/devices/platform/3f000000.pcie/pci0000:00/0000:00:02.0/0000:09:00.0/0000:0a:00.0/msi_irqs/29
>
> msi
> # cat /proc/interrupts | grep 29
>   29:          1          0       MSI 5242880 Edge      pciehp
>
> The idea is to preserve the current behaviror.
>
>        current: PCI device does not have dt node, thus iort_msi_map_id()
> is called.
>
>        modified code: PCI device has dt node but with OF_DYNAMIC flag,
> thus  iort_msi_map_id() is called.
>
> I was planning to take on of_msi_map_id() for dynamically generated dt node
>
> in future when we see a real use case?
>
> >
> >>
> >>      return rid;
> >>   }
> >> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> >> index 196834ed44fe..fb60b04f0b93 100644
> >> --- a/drivers/pci/of.c
> >> +++ b/drivers/pci/of.c
> >> @@ -469,6 +469,8 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
> >>              } else {
> >>                      /* We found a P2P bridge, check if it has a node */
> >>                      ppnode = pci_device_to_OF_node(ppdev);
> >> +                    if (of_node_check_flag(ppnode, OF_DYNAMIC))
> >> +                            ppnode = NULL;
> >>              }
> >>
> >>              /*
> >> @@ -599,6 +601,75 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
> >>      return pci_parse_request_of_pci_ranges(dev, bridge);
> >>   }
> >>
> >> +#if IS_ENABLED(CONFIG_PCI_DYNAMIC_OF_NODES)
> >> +
> >> +void of_pci_remove_node(struct pci_dev *pdev)
> >> +{
> >> +    struct device_node *dt_node;
> > node or np are the typical names.
> Will fix this.
> >
> >> +
> >> +    dt_node = pci_device_to_OF_node(pdev);
> >> +    if (!dt_node || !of_node_check_flag(dt_node, OF_DYNAMIC))
> >> +            return;
> >> +    pdev->dev.of_node = NULL;
> >> +
> >> +    of_destroy_node(dt_node);
> >> +}
> >> +
> >> +void of_pci_make_dev_node(struct pci_dev *pdev)
> >> +{
> >> +    struct device_node *parent, *dt_node = NULL;
> >> +    const char *pci_type = "dev";
> >> +    struct of_changeset *cset;
> >> +    const char *full_name;
> >> +    int ret;
> >> +
> >> +    /*
> >> +     * If there is already a device tree node linked to this device,
> >> +     * return immediately.
> >> +     */
> >> +    if (pci_device_to_OF_node(pdev))
> >> +            return;
> >> +
> >> +    /* Check if there is device tree node for parent device */
> >> +    if (!pdev->bus->self)
> >> +            parent = pdev->bus->dev.of_node;
> >> +    else
> >> +            parent = pdev->bus->self->dev.of_node;
> >> +    if (!parent)
> >> +            return;
> >> +
> >> +    if (pci_is_bridge(pdev))
> >> +            pci_type = "pci";
> > What's the node name if not a bridge? I don't see how that would work.
> >
> > It should depend on the device class if it has one.
>
> pci_type is initialized with "dev"
>
> +    const char *pci_type = "dev";

I missed that...

> Do you mean I should use class instead of pci_is_bridge()?
>
> if ((pdev->class >> 24) == PCI_BASE_CLASS_BRIDGE)
>      pci_type = "pci";

Well, maybe as preparation to support other classes. If you had a UART
for example, the node name is 'serial'. I don't think you need to
worry about those ATM. We may need some way for the name to come from
the driver as not all devices have a class. Yours for example, we'd
want something like 'fpga@...' ideally. Maybe that's fine to leave as
a known issue.

Rob
