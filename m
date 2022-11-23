Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC47636C5F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 22:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbiKWV2P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 16:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbiKWV2O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 16:28:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEC66DCD4;
        Wed, 23 Nov 2022 13:28:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9B2161F30;
        Wed, 23 Nov 2022 21:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B049C433D6;
        Wed, 23 Nov 2022 21:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669238891;
        bh=aXYuVL56OUqCkmkuBtTiGlD0vJDEW1H10E3zF/4GBnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eW3PAD8vvRz1vpgKL+baw0/U0ISwR6jtuzN+bRUUr9GPUE1B0IWowOl8cxG7mepPB
         08vsCMWuB8+O8SZ7V0zIen0I33ZSENkSPUVTcCFzq+3wrF5lw7QdSqGzBuT6WsL/Y4
         5hNlXuj2d16Tf8qofl8IiKG/2pUCLKof4ysE843L+L8rQDrrOApsR97vgow+BQGdZV
         G/ooHLf7diRnXDH0HpBelkbXWRqAY/+1x1oeAXStfh7eUYubBwtspSd/LE1iLf4Ndj
         CFW9Z2S/WLvA+klxhEESdD4TzRSKx2bMMI8LlWsj7RB9U5emK2968/fIJXSlD4mIfD
         fZV1oN0wRC7IQ==
Date:   Wed, 23 Nov 2022 21:28:06 +0000
From:   Conor Dooley <conor@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 2/9] PCI: microchip: Correct the DED and SEC interrupt
 bit offsets
Message-ID: <Y36QZt1bsfsroIjM@spud>
References: <20221116135504.258687-1-daire.mcnamara@microchip.com>
 <20221116135504.258687-3-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116135504.258687-3-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 01:54:57PM +0000, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> The SEC and DED interrupt bits were the wrong way round so the SEC
> interrupt handler attempted to mask, unmask, and clear the DED interrupt
> and vice versa. Correct the bit offsets so each interrupt handler
> operates properly.

Firstly, does this need a fixes tag for backporting?
If it does, then you should probably put this as patch #1 in the series.


> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pci/controller/pcie-microchip-host.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> index 80e7554722ca..30153fd1a2b3 100644
> --- a/drivers/pci/controller/pcie-microchip-host.c
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -165,12 +165,12 @@
>  #define EVENT_PCIE_DLUP_EXIT			2
>  #define EVENT_SEC_TX_RAM_SEC_ERR		3
>  #define EVENT_SEC_RX_RAM_SEC_ERR		4
> -#define EVENT_SEC_AXI2PCIE_RAM_SEC_ERR		5
> -#define EVENT_SEC_PCIE2AXI_RAM_SEC_ERR		6
> +#define EVENT_SEC_PCIE2AXI_RAM_SEC_ERR		5
> +#define EVENT_SEC_AXI2PCIE_RAM_SEC_ERR		6

The order in the registers is:
TX_RAM, RX_RAM, PCIE2AXI_RAM, AXI2PCIE_RAM
Fix looks correct to me on that basis:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

>  #define EVENT_DED_TX_RAM_DED_ERR		7
>  #define EVENT_DED_RX_RAM_DED_ERR		8
> -#define EVENT_DED_AXI2PCIE_RAM_DED_ERR		9
> -#define EVENT_DED_PCIE2AXI_RAM_DED_ERR		10
> +#define EVENT_DED_PCIE2AXI_RAM_DED_ERR		9
> +#define EVENT_DED_AXI2PCIE_RAM_DED_ERR		10
>  #define EVENT_LOCAL_DMA_END_ENGINE_0		11
>  #define EVENT_LOCAL_DMA_END_ENGINE_1		12
>  #define EVENT_LOCAL_DMA_ERROR_ENGINE_0		13
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
