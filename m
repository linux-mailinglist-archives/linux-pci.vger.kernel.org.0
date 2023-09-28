Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801607B14E0
	for <lists+linux-pci@lfdr.de>; Thu, 28 Sep 2023 09:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjI1HaG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Sep 2023 03:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjI1HaF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2023 03:30:05 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACA391;
        Thu, 28 Sep 2023 00:30:01 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F34240004;
        Thu, 28 Sep 2023 07:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695886200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NhmKTjJkBKMPVPKo3Rq7nMal1Z/uZ+jic+eZj6B9BM0=;
        b=V/gE/Eca0QNVIYB9VsYPzxRkBxWT9DAce7rsyZVTV0/4fSmtalOz1sQVmvL+aD2r23f5RO
        ZxiWrMnkSD3m+hxX8wTc0umopcu1N8kt6k0/pGeONNsxPGpjPzsftP5YbeX2yrMyJ0Bm2q
        3HJXF3C73K39dK2lrAMq0hzUZ805C3cC8HTxzrovea6ZDP5NIUAxbiRF26Xve+8aLvxmEA
        qoZrBDYxr1sVmQXIscGUjYgOiVRiInEcvFD6QuQC5Sbx9MwQ9ZFfMKxdASZm/2DbPD6EqY
        HmlU6Pul1b2ESOuENV6S5ungD1FoDkqkeG88HQwzE0lG7LOBtrCzBQuB64+1Og==
Date:   Thu, 28 Sep 2023 09:29:58 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Jonathan.Cameron@Huawei.com>,
        <bhelgaas@google.com>, <robh@kernel.org>
Subject: Re: [PATCH 2/2] PCI: of_property: Fix uninitialized variable when
 of_irq_parse_raw() failed
Message-ID: <20230928092958.1ac4577e@bootlin.com>
In-Reply-To: <1694801287-17217-2-git-send-email-lizhi.hou@amd.com>
References: <1694801287-17217-1-git-send-email-lizhi.hou@amd.com>
        <1694801287-17217-2-git-send-email-lizhi.hou@amd.com>
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

On Fri, 15 Sep 2023 11:08:07 -0700
Lizhi Hou <lizhi.hou@amd.com> wrote:

> In function of_pci_prop_intr_map(), addr_sz[i] will be uninitialized if
> of_irq_parse_raw() returns failure. Add addr_sz array initialization. And
> when parsing irq failed, skip generating interrupt-map pair for the pin.
> 
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Closes: https://lore.kernel.org/all/20230911154856.000076c3@Huawei.com/
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
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

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
