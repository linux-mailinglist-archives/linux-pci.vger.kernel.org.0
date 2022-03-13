Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F014D7709
	for <lists+linux-pci@lfdr.de>; Sun, 13 Mar 2022 18:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiCMRIV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Mar 2022 13:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbiCMRIV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Mar 2022 13:08:21 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09A4124C35
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2022 10:07:12 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso17376971ooi.1
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2022 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G3i0QYjUd9DxZkqdj4EfuBQknvXbN2Xgak73Yimrolk=;
        b=P7tPdGH0Q7HXZS2rDPX/GZMNX/N3gulew7hoebGwjGqH4RPi/3snnm4jhGZBxhU41R
         wxcpbOTEad1jEADU8c1KFxosrRo72iGL1nXioEXon87sYOIUCNbZy4PB4lR6jc1iuawc
         ArAno8zB31O1pKtFkjdMwgsBTaK93P0D/kqXf5XrJeeVp0q91ZKSgVe33vyxoETT5B+p
         HZD317Gi5qHM9PbbAu8BDPgcU/RDN42uE8Wa47usR3jR/FQBfNIP++xl0b5MLQEKKIf4
         PM3sq9dbSBn0LS8r7MjzOpr6tF8P+UEMFdZv8JYX1Ek3XvaaJlPNfpPx+/Lc5DGjkZDf
         1W7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G3i0QYjUd9DxZkqdj4EfuBQknvXbN2Xgak73Yimrolk=;
        b=YwZgyyKWb1lCzvY1bh/mPUcQTAAT2FrfA65jklrLa0dcy6HvLYEKqUiMLl5Dj/g2Th
         yPwYGouYImp/FE79o2CQRDhYq+DSCBakFfbVlXmoNXWoj6ttaBzV6sW46rEnl1BprqoC
         6zK6lwRKruPysdIcVJSOurRYSgXHiq0Qb8j9s0gwUjQOiwUXHTItSI8NgLtG3PhSa3JB
         os9fxwgpZ9P1UPL/gSx3yKHhZGg4OqDdHDK81puOABsANN0lzp6uZxN8JPwuLj/02d7Z
         E3s4MrXbURyCQFYzLBAq2r7H8p3z/KN9ZnRzSzr+3rvtxxsAwdAg6RfuMF2SwRJ1JY9a
         MopA==
X-Gm-Message-State: AOAM533gvII8DCqwUjXjR8E3AYIa4Cx/KP2277D+MJ54ReflB7cWmK4e
        NHZ6B62K3eOzaBMxovNxD+czNQ==
X-Google-Smtp-Source: ABdhPJywLf6oC4nhXjnUswGNBrO47XjsBgqf51Zx1FvEEF6+VzePjA8l5sSRqRHvhgGbpMmncxUO8g==
X-Received: by 2002:a05:6871:99:b0:d6:ac91:d53c with SMTP id u25-20020a056871009900b000d6ac91d53cmr15703538oaa.10.1647191231934;
        Sun, 13 Mar 2022 10:07:11 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id l14-20020a4ac60e000000b002e0e75dcb82sm6207619ooq.12.2022.03.13.10.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 10:07:11 -0700 (PDT)
Date:   Sun, 13 Mar 2022 12:07:09 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] PCI: qcom: Drop manual pipe_clk_src handling
Message-ID: <Yi4kvSJiFqxkcAlR@builder.lan>
References: <20220313000824.229405-1-dmitry.baryshkov@linaro.org>
 <20220313000824.229405-6-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313000824.229405-6-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat 12 Mar 18:08 CST 2022, Dmitry Baryshkov wrote:

