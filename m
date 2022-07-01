Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A473563921
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 20:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiGAS3O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 14:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGAS3N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 14:29:13 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01A6220F7;
        Fri,  1 Jul 2022 11:29:12 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id i17so1902721ils.12;
        Fri, 01 Jul 2022 11:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/3e6AZaFiXYb4YbnsmFTEk9K1NTwzkBROYYE+v5p2ZI=;
        b=Z5q+sLRiSWAVT4ZT28Qmc4ZRlSUMtWRchgiMxf4CiDkR9mplwIkHj4SoTGkUdb+FNl
         /yIdLNB1H6qzJUmsvNcZR0ZPUw720+FvDSUiwkgXVF+wyg49pPxLf4xSIiqV2KqGBwFN
         QGYs4heB1N4rH2XghlD/JiSPj38YoEOXdEkCohiJrK/DEWjDU2xUcRatFR6cz0lCDw5r
         zc6OOXSYFPN3W2L7eOzOjcdJL05yNkIXgb/y+NpGOzPtfg06ad+7JLKhuuSHvBMr0v+U
         +/uCWKBC0X3LJ11GrGk2cywk6FZi7IGF7kstZT4jqHUrzQLYqSV3ZyWFDH8pl8Ii3ojo
         SAHA==
X-Gm-Message-State: AJIora/0B1erIeddVBaDxTzHmt9b/v10cgIU3SyWGe4paH9S1dX2S69E
        8qB85EKTmVVGtoWd+BlPlA==
X-Google-Smtp-Source: AGRyM1tTOiSo4oXi5cL/Xm3k+ov14bukraMZbiKTiHKfeplJ9zO8ijx527DNmqCk8dP114dY/VX1Qg==
X-Received: by 2002:a05:6e02:184d:b0:2da:ca66:76f6 with SMTP id b13-20020a056e02184d00b002daca6676f6mr8442812ilv.128.1656700151765;
        Fri, 01 Jul 2022 11:29:11 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p70-20020a022949000000b00339d2cd8da1sm10023783jap.152.2022.07.01.11.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 11:29:11 -0700 (PDT)
Received: (nullmailer pid 1274357 invoked by uid 1000);
        Fri, 01 Jul 2022 18:29:09 -0000
Date:   Fri, 1 Jul 2022 12:29:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] PCI: qcom: Add support for SC8280XP
Message-ID: <20220701182909.GA1266081-robh@kernel.org>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-7-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629141000.18111-7-johan+linaro@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
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

Shouldn't the interconnect binding handle these? Probably, bus clocks 
have to be the biggest single reason why clocks are such a mess in terms 
of 'the same' block having different clocks.

> 
> Note that the same could be done for the SM8450 interconnect clocks and
> possibly also for the TBU clocks.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
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
> 
