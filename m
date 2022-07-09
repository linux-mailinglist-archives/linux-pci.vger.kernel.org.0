Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B9A56C7ED
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 10:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiGIISq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 04:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGIISo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 04:18:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77961F627
        for <linux-pci@vger.kernel.org>; Sat,  9 Jul 2022 01:18:42 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w185so891795pfb.4
        for <linux-pci@vger.kernel.org>; Sat, 09 Jul 2022 01:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lo5qSW9ZcTBTZWvGTZJ0zL849GtjejbOaEBQBDMz6f8=;
        b=fHOJQIjBVaw67g+k2a+N6+6+/mIs3rAdzTSi8iOwafN7ABxy6fqZRsFlcBQXXlHVrR
         0UIFYYgbmeAvRXyp2MaXBHSSTBaDgw7RWcXCgAxEwHN5EwD4dQs71ji0A6iUJcY+A1W7
         cYSyBFQ8nwuwZs4KweZDnPq2AYHMLxohbDsbCzLuYys2jrpI5hiBOre2FOjqMMgxuVfv
         YX7ghkpgUwZOLPPeWL8xUzi5eCnIaxVfvkezp0alIDb7+SEh4exGJ/rKAdXZjMjn29V2
         iyYZuTJwsCbpQWh2nD7KHCAspV9JSWvG2WtHMDYbjBTMrAEhqPW9ARfklCRvE0uZM7F/
         mcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lo5qSW9ZcTBTZWvGTZJ0zL849GtjejbOaEBQBDMz6f8=;
        b=gogP0ZsoHtTUIx1Cx8WfBUp2TZnbMWQdpUrJ51WpmWruQqabcFfDbljAXcwrcuecPO
         KI0HyDkBcToLosp4kP+3xJOiIg79NhugEC/oyGWC/rfd5Pm5EkZTAX/0O8c5DziGiHFl
         raN6OrMiM1CqgIyPp67MXrjSCO24+vcZ3Xd4qNpXo0zKXKtAfz5uRBnmCj+JV2kEa7yC
         ZsAVSWzsEUshQhabw7jDRf/6fhnxEnlcvmWlYlQjMd4p/Zal+sMD3X0Akr/udyVxxMKR
         OrKl+gyLYHPusevZes9kMeAz/Ftp3BDASldSVZSh7CIkfIROswcBgA5oabXcsZki58fC
         lsqA==
X-Gm-Message-State: AJIora9JQNqea0/kZtUlhXhpL67502W2UTR5F3h/cdfhy/Shyx45sMkk
        4ONJE8tkkAoMbpVKTe5/IC0q
X-Google-Smtp-Source: AGRyM1u/7JAK7eq81T8Bre1OXsxdl6IhUPQxzfPJuLtOUUGSsLHdKGfWtdDoiytRH4GgiYEXmrqDXg==
X-Received: by 2002:a63:cc53:0:b0:40d:bf0e:21a4 with SMTP id q19-20020a63cc53000000b0040dbf0e21a4mr6592489pgi.162.1657354722265;
        Sat, 09 Jul 2022 01:18:42 -0700 (PDT)
Received: from thinkpad ([117.207.26.140])
        by smtp.gmail.com with ESMTPSA id g21-20020a170902d5d500b0016b8bec1ed9sm791976plh.93.2022.07.09.01.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 01:18:42 -0700 (PDT)
Date:   Sat, 9 Jul 2022 13:48:34 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] PCI: qcom: Add support for SC8280XP
Message-ID: <20220709081834.GM5063@thinkpad>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-7-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629141000.18111-7-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 29, 2022 at 04:09:56PM +0200, Johan Hovold wrote:
> The SC8280XP platform has seven PCIe controllers: two used with USB4,
> two 4-lane, two 2-lane and one 1-lane.
> 
> Add a new "qcom,pcie-sc8280xp" compatible string and reuse the 1.9.0
> ops.
> 
> Note that the SC8280XP controllers need two or three interconnect
> clocks to be enabled. Model these as optional clocks to avoid encoding
> devicetree data in the PCIe driver.
> 

There isn't much info available for these clocks. Since some of these types of
clocks are already present in bindings, I think this patch is fine by itself.

I will also try to find how these clocks are laid out. But that shouldn't stop
this patch IMO.

> Note that the same could be done for the SM8450 interconnect clocks and
> possibly also for the TBU clocks.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ff1b40f213c1..da3f1cdc4ba6 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -160,7 +160,7 @@ struct qcom_pcie_resources_2_3_3 {
>  
>  /* 6 clocks typically, 7 for sm8250 */
>  struct qcom_pcie_resources_2_7_0 {
> -	struct clk_bulk_data clks[9];
> +	struct clk_bulk_data clks[12];
>  	int num_clks;
>  	struct regulator_bulk_data supplies[2];
>  	struct reset_control *pci_reset;
> @@ -1119,6 +1119,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> +	unsigned int num_clks, num_opt_clks;
>  	unsigned int idx;
>  	int ret;
>  
> @@ -1148,9 +1149,20 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	if (pcie->cfg->has_aggre1_clk)
>  		res->clks[idx++].id = "aggre1";
>  
> +	num_clks = idx;
> +
> +	ret = devm_clk_bulk_get(dev, num_clks, res->clks);
> +	if (ret < 0)
> +		return ret;
> +
> +	res->clks[idx++].id = "noc_aggr_4";
> +	res->clks[idx++].id = "noc_aggr_south_sf";
> +	res->clks[idx++].id = "cnoc_qx";
> +
> +	num_opt_clks = idx - num_clks;
>  	res->num_clks = idx;
>  
> -	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
> +	ret = devm_clk_bulk_get_optional(dev, num_opt_clks, res->clks + num_clks);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -1449,6 +1461,11 @@ static const struct qcom_pcie_cfg ipq4019_cfg = {
>  	.ops = &ops_2_4_0,
>  };
>  
> +static const struct qcom_pcie_cfg sc8280xp_cfg = {
> +	.ops = &ops_1_9_0,
> +	.has_ddrss_sf_tbu_clk = true,
> +};
> +
>  static const struct qcom_pcie_cfg sdm845_cfg = {
>  	.ops = &ops_2_7_0,
>  	.has_tbu_clk = true,
> @@ -1613,6 +1630,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sm8150", .data = &sm8150_cfg },
>  	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
>  	{ .compatible = "qcom,pcie-sc8180x", .data = &sc8180x_cfg },
> +	{ .compatible = "qcom,pcie-sc8280xp", .data = &sc8280xp_cfg },
>  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &sm8450_pcie0_cfg },
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &sm8450_pcie1_cfg },
>  	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
