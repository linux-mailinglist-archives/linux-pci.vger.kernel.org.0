Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE18363F997
	for <lists+linux-pci@lfdr.de>; Thu,  1 Dec 2022 22:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiLAVM2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Dec 2022 16:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiLAVM2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Dec 2022 16:12:28 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D16BEE1A;
        Thu,  1 Dec 2022 13:12:26 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id l42-20020a9d1b2d000000b0066c6366fbc3so1783578otl.3;
        Thu, 01 Dec 2022 13:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAFyTGm9QWJvE8SjDWxAh+EXptzHRpf+a3XqIj1gJp8=;
        b=yIHIQWvINY99xe+TSp3SAPFyx+8FN9LW5DRahqzVTqiGkaL+ZeCWDuoqxD1TM396Z+
         l2u4/8vxmmuzfHKxYpVG35fmul76fV+SFYxVAHhQl1479c96wjeN7Oxk+R5z/OUMmWU6
         EiJDmh4SOEm6r9nwGk7vtOKgoPLILph3gurZzdDir65mNpMx6uPEQ3jHxiTInYMIY0k+
         L0sYB2AnjU8KNV02qbDVSLDMjx7PmnWxcv+T+YGU28BCpVX09Y7bb79xgpCKyt/ButYy
         7LsaA23aKUQxMLm3zPU8vvYzApqY/dIsBfu1JCit3GjhB/K3Ora/mTnxSPR83WdcMJ6d
         1nQQ==
X-Gm-Message-State: ANoB5pnypRPWZsm1QMTo0S9yMtzHD0W9z0YfJkgSVmEA09BXVjpLdyKE
        vBUISHItY3dLcMD7GNYwHA==
X-Google-Smtp-Source: AA0mqf5JKubuoKPivizMUPH85lWk45F1AFTIcP11dlw4x81Kkmqu+6u0tbV+Rqz8e9Z2PeRp8hba8A==
X-Received: by 2002:a05:6830:6215:b0:66c:5e63:40f5 with SMTP id cd21-20020a056830621500b0066c5e6340f5mr24279246otb.51.1669929145640;
        Thu, 01 Dec 2022 13:12:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u36-20020a056808152400b0035a534b9237sm2276218oiw.29.2022.12.01.13.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 13:12:25 -0800 (PST)
Received: (nullmailer pid 1401603 invoked by uid 1000);
        Thu, 01 Dec 2022 21:12:24 -0000
Date:   Thu, 1 Dec 2022 15:12:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, frowand.list@gmail.com,
        helgaas@kernel.org, clement.leger@bootlin.com, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        stefano.stabellini@xilinx.com, trix@redhat.com
Subject: Re: [RESEND PATCH RFC V4 2/3] PCI: Create device tree node for
 selected devices
Message-ID: <20221201211224.GA1225112-robh@kernel.org>
References: <1669048984-56394-1-git-send-email-lizhi.hou@amd.com>
 <1669048984-56394-3-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669048984-56394-3-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 21, 2022 at 08:43:03AM -0800, Lizhi Hou wrote:
> The PCI endpoint device such as Xilinx Alveo PCI card maps the register
> spaces from multiple hardware peripherals to its PCI BAR. Normally,
> the PCI core discovers devices and BARs using the PCI enumeration process.
> There is no infrastructure to discover the hardware peripherals that are
> present in a PCI device, and which can be accessed through the PCI BARs.
> 
> For Alveo PCI card, the card firmware provides a flattened device tree to
> describe the hardware peripherals on its BARs. The Alveo card driver can
> load this flattened device tree and leverage device tree framework to
> generate platform devices for the hardware peripherals eventually.
> 
> Apparently, the device tree framework requires a device tree node for the
> PCI device. Thus, it can generate the device tree nodes for hardware
> peripherals underneath. Because PCI is self discoverable bus, there might
> not be a device tree node created for PCI devices. This patch is to add
> support to generate device tree node for PCI devices.
> 
> Added a kernel option. When the option is turned on, the kernel will
> generate device tree nodes for PCI bridges unconditionally.
> 
> Initially, the basic properties are added for the dynamically generated
> device tree nodes.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Reviewed-by: Brian Xu <brian.xu@amd.com>
> ---
>  drivers/pci/Kconfig         |  12 ++
>  drivers/pci/Makefile        |   1 +
>  drivers/pci/bus.c           |   2 +
>  drivers/pci/msi/irqdomain.c |   6 +-
>  drivers/pci/of.c            |  71 ++++++++++
>  drivers/pci/of_property.c   | 256 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci-driver.c    |   3 +-
>  drivers/pci/pci.h           |  19 +++
>  drivers/pci/remove.c        |   1 +
>  9 files changed, 368 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/pci/of_property.c
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 55c028af4bd9..126c31b79718 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -198,6 +198,18 @@ config PCI_HYPERV
>  	  The PCI device frontend driver allows the kernel to import arbitrary
>  	  PCI devices from a PCI backend to support PCI driver domains.
>  
> +config PCI_DYNAMIC_OF_NODES
> +	bool "Device tree node for PCI devices"

Create Devicetree nodes for PCI devices

But as I've said before, making this a config option doesn't really work 
except as something to experiment with. Once you add your driver and 
want to do a 'select PCI_DYNAMIC_OF_NODES', you've affected everyone 
else.

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
> @@ -32,6 +32,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
>  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>  obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>  obj-$(CONFIG_PCI_DOE)		+= doe.o
> +obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>  
>  # Endpoint library must be initialized before its users
>  obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
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
> @@ -230,8 +230,10 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
>  	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
>  
>  	of_node = irq_domain_get_of_node(domain);
> -	rid = of_node ? of_msi_map_id(&pdev->dev, of_node, rid) :
> -			iort_msi_map_id(&pdev->dev, rid);
> +	if (of_node && !of_node_check_flag(of_node, OF_DYNAMIC))
> +		rid = of_msi_map_id(&pdev->dev, of_node, rid);
> +	else
> +		rid = iort_msi_map_id(&pdev->dev, rid);

I have no idea if this works. It looks kind of broken already if 
!of_node calls iort_msi_map_id(). With a DT only system, I would think 
we'd always call of_msi_map_id(). Have you tested MSIs?

With a mixed system, I have no idea what happens. That needs to be 
understood for MSI, DMA, and interrupts.

