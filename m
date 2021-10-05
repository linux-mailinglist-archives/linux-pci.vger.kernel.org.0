Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DE24230B6
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 21:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbhJETXZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 15:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235361AbhJETXY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 15:23:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA57761154;
        Tue,  5 Oct 2021 19:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633461693;
        bh=M62TAUo+09n/pFjm3mE9/03lQLtfj7sPmGMZwJ6g/bA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ql+LqFMIoFiVmsk2GVJiJC/64iVnAjQjwndueuqwbKdSVeiEnuh+YfbXn8j/2/RAi
         y/dn9eLG4VCUEphU8AgVjSoqf0Ixg4AWMDsDRY3PSa3d99ya8O/IdqYKbxWF4tbJ9Q
         ccJ7su+bSpUIPmnEWqVSFwOvjA7xnb2OiPxoECAt1yvogP10qH7ATPF+ZtWEfR7ZEi
         UMkBzXk2jlAdJtMB5qcFnnMKHvUNr4QXOod2rL8u73IP3Kb30VcYIXnI6SCfXVHTxE
         P+e7DdAlqO4NzuQiymtOgExlzeNObIwfaZ8gc3hjYI/ZtcDiaIFsAFvvivRS1+WFV2
         WxoehdS+fH6Mg==
Date:   Tue, 5 Oct 2021 14:21:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Prasad Malisetty <pmaliset@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, swboyd@chromium.org, lorenzo.pieralisi@arm.com,
        svarbanov@mm-sol.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        mka@chromium.org, vbadigan@codeaurora.org, sallenki@codeaurora.org,
        manivannan.sadhasivam@linaro.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v11 4/5] PCI: qcom: Add a flag in match data along with
 ops
Message-ID: <20211005192131.GA1111392@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633459359-31517-5-git-send-email-pmaliset@codeaurora.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 06, 2021 at 12:12:38AM +0530, Prasad Malisetty wrote:
> Add pipe_clk_need_muxing flag in match data and configure
> If the platform needs to switch pipe_clk_src.
> 
> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 70 ++++++++++++++++++++++++++++------
>  1 file changed, 59 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 8a7a300..1d7a9cb 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -189,6 +189,11 @@ struct qcom_pcie_ops {
>  	int (*config_sid)(struct qcom_pcie *pcie);
>  };
>  
> +struct qcom_pcie_cfg {
> +	const struct qcom_pcie_ops *ops;
> +	unsigned int pipe_clk_need_muxing:1;
> +};

Thanks for splitting this up; it's 90% of the way there.

It would be better if this patch added only the definition and use of
qcom_pcie_cfg:

  +struct qcom_pcie_cfg {
  +     const struct qcom_pcie_ops *ops;
  +};

and then the subsequent patch added the clock muxing stuff:

   struct qcom_pcie_cfg {
  +	unsigned int pipe_clk_need_muxing:1;

   struct qcom_pcie {
  +	unsigned int pipe_clk_need_muxing:1;

   static const struct qcom_pcie_cfg sc7280_cfg = {
  +	.pipe_clk_need_muxing = true,

  static int qcom_pcie_probe(struct platform_device *pdev)
  +	pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;

That way everything related to pipe_clk_need_muxing would be in a
single patch.

>  struct qcom_pcie {
>  	struct dw_pcie *pci;
>  	void __iomem *parf;			/* DT parf */
> @@ -197,6 +202,7 @@ struct qcom_pcie {
>  	struct phy *phy;
>  	struct gpio_desc *reset;
>  	const struct qcom_pcie_ops *ops;
> +	unsigned int pipe_clk_need_muxing:1;
>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -1456,6 +1462,39 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
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
> @@ -1467,6 +1506,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	struct pcie_port *pp;
>  	struct dw_pcie *pci;
>  	struct qcom_pcie *pcie;
> +	const struct qcom_pcie_cfg *pcie_cfg;
>  	int ret;
>  
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> @@ -1488,7 +1528,14 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->pci = pci;
>  
> -	pcie->ops = of_device_get_match_data(dev);
> +	pcie_cfg = of_device_get_match_data(dev);
> +	if (!pcie_cfg || !pcie_cfg->ops) {
> +		dev_err(dev, "Invalid platform data\n");
> +		return NULL;
> +	}
> +
> +	pcie->ops = pcie_cfg->ops;
> +	pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;
>  
>  	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
>  	if (IS_ERR(pcie->reset)) {
> @@ -1545,16 +1592,17 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
