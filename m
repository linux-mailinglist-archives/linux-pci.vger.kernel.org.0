Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C986F3873
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 21:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjEATsN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 15:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEATsM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 15:48:12 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE27D1FC0;
        Mon,  1 May 2023 12:48:10 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2a8a6602171so28769131fa.0;
        Mon, 01 May 2023 12:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682970489; x=1685562489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EMAgGHNMgwb/IjpFMc3UyWoPThz6bRchwVC+4upmDvY=;
        b=Q8dx3wApvz9PnGvEVk/+sgq/+kQhnurhZ9M3u5UpVQusmksLSLd1LJBqU8pTzrf5GS
         geC6xEj9CQ6WNXEntNS7e+C8slrdHvn/gEiLeDz+gCJWGvjH9KbYSvqMqrlSZzB3SJvB
         IANPwTQtgzZN6KpOibCwsTkd/dRAQjEjqjBDSW19rn59LK7GFTBa1EDOTgqyxQ20Poqt
         BcKR4fxSvueoIwBP/yIkbKOG9ggKcv8VhMDkFb3o7m2/nsy/Ebw2aWrs3NGivpC/WGbl
         YeOG4R3epoG0xta0BqoYJWFlFdOltSkIlGH7GQM1PBsHQEm4LU4uVWk3sG1F0q9CK/oF
         EP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682970489; x=1685562489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMAgGHNMgwb/IjpFMc3UyWoPThz6bRchwVC+4upmDvY=;
        b=O4DH4cuAKsJt3CIqeup4hwkaoWomNOZQY5QXdwxa5rnEG42eNTF2I2x840THaHFOgz
         sDzGhlcbSV5vA/R5NtdBvSU2jH++kHQ0RI8dYr3PYdjDnwy7Fj2cICpFCP2GXfxzNSum
         trWD+uCRnTERPbTYZtH7PhTdWCGh7mpuXUNNoyZQ4MWUyOn7tE4y3cyaaTZuvvlENlMP
         NyffCyTOKgjblR4ubduSe3fs7iz9fjm06nK1tJPfKOwXGQjfq7m4PDn5NOf+HOwFfY6Q
         Plc23f34C21VZUyVAPr8gyX6rGt7yFisrbX/zJivVvum6uEohfZVuX+aQitIoI7PYeEx
         IE2g==
X-Gm-Message-State: AC+VfDw9U+Jt5VWMgs/2dSYGw5G+2dJP90gvDCezNoOEfRey2CNFbqQu
        1B1i/dXAW8pQ5M/6rVtNXE06nw0lK3xQaA==
X-Google-Smtp-Source: ACHHUZ7htbJ5YsOW1gRpRIP00N04ENBxPKIq1dsYdQ1OAmhhK25H/R8uGi1CYcAqIMpQG/VIkQrbKQ==
X-Received: by 2002:a2e:8482:0:b0:2a9:e6e7:b027 with SMTP id b2-20020a2e8482000000b002a9e6e7b027mr3586243ljh.41.1682970488794;
        Mon, 01 May 2023 12:48:08 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id o8-20020a2e9b48000000b002a9b01bb0a3sm4837129ljj.57.2023.05.01.12.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:48:08 -0700 (PDT)
Date:   Mon, 1 May 2023 22:48:05 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        kishon@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v14 10/21] PCI: dwc: Add dw_pcie_link_set_max_width()
Message-ID: <20230501194805.542ohktc5sexcxnb@mobilestation>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
 <20230426045557.3613826-11-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426045557.3613826-11-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 26, 2023 at 01:55:46PM +0900, Yoshihiro Shimoda wrote:
> To improve code readability, add dw_pcie_link_set_max_width().
> The original code writes the PCIE_PORT_LINK_CONTROL register twice
> if the pci->num_lanes is not zero. But, it should avoid to write
> the register twice. So, refactor it.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 66 +++++++++++---------
>  1 file changed, 35 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 69358dc202f0..f8926d5ec422 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -737,6 +737,40 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
>  	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | link_speed);
>  }
>  

> +static void dw_pcie_link_set_max_width(struct dw_pcie *pci, u32 num_lanes)

Why defining a separate method? Just move it's content to the already
defined dw_pcie_link_set_max_link_width(). This could have been done in
the framework of the previous patch.

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

this and...

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

...this change the link-width setup semantic in case if the
invalid number of lanes is specified. Your method now causes the
PORT_LINK_MODE_MASK field clearance in case if a not permitted link
width is passed.

> +		break;
> +	}
> +
> +	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> +}
> +
>  static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
>  {
>  	u32 val;
> @@ -1040,36 +1074,6 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
>  	}
>  

> -	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> -	val &= ~PORT_LINK_FAST_LINK_MODE;
> -	val |= PORT_LINK_DLL_LINK_EN;
> -	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);

Please leave the setups above here. Link-training mode has nothing to
do with the max link width.

-Serge(y)

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
