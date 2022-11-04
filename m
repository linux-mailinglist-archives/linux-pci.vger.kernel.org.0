Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD7B6192E5
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 09:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKDInP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Nov 2022 04:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKDInO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Nov 2022 04:43:14 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9234275F4
        for <linux-pci@vger.kernel.org>; Fri,  4 Nov 2022 01:43:12 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id qsI7ozIjdkifIqsI7oGDyf; Fri, 04 Nov 2022 09:43:10 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 04 Nov 2022 09:43:10 +0100
X-ME-IP: 86.243.100.34
Message-ID: <d2f7deb7-ebe0-d880-1c4b-a210d65c6223@wanadoo.fr>
Date:   Fri, 4 Nov 2022 09:43:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/1] PCI: loongson: skip scanning unavailable child
 device
To:     Liu Peibao <liupeibao@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221104072730.14631-1-liupeibao@loongson.cn>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221104072730.14631-1-liupeibao@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 04/11/2022 à 08:27, Liu Peibao a écrit :
> The PCI Controller of 2k1000 could not mask devices by
> setting vender id or device id in configuration space header
> as invalid values. When there are pins shareble between
> the platform device and PCI device, if the platform device
> is preferred, we should not scan this PCI device. In the
> above scene, add `status = "disabled"` property in DT node
> of this PCI device.
> 
> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> ---
> V1 -> V2: use existing property "status" instead of adding new property.
> 
>   drivers/pci/controller/pci-loongson.c | 57 +++++++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 05c50408f13b..cde8a8691867 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -40,11 +40,21 @@ struct loongson_pci_data {
>   	struct pci_ops *ops;
>   };
>   
> +#ifdef CONFIG_OF
> +struct mask_entry {
> +	struct list_head entry;
> +	unsigned int devfn;
> +};
> +#endif
> +
>   struct loongson_pci {
>   	void __iomem *cfg0_base;
>   	void __iomem *cfg1_base;
>   	struct platform_device *pdev;
>   	const struct loongson_pci_data *data;
> +#ifdef CONFIG_OF
> +	struct list_head masklist;
> +#endif
>   };
>   
>   /* Fixup wrong class code in PCIe bridges */
> @@ -194,6 +204,20 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus,
>   			return NULL;
>   	}
>   
> +#ifdef CONFIG_OF
> +	/* Don't access devices in masklist */
> +	if (pci_is_root_bus(bus)) {
> +		struct list_head *list;
> +		struct mask_entry *entry;
> +
> +		list_for_each(list, &priv->masklist) {
> +			entry = list_entry(list, struct mask_entry, entry);

Hi,

list_for_each_entry() is slighly less verbose.

> +			if (devfn == entry->devfn)
> +				return NULL;
> +		}
> +	}
> +#endif
> +
>   	/* CFG0 can only access standard space */
>   	if (where < PCI_CFG_SPACE_SIZE && priv->cfg0_base)
>   		return cfg0_map(priv, bus, devfn, where);
> @@ -206,6 +230,36 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus,
>   }
>   
>   #ifdef CONFIG_OF
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
> +			entry = devm_kzalloc(dev, sizeof(entry), GFP_KERNEL);

sizeof(*entry)?

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
>   static int loongson_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>   {
> @@ -305,6 +359,9 @@ static int loongson_pci_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> +	if (setup_masklist(priv))
> +		return -ENOMEM;
> +
>   	bridge->sysdata = priv;
>   	bridge->ops = priv->data->ops;
>   	bridge->map_irq = loongson_map_irq;

