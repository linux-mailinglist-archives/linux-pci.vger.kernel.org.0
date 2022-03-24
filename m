Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FBA4E6331
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 13:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241024AbiCXMVJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 08:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350106AbiCXMUx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 08:20:53 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B0B381B2
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 05:19:11 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q19so3685251pgm.6
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 05:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PSVqUGYCB8wbqp0p5VdHcycQRYblcQrceG961CbBc2A=;
        b=xv7UNuh3P/pCkD30Cn5aiI+Z9Q2ToAUx3HRW9MfmVNyc2NW9JgXCpNq5u8S36zmwV6
         UJE5E55gp9RnS8Z5ITwrEq197emD7plU9KYuvosCZHibQGUSyT2OQ6PCjjINl5bwPIzk
         Ft49iIISlZ26bjImBo2TmZVBgqPQvnZl0HNjDHaogXWcE4lw4KafLyWbfit4ON8Atwco
         qoh1ALKl1zhdm83knImVa6l3NuN6sx5OpVf3yWm/89XOFFwb2JwLuFS6SGNlUYpKYhYF
         TrJZF9xQtlONhf/CcyIlX/XCr4cErV81Oc3HzdqYM1RIiZC21XQaS+z39VMGpbotdnmD
         E8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PSVqUGYCB8wbqp0p5VdHcycQRYblcQrceG961CbBc2A=;
        b=dvuF8udkkyGSc1/sa5OoNh0Lv4xauBoDyUXlC0y0HMZX0rduU496HDj/HYqTvuwvWU
         z6Q9gb0i/olPl+xlWca5Fvg5lOwKRTykFHgY7Bgg9lO6lLWoChwwG9ajPRpP8MFMx9oy
         bbvLOAYxU2bwXqGxuBRanfx46RI3vKdqPryXbF009sNr5SUgFMERophOee7fuz3wvXhE
         iccbwW+FoI8q0f89kcKH/Fnc03xZ5o6YQ1a5iRnIaVR3nAxRKHRETAevMowZVJtvXoVG
         +Mt5OWV2Iylf5BQM55slZxYjEK4S5h+WFpTggtISmH2Ssc68VCbb6F8Bs0cYVC6oVpqz
         LfGQ==
X-Gm-Message-State: AOAM530qHNOG6ehZyCurE6KqrD1cGvYkg7GOn3LsRNQhF8FWxpsHppjP
        EEbOVF+W0q8JzZsrROen52xs
X-Google-Smtp-Source: ABdhPJyuUdBVtlvKFXLN8XVaL5WdsI//XFeIzHjYqFdNJyAuyLqrhdizNaHwxYMYlooEtPQQZLslCQ==
X-Received: by 2002:a63:753:0:b0:385:fe06:eb86 with SMTP id 80-20020a630753000000b00385fe06eb86mr3790923pgh.132.1648124351146;
        Thu, 24 Mar 2022 05:19:11 -0700 (PDT)
Received: from thinkpad ([220.158.158.107])
        by smtp.gmail.com with ESMTPSA id p12-20020a63ab0c000000b00381f7577a5csm2428626pgf.17.2022.03.24.05.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 05:19:10 -0700 (PDT)
Date:   Thu, 24 Mar 2022 17:49:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] PCI: dwc: Discard IP-core version checking on
 unrolled iATU detection
Message-ID: <20220324121905.GH2854@thinkpad>
References: <20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru>
 <20220324012524.16784-9-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324012524.16784-9-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 04:25:19AM +0300, Serge Semin wrote:
> It's pretty much pointless. Even though unrolled version of the internal
> ATU has been indeed available since DWC PCIe v4.80a IP-core, there is no
> guarantee it was enabled during the IP-core configuration (Synopsys
> suggests to contact the Solvnet support for guidance of how to do that for
> the newer IP-cores). So the only reliable way to find out the unrolled
> iATU feature availability is indeed to check the iATU viewport register
> content. In accordance with the reference manual [1] if the register
> doesn't exist (unrolled iATU is enabled) it's content is fixed with
> 0xff-s, otherwise it will contain some zeros. So we can freely drop the
> IP-core version checking in this matter then and use the
> dw_pcie_iatu_unroll_enabled() method only to detect whether iATU/eDMA
> space is unrolled.
> 
> [1] DesignWare Cores, PCI Express Controller, Register Desciptions,
> v.4.90a, December 2016, p.855
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 3bd1cfd12148..e3d2c11e6998 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -600,15 +600,15 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
>  
>  }
>  
> -static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
> +static bool dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
>  {
>  	u32 val;
>  
>  	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
>  	if (val == 0xffffffff)
> -		return 1;
> +		return true;
>  
> -	return 0;
> +	return false;
>  }
>  
>  static void dw_pcie_iatu_detect_regions_unroll(struct dw_pcie *pci)
> @@ -680,9 +680,8 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  	struct device *dev = pci->dev;
>  	struct platform_device *pdev = to_platform_device(dev);
>  
> -	if (pci->version >= 0x480A || (!pci->version &&
> -				       dw_pcie_iatu_unroll_enabled(pci))) {
> -		pci->iatu_unroll_enabled = true;
> +	pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
> +	if (pci->iatu_unroll_enabled) {
>  		if (!pci->atu_base) {
>  			struct resource *res =
>  				platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
> -- 
> 2.35.1
> 
