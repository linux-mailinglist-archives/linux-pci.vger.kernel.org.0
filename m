Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966F346FFE1
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 12:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240478AbhLJLeP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 06:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240451AbhLJLeO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 06:34:14 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FA9C061746
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 03:30:40 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so9211915pjb.5
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 03:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mf7EFsdPh5sDDWteoiVVZdM8qPQLJMGyfkrlgZ74xeY=;
        b=HThkS3HbsJBlF2DX5Z9qMXGASrSSCSbcTk1HDtf+7uzIQ8lnNJaRWittq9kY0BQ4TS
         Oy478dfdZF1jGmL2kKwIM5QWccFEA0ekfRjvntK1nX+79MlXJbghKgBFqfQk5RwUrnhu
         WZbEVu2sAsLZR6bopF256YMXASTMBRY7Q5CFHuDYZXav6pBdgX7czSjFEGkJMkT6zLPU
         XXE8PlWukszoNseRcJMWrD2UbVtjUo7makUk43A+SS39uKWZHQ748QDzsh3y1JkqJK99
         uwrIo8SPDGAd4jJ5SM9DPuKy5kuT2pc0tOhUVjtyqsFCcAxrqIwSJ1D2l42NTA1ywLlc
         gv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mf7EFsdPh5sDDWteoiVVZdM8qPQLJMGyfkrlgZ74xeY=;
        b=ImRvQZF2XgEDksFtJ6GovE+E9wLrP7gh8Imu8N8jEcBjaxYAkImirQH23bwfHaTGGe
         VwcQXQm6wja1PCanYHtgv12ZoqG5IaFMNZj3D1upgkMMXlP1s2NhGu8fbivpe9rBUsru
         Xsl6OfBkX1hlnSbAZEO8q4yqn9SzQQI1ND5RHuqYpeDySDRD3rzERpd3+Okv0reTRTrg
         KHFw0YmyuJyzq+DfBjCbQTXpG2Yd6UmXaVeIicXROUke2dI7oEll/0wrm6Coy1QnPcp7
         s3NhWJIl3T2IohHhuoawiweNHStb4yx+SAfAh/0T/alOAnl7QUv4F71iA+tflb6Tu/yo
         IM0w==
X-Gm-Message-State: AOAM5307RxuIZgqf/MHnw2FMF4tkuUa4LCcAtYm61Ny38jK04XVcGUkU
        r3ymG9xjvClWxfXqt+45uEch
X-Google-Smtp-Source: ABdhPJzzW3+g14DNBEC2/eMHzu4q8zNdxPCQFcBzEoA9TpbXUIjeKvrwxO/S/qr8v/dl9cj1ngVgpw==
X-Received: by 2002:a17:90a:fd13:: with SMTP id cv19mr23371091pjb.54.1639135839629;
        Fri, 10 Dec 2021 03:30:39 -0800 (PST)
Received: from thinkpad ([202.21.42.75])
        by smtp.gmail.com with ESMTPSA id a26sm2834527pfh.161.2021.12.10.03.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 03:30:39 -0800 (PST)
Date:   Fri, 10 Dec 2021 17:00:31 +0530
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
Subject: Re: [PATCH v2 06/10] PCI: qcom: Add SM8450 PCIe support
Message-ID: <20211210113031.GF1734@thinkpad>
References: <20211208171442.1327689-1-dmitry.baryshkov@linaro.org>
 <20211208171442.1327689-7-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208171442.1327689-7-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 08, 2021 at 08:14:38PM +0300, Dmitry Baryshkov wrote:
> On SM8450 platform PCIe hosts do not use all the clocks (and add several
> additional clocks), so expand the driver to handle these requirements.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 47 +++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 803d3ac18c56..ada9c816395d 100644
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
> @@ -196,7 +196,10 @@ struct qcom_pcie_cfg {
>  	const struct qcom_pcie_ops *ops;
>  	/* flags for ops 2.7.0 and 1.9.0 */
>  	unsigned int pipe_clk_need_muxing:1;
> +	unsigned int has_tbu_clk:1;
>  	unsigned int has_ddrss_sf_tbu_clk:1;
> +	unsigned int has_aggre0_clk:1;
> +	unsigned int has_aggre1_clk:1;
>  };
>  
>  struct qcom_pcie {
> @@ -1147,6 +1150,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> +	unsigned int idx;

u32?

>  	int ret;
>  
>  	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
> @@ -1160,18 +1164,22 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
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

res->num_clks = idx + 1?

Thanks,
Mani

>  
>  	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
>  	if (ret < 0)
> @@ -1510,15 +1518,27 @@ static const struct qcom_pcie_cfg ipq4019_cfg = {
>  
>  static const struct qcom_pcie_cfg sdm845_cfg = {
>  	.ops = &ops_2_7_0,
> +	.has_tbu_clk = true,
>  };
>  
>  static const struct qcom_pcie_cfg sm8250_cfg = {
>  	.ops = &ops_1_9_0,
> +	.has_tbu_clk = true,
>  	.has_ddrss_sf_tbu_clk = true,
>  };
>  
> +/* Only for the PCIe0! */
> +static const struct qcom_pcie_cfg sm8450_cfg = {
> +	.ops = &ops_1_9_0,
> +	.has_ddrss_sf_tbu_clk = true,
> +	.pipe_clk_need_muxing = true,
> +	.has_aggre0_clk = true,
> +	.has_aggre1_clk = true,
> +};
> +
>  static const struct qcom_pcie_cfg sc7280_cfg = {
>  	.ops = &ops_1_9_0,
> +	.has_tbu_clk = true,
>  	.pipe_clk_need_muxing = true,
>  };
>  
> @@ -1626,6 +1646,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sdm845", .data = &sdm845_cfg },
>  	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
>  	{ .compatible = "qcom,pcie-sc8180x", .data = &sm8250_cfg },
> +	{ .compatible = "qcom,pcie-sm8450", .data = &sm8450_cfg },
>  	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
>  	{ }
>  };
> -- 
> 2.33.0
> 
