Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED106286B5
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 18:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbiKNRLI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 12:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238131AbiKNRLH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 12:11:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6800930553;
        Mon, 14 Nov 2022 09:11:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB41461313;
        Mon, 14 Nov 2022 17:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79B0C433D7;
        Mon, 14 Nov 2022 17:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668445865;
        bh=zMD3k7kl4ms288ed0Dzk5pz6tGe8UqBdVUVgbgvVQBw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RFGkA6RL7QX14GUUIU/J1uB+IYdkp9EYZJ2aXjMfYQBy1U/L0vq8NsBudAUByvne6
         Q3WooKrcAEbJKztc2bdtnh7AooKJ0ushK1ioQj8ZwNVJrQbN3Do2GvEGrdcEMwriKq
         CAc66jRqs8ZOHAqqjNEXMOkiqFy2gTgtFJXwr38EeAWls4lErI1ndSmTMiWdl6+ImP
         oHCPXris4Lppc7hsYKzv81Ufk39P3+EicAAZ4/FnAkR7vOOLkxZGfGLmlIVnzq/lDL
         NvDc+gq9knDHw4Gcq26vff4ed04CpHstMnO9g6PbmTeEA2jQbo7Ctwnp/JeEt4Iemn
         XGYRc7YntFCZA==
Date:   Mon, 14 Nov 2022 11:11:03 -0600
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
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        wanghongliang <wanghongliang@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5] PCI: loongson: Skip scanning unavailable child devices
Message-ID: <20221114171103.GA917836@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114074346.23008-1-liupeibao@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Liu,

On Mon, Nov 14, 2022 at 03:43:46PM +0800, Liu Peibao wrote:
> The PCI Controller of 2K1000 could not mask devices by setting vender ID or
> device ID in configuration space header as invalid values.

I don't think this 2K1000 information is really relevant.  I
understand that some chipsets might support this, and they might use
that to avoid this issue, but there's no PCI requirement that the
Vendor/Device ID be writable by anything.

> When there are
> pins shareable between the platform device and the on chip PCI device, if

What does "pins shareable between the platform device and the on chip
PCI device" mean?

I assume there's a single device in the hardware, and both the
"platform device" and the PCI device" refer to that single device?

And there's some reason you prefer to use the platform device
interface to enumerate that device?

> the platform device is preferred, we should not scan this PCI device. In
> the above scene, add `status = "disabled"` property in DT node of this PCI
> device.
> 
> Before this patch, to solve the above problem, we treat the on chip PCI
> devices as platform devices with fixed address assigned by the BIOS.

This says "before this patch".  But the rest of the sentence sounds
like what happens *after* this patch.

> When
> there is device not preferred, add the `status = "disabled"` property in DT
> node.

> In kernel, the PCI host bridge only scans slot 9/A/B/C/D/E that are
> bridges.

I guess this has something to do with pdev_may_exist() [1], but why do
you mention it here?  Do you intend to remove pdev_may_exist() and use
this DT mechanism instead?

Bjorn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pci-loongson.c?id=v6.0#n168

> Overall, this looks not much elegant.
> 
> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> ---
> V4 -> V5: make the issue we are facing clear in commit log.
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
> +
>  	/* CFG0 can only access standard space */
>  	if (where < PCI_CFG_SPACE_SIZE && priv->cfg0_base)
>  		return cfg0_map(priv, bus, devfn, where);
> -- 
> 2.20.1
> 
