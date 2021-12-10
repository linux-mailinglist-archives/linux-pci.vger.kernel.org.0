Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D34846FF9E
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 12:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbhLJLTX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 06:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbhLJLTX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 06:19:23 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D561AC0617A2
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 03:15:48 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso7235177pjl.3
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 03:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qYllIsVSqbDs4dUz+zHNMI4+DHlEEtES2AFLDR4RsZs=;
        b=lJMJZNQwKKu3LXLTLiiAMsOb/MOH+BlpVy5hjylkJ5ZbqhJVb+i9WuizTmYNqqHd8i
         GU+rvIFnESSUy8bcVLcsBqzhh9Xe7ZKHtd66uad0C+bNYUCVUZEXQU2FfQhH64QHf+w2
         DZeQs6EI23KdzoHltL53EfUJLeAwCbNOvO2A9AS4OzfacF6kMvd1ADO9icjkU3oMmLfG
         Ug7mI0GUaQpoLPuBMGo/gfOLKrpONc+ZCH/T+Ss+ffigflymQglRnDhkSdOY3r18eteM
         4BZDg3PbylTiHWEKQ82AojRHPaVn4EbqpMAFJQkBcq569ZFD3oTvthmgOnuO2rL7h3q/
         LXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qYllIsVSqbDs4dUz+zHNMI4+DHlEEtES2AFLDR4RsZs=;
        b=upvXVKHlsopyRN97cNUl0oXf24Z2OpFU3UDtT9J10OqdNVSxwJZR89tpYJ6WKaJdKK
         pbbQthwapOQY3sMZJ+dFvBtqimYZepNP8cIwTuLztRMHw9b4XZhLOXoKvM/fxymrTHK7
         y3cEE9KF+GFMLyn9UqfMfh91oZENd/e2lnRkr5h04fjq+ibK8fR7sNaV14XRDxidMXAG
         lywuWpptLnZMhmxYOQO8pZwcGco++Q42WB6YWD5VEUMhF+rMLImE2RhzkvSrWgrnvlLM
         jPIPNea+iU3wyiHlDY5fndnt/Wdzt6gVVnN7IxO0Lcm/chjrmj7RCjafGrWuP6tTCUhA
         AtCQ==
X-Gm-Message-State: AOAM531CnJAVr5cC+nX3wFde0Jf+n91T9YEFUxyfUGeXIuQZ4fBkqA9I
        j2rRASWALozwEXEWD0+f4eBD
X-Google-Smtp-Source: ABdhPJzERHijcXGBjTizLrbvJuz4CCYCfVW96LQWzIIDzO445NjwhkHNujDFBQnjjnIQB6Atf/1YQw==
X-Received: by 2002:a17:902:e842:b0:142:dbc:bade with SMTP id t2-20020a170902e84200b001420dbcbademr75107587plg.45.1639134948281;
        Fri, 10 Dec 2021 03:15:48 -0800 (PST)
Received: from thinkpad ([202.21.42.75])
        by smtp.gmail.com with ESMTPSA id s19sm2944131pfu.104.2021.12.10.03.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 03:15:47 -0800 (PST)
Date:   Fri, 10 Dec 2021 16:45:41 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v2 04/10] PCI: qcom: Remove redundancy between qcom_pcie
 and qcom_pcie_cfg
Message-ID: <20211210111541.GD1734@thinkpad>
References: <20211208171442.1327689-1-dmitry.baryshkov@linaro.org>
 <20211208171442.1327689-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208171442.1327689-5-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 08, 2021 at 08:14:36PM +0300, Dmitry Baryshkov wrote:
