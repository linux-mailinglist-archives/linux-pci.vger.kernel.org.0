Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D632A46A670
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 20:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhLFUCu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 15:02:50 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57778 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhLFUCt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 15:02:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 52D01CE180A;
        Mon,  6 Dec 2021 19:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4CDC341C2;
        Mon,  6 Dec 2021 19:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638820757;
        bh=T4aB3iAFuCBw5bew9OWrYw7I9uaZkV0Nov/YMV/ousQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hggLGZuJBaglUu21+PxtOArN2IJpgSi1HzE1sLzsyjwdljoC7yy37JsKvtJy0Tx/R
         iFoaNcl/1BNcAqz1uPl/Xvzd7JDoczGU1Uw5wXdQoIZJM4KEKG+kzZ23nyGi3vGXFJ
         zjWXxhS61r//pEakBVNdmdBQFaPICzmVcKWlTbdYIC/289jNK0v8S9FUbhFmhd0hgl
         9anBPL+p1iE8E1pX8sTzzaDLx9Kgnh1Zt5wPpGaKEDg79lMCh71psuPSBYJBUftXpA
         lwsnk7qN9wPt/a4zUe4yPnF/b5dwavFbn6PspJ08/yFzVy9n/L8guX2Vb3EEHjH0o2
         j73cC02BYNXkQ==
Date:   Mon, 6 Dec 2021 13:59:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [PATCH v1 04/10] PCI: qcom: do not duplicate qcom_pcie_cfg
 fields in qcom_pcie struct
Message-ID: <20211206195915.GA6596@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202141726.1796793-5-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 02, 2021 at 05:17:20PM +0300, Dmitry Baryshkov wrote:
> In preparation to adding more flags to configuration data, use struct
> qcom_pcie_cfg directly inside struct qcom_pcie, rather than duplicating
> all its fields. This would save us from the boilerplate code that just
> copies flags values from one sruct to another one.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 34 ++++++++++++--------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 3bee901c4df7..64f762cdbc7d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -204,8 +204,7 @@ struct qcom_pcie {
>  	union qcom_pcie_resources res;
>  	struct phy *phy;
>  	struct gpio_desc *reset;
> -	const struct qcom_pcie_ops *ops;
> -	unsigned int pipe_clk_need_muxing:1;
> +	struct qcom_pcie_cfg cfg;

A common strategy is to simply save the pointer to the match data,
e.g.,

    struct imx6_pcie {
      ...
      const struct imx6_pcie_drvdata *drvdata;
    };

    imx6_pcie_probe()
      imx6_pcie->drvdata = of_device_get_match_data(dev);
    

    struct ls_pcie {
      ...
      const struct ls_pcie_drvdata *drvdata;
    };

    ls_pcie_probe()
      pcie->drvdata = of_device_get_match_data(dev);
    
    
    struct tegra_pcie {
      ...
      const struct tegra_pcie_soc *soc;
    };

    tegra_pcie_probe()
      pcie->soc = of_device_get_match_data(dev);
    

    struct mtk_pcie {
      ...
      const struct mtk_pcie_soc *soc;
    };

    mtk_pcie_probe()
      pcie->soc = of_device_get_match_data(dev);

Bonus points if you name the pointer the same, e.g., "soc" or maybe
"drvdata" (although this one is possibly confusing with
platform_set_drvdata(), which is something different).

>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -229,8 +228,8 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
>  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>  
>  	/* Enable Link Training state machine */
> -	if (pcie->ops->ltssm_enable)
> -		pcie->ops->ltssm_enable(pcie);
> +	if (pcie->cfg.ops->ltssm_enable)
> +		pcie->cfg.ops->ltssm_enable(pcie);
>  
>  	return 0;
>  }
> @@ -1176,7 +1175,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (pcie->pipe_clk_need_muxing) {
> +	if (pcie->cfg.pipe_clk_need_muxing) {
>  		res->pipe_clk_src = devm_clk_get(dev, "pipe_mux");
>  		if (IS_ERR(res->pipe_clk_src))
>  			return PTR_ERR(res->pipe_clk_src);
> @@ -1209,7 +1208,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	}
>  
>  	/* Set TCXO as clock source for pcie_pipe_clk_src */
> -	if (pcie->pipe_clk_need_muxing)
> +	if (pcie->cfg.pipe_clk_need_muxing)
>  		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
>  
>  	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
> @@ -1287,7 +1286,7 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>  
>  	/* Set pipe clock as clock source for pcie_pipe_clk_src */
> -	if (pcie->pipe_clk_need_muxing)
> +	if (pcie->cfg.pipe_clk_need_muxing)
>  		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
>  
>  	return clk_prepare_enable(res->pipe_clk);
> @@ -1387,7 +1386,7 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  
>  	qcom_ep_reset_assert(pcie);
>  
> -	ret = pcie->ops->init(pcie);
> +	ret = pcie->cfg.ops->init(pcie);
>  	if (ret)
>  		return ret;
>  
> @@ -1395,16 +1394,16 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  	if (ret)
>  		goto err_deinit;
>  
> -	if (pcie->ops->post_init) {
> -		ret = pcie->ops->post_init(pcie);
> +	if (pcie->cfg.ops->post_init) {
> +		ret = pcie->cfg.ops->post_init(pcie);
>  		if (ret)
>  			goto err_disable_phy;
>  	}
>  
>  	qcom_ep_reset_deassert(pcie);
>  
> -	if (pcie->ops->config_sid) {
> -		ret = pcie->ops->config_sid(pcie);
> +	if (pcie->cfg.ops->config_sid) {
> +		ret = pcie->cfg.ops->config_sid(pcie);
>  		if (ret)
>  			goto err;
>  	}
> @@ -1413,12 +1412,12 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  
>  err:
>  	qcom_ep_reset_assert(pcie);
> -	if (pcie->ops->post_deinit)
> -		pcie->ops->post_deinit(pcie);
> +	if (pcie->cfg.ops->post_deinit)
> +		pcie->cfg.ops->post_deinit(pcie);
>  err_disable_phy:
>  	phy_power_off(pcie->phy);
>  err_deinit:
> -	pcie->ops->deinit(pcie);
> +	pcie->cfg.ops->deinit(pcie);
>  
>  	return ret;
>  }
> @@ -1562,8 +1561,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	pcie->ops = pcie_cfg->ops;
> -	pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;
> +	pcie->cfg = *pcie_cfg;
>  
>  	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
>  	if (IS_ERR(pcie->reset)) {
> @@ -1589,7 +1587,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_pm_runtime_put;
>  	}
>  
> -	ret = pcie->ops->get_resources(pcie);
> +	ret = pcie->cfg.ops->get_resources(pcie);
>  	if (ret)
>  		goto err_pm_runtime_put;
>  
> -- 
> 2.33.0
> 
