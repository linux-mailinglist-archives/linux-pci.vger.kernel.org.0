Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DC3636C6C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 22:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238414AbiKWVeS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 16:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238411AbiKWVeR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 16:34:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD2DA4163;
        Wed, 23 Nov 2022 13:34:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDEB161F32;
        Wed, 23 Nov 2022 21:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3D8C433D6;
        Wed, 23 Nov 2022 21:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669239255;
        bh=ttMnqx4iEKEd6geGNacCiYRbZj8zxa04+xKggspTI3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pdX0/svkQ/HYg3xS3rH6GcyUNRLwoipJuiIoygPCKDNw+pLtkul/tX757vACpYGtR
         MpvHKe6k1Tb+iT91JVu4FK3toFOR4Az9ePc6k0aa94gQ1+ix+KqTbFDrieh+wK/gJc
         Ppv9XHefhHc3s2gtDMADjnMc7oHB10KYGHKygBkaeflbErUVlML+bbop6qe7ZG8vFX
         Pbu9mvMSPje3BJilqEGydf34aXaSS6QuG2ZDWL0i1b0IT2lvOQS+qHHSu+dByXDIms
         qUILaMekxYgX4AkuAZkZBaZRG+7Kf7m/DpCGsCk58TtYVqOOv7PBP4rIZSJqS5fpgZ
         aylWlicVQFkXQ==
Date:   Wed, 23 Nov 2022 21:34:10 +0000
From:   Conor Dooley <conor@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 3/9] PCI: microchip: Enable event handlers to access
 bridge and ctrl ptrs
Message-ID: <Y36R0jXXx6AwrLub@spud>
References: <20221116135504.258687-1-daire.mcnamara@microchip.com>
 <20221116135504.258687-4-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116135504.258687-4-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hey Daire,

On Wed, Nov 16, 2022 at 01:54:58PM +0000, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> Minor re-organisation so that event handlers can access both a pointer
> to the bridge area of the PCIe rootport and the ctrl area of the PCIe
> rootport.

Perhaps explaining why we would want to access both, when we've not
needed to so far, would be helpful so that this commit message will make
sense in isolation would be nice. The mechanics of the change seem good
to me though:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pci/controller/pcie-microchip-host.c | 31 ++++++++++----------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> index 30153fd1a2b3..a81e6d25e347 100644
> --- a/drivers/pci/controller/pcie-microchip-host.c
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -654,9 +654,10 @@ static inline u32 reg_to_event(u32 reg, struct event_map field)
>  	return (reg & field.reg_mask) ? BIT(field.event_bit) : 0;
>  }
>  
> -static u32 pcie_events(void __iomem *addr)
> +static u32 pcie_events(struct mc_pcie *port)
>  {
> -	u32 reg = readl_relaxed(addr);
> +	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
> +	u32 reg = readl_relaxed(ctrl_base_addr + PCIE_EVENT_INT);
>  	u32 val = 0;
>  	int i;
>  
> @@ -666,9 +667,10 @@ static u32 pcie_events(void __iomem *addr)
>  	return val;
>  }
>  
> -static u32 sec_errors(void __iomem *addr)
> +static u32 sec_errors(struct mc_pcie *port)
>  {
> -	u32 reg = readl_relaxed(addr);
> +	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
> +	u32 reg = readl_relaxed(ctrl_base_addr + SEC_ERROR_INT);
>  	u32 val = 0;
>  	int i;
>  
> @@ -678,9 +680,10 @@ static u32 sec_errors(void __iomem *addr)
>  	return val;
>  }
>  
> -static u32 ded_errors(void __iomem *addr)
> +static u32 ded_errors(struct mc_pcie *port)
>  {
> -	u32 reg = readl_relaxed(addr);
> +	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
> +	u32 reg = readl_relaxed(ctrl_base_addr + DED_ERROR_INT);
>  	u32 val = 0;
>  	int i;
>  
> @@ -690,9 +693,10 @@ static u32 ded_errors(void __iomem *addr)
>  	return val;
>  }
>  
> -static u32 local_events(void __iomem *addr)
> +static u32 local_events(struct mc_pcie *port)
>  {
> -	u32 reg = readl_relaxed(addr);
> +	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> +	u32 reg = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
>  	u32 val = 0;
>  	int i;
>  
> @@ -704,15 +708,12 @@ static u32 local_events(void __iomem *addr)
>  
>  static u32 get_events(struct mc_pcie *port)
>  {
> -	void __iomem *bridge_base_addr =
> -		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> -	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
>  	u32 events = 0;
>  
> -	events |= pcie_events(ctrl_base_addr + PCIE_EVENT_INT);
> -	events |= sec_errors(ctrl_base_addr + SEC_ERROR_INT);
> -	events |= ded_errors(ctrl_base_addr + DED_ERROR_INT);
> -	events |= local_events(bridge_base_addr + ISTATUS_LOCAL);
> +	events |= pcie_events(port);
> +	events |= sec_errors(port);
> +	events |= ded_errors(port);
> +	events |= local_events(port);
>  
>  	return events;
>  }
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
