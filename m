Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC2B4FF441
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 11:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiDMJ7E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 05:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiDMJ7E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 05:59:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9349555BE9;
        Wed, 13 Apr 2022 02:56:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58D0213D5;
        Wed, 13 Apr 2022 02:56:43 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.8.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 900E83F73B;
        Wed, 13 Apr 2022 02:56:40 -0700 (PDT)
Date:   Wed, 13 Apr 2022 10:56:50 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
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
Message-ID: <20220413095650.GB19821@lpieralisi>
References: <20220323085010.1753493-1-dmitry.baryshkov@linaro.org>
 <20220323085010.1753493-2-dmitry.baryshkov@linaro.org>
 <YlAZVrDXwdIItyTy@lpieralisi>
 <YlXI0fg21XZPXwf4@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlXI0fg21XZPXwf4@builder.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 12, 2022 at 01:45:37PM -0500, Bjorn Andersson wrote:
> On Fri 08 Apr 06:15 CDT 2022, Lorenzo Pieralisi wrote:
> 
> > On Wed, Mar 23, 2022 at 11:50:06AM +0300, Dmitry Baryshkov wrote:
> > > On recent Qualcomm platforms the QMP PIPE clocks feed into a set of
> > > muxes which must be parked to the "safe" source (bi_tcxo) when
> > > corresponding GDSC is turned off and on again. Currently this is
> > > handcoded in the PCIe driver by reparenting the gcc_pipe_N_clk_src
> > > clock. However the same code sequence should be applied in the
> > > pcie-qcom endpoint, USB3 and UFS drivers.
> > > 
> > > Rather than copying this sequence over and over again, follow the
> > > example of clk_rcg2_shared_ops and implement this parking in the
> > > enable() and disable() clock operations. As we are changing the parent
> > > behind the back of the clock framework, also implement custom
> > > set_parent() and get_parent() operations behaving accroding to the clock
> > > framework expectations (cache the new parent if the clock is in disabled
> > > state, return cached parent).
> > > 
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  drivers/clk/qcom/clk-regmap-mux.c | 78 +++++++++++++++++++++++++++++++
> > >  drivers/clk/qcom/clk-regmap-mux.h |  3 ++
> > >  2 files changed, 81 insertions(+)
> > 
> > Need BjornA's ACK on this patch and I can pull the series then.
> > 
> 
> It seems I have a few more clock patches in the queue which depends on
> top of this, so I picked up the three clock branches and pushed a tag
> for you to pick up, Lorenzo.

There are still comments on v2 as of today that require attention.

https://lore.kernel.org/linux-pci/YlaUtCuMZZL4bM2U@hovoldconsulting.com

I will put this on hold waiting for the discussion to complete.

Lorenzo

