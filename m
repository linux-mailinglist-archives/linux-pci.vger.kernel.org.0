Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798526EB8E1
	for <lists+linux-pci@lfdr.de>; Sat, 22 Apr 2023 13:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjDVLpR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Apr 2023 07:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDVLpO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Apr 2023 07:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F4A1FE3;
        Sat, 22 Apr 2023 04:45:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A3C161276;
        Sat, 22 Apr 2023 11:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C05C433EF;
        Sat, 22 Apr 2023 11:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682163911;
        bh=qTWBe8fqFQ9EuHhRLsT8uuOS+MFBNIxtY4I3edGoZDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBfeqJn7W9AqdtuvdR2bN6WkLAlEqYaxW9IiZumckt3ht9auktyB5WJF5rjgGZFyS
         EPNq2U7JXJ5doYo6Cp2QNUGdcKR+y2gDN75WgOLcx3HJ8cpSiN3JNTx6xpQkkZqeRh
         aXS2IKA7UhrUx7LR8/YHwZcQjrivLVL9KOLpxgfIO2166x5EXkGIYwPEzdRrxeMkI9
         nUeh0RbkBxMbRvu7odzo3c2l/t/zAQvQGHurUpBJwGa9HQAt3xTxLuCfOrkOeG6HDa
         13Dc/oE2v5gmgGTvLde6G/14VHgLU2lZ/SWfMESkCp3ds4C3tKh9IOdtjAofxwFGbO
         TPF04x+g/pIKw==
Date:   Sat, 22 Apr 2023 17:15:04 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        fancer.lancer@gmail.com, lpieralisi@kernel.org, robh+dt@kernel.org,
        kw@linux.com, bhelgaas@google.com, kishon@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v13 10/22] PCI: dwc: Add dw_pcie_link_set_max_link_width()
Message-ID: <20230422114504.GG4769@thinkpad>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-11-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230418122403.3178462-11-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 09:23:51PM +0900, Yoshihiro Shimoda wrote:
> To improve code readability, add dw_pcie_link_set_max_link_width().
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 46 ++++++++++++--------
>  1 file changed, 28 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index e8d4d5bde2d3..69358dc202f0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -737,6 +737,33 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
>  	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | link_speed);
>  }
>  
> +static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
> +{
> +	u32 val;
> +
> +	if (!num_lanes)
> +		return;
> +
> +	/* Set link width speed control register */
> +	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> +	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
> +	switch (num_lanes) {
> +	case 1:
> +		val |= PORT_LOGIC_LINK_WIDTH_1_LANES;
> +		break;
> +	case 2:
> +		val |= PORT_LOGIC_LINK_WIDTH_2_LANES;
> +		break;
> +	case 4:
> +		val |= PORT_LOGIC_LINK_WIDTH_4_LANES;
> +		break;
> +	case 8:
> +		val |= PORT_LOGIC_LINK_WIDTH_8_LANES;
> +		break;
> +	}
> +	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> +}
> +
>  void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  {
>  	int max_region, ob, ib;
> @@ -1044,22 +1071,5 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  	}
>  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
>  
> -	/* Set link width speed control register */
> -	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> -	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
> -	switch (pci->num_lanes) {
> -	case 1:
> -		val |= PORT_LOGIC_LINK_WIDTH_1_LANES;
> -		break;
> -	case 2:
> -		val |= PORT_LOGIC_LINK_WIDTH_2_LANES;
> -		break;
> -	case 4:
> -		val |= PORT_LOGIC_LINK_WIDTH_4_LANES;
> -		break;
> -	case 8:
> -		val |= PORT_LOGIC_LINK_WIDTH_8_LANES;
> -		break;
> -	}
> -	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> +	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
>  }
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
