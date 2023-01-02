Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DBB65B5BA
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jan 2023 18:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjABROT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Jan 2023 12:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjABROH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jan 2023 12:14:07 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27BEAE45;
        Mon,  2 Jan 2023 09:14:04 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A2F17E0009;
        Mon,  2 Jan 2023 17:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672679643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jtZiXGegmvlBwyxMr/KRgFf6kuZi+2eQQuI5YxCyVe4=;
        b=D8JPs233qBQ4HxP77Ymf3JuOi5K7KW6gu7SuSpZf0/UsipduhAPX/GRya4R85WyhVD4KEi
        63VXXKXgOiU3USulunflI3DB3vTuLTSjp1wTYNyOlUxznR2WtuNoTMBhF0cMoHwGZ5gAw7
        sQ4Nvc/CTSOpOXB5z+HED/Olbwp33ZacM5nWZBcPqbhqCiNHebg161U6zb0AXV8vxEKrrT
        BioqrmbBaXFanGaO2QA+Bqt4yADxKZeiBEB4UFxRRpCb3dJ+BJNuuKIMjCpaBj0CTIYCOM
        vDXE38S4cy7zF5UxfURBN3rm0Twk5pFdyD3IZ96az0AnYilTkPRMdf+fi1RMzA==
Date:   Mon, 2 Jan 2023 18:16:11 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <stefano.stabellini@xilinx.com>, <trix@redhat.com>,
        "Allan.Nielsen@microchip.com" <Allan.Nielsen@microchip.com>,
        "Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
        "Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>
Subject: Re: [PATCH V5 2/3] PCI: Create device tree node for selected
 devices
Message-ID: <20230102181611.0e6023f2@fixe.home>
In-Reply-To: <1671125446-57584-3-git-send-email-lizhi.hou@amd.com>
References: <1671125446-57584-1-git-send-email-lizhi.hou@amd.com>
        <1671125446-57584-3-git-send-email-lizhi.hou@amd.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
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

Le Thu, 15 Dec 2022 09:30:45 -0800,
Lizhi Hou <lizhi.hou@amd.com> a =C3=A9crit :

