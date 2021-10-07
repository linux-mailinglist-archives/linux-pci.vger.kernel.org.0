Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E73E425B63
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 21:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243799AbhJGTPB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 15:15:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233879AbhJGTPB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 15:15:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 433A260F23;
        Thu,  7 Oct 2021 19:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633633986;
        bh=4097i7mkFkqGG7g6bmJrh8yORC7/TSKWh6X6Z6f10a8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PAW7l7d+uZ/uWAbylFNHh7bfq4jdELPttvGO0mPiMMM7jV3YRMIcNp8m6qVATu0qA
         e+3Xmr1sEvqzA9ww/tVvPj93ZR6u0X7F3iDfcdcWtGw89juUigk2q9KbvXXCN2HRIJ
         LD9hahvTR136Q83ZBxxA4b3qoLBgYxrv7236PtPtZCyLAPD6KyFi04VSiG8O0QQSrt
         ao3Pi07O4Zcjwm/s37c4/NsB9eDUArdO/HPfBIih1LkHKmGMo24lAF57paB1pAP49a
         UrhLLUzQGVwumGu7L1Pf85Yh4ipTiX3hso7CTmA3JTDovpos7y/7Pvb1N5PGEd4GyC
         9JOh66/bkHhag==
Date:   Thu, 7 Oct 2021 14:13:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Prasad Malisetty <pmaliset@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, swboyd@chromium.org, lorenzo.pieralisi@arm.com,
        svarbanov@mm-sol.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        mka@chromium.org, vbadigan@codeaurora.org, sallenki@codeaurora.org,
        manivannan.sadhasivam@linaro.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v12 5/5] PCI: qcom: Switch pcie_1_pipe_clk_src after PHY
 init in SC7280
Message-ID: <20211007191304.GA1256620@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633628923-25047-6-git-send-email-pmaliset@codeaurora.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 07, 2021 at 11:18:43PM +0530, Prasad Malisetty wrote:
> On the SC7280, the clock source for gcc_pcie_1_pipe_clk_src
> must be the TCXO while gdsc is enabled. After PHY init successful
> clock source should switch to pipe clock for gcc_pcie_1_pipe_clk_src.
> 
> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Thanks a lot for sorting out the patch 4/5 and 5/5 contents!

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 41132dd..ded70e6 100644
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
> @@ -191,6 +194,7 @@ struct qcom_pcie_ops {
>  
>  struct qcom_pcie_cfg {
>  	const struct qcom_pcie_ops *ops;
> +	unsigned int pipe_clk_need_muxing:1;
>  };
>  
>  struct qcom_pcie {
> @@ -201,6 +205,7 @@ struct qcom_pcie {
>  	struct phy *phy;
>  	struct gpio_desc *reset;
>  	const struct qcom_pcie_ops *ops;
> +	unsigned int pipe_clk_need_muxing:1;
>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -1171,6 +1176,20 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
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
> @@ -1189,6 +1208,10 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
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
> @@ -1260,6 +1283,10 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
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
> @@ -1490,6 +1517,7 @@ static const struct qcom_pcie_cfg sm8250_cfg = {
>  
>  static const struct qcom_pcie_cfg sc7280_cfg = {
>  	.ops = &ops_1_9_0,
> +	.pipe_clk_need_muxing = true,
>  };
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
> @@ -1532,6 +1560,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	}
>  
>  	pcie->ops = pcie_cfg->ops;
> +	pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;
>  
>  	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
>  	if (IS_ERR(pcie->reset)) {
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
