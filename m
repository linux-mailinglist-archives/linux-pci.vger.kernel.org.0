Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACC47453BD
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jul 2023 04:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjGCCGO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Jul 2023 22:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGCCGN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Jul 2023 22:06:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AF0E58;
        Sun,  2 Jul 2023 19:05:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83B9A60D2C;
        Mon,  3 Jul 2023 02:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B1BC433C8;
        Mon,  3 Jul 2023 02:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688349933;
        bh=6Vt/sBkrXdrxTQKVsUKGftN2YBxZb9Pi00xquCrBohc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LjCUwi5skzJas/FE30Uw3LTmmxaKFtanu5Q4CdiA49GglOROpD0KWawmPcK/U4jNN
         JS8ST9+me3IWMG5rrqvv0w6A3PRik9TAMkaRw7GNTQiJ+5wDcJjU7CF/9D6BJjIVhH
         ekW8hR0sTSKZ6ZmZD9ru3O7LGE3mDymTQk+K9dOzGl3go/NdZzM85W2cMSzdu0uwJF
         TlPQJtZoiuy0kSOpGr+E5E92Dxx0Cyz+kFt4zPdHBy9Lcm+AUpBb+W6f6bwTTxwoe1
         DGrhyfGMbhZijPjzMC3JOVUdIbIRcCYrty3HlFavgHMT4cmZIdz9QTHsriKTh1x262
         HSfUi7zOdkttw==
Message-ID: <3e49476e-ee18-bfb8-ae1a-3a55a3d13f88@kernel.org>
Date:   Mon, 3 Jul 2023 11:05:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] PCI: rockchip: Use 64-bit mask on MSI 64-bit PCI address
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig.vd.ch
Cc:     Dan Carpenter <dan.carpenter@linaro.org>, stable@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230630131753.1549685-1-rick.wertenbroek@gmail.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230630131753.1549685-1-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/30/23 22:17, Rick Wertenbroek wrote:
> A 32-bit mask was used on the 64-bit PCI address used for mapping MSIs.
> This would result in the upper 32 bits being unintentionally zeroed and
> MSIs getting mapped to incorrect PCI addresses if the address had any
> of the upper bits set.
> 
> Replace 32-bit mask by appropriate 64-bit mask and rename 32-bit mask
> for clarity.
> 
> Fixes: dc73ed0f1b8b ("PCI: rockchip: Fix window mapping and address translation for endpoint")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-pci/8d19e5b7-8fa0-44a4-90e2-9bb06f5eb694@moroto.mountain/
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 12 ++++++------
>  drivers/pci/controller/pcie-rockchip.h    |  6 +++---
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index 0af0e965fb57..313face6a87f 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -354,7 +354,7 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
>  	struct rockchip_pcie *rockchip = &ep->rockchip;
>  	u32 flags, mme, data, data_mask;
>  	u8 msi_count;
> -	u64 pci_addr;
> +	u64 pci_addr, pci_addr_mask = GENMASK(63, 8);

I think you can simplify all this with only the change to the definition of
PCIE_ADDR_MASK macro. Applying a 64 bits mask for low bits to a 32-bits variable
is OK and should not generate any complaints from the compiler.
Also, that "8" in the GENMASK can be replaced by MIN_AXI_ADDR_BITS_PASSED.
So:

#define PCIE_ADDR_MASK	GENMASK(63, MIN_AXI_ADDR_BITS_PASSED)

Would fix everything I think.

If it does not, I would prefer you define a macro for that GENMASK(63, 8) mask
instead of using a variable on stack. That would be more efficient code wise,
removing a memory access.

>  	u32 r;
>  
>  	/* Check MSI enable bit */
> @@ -391,18 +391,18 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
>  				       PCI_MSI_ADDRESS_LO);
>  
>  	/* Set the outbound region if needed. */
> -	if (unlikely(ep->irq_pci_addr != (pci_addr & PCIE_ADDR_MASK) ||
> +	if (unlikely(ep->irq_pci_addr != (pci_addr & pci_addr_mask) ||
>  		     ep->irq_pci_fn != fn)) {
>  		r = rockchip_ob_region(ep->irq_phys_addr);
>  		rockchip_pcie_prog_ep_ob_atu(rockchip, fn, r,
>  					     ep->irq_phys_addr,
> -					     pci_addr & PCIE_ADDR_MASK,
> -					     ~PCIE_ADDR_MASK + 1);
> -		ep->irq_pci_addr = (pci_addr & PCIE_ADDR_MASK);
> +					     pci_addr & pci_addr_mask,
> +					     ~pci_addr_mask + 1);
> +		ep->irq_pci_addr = (pci_addr & pci_addr_mask);
>  		ep->irq_pci_fn = fn;
>  	}
>  
> -	writew(data, ep->irq_cpu_addr + (pci_addr & ~PCIE_ADDR_MASK));
> +	writew(data, ep->irq_cpu_addr + (pci_addr & ~pci_addr_mask));
>  	return 0;
>  }
>  
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index fe0333778fd9..2d7b05f07b7e 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -158,11 +158,11 @@
>  #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
>  #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
>  
> -#define PCIE_ADDR_MASK			0xffffff00
> +#define PCIE_LO_ADDR_MASK		GENMASK(31, 8)
>  #define PCIE_CORE_AXI_CONF_BASE		0xc00000
>  #define PCIE_CORE_OB_REGION_ADDR0	(PCIE_CORE_AXI_CONF_BASE + 0x0)
>  #define   PCIE_CORE_OB_REGION_ADDR0_NUM_BITS	0x3f
> -#define   PCIE_CORE_OB_REGION_ADDR0_LO_ADDR	PCIE_ADDR_MASK
> +#define   PCIE_CORE_OB_REGION_ADDR0_LO_ADDR	PCIE_LO_ADDR_MASK
>  #define PCIE_CORE_OB_REGION_ADDR1	(PCIE_CORE_AXI_CONF_BASE + 0x4)
>  #define PCIE_CORE_OB_REGION_DESC0	(PCIE_CORE_AXI_CONF_BASE + 0x8)
>  #define PCIE_CORE_OB_REGION_DESC1	(PCIE_CORE_AXI_CONF_BASE + 0xc)
> @@ -170,7 +170,7 @@
>  #define PCIE_CORE_AXI_INBOUND_BASE	0xc00800
>  #define PCIE_RP_IB_ADDR0		(PCIE_CORE_AXI_INBOUND_BASE + 0x0)
>  #define   PCIE_CORE_IB_REGION_ADDR0_NUM_BITS	0x3f
> -#define   PCIE_CORE_IB_REGION_ADDR0_LO_ADDR	PCIE_ADDR_MASK
> +#define   PCIE_CORE_IB_REGION_ADDR0_LO_ADDR	PCIE_LO_ADDR_MASK
>  #define PCIE_RP_IB_ADDR1		(PCIE_CORE_AXI_INBOUND_BASE + 0x4)
>  
>  /* Size of one AXI Region (not Region 0) */

-- 
Damien Le Moal
Western Digital Research

