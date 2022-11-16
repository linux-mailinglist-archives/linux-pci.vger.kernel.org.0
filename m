Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB5C62C250
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 16:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbiKPPUa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 10:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiKPPTw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 10:19:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DAB5289C;
        Wed, 16 Nov 2022 07:19:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C023DB81DBA;
        Wed, 16 Nov 2022 15:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83D0C433C1;
        Wed, 16 Nov 2022 15:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668611988;
        bh=lqmI8EdUh2H0o0VABEygiFBMe3KsYR9v64AOL7Is7Dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7jIYwWIlBlxBCL6G3scI/5BVg4tzIbThr4qXSItYpTx99xvJ7x0NWi59cr3t6/81
         7/QhBJ8SC7zhcwLB8N9Y6ag78d8DxTNTHkNL7FSXoz14JTeO9ngLvBQkVnx+JLtVQl
         hcF/U93KSkA5Ic5pMGxNKnwnJ8ozxURCBqepygR539gFXdN81Jyf1IxGUXlXOkaruj
         /SWLYhdRnfLM16UJYmra1IUtgVmJasbfKjemoh6C6LY1JYupH9E9z4daswz6wUp2zh
         an8Qdujmu9x9nqjISnjLjIfyYcYdy/LnQ0NIscAdsqhGH/8WHy6v7Rj/wZZl0ueFfZ
         bC8bs3n/hB5Kw==
Date:   Wed, 16 Nov 2022 15:19:43 +0000
From:   Conor Dooley <conor@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 2/9] PCI: microchip: Correct the DED and SEC interrupt
 bit offsets
Message-ID: <Y3T/j4P6SERh5O4j@spud>
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
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Hey Daire,
I assume my SoB here is a hang over from me applying to our tree?
It'll need dropping for whenever you send a v2, sorry for not noticing
when you sent it to me before sending here.
Conor.

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
