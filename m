Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A43052F024
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 18:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348191AbiETQKC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 12:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234699AbiETQJ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 12:09:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734B21737DC;
        Fri, 20 May 2022 09:09:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C25B61E15;
        Fri, 20 May 2022 16:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6297EC34100;
        Fri, 20 May 2022 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653062997;
        bh=8zAsVykc7zIiYDzIlRZTTHAtIDLbg2xtKgboqJ8EnAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rvbx2fkAIsSeHrIF2xSPzECPo1CT2NeRA53jieKey/MYWeEKBeJZn0lLsPj3ILqDG
         UOfC6DCfaCmZJ6bmX1bq9RPT075JjI+IoWrfg9RRVhqcQWKChWZXB0O5URWEdUDQOJ
         j6B2B7r4iLNHnu+upN7ZYL+511KgALAVqAtc9nfDsKfS4wFUhv5Rd42DnQDTRi2toh
         +XMf9yDsbv0cEQ51v4aaqqpZyJwnqpx5QK2FLsd9g5AxJM8lDhKsyLa+P5y2ueAt5m
         Boj2Gbv9GXOd1aIkTP8xXtmAlpV/MvfsdsrgcjkPj489XPPo4IGn69LAh6fxHAxgLD
         AHz6yXJlRdX1Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ns5CP-00088J-MF; Fri, 20 May 2022 18:09:57 +0200
Date:   Fri, 20 May 2022 18:09:57 +0200
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
Subject: Re: [PATCH v7 3/6] clk: qcom: gcc-sm8450: use new
 clk_regmap_phy_mux_ops for PCIe pipe clocks
Message-ID: <Yoe9VSxzOs733LTz@hovoldconsulting.com>
References: <20220520015844.1190511-1-dmitry.baryshkov@linaro.org>
 <20220520015844.1190511-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520015844.1190511-4-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 20, 2022 at 04:58:41AM +0300, Dmitry Baryshkov wrote:
> Use newly defined clk_regmap_phy_mux_ops for PCIe pipe clocks to let
> the clock framework automatically park the clock when the clock is
> switched off and restore the parent when the clock is switched on.
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

For the benefit of others using the new phy_mux implementation, it would
have been better to just do a revert of the safe-mux change. Would make
reviewing easier too.

> ---
>  drivers/clk/qcom/gcc-sm8450.c | 72 +++++++++++------------------------
>  1 file changed, 22 insertions(+), 50 deletions(-)
 
> -static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
> -	.reg = 0x7b060,
> -	.shift = 0,
> -	.width = 2,
> -	.safe_src_parent = P_BI_TCXO,
> -	.parent_map = gcc_parent_map_4,
> -	.clkr = {
> -		.hw.init = &(struct clk_init_data){
> -			.name = "gcc_pcie_0_pipe_clk_src",
> -			.parent_data = gcc_parent_data_4,
> -			.num_parents = ARRAY_SIZE(gcc_parent_data_4),
> -			.ops = &clk_regmap_mux_safe_ops,
> +static struct clk_regmap gcc_pcie_0_pipe_clk_src = {
> +	.enable_reg = 0x7b060,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "gcc_pcie_0_pipe_clk_src",
> +		.parent_data = &(const struct clk_parent_data){
> +			.fw_name = "pcie_0_pipe_clk",
>  		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_phy_mux_ops,
>  	},
>  };

And again, this would be easier to understand with a dedicated struct
clk_regmap_phy_mux (whose definition you can look up and find a
description of how it is intended to be use).

Johan