> The following changes since commit a9ed9e2bf7940353d2ffa4faa2ad2b75a24f3ac0:
> 
>   clk: qcom: gcc-sc7280: use new clk_regmap_mux_safe_ops for PCIe pipe clocks (2022-04-12 13:32:58 -0500)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git tags/20220323085010.1753493-4-dmitry.baryshkov@linaro.org
> 
> for you to fetch changes up to a9ed9e2bf7940353d2ffa4faa2ad2b75a24f3ac0:
> 
>   clk: qcom: gcc-sc7280: use new clk_regmap_mux_safe_ops for PCIe pipe clocks (2022-04-12 13:32:58 -0500)
> 
> ----------------------------------------------------------------
> v5.18-rc1 +
> 20220323085010.1753493-2-dmitry.baryshkov@linaro.org +
> 20220323085010.1753493-3-dmitry.baryshkov@linaro.org +
> 20220323085010.1753493-4-dmitry.baryshkov@linaro.org
> 
> ----------------------------------------------------------------
> 
> Hope this works for you.
> 
> Regards,
> Bjorn
> 
> > Lorenzo
> > 
> > > diff --git a/drivers/clk/qcom/clk-regmap-mux.c b/drivers/clk/qcom/clk-regmap-mux.c
> > > index 45d9cca28064..c39ee783ee83 100644
> > > --- a/drivers/clk/qcom/clk-regmap-mux.c
> > > +++ b/drivers/clk/qcom/clk-regmap-mux.c
> > > @@ -49,9 +49,87 @@ static int mux_set_parent(struct clk_hw *hw, u8 index)
> > >  	return regmap_update_bits(clkr->regmap, mux->reg, mask, val);
> > >  }
> > >  
> > > +static u8 mux_safe_get_parent(struct clk_hw *hw)
> > > +{
> > > +	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
> > > +	unsigned int val;
> > > +
> > > +	if (clk_hw_is_enabled(hw))
> > > +		return mux_get_parent(hw);
> > > +
> > > +	val = mux->stored_parent_cfg;
> > > +
> > > +	if (mux->parent_map)
> > > +		return qcom_find_cfg_index(hw, mux->parent_map, val);
> > > +
> > > +	return val;
> > > +}
> > > +
> > > +static int mux_safe_set_parent(struct clk_hw *hw, u8 index)
> > > +{
> > > +	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
> > > +
> > > +	if (clk_hw_is_enabled(hw))
> > > +		return mux_set_parent(hw, index);
> > > +
> > > +	if (mux->parent_map)
> > > +		index = mux->parent_map[index].cfg;
> > > +
> > > +	mux->stored_parent_cfg = index;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void mux_safe_disable(struct clk_hw *hw)
> > > +{
> > > +	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
> > > +	struct clk_regmap *clkr = to_clk_regmap(hw);
> > > +	unsigned int mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
> > > +	unsigned int val;
> > > +
> > > +	regmap_read(clkr->regmap, mux->reg, &val);
> > > +
> > > +	mux->stored_parent_cfg = (val & mask) >> mux->shift;
> > > +
> > > +	val = mux->safe_src_parent;
> > > +	if (mux->parent_map) {
> > > +		int index = qcom_find_src_index(hw, mux->parent_map, val);
> > > +
> > > +		if (WARN_ON(index < 0))
> > > +			return;
> > > +
> > > +		val = mux->parent_map[index].cfg;
> > > +	}
> > > +	val <<= mux->shift;
> > > +
> > > +	regmap_update_bits(clkr->regmap, mux->reg, mask, val);
> > > +}
> > > +
> > > +static int mux_safe_enable(struct clk_hw *hw)
> > > +{
> > > +	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
> > > +	struct clk_regmap *clkr = to_clk_regmap(hw);
> > > +	unsigned int mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
> > > +	unsigned int val;
> > > +
> > > +	val = mux->stored_parent_cfg;
> > > +	val <<= mux->shift;
> > > +
> > > +	return regmap_update_bits(clkr->regmap, mux->reg, mask, val);
> > > +}
> > > +
> > >  const struct clk_ops clk_regmap_mux_closest_ops = {
> > >  	.get_parent = mux_get_parent,
> > >  	.set_parent = mux_set_parent,
> > >  	.determine_rate = __clk_mux_determine_rate_closest,
> > >  };
> > >  EXPORT_SYMBOL_GPL(clk_regmap_mux_closest_ops);
> > > +
> > > +const struct clk_ops clk_regmap_mux_safe_ops = {
> > > +	.enable = mux_safe_enable,
> > > +	.disable = mux_safe_disable,
> > > +	.get_parent = mux_safe_get_parent,
> > > +	.set_parent = mux_safe_set_parent,
> > > +	.determine_rate = __clk_mux_determine_rate_closest,
> > > +};
> > > +EXPORT_SYMBOL_GPL(clk_regmap_mux_safe_ops);
> > > diff --git a/drivers/clk/qcom/clk-regmap-mux.h b/drivers/clk/qcom/clk-regmap-mux.h
> > > index db6f4cdd9586..f86c674ce139 100644
> > > --- a/drivers/clk/qcom/clk-regmap-mux.h
> > > +++ b/drivers/clk/qcom/clk-regmap-mux.h
> > > @@ -14,10 +14,13 @@ struct clk_regmap_mux {
> > >  	u32			reg;
> > >  	u32			shift;
> > >  	u32			width;
> > > +	u8			safe_src_parent;
> > > +	u8			stored_parent_cfg;
> > >  	const struct parent_map	*parent_map;
> > >  	struct clk_regmap	clkr;
> > >  };
> > >  
> > >  extern const struct clk_ops clk_regmap_mux_closest_ops;
> > > +extern const struct clk_ops clk_regmap_mux_safe_ops;
> > >  
> > >  #endif
> > > -- 
> > > 2.35.1
> > > 