> Manual reparenting of pipe_clk_src is being replaced with the parking of
> the clock with clk_disable()/clk_enable(). Drop redundant code letting
> the pipe clock driver park the clock to the safe bi_tcxo parent
> automatically.
> 
> Cc: Prasad Malisetty <quic_pmaliset@quicinc.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 39 +-------------------------
>  1 file changed, 1 insertion(+), 38 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index a6becafb6a77..b48c899bcc97 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -164,9 +164,6 @@ struct qcom_pcie_resources_2_7_0 {
>  	int num_clks;
>  	struct regulator_bulk_data supplies[2];
>  	struct reset_control *pci_reset;
> -	struct clk *pipe_clk_src;
> -	struct clk *phy_pipe_clk;
> -	struct clk *ref_clk_src;
>  };
>  
>  union qcom_pcie_resources {
> @@ -192,7 +189,6 @@ struct qcom_pcie_ops {
>  
>  struct qcom_pcie_cfg {
>  	const struct qcom_pcie_ops *ops;
> -	unsigned int pipe_clk_need_muxing:1;
>  	unsigned int has_tbu_clk:1;
>  	unsigned int has_ddrss_sf_tbu_clk:1;
>  	unsigned int has_aggre0_clk:1;
> @@ -1158,20 +1154,6 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (pcie->cfg->pipe_clk_need_muxing) {
> -		res->pipe_clk_src = devm_clk_get(dev, "pipe_mux");
> -		if (IS_ERR(res->pipe_clk_src))
> -			return PTR_ERR(res->pipe_clk_src);
> -
> -		res->phy_pipe_clk = devm_clk_get(dev, "phy_pipe");
> -		if (IS_ERR(res->phy_pipe_clk))
> -			return PTR_ERR(res->phy_pipe_clk);
> -
> -		res->ref_clk_src = devm_clk_get(dev, "ref");
> -		if (IS_ERR(res->ref_clk_src))
> -			return PTR_ERR(res->ref_clk_src);
> -	}
> -
>  	return 0;
>  }
>  
> @@ -1189,10 +1171,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  		return ret;
>  	}
>  
> -	/* Set TCXO as clock source for pcie_pipe_clk_src */
> -	if (pcie->cfg->pipe_clk_need_muxing)
> -		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
> -
>  	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
>  	if (ret < 0)
>  		goto err_disable_regulators;
> @@ -1254,18 +1232,8 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>  
>  	clk_bulk_disable_unprepare(res->num_clks, res->clks);
> -	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> -}
>  
> -static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
> -{
> -	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> -
> -	/* Set pipe clock as clock source for pcie_pipe_clk_src */
> -	if (pcie->cfg->pipe_clk_need_muxing)
> -		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
> -
> -	return 0;
> +	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
>  }
>  
>  static int qcom_pcie_link_up(struct dw_pcie *pci)
> @@ -1441,7 +1409,6 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
>  	.init = qcom_pcie_init_2_7_0,
>  	.deinit = qcom_pcie_deinit_2_7_0,
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> -	.post_init = qcom_pcie_post_init_2_7_0,
>  };
>  
>  /* Qcom IP rev.: 1.9.0 */
> @@ -1450,7 +1417,6 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>  	.init = qcom_pcie_init_2_7_0,
>  	.deinit = qcom_pcie_deinit_2_7_0,
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> -	.post_init = qcom_pcie_post_init_2_7_0,
>  	.config_sid = qcom_pcie_config_sid_sm8250,
>  };
>  
> @@ -1488,7 +1454,6 @@ static const struct qcom_pcie_cfg sm8250_cfg = {
>  static const struct qcom_pcie_cfg sm8450_pcie0_cfg = {
>  	.ops = &ops_1_9_0,
>  	.has_ddrss_sf_tbu_clk = true,
> -	.pipe_clk_need_muxing = true,
>  	.has_aggre0_clk = true,
>  	.has_aggre1_clk = true,
>  };
> @@ -1496,14 +1461,12 @@ static const struct qcom_pcie_cfg sm8450_pcie0_cfg = {
>  static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
>  	.ops = &ops_1_9_0,
>  	.has_ddrss_sf_tbu_clk = true,
> -	.pipe_clk_need_muxing = true,
>  	.has_aggre1_clk = true,
>  };
>  
>  static const struct qcom_pcie_cfg sc7280_cfg = {
>  	.ops = &ops_1_9_0,
>  	.has_tbu_clk = true,
> -	.pipe_clk_need_muxing = true,
>  };
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
> -- 
> 2.34.1
> 
