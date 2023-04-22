Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83726EB8F7
	for <lists+linux-pci@lfdr.de>; Sat, 22 Apr 2023 13:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjDVLvl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Apr 2023 07:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjDVLvh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Apr 2023 07:51:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AF72710;
        Sat, 22 Apr 2023 04:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11DFE618D1;
        Sat, 22 Apr 2023 11:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24E9C433D2;
        Sat, 22 Apr 2023 11:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682164261;
        bh=xIoO3eZDrwDqrFgoJa0RyU+GcZJKbqPExwzMeblx2V0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwqC+EhyZrUTl4DhvzcQkhLy1N9hBvrOIvQMZqcAQHdk9OG0Fgm90mPjafk+CgOnP
         HOXJUXn+NziQFVj3YjI3z7T0/S4Y+Tr2Vxk8wFS57EkqKNDDTpH6EkXid3AAj+lLhK
         vQ1zZl+q5cOV6FuDmmFQCUYs6byqjA1rWaUJ95S6LgPYN3Lw07n8NOrtAxxmYEYUNZ
         5MEUxulul71xfXgc0u9aWDvIzvpxLXs18hQlaILVrL/rnbhKt9PC5QFLIWkGtxYEW1
         ZD8As/QBxM3oKjqfE0NL6Jox500ygXGGs02Tg7duyQ7t6fSaVwUzDX4SFTDol4Juqr
         WBWz+8q0K0MTw==
Date:   Sat, 22 Apr 2023 17:20:53 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        fancer.lancer@gmail.com, lpieralisi@kernel.org, robh+dt@kernel.org,
        kw@linux.com, bhelgaas@google.com, kishon@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v13 11/22] PCI: dwc: Add dw_pcie_link_set_max_width()
Message-ID: <20230422115053.GH4769@thinkpad>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-12-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230418122403.3178462-12-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 09:23:52PM +0900, Yoshihiro Shimoda wrote:
> To improve code readability, add dw_pcie_link_set_max_width().
> The original code writes the PCIE_PORT_LINK_CONTROL register twice
> if the pci->num_lanes is not zero. But, it should avoid to write
> the register twice. So, refactor it.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 65 ++++++++++----------
>  1 file changed, 34 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 69358dc202f0..c76fa78c6468 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -737,6 +737,39 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
>  	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | link_speed);
>  }
>  
> +static void dw_pcie_link_set_max_width(struct dw_pcie *pci, u32 num_lanes)
> +{
> +	u32 val;
> +
> +	/* Set the number of lanes */
> +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> +	val &= ~PORT_LINK_FAST_LINK_MODE;
> +	val |= PORT_LINK_DLL_LINK_EN;
> +
> +	/* Mask LINK_MODE if num_lanes is not zero */
> +	if (num_lanes)
> +		val &= ~PORT_LINK_MODE_MASK;
> +
> +	switch (num_lanes) {
> +	case 1:
> +		val |= PORT_LINK_MODE_1_LANES;
> +		break;
> +	case 2:
> +		val |= PORT_LINK_MODE_2_LANES;
> +		break;
> +	case 4:
> +		val |= PORT_LINK_MODE_4_LANES;
> +		break;
> +	case 8:
> +		val |= PORT_LINK_MODE_8_LANES;
> +		break;
> +	default:
> +		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
> +		return;

Here you are not updating the LINK_CONTROL register. You should break instead of
returning.

> +	}

Newline here.

- Mani

> +	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> +}
> +
>  static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
>  {
>  	u32 val;
> @@ -1040,36 +1073,6 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
>  	}
>  
> -	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> -	val &= ~PORT_LINK_FAST_LINK_MODE;
> -	val |= PORT_LINK_DLL_LINK_EN;
> -	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> -
> -	if (!pci->num_lanes) {
> -		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
> -		return;
> -	}
> -
> -	/* Set the number of lanes */
> -	val &= ~PORT_LINK_MODE_MASK;
> -	switch (pci->num_lanes) {
> -	case 1:
> -		val |= PORT_LINK_MODE_1_LANES;
> -		break;
> -	case 2:
> -		val |= PORT_LINK_MODE_2_LANES;
> -		break;
> -	case 4:
> -		val |= PORT_LINK_MODE_4_LANES;
> -		break;
> -	case 8:
> -		val |= PORT_LINK_MODE_8_LANES;
> -		break;
> -	default:
> -		dev_err(pci->dev, "num-lanes %u: invalid value\n", pci->num_lanes);
> -		return;
> -	}
> -	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> -
> +	dw_pcie_link_set_max_width(pci, pci->num_lanes);
>  	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
>  }
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