>  
>  	return rid;
>  }
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 196834ed44fe..fb60b04f0b93 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -469,6 +469,8 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
>  		} else {
>  			/* We found a P2P bridge, check if it has a node */
>  			ppnode = pci_device_to_OF_node(ppdev);
> +			if (of_node_check_flag(ppnode, OF_DYNAMIC))
> +				ppnode = NULL;
>  		}
>  
>  		/*
> @@ -599,6 +601,75 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>  	return pci_parse_request_of_pci_ranges(dev, bridge);
>  }
>  
> +#if IS_ENABLED(CONFIG_PCI_DYNAMIC_OF_NODES)
> +
> +void of_pci_remove_node(struct pci_dev *pdev)
> +{
> +	struct device_node *dt_node;

node or np are the typical names.

> +
> +	dt_node = pci_device_to_OF_node(pdev);
> +	if (!dt_node || !of_node_check_flag(dt_node, OF_DYNAMIC))
> +		return;
> +	pdev->dev.of_node = NULL;
> +
> +	of_destroy_node(dt_node);
> +}
> +
> +void of_pci_make_dev_node(struct pci_dev *pdev)
> +{
> +	struct device_node *parent, *dt_node = NULL;
> +	const char *pci_type = "dev";
> +	struct of_changeset *cset;
> +	const char *full_name;
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
> +		parent = pdev->bus->dev.of_node;
> +	else
> +		parent = pdev->bus->self->dev.of_node;
> +	if (!parent)
> +		return;
> +
> +	if (pci_is_bridge(pdev))
> +		pci_type = "pci";

What's the node name if not a bridge? I don't see how that would work.

It should depend on the device class if it has one.

> +
> +	full_name = kasprintf(GFP_KERNEL, "%pOF/%s@%x,%x", parent, pci_type,
> +			      PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));

'full_name' in the DT code is historical. It's not storing the full path 
now. It's just 'name' with the unit-address. So why does 
of_create_node() need the full path?

> +	if (!full_name)
> +		goto failed;
> +
> +	dt_node = of_create_node(parent, full_name, &cset);
> +	if (!dt_node)
> +		goto failed;
> +	kfree(full_name);
> +
> +	ret = of_pci_add_properties(pdev, cset, dt_node);
> +	if (ret)
> +		goto failed;
> +
> +	ret = of_changeset_apply(cset);
> +	if (ret)
> +		goto failed;
> +
> +	pdev->dev.of_node = dt_node;
> +
> +	return;
> +
> +failed:
> +	if (dt_node)
> +		of_destroy_node(dt_node);
> +	kfree(full_name);
> +}
> +#endif
> +
>  #endif /* CONFIG_PCI */
>  
>  /**
> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> new file mode 100644
> index 000000000000..cc66fa7517e0
> --- /dev/null
> +++ b/drivers/pci/of_property.c
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0+

GPL-2.0-only

> +/*
> + * Copyright (C) 2022, Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/of.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include "pci.h"
> +
> +struct of_pci_addr_pair {
> +	__be32		phys_hi;
> +	__be32		phys_mid;
> +	__be32		phys_lo;
> +	__be32		size_hi;
> +	__be32		size_lo;
> +};
> +
> +struct of_pci_range {
> +	__be32		child_addr_hi;
> +	__be32		child_addr_mid;
> +	__be32		child_addr_lo;
> +	__be32		parent_addr_hi;
> +	__be32		parent_addr_mid;
> +	__be32		parent_addr_lo;
> +	__be32		size_hi;
> +	__be32		size_lo;
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
> +#define OF_PCI_ADDRESS_CELLS		3
> +#define OF_PCI_SIZE_CELLS		2
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
> +static int of_pci_set_addr_flags(struct resource *res, u32 *addr_hi)
> +{
> +	u32 ss;
> +
> +	if (res->flags & IORESOURCE_IO)
> +		ss = OF_PCI_ADDR_SPACE_IO;
> +	else if (res->flags & IORESOURCE_MEM_64)
> +		ss = OF_PCI_ADDR_SPACE_MEM64;
> +	else if (res->flags & IORESOURCE_MEM)
> +		ss = OF_PCI_ADDR_SPACE_MEM32;
> +	else
> +		return -EINVAL;
> +
> +	*addr_hi &= ~(OF_PCI_ADDR_FIELD_SS | OF_PCI_ADDR_FIELD_PREFETCH);
> +	if (res->flags & IORESOURCE_PREFETCH)
> +		*addr_hi |= OF_PCI_ADDR_FIELD_PREFETCH;
> +
> +	*addr_hi |= ss;
> +
> +	return 0;
> +}
> +
> +static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
> +			      struct device_node *np)
> +{
> +	struct of_pci_range rp[PCI_BRIDGE_RESOURCE_NUM];
> +	struct resource *res;
> +	int i = 0, j, ret;
> +	u64 val64;
> +	u32 val;
> +
> +	res = &pdev->resource[PCI_BRIDGE_RESOURCES];
> +	for (j = 0; j < PCI_BRIDGE_RESOURCE_NUM; j++) {
> +		if (!resource_size(&res[j]))
> +			continue;
> +
> +		val = OF_PCI_ADDR_FIELD_NONRELOC;
> +		if (of_pci_set_addr_flags(&res[j], &val))
> +			continue;
> +
> +		rp[i].parent_addr_hi = cpu_to_be32(val);
> +
> +		val64 = res[j].start;
> +		rp[i].parent_addr_mid =
> +			cpu_to_be32(FIELD_GET(OF_PCI_ADDR_HI, val64));
> +		rp[i].parent_addr_lo =
> +			cpu_to_be32(FIELD_GET(OF_PCI_ADDR_LO, val64));

cpu_to_be64(res[j].start) would be simpler, but then you'll need 
unaligned accessors.

This all could use some refactoring as you write 3 cell PCI addreses in 
several places. Something like:

of_pci_set_address(__be32 *prop, u64 addr, u32 flags)

> +
> +		val64 = resource_size(&res[j]);
> +		rp[i].size_hi = cpu_to_be32(FIELD_GET(OF_PCI_SIZE_HI, val64));
> +		rp[i].size_lo = cpu_to_be32(FIELD_GET(OF_PCI_SIZE_LO, val64));
> +
> +		rp[i].child_addr_hi = rp[i].parent_addr_hi;
> +		rp[i].child_addr_mid = rp[i].parent_addr_mid;
> +		rp[i].child_addr_lo = rp[i].parent_addr_lo;
> +		i++;
> +	}
> +
> +	ret = of_changeset_add_prop_u32_array(ocs, np, "ranges", (u32 *)rp,
> +					      i * sizeof(*rp) / sizeof(u32));
> +
> +	return ret;
> +}
> +
> +static int of_pci_prop_reg(struct pci_dev *pdev, struct of_changeset *ocs,
> +			   struct device_node *np)
> +{
> +	struct of_pci_addr_pair *reg;
> +	int i = 1, resno, ret = 0;
> +	u32 reg_val, base_addr;
> +	resource_size_t sz;
> +
> +	reg = kzalloc(sizeof(*reg) * (PCI_STD_NUM_BARS + 1), GFP_KERNEL);
> +	if (!reg)
> +		return -ENOMEM;
> +
> +	reg_val = FIELD_PREP(OF_PCI_ADDR_FIELD_SS, OF_PCI_ADDR_SPACE_CONFIG) |
> +		FIELD_PREP(OF_PCI_ADDR_FIELD_BUS, pdev->bus->number) |
> +		FIELD_PREP(OF_PCI_ADDR_FIELD_DEV, PCI_SLOT(pdev->devfn)) |
> +		FIELD_PREP(OF_PCI_ADDR_FIELD_FUNC, PCI_FUNC(pdev->devfn));
> +	reg[0].phys_hi = cpu_to_be32(reg_val);
> +
> +	base_addr = PCI_BASE_ADDRESS_0;
> +	for (resno = PCI_STD_RESOURCES; resno <= PCI_STD_RESOURCE_END;
> +	     resno++, base_addr += 4) {
> +		sz = pci_resource_len(pdev, resno);
> +		if (!sz)
> +			continue;
> +
> +		ret = of_pci_set_addr_flags(&pdev->resource[resno], &reg_val);
> +		if (!ret)
> +			continue;
> +
> +		reg_val &= ~OF_PCI_ADDR_FIELD_REG;
> +		reg_val |= FIELD_PREP(OF_PCI_ADDR_FIELD_REG, base_addr);
> +		reg[i].phys_hi = cpu_to_be32(reg_val);
> +		reg[i].size_hi = cpu_to_be32(FIELD_GET(OF_PCI_SIZE_HI, sz));
> +		reg[i].size_lo = cpu_to_be32(FIELD_GET(OF_PCI_SIZE_LO, sz));
> +		i++;
> +	}
> +
> +	ret = of_changeset_add_prop_u32_array(ocs, np, "reg", (u32 *)reg,
> +					      i * sizeof(*reg) / sizeof(u32));
> +	kfree(reg);
> +
> +	return ret;
> +}
> +
> +static int of_pci_prop_compatible(struct pci_dev *pdev,
> +				  struct of_changeset *ocs,
> +				  struct device_node *np)
> +{
> +	const char *compat_strs[PROP_COMPAT_NUM] = { 0 };
> +	int i, ret;
> +
> +	compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] =
> +		kasprintf(GFP_KERNEL, "pci%x,%x", pdev->vendor, pdev->device);
> +	compat_strs[PROP_COMPAT_PCICLASS_CCSSPP] =
> +		kasprintf(GFP_KERNEL, "pciclass,%06x", pdev->class);
> +	compat_strs[PROP_COMPAT_PCICLASS_CCSS] =
> +		kasprintf(GFP_KERNEL, "pciclass,%04x", pdev->class >> 8);
> +
> +	ret = of_changeset_add_prop_string_array(ocs, np, "compatible",
> +						 compat_strs, PROP_COMPAT_NUM);
> +	for (i = 0; i < PROP_COMPAT_NUM; i++)
> +		kfree(compat_strs[i]);
> +
> +	return ret;
> +}
> +
> +static int (*of_pci_endpoint_props[])(struct pci_dev *pdev,
> +				      struct of_changeset *ocs,
> +				      struct device_node *np) = {
> +	of_pci_prop_reg,
> +	of_pci_prop_compatible,
> +	NULL
> +};
> +
> +static int (*of_pci_bridge_props[])(struct pci_dev *pdev,
> +				    struct of_changeset *ocs,
> +				    struct device_node *np) = {
> +	of_pci_prop_device_type,
> +	of_pci_prop_address_cells,
> +	of_pci_prop_size_cells,
> +	of_pci_prop_ranges,
> +	of_pci_prop_reg,
> +	of_pci_prop_compatible,
> +	NULL
> +};
> +
> +int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
> +			  struct device_node *np)
> +{
> +	int (**prop_func)(struct pci_dev *pdev, struct of_changeset *ocs,
> +			  struct device_node *np);
> +	int i, ret;
> +
> +	if (pci_is_bridge(pdev))
> +		prop_func = of_pci_bridge_props;

Skip all this indirection and just make everything direct function 
calls.

> +	else
> +		prop_func = of_pci_endpoint_props;
> +
> +	for (i = 0; prop_func[i]; i++) {
> +		ret = prop_func[i](pdev, ocs, np);
> +		if (ret) {
> +			/*
> +			 * The added properties will be released when the
> +			 * changeset is destroyed.
> +			 */
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 49238ddd39ee..1540c4c9a770 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1628,7 +1628,8 @@ static int pci_dma_configure(struct device *dev)
>  	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
>  
>  	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
> -	    bridge->parent->of_node) {
> +	    bridge->parent->of_node &&
> +	    !of_node_check_flag(bridge->parent->of_node, OF_DYNAMIC)) {
>  		ret = of_dma_configure(dev, bridge->parent->of_node, true);
>  	} else if (has_acpi_companion(bridge)) {
>  		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 785f31086313..bd81dc4ca04f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -678,6 +678,25 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
>  
>  #endif /* CONFIG_OF */
>  
> +struct of_changeset;
> +
> +#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
> +void of_pci_make_dev_node(struct pci_dev *pdev);
> +void of_pci_remove_node(struct pci_dev *pdev);
> +int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
> +			  struct device_node *np);
> +#else
> +static inline void
> +of_pci_make_dev_node(struct pci_dev *pdev)
> +{
> +}
> +
> +static inline void
> +of_pci_remove_node(struct pci_dev *pdev)
> +{
> +}
> +#endif /* CONFIG_PCI_DYNAMIC_OF_NODES */
> +
>  #ifdef CONFIG_PCIEAER
>  void pci_no_aer(void);
>  void pci_aer_init(struct pci_dev *dev);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 4c54c75050dc..0eaa9d9a3609 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -23,6 +23,7 @@ static void pci_stop_dev(struct pci_dev *dev)
>  		device_release_driver(&dev->dev);
>  		pci_proc_detach_device(dev);
>  		pci_remove_sysfs_dev_files(dev);
> +		of_pci_remove_node(dev);
>  
>  		pci_dev_assign_added(dev, false);
>  	}
> -- 
> 2.17.1
> 
> 
