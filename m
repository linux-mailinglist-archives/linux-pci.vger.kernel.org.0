Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1EF4FE836
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 20:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiDLSsB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 14:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244339AbiDLSsA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 14:48:00 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D38D5A59F
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 11:45:40 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso13984373otj.5
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 11:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XxeVW+ERdpckFbjpybjyBJY0dmogdXiEHvij5CpNz9Q=;
        b=SA3z/k155K8jxq+rHu6Mxe+9aKu+zZ6/lm8W1JtGPmwCdUCBO0bUtXISleMGB5Dw28
         qAF3DsvtqMzrGT+gZk3vzJDgnFa8mvdWyjNU3EYwHrl/5N1FaGWCa4RqtNB0BvbpbjkJ
         2gd+8Mn1Oo0HAAfGfl8Eu8uDj6HbYBQVo87umSzDZMWmfPTvp9zFVepwS8aWmV998+Lm
         hXxbNyPn0C7EbiqvrXHChw2jvU91+1IWeFzEgNiLQqq9gzEeTwPJlyAedmi/YVHC81lP
         u4/Ia5exHODFZpOHz5eUnYh/WGJnjYWqAad9hkkYMGZLWqPuzDoXTAnhWriAxmp2clBb
         Y+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XxeVW+ERdpckFbjpybjyBJY0dmogdXiEHvij5CpNz9Q=;
        b=sMKX2u9+scZjW5N00gisfyMvPfIqc18kx2jvvQ4yN7dzXefIbg7gNbzO9G7xmvOIXr
         qR+JyUB291Pr42M3gDar1zA0zOLcfq87aGmlsdCPVtu2Tk9lx2mlaoLEBz6wvg/yf+eB
         5YRQ0I75ISaUSL/PAtd17hLeskF7P1UcPFExEA5yvcRcXHhCu/S5HUBbdo6iAaQpY9Or
         Rvg1lrPP8RTS9BthViUeTctUSa6O2+1VrisCFXE6+XZ3+6tcJ+O8t0Zk7fm7YhH47WNk
         s3hgp4Um2hsWsbg+zrvhD8zN6IOfWntZZ1BjrH3sK/D/qUouonVoryHc80t4hAJz6Bd+
         huKg==
X-Gm-Message-State: AOAM532gnmqsoSc8vhnu+CCAbQuEVOK7ZzZ/1cq4iIXG0mIjf3WklUjB
        hMfsk7gW7CBkdBxwA/dsvuCgcA==
X-Google-Smtp-Source: ABdhPJyYGjgv5VNY/znjPVv4C2d3S7X3Gk5Xtstq9W0w7X1ocT+WxUjkTIc/8kibVAfYBdE5cfe7MA==
X-Received: by 2002:a05:6830:154c:b0:5e6:85c5:ed8b with SMTP id l12-20020a056830154c00b005e685c5ed8bmr13547125otp.253.1649789139600;
        Tue, 12 Apr 2022 11:45:39 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id m5-20020a056870194500b000d9a0818925sm13147552oak.25.2022.04.12.11.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 11:45:39 -0700 (PDT)
Date:   Tue, 12 Apr 2022 13:45:37 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 1/5] clk: qcom: regmap-mux: add pipe clk implementation
Message-ID: <YlXI0fg21XZPXwf4@builder.lan>
References: <20220323085010.1753493-1-dmitry.baryshkov@linaro.org>
 <20220323085010.1753493-2-dmitry.baryshkov@linaro.org>
 <YlAZVrDXwdIItyTy@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlAZVrDXwdIItyTy@lpieralisi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri 08 Apr 06:15 CDT 2022, Lorenzo Pieralisi wrote:

> On Wed, Mar 23, 2022 at 11:50:06AM +0300, Dmitry Baryshkov wrote:
> > On recent Qualcomm platforms the QMP PIPE clocks feed into a set of
> > muxes which must be parked to the "safe" source (bi_tcxo) when
> > corresponding GDSC is turned off and on again. Currently this is
> > handcoded in the PCIe driver by reparenting the gcc_pipe_N_clk_src
> > clock. However the same code sequence should be applied in the
> > pcie-qcom endpoint, USB3 and UFS drivers.
> > 
> > Rather than copying this sequence over and over again, follow the
> > example of clk_rcg2_shared_ops and implement this parking in the
> > enable() and disable() clock operations. As we are changing the parent
> > behind the back of the clock framework, also implement custom
> > set_parent() and get_parent() operations behaving accroding to the clock
> > framework expectations (cache the new parent if the clock is in disabled
> > state, return cached parent).
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/clk/qcom/clk-regmap-mux.c | 78 +++++++++++++++++++++++++++++++
> >  drivers/clk/qcom/clk-regmap-mux.h |  3 ++
> >  2 files changed, 81 insertions(+)
> 
> Need BjornA's ACK on this patch and I can pull the series then.
> 

It seems I have a few more clock patches in the queue which depends on
top of this, so I picked up the three clock branches and pushed a tag
for you to pick up, Lorenzo.

