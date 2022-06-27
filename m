Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9AA55D60D
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbiF0Viw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 17:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiF0Viv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 17:38:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD39BA8
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 14:38:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E208B617F0
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 21:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A63DC341C8;
        Mon, 27 Jun 2022 21:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656365929;
        bh=48tZF0M7bMUIqTHQuvIOb/ZFDVvO4hALw5YR2er/1aA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RP1RspgisMZZz88CIzrWmCWCBKR3DAVzV6f92RM5jaZzM/uMnXo/S+MC/unVEmOSq
         2ffFN6g5iqw4zsWv1Va5SXLAZlttbhRT7Y8S9bv6i4pO7XTaH+Y6Lx6+C9DnbhFW1T
         Yzq6ff9mP5HXP79ZSLz6WPEg8bvELoJ+4ySXmcx6w74qveFwzJ0bePEGhEcKW4ZKb1
         rtSeCIDNBCO2fnrHI6Yfeq/ZpLIKcpcWdOaKBbFaWVWxlsiiWzUuuIe3467iC8vUIb
         9IZNVdp39s5ljar+Pe3zg3uG6LIIuKiqax5sWjUaC4/Zb3u4YM2tUf5x3ICsub4Ak6
         aAEExgZi34SYQ==
Date:   Mon, 27 Jun 2022 16:38:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V14 4/7] PCI: loongson: Don't access non-existant devices
Message-ID: <20220627213847.GA1777956@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617074330.12605-5-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 17, 2022 at 03:43:27PM +0800, Huacai Chen wrote:
> On LS2K/LS7A, some non-existant devices don't return 0xffffffff when
> scanning. This is a hardware flaw but we can only avoid it by software
> now.

We should say what *does* happen if we do a config read to a device
that doesn't exit.  Machine check, hang, etc?

> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/pci/controller/pci-loongson.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index a1222fc15454..e22142f75d97 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -134,10 +134,20 @@ static void __iomem *cfg0_map(struct loongson_pci *priv, int bus,
>  	return priv->cfg0_base + addroff;
>  }
>  
> +static bool pdev_is_existant(unsigned char bus, unsigned int device, unsigned int function)
> +{
> +	if ((bus == 0) && (device >= 9 && device <= 20) && (function > 0))
> +		return false;

Why do you test pci_is_root_bus() below and "bus == 0" here?  I think
you intend them both to test the same thing.  If so, I think you
should test for "if (pci_is_root_bus(bus) ..." here.

Generally speaking we only probe for functions > 0 if .0 is marked as
multi-function, so I guess this means 00:09.0 is marked as a
multi-function device, but config reads to 00:09.1 would fail?

> +	return true;

Returning "true" here means "the device *may* exist," not "this device
*does* exist," right?  If so, the function name probably should be
"pdev_may_exist()".

I guess that when we do a config read to a non-root bus device that
doesn't exist, e.g., "01:00.0", that read terminates with an
Unsupported Request error, the config read gets the ~0 data we expect?

> +}
> +
>  static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devfn,
>  			       int where)
>  {
>  	unsigned char busnum = bus->number;
> +	unsigned int device = PCI_SLOT(devfn);
> +	unsigned int function = PCI_FUNC(devfn);
>  	struct loongson_pci *priv = pci_bus_to_loongson_pci(bus);
>  
>  	if (pci_is_root_bus(bus))
> @@ -147,8 +157,13 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
>  	 * Do not read more than one device on the bus other than
>  	 * the host bus.
>  	 */
> -	if (priv->data->flags & FLAG_DEV_FIX &&
> -			!pci_is_root_bus(bus) && PCI_SLOT(devfn) > 0)
> +	if ((priv->data->flags & FLAG_DEV_FIX) && bus->self) {
> +		if (!pci_is_root_bus(bus) && (device > 0))
> +			return NULL;
> +	}
> +
> +	/* Don't access non-existant devices */
> +	if (!pdev_is_existant(busnum, device, function))
>  		return NULL;

Is this a "forever" hardware bug that will never be fixed, or should
there be a flag like FLAG_DEV_FIX so we only do this on the broken
devices?

>  	/* CFG0 can only access standard space */
> -- 
> 2.27.0
> 
