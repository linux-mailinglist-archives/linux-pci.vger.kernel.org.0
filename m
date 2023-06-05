Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039E67223E5
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 12:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjFEKxb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 06:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjFEKxa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 06:53:30 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBF0EA;
        Mon,  5 Jun 2023 03:53:26 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b1b06af50eso36839151fa.1;
        Mon, 05 Jun 2023 03:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685962405; x=1688554405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KSRoaU6MsSHM4EqamjXT1zsk+53BlQcjMgqZZmifUn8=;
        b=A77Xz69YxUGaRkiX8/O1yS6+dnwZXYLCwxSDVON2hVBi70jCDooSqDpt116UC+IVzh
         42zwDUKbcR/Vcw7bqjmlgxHucYZ5RQ1rh1KggwyZyPLiJ2sso48TILcnDlS3Yl9C5Sju
         O3WTQlCjOD/hJ9lBmuwzEmRtWVJVdw59EEr34JHrXYmlWgS+UAeTeJpANrJcBJJxaw0M
         RL7EAQGaTXPl9w/TA+9N7G00AJ1im1W38eqETibddRjElYUhPdLnG6A53pwApdeDdLhO
         h9Rv1FThwBR0dY2w8dzRNWYvYwrNZrnIXucbjY8GbHEyV07Dp/VlP9cUM6g5bM1AGKlf
         WGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685962405; x=1688554405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSRoaU6MsSHM4EqamjXT1zsk+53BlQcjMgqZZmifUn8=;
        b=UYeGF81jYmUGnDwkjrHBx6jp4SoczGHbhCMM9jJoOVeGI8fD/YSiyjKW2PbtL37f7U
         pu1mh2gIC67dOyfthIwtd0CZ+pe/Bs4gCMqOiRgpBlIk4Qpp1P9TxmX15b9gDQV/Ii0C
         rvLsQKN/WBkK/9Ab/6BBDuhIdOaPnMIn/nUoBHugqVKek9VJoQLrrSYo9B7NaShY4uxE
         MlC6e5nEl2RAglk60Q3PWlgy5nk0aeJW77j6hgXfg3J73AinYVsVM6bEG/fnaNjLO9e+
         fqADmiptAnSlc3D3qEQio25gbYdVSPplB8ISND9bhq7nQTPB78AeqFOPoMO3ahzR58HF
         oz8g==
X-Gm-Message-State: AC+VfDxPRekduBQX/ZwrrpGlDgGu4ILuM8duEpxYSSqHqm2cVsjCit8F
        D9MAe/CqKdJpT3YQXhnhwd2NfoxP+BVxJQ==
X-Google-Smtp-Source: ACHHUZ6G/HWw7tuPO8u1dkQWfzU1WHbd6JG5n5fQUR2Fs98RUfwOL36rNdJMWrR0NC1QRW1yR+q3kA==
X-Received: by 2002:a2e:8ec4:0:b0:2ac:82c1:5a3d with SMTP id e4-20020a2e8ec4000000b002ac82c15a3dmr3660296ljl.23.1685962404619;
        Mon, 05 Jun 2023 03:53:24 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id x13-20020a2e880d000000b002ac7b0fc473sm1393329ljh.38.2023.06.05.03.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 03:53:24 -0700 (PDT)
Date:   Mon, 5 Jun 2023 13:53:22 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        kishon@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v16 10/22] PCI: dwc: Modify PCIE_PORT_LINK_CONTROL
 handling
Message-ID: <20230605105322.orc3rtgu5rr3ovot@mobilestation>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-11-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510062234.201499-11-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 10, 2023 at 03:22:22PM +0900, Yoshihiro Shimoda wrote:
> To improve code readability, modify PCIE_PORT_LINK_CONTROL handling.

So basically you are doing the same update as in the Patch 9:
detaching the already implemented link width setups into a separate
method. Why do you split them up into the incremental updates? Just
squash this patch into the patch 9. The resultant patch would be an
atomic update and a preparation before adding the PCI_EXP_LNKCAP field
update. The later would lead to the fully coherent maximum link width
setup method in accordance with the DW PCIe hardware manual.

-Serge(y)

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 40 +++++++-------------
>  1 file changed, 13 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 68aefbbcd68c..5dc423dd2f21 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -721,28 +721,40 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
>  
>  static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
>  {
> -	u32 lwsc;
> +	u32 lwsc, plc;
>  
>  	if (!num_lanes)
>  		return;
>  
> +	/* Set the number of lanes */
> +	plc = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> +	plc &= ~PORT_LINK_MODE_MASK;
> +
>  	/* Set link width speed control register */
>  	lwsc = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>  	lwsc &= ~PORT_LOGIC_LINK_WIDTH_MASK;
>  	switch (num_lanes) {
>  	case 1:
> +		plc |= PORT_LINK_MODE_1_LANES;
>  		lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
>  		break;
>  	case 2:
> +		plc |= PORT_LINK_MODE_2_LANES;
>  		lwsc |= PORT_LOGIC_LINK_WIDTH_2_LANES;
>  		break;
>  	case 4:
> +		plc |= PORT_LINK_MODE_4_LANES;
>  		lwsc |= PORT_LOGIC_LINK_WIDTH_4_LANES;
>  		break;
>  	case 8:
> +		plc |= PORT_LINK_MODE_8_LANES;
>  		lwsc |= PORT_LOGIC_LINK_WIDTH_8_LANES;
>  		break;
> +	default:
> +		dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
> +		return;
>  	}
> +	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
>  	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
>  }
>  
> @@ -1027,31 +1039,5 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  	val |= PORT_LINK_DLL_LINK_EN;
>  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
>  
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
>  	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
>  }
> -- 
> 2.25.1
> 