> The PCI endpoint device such as Xilinx Alveo PCI card maps the register
> spaces from multiple hardware peripherals to its PCI BAR. Normally,
> the PCI core discovers devices and BARs using the PCI enumeration process.
> There is no infrastructure to discover the hardware peripherals that are
> present in a PCI device, and which can be accessed through the PCI BARs.
>=20
> For Alveo PCI card, the card firmware provides a flattened device tree to
> describe the hardware peripherals on its BARs. The Alveo card driver can
> load this flattened device tree and leverage device tree framework to
> generate platform devices for the hardware peripherals eventually.
>=20
> Apparently, the device tree framework requires a device tree node for the
> PCI device. Thus, it can generate the device tree nodes for hardware
> peripherals underneath. Because PCI is self discoverable bus, there might
> not be a device tree node created for PCI devices. This patch is to add
> support to generate device tree node for PCI devices.
>=20
> Added a kernel option. When the option is turned on, the kernel will
> generate device tree nodes for PCI bridges unconditionally.
>=20
> Initially, the basic properties are added for the dynamically generated
> device tree nodes.
>=20
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Reviewed-by: Brian Xu <brian.xu@amd.com>
> ---
>  drivers/pci/Kconfig         |  12 ++
>  drivers/pci/Makefile        |   1 +
>  drivers/pci/bus.c           |   2 +
>  drivers/pci/msi/irqdomain.c |   6 +-
>  drivers/pci/of.c            |  71 ++++++++++++
>  drivers/pci/of_property.c   | 222 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci-driver.c    |   3 +-
>  drivers/pci/pci.h           |  19 +++
>  drivers/pci/remove.c        |   1 +
>  9 files changed, 334 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/pci/of_property.c
>=20
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 55c028af4bd9..1b2347aa1e5b 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -198,6 +198,18 @@ config PCI_HYPERV
>  	  The PCI device frontend driver allows the kernel to import arbitrary
>  	  PCI devices from a PCI backend to support PCI driver domains.
> =20
> +config PCI_DYNAMIC_OF_NODES
> +	bool "Create Devicetree nodes for PCI devices"
> +	depends on OF
> +	select OF_DYNAMIC
> +	help
> +	  This option enables support for generating device tree nodes for some
> +	  PCI devices. Thus, the driver of this kind can load and overlay
> +	  flattened device tree for its downstream devices.
> +
> +	  Once this option is selected, the device tree nodes will be generated
> +	  for all PCI bridges.
> +
>  choice
>  	prompt "PCI Express hierarchy optimization setting"
>  	default PCIE_BUS_DEFAULT
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 2680e4c92f0a..cc8b4e01e29d 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+=3D p2pdma.o
>  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) +=3D xen-pcifront.o
>  obj-$(CONFIG_VGA_ARB)		+=3D vgaarb.o
>  obj-$(CONFIG_PCI_DOE)		+=3D doe.o
> +obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) +=3D of_property.o
> =20
>  # Endpoint library must be initialized before its users
>  obj-$(CONFIG_PCI_ENDPOINT)	+=3D endpoint/
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 3cef835b375f..8507cc32b61d 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -316,6 +316,8 @@ void pci_bus_add_device(struct pci_dev *dev)
>  	 */
>  	pcibios_bus_add_device(dev);
>  	pci_fixup_device(pci_fixup_final, dev);
> +	if (pci_is_bridge(dev))
> +		of_pci_make_dev_node(dev);
>  	pci_create_sysfs_dev_files(dev);
>  	pci_proc_attach_device(dev);
>  	pci_bridge_d3_update(dev);
> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> index e9cf318e6670..eeaf44169bfd 100644
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -230,8 +230,10 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *do=
main, struct pci_dev *pdev)
>  	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
> =20
>  	of_node =3D irq_domain_get_of_node(domain);
> -	rid =3D of_node ? of_msi_map_id(&pdev->dev, of_node, rid) :
> -			iort_msi_map_id(&pdev->dev, rid);
> +	if (of_node && !of_node_check_flag(of_node, OF_DYNAMIC))
> +		rid =3D of_msi_map_id(&pdev->dev, of_node, rid);
> +	else
> +		rid =3D iort_msi_map_id(&pdev->dev, rid);
> =20
>  	return rid;
>  }
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 196834ed44fe..cb34a73ac8a3 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -469,6 +469,8 @@ static int of_irq_parse_pci(const struct pci_dev *pde=
v, struct of_phandle_args *
>  		} else {
>  			/* We found a P2P bridge, check if it has a node */
>  			ppnode =3D pci_device_to_OF_node(ppdev);
> +			if (ppnode && of_node_check_flag(ppnode, OF_DYNAMIC))
> +				ppnode =3D NULL;
>  		}
> =20
>  		/*
> @@ -599,6 +601,75 @@ int devm_of_pci_bridge_init(struct device *dev, stru=
ct pci_host_bridge *bridge)
>  	return pci_parse_request_of_pci_ranges(dev, bridge);
>  }
> =20
> +#if IS_ENABLED(CONFIG_PCI_DYNAMIC_OF_NODES)
> +
> +void of_pci_remove_node(struct pci_dev *pdev)
> +{
> +	struct device_node *np;
> +
> +	np =3D pci_device_to_OF_node(pdev);
> +	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
> +		return;
> +	pdev->dev.of_node =3D NULL;
> +
> +	of_destroy_node(np);
> +}
> +
> +void of_pci_make_dev_node(struct pci_dev *pdev)
> +{
> +	struct device_node *ppnode, *np =3D NULL;
> +	const char *pci_type =3D "dev";
> +	struct of_changeset *cset;
> +	const char *name;
> +	int ret;
> +
> +	/*
> +	 * If there is already a device tree node linked to this device,
> +	 * return immediately.
> +	 */
> +	if (pci_device_to_OF_node(pdev))
> +		return;
> +
> +	/* Check if there is device tree node for parent device */
> +	if (!pdev->bus->self)
> +		ppnode =3D pdev->bus->dev.of_node;
> +	else
> +		ppnode =3D pdev->bus->self->dev.of_node;
> +	if (!ppnode)
> +		return;
> +
> +	if (pci_is_bridge(pdev))
> +		pci_type =3D "pci";
> +
> +	name =3D kasprintf(GFP_KERNEL, "%s@%x,%x", pci_type,
> +			 PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
> +	if (!name)
> +		goto failed;
> +
> +	np =3D of_create_node(ppnode, name, &cset);
> +	if (!np)
> +		goto failed;
> +
> +	ret =3D of_pci_add_properties(pdev, cset, np);
> +	if (ret)
> +		goto failed;
> +
> +	ret =3D of_changeset_apply(cset);
> +	if (ret)
> +		goto failed;
> +
> +	pdev->dev.of_node =3D np;
> +	kfree(name);
> +
> +	return;
> +
> +failed:
> +	if (np)
> +		of_destroy_node(np);
> +	kfree(name);
> +}
> +#endif
> +
>  #endif /* CONFIG_PCI */
> =20
>  /**
> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> new file mode 100644
> index 000000000000..05c8ca05a71b
> --- /dev/null
> +++ b/drivers/pci/of_property.c
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2022, Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/of.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <asm/unaligned.h>
> +#include "pci.h"
> +
> +#define OF_PCI_ADDRESS_CELLS		3
> +#define OF_PCI_SIZE_CELLS		2
> +
> +struct of_pci_addr_pair {
> +	u32		phys_addr[OF_PCI_ADDRESS_CELLS];
> +	u32		size[OF_PCI_SIZE_CELLS];
> +};
> +
> +struct of_pci_range {
> +	u32		child_addr[OF_PCI_ADDRESS_CELLS];
> +	u32		parent_addr[OF_PCI_ADDRESS_CELLS];
> +	u32		size[OF_PCI_SIZE_CELLS];
> +};
> +
> +#define OF_PCI_ADDR_SPACE_CONFIG	0x0
> +#define OF_PCI_ADDR_SPACE_IO		0x1
> +#define OF_PCI_ADDR_SPACE_MEM32		0x2
> +#define OF_PCI_ADDR_SPACE_MEM64		0x3
> +
> +#define OF_PCI_ADDR_FIELD_NONRELOC	BIT(31)
> +#define OF_PCI_ADDR_FIELD_SS		GENMASK(25, 24)
> +#define OF_PCI_ADDR_FIELD_PREFETCH	BIT(30)
> +#define OF_PCI_ADDR_FIELD_BUS		GENMASK(23, 16)
> +#define OF_PCI_ADDR_FIELD_DEV		GENMASK(15, 11)
> +#define OF_PCI_ADDR_FIELD_FUNC		GENMASK(10, 8)
> +#define OF_PCI_ADDR_FIELD_REG		GENMASK(7, 0)
> +
> +#define OF_PCI_ADDR_HI			GENMASK_ULL(63, 32)
> +#define OF_PCI_ADDR_LO			GENMASK_ULL(31, 0)
> +#define OF_PCI_SIZE_HI			GENMASK_ULL(63, 32)
> +#define OF_PCI_SIZE_LO			GENMASK_ULL(31, 0)
> +
> +enum of_pci_prop_compatible {
> +	PROP_COMPAT_PCI_VVVV_DDDD,
> +	PROP_COMPAT_PCICLASS_CCSSPP,
> +	PROP_COMPAT_PCICLASS_CCSS,
> +	PROP_COMPAT_NUM,
> +};
> +
> +static int of_pci_prop_device_type(struct pci_dev *pdev,
> +				   struct of_changeset *ocs,
> +				   struct device_node *np)
> +{
> +	return of_changeset_add_prop_string(ocs, np, "device_type", "pci");
> +}
> +
> +static int of_pci_prop_address_cells(struct pci_dev *pdev,
> +				     struct of_changeset *ocs,
> +				     struct device_node *np)
> +{
> +	return of_changeset_add_prop_u32(ocs, np, "#address_cells",
> +					 OF_PCI_ADDRESS_CELLS);
> +}
> +
> +static int of_pci_prop_size_cells(struct pci_dev *pdev,
> +				  struct of_changeset *ocs,
> +				  struct device_node *np)
> +{
> +	return of_changeset_add_prop_u32(ocs, np, "#size_cells",
> +					 OF_PCI_SIZE_CELLS);
> +}
> +
> +static void of_pci_set_address(u32 *prop, u64 addr, u32 flags)
> +{
> +	prop[0] =3D flags;
> +	put_unaligned(addr, &prop[1]);
> +}

Here, the put_unaligned() call will assume you want to store a 32bits
value since prop is pointing to a u32 array. This can't work.

Moreover, when storing a 64bits address in device-tree properties, they
are stored starting with their 32 MSB in the first cell and the
32 LSB in the next cells.

This should probably be something like this:

static void of_pci_set_address(u32 *prop, u64 addr, u32 flags)
{
	prop[0] =3D flags;
	prop[1] =3D addr >> 32;
	prop[2] =3D addr;
}

[snip]

> +
> +static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset =
*ocs,
> +			      struct device_node *np)
> +{
> +	struct of_pci_range rp[PCI_BRIDGE_RESOURCE_NUM];
> +	struct resource *res;
> +	int i =3D 0, j, ret;
> +	u64 val64;
> +	u32 flags;
> +
> +	res =3D &pdev->resource[PCI_BRIDGE_RESOURCES];
> +	for (j =3D 0; j < PCI_BRIDGE_RESOURCE_NUM; j++) {
> +		if (!resource_size(&res[j]))
> +			continue;
> +
> +		flags =3D OF_PCI_ADDR_FIELD_NONRELOC;
> +		if (of_pci_get_addr_flags(&res[j], &flags))
> +			continue;
> +
> +		val64 =3D res[j].start;
> +		of_pci_set_address(rp[i].parent_addr, val64, flags);
> +		of_pci_set_address(rp[i].child_addr, val64, flags);
> +
> +		val64 =3D resource_size(&res[j]);
> +		put_unaligned(val64, rp[i].size);

Same problem here, the size is meant to be a 64 bits values but will
assume you want to store it using a 32bits pointer.

> +
> +		i++;
> +	}
> +
> +	ret =3D of_changeset_add_prop_u32_array(ocs, np, "ranges", (u32 *)rp,
> +					      i * sizeof(*rp) / sizeof(u32));
> +
> +	return ret;
> +}
> +
> +static int of_pci_prop_reg(struct pci_dev *pdev, struct of_changeset *oc=
s,
> +			   struct device_node *np)
> +{
> +	struct of_pci_addr_pair *reg;
> +	int i =3D 1, resno, ret =3D 0;
> +	u32 reg_val, base_addr;
> +	resource_size_t sz;
> +
> +	reg =3D kzalloc(sizeof(*reg) * (PCI_STD_NUM_BARS + 1), GFP_KERNEL);
> +	if (!reg)
> +		return -ENOMEM;
> +
> +	reg_val =3D FIELD_PREP(OF_PCI_ADDR_FIELD_SS, OF_PCI_ADDR_SPACE_CONFIG) |
> +		FIELD_PREP(OF_PCI_ADDR_FIELD_BUS, pdev->bus->number) |
> +		FIELD_PREP(OF_PCI_ADDR_FIELD_DEV, PCI_SLOT(pdev->devfn)) |
> +		FIELD_PREP(OF_PCI_ADDR_FIELD_FUNC, PCI_FUNC(pdev->devfn));
> +	of_pci_set_address(reg[0].phys_addr, 0, reg_val);
> +
> +	base_addr =3D PCI_BASE_ADDRESS_0;
> +	for (resno =3D PCI_STD_RESOURCES; resno <=3D PCI_STD_RESOURCE_END;
> +	     resno++, base_addr +=3D 4) {
> +		sz =3D pci_resource_len(pdev, resno);
> +		if (!sz)
> +			continue;
> +
> +		ret =3D of_pci_get_addr_flags(&pdev->resource[resno], &reg_val);
> +		if (!ret)
> +			continue;
> +
> +		reg_val &=3D ~OF_PCI_ADDR_FIELD_REG;
> +		reg_val |=3D FIELD_PREP(OF_PCI_ADDR_FIELD_REG, base_addr);
> +		of_pci_set_address(reg[i].phys_addr, 0, reg_val);
> +		put_unaligned((u64)sz, reg[i].size);

And same here. Something like this should probably be used (untested):

static void of_pci_set_size(u32 *prop, u64 size)
{
	prop[0] =3D size >> 32;
	prop[1] =3D size;
}

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
