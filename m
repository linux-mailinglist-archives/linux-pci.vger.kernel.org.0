Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EECE56C7FE
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 10:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiGIIYH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 04:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGIIYF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 04:24:05 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E8D21254
        for <linux-pci@vger.kernel.org>; Sat,  9 Jul 2022 01:24:04 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id o18so770023pgu.9
        for <linux-pci@vger.kernel.org>; Sat, 09 Jul 2022 01:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3gp/nn7TzypARR1HY0tBDLC61zrtXrd5JCPdj/Mvc70=;
        b=N/wwmsDdHpBDq0ftVTPt2g3Ij7VOBdzqX6RjoaQ+IMnMtRM9VtucOQtXhCBGlTnte8
         HyLOEYaZlJnVhxvjto8ctXriUTIaM4U5mqSzZ+Z5IL2/gInNq9W2biYoGGFgMw7U/mFZ
         tPfWqT8uYmGyv7Gje48QCNywm9ype7+w02OVWFkECxf5q0B6y0A7dJaVKmMKesr9BBNV
         fOjNkCkXlpRV8YPZ180ndSaLVNkNNo61Es3M1zLfZ2ojb8tWj4Fm4qCS/yh2Ac/sTQzS
         PZbJ0PI52lWDFSTMP2GQyDi1EHw05hc1jpvFl26/pJyj4PB/MUXEXkIVfKPOton0xelR
         uV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3gp/nn7TzypARR1HY0tBDLC61zrtXrd5JCPdj/Mvc70=;
        b=48OlV05AlNBOrnuBdD4t4Cn4zEHYLyiSvC+R/EwGCjeoyUrdEmTvIobU1TVoTtMxTS
         y86fHXofMHE9lFZ28GpKI6H0pC2KoHlX8Zrd5yOoqeAgyi+VBEzqGpC4csYxnJ+R8BNT
         Dp5zNs+Bu6F9YH1wHWr7h4iTlmQnuW35df3irMBQVJhA1CGBiiwaaer/JEINqnEIr/il
         /7qJjel73NYzf2Tcj1HWAlmHKyPKtQ5bS0bcHTnvEmpkBYr/yXv6n+zaqxuO1fL5qbns
         LKPQSNXT61w/CNavblWEzwN3VaujGW8zVauREsQzhOQWiRKCINvxuYnwHqHBTqPt98Xy
         /Cog==
X-Gm-Message-State: AJIora8rT38dKtgnWKO5uhOgFg215KeVUPxKzzn9XoNkwzsEDmIZTdna
        ZkupsS8sZLeRFs+XSoOeM56f
X-Google-Smtp-Source: AGRyM1vqFf1rz87+sr/2LMoPEXsknQv/uxV1HdkMlDUXB9PAQ/6oLtUzUZGwiSibD6yYNSKxXTcBVw==
X-Received: by 2002:a65:6e04:0:b0:40d:26eb:8225 with SMTP id bd4-20020a656e04000000b0040d26eb8225mr7026485pgb.138.1657355044065;
        Sat, 09 Jul 2022 01:24:04 -0700 (PDT)
Received: from thinkpad ([117.207.26.140])
        by smtp.gmail.com with ESMTPSA id l2-20020a17090a150200b001ef307e1deesm2898666pja.18.2022.07.09.01.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 01:24:03 -0700 (PDT)