> In preparation to adding more flags to configuration data, use struct
> qcom_pcie_cfg directly inside struct qcom_pcie, rather than duplicating
> all its fields. This would save us from the boilerplate code that just
> copies flags values from one sruct to another one.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 39 +++++++++++---------------
>  1 file changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 1c3d1116bb60..51a0475173fb 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -204,8 +204,7 @@ struct qcom_pcie {
>  	union qcom_pcie_resources res;
>  	struct phy *phy;
>  	struct gpio_desc *reset;
> -	const struct qcom_pcie_ops *ops;
> -	unsigned int pipe_clk_need_muxing:1;
> +	const struct qcom_pcie_cfg *cfg;

There is no change in this patch that adds "pipe_clk_need_muxing" to
qcom_pcie_cfg.

Thanks,
Mani

>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -229,8 +228,8 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
>  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>  
>  	/* Enable Link Training state machine */
> -	if (pcie->ops->ltssm_enable)
> -		pcie->ops->ltssm_enable(pcie);
> +	if (pcie->cfg->ops->ltssm_enable)
> +		pcie->cfg->ops->ltssm_enable(pcie);
>  
>  	return 0;
>  }
> @@ -1176,7 +1175,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (pcie->pipe_clk_need_muxing) {
> +	if (pcie->cfg->pipe_clk_need_muxing) {
>  		res->pipe_clk_src = devm_clk_get(dev, "pipe_mux");
>  		if (IS_ERR(res->pipe_clk_src))
>  			return PTR_ERR(res->pipe_clk_src);
> @@ -1209,7 +1208,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	}
>  
>  	/* Set TCXO as clock source for pcie_pipe_clk_src */
> -	if (pcie->pipe_clk_need_muxing)
> +	if (pcie->cfg->pipe_clk_need_muxing)
>  		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
>  
>  	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
> @@ -1284,7 +1283,7 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>  
>  	/* Set pipe clock as clock source for pcie_pipe_clk_src */
> -	if (pcie->pipe_clk_need_muxing)
> +	if (pcie->cfg->pipe_clk_need_muxing)
>  		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
>  
>  	return clk_prepare_enable(res->pipe_clk);
> @@ -1384,7 +1383,7 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  
>  	qcom_ep_reset_assert(pcie);
>  
> -	ret = pcie->ops->init(pcie);
> +	ret = pcie->cfg->ops->init(pcie);
>  	if (ret)
>  		return ret;
>  
> @@ -1392,16 +1391,16 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  	if (ret)
>  		goto err_deinit;
>  
> -	if (pcie->ops->post_init) {
> -		ret = pcie->ops->post_init(pcie);
> +	if (pcie->cfg->ops->post_init) {
> +		ret = pcie->cfg->ops->post_init(pcie);
>  		if (ret)
>  			goto err_disable_phy;
>  	}
>  
>  	qcom_ep_reset_deassert(pcie);
>  
> -	if (pcie->ops->config_sid) {
> -		ret = pcie->ops->config_sid(pcie);
> +	if (pcie->cfg->ops->config_sid) {
> +		ret = pcie->cfg->ops->config_sid(pcie);
>  		if (ret)
>  			goto err;
>  	}
> @@ -1410,12 +1409,12 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  
>  err:
>  	qcom_ep_reset_assert(pcie);
> -	if (pcie->ops->post_deinit)
> -		pcie->ops->post_deinit(pcie);
> +	if (pcie->cfg->ops->post_deinit)
> +		pcie->cfg->ops->post_deinit(pcie);
>  err_disable_phy:
>  	phy_power_off(pcie->phy);
>  err_deinit:
> -	pcie->ops->deinit(pcie);
> +	pcie->cfg->ops->deinit(pcie);
>  
>  	return ret;
>  }
> @@ -1531,7 +1530,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	struct pcie_port *pp;
>  	struct dw_pcie *pci;
>  	struct qcom_pcie *pcie;
> -	const struct qcom_pcie_cfg *pcie_cfg;
>  	int ret;
>  
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> @@ -1553,15 +1551,12 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->pci = pci;
>  
> -	pcie_cfg = of_device_get_match_data(dev);
> -	if (!pcie_cfg || !pcie_cfg->ops) {
> +	pcie->cfg = of_device_get_match_data(dev);
> +	if (!pcie->cfg || !pcie->cfg->ops) {
>  		dev_err(dev, "Invalid platform data\n");
>  		return -EINVAL;
>  	}
>  
> -	pcie->ops = pcie_cfg->ops;
> -	pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;
> -
>  	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
>  	if (IS_ERR(pcie->reset)) {
>  		ret = PTR_ERR(pcie->reset);
> @@ -1586,7 +1581,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_pm_runtime_put;
>  	}
>  
> -	ret = pcie->ops->get_resources(pcie);
> +	ret = pcie->cfg->ops->get_resources(pcie);
>  	if (ret)
>  		goto err_pm_runtime_put;
>  
> -- 
> 2.33.0
> 
