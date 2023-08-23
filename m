Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00384785641
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 12:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjHWKw5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 06:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbjHWKwf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 06:52:35 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311D9171A;
        Wed, 23 Aug 2023 03:52:03 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bbad32bc79so91586371fa.0;
        Wed, 23 Aug 2023 03:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692787919; x=1693392719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dRqhHJXq0Bktxo4H46C7zgVTLLHao9LqR7pClaczyyg=;
        b=g9aT5cY0qg5/uOYhAX43HIno9Ld2yZYR1mu2rg5carT2KMhyo030PA10b8E91317GC
         ak4xBcexedwhm2nrHROiiD3Qlydl+IRpZlG6k9VqrnPZxDh1mqg9gz0ci6wRrDErFBow
         Q8Tbl/Q9dDrPD7fAlpvMHaMBvBXlfOoQP2ds/+DJ2XuN4L8ZT1NBDthyKg7GPzYiwA0Q
         23+c9nlWS4m/mgNpVa/ULx58zyw2SCHuHBEuLeHUbcr9/QfdIpgm6rKNuu5qner5L9HZ
         ez12vz+L76HFYsFH32hFAecwHxAlkYTwHqr46csKBkgWuqtLw1jx7+L60R7dPICjgNQA
         PyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692787919; x=1693392719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRqhHJXq0Bktxo4H46C7zgVTLLHao9LqR7pClaczyyg=;
        b=g57s91+v9uNRi0yQcU9hcJWS7395WgsEoMHlJJad2qJ+HBRHQs6+QPuF6C6SdpgB4g
         CpxrHf8DIL+erUoo/1bHXFkKwoOa86HsBs7Ii1bICLkzqYimSbmG602v0WNOv7mfOccC
         1ppr+5ub7JOX2uYWr+jyWJus29X07hxxGa7g/ebOFuRT9qH1znTv37W4UXNW91fVxihz
         fRq/P6Bmfy+SnUtGDweeUOEhMyMJQwRP6eadwMtz/gsbCnzNnBVlaLP0y0j/nTlc/DSP
         BLzcpEUUq7aY3hT4GYJvDwcwaUqEHJGL7IIOJPga012fIf6L+ZbJC4mZLPDBSbG+mxKo
         nCyg==
X-Gm-Message-State: AOJu0YyxJg/w0jSO94A+HJyVEv2ruSegIpeLpZyPxQ4DOJdeqxkwZBx4
        QF4hvba5KNwbc0UwgHp1piY=
X-Google-Smtp-Source: AGHT+IFcjFkYYN1zTjIy03aZ9OVZHXp+Q5at0oljrFTh0tUeUKBOXh3Hy+PDiisA500c0O+wbXloHA==
X-Received: by 2002:a05:651c:146:b0:2b6:9ed0:46f4 with SMTP id c6-20020a05651c014600b002b69ed046f4mr9301965ljd.23.1692787918876;
        Wed, 23 Aug 2023 03:51:58 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id n23-20020a2e9057000000b002bcbb464a28sm1713321ljg.59.2023.08.23.03.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 03:51:58 -0700 (PDT)
Date:   Wed, 23 Aug 2023 13:51:55 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v19 06/19] PCI: dwc: Add dw_pcie_link_set_max_link_width()
Message-ID: <xx2acgfntcqzdiujo76xqt7prhgws4kgsmiupukzkmpmin5tzx@jzorkzrx4di3>
References: <20230823091153.2578417-1-yoshihiro.shimoda.uh@renesas.com>
 <20230823091153.2578417-7-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823091153.2578417-7-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 23, 2023 at 06:11:40PM +0900, Yoshihiro Shimoda wrote:
> This patch is a preparation before adding the Max-Link-width capability
> setup which would in its turn complete the max-link-width setup
> procedure defined by Synopsys in the HW-manual. Seeing there is
> a max-link-speed setup method defined in the DW PCIe core driver
> it would be good to have a similar function for the link width setup.
> That's why we need to define a dedicated function first from already
> implemented but incomplete link-width setting up code.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 86 ++++++++++----------
>  1 file changed, 41 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index d1dfe6f2eb4c..976dcc511fdc 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -722,6 +722,46 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
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

Sigh... Anyway.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

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
> @@ -1003,49 +1043,5 @@ void dw_pcie_setup(struct dw_pcie *pci)
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
