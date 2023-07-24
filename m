Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4BC75ED27
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 10:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjGXINa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 04:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjGXINO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 04:13:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069BDE74;
        Mon, 24 Jul 2023 01:13:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDB0260FAB;
        Mon, 24 Jul 2023 08:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6600CC433C7;
        Mon, 24 Jul 2023 08:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690186385;
        bh=sfAxrCE56SHSPnhhJMcYT4mytu7MFMI2WN7dGuQJT3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mMhPqqyK6U3jxcrhAkz9D14oq86hLQIEgmTgfJwWQYY8HmujX1zIl9uZo5RTIE6Tl
         /KL4vPx+AV66fCxZOq004eQ4X6i3Wz8tyzpc9a+/9I5oNQ/VaNuLWutXSaFMgnQf2k
         UagV5b7D9iJc/5JL2Y5B/8L+U7F5msLAcrDoIrLv5eU/B7B7qg0eAeSGU6IeU1hG/t
         LWvlmWwAOtPchNTsDlZJ9q/AjiwqzSBEWQSAKQAd2yhzopYYitzUv0rLlXaYvvwDOt
         +JF/fTcmb0S+izJbRQNKWt/XG1E5RqcFsvsVIeb79VpyoyrHLRI/WtI4BX3sSF85bR
         jgEGZA0A/LtGg==
Date:   Mon, 24 Jul 2023 13:42:50 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        fancer.lancer@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v18 05/20] PCI: dwc: Add outbound MSG TLPs support
Message-ID: <20230724081250.GD6291@thinkpad>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-6-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721074452.65545-6-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 04:44:37PM +0900, Yoshihiro Shimoda wrote:
> Add "code" and "routing" into struct dw_pcie_ob_atu_cfg for sending
> MSG by iATU in the PCIe endpoint mode in near the future.

It's better to specify the exact requirement here "triggering INTx IRQs"
instead of implying.

> PCIE_ATU_INHIBIT_PAYLOAD is set to issue TLP type of Msg instead of
> MsgD. So, this implementation supports the data-less messages only
> for now.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Same comment for patch 4/20 applies here also. With that fixed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++--
>  drivers/pci/controller/dwc/pcie-designware.h | 4 ++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 49b785509576..2d0f816fa0ab 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -498,7 +498,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
>  			      upper_32_bits(atu->pci_addr));
>  
> -	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
> +	val = atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
>  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
>  	    dw_pcie_ver_is_ge(pci, 460A))
>  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> @@ -506,7 +506,12 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>  		val = dw_pcie_enable_ecrc(val);
>  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
>  
> -	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
> +	val = PCIE_ATU_ENABLE;
> +	if (atu->type == PCIE_ATU_TYPE_MSG) {
> +		/* The data-less messages only for now */
> +		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
> +	}
> +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
>  
>  	/*
>  	 * Make sure ATU enable takes effect before any subsequent config
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 85de0d8346fa..c626d21243b0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -147,11 +147,13 @@
>  #define PCIE_ATU_TYPE_IO		0x2
>  #define PCIE_ATU_TYPE_CFG0		0x4
>  #define PCIE_ATU_TYPE_CFG1		0x5
> +#define PCIE_ATU_TYPE_MSG		0x10
>  #define PCIE_ATU_TD			BIT(8)
>  #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
>  #define PCIE_ATU_REGION_CTRL2		0x004
>  #define PCIE_ATU_ENABLE			BIT(31)
>  #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
> +#define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
>  #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
>  #define PCIE_ATU_LOWER_BASE		0x008
>  #define PCIE_ATU_UPPER_BASE		0x00C
> @@ -292,6 +294,8 @@ struct dw_pcie_ob_atu_cfg {
>  	int index;
>  	int type;
>  	u8 func_no;
> +	u8 code;
> +	u8 routing;
>  	u64 cpu_addr;
>  	u64 pci_addr;
>  	u64 size;
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
