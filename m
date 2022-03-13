Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDFA4D7708
	for <lists+linux-pci@lfdr.de>; Sun, 13 Mar 2022 18:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiCMRH4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Mar 2022 13:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbiCMRHu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Mar 2022 13:07:50 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DFC124C3D
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2022 10:06:41 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id ay7so15043740oib.8
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2022 10:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cyExqYFUEED5RxJ99VQKUU0rLaGLpZw8O5MJtPofWqo=;
        b=w0Zd/RiiIOHdkRMkNSHeSi7eso9IcO5PohoAwSu0/ePmEVjXZx7pd8qmedqbbsq2kq
         VxYETFae1jP3hcDDUmIHfjrAiTBnZRRNKX2G0rVlaHch2lQSmjPbqXG6MlREyrLYs4X5
         DigFmENvrrR7sdIj3vajOPr6ibNrIxptpUPu0zbMWMkNRv0L/0JpYOExjSL89KC2iQwu
         daAeomawJ4/Qi5oCbmOCdJjYtZIh/D4gvoFhCfgu0Unt7ewcgmXAtv3py3ftLA2yJ4xH
         N8qxutTqkM71uogDWlleVGGJUw2ewvmn5emiUNOmqJWGUEF1snsBeMP/iJAruM2tUG9T
         lYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cyExqYFUEED5RxJ99VQKUU0rLaGLpZw8O5MJtPofWqo=;
        b=b9naI7Gy879Y7guKmYzcpOHEhaklw69jm81l/26VklCYIdhxgxWa1Cw8EgsXsdoTt3
         ryf0SFHeEbcU2wmX5ha+tUpR7ujC/pwhY0WgcbzZvz9qppWCTBK5KX+yQq57rgqMhfC3
         oIiXAfog8q2vg2CYQT+LV33MjGc8mB71iqWd2QcLNPhtKoWRgT85ZpuI+f0hy9WIV4O0
         RyM59+mNJA9kvOy4p3VfSCrx17MyOeG02Dn9I4mc+S+QGtIvUHbwgCBPWmwgKV39QHSc
         +U0Sg9joz6WDeo3Wp3LnoaR6rp+a7dajPgL0eA9bjWYd9oeHuCRlrs8fSGxOLAMDN3Uf
         ZQSQ==
X-Gm-Message-State: AOAM5323YbAQDv6qH7zuvrwkISlAe61ZrB/7c8sSqb3RCfM5PPAZQ1yd
        5AA37shXrZ4Kkq+aZ8CQlJM3Jg==
X-Google-Smtp-Source: ABdhPJygdsYZgzeuWh6Zt/A4twhiG0Fc/WetWlZMXaohY5Zh2Oq9OJ8S7pwu1gFMTdBX7izRarxTtw==
X-Received: by 2002:a05:6808:302b:b0:2cb:2fea:cf9 with SMTP id ay43-20020a056808302b00b002cb2fea0cf9mr12430643oib.117.1647191200773;
        Sun, 13 Mar 2022 10:06:40 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id p21-20020a4a2f15000000b00320fca09b74sm6326576oop.1.2022.03.13.10.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 10:06:40 -0700 (PDT)
Date:   Sun, 13 Mar 2022 12:06:38 -0500
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
Subject: Re: [RFC PATCH 4/5] PCI: qcom: Remove unnecessary pipe_clk handling
Message-ID: <Yi4knsfVrEmEEzKM@builder.lan>
References: <20220313000824.229405-1-dmitry.baryshkov@linaro.org>
 <20220313000824.229405-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313000824.229405-5-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat 12 Mar 18:08 CST 2022, Dmitry Baryshkov wrote:

