Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D378053E702
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jun 2022 19:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiFFQci (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jun 2022 12:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiFFQch (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jun 2022 12:32:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805D31DA47;
        Mon,  6 Jun 2022 09:32:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4207DB81A9A;
        Mon,  6 Jun 2022 16:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36EBC385A9;
        Mon,  6 Jun 2022 16:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654533154;
        bh=kcCx9yQs5mDziJlp0KzJTbH7vdxaXY8Y6DUsrLiQZiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I/QUBJRKxZr55jiqYGCwO1DuZ/uqVh3Eg4j24gtvRHgoVifQwv47nRlI+Jhr6sOgr
         NdJ1g4qe2UaNnGHPzr4YFvj958AvGfZAvt8HB4dU8khU/QK/qZLblEflZft/y1WgAi
         fM870JADY/IXM8ycJPZ1QFsd10xxlBf9PypnS4/fRf6yV8L4rNggeSOPgGVqnd7UPL
         SY7/HdgY4qiok9hky2ycmipCpS6Z7ogotmlec6ibBMmJGacStJ/5mf4YoE+/dkCfDw
         VVxFOynfxoi6SVYUR1ncDce1PfFCL6KzEWchMiC3/iXwb60NKroiH/SAYjoGKMW9fn
         hZwoxh2HgxM5g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nyFeV-0004DI-UY; Mon, 06 Jun 2022 18:32:27 +0200
Date:   Mon, 6 Jun 2022 18:32:27 +0200
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
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v10 3/5] clk: qcom: gcc-sc7280: use new
 clk_regmap_phy_mux_ops for PCIe pipe clocks
Message-ID: <Yp4sG1T104uxkPzp@hovoldconsulting.com>
References: <20220603084454.1861142-1-dmitry.baryshkov@linaro.org>
 <20220603084454.1861142-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603084454.1861142-4-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 03, 2022 at 11:44:52AM +0300, Dmitry Baryshkov wrote:
> Use newly defined clk_regmap_phy_mux_ops for PCIe pipe clocks to let
> the clock framework automatically park the clock when the clock is
> switched off and restore the parent when the clock is switched on.
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/clk/qcom/gcc-sc7280.c | 47 ++++++++++-------------------------
>  1 file changed, 13 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
> index 423627d49719..5a853497d211 100644
> --- a/drivers/clk/qcom/gcc-sc7280.c
> +++ b/drivers/clk/qcom/gcc-sc7280.c
> @@ -17,6 +17,7 @@
>  #include "clk-rcg.h"
>  #include "clk-regmap-divider.h"
>  #include "clk-regmap-mux.h"
> +#include "clk-regmap-phy-mux.h"
>  #include "common.h"
>  #include "gdsc.h"
>  #include "reset.h"
> @@ -255,26 +256,6 @@ static const struct clk_parent_data gcc_parent_data_5[] = {
>  	{ .hw = &gcc_gpll0_out_even.clkr.hw },
>  };
>  
> -static const struct parent_map gcc_parent_map_6[] = {
> -	{ P_PCIE_0_PIPE_CLK, 0 },
> -	{ P_BI_TCXO, 2 },
> -};
> -
> -static const struct clk_parent_data gcc_parent_data_6[] = {
> -	{ .fw_name = "pcie_0_pipe_clk", .name = "pcie_0_pipe_clk" },
> -	{ .fw_name = "bi_tcxo" },
> -};
> -
> -static const struct parent_map gcc_parent_map_7[] = {
> -	{ P_PCIE_1_PIPE_CLK, 0 },
> -	{ P_BI_TCXO, 2 },
> -};
> -
> -static const struct clk_parent_data gcc_parent_data_7[] = {
> -	{ .fw_name = "pcie_1_pipe_clk", .name = "pcie_1_pipe_clk" },
> -	{ .fw_name = "bi_tcxo" },
> -};
> -
>  static const struct parent_map gcc_parent_map_8[] = {
>  	{ P_BI_TCXO, 0 },
>  	{ P_GCC_GPLL0_OUT_MAIN, 1 },
> @@ -369,32 +350,30 @@ static const struct clk_parent_data gcc_parent_data_15[] = {
>  	{ .hw = &gcc_mss_gpll0_main_div_clk_src.clkr.hw },
>  };
>  
> -static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
> +static struct clk_regmap_phy_mux gcc_pcie_0_pipe_clk_src = {
>  	.reg = 0x6b054,
> -	.shift = 0,
> -	.width = 2,
> -	.parent_map = gcc_parent_map_6,
>  	.clkr = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_pcie_0_pipe_clk_src",
> -			.parent_data = gcc_parent_data_6,
> -			.num_parents = ARRAY_SIZE(gcc_parent_data_6),
> -			.ops = &clk_regmap_mux_closest_ops,
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "pcie_0_pipe_clk", .name = "pcie_0_pipe_clk",

No need to initialise fw_name and name on the same line here.

> +			},
> +			.num_parents = 1,
> +			.ops = &clk_regmap_phy_mux_ops,
>  		},
>  	},
>  };
>  
> -static struct clk_regmap_mux gcc_pcie_1_pipe_clk_src = {
> +static struct clk_regmap_phy_mux gcc_pcie_1_pipe_clk_src = {
>  	.reg = 0x8d054,
> -	.shift = 0,
> -	.width = 2,
> -	.parent_map = gcc_parent_map_7,
>  	.clkr = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_pcie_1_pipe_clk_src",
> -			.parent_data = gcc_parent_data_7,
> -			.num_parents = ARRAY_SIZE(gcc_parent_data_7),
> -			.ops = &clk_regmap_mux_closest_ops,
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "pcie_1_pipe_clk", .name = "pcie_1_pipe_clk",

Same here.

> +			},
> +			.num_parents = 1,
> +			.ops = &clk_regmap_phy_mux_ops,
>  		},
>  	},
>  };

Johan
