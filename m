Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235364FF32E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 11:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiDMJSB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 05:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiDMJSA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 05:18:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD971245B6;
        Wed, 13 Apr 2022 02:15:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3721861B65;
        Wed, 13 Apr 2022 09:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF9CC385AD;
        Wed, 13 Apr 2022 09:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649841338;
        bh=7gv8n9sZbHEBMpYf/WaXUD9WERbNzyDJPUSPAwT/RuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jzdcG2M40kGlN6MyPAc/+Z2k5q7V4Ox8Dgk8+YiEHGyNoUfl3Hmvb4o2HSDwEa+Fr
         AiYAFgzGOrbR/8SIauuOJk7jAq8G/oQswgzqElT+bZdMylkL2epIsxZn+6RKG6Ht51
         1sa6AoIuFsXanpYF5Pc9hOADkuXODTs/hx5O8nsDeBpNeyxxpMoh+PgqdYcMSa5H6H
         rxqPRcy1wVDgk2gEXYShBkqLLES0U4xv/RKd2QORF9kZ8aDhYTV6+9hLa/c2/D69O4
         VBplZT373Yts54JLo73Uu7JZDkRo8/8XJGVrVANPDlhCDc9IxDU29ZoHJJbh05qKs3
         jYXpuNgfm3T6g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1neZ64-0005OB-CF; Wed, 13 Apr 2022 11:15:33 +0200
Date:   Wed, 13 Apr 2022 11:15:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/5] clk: qcom: regmap-mux: add pipe clk implementation
Message-ID: <YlaUtCuMZZL4bM2U@hovoldconsulting.com>
References: <20220412193839.2545814-1-dmitry.baryshkov@linaro.org>
 <20220412193839.2545814-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412193839.2545814-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 12, 2022 at 10:38:35PM +0300, Dmitry Baryshkov wrote:
> On recent Qualcomm platforms the QMP PIPE clocks feed into a set of
> muxes which must be parked to the "safe" source (bi_tcxo) when
> corresponding GDSC is turned off and on again. Currently this is
> handcoded in the PCIe driver by reparenting the gcc_pipe_N_clk_src
> clock. However the same code sequence should be applied in the
> pcie-qcom endpoint, USB3 and UFS drivers.

I'm starting to think this really belongs in the PHY driver which is the
provider of the pipe clock. Moving it there would also allow the code to
be shared between PCIe, USB, and UFS.

The PHY driver enables the pipe clock by starting the PHY and before
doing so there's no point in updating the mux. Similarly, the PHY driver
can restore the "safe" source after disabling the pipe clock.

That way there's no magic happening behind scenes, the clock framework
always reports the actual state of the tree, and the reason for all of
this can be documented in the QMP PHY driver once and for all.

The only change to the bindings compared to what this series proposes is
that the PHY driver also needs a reference to bi_tcxo.

Also note that updating the mux separately from starting the PHY as this
series allows for, doesn't really make the pipe clock any safer to use.

Either way, there are also some problems with this safe-mux
implementation that I point out below.

> Rather than copying this sequence over and over again, follow the
> example of clk_rcg2_shared_ops and implement this parking in the
> enable() and disable() clock operations. As we are changing the parent
> behind the back of the clock framework, also implement custom
> set_parent() and get_parent() operations behaving accroding to the clock
> framework expectations (cache the new parent if the clock is in disabled
> state, return cached parent).
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/clk/qcom/clk-regmap-mux.c | 78 +++++++++++++++++++++++++++++++
>  drivers/clk/qcom/clk-regmap-mux.h |  3 ++
>  2 files changed, 81 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-regmap-mux.c b/drivers/clk/qcom/clk-regmap-mux.c
> index 45d9cca28064..c39ee783ee83 100644
> --- a/drivers/clk/qcom/clk-regmap-mux.c
> +++ b/drivers/clk/qcom/clk-regmap-mux.c
> @@ -49,9 +49,87 @@ static int mux_set_parent(struct clk_hw *hw, u8 index)
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
> +	val = mux->stored_parent_cfg;
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
> +	mux->stored_parent_cfg = index;
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
> +	mux->stored_parent_cfg = (val & mask) >> mux->shift;
> +
> +	val = mux->safe_src_parent;
> +	if (mux->parent_map) {
> +		int index = qcom_find_src_index(hw, mux->parent_map, val);
> +
> +		if (WARN_ON(index < 0))
> +			return;
> +
> +		val = mux->parent_map[index].cfg;
> +	}
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
> +	val = mux->stored_parent_cfg;
> +	val <<= mux->shift;
> +
> +	return regmap_update_bits(clkr->regmap, mux->reg, mask, val);
> +}

The caching of the parent is broken since set_parent() is typically not
called before enabling the clock.

This means that the above code will set the mux to its zero-initialised
value, which currently only works by chance as the pipe clock config
value happens to be zero.

For this to work generally, you'd also need to define also the
(default/initial) non-safe parent for each mux. Handling handover from
the bootloader might also be tricky.

Furthermore, the current implementation appears to ignore locking and
doesn't handle the case where set_parent() races with enable(). The
former is protected by the prepare mutex and the latter by the enable
spinlock and a driver that needs to serialise the two needs to handle
that itself.

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
> index db6f4cdd9586..f86c674ce139 100644
> --- a/drivers/clk/qcom/clk-regmap-mux.h
> +++ b/drivers/clk/qcom/clk-regmap-mux.h
> @@ -14,10 +14,13 @@ struct clk_regmap_mux {
>  	u32			reg;
>  	u32			shift;
>  	u32			width;
> +	u8			safe_src_parent;
> +	u8			stored_parent_cfg;
>  	const struct parent_map	*parent_map;
>  	struct clk_regmap	clkr;
>  };
>  
>  extern const struct clk_ops clk_regmap_mux_closest_ops;
> +extern const struct clk_ops clk_regmap_mux_safe_ops;
>  
>  #endif

Johan
