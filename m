Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDE26200E9
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 22:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiKGVTI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 16:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbiKGVSq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 16:18:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A993E09E;
        Mon,  7 Nov 2022 13:15:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0364612FB;
        Mon,  7 Nov 2022 21:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B438AC433D6;
        Mon,  7 Nov 2022 21:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667855727;
        bh=I4oqu/LBW91Hy9RiY77bfpNiDxS7N+HlwjXTr0S9q28=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YEGwKRGm+z9JQWds8LiAQBhmUqgNX5OjzruFT1O1n2DkVMuQbX/4KAMazlHlz+ZPq
         aYDjPOJY8FR1sBE+EhJUEjVjZLLKvuu8GdN1NoWxQfNqMiYKpr8DMP94EGdeTSMioZ
         GZrGFjGnzST48v9nVmSCfhN7Yu2Q6OprCIYMzz03Gv2QqBdz+qjRFvKgUyaZ3QIizF
         2NuyHm8GP046qKFKHQdOkmOorwCT1XqgC07S1U+8IBhZ8ZXx/NcTrJyFbaOelt/Rs0
         oxM/PiBPoMGatII9aXHEx5eX3Fgd3AyrOm4a4yv8Nq+ek9yttH/5l1mrDyLEeXBo0U
         gaqYowsXqT7AQ==
Date:   Mon, 7 Nov 2022 15:15:25 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Liu Peibao <liupeibao@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: loongson: skip scanning unavailable child device
Message-ID: <20221107211525.GA419924@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104105340.20610-1-liupeibao@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Capitalize subject line to match other commits:

  930c6074d7dd ("PCI: loongson: Work around LS7A incorrect Interrupt Pin registers")
  2410e3301fcc ("PCI: loongson: Don't access non-existent devices")
  cd89edda4002 ("PCI: loongson: Add ACPI init support")
  dee449aafd48 ("PCI: loongson: Use generic 8/16/32-bit config ops on LS2K/LS7A")

On Fri, Nov 04, 2022 at 06:53:40PM +0800, Liu Peibao wrote:
> The PCI Controller of 2k1000 could not mask devices by
> setting vender id or device id in configuration space header
> as invalid values. When there are pins shareble between
> the platform device and PCI device, if the platform device
> is preferred, we should not scan this PCI device. In the
> above scene, add `status = "disabled"` property in DT node
> of this PCI device.

Rewrap this to fill 75 columns.

s/id/ID/
s/shareble/shareable/

> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> ---
> V2 -> V3: 1. use list_for_each_entry() for more clearly.
>           2. fix wrong use of sizeof().
> V1 -> V2: use existing property "status" instead of adding new property.
> 
> 
>  drivers/pci/controller/pci-loongson.c | 55 +++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 05c50408f13b..c7dd88eac885 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -40,11 +40,21 @@ struct loongson_pci_data {
>  	struct pci_ops *ops;
>  };
>  
> +#ifdef CONFIG_OF
> +struct mask_entry {
> +	struct list_head entry;
> +	unsigned int devfn;
> +};
> +#endif
> +
>  struct loongson_pci {
>  	void __iomem *cfg0_base;
>  	void __iomem *cfg1_base;
>  	struct platform_device *pdev;
>  	const struct loongson_pci_data *data;
> +#ifdef CONFIG_OF
> +	struct list_head masklist;
> +#endif
>  };
>  
>  /* Fixup wrong class code in PCIe bridges */
> @@ -194,6 +204,18 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus,
>  			return NULL;
>  	}
>  
> +#ifdef CONFIG_OF
> +	/* Don't access devices in masklist */
> +	if (pci_is_root_bus(bus)) {
> +		struct mask_entry *entry;
> +
> +		list_for_each_entry(entry, &priv->masklist, entry) {
> +			if (devfn == entry->devfn)
> +				return NULL;
> +		}
> +	}
> +#endif

I would probably get rid of the masklist and just search for a disabled
property when reading config offset 0 (vendor ID).  That's not a
performance path anyway.  And this seems similar to the
FLAG_DEV_HIDDEN path where you probably don't need to do it for all
controllers.

>  	/* CFG0 can only access standard space */
>  	if (where < PCI_CFG_SPACE_SIZE && priv->cfg0_base)
>  		return cfg0_map(priv, bus, devfn, where);
> @@ -206,6 +228,36 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus,
>  }
>  
>  #ifdef CONFIG_OF
> +static int setup_masklist(struct loongson_pci *priv)
> +{
> +	struct device *dev = &priv->pdev->dev;
> +	struct device_node *dn, *parent = dev->of_node;
> +	struct mask_entry *entry;
> +	int devfn;
> +
> +	INIT_LIST_HEAD(&priv->masklist);
> +
> +	for_each_child_of_node(parent, dn) {
> +		/*
> +		 * if device is not available, add this to masklist
> +		 * to avoid scanning it.
> +		 */
> +		if (!of_device_is_available(dn)) {
> +			devfn = of_pci_get_devfn(dn);
> +			if (devfn < 0)
> +				continue;
> +
> +			entry = devm_kzalloc(dev, sizeof(*entry), GFP_KERNEL);
> +			if (!entry)
> +				return -ENOMEM;
> +
> +			entry->devfn = devfn;
> +			list_add_tail(&entry->entry, &priv->masklist);
> +		}
> +	}
> +
> +	return 0;
> +}
>  
>  static int loongson_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>  {
> @@ -305,6 +357,9 @@ static int loongson_pci_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	if (setup_masklist(priv))
> +		return -ENOMEM;
> +
>  	bridge->sysdata = priv;
>  	bridge->ops = priv->data->ops;
>  	bridge->map_irq = loongson_map_irq;
> -- 
> 2.20.1
> 
