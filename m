Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D64E51863A
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 16:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbiECOPm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 10:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbiECOPl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 10:15:41 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A451581B;
        Tue,  3 May 2022 07:12:08 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id y27-20020a4a9c1b000000b0032129651bb0so3113840ooj.2;
        Tue, 03 May 2022 07:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+YF29TZi131w+V+niyw8f+5BrVYB2TL4PkQPvgOxC1c=;
        b=kyjmNVAk+5Plm1ZZ7PK1tWgvYl3lczYhmf44lu0dWmNQN8CK1R08C5aJmn7JyX53vX
         gF+vZrFRPRMsdQkO9PRtqQAqjTdezF7eHbkti2w1N+AxyU0XsKuuPlKRhU/N/dm41ZOC
         srFlJ1Ioqqo/vZ8TiQbdjGh2ks+2vPxfZvboffrEqPLQiy6GPynM1Y/daTjK6EsUg4fw
         lyYpOx8UPbQNJDZ5ywKkEb48Bxg184+aKl70tbqRzYCkqj9vjTKua8XK4XFW6+aW+aoY
         NuFpNQyRHiS8yhkzzOQR87/ezEtn5k1L7nxTnjTF3IInx8St3Rwnd1ivf430WC6edHWQ
         j7/Q==
X-Gm-Message-State: AOAM531UnVipyNF/ECr1Z8wzBZmUE8fHXH3vv7yI3/6KGkO67QyuGp6W
        PHB9ewQpnBlWuYmn8LjD6w==
X-Google-Smtp-Source: ABdhPJxkPagr4DtftAZPsUY7FNqg5juEjTTAW1X5Ft6g2qNU4vcojndBMTr46RVJBtG9EyVK+zpt+A==
X-Received: by 2002:a4a:e8cc:0:b0:35f:6c5:a41a with SMTP id h12-20020a4ae8cc000000b0035f06c5a41amr2262794ooe.74.1651587127814;
        Tue, 03 May 2022 07:12:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f9-20020a0568301c2900b0060603221247sm3981516ote.23.2022.05.03.07.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 07:12:07 -0700 (PDT)
Received: (nullmailer pid 3564454 invoked by uid 1000);
        Tue, 03 May 2022 14:12:06 -0000
Date:   Tue, 3 May 2022 09:12:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
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
Subject: Re: [PATCH 2/3] PCI: of: create DT nodes for PCI devices if they do
 not exists
Message-ID: <YnE4Ni+QUJT/CXV4@robh.at.kernel.org>
References: <20220427094502.456111-1-clement.leger@bootlin.com>
 <20220427094502.456111-3-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220427094502.456111-3-clement.leger@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 27, 2022 at 11:45:01AM +0200, Clément Léger wrote:
> In order to apply overlays to PCI device nodes, the nodes must first
> exist. This commit add support to populate a skeleton tree for PCI bus
> and devices. These nodes can then be used by drivers to apply overlays.
> 

While I implemented this creating the nodes as the PCI devices are 
created, I think probably we're going to want to create the device node 
and any needed parent nodes on demand. Otherwise, just turning on 
CONFIG_OF could break platforms.

One potential issue is that fwnode assumes there is either a DT node or 
ACPI node. With this, we have the potential for both. I'm not sure how 
much that's going to be an issue.

> Co-developed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> ---
>  drivers/pci/of.c | 184 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 184 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index cb2e8351c2cc..f2325708726e 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -16,12 +16,194 @@
>  #include "pci.h"
>  
>  #ifdef CONFIG_PCI
> +static int of_pci_add_property(struct of_changeset *ocs, struct device_node *np,
> +			       const char *name, const void *value, int length)

Nothing really PCI specific about this function.

The kernel support for creating nodes and properties is pretty poor. We 
should improve it with functions like this (in drivers/of/). Maybe the 
changeset part should be separate though. We have some cases of creating 
properties or nodes already, and whatever new APIs we make those 
cases should be able to use them. And if they are converted, then it can 
be merged sooner rather than when all the PCI parts are ready.

