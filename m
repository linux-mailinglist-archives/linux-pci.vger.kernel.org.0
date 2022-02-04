Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0174A92E7
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 05:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356341AbiBDEC7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 23:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244256AbiBDEC5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 23:02:57 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5F9C06173B
        for <linux-pci@vger.kernel.org>; Thu,  3 Feb 2022 20:02:57 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id l12-20020a0568302b0c00b005a4856ff4ceso4267456otv.13
        for <linux-pci@vger.kernel.org>; Thu, 03 Feb 2022 20:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8vjUDkV+iARdgiWSQ4YsWHnN/kh0X+O8ugeP4lXiODk=;
        b=RYw2VYN9KB2/BEuUv8nabBEggJvW9qlsMbzlk0pvrLeKLnurQKe1vRlfJ7cajr9xJW
         b5vK2Th0UAfkx33tvLyAJy4BYK0ZAvUZwIG4ByRbLgCU4BOsn7yIvnoUHvN6zZQtKYZc
         XYNk9J0ZRe2wGIMot5vpWFmKu+z9P5EA/dQPMIE5h3KEJ46GtojZRTUDtTdtfF3NzhPX
         nLPxjI+6Aw4XMe/7CxUYiJXS2eQvM1fidSc71H9dteAE6MyRl/g9LaUnGtL9S1INA8UN
         wFHPrsD373vYFwzOutg7wAWHBK4aPA9FnzW2p2rgKLQy6zGPgE/zW9UdYFVnpF7uq8TC
         n02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8vjUDkV+iARdgiWSQ4YsWHnN/kh0X+O8ugeP4lXiODk=;
        b=vaf18yIKnHLhmLYFv+hVoDh1KFp1t+j3TPPtnu6laMMlOBBPAcrR2/axPrG4EBoghe
         RJtQA4DyQt/A8h1VMg0Qcj5lxP7uhTLrH1DNBvLxBHe2OPV+azAZD456MM9vb0gBBYOh
         G6hRTgRf7EQX6rIwrn3pFxiUX8eqFWGO0XlJ0PWYWwyhHfPd0zKasLG4WSf0RhLNHJiL
         QXg1ILmbwmyXjWp/CScSDR4lWzniBB1KKJY7twBTmZwZaHf2wAy1nIhVmdB8Y0fJv1d7
         TCXfiQCPxwJeS+m/1L+c7dsyTCFONfP9HeWZGpSNvaWk4kOrlpJyBw4BaNy7MB61xVLQ
         nJRg==
X-Gm-Message-State: AOAM533Yx76z8Cak2mtfsQAA91dCVawUs53VYnItn5JBhKzoCi1u/EuN
        PSQFdh/c7J1xAAD0YIvu4KV6Kw==
X-Google-Smtp-Source: ABdhPJxRzC5FPqT1W+Buzn1QEA1+Tjp17Lmc5wGGdM3OlHirSRFv8xduxJ0aJ8LZilmhEjsvvaYoYQ==
X-Received: by 2002:a9d:69c1:: with SMTP id v1mr510435oto.134.1643947376995;
        Thu, 03 Feb 2022 20:02:56 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id ay42sm360785oib.5.2022.02.03.20.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 20:02:56 -0800 (PST)
Date:   Thu, 3 Feb 2022 20:03:12 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 2/3] PCI: qcom: Fix pipe_clk_src reparenting
Message-ID: <YfylgC0OEdbpIR37@ripper>
References: <20211218140223.500390-1-dmitry.baryshkov@linaro.org>
 <20211218140223.500390-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218140223.500390-3-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat 18 Dec 06:02 PST 2021, Dmitry Baryshkov wrote:

