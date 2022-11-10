Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3165624C91
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 22:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbiKJVHp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 16:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbiKJVHh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 16:07:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6872258BD6;
        Thu, 10 Nov 2022 13:07:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1134B8238E;
        Thu, 10 Nov 2022 21:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E41C433C1;
        Thu, 10 Nov 2022 21:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668114453;
        bh=9J/8mtPefAQqogh4jFlbGu4+fqQ9vN2bfV5hD1uWbrI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZWu+EBIa70QL4S8G0ObyISCrLNZ0uU2/EmFiyH5ZJv4RsNowDJ7nogF6AphwUiSPy
         madpFJ0j6Pl83dzdkBcyB6rPKS1MfeUytJaSrA+0ba8o0On0bVyDrq5HK5UB9r6vrC
         c3NGAGSqgOpw59O+lsYebPWLj0Dvluoe1wXxzjOk0O4SJ6NTld+GIztG62bvXQ5sCz
         qtIM4Vw9KVpUkcFe5vdLGRwPSU2wpIBWII7ZxZELKelwdbpUa+oe63tY54ORtOlUjP
         F4Mz0vK4t9DegeViF+JS6PHMFSaSN1kz1rIuMAlzPJiE5aIf9T4VSxh9SGuEPeIH2d
         Q91vXEvBMEjVA==
Date:   Thu, 10 Nov 2022 15:07:31 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Liu Peibao <liupeibao@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] PCI: loongson: Skip scanning unavailable child devices
Message-ID: <20221110210731.GA672063@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108064240.8030-1-liupeibao@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 08, 2022 at 02:42:40PM +0800, Liu Peibao wrote:
> The PCI Controller of 2k1000 could not mask devices by setting vender ID or
> device ID in configuration space header as invalid values. When there are
> pins shareable between the platform device and PCI device, if the platform
> device is preferred, we should not scan this PCI device. In the above
> scene, add `status = "disabled"` property in DT node of this PCI device.
> 
> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> ---
> V3 -> V4: 1. get rid of the masklist and search the status property
> 	  directly.
>           2. check the status property only when accessing the vendor ID.
> V2 -> V3: 1. use list_for_each_entry() for more clearly.
>           2. fix wrong use of sizeof().
> V1 -> V2: use existing property "status" instead of adding new property.
> 
>  drivers/pci/controller/pci-loongson.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 05c50408f13b..efca0b3b5a29 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -194,6 +194,17 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus,
>  			return NULL;
>  	}
>  
> +#ifdef CONFIG_OF
> +	/* Don't access disabled devices. */
> +	if (pci_is_root_bus(bus) && where == PCI_VENDOR_ID) {
> +		struct device_node *dn;
> +
> +		dn = of_pci_find_child_device(bus->dev.of_node, devfn);
> +		if (dn && !of_device_is_available(dn))
> +			return NULL;
> +	}
> +#endif

Looks nice and simple, thanks for trying this out.

>  	/* CFG0 can only access standard space */
>  	if (where < PCI_CFG_SPACE_SIZE && priv->cfg0_base)
>  		return cfg0_map(priv, bus, devfn, where);
> -- 
> 2.20.1
> 
