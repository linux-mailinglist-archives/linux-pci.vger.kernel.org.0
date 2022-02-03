Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CF94A8976
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 18:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352604AbiBCRKC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 12:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352525AbiBCRJu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 12:09:50 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B68FC061744
        for <linux-pci@vger.kernel.org>; Thu,  3 Feb 2022 09:09:50 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id v67so5015651oie.9
        for <linux-pci@vger.kernel.org>; Thu, 03 Feb 2022 09:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dp+Q+BZVAFYUKDakoDDrpzKynjH1KfyR67RxEPsBMUQ=;
        b=X6RuS7hnFE8QuQc6ecdjMqJ+R578JtgLxsgVBJmE3PeHe8x5fQZXptZLzYUR+mDZvk
         ygetmkszh7JvJgXWgugdVCM/RRpYVmyOreWdafireVRIVW9FYuLhm9KoIisAIyvR6BEZ
         X2wKXoEJd34ewsB1/7COIOI9zdHY1lFPjh0O+iTOgztDukF6ZkkMEWC85znnOmHzqBnQ
         4jfb3aS/2pfRNHOlW6ZHBBNDOz/mVsY0sszrIENqPV6NHCRREZMQtoEOv0SDbO55VDnS
         xOpU2tFAFQA4vXhHZCTYwybTBQnLsmIZVMQfBflf77l4bvY89SdQqehmIPIsvUhURZLq
         a7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dp+Q+BZVAFYUKDakoDDrpzKynjH1KfyR67RxEPsBMUQ=;
        b=8OJgN5lFs8PTjTiUF3TDdDkEnxFQHtoXlLzQRja2RXB3JUv/hCM1/z+9QOmcvLIbqx
         znjPQAPsCLSDsQVaLbOgdU9yqbAJoj1tsjV0haLtJUmofWG3DMCrbRNRX4mV5CGGEYbe
         qYh1iL+CwFTca1dHGQ6jXCM5mCN9ApP5qdlLXkOA8BsIfmEy8mYriC26xyrHiLsoJwBh
         6WbcSeYcKf41QTDkSRRY0Hfa4x30bnLkobB144ZJbM8BFLWtyvfiol6Wtne9X2up3v2D
         13bTH4wbPiVoRpQJzWv/j/v86Ih3QsgvzldrQzfjysQeaZVYdAfxUmbkiU3ZmRui3X2h
         pyrw==
X-Gm-Message-State: AOAM530b3UGPRQ5WQUcS/EP5QZ3MbkeGm9UtaaFRosVTfDtiGv2Y51rD
        SU5gNHfiaJWb/3Beq/OkHEIVoQ==
X-Google-Smtp-Source: ABdhPJwiW154TEn1eBOojokeZf7L7OXCy0vVk/5RBOHgj1iBKXRk6RDh1M6hqoXLB69JlzZ5h/czDw==
X-Received: by 2002:aca:eb03:: with SMTP id j3mr8143556oih.43.1643908189732;
        Thu, 03 Feb 2022 09:09:49 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id z4sm14340958ota.7.2022.02.03.09.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:09:49 -0800 (PST)
Date:   Thu, 3 Feb 2022 09:10:06 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 5/5] PCI: qcom: Add SM8450 PCIe support
Message-ID: <YfwMbqG6ovrPbDhx@ripper>
References: <20211218141024.500952-1-dmitry.baryshkov@linaro.org>
 <20211218141024.500952-6-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218141024.500952-6-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat 18 Dec 06:10 PST 2021, Dmitry Baryshkov wrote:

