Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CD460E917
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 21:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiJZTjJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 15:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbiJZTjI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 15:39:08 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB9480BC3;
        Wed, 26 Oct 2022 12:39:06 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id s206so6649777oie.3;
        Wed, 26 Oct 2022 12:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufoNLifu/8j2ACtS3DBPUqi5tqSlwhmjBXaNllVOyFA=;
        b=XRkY2xMVXYNwV/jtykz0nua3gdI9S+pEcZCgsKJptBZNbA8BRlVULAXDKL5GNlnoB/
         /JWahYEx1X5KLuw14veIj7kM4X3I0GHlq/jjhwoHIsbIOGZX04i9i/FfYcUpXrSrPwhC
         +D+MmmwnOO0tULimty2RgNUFLuUu71VGdtSpNbv8fndNqQ1TqhoEebb87xBeM+hgozRt
         wvHIpNXi5lJUFwi6YquAal95y4QKEttoJ/D1cEVicYJJsO/zmNmuxQIE7WHBp9gXFrJC
         iYyzw+EwSNS264qCV0Fw6bH59FtDUbIZhLO7iZK5IaT6+eC4xsd5n7bHvQHRWYYh8q53
         2Diw==
X-Gm-Message-State: ACrzQf38bn7izeCXVnOkBUT92OM3emgDqGog88Gm1cNcCIKNxahFSvKu
        pQff60TCctpTurwROZenOQ==
X-Google-Smtp-Source: AMsMyM6PKPHEoNUgi/IyslltI+QO9kWqw70qsL4YeJBSYUMBVVC7ezM+oyp7JCwlsRS7iQFV0i/xtg==
X-Received: by 2002:a05:6808:1395:b0:359:b4bb:9826 with SMTP id c21-20020a056808139500b00359b4bb9826mr1530886oiw.162.1666813146050;
        Wed, 26 Oct 2022 12:39:06 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eq37-20020a056870a92500b00136c20b1c59sm3524846oab.43.2022.10.26.12.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:39:05 -0700 (PDT)
Received: (nullmailer pid 1043578 invoked by uid 1000);
        Wed, 26 Oct 2022 19:39:07 -0000
Date:   Wed, 26 Oct 2022 14:39:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, frowand.list@gmail.com,
        helgaas@kernel.org, clement.leger@bootlin.com, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        stefano.stabellini@xilinx.com, trix@redhat.com
Subject: Re: [PATCH RFC V2 3/3] PCI: Add basic properties for dynamically
 generated PCI OF node
Message-ID: <20221026193907.GA902790-robh@kernel.org>
References: <1665598440-47410-1-git-send-email-lizhi.hou@amd.com>
 <1665598440-47410-4-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1665598440-47410-4-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 12, 2022 at 11:14:00AM -0700, Lizhi Hou wrote:
> This patch addes 'reg', 'compatible' and 'device_typ' properties for

typo

Please read submitting-patches.rst and what it says about 'This patch'.

> dynamically generated PCI device tree node
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Signed-off-by: Brian Xu <brian.xu@amd.com>
> ---
>  drivers/pci/Makefile      |   1 +
>  drivers/pci/of.c          |  10 ++-
>  drivers/pci/of_property.c | 177 ++++++++++++++++++++++++++++++++++++++

I don't think we need a separate file here and patches 2 and 3 should be 
combined. Patch 2 alone doesn't really make sense.


