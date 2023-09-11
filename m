Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE2879B31E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 01:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350433AbjIKViX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241777AbjIKPOW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 11:14:22 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9B5FA;
        Mon, 11 Sep 2023 08:14:16 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6E69BC0025;
        Mon, 11 Sep 2023 15:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694445255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ojuPiNmXmCazeh3wr8WutwjTo9jG8jJh57glhlUbxKQ=;
        b=IjcYBOellcOfTpijLCpK9WnTM4/S/aHyvMuAt5a98uJnhkxBmZKIURIgO3VH/+TVpKUVf2
        aG+r9ONNUgm0rHj8yq6enm0iDDgY7XptJJipf55c1DMLRXAKUjwPa+QVs87DmPJHVL2K/m
        7Wu0kxenpt3iwns8cXXXFRSxcxoHCSdozRAE1ddfnLZone36fnaQUhOPIL8h4g8sTgDrMi
        J5/RQinVOdc3JHbQDIlFv8bWneJfngxF6pk6Y6YWiOBCrFNQeIPlldLSgmo+hyHu2TvCPQ
        XWWAJyKyrx+9XCOhC3y6VaPdoPSK7MWUWFCYv6COmBp6ITiS5UNbvwXWPZSljw==
Date:   Mon, 11 Sep 2023 17:13:19 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>,
        <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH V13 2/5] PCI: Create device tree node for bridge
Message-ID: <20230911171319.495bb837@bootlin.com>
In-Reply-To: <1692120000-46900-3-git-send-email-lizhi.hou@amd.com>
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
        <1692120000-46900-3-git-send-email-lizhi.hou@amd.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lizhi,

On Tue, 15 Aug 2023 10:19:57 -0700
Lizhi Hou <lizhi.hou@amd.com> wrote:
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
> +		ppnode = pdev->bus->dev.of_node;
> +	else
> +		ppnode = pdev->bus->self->dev.of_node;
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

The "goto failed" will leak the cset previously allocated.

np->data = cset; (next line) allows to free the cset when the node is destroyed
(of_node_put() calls). When the node cannot be created, the allocated cset should
be freed.

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
> +	kfree(name);
> +
> +	return;
> +
> +failed:
> +	if (np)
> +		of_node_put(np);
> +	kfree(name);
> +}
> +#endif
> +
>  #endif /* CONFIG_PCI */
>  
...
> +static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
> +				struct device_node *np)
> +{
> +	struct of_phandle_args out_irq[OF_PCI_MAX_INT_PIN];
> +	u32 i, addr_sz[OF_PCI_MAX_INT_PIN], map_sz = 0;
> +	__be32 laddr[OF_PCI_ADDRESS_CELLS] = { 0 };
> +	u32 int_map_mask[] = { 0xffff00, 0, 0, 7 };
> +	struct device_node *pnode;
> +	struct pci_dev *child;
> +	u32 *int_map, *mapp;
> +	int ret;
> +	u8 pin;
> +
> +	pnode = pci_device_to_OF_node(pdev->bus->self);
> +	if (!pnode)
> +		pnode = pci_bus_to_OF_node(pdev->bus);
> +
> +	if (!pnode) {
> +		pci_err(pdev, "failed to get parent device node");
> +		return -EINVAL;
> +	}
> +
> +	laddr[0] = cpu_to_be32((pdev->bus->number << 16) | (pdev->devfn << 8));
> +	for (pin = 1; pin <= OF_PCI_MAX_INT_PIN;  pin++) {
> +		i = pin - 1;
> +		out_irq[i].np = pnode;
> +		out_irq[i].args_count = 1;
> +		out_irq[i].args[0] = pin;
> +		ret = of_irq_parse_raw(laddr, &out_irq[i]);
> +		if (ret) {
> +			pci_err(pdev, "parse irq %d failed, ret %d", pin, ret);
> +			continue;
> +		}
> +		ret = of_property_read_u32(out_irq[i].np, "#address-cells",
> +					   &addr_sz[i]);
> +		if (ret)
> +			addr_sz[i] = 0;
> +	}

if of_irq_parse_raw() fails, addr_sz[i] is not initialized and map_sz bellow is
computed with uninitialized values.
On the test I did, this lead to a kernel crash due to the following kcalloc()
called with incorrect values.

Are interrupt-map and interrupt-map-mask properties needed in all cases ?
I mean are they mandatory for the host pci bridge ?

> +
> +	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
> +		for (pin = 1; pin <= OF_PCI_MAX_INT_PIN; pin++) {
> +			i = pci_swizzle_interrupt_pin(child, pin) - 1;
> +			map_sz += 5 + addr_sz[i] + out_irq[i].args_count;

of_irq_parse_raw() can fail on some pins.
Is it correct to set map_sz based on information related to all pins even if
of_irq_parse_raw() previously failed on some pins ?

> +		}
> +	}
> +
> +	int_map = kcalloc(map_sz, sizeof(u32), GFP_KERNEL);
> +	mapp = int_map;
> +
> +	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
> +		for (pin = 1; pin <= OF_PCI_MAX_INT_PIN; pin++) {
> +			*mapp = (child->bus->number << 16) |
> +				(child->devfn << 8);
> +			mapp += OF_PCI_ADDRESS_CELLS;
> +			*mapp = pin;
> +			mapp++;
> +			i = pci_swizzle_interrupt_pin(child, pin) - 1;
> +			*mapp = out_irq[i].np->phandle;
> +			mapp++;
> +			if (addr_sz[i]) {
> +				ret = of_property_read_u32_array(out_irq[i].np,
> +								 "reg", mapp,
> +								 addr_sz[i]);
> +				if (ret)
> +					goto failed;
> +			}
> +			mapp += addr_sz[i];
> +			memcpy(mapp, out_irq[i].args,
> +			       out_irq[i].args_count * sizeof(u32));
> +			mapp += out_irq[i].args_count;
> +		}
> +	}
> +
> +	ret = of_changeset_add_prop_u32_array(ocs, np, "interrupt-map", int_map,
> +					      map_sz);
> +	if (ret)
> +		goto failed;
> +
> +	ret = of_changeset_add_prop_u32(ocs, np, "#interrupt-cells", 1);
> +	if (ret)
> +		goto failed;
> +
> +	ret = of_changeset_add_prop_u32_array(ocs, np, "interrupt-map-mask",
> +					      int_map_mask,
> +					      ARRAY_SIZE(int_map_mask));
> +	if (ret)
> +		goto failed;
> +
> +	kfree(int_map);
> +	return 0;
> +
> +failed:
> +	kfree(int_map);
> +	return ret;
> +}
> +
...

Regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
