Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717CE4D7737
	for <lists+linux-pci@lfdr.de>; Sun, 13 Mar 2022 18:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiCMRP1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Mar 2022 13:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiCMRP0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Mar 2022 13:15:26 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D022E1BE9B
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2022 10:14:13 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id g5-20020a4ae885000000b003240bc9b2afso4789387ooe.10
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2022 10:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7JUbXPWavocTrxHfrM8Ljwj1RqbA1g9o14Z+OZzAewE=;
        b=KLsa6jti1VlDy1yfj527yRPcynATQNAV38Mar46MEPPGxmoL5AA4I1s3vIsQC/1jSB
         1gRaZQqDv2VCzPmsuEpyu4kPajhJ+P99liIk73KCWqCb7Ta3JfXHBEFaywuGCtKnA4DV
         R6M5emMwhh416JKZqHgI+RLavRPm1u8U2bKejRTTKM3NIU9UZ7rgQV0E/GjNUt7KJuG6
         fT4O71lKczFy7RFiQawHVmrMn7M/nMKxdCwjQa4jt+6rHMmSaQHO2XFiNibcmMLUU/Rc
         bX/ujwtHkoEAX9gmm008mcipc6IE+rx42AzaDh0iNwjzDi49m5B02eQ+yHfYmdudA2Mu
         3cTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7JUbXPWavocTrxHfrM8Ljwj1RqbA1g9o14Z+OZzAewE=;
        b=h0dBueQH6L+ivmkapxq9+sXLe8OIoTc4gMai30+GWNGlnvIQ1CPavcGnhHakPFiSgc
         nLMdCbx9eZ56Akk9WgEk3MqsSEXD39adc6ArWRi/zbqMg8SAE0kuzNMnizsXaqudI6sa
         6v/Ylu8/rYrTNZNFRXxvgTB5RyhnjLLxK9jbIvGXCqVcHXbRGCEQYsKuhgIPR6IfgInT
         Iubo2JZmaSlObmpbFcOtjT05wKuCpXoWGFRYtfYNQlbvGgEbO5Qzw8T9sXGGGlbEtPnR
         JNVhTgArA8+Xh67VUR7qMjdMQNc2guCyDoPMVtLmb2OdYRU185c0a9oRqgmAJ7+nTfnM
         EYsA==
X-Gm-Message-State: AOAM533qIG8jja0JL4qgITPH7jU9i876+mGvXPYD7URZESnKF6VK8uES
        YgSY7874uiGAvdpFPHEyt2vKUQ==
X-Google-Smtp-Source: ABdhPJzNe5yoZ1PZT7tStcscdhSTkdy1tXd5jWXSCI51FpWnrwIiIWmAMguJrx3QSRKYonFxwTJSCg==
X-Received: by 2002:a05:6870:c88a:b0:da:cdc2:282c with SMTP id er10-20020a056870c88a00b000dacdc2282cmr6856120oab.115.1647191653069;
        Sun, 13 Mar 2022 10:14:13 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id q62-20020a4a3341000000b00320f8a179d0sm6191967ooq.30.2022.03.13.10.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 10:14:12 -0700 (PDT)
Date:   Sun, 13 Mar 2022 12:14:10 -0500
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
Subject: Re: [RFC PATCH 1/5] clk: qcom: regmap-mux: add pipe clk
 implementation
Message-ID: <Yi4mYqEaWIIav5rg@builder.lan>
References: <20220313000824.229405-1-dmitry.baryshkov@linaro.org>
 <20220313000824.229405-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313000824.229405-2-dmitry.baryshkov@linaro.org>
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

> PCIe PIPE clk (and some other clocks) must be parked to the "safe"

How about changing this to:

"On recent Qualcomm platforms the QMP PIPE clocks feed into a set of
muxes which must be parked..."

To cover the fact that the design changed recently and that it relates
to (at least) USB as well.