The following changes since commit a9ed9e2bf7940353d2ffa4faa2ad2b75a24f3ac0:

  clk: qcom: gcc-sc7280: use new clk_regmap_mux_safe_ops for PCIe pipe clocks (2022-04-12 13:32:58 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git tags/20220323085010.1753493-4-dmitry.baryshkov@linaro.org

for you to fetch changes up to a9ed9e2bf7940353d2ffa4faa2ad2b75a24f3ac0:

  clk: qcom: gcc-sc7280: use new clk_regmap_mux_safe_ops for PCIe pipe clocks (2022-04-12 13:32:58 -0500)

----------------------------------------------------------------
v5.18-rc1 +
20220323085010.1753493-2-dmitry.baryshkov@linaro.org +
20220323085010.1753493-3-dmitry.baryshkov@linaro.org +
20220323085010.1753493-4-dmitry.baryshkov@linaro.org

----------------------------------------------------------------

Hope this works for you.

Regards,
Bjorn

> Lorenzo
> 
> > diff --git a/drivers/clk/qcom/clk-regmap-mux.c b/drivers/clk/qcom/clk-regmap-mux.c
> > index 45d9cca28064..c39ee783ee83 100644
> > --- a/drivers/clk/qcom/clk-regmap-mux.c
> > +++ b/drivers/clk/qcom/clk-regmap-mux.c
> > @@ -49,9 +49,87 @@ static int mux_set_parent(struct clk_hw *hw, u8 index)
> >  	return regmap_update_bits(clkr->regmap, mux->reg, mask, val);
> >  }
> >  
> > +static u8 mux_safe_get_parent(struct clk_hw *hw)
> > +{
> > +	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
> > +	unsigned int val;
> > +
> > +	if (clk_hw_is_enabled(hw))
> > +		return mux_get_parent(hw);
> > +
> > +	val = mux->stored_parent_cfg;
> > +
> > +	if (mux->parent_map)
> > +		return qcom_find_cfg_index(hw, mux->parent_map, val);
> > +
> > +	return val;
> > +}
> > +
> > +static int mux_safe_set_parent(struct clk_hw *hw, u8 index)
> > +{
> > +	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
> > +
> > +	if (clk_hw_is_enabled(hw))
> > +		return mux_set_parent(hw, index);
> > +
> > +	if (mux->parent_map)
> > +		index = mux->parent_map[index].cfg;
> > +
> > +	mux->stored_parent_cfg = index;
> > +
> > +	return 0;
> > +}
> > +
> > +static void mux_safe_disable(struct clk_hw *hw)
> > +{
> > +	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
> > +	struct clk_regmap *clkr = to_clk_regmap(hw);
> > +	unsigned int mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
> > +	unsigned int val;
> > +
> > +	regmap_read(clkr->regmap, mux->reg, &val);
> > +
> > +	mux->stored_parent_cfg = (val & mask) >> mux->shift;
> > +
> > +	val = mux->safe_src_parent;
> > +	if (mux->parent_map) {
> > +		int index = qcom_find_src_index(hw, mux->parent_map, val);
> > +
> > +		if (WARN_ON(index < 0))
> > +			return;
> > +
> > +		val = mux->parent_map[index].cfg;
> > +	}
> > +	val <<= mux->shift;
> > +
> > +	regmap_update_bits(clkr->regmap, mux->reg, mask, val);
> > +}
> > +
> > +static int mux_safe_enable(struct clk_hw *hw)
> > +{
> > +	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
> > +	struct clk_regmap *clkr = to_clk_regmap(hw);
> > +	unsigned int mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
> > +	unsigned int val;
> > +
> > +	val = mux->stored_parent_cfg;
> > +	val <<= mux->shift;
> > +
> > +	return regmap_update_bits(clkr->regmap, mux->reg, mask, val);
> > +}
> > +
> >  const struct clk_ops clk_regmap_mux_closest_ops = {
> >  	.get_parent = mux_get_parent,
> >  	.set_parent = mux_set_parent,
> >  	.determine_rate = __clk_mux_determine_rate_closest,
> >  };
> >  EXPORT_SYMBOL_GPL(clk_regmap_mux_closest_ops);
> > +
> > +const struct clk_ops clk_regmap_mux_safe_ops = {
> > +	.enable = mux_safe_enable,
> > +	.disable = mux_safe_disable,
> > +	.get_parent = mux_safe_get_parent,
> > +	.set_parent = mux_safe_set_parent,
> > +	.determine_rate = __clk_mux_determine_rate_closest,
> > +};
> > +EXPORT_SYMBOL_GPL(clk_regmap_mux_safe_ops);
> > diff --git a/drivers/clk/qcom/clk-regmap-mux.h b/drivers/clk/qcom/clk-regmap-mux.h
> > index db6f4cdd9586..f86c674ce139 100644
> > --- a/drivers/clk/qcom/clk-regmap-mux.h
> > +++ b/drivers/clk/qcom/clk-regmap-mux.h
> > @@ -14,10 +14,13 @@ struct clk_regmap_mux {
> >  	u32			reg;
> >  	u32			shift;
> >  	u32			width;
> > +	u8			safe_src_parent;
> > +	u8			stored_parent_cfg;
> >  	const struct parent_map	*parent_map;
> >  	struct clk_regmap	clkr;
> >  };
> >  
> >  extern const struct clk_ops clk_regmap_mux_closest_ops;
> > +extern const struct clk_ops clk_regmap_mux_safe_ops;
> >  
> >  #endif
> > -- 
> > 2.35.1
> > 