> The hardware requires that pipe_clk_src is fed from TCXO when GDSC is
> disabled. It can be fed from PHY's pipe_clk once GDSC is enabled (which
> is what is done by the downstream driver).
> 
> Currently code does all clk_set_parent() calls after the
> pm_runtime_get(), so the GDSC is already enabled.
> Implement these requirements by moving pm_runtime_*() calls after
> get_resources (so that get_resources() can ensure that the pipe clock
> parent is TCXO).
> 
> Fixes: aa9c0df98c29 ("PCI: qcom: Switch pcie_1_pipe_clk_src after PHY init in SC7280")
> Cc: Prasad Malisetty <pmaliset@codeaurora.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 52 ++++++++++++--------------
>  1 file changed, 24 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 3a0f126db5a3..fbaae6f4eb18 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1188,6 +1188,9 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  		res->ref_clk_src = devm_clk_get(dev, "ref");
>  		if (IS_ERR(res->ref_clk_src))
>  			return PTR_ERR(res->ref_clk_src);
> +
> +		/* Ensure that the TCXO is a clock source for pcie_pipe_clk_src */
> +		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
>  	}
>  
>  	res->pipe_clk = devm_clk_get(dev, "pipe");
> @@ -1208,9 +1211,9 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  		return ret;
>  	}
>  
> -	/* Set TCXO as clock source for pcie_pipe_clk_src */
> +	/* Set pipe clock as clock source for pcie_pipe_clk_src */
>  	if (pcie->pipe_clk_need_muxing)
> -		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
> +		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);

At this point we've not yet called phy_power_on(), so I would expect the
pipe_clk_src from the PHY to be disabled and hence we wouldn't be able
to reparent the pipe_clk.

But that makes me wonder what the actual requirement here is. Do we need
just any signal on the pipe clock while initializing the controller? Or
could we simply just move the pipe_clk parent scheme to the PHY driver
as well?


Is there a case where pipe_clk needs to provide a good clock signal,
before the PHY has started to generate pipe_clk_src? Or is this scheme
simply an open coded version of the parking of shared RCGs that we see
all over the place?

Regards,
Bjorn

>  
>  	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
>  	if (ret < 0)
> @@ -1276,6 +1279,11 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>  
>  	clk_bulk_disable_unprepare(res->num_clks, res->clks);
> +
> +	/* Set TCXO as clock source for pcie_pipe_clk_src */
> +	if (pcie->pipe_clk_need_muxing)
> +		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
> +
>  	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
>  }
>  
> @@ -1283,10 +1291,6 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  {
>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>  
> -	/* Set pipe clock as clock source for pcie_pipe_clk_src */
> -	if (pcie->pipe_clk_need_muxing)
> -		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
> -
>  	return clk_prepare_enable(res->pipe_clk);
>  }
>  
> @@ -1542,11 +1546,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	if (!pci)
>  		return -ENOMEM;
>  
> -	pm_runtime_enable(dev);
> -	ret = pm_runtime_resume_and_get(dev);
> -	if (ret < 0)
> -		goto err_pm_runtime_disable;
> -
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>  	pp = &pci->pp;
> @@ -1563,32 +1562,29 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;
>  
>  	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
> -	if (IS_ERR(pcie->reset)) {
> -		ret = PTR_ERR(pcie->reset);
> -		goto err_pm_runtime_put;
> -	}
> +	if (IS_ERR(pcie->reset))
> +		return PTR_ERR(pcie->reset);
>  
>  	pcie->parf = devm_platform_ioremap_resource_byname(pdev, "parf");
> -	if (IS_ERR(pcie->parf)) {
> -		ret = PTR_ERR(pcie->parf);
> -		goto err_pm_runtime_put;
> -	}
> +	if (IS_ERR(pcie->parf))
> +		return PTR_ERR(pcie->parf);
>  
>  	pcie->elbi = devm_platform_ioremap_resource_byname(pdev, "elbi");
> -	if (IS_ERR(pcie->elbi)) {
> -		ret = PTR_ERR(pcie->elbi);
> -		goto err_pm_runtime_put;
> -	}
> +	if (IS_ERR(pcie->elbi))
> +		return PTR_ERR(pcie->elbi);
>  
>  	pcie->phy = devm_phy_optional_get(dev, "pciephy");
> -	if (IS_ERR(pcie->phy)) {
> -		ret = PTR_ERR(pcie->phy);
> -		goto err_pm_runtime_put;
> -	}
> +	if (IS_ERR(pcie->phy))
> +		return PTR_ERR(pcie->phy);
>  
>  	ret = pcie->ops->get_resources(pcie);
>  	if (ret)
> -		goto err_pm_runtime_put;
> +		return ret;
> +
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
> +		goto err_pm_runtime_disable;
>  
>  	pp->ops = &qcom_pcie_dw_ops;
>  
> -- 
> 2.34.1
> 