> On SM8450 platform PCIe hosts do not use all the clocks (and add several
> additional clocks), so expand the driver to handle these requirements.
> 
> PCIe0 and PCIe1 hosts use different sets of clocks, so separate entries
> are required.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 57 ++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 55ac3caa6d7d..fe6ed1e0415a 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -161,7 +161,7 @@ struct qcom_pcie_resources_2_3_3 {
>  
>  /* 6 clocks typically, 7 for sm8250 */
>  struct qcom_pcie_resources_2_7_0 {
> -	struct clk_bulk_data clks[7];
> +	struct clk_bulk_data clks[9];
>  	int num_clks;
>  	struct regulator_bulk_data supplies[2];
>  	struct reset_control *pci_reset;
> @@ -193,7 +193,10 @@ struct qcom_pcie_ops {
>  struct qcom_pcie_cfg {
>  	const struct qcom_pcie_ops *ops;
>  	unsigned int pipe_clk_need_muxing:1;
> +	unsigned int has_tbu_clk:1;
>  	unsigned int has_ddrss_sf_tbu_clk:1;
> +	unsigned int has_aggre0_clk:1;
> +	unsigned int has_aggre1_clk:1;
>  };
>  
>  struct qcom_pcie {
> @@ -1117,6 +1120,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> +	unsigned int idx;
>  	int ret;
>  
>  	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
> @@ -1134,18 +1138,22 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	if (ret)
>  		return ret;
>  
> -	res->clks[0].id = "aux";
> -	res->clks[1].id = "cfg";
> -	res->clks[2].id = "bus_master";
> -	res->clks[3].id = "bus_slave";
> -	res->clks[4].id = "slave_q2a";
> -	res->clks[5].id = "tbu";
> -	if (pcie->cfg->has_ddrss_sf_tbu_clk) {
> -		res->clks[6].id = "ddrss_sf_tbu";
> -		res->num_clks = 7;
> -	} else {
> -		res->num_clks = 6;
> -	}
> +	idx = 0;
> +	res->clks[idx++].id = "aux";
> +	res->clks[idx++].id = "cfg";
> +	res->clks[idx++].id = "bus_master";
> +	res->clks[idx++].id = "bus_slave";
> +	res->clks[idx++].id = "slave_q2a";
> +	if (pcie->cfg->has_tbu_clk)
> +		res->clks[idx++].id = "tbu";
> +	if (pcie->cfg->has_ddrss_sf_tbu_clk)
> +		res->clks[idx++].id = "ddrss_sf_tbu";
> +	if (pcie->cfg->has_aggre0_clk)
> +		res->clks[idx++].id = "aggre0";
> +	if (pcie->cfg->has_aggre1_clk)
> +		res->clks[idx++].id = "aggre1";
> +
> +	res->num_clks = idx;
>  
>  	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
>  	if (ret < 0)
> @@ -1210,6 +1218,9 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  		goto err_disable_clocks;
>  	}
>  
> +	/* Wait for reset to complete, required on SM8450 */
> +	usleep_range(1000, 1500);
> +
>  	/* configure PCIe to RC mode */
>  	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
>  
> @@ -1457,15 +1468,33 @@ static const struct qcom_pcie_cfg ipq4019_cfg = {
>  
>  static const struct qcom_pcie_cfg sdm845_cfg = {
>  	.ops = &ops_2_7_0,
> +	.has_tbu_clk = true,
>  };
>  
>  static const struct qcom_pcie_cfg sm8250_cfg = {
> +	.ops = &ops_1_9_0,
> +	.has_tbu_clk = true,
> +	.has_ddrss_sf_tbu_clk = true,
> +};
> +
> +static const struct qcom_pcie_cfg sm8450_pcie0_cfg = {
>  	.ops = &ops_1_9_0,
>  	.has_ddrss_sf_tbu_clk = true,
> +	.pipe_clk_need_muxing = true,
> +	.has_aggre0_clk = true,
> +	.has_aggre1_clk = true,
> +};
> +
> +static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
> +	.ops = &ops_1_9_0,
> +	.has_ddrss_sf_tbu_clk = true,
> +	.pipe_clk_need_muxing = true,
> +	.has_aggre1_clk = true,
>  };
>  
>  static const struct qcom_pcie_cfg sc7280_cfg = {
>  	.ops = &ops_1_9_0,
> +	.has_tbu_clk = true,
>  	.pipe_clk_need_muxing = true,
>  };
>  
> @@ -1564,6 +1593,8 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sdm845", .data = &sdm845_cfg },
>  	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
>  	{ .compatible = "qcom,pcie-sc8180x", .data = &sm8250_cfg },
> +	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &sm8450_pcie0_cfg },
> +	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &sm8450_pcie1_cfg },
>  	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
>  	{ }
>  };
> -- 
> 2.34.1
> 
