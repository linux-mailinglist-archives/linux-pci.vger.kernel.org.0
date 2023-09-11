Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B3A79C3B9
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 05:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241676AbjILDIP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 23:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241695AbjILDID (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 23:08:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EC22F8D5;
        Mon, 11 Sep 2023 14:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694466654; x=1726002654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HodeLA1YPF9rQu/xpkdJPTv/y/IotPBfmXtWfqkNx48=;
  b=S/SNebapO1XdWMYQrvXOOIPCsBfO3aU7OJ2oQgi3X8DnvmFlNmPqWVq1
   pzI4A2wXOWhsUYlPOJVyayE1ttm8hU1u5dV728hiPFNDVy9QmB11PUcDA
   I1ngv8mxMf6nblClKI21DWdHcqStJarZmxCoOpnp+key5a4OtNhIqAlA7
   LlOD6fs4ffU4EJqws+82pKN28hhYB8a38uCG+rWh8wPohhS4zbL+UzgCq
   edNXlQU1V7jxfn/kXU4xQibtFqbBMxOSCwcLcvOsguXWLcT2J2MXmyKNk
   SiI/UrVHbfRmL8ozRGB6PHfEaLgZ6Jk1W5isHyFFoqnnWeVx5q7XZIXo9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="442211111"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="442211111"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 14:07:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="990248630"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="990248630"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 14:07:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qfo7W-008QLa-2v;
        Tue, 12 Sep 2023 00:06:58 +0300
Date:   Tue, 12 Sep 2023 00:06:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com
Subject: Re: [PATCH V13 2/5] PCI: Create device tree node for bridge
Message-ID: <ZP+BcnBl3+QdAl08@smile.fi.intel.com>
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
 <1692120000-46900-3-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692120000-46900-3-git-send-email-lizhi.hou@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 15, 2023 at 10:19:57AM -0700, Lizhi Hou wrote:
> The PCI endpoint device such as Xilinx Alveo PCI card maps the register
> spaces from multiple hardware peripherals to its PCI BAR. Normally,
> the PCI core discovers devices and BARs using the PCI enumeration process.
> There is no infrastructure to discover the hardware peripherals that are
> present in a PCI device, and which can be accessed through the PCI BARs.
> 
> Apparently, the device tree framework requires a device tree node for the
> PCI device. Thus, it can generate the device tree nodes for hardware
> peripherals underneath. Because PCI is self discoverable bus, there might
> not be a device tree node created for PCI devices. Furthermore, if the PCI
> device is hot pluggable, when it is plugged in, the device tree nodes for
> its parent bridges are required. Add support to generate device tree node
> for PCI bridges.
> 
> Add an of_pci_make_dev_node() interface that can be used to create device
> tree node for PCI devices.
> 
> Add a PCI_DYNAMIC_OF_NODES config option. When the option is turned on,
> the kernel will generate device tree nodes for PCI bridges unconditionally.
> 
> Initially, add the basic properties for the dynamically generated device
> tree nodes which include #address-cells, #size-cells, device_type,
> compatible, ranges, reg.

...

> @@ -32,6 +32,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
>  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>  obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>  obj-$(CONFIG_PCI_DOE)		+= doe.o

> +obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o

Maybe a bit ordered?

...

> +void of_pci_remove_node(struct pci_dev *pdev)
> +{
> +	struct device_node *np;
> +
> +	np = pci_device_to_OF_node(pdev);

CamelCase out of a sudden?!

> +	if (!np || !of_node_check_flag(np, OF_DYNAMIC))

Do you need a first check? Shouldn't the second return false for you in such a
case?

> +		return;

> +	pdev->dev.of_node = NULL;

This will mess up with fwnode, isn't it?


> +	of_changeset_revert(np->data);
> +	of_changeset_destroy(np->data);
> +	of_node_put(np);
> +}

...

> +void of_pci_make_dev_node(struct pci_dev *pdev)
> +{
> +	struct device_node *ppnode, *np = NULL;
> +	const char *pci_type;
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

While not positive conditional?

> +		ppnode = pdev->bus->dev.of_node;
> +	else
> +		ppnode = pdev->bus->self->dev.of_node;

What about firmware nodes?

> +	if (!ppnode)
> +		return;
> +
> +	if (pci_is_bridge(pdev))
> +		pci_type = "pci";
> +	else
> +		pci_type = "dev";
> +
> +	name = kasprintf(GFP_KERNEL, "%s@%x,%x", pci_type,
> +			 PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
> +	if (!name)
> +		return;
> +
> +	cset = kmalloc(sizeof(*cset), GFP_KERNEL);
> +	if (!cset)
> +		goto failed;
> +	of_changeset_init(cset);
> +
> +	np = of_changeset_create_node(ppnode, name, cset);
> +	if (!np)
> +		goto failed;
> +	np->data = cset;
> +
> +	ret = of_pci_add_properties(pdev, cset, np);
> +	if (ret)
> +		goto failed;
> +
> +	ret = of_changeset_apply(cset);
> +	if (ret)
> +		goto failed;
> +
> +	pdev->dev.of_node = np;

Firmware node?

> +	kfree(name);
> +
> +	return;
> +
> +failed:

> +	if (np)

Dup check.

> +		of_node_put(np);
> +	kfree(name);
> +}

...

> +#include <linux/pci.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>

Can it be ordered?

...

> +struct of_pci_addr_pair {
> +	u32		phys_addr[OF_PCI_ADDRESS_CELLS];
> +	u32		size[OF_PCI_SIZE_CELLS];
> +};

Why not

struct foo {
	u32 phys_addr; // why not 64-bit?
	u32 size; // same Q, btw
};

struct _pairs {
	strict foo pairs[...];
}

?

...

> +struct of_pci_range {
> +	u32		child_addr[OF_PCI_ADDRESS_CELLS];
> +	u32		parent_addr[OF_PCI_ADDRESS_CELLS];
> +	u32		size[OF_PCI_SIZE_CELLS];
> +};

In the similar way?

...

> +enum of_pci_prop_compatible {
> +	PROP_COMPAT_PCI_VVVV_DDDD,
> +	PROP_COMPAT_PCICLASS_CCSSPP,
> +	PROP_COMPAT_PCICLASS_CCSS,
> +	PROP_COMPAT_NUM,

No comma for the terminator entry (as far as I got it).

> +};

...

> +static void of_pci_set_address(struct pci_dev *pdev, u32 *prop, u64 addr,
> +			       u32 reg_num, u32 flags, bool reloc)
> +{
> +	prop[0] = FIELD_PREP(OF_PCI_ADDR_FIELD_BUS, pdev->bus->number) |
> +		FIELD_PREP(OF_PCI_ADDR_FIELD_DEV, PCI_SLOT(pdev->devfn)) |
> +		FIELD_PREP(OF_PCI_ADDR_FIELD_FUNC, PCI_FUNC(pdev->devfn));
> +	prop[0] |= flags | reg_num;

No checks? No masks? flags or reg_num may easily / mistakenly rewrite the above.

> +	if (!reloc) {

	if (reloc)
		return;

?

> +		prop[0] |= OF_PCI_ADDR_FIELD_NONRELOC;
> +		prop[1] = upper_32_bits(addr);
> +		prop[2] = lower_32_bits(addr);
> +	}
> +}

...

> +static int of_pci_get_addr_flags(struct resource *res, u32 *flags)
> +{
> +	u32 ss;

> +	if (res->flags & IORESOURCE_IO)
> +		ss = OF_PCI_ADDR_SPACE_IO;
> +	else if (res->flags & IORESOURCE_MEM_64)
> +		ss = OF_PCI_ADDR_SPACE_MEM64;
> +	else if (res->flags & IORESOURCE_MEM)
> +		ss = OF_PCI_ADDR_SPACE_MEM32;
> +	else
> +		return -EINVAL;

We have ioport.h and respective helpers, can you use them?
resource_type(), for example.

> +	*flags = 0;
> +	if (res->flags & IORESOURCE_PREFETCH)
> +		*flags |= OF_PCI_ADDR_FIELD_PREFETCH;
> +
> +	*flags |= FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss);
> +
> +	return 0;
> +}

...

> +static int of_pci_prop_bus_range(struct pci_dev *pdev,
> +				 struct of_changeset *ocs,
> +				 struct device_node *np)
> +{
> +	u32 bus_range[] = { pdev->subordinate->busn_res.start,
> +			    pdev->subordinate->busn_res.end };

Wrong. It won't work on 64-bit resources.

> +	return of_changeset_add_prop_u32_array(ocs, np, "bus-range", bus_range,
> +					       ARRAY_SIZE(bus_range));
> +}

...

> +	if (pci_is_bridge(pdev)) {
> +		num = PCI_BRIDGE_RESOURCE_NUM;
> +		res = &pdev->resource[PCI_BRIDGE_RESOURCES];
> +	} else {
> +		num = PCI_STD_NUM_BARS;
> +		res = &pdev->resource[PCI_STD_RESOURCES];
> +	}

Don't we have pci_resource() macro?

...

> +	for (i = 0, j = 0; j < num; j++) {
> +		if (!resource_size(&res[j]))
> +			continue;
> +
> +		if (of_pci_get_addr_flags(&res[j], &flags))
> +			continue;
> +
> +		val64 = res[j].start;
> +		of_pci_set_address(pdev, rp[i].parent_addr, val64, 0, flags,
> +				   false);
> +		if (pci_is_bridge(pdev)) {

> +			memcpy(rp[i].child_addr, rp[i].parent_addr,
> +			       sizeof(rp[i].child_addr));

Why simple assignment is not good enough here?

> +		} else {
> +			/*
> +			 * For endpoint device, the lower 64-bits of child
> +			 * address is always zero.
> +			 */
> +			rp[i].child_addr[0] = j;
> +		}

> +		val64 = resource_size(&res[j]);

Dup. You already called this at the top of the loop, why to repeat?

> +		rp[i].size[0] = upper_32_bits(val64);
> +		rp[i].size[1] = lower_32_bits(val64);
> +
> +		i++;
> +	}

...

> +static int of_pci_prop_reg(struct pci_dev *pdev, struct of_changeset *ocs,
> +			   struct device_node *np)
> +{
> +	struct of_pci_addr_pair reg = { 0 };

0 is redundant.

> +
> +	/* configuration space */
> +	of_pci_set_address(pdev, reg.phys_addr, 0, 0, 0, true);
> +
> +	return of_changeset_add_prop_u32_array(ocs, np, "reg", (u32 *)&reg,
> +					       sizeof(reg) / sizeof(u32));
> +}

...

> +	ret = pci_read_config_byte(pdev, PCI_INTERRUPT_PIN, &pin);
> +	if (ret != 0)

Why this pattern?

> +		return ret;

Are you aware that above can return positive codes, aren't you?
You probably want to translate them to the Linux error codes
Same applies to all generic PCI config space accessors used in
the code.

> +	if (!pin)
> +		return 0;
> +
> +	return of_changeset_add_prop_u32(ocs, np, "interrupts", (u32)pin);

Why casting?

> +}

-- 
With Best Regards,
Andy Shevchenko