>  drivers/pci/pci.h         |   3 +-
>  4 files changed, 189 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/pci/of_property.c
> 
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
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 83e042f495a6..00d716589660 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -619,6 +619,7 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>  {
>  	struct device_node *parent, *dt_node;
>  	const char *pci_type = "dev";
> +	struct property *props;
>  	char *full_name;
>  
>  	/*
> @@ -645,10 +646,15 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>  	if (!full_name)
>  		goto failed;
>  
> -	dt_node = of_create_node(parent, full_name, NULL);
> +	props = of_pci_props_create(pdev);
> +	if (!props)
> +		goto failed;
> +
> +	dt_node = of_create_node(parent, full_name, props);
>  	if (!dt_node)
>  		goto failed;
>  
> +	of_pci_props_destroy(props);
>  	kfree(full_name);
>  
>  	pdev->dev.of_node = dt_node;
> @@ -656,6 +662,8 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>  	return;
>  
>  failed:
> +	if (props)
> +		of_pci_props_destroy(props);
>  	kfree(full_name);
>  }
>  #endif
> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> new file mode 100644
> index 000000000000..693a08323aa4
> --- /dev/null
> +++ b/drivers/pci/of_property.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2022, Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/of.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +
> +struct of_pci_prop {
> +	char *name;
> +	int (*prop_val)(struct pci_dev *pdev, void **val, u32 *len);
> +};
> +
> +struct of_pci_addr_pair {
> +	__be32		phys_hi;
> +	__be32		phys_mid;
> +	__be32		phys_lo;
> +	__be32		size_hi;
> +	__be32		size_lo;
> +};
> +
> +#define OF_PCI_ADDR_SPACE_CONFIG	0x0
> +#define OF_PCI_ADDR_SPACE_IO		0x1
> +#define OF_PCI_ADDR_SPACE_MEM32		0x2
> +#define OF_PCI_ADDR_SPACE_MEM64		0x3
> +
> +#define OF_PCI_ADDR_FIELD_SS		GENMASK(25, 24)
> +#define OF_PCI_ADDR_FIELD_PREFETCH	BIT(30)
> +#define OF_PCI_ADDR_FIELD_BUS		GENMASK(23, 16)
> +#define OF_PCI_ADDR_FIELD_DEV		GENMASK(15, 11)
> +#define OF_PCI_ADDR_FIELD_FUNC		GENMASK(10, 8)
> +#define OF_PCI_ADDR_FIELD_REG		GENMASK(7, 0)
> +
> +#define OF_PCI_SIZE_HI			GENMASK_ULL(63, 32)
> +#define OF_PCI_SIZE_LO			GENMASK_ULL(31, 0)
> +
> +#define OF_PCI_PROP_COMPAT_LEN_MAX	256
> +static int of_pci_prop_device_type(struct pci_dev *pdev, void **val, u32 *len)
> +{
> +	if (!pci_is_bridge(pdev))
> +		return 0;
> +
> +	*val = kasprintf(GFP_KERNEL, "pci");
> +	if (!*val)
> +		return -ENOMEM;
> +
> +	*len = strlen(*val) + 1;
> +
> +	return 0;
> +}
> +
> +static int of_pci_prop_reg(struct pci_dev *pdev, void **val, u32 *len)
> +{
> +	struct of_pci_addr_pair *reg;
> +	u32 reg_val, base_addr, ss;
> +	resource_size_t sz;
> +	int i = 1, resno;
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
> +		if (pci_resource_flags(pdev, resno) & IORESOURCE_IO)
> +			ss = OF_PCI_ADDR_SPACE_IO;
> +		else if (pci_resource_flags(pdev, resno) & IORESOURCE_MEM_64)
> +			ss = OF_PCI_ADDR_SPACE_MEM64;
> +		else
> +			ss = OF_PCI_ADDR_SPACE_MEM32;
> +
> +		reg_val &= ~(OF_PCI_ADDR_FIELD_SS | OF_PCI_ADDR_FIELD_PREFETCH |
> +				OF_PCI_ADDR_FIELD_REG);
> +		reg_val |= FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss) |
> +			FIELD_PREP(OF_PCI_ADDR_FIELD_REG, base_addr);
> +		if (pci_resource_flags(pdev, resno) & IORESOURCE_PREFETCH)
> +			reg_val |= OF_PCI_ADDR_FIELD_PREFETCH;
> +		reg[i].phys_hi = cpu_to_be32(reg_val);
> +		reg[i].size_hi = cpu_to_be32(FIELD_GET(OF_PCI_SIZE_HI, sz));
> +		reg[i].size_lo = cpu_to_be32(FIELD_GET(OF_PCI_SIZE_LO, sz));
> +		i++;
> +	}
> +
> +	*val = reg;
> +	*len = i * sizeof(*reg);
> +
> +	return 0;
> +}
> +
> +static int of_pci_prop_compatible(struct pci_dev *pdev, void **val, u32 *len)
> +{
> +	char *compat;
> +
> +	compat = kzalloc(OF_PCI_PROP_COMPAT_LEN_MAX, GFP_KERNEL);

The size here looks pretty arbitrary yet we should be able to calculate 
the worst case.

> +	if (!compat)
> +		return -ENOMEM;
> +
> +	*val = compat;
> +	if (pdev->subsystem_vendor) {
> +		compat += sprintf(compat, "pci%x,%x.%x.%x.%x",
> +				  pdev->vendor, pdev->device,
> +				  pdev->subsystem_vendor,
> +				  pdev->subsystem_device,
> +				  pdev->revision) + 1;
> +		compat += sprintf(compat, "pci%x,%x.%x.%x",
> +				  pdev->vendor, pdev->device,
> +				  pdev->subsystem_vendor,
> +				  pdev->subsystem_device) + 1;
> +		compat += sprintf(compat, "pci%x,%x",
> +				  pdev->subsystem_vendor,
> +				  pdev->subsystem_device) + 1;
> +	}
> +	compat += sprintf(compat, "pci%x,%x.%x",
> +			  pdev->vendor, pdev->device, pdev->revision) + 1;
> +	compat += sprintf(compat, "pci%x,%x", pdev->vendor, pdev->device) + 1;
> +	compat += sprintf(compat, "pciclass,%06x", pdev->class) + 1;
> +	compat += sprintf(compat, "pciclass,%04x", pdev->class >> 8) + 1;

No checking/preventing overrunning the compat buffer?

I don't think we need all these compatible strings. One with VID/PID and 
one with the class should be sufficient. But I'm not sure offhand what 
subsystem_vendor/device device is...

> +
> +	*len = (u32)(compat - (char *)*val);
> +
> +	return 0;
> +}
> +
> +struct of_pci_prop of_pci_props[] = {
> +	{ .name = "device_type", .prop_val = of_pci_prop_device_type },

This only only applies to bridge nodes.

> +	{ .name = "reg", .prop_val = of_pci_prop_reg },
> +	{ .name = "compatible", .prop_val = of_pci_prop_compatible },
> +	{},
> +};
> +
> +struct property *of_pci_props_create(struct pci_dev *pdev)
> +{
> +	struct property *props, *pp;
> +	void *val;
> +	u32 len;
> +	int i;
> +
> +	props = kcalloc(ARRAY_SIZE(of_pci_props), sizeof(*props), GFP_KERNEL);
> +	if (!props)
> +		return NULL;
> +
> +	pp = props;
> +	for (i = 0; of_pci_props[i].name; i++) {
> +		len = 0;
> +		of_pci_props[i].prop_val(pdev, &val, &len);
> +		if (!len)
> +			continue;
> +		props->name = of_pci_props[i].name;
> +		props->value = val;
> +		props->length = len;
> +		props++;

This creates an array of properties and then copies each one, and it 
also exposes the internals of 'struct property' which we want to make 
opaque. Neither of these is great.

I'd rather see the of_changeset API expanded to handle specific types of 
properties. Something like this:

of_changeset_add_prop_string(cset, node, "device_type", "pci");
of_changeset_add_prop_string_array(cset, node, "compatible", compats, cnt);
of_changeset_add_prop_u32_array(cset, node, "reg", reg, cnt);

And perhaps these functions just wrap similar non-changeset functions 
that produce a struct property.

IOW, it should be similar to the of_property_read_* APIs, but to 
set/add rather than get.


You are also missing 'ranges', '#address-cells, and '#size-cells' in 
bridge nodes.

Rob
