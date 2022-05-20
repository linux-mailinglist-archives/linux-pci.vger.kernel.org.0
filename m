Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8864A52EFFB
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 18:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351312AbiETQEG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 12:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242089AbiETQEF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 12:04:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADDE17CE46;
        Fri, 20 May 2022 09:04:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44BFAB82C4E;
        Fri, 20 May 2022 16:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4171C34100;
        Fri, 20 May 2022 16:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653062642;
        bh=YeGJKPJHDvFCGBv8yruGYmLxXgiUwVSyw6y7dTSAUI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m0j9iT85np1fFZ5QWV09+pUu0gNYGIVcWBJwLhVAsebcsCPuDH+JnhAtwrYW688Iu
         6EeiG5xxks8XZ5IDDLwXeSKOJkzIl5tLiTRN0ReyzSTUqjHTWoeD75CqUWeShSzqFp
         a2t3R1eM9di5CIVhcb4MUVM9qg6r/m8VYqZ5eF5TqxlcB4Ae52kWz/tYoLcN6pQVfv
         i5afkKafkeu3F9hMtIL3UVV4y16qj5oSIDJX66OQmalwV4eJfy+HWWaDD0jdqpKvua
         p8TGatdpiERqFkbtUvmB5DDe5B4segNjkQFLBFV2O/011GhElbR+U+p9xAiRKzndyo
         0syphMemdWX0w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ns56g-00085Y-4Q; Fri, 20 May 2022 18:04:02 +0200
Date:   Fri, 20 May 2022 18:04:02 +0200
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
Subject: Re: [PATCH v7 2/6] clk: qcom: regmap: add PHY clock source
 implementation
Message-ID: <Yoe78gvFkSB+UF7w@hovoldconsulting.com>
References: <20220520015844.1190511-1-dmitry.baryshkov@linaro.org>
 <20220520015844.1190511-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520015844.1190511-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 20, 2022 at 04:58:40AM +0300, Dmitry Baryshkov wrote:
> On recent Qualcomm platforms the QMP PIPE clocks feed into a set of
> muxes which must be parked to the "safe" source (bi_tcxo) when
> corresponding GDSC is turned off and on again. Currently this is
> handcoded in the PCIe driver by reparenting the gcc_pipe_N_clk_src
> clock. However the same code sequence should be applied in the
> pcie-qcom endpoint, USB3 and UFS drivers.
> 
> Rather than copying this sequence over and over again, follow the
> example of clk_rcg2_shared_ops and implement this parking in the
> enable() and disable() clock operations. Supplement the regmap-mux with
> the new clk_regmap_phy_mux type, which implements such multiplexers
> as a simple gate clocks.
> 
> This is possible since each of these multiplexers has just two clock
> sources: one coming from the PHY and a reference (XO) one.  If the clock
> is running off the from-PHY source, report it as enabled. Report it as
> disabled otherwise (if it uses reference source).
> 
> This way the PHY will disable the pipe clock before turning off the
> GDSC, which in turn would lead to disabling corresponding pipe_clk_src
> (and thus it being parked to a safe, reference clock source). And vice
> versa, after enabling the GDSC the PHY will enable the pipe clock, which
> would cause pipe_clk_src to be switched from a safe source to the
> working one.
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>