> +{
> +	struct property *prop;
> +	int ret = -ENOMEM;
> +
> +	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
> +	if (!prop)
> +		return -ENOMEM;
> +
> +	prop->name = kstrdup(name, GFP_KERNEL);
> +	if (!prop->name)
> +		goto out_err;
> +
> +	if (value) {
> +		prop->value = kmemdup(value, length, GFP_KERNEL);
> +		if (!prop->value)
> +			goto out_err;
> +	} else {
> +		/*
> +		 * Even if the property has no value, it must be set to a
> +		 * non-null value since of_get_property() is used to check
> +		 * some values that might or not have a values (ranges for
> +		 * instance). Moreover, when the node is released, prop->value
> +		 * is kfreed so the memory must come from kmalloc.
> +		 */
> +		prop->value = kmalloc(1, GFP_KERNEL);
> +		if (!prop->value)
> +			goto out_err;
> +	}
> +
> +	of_property_set_flag(prop, OF_DYNAMIC);
> +
> +	prop->length = length;
> +
> +	ret = of_changeset_add_property(ocs, np, prop);
> +	if (!ret)
> +		return 0;
> +
> +out_err:
> +	kfree(prop->value);
> +	kfree(prop->name);
> +	kfree(prop);
> +
> +	return ret;
> +}
> +
> +static struct device_node *of_pci_make_node(void)
> +{

This isn't PCI specific either.

> +	struct device_node *node;
> +
> +	node = kzalloc(sizeof(*node), GFP_KERNEL);
> +	if (!node)
> +		return NULL;
> +
> +	of_node_set_flag(node, OF_DYNAMIC);
> +	of_node_set_flag(node, OF_DETACHED);
> +	of_node_init(node);
> +
> +	return node;
> +}
> +
> +static int of_pci_add_cells_props(struct device_node *node,
> +				  struct of_changeset *cs, int n_addr_cells,
> +				  int n_size_cells)
> +{
> +	__be32 val;
> +	int ret;
> +
> +	ret = of_pci_add_property(cs, node, "ranges", NULL, 0);

The host bridge node is going to need to fill in 'ranges'. Empty ranges 
is not valid when there's a change in number of cells.

The root node also will need "#address-cells" and "#size-cells".
 
> +	if (ret)
> +		return ret;
> +
> +	val = __cpu_to_be32(n_addr_cells);
> +	ret = of_pci_add_property(cs, node, "#address-cells", &val,
> +				  sizeof(__be32));
> +	if (ret)
> +		return ret;
> +
> +	val = __cpu_to_be32(n_size_cells);
> +	return of_pci_add_property(cs, node, "#size-cells", &val,
> +				   sizeof(__be32));
> +}
> +
> +static int of_pci_add_pci_bus_props(struct device_node *node,
> +				    struct of_changeset *cs)
> +{
> +	int ret;
> +
> +	ret = of_pci_add_property(cs, node, "device_type", "pci",
> +				  strlen("pci") + 1);
> +	if (ret)
> +		return ret;
> +
> +	return of_pci_add_cells_props(node, cs, 3, 2);
> +}
> +
> +static void of_pci_make_dev_node(struct pci_dev *dev)
> +{
> +	static struct of_changeset cs;
> +	const char *pci_type = "dev";
> +	struct device_node *node;
> +	__be32 val[5] = {0};
> +	int ret;
> +
> +	node = of_pci_make_node();
> +	if (!node)
> +		return;
> +
> +	node->parent = dev->bus->dev.of_node;
> +	of_changeset_init(&cs);
> +
> +	if (pci_is_bridge(dev)) {
> +		ret = of_pci_add_pci_bus_props(node, &cs);
> +		if (ret)
> +			goto changeset_destroy;
> +		pci_type = "pci";
> +	}
> +
> +	node->full_name = kasprintf(GFP_KERNEL, "%s@%x,%x", pci_type,
> +				    PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
> +
> +	val[0] = __cpu_to_be32(dev->devfn << 8);
> +	val[4] = __cpu_to_be32(SZ_4K);
> +	ret = of_pci_add_property(&cs, node, "reg", val, 5 * sizeof(__be32));
> +	if (ret)
> +		goto changeset_destroy;
> +
> +	ret = of_changeset_attach_node(&cs, node);
> +	if (ret)
> +		goto changeset_destroy;
> +
> +	ret = of_changeset_apply(&cs);
> +	if (ret)
> +		goto changeset_destroy;
> +
> +	dev->dev.of_node = node;
> +
> +	return;
> +
> +changeset_destroy:
> +	of_changeset_destroy(&cs);
> +	kfree(node);
> +}
> +
> +static struct device_node *of_pci_create_root_bus_node(struct pci_bus *bus)
> +{
> +	static struct of_changeset cs;
> +	struct device_node *node;
> +	int ret;
> +
> +	node = of_pci_make_node();
> +	if (!node)
> +		return NULL;
> +
> +	node->full_name = "pci";
> +	node->parent = of_root;
> +
> +	of_changeset_init(&cs);
> +	ret = of_pci_add_pci_bus_props(node, &cs);
> +	if (ret)
> +		goto changeset_destroy;
> +
> +	ret = of_changeset_attach_node(&cs, node);
> +	if (ret)
> +		goto changeset_destroy;
> +
> +	ret = of_changeset_apply(&cs);
> +	if (ret)
> +		goto changeset_destroy;
> +
> +	return node;
> +
> +changeset_destroy:
> +	of_changeset_destroy(&cs);
> +	kfree(node);
> +
> +	return NULL;
> +}
> +
>  void pci_set_of_node(struct pci_dev *dev)
>  {
>  	if (!dev->bus->dev.of_node)
>  		return;
>  	dev->dev.of_node = of_pci_find_child_device(dev->bus->dev.of_node,
>  						    dev->devfn);
> +	if (!dev->dev.of_node)
> +		of_pci_make_dev_node(dev);
>  	if (dev->dev.of_node)
>  		dev->dev.fwnode = &dev->dev.of_node->fwnode;
>  }
> @@ -39,6 +221,8 @@ void pci_set_bus_of_node(struct pci_bus *bus)
>  
>  	if (bus->self == NULL) {
>  		node = pcibios_get_phb_of_node(bus);
> +		if (!node)
> +			node = of_pci_create_root_bus_node(bus);
>  	} else {
>  		node = of_node_get(bus->self->dev.of_node);
>  		if (node && of_property_read_bool(node, "external-facing"))
> -- 
> 2.34.1
> 
> 
