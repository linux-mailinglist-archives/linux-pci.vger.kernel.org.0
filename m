Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C0B41B3B9
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 18:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241689AbhI1QXa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 12:23:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241662AbhI1QXa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Sep 2021 12:23:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 136C660F5B;
        Tue, 28 Sep 2021 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632846110;
        bh=pMo9KK5doUM7+rvpr+8DStF/6cDzZLGEDqhBIksnBAQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ee30XMTJzmJ1Ftatpaxcg4q3jAMMSRDOc8lPLaCJQxAToLAS94K6U9ENweBWVt14q
         5So91pbyf1uxyWPdlrnpc1yAUIMFf7Yu/sEzRZffwEmRAh7cF5+i5+CTzlnZ7IrPuG
         dQ9EI0fxgC1qDuF+l1gHAVXdKyEZ256oQfemwVyY7GLAYW5ByeLv70gP6b35UFUmkL
         NezpBoDwasqRDcYg59nnhwXmRi9dhAvMvBn7V+u0+viHC4wcIGsXq754MviH5sfg5E
         OzTRIEJQXnP2TLNVuA8rE+qBdlznwVwYpXDxot7R6/NPcuFbFrRr1rLmeu1I1+DB3k
         UX4wiMUpNIGYQ==
Date:   Tue, 28 Sep 2021 11:21:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Prasad Malisetty <pmaliset@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, swboyd@chromium.org, lorenzo.pieralisi@arm.com,
        svarbanov@mm-sol.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        mka@chromium.org, vbadigan@codeaurora.org, sallenki@codeaurora.org,
        manivannan.sadhasivam@linaro.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 4/4] PCI: qcom: Switch pcie_1_pipe_clk_src after PHY
 init in SC7280
Message-ID: <20210928162148.GA701581@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632837350-12100-5-git-send-email-pmaliset@codeaurora.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci; please cc drivers/pci changes there]

On Tue, Sep 28, 2021 at 07:25:50PM +0530, Prasad Malisetty wrote:
> On the SC7280, the clock source for gcc_pcie_1_pipe_clk_src
> must be the TCXO while gdsc is enabled. After PHY init successful
> clock source should switch to pipe clock for gcc_pcie_1_pipe_clk_src.

This looks good.  Ideally the commit log would say what the patch
*does*.  I know it's in the subject, but it's nice to have it both
places so the body is complete in itself.

Again in an ideal world, I would split this into two patches:

  1) Do the boilerplate conversions to struct qcom_pcie_cfg and
  updates of qcom_pcie_match[].  This patch would have no functional
  change.

  2) Add the code to deal with pcie_1_pipe_clk_src, which should be a
  much smaller patch.

This makes it easier to see the important part of dealing with
pcie_1_pipe_clk_src and makes any future bisect much more specific.

> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 94 ++++++++++++++++++++++++++++++----
>  1 file changed, 83 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 8a7a300..7896a86 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -166,6 +166,9 @@ struct qcom_pcie_resources_2_7_0 {
>  	struct regulator_bulk_data supplies[2];
>  	struct reset_control *pci_reset;
>  	struct clk *pipe_clk;
> +	struct clk *pipe_clk_src;
> +	struct clk *phy_pipe_clk;
> +	struct clk *ref_clk_src;
>  };
>  
>  union qcom_pcie_resources {
> @@ -189,6 +192,11 @@ struct qcom_pcie_ops {
>  	int (*config_sid)(struct qcom_pcie *pcie);
>  };
>  
> +struct qcom_pcie_cfg {
> +	const struct qcom_pcie_ops *ops;
> +	unsigned int pipe_clk_need_muxing:1;
> +};
> +
>  struct qcom_pcie {
>  	struct dw_pcie *pci;
>  	void __iomem *parf;			/* DT parf */
> @@ -197,6 +205,7 @@ struct qcom_pcie {
>  	struct phy *phy;
>  	struct gpio_desc *reset;
>  	const struct qcom_pcie_ops *ops;
> +	unsigned int pipe_clk_need_muxing:1;
>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -1167,6 +1176,20 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	if (ret < 0)
>  		return ret;
>  
> +	if (pcie->pipe_clk_need_muxing) {
> +		res->pipe_clk_src = devm_clk_get(dev, "pipe_mux");
> +		if (IS_ERR(res->pipe_clk_src))
> +			return PTR_ERR(res->pipe_clk_src);
> +
> +		res->phy_pipe_clk = devm_clk_get(dev, "phy_pipe");
> +		if (IS_ERR(res->phy_pipe_clk))
> +			return PTR_ERR(res->phy_pipe_clk);
> +
> +		res->ref_clk_src = devm_clk_get(dev, "ref");
> +		if (IS_ERR(res->ref_clk_src))
> +			return PTR_ERR(res->ref_clk_src);
> +	}
> +
>  	res->pipe_clk = devm_clk_get(dev, "pipe");
>  	return PTR_ERR_OR_ZERO(res->pipe_clk);
>  }
> @@ -1185,6 +1208,10 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  		return ret;
>  	}
>  
> +	/* Set TCXO as clock source for pcie_pipe_clk_src */
> +	if (pcie->pipe_clk_need_muxing)
> +		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
> +
>  	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
>  	if (ret < 0)
>  		goto err_disable_regulators;
> @@ -1256,6 +1283,10 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  {
>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>  
> +	/* Set pipe clock as clock source for pcie_pipe_clk_src */
> +	if (pcie->pipe_clk_need_muxing)
> +		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
> +
>  	return clk_prepare_enable(res->pipe_clk);
>  }
>  
> @@ -1456,6 +1487,39 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>  	.config_sid = qcom_pcie_config_sid_sm8250,
>  };
>  
> +static const struct qcom_pcie_cfg apq8084_cfg = {
> +	.ops = &ops_1_0_0,
> +};
> +
> +static const struct qcom_pcie_cfg ipq8064_cfg = {
> +	.ops = &ops_2_1_0,
> +};
> +
> +static const struct qcom_pcie_cfg msm8996_cfg = {
> +	.ops = &ops_2_3_2,
> +};
> +
> +static const struct qcom_pcie_cfg ipq8074_cfg = {
> +	.ops = &ops_2_3_3,
> +};
> +
> +static const struct qcom_pcie_cfg ipq4019_cfg = {
> +	.ops = &ops_2_4_0,
> +};
> +
> +static const struct qcom_pcie_cfg sdm845_cfg = {
> +	.ops = &ops_2_7_0,
> +};
> +
> +static const struct qcom_pcie_cfg sm8250_cfg = {
> +	.ops = &ops_1_9_0,
> +};
> +
> +static const struct qcom_pcie_cfg sc7280_cfg = {
> +	.ops = &ops_1_9_0,
> +	.pipe_clk_need_muxing = true,
> +};
> +
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = qcom_pcie_link_up,
>  	.start_link = qcom_pcie_start_link,
> @@ -1467,6 +1531,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	struct pcie_port *pp;
>  	struct dw_pcie *pci;
>  	struct qcom_pcie *pcie;
> +	const struct qcom_pcie_cfg *pcie_cfg;
>  	int ret;
>  
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> @@ -1488,7 +1553,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->pci = pci;
>  
> -	pcie->ops = of_device_get_match_data(dev);
> +	pcie_cfg = of_device_get_match_data(dev);
> +	pcie->ops = pcie_cfg->ops;
> +	if (!pcie->ops) {
> +		dev_err(dev, "Invalid platform data\n");
> +		return -EINVAL;
> +	}
> +	pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;
>  
>  	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
>  	if (IS_ERR(pcie->reset)) {
> @@ -1545,16 +1616,17 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id qcom_pcie_match[] = {
> -	{ .compatible = "qcom,pcie-apq8084", .data = &ops_1_0_0 },
> -	{ .compatible = "qcom,pcie-ipq8064", .data = &ops_2_1_0 },
> -	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &ops_2_1_0 },
> -	{ .compatible = "qcom,pcie-apq8064", .data = &ops_2_1_0 },
> -	{ .compatible = "qcom,pcie-msm8996", .data = &ops_2_3_2 },
> -	{ .compatible = "qcom,pcie-ipq8074", .data = &ops_2_3_3 },
> -	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
> -	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
> -	{ .compatible = "qcom,pcie-sdm845", .data = &ops_2_7_0 },
> -	{ .compatible = "qcom,pcie-sm8250", .data = &ops_1_9_0 },
> +	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
> +	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
> +	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &ipq8064_cfg },
> +	{ .compatible = "qcom,pcie-apq8064", .data = &ipq8064_cfg },
> +	{ .compatible = "qcom,pcie-msm8996", .data = &msm8996_cfg },
> +	{ .compatible = "qcom,pcie-ipq8074", .data = &ipq8074_cfg },
> +	{ .compatible = "qcom,pcie-ipq4019", .data = &ipq4019_cfg },
> +	{ .compatible = "qcom,pcie-qcs404", .data = &ipq4019_cfg },
> +	{ .compatible = "qcom,pcie-sdm845", .data = &sdm845_cfg },
> +	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
> +	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
>  	{ }
>  };
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
