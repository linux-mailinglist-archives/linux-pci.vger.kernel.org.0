Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6144D770E
	for <lists+linux-pci@lfdr.de>; Sun, 13 Mar 2022 18:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiCMRJ0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Mar 2022 13:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbiCMRJZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Mar 2022 13:09:25 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DC83C483
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2022 10:08:16 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id w3-20020a4ac183000000b0031d806bbd7eso17262357oop.13
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2022 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TTEL9z0j5y5IwZybrA/ry1mARIsb0Sd08Qpenpd0zvk=;
        b=JSptMf34XGEErjoHEdgKX5AT6KMDMANZhzSOCLee8mH8y83DZpS20nOermqB31KSKd
         RXB+n+WTjM0VsFqdG9jRaCpQi5dTfD8HLvUzzT688ZP7zXXMU37aZfyoyyNS8uquOzZQ
         K/diSGC9ADfsUCkGeH2wFDZ625e9bUQjIppfVroIF+NY/PXcAyQXv4GXTDPRrwTh8jS4
         eFvKJ8/lYv5xnCvi6R4aazbPJ/bWNwWQnH6NWHZ6t1t3ik5sl4DmQKzkjSbAXqGClbLS
         89NYjafaFXC0+mpNd69dMrTI2/4ZK6/jMpR+Ju6OryCNgPpfEGzE1d+7GxoqXvee58gH
         AwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TTEL9z0j5y5IwZybrA/ry1mARIsb0Sd08Qpenpd0zvk=;
        b=IfQfuJk7H0k+k2Y6oiLwGpm6QhlGz6g2l+GUiXYrwS0KueQEKD2eCREaNjX88r4S1+
         PLTVTUI7vwKdQdOMYfgMT6pa8DUSne2HxSBanush4ZfY1B80OMMVqJIlUhdZ1Ja8PewU
         JFxq1FweSvgSpZ5tag5o2SFVYJ1KAT2vLBQKofd/4KkZ3fQRwPww69hvZa6bvLGL3uCZ
         /xRwezMShnWHU8iNzOkfJ0+JsAJXQhv86HSTHCwrY7Z9vwsB6c5MFEIV61eHdPQrU1+v
         Z1Fqudh6LwIKO/zzXjAGJD9IXjmRCe/Q/syRoK6aiHxUyfULnaQpUmOCRH/3Cbi33Zfn
         NipQ==
X-Gm-Message-State: AOAM533TCHkJqj9iVgMIa8qeOsRrseC2mRLEfGuB9riNz2u0/VEqxNLK
        KffY9G1aBmO2oTMBsmQjlShoaQ==
X-Google-Smtp-Source: ABdhPJyBtkA0wzi8Byfyr9t3m6o1sQsxWqhiDtj2Tb9lBU1kGHtdibCIy0qS/C9YPWVu/PI3y6IGQQ==
X-Received: by 2002:a05:6870:8989:b0:d3:b909:9266 with SMTP id f9-20020a056870898900b000d3b9099266mr15290335oaq.150.1647191296327;
        Sun, 13 Mar 2022 10:08:16 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id w22-20020acaad16000000b002d9c98e551bsm2897103oie.36.2022.03.13.10.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 10:08:15 -0700 (PDT)
Date:   Sun, 13 Mar 2022 12:08:14 -0500
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
Subject: Re: [RFC PATCH 3/5] clk: qcom: gcc-sc7280: use new
 clk_regmap_mux_safe_ops for PCIe pipe clocks
Message-ID: <Yi4k/gUHqEEQfZIT@builder.lan>
References: <20220313000824.229405-1-dmitry.baryshkov@linaro.org>
 <20220313000824.229405-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313000824.229405-4-dmitry.baryshkov@linaro.org>
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

> Use newly defined clk_regmap_mux_safe_ops for PCIe pipe clocks to let
> the clock framework automatically park the clock when the clock is
> switched off and restore the parent when the clock is switched on.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/clk/qcom/gcc-sc7280.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
> index 423627d49719..69887e45d02f 100644
> --- a/drivers/clk/qcom/gcc-sc7280.c
> +++ b/drivers/clk/qcom/gcc-sc7280.c
> @@ -373,13 +373,14 @@ static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
>  	.reg = 0x6b054,
>  	.shift = 0,
>  	.width = 2,
> +	.safe_src_index = 2,
>  	.parent_map = gcc_parent_map_6,
>  	.clkr = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_pcie_0_pipe_clk_src",
>  			.parent_data = gcc_parent_data_6,
>  			.num_parents = ARRAY_SIZE(gcc_parent_data_6),
> -			.ops = &clk_regmap_mux_closest_ops,
> +			.ops = &clk_regmap_mux_safe_ops,
>  		},
>  	},
>  };
> @@ -388,13 +389,14 @@ static struct clk_regmap_mux gcc_pcie_1_pipe_clk_src = {
>  	.reg = 0x8d054,
>  	.shift = 0,
>  	.width = 2,
> +	.safe_src_index = 2,
>  	.parent_map = gcc_parent_map_7,
>  	.clkr = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_pcie_1_pipe_clk_src",
>  			.parent_data = gcc_parent_data_7,
>  			.num_parents = ARRAY_SIZE(gcc_parent_data_7),
> -			.ops = &clk_regmap_mux_closest_ops,
> +			.ops = &clk_regmap_mux_safe_ops,
>  		},
>  	},
>  };
> -- 
> 2.34.1
> 
