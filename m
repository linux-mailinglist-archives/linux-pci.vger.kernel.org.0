Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C627D9A71
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 15:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345688AbjJ0NvX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 09:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345458AbjJ0NvW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 09:51:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB43C9D
        for <linux-pci@vger.kernel.org>; Fri, 27 Oct 2023 06:51:20 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27cfb8442f9so1750501a91.2
        for <linux-pci@vger.kernel.org>; Fri, 27 Oct 2023 06:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698414680; x=1699019480; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yClEmQrqjxPOdEt4O4nDzfNvYznOcwD4oHzNoki+cXk=;
        b=IniAMNg7WfTlg9CqfyIO+8h4AyKyxVi9dAj1cf2AbG8nT6mzRdFkAOg4V07OOqE+98
         az6NW5eZPIyTKY7ppZ/Q834JuxYSPJuoN9OeT4pU5Ir9qUqzg0fOykG2Xu5bnj+haC5I
         yQxXOMCO8EtFRi993j1s/Cp/vqobJugxJLOq1gzxdV5FkgdLH1XghUTeRH/HbOAh0+KE
         ex5tKDnh77BIs0djqRCIWsmDAYdmFJinscCXCrrJFoJ9I5jD7zaoLKCf9+ygyt8J5p44
         r0/UYgqjOR8BIgu5xJNl5p+v8uWXWBbjrD1l8vthJ2iLzQq81G7Yfmcd0FdfOehY46nB
         x8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698414680; x=1699019480;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yClEmQrqjxPOdEt4O4nDzfNvYznOcwD4oHzNoki+cXk=;
        b=QIgrAMyO00xJtDLPJqHWVCyylUAuABC/nimMREPpeawvpJZkHBZVvxFjWyDnLBrKdG
         +wI/1kM5d40M/I365dmjwz8vVNqBiDLy9aJ4dm6XLwSqPMABZBFp9shLJFtGMs3PI6AA
         itEYr23gA5X3OewrpxlYIDO6EvXq01zhhlMAfJJzCHBTKrBJBRcBWscmElh9L/C91NmA
         LdnoyB03BlJ8FRIalKKB1lGokdsk8e//vu0JCsr3CP6tA4++JpeRhsQbjnpDpO4I0g3v
         L7O35fcwKBApNEMVHkrOwRNWGZK/yD/MmUimOAA53DNB8xrKsAe07hus7/BWFc4XgQ83
         U2lg==
X-Gm-Message-State: AOJu0Yy2JggZzLBckUjQxTZ069x4UHZ0p4yD2xXL+r6YKiXZAQeVExB+
        ODZZj/Tcm5yR5Kg5QGqUJeW0
X-Google-Smtp-Source: AGHT+IGqCJVvpEyUioQmJvsxwgcQ0gbRLZzrZ42d1hKqRxPaA7cyNZ0+7ziM+B9RL5dMOlHxK5eGYw==
X-Received: by 2002:a17:90b:2495:b0:274:99e7:217e with SMTP id nt21-20020a17090b249500b0027499e7217emr2593791pjb.16.1698414680273;
        Fri, 27 Oct 2023 06:51:20 -0700 (PDT)
Received: from thinkpad ([120.138.12.43])
        by smtp.gmail.com with ESMTPSA id n14-20020a17090ac68e00b00274262bcf8dsm3229377pjt.41.2023.10.27.06.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 06:49:49 -0700 (PDT)
Date:   Fri, 27 Oct 2023 19:18:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     jingoohan1@gmail.com, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        pankaj.dubey@samsung.com
Subject: Re: [PATCH] PCI: exynos: Adapt to clk_bulk_* APIs
Message-ID: <20231027134849.GA23716@thinkpad>
References: <CGME20231009062222epcas5p36768b75c13c7c79965b5863521361a64@epcas5p3.samsung.com>
 <20231009062216.6729-1-shradha.t@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009062216.6729-1-shradha.t@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 09, 2023 at 11:52:16AM +0530, Shradha Todi wrote:
> There is no need to hardcode the clock info in the driver as driver can
> rely on the devicetree to supply the clocks required for the functioning
> of the peripheral. Get rid of the static clock info and obtain the
> platform supplied clocks. The total number of clocks supplied is
> obtained using the devm_clk_bulk_get_all() API and used for the rest of
> the clk_bulk_* APIs.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/pci/controller/dwc/pci-exynos.c | 46 ++++++-------------------
>  1 file changed, 11 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index 9e42cfcd99cc..023cf41fccd7 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -54,8 +54,8 @@
>  struct exynos_pcie {
>  	struct dw_pcie			pci;
>  	void __iomem			*elbi_base;
> -	struct clk			*clk;
> -	struct clk			*bus_clk;
> +	struct clk_bulk_data		*clks;
> +	int				clk_cnt;
>  	struct phy			*phy;
>  	struct regulator_bulk_data	supplies[2];
>  };
> @@ -65,30 +65,18 @@ static int exynos_pcie_init_clk_resources(struct exynos_pcie *ep)
>  	struct device *dev = ep->pci.dev;
>  	int ret;
>  
> -	ret = clk_prepare_enable(ep->clk);
> -	if (ret) {
> -		dev_err(dev, "cannot enable pcie rc clock");
> +	ret = devm_clk_bulk_get_all(dev, &ep->clks);
> +	if (ret < 0)

Please use !(ret) here and below to be consistent with the driver.

>  		return ret;
> -	}
>  
> -	ret = clk_prepare_enable(ep->bus_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot enable pcie bus clock");
> -		goto err_bus_clk;
> -	}
> +	ep->clk_cnt = ret;

Since clk_cnt is "int", you can just use it directly instead of "ret".

>  
> -	return 0;
> -
> -err_bus_clk:
> -	clk_disable_unprepare(ep->clk);
> -
> -	return ret;
> +	return clk_bulk_prepare_enable(ep->clk_cnt, ep->clks);
>  }
>  
>  static void exynos_pcie_deinit_clk_resources(struct exynos_pcie *ep)
>  {
> -	clk_disable_unprepare(ep->bus_clk);
> -	clk_disable_unprepare(ep->clk);
> +	clk_bulk_disable_unprepare(ep->clk_cnt, ep->clks);
>  }
>  
>  static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
> @@ -332,17 +320,9 @@ static int exynos_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(ep->elbi_base))
>  		return PTR_ERR(ep->elbi_base);
>  
> -	ep->clk = devm_clk_get(dev, "pcie");
> -	if (IS_ERR(ep->clk)) {
> -		dev_err(dev, "Failed to get pcie rc clock\n");
> -		return PTR_ERR(ep->clk);
> -	}
> -
> -	ep->bus_clk = devm_clk_get(dev, "pcie_bus");
> -	if (IS_ERR(ep->bus_clk)) {
> -		dev_err(dev, "Failed to get pcie bus clock\n");
> -		return PTR_ERR(ep->bus_clk);
> -	}
> +	ret = exynos_pcie_init_clk_resources(ep);
> +	if (ret < 0)
> +		return ret;
>  
>  	ep->supplies[0].supply = "vdd18";
>  	ep->supplies[1].supply = "vdd10";
> @@ -351,10 +331,6 @@ static int exynos_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	ret = exynos_pcie_init_clk_resources(ep);
> -	if (ret)
> -		return ret;
> -
>  	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
>  	if (ret)

You need to disable_unprepare() clocks in error path here and above.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
