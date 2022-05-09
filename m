Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF9351F9C4
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 12:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiEIK3h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 06:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiEIK33 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 06:29:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B187A245601;
        Mon,  9 May 2022 03:24:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0780B8111A;
        Mon,  9 May 2022 10:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA37DC385AB;
        Mon,  9 May 2022 10:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652091855;
        bh=t0gdJ/3OYVRiWj8H5ickLau7bfGxmx6eQquiXYNQCUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lXWP4k0bM0zkwr4PFj/cjc3EMZNolHLvHsLErY69hP7+mCTzVf59Gr+QzuDB/Mq+k
         yaf3vEfH0flg/4ksQVAqVKNsmUOZAeconr6rA0WnEycXDNzjZhsBkMXfhq34VvugKe
         2B6d7SJWlvVWQgSgLW8CP42MDbQ9B+TYaIEMR/7H5dx4P8aUB61CP5yCxKGEg6P9Y3
         Lm+oYkXk7pYGTXqj7yMNCOpHXLIQ8L3S0bTMbcq1jYHaArT69KFiGlR0fGfd7LSQ25
         6mxPLDfKEUV3/k8sT6ynWluTsIPvYXpdPSIaK0m/ewv2q3LsEJXxQwWASCK0veOeIK
         IFLxvw724InoQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1no0Ym-0006AV-DE; Mon, 09 May 2022 12:24:13 +0200
Date:   Mon, 9 May 2022 12:24:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/5] PCI: qcom: Drop manual pipe_clk_src handling
Message-ID: <YnjrzKgytcdL5XYw@hovoldconsulting.com>
References: <20220501192149.4128158-1-dmitry.baryshkov@linaro.org>
 <20220501192149.4128158-6-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501192149.4128158-6-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, May 01, 2022 at 10:21:49PM +0300, Dmitry Baryshkov wrote:
> Manual reparenting of pipe_clk_src is being replaced with the parking of
> the clock with clk_disable()/clk_enable(). Drop redundant code letting
> the pipe clock driver park the clock to the safe bi_tcxo parent
> automatically.

This isn't just about restoring XO before disabling, you also need to
make sure the PHY PLL is muxed in (and the current implementation never
even bothered to restore XO).

Perhaps rephrase the above.

> Cc: Prasad Malisetty <quic_pmaliset@quicinc.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

This unconditional reparenting would even cause problems on some
platforms where everything has been set up by the boot firmware.

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

Change itself looks good otherwise.

Johan