I haven't reviewed or tested this version yet...

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/clk/qcom/Makefile             |  1 +
>  drivers/clk/qcom/clk-regmap-phy-mux.c | 53 +++++++++++++++++++++++++++
>  drivers/clk/qcom/clk-regmap.h         | 17 +++++++++
>  3 files changed, 71 insertions(+)
>  create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.c
> 
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index dff6aeb980e6..6d242f46bd1d 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -11,6 +11,7 @@ clk-qcom-y += clk-branch.o
>  clk-qcom-y += clk-regmap-divider.o
>  clk-qcom-y += clk-regmap-mux.o
>  clk-qcom-y += clk-regmap-mux-div.o
> +clk-qcom-y += clk-regmap-phy-mux.o
>  clk-qcom-$(CONFIG_KRAIT_CLOCKS) += clk-krait.o
>  clk-qcom-y += clk-hfpll.o
>  clk-qcom-y += reset.o
> diff --git a/drivers/clk/qcom/clk-regmap-phy-mux.c b/drivers/clk/qcom/clk-regmap-phy-mux.c
> new file mode 100644
> index 000000000000..dc96714a6175
> --- /dev/null
> +++ b/drivers/clk/qcom/clk-regmap-phy-mux.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022, Linaro Ltd.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/bitops.h>
> +#include <linux/regmap.h>
> +#include <linux/export.h>
> +
> +#include "clk-regmap.h"
> +
> +#define PHY_MUX_MASK		GENMASK(1, 0)
> +#define PHY_MUX_PHY_SRC		0
> +#define PHY_MUX_REF_SRC		2
> +
> +static int phy_mux_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clkr = to_clk_regmap(hw);
> +	unsigned int val;
> +
> +	regmap_read(clkr->regmap, clkr->enable_reg, &val);
> +	val = FIELD_GET(PHY_MUX_MASK, val);
> +
> +	WARN_ON(val != PHY_MUX_PHY_SRC && val != PHY_MUX_REF_SRC);
> +
> +	return val == PHY_MUX_PHY_SRC;
> +}
> +
> +static int phy_mux_enable(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clkr = to_clk_regmap(hw);
> +
> +	return regmap_update_bits(clkr->regmap, clkr->enable_reg,
> +				  PHY_MUX_MASK,
> +				  FIELD_PREP(PHY_MUX_MASK, PHY_MUX_PHY_SRC));
> +}
> +
> +static void phy_mux_disable(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clkr = to_clk_regmap(hw);
> +
> +	regmap_update_bits(clkr->regmap, clkr->enable_reg,
> +			   PHY_MUX_MASK,
> +			   FIELD_PREP(PHY_MUX_MASK, PHY_MUX_REF_SRC));
> +}

I prefer the implementation where you had a dedicated struct
clk_regmap_phy_mux to match the ops rather than repurpose the clk_regmap
and its enable_reg.

This is a mux and that should be reflected in the implementation (even if
it's modelled as a gate).

This will also make it easier to add further fields which there are
indications that we may need to do pretty soon.

> +
> +const struct clk_ops clk_regmap_phy_mux_ops = {
> +	.enable = phy_mux_enable,
> +	.disable = phy_mux_disable,
> +	.is_enabled = phy_mux_is_enabled,
> +};
> +EXPORT_SYMBOL_GPL(clk_regmap_phy_mux_ops);
> diff --git a/drivers/clk/qcom/clk-regmap.h b/drivers/clk/qcom/clk-regmap.h
> index 14ec659a3a77..a58cd1d790fe 100644
> --- a/drivers/clk/qcom/clk-regmap.h
> +++ b/drivers/clk/qcom/clk-regmap.h
> @@ -35,4 +35,21 @@ int clk_enable_regmap(struct clk_hw *hw);
>  void clk_disable_regmap(struct clk_hw *hw);
>  int devm_clk_register_regmap(struct device *dev, struct clk_regmap *rclk);
>  
> +/*
> + * A clock implementation for PHY pipe and symbols clock muxes.
> + *
> + * If the clock is running off the from-PHY source, report it as enabled.
> + * Report it as disabled otherwise (if it uses reference source).
> + *
> + * This way the PHY will disable the pipe clock before turning off the GDSC,
> + * which in turn would lead to disabling corresponding pipe_clk_src (and thus
> + * it being parked to a safe, reference clock source). And vice versa, after
> + * enabling the GDSC the PHY will enable the pipe clock, which would cause
> + * pipe_clk_src to be switched from a safe source to the working one.
> + *
> + * For some platforms this should be used for the UFS symbol_clk_src clocks
> + * too.
> + */
> +extern const struct clk_ops clk_regmap_phy_mux_ops;
> +
>  #endif

Johan
