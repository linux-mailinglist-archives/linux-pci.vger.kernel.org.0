Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697097B3CA3
	for <lists+linux-pci@lfdr.de>; Sat, 30 Sep 2023 00:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjI2Wg7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 18:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Wg6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 18:36:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332E71A5;
        Fri, 29 Sep 2023 15:36:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C74C433C7;
        Fri, 29 Sep 2023 22:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696027015;
        bh=yBXOI57T2QqpCcsEjko2gn/7Hd9X43YQwa23OuNuYNw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RlBKb1CZ+AVisia/JOb+8xQ9EQHWWD4A2gjiHDS5hwF14sc3xMsMjUV8o3POB00uS
         lRHK65xuGMPVRt2PAqWRMrLF8aZMptYiL/wjRgkeaMU9rN9UT3SVFFr1DTrXt2HI8B
         FcL03wY6+OCDjZcesEKhN71q3hXe+R+yH7KQ7C5EwCahmqLxtgLqfKOEnupZQUpfzU
         PwiBlTWFAuhklDQeHjqTKaGsIqg8l86XoG5Vy3KKVylud59N8dT7PWQ0gHyJhgwy1U
         EY0b65y6x147Ht8VuQLm2Ywf9isGofyfbPwGpRz5LS7ZGwtYVI+T9TLFHNETbfGvxn
         mqr4VdNGVkHCQ==
Date:   Fri, 29 Sep 2023 17:36:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, herve.codina@bootlin.com,
        Jonathan.Cameron@huawei.com, bhelgaas@google.com, robh@kernel.org
Subject: Re: [PATCH v3] PCI: of_property: Fix uninitialized variable when
 of_irq_parse_raw() failed
Message-ID: <20230929223653.GA558638@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696007448-42127-1-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 29, 2023 at 10:10:48AM -0700, Lizhi Hou wrote:
> In function of_pci_prop_intr_map(), addr_sz[i] will be uninitialized if
> of_irq_parse_raw() returns failure. Add addr_sz array initialization. And
> when parsing irq failed, skip generating interrupt-map pair for the pin.
> 
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Closes: https://lore.kernel.org/all/20230911154856.000076c3@Huawei.com/
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Applied to for-linus for v6.6, since 407d1a51921e appeared in
v6.6-rc1.

I added Herve's Reported-by since he reported this as well as the cset
leak at https://lore.kernel.org/all/20230911171319.495bb837@bootlin.com/

> ---
>  drivers/pci/of_property.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index 710ec35ba4a1..c2c7334152bc 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c
> @@ -186,8 +186,8 @@ static int of_pci_prop_interrupts(struct pci_dev *pdev,
>  static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
>  				struct device_node *np)
>  {
> +	u32 i, addr_sz[OF_PCI_MAX_INT_PIN] = { 0 }, map_sz = 0;
>  	struct of_phandle_args out_irq[OF_PCI_MAX_INT_PIN];
> -	u32 i, addr_sz[OF_PCI_MAX_INT_PIN], map_sz = 0;
>  	__be32 laddr[OF_PCI_ADDRESS_CELLS] = { 0 };
>  	u32 int_map_mask[] = { 0xffff00, 0, 0, 7 };
>  	struct device_node *pnode;
> @@ -213,33 +213,44 @@ static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
>  		out_irq[i].args[0] = pin;
>  		ret = of_irq_parse_raw(laddr, &out_irq[i]);
>  		if (ret) {
> -			pci_err(pdev, "parse irq %d failed, ret %d", pin, ret);
> +			out_irq[i].np = NULL;
> +			pci_dbg(pdev, "parse irq %d failed, ret %d", pin, ret);
>  			continue;
>  		}
> -		ret = of_property_read_u32(out_irq[i].np, "#address-cells",
> -					   &addr_sz[i]);
> -		if (ret)
> -			addr_sz[i] = 0;
> +		of_property_read_u32(out_irq[i].np, "#address-cells",
> +				     &addr_sz[i]);
>  	}
>  
>  	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
>  		for (pin = 1; pin <= OF_PCI_MAX_INT_PIN; pin++) {
>  			i = pci_swizzle_interrupt_pin(child, pin) - 1;
> +			if (!out_irq[i].np)
> +				continue;
>  			map_sz += 5 + addr_sz[i] + out_irq[i].args_count;
>  		}
>  	}
>  
> +	/*
> +	 * Parsing interrupt failed for all pins. In this case, it does not
> +	 * need to generate interrupt-map property.
> +	 */
> +	if (!map_sz)
> +		return 0;
> +
>  	int_map = kcalloc(map_sz, sizeof(u32), GFP_KERNEL);
>  	mapp = int_map;
>  
>  	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
>  		for (pin = 1; pin <= OF_PCI_MAX_INT_PIN; pin++) {
> +			i = pci_swizzle_interrupt_pin(child, pin) - 1;
> +			if (!out_irq[i].np)
> +				continue;
> +
>  			*mapp = (child->bus->number << 16) |
>  				(child->devfn << 8);
>  			mapp += OF_PCI_ADDRESS_CELLS;
>  			*mapp = pin;
>  			mapp++;
> -			i = pci_swizzle_interrupt_pin(child, pin) - 1;
>  			*mapp = out_irq[i].np->phandle;
>  			mapp++;
>  			if (addr_sz[i]) {
> -- 
> 2.34.1
> 