Date:   Sat, 9 Jul 2022 13:53:53 +0530
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
Subject: Re: [PATCH 08/10] PCI: qcom: Make all optional clocks optional
Message-ID: <20220709082353.GO5063@thinkpad>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-9-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629141000.18111-9-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 29, 2022 at 04:09:58PM +0200, Johan Hovold wrote:
> The kernel is not a devicetree validator and does not need to re-encode
> information which is already available in the devicetree.
> 
> This is specifically true for the optional PCIe clocks, some of which
> are really interconnect clocks.
> 
> Treat also the 2.7.0 optional clocks as truly optional instead of
> maintaining a list of clocks per compatible (including two compatible
> strings for the two identical controllers on sm8450) just to validate
> the devicetree.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 28 ++++----------------------
>  1 file changed, 4 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 8ab88e5743da..1a564f624bb1 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -189,10 +189,6 @@ struct qcom_pcie_ops {
>  
>  struct qcom_pcie_cfg {
>  	const struct qcom_pcie_ops *ops;
> -	unsigned int has_tbu_clk:1;
> -	unsigned int has_ddrss_sf_tbu_clk:1;
> -	unsigned int has_aggre0_clk:1;
> -	unsigned int has_aggre1_clk:1;
>  };
>  
>  struct qcom_pcie {
> @@ -1140,14 +1136,6 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	res->clks[idx++].id = "bus_master";
>  	res->clks[idx++].id = "bus_slave";
>  	res->clks[idx++].id = "slave_q2a";
> -	if (pcie->cfg->has_tbu_clk)
> -		res->clks[idx++].id = "tbu";
> -	if (pcie->cfg->has_ddrss_sf_tbu_clk)
> -		res->clks[idx++].id = "ddrss_sf_tbu";
> -	if (pcie->cfg->has_aggre0_clk)
> -		res->clks[idx++].id = "aggre0";
> -	if (pcie->cfg->has_aggre1_clk)
> -		res->clks[idx++].id = "aggre1";
>  
>  	num_clks = idx;
>  
> @@ -1155,6 +1143,10 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	if (ret < 0)
>  		return ret;
>  
> +	res->clks[idx++].id = "tbu";
> +	res->clks[idx++].id = "ddrss_sf_tbu";
> +	res->clks[idx++].id = "aggre0";
> +	res->clks[idx++].id = "aggre1";
>  	res->clks[idx++].id = "noc_aggr_4";
>  	res->clks[idx++].id = "noc_aggr_south_sf";
>  	res->clks[idx++].id = "cnoc_qx";
> @@ -1463,17 +1455,14 @@ static const struct qcom_pcie_cfg ipq4019_cfg = {
>  
>  static const struct qcom_pcie_cfg sa8540p_cfg = {
>  	.ops = &ops_1_9_0,
> -	.has_ddrss_sf_tbu_clk = true,
>  };
>  
>  static const struct qcom_pcie_cfg sc8280xp_cfg = {
>  	.ops = &ops_1_9_0,
> -	.has_ddrss_sf_tbu_clk = true,
>  };
>  
>  static const struct qcom_pcie_cfg sdm845_cfg = {
>  	.ops = &ops_2_7_0,
> -	.has_tbu_clk = true,
>  };
>  
>  static const struct qcom_pcie_cfg sm8150_cfg = {
> @@ -1485,31 +1474,22 @@ static const struct qcom_pcie_cfg sm8150_cfg = {
>  
>  static const struct qcom_pcie_cfg sm8250_cfg = {
>  	.ops = &ops_1_9_0,
> -	.has_tbu_clk = true,
> -	.has_ddrss_sf_tbu_clk = true,
>  };
>  
>  static const struct qcom_pcie_cfg sm8450_pcie0_cfg = {
>  	.ops = &ops_1_9_0,
> -	.has_ddrss_sf_tbu_clk = true,
> -	.has_aggre0_clk = true,
> -	.has_aggre1_clk = true,
>  };
>  
>  static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
>  	.ops = &ops_1_9_0,
> -	.has_ddrss_sf_tbu_clk = true,
> -	.has_aggre1_clk = true,
>  };
>  
>  static const struct qcom_pcie_cfg sc7280_cfg = {
>  	.ops = &ops_1_9_0,
> -	.has_tbu_clk = true,
>  };
>  
>  static const struct qcom_pcie_cfg sc8180x_cfg = {
>  	.ops = &ops_1_9_0,
> -	.has_tbu_clk = true,
>  };
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