> source (bi_tcxo) when corresponding GDSC is turned off and on again.
> Currently this is handcoded in the PCIe driver, reparenting the
> gcc_pipe_N_clk_src clock. However the same code sequence should be
> applied in the pcie-qcom-ep, USB3 and UFS drivers.
> 
> Rather than copying this sequence over and over again, follow the
> example of clk_rcg2_shared_ops and implement this parking in the
> enable() and disable() clock operations. As we are changing the parent
> behind the back of the clock framework, also implement custom
> set_parent() and get_parent() operations behaving accroding to the clock
> framework expectations (cache the new parent if the clock is in disabled
> state, return cached parent).
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/clk/qcom/clk-regmap-mux.c | 70 +++++++++++++++++++++++++++++++
>  drivers/clk/qcom/clk-regmap-mux.h |  3 ++
>  2 files changed, 73 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-regmap-mux.c b/drivers/clk/qcom/clk-regmap-mux.c
> index 45d9cca28064..024412b070c5 100644
> --- a/drivers/clk/qcom/clk-regmap-mux.c
> +++ b/drivers/clk/qcom/clk-regmap-mux.c
> @@ -49,9 +49,79 @@ static int mux_set_parent(struct clk_hw *hw, u8 index)
>  	return regmap_update_bits(clkr->regmap, mux->reg, mask, val);
>  }
>  
> +static u8 mux_safe_get_parent(struct clk_hw *hw)
> +{
> +	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
> +	unsigned int val;
> +
> +	if (clk_hw_is_enabled(hw))
> +		return mux_get_parent(hw);
> +
> +	val = mux->stored_parent;
> +
> +	if (mux->parent_map)
> +		return qcom_find_cfg_index(hw, mux->parent_map, val);
> +
> +	return val;
> +}
> +
> +static int mux_safe_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
> +
> +	if (clk_hw_is_enabled(hw))
> +		return mux_set_parent(hw, index);
> +
> +	if (mux->parent_map)
> +		index = mux->parent_map[index].cfg;
> +
> +	mux->stored_parent = index;
> +
> +	return 0;
> +}
> +
> +static void mux_safe_disable(struct clk_hw *hw)
> +{
> +	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
> +	struct clk_regmap *clkr = to_clk_regmap(hw);
> +	unsigned int mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
> +	unsigned int val;
> +
> +	regmap_read(clkr->regmap, mux->reg, &val);
> +
> +	mux->stored_parent = (val & mask) >> mux->shift;
> +
> +	val = mux->safe_src_index;
> +	val <<= mux->shift;
> +
> +	regmap_update_bits(clkr->regmap, mux->reg, mask, val);
> +}
> +
> +static int mux_safe_enable(struct clk_hw *hw)
> +{
> +	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
> +	struct clk_regmap *clkr = to_clk_regmap(hw);
> +	unsigned int mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
> +	unsigned int val;
> +
> +	val = mux->stored_parent;
> +	val <<= mux->shift;
> +
> +	return regmap_update_bits(clkr->regmap, mux->reg, mask, val);
> +}
> +
>  const struct clk_ops clk_regmap_mux_closest_ops = {
>  	.get_parent = mux_get_parent,
>  	.set_parent = mux_set_parent,
>  	.determine_rate = __clk_mux_determine_rate_closest,
>  };
>  EXPORT_SYMBOL_GPL(clk_regmap_mux_closest_ops);
> +
> +const struct clk_ops clk_regmap_mux_safe_ops = {
> +	.enable = mux_safe_enable,
> +	.disable = mux_safe_disable,
> +	.get_parent = mux_safe_get_parent,
> +	.set_parent = mux_safe_set_parent,
> +	.determine_rate = __clk_mux_determine_rate_closest,
> +};
> +EXPORT_SYMBOL_GPL(clk_regmap_mux_safe_ops);
> diff --git a/drivers/clk/qcom/clk-regmap-mux.h b/drivers/clk/qcom/clk-regmap-mux.h
> index db6f4cdd9586..ab8ab25d79bd 100644
> --- a/drivers/clk/qcom/clk-regmap-mux.h
> +++ b/drivers/clk/qcom/clk-regmap-mux.h
> @@ -14,10 +14,13 @@ struct clk_regmap_mux {
>  	u32			reg;
>  	u32			shift;
>  	u32			width;
> +	u8			safe_src_index;
> +	u8			stored_parent;
>  	const struct parent_map	*parent_map;
>  	struct clk_regmap	clkr;
>  };
>  
>  extern const struct clk_ops clk_regmap_mux_closest_ops;
> +extern const struct clk_ops clk_regmap_mux_safe_ops;
>  
>  #endif
> -- 
> 2.34.1
> 