> QMP PHY driver already does clk_prepare_enable()/_disable() pipe_clk.
> Remove extra calls to enable/disable this clock from the PCIe driver, so
> that the PHY driver can manage the clock on its own.
> 
> Fixes: aa9c0df98c29 ("PCI: qcom: Switch pcie_1_pipe_clk_src after PHY init in SC7280")
> Cc: Prasad Malisetty <quic_pmaliset@quicinc.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 50 ++------------------------
>  1 file changed, 3 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6ab90891801d..a6becafb6a77 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -128,7 +128,6 @@ struct qcom_pcie_resources_2_3_2 {
>  	struct clk *master_clk;
>  	struct clk *slave_clk;
>  	struct clk *cfg_clk;
> -	struct clk *pipe_clk;
>  	struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
>  };
>  
> @@ -165,7 +164,6 @@ struct qcom_pcie_resources_2_7_0 {
>  	int num_clks;
>  	struct regulator_bulk_data supplies[2];
>  	struct reset_control *pci_reset;
> -	struct clk *pipe_clk;
>  	struct clk *pipe_clk_src;
>  	struct clk *phy_pipe_clk;
>  	struct clk *ref_clk_src;
> @@ -597,8 +595,7 @@ static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
>  	if (IS_ERR(res->slave_clk))
>  		return PTR_ERR(res->slave_clk);
>  
> -	res->pipe_clk = devm_clk_get(dev, "pipe");
> -	return PTR_ERR_OR_ZERO(res->pipe_clk);
> +	return 0;
>  }
>  
>  static void qcom_pcie_deinit_2_3_2(struct qcom_pcie *pcie)
> @@ -613,13 +610,6 @@ static void qcom_pcie_deinit_2_3_2(struct qcom_pcie *pcie)
>  	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
>  }
>  
> -static void qcom_pcie_post_deinit_2_3_2(struct qcom_pcie *pcie)
> -{
> -	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
> -
> -	clk_disable_unprepare(res->pipe_clk);
> -}
> -
>  static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
>  {
>  	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
> @@ -694,22 +684,6 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
>  	return ret;
>  }
>  
> -static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
> -{
> -	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
> -	struct dw_pcie *pci = pcie->pci;
> -	struct device *dev = pci->dev;
> -	int ret;
> -
> -	ret = clk_prepare_enable(res->pipe_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable pipe clock\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>  static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
>  {
>  	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
> @@ -1198,8 +1172,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  			return PTR_ERR(res->ref_clk_src);
>  	}
>  
> -	res->pipe_clk = devm_clk_get(dev, "pipe");
> -	return PTR_ERR_OR_ZERO(res->pipe_clk);
> +	return 0;
>  }
>  
>  static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> @@ -1238,12 +1211,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  		goto err_disable_clocks;
>  	}
>  
> -	ret = clk_prepare_enable(res->pipe_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable pipe clock\n");
> -		goto err_disable_clocks;
> -	}
> -
>  	/* Wait for reset to complete, required on SM8450 */
>  	usleep_range(1000, 1500);
>  
> @@ -1298,14 +1265,7 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  	if (pcie->cfg->pipe_clk_need_muxing)
>  		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
>  
> -	return clk_prepare_enable(res->pipe_clk);
> -}
> -
> -static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
> -{
> -	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> -
> -	clk_disable_unprepare(res->pipe_clk);
> +	return 0;
>  }
>  
>  static int qcom_pcie_link_up(struct dw_pcie *pci)
> @@ -1455,9 +1415,7 @@ static const struct qcom_pcie_ops ops_1_0_0 = {
>  static const struct qcom_pcie_ops ops_2_3_2 = {
>  	.get_resources = qcom_pcie_get_resources_2_3_2,
>  	.init = qcom_pcie_init_2_3_2,
> -	.post_init = qcom_pcie_post_init_2_3_2,
>  	.deinit = qcom_pcie_deinit_2_3_2,
> -	.post_deinit = qcom_pcie_post_deinit_2_3_2,
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  };
>  
> @@ -1484,7 +1442,6 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
>  	.deinit = qcom_pcie_deinit_2_7_0,
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  	.post_init = qcom_pcie_post_init_2_7_0,
> -	.post_deinit = qcom_pcie_post_deinit_2_7_0,
>  };
>  
>  /* Qcom IP rev.: 1.9.0 */
> @@ -1494,7 +1451,6 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>  	.deinit = qcom_pcie_deinit_2_7_0,
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  	.post_init = qcom_pcie_post_init_2_7_0,
> -	.post_deinit = qcom_pcie_post_deinit_2_7_0,
>  	.config_sid = qcom_pcie_config_sid_sm8250,
>  };
>  
> -- 
> 2.34.1
> 
