Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936E974F944
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 22:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjGKUpn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 16:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjGKUpm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 16:45:42 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEFD1BE8;
        Tue, 11 Jul 2023 13:45:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fba74870abso9383236e87.0;
        Tue, 11 Jul 2023 13:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689108316; x=1691700316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9xIQvqaahkiwEUqdRZhWypAqRkikDdgKU/ZrStMMeg=;
        b=dsK0NXDIeVcBsiyPXT9V2671tLaT4oNp0Nx6MBOYfYAkPD9AtV4Gn6XvhA4gu32rDI
         o8QHw1WcaXHOVveCQ9ZwwuyMqrH+0I5mDKORD/XYFGC6E/qG0tef1/TPlgL117hThXhu
         +WhF3zd5W4PtVGvfBGXYGR0TcierT38BQSih00QGbOnpdcJNqffQG3WytnqZ7BGgGcjX
         0AQ5bx4xsNpS+ElHZhUfb+vHd6SSUmXDIb7HTaSzouMXUYX8P+/KYxqSxrxJDApVqtB3
         hKes2tIMxsv3b899AmyYgm+v1sNtJofdzVyUXvPLW5ga0vm7iGg7mpzTJQvA2FXia0GA
         IysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689108316; x=1691700316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9xIQvqaahkiwEUqdRZhWypAqRkikDdgKU/ZrStMMeg=;
        b=hNgQtnAdkLdDHzWvC0KC8cKOT5ZTJAmoH9QfTrYDk/ktC5Fq71JiV4ElanaSGz4rmY
         CH7eJCTyV5OzK1t+99qe2fAHWWkv0yr1wCbPt0NYqpxs4We6WBGa1VR9UIQ1MRv64c4n
         L6hJHf1k8kw2HMJwu4B5btIY/oBt5aa/iGeqMmiMdDtrXTeZcq+Ino0MZt5DMPd1GB4x
         yxhFkCU00VOLsZMKwuwjA9Gy7bz/yAYa0oZWaxsm4m4/LPGAKmMxSMwm8ZfrAv9BPq1c
         O6Oe1CuX+OlTM8pOu1Uhx4wrDC+4F2AYGRO09OiqdIwPSLVOVwYa679ApDpgY13Eeo9Q
         Sjog==
X-Gm-Message-State: ABy/qLYqQwBf+KnIpdSWpCm+3FGCEze66BlMYI1oRtMsit5Mo+PIuJBc
        1pj9/KOrHzqzoIg1/jyvAL8=
X-Google-Smtp-Source: APBJJlGcM8HVA3S7jGvt/A3pI5N5Rc581SeVvdlceIgVS7lJx/eDsAxaKx96Ea0clz/Xb98Cai9LQQ==
X-Received: by 2002:a19:6504:0:b0:4fb:8b78:4a93 with SMTP id z4-20020a196504000000b004fb8b784a93mr9689819lfb.7.1689108315358;
        Tue, 11 Jul 2023 13:45:15 -0700 (PDT)
Received: from mobilestation ([95.79.172.181])
        by smtp.gmail.com with ESMTPSA id d28-20020ac2545c000000b004faeedbb2a0sm441163lfn.78.2023.07.11.13.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 13:45:14 -0700 (PDT)
Date:   Tue, 11 Jul 2023 23:45:10 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v17 08/20] PCI: dwc: Add dw_pcie_link_set_max_link_width()
Message-ID: <3nldn3s27gwdsfyybgg2ady4tkgpxcvsntbpxp4vdbr4myncnc@clivb7gcds3e>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
 <20230705114206.3585188-9-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705114206.3585188-9-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 05, 2023 at 08:41:54PM +0900, Yoshihiro Shimoda wrote:
> To improve code readability, add dw_pcie_link_set_max_link_width().

This is a preparation 

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 86 ++++++++++----------
>  1 file changed, 41 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index a531dc50abea..7b720bad7656 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -728,6 +728,46 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
>  
>  }
>  
> +static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
> +{
> +	u32 lwsc, plc;
> +
> +	if (!num_lanes)
> +		return;
> +
> +	/* Set the number of lanes */
> +	plc = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);

> +	plc &= ~PORT_LINK_FAST_LINK_MODE;

This is redundant and unrelated to the link width setup. See my next
comment for solution.

> +	plc &= ~PORT_LINK_MODE_MASK;
> +
> +	/* Set link width speed control register */
> +	lwsc = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> +	lwsc &= ~PORT_LOGIC_LINK_WIDTH_MASK;
> +	switch (num_lanes) {
> +	case 1:
> +		plc |= PORT_LINK_MODE_1_LANES;
> +		lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
> +		break;
> +	case 2:
> +		plc |= PORT_LINK_MODE_2_LANES;
> +		lwsc |= PORT_LOGIC_LINK_WIDTH_2_LANES;
> +		break;
> +	case 4:
> +		plc |= PORT_LINK_MODE_4_LANES;
> +		lwsc |= PORT_LOGIC_LINK_WIDTH_4_LANES;
> +		break;
> +	case 8:
> +		plc |= PORT_LINK_MODE_8_LANES;
> +		lwsc |= PORT_LOGIC_LINK_WIDTH_8_LANES;
> +		break;
> +	default:
> +		dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
> +		return;
> +	}
> +	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
> +	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
> +}
> +
>  void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  {
>  	int max_region, ob, ib;
> @@ -1009,49 +1049,5 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  	val |= PORT_LINK_DLL_LINK_EN;
>  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
>  
> -	if (!pci->num_lanes) {
> -		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
> -		return;
> -	}
> -
> -	/* Set the number of lanes */

> -	val &= ~PORT_LINK_FAST_LINK_MODE;

Please pick up my patch dropping the line above
https://patchwork.kernel.org/project/linux-pci/patch/20230611192005.25636-6-Sergey.Semin@baikalelectronics.ru/
and add it to your series before this one.
* unless Krzysztof decide to merge it and some another patches from my
* series in...

-Serge(y)

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
