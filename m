Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12DA76A536
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 01:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjGaXxj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 19:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGaXxi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 19:53:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2926310C7;
        Mon, 31 Jul 2023 16:53:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe0c566788so8291703e87.0;
        Mon, 31 Jul 2023 16:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690847615; x=1691452415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTz8MxACsxOf+Ez5xf9vsBoR75Ka4/7ElU4RaiDgvDc=;
        b=jxTpHtIE7/7uTP26BYSD+7otApX+Z8LysDxm+dUfaXwr5b1MsBCXBhLu+66awp8LNo
         Gs3q//aRbbsfYWJnGTfbSZq9zg92YMq3JwCL+Cx66SX0OEamshOJi80lXuyleYJc4hh0
         iLPVAGPc4b1Sw2kyoUsL8t0wjQhn8dsainHJmzHowTuoooKvmU9b6dxEZY3CKktti03Z
         +cPKLleN0jIkPZNrHS3cEvTyMoOu37lUYM3WATBm1m5RPb1XiZDCoDmKhPpClZmEse2R
         AOXYXSNY73Ioxe+95qz7mEMFSEVBgoJC6SVV9jClYlWObQqhbGcHIHp6fvZ/59fHAxsE
         3zKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690847615; x=1691452415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTz8MxACsxOf+Ez5xf9vsBoR75Ka4/7ElU4RaiDgvDc=;
        b=Uf9wcByLBKC9fqfHv6aRhRA0uLuxSGYudhaJjiI0KzXrdxPC7ddB5g2amIdPZ6WM0D
         0YC9YQ9SskZbGdseTqsV+Wwv/0Df408aFY68dbOIQneO7TZpvZIFe2bopj6abPzV7C3b
         ElxJkJi/c7dy9Xmc79uUp2O1+EiwcZbM+dNGSNpo/ZshWMaqYyk4uo7LiNKMJZp65YPq
         6rAP8rxJnijyUw0UU6D5NzEHst4SEWheuSGvdZBkB4wpIDxzNNcLK5AxsQ+8FHR/HkIe
         1xoE6Sa+UJp2/Gw8sLwllMhwKENx4CSaPkDrtgt0gbuK6XQVfWpEnFtJnMoFwKCWDjbA
         USbw==
X-Gm-Message-State: ABy/qLbkdgAzf5uHjXGE7AnKr0RAD2kZlMOKj74fB9Ffva+rJAQeBxGr
        zvSwYJUt1esyCsbN2Vd8Dn4=
X-Google-Smtp-Source: APBJJlGd80L6Cve2a73xTy1Hm460tsYYQdPpMOWyeQSPLJ6koM/H0sw9PGTgFha5pCyiZ+UvrB5XDQ==
X-Received: by 2002:a05:6512:3e2a:b0:4fb:be3c:d8b7 with SMTP id i42-20020a0565123e2a00b004fbbe3cd8b7mr1064981lfv.51.1690847615041;
        Mon, 31 Jul 2023 16:53:35 -0700 (PDT)
Received: from mobilestation ([95.79.172.181])
        by smtp.gmail.com with ESMTPSA id s11-20020a19ad4b000000b004fe30e400a3sm958045lfd.111.2023.07.31.16.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 16:53:34 -0700 (PDT)
Date:   Tue, 1 Aug 2023 02:53:32 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        bhelgaas@google.com, Bjorn Helgaas <helgaas@kernel.org>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v18 08/20] PCI: dwc: Add dw_pcie_link_set_max_link_width()
Message-ID: <4ojfda5tlfu5wnljydzg7jncaa2zmhzgaqn723sst5rp44tfbl@j6ndm27ejinb>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-9-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721074452.65545-9-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 04:44:40PM +0900, Yoshihiro Shimoda wrote:
> To improve code readability, add dw_pcie_link_set_max_link_width().

You completely ignored all my comments regarding this patch again.
It's getting to be annoying really.

Once again: "This patch is a preparation before adding the
Max-Link-width capability setup which would in its turn complete the
max-link-width setup procedure defined by Synopsys in the HW-manual.
Seeing there is a max-link-speed setup method defined in the DW PCIe
core driver it would be good to have a similar function for the link
width setup. That's why we need to define a dedicated function first
from already implemented but incomplete link-width setting up
code." This is what should have been described in the commit log.
If you were a side-reader of the patch could you guess that from your
commit log and the patch content? I bet you couldn't. That's why a
very thorough description is important.

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 86 ++++++++++----------
>  1 file changed, 41 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 2d0f816fa0ab..5cca34140d2a 100644
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

Once again: this masking is unrelated to the link width setup.
Moreover it's completely redundant in here and in the original code.
See further for details.

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

My series contains the patch which drops this line:
https://patchwork.kernel.org/project/linux-pci/patch/20230611192005.25636-6-Sergey.Semin@baikalelectronics.ru/
So either pick my patch up and add it to your series or still pick it up
but with changing the authorship and adding me under the Suggested-by
tag with the email-address I am using to review your series. Bjorn,
what approach would you prefer? Perhaps alternative?

Note the patch I am talking about doesn't contain anything what
couldn't be merged in. The problem with my series is in completely
another dimension.

Bjorn

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
