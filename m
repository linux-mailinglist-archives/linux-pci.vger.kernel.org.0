Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC4E5399F4
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 01:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348627AbiEaXOO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 19:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244731AbiEaXON (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 19:14:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852818FFB0
        for <linux-pci@vger.kernel.org>; Tue, 31 May 2022 16:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01C20B8172B
        for <linux-pci@vger.kernel.org>; Tue, 31 May 2022 23:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463FFC385A9;
        Tue, 31 May 2022 23:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654038849;
        bh=kJXIsmBcD6yGK5D/mN4CoGDt1HVG4C9Ak3qVgH8bL2c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kM2RTQWUvQot77x8WsBMIdxJ2WnDqmI9d0HxgeUIIh1zOv4YDJpmDBleFwqpzN1GU
         0fWVpSCrhoSL5/VhYuJA7asRFF4vyhLnOyYOQa2VBnNkas1iQT0bZ4zCCl5Y/CR5vr
         kAUtzhBm0DhABO1n+nycWFVtdgpo8Ut+GqOgH8Ra3lyLJ46z7XoY/6Ll2Dg0XJMz29
         HZ440njYtooQBbzxz6loqzmycS9XxzH+WFO2OkVEPzctM9SJwOPS4LxAbtP24VcPGE
         SunppljsB9J5+7cyT1m7UOYiw5tU8f1WlRp+PFL6VeVk4YbF5EFXHn2859S5DAfNuQ
         PKnhVJ88jJkOQ==
Date:   Tue, 31 May 2022 18:14:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V13 3/6] PCI: loongson: Don't access unexisting devices
Message-ID: <20220531231407.GA795410@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430084846.3127041-4-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 30, 2022 at 04:48:43PM +0800, Huacai Chen wrote:
> On LS2K/LS7A, some unexisting devices don't return 0xffffffff when
> scanning. This is a hardware flaw but we can only avoid it by software
> now.

s/unexisting/non-existant/ (many occurrences: subject line, commit
log, comments below)

What happens in other situations that normally cause Unsupported
Request or similar errors?  For example, memory reads/writes to a
device in D3hot should cause an Unsupported Request error.  I'm
wondering whether other error handling assumptions might be broken
on LS2K/LS7A.

> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/pci/controller/pci-loongson.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index adbfa4a2330f..48316daa1f23 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -138,6 +138,8 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
>  			       int where)
>  {
>  	unsigned char busnum = bus->number;
> +	unsigned int device = PCI_SLOT(devfn);
> +	unsigned int function = PCI_FUNC(devfn);
>  	struct loongson_pci *priv = pci_bus_to_loongson_pci(bus);
>  
>  	if (pci_is_root_bus(bus))
> @@ -147,8 +149,13 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
>  	 * Do not read more than one device on the bus other than
>  	 * the host bus. For our hardware the root bus is always bus 0.
>  	 */
> -	if (priv->data->flags & FLAG_DEV_FIX &&
> -			!pci_is_root_bus(bus) && PCI_SLOT(devfn) > 0)
> +	if ((priv->data->flags & FLAG_DEV_FIX) && bus->self) {
> +		if (!pci_is_root_bus(bus) && (device > 0))
> +			return NULL;
> +	}
> +
> +	/* Don't access unexisting devices */
> +	if (pci_is_root_bus(bus) && (device >= 9 && device <= 20 && function > 0))

Yuck.  This is pretty nasty magic.  If this is something that might be
fixed in future versions of the hardware, maybe you should factor this
out into a function pointer in loongson_pci_data or something.

>  		return NULL;
>  
>  	/* CFG0 can only access standard space */
> -- 
> 2.27.0
> 
