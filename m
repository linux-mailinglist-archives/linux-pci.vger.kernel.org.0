Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E292F525D3B
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 10:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243552AbiEMIQ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 04:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378157AbiEMIQ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 04:16:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E306C1FE3CF;
        Fri, 13 May 2022 01:16:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F50E62013;
        Fri, 13 May 2022 08:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2E1C34100;
        Fri, 13 May 2022 08:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652429811;
        bh=guXp+XBSL9KDmpRUO5UOJREr+LfK1jT4s0wHUCFWfGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BveVSIgwUYfVMy1tNkHhF++xveumq+o872WnflvtHFS0BmZeW8CoBifVI9ujgHfZ7
         nPOqcFVW4Qg9np2vXSVO57TI1BJTZnCWx9iL61XcHozypJQiKFHK6HqERoZaR4sLg0
         4i8MuKs/rA3XumMypR8fsGKNgpYJB3b05E8YAWOMCSJz9p9dtj3AKJUJkZh3Ks0V1m
         FQEEjM3f3+A3oaAoFc0/wl7rhT5vLeVaUdeoSQ5R4/xkNo9RRM64nfBZ3FdW6IljHG
         YTHiJRSZT9ngN14EDwRXAdao+SQe1lAqzG//utFFHHFwY/qxeDHXf8TFVlJiLKG8Cy
         VwrPBVW/BKQTA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npQTf-0007BK-Pq; Fri, 13 May 2022 10:16:47 +0200
Date:   Fri, 13 May 2022 10:16:47 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 2/5] clk: qcom: regmap: add PHY clock source
 implementation
Message-ID: <Yn4T72U8GxwvIBBu@hovoldconsulting.com>
References: <20220512172909.2436302-1-dmitry.baryshkov@linaro.org>
 <20220512172909.2436302-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512172909.2436302-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 12, 2022 at 08:29:06PM +0300, Dmitry Baryshkov wrote:
> On recent Qualcomm platforms the QMP PIPE clocks feed into a set of
> muxes which must be parked to the "safe" source (bi_tcxo) when
> corresponding GDSC is turned off and on again. Currently this is
> handcoded in the PCIe driver by reparenting the gcc_pipe_N_clk_src
> clock. However the same code sequence should be applied in the
> pcie-qcom endpoint, USB3 and UFS drivers.

You seem to have ignored my comment regarding UFS and naming except for
the updated Subject.

For UFS the corresponding clocks would be named symbol clocks, which
seems to suggest that a more generic name is warranted. I mentioned
phy_mux as a possible alternative name for for pipe_mux (or pipe_src).

> Rather than copying this sequence over and over again, follow the
> example of clk_rcg2_shared_ops and implement this parking in the
> enable() and disable() clock operations. Supplement the regmap-mux with
> the new clk_regmap_pipe_src type, which implements such multiplexers
> as a simple gate clocks.
> 
> This is possible since each of these multiplexers has just two clock
> sources: working (pipe) and safe/park (bi_tcxo) clock sources. If the
> clock is running off the external pipe source, report it as enabled and
> report it as disabled otherwise.
> 
> This way the PHY will disable the pipe clock before turning off the
> GDSC, which in turn would lead to disabling corresponding pipe_clk_src
> (and thus parked to a safe clock srouce). And vice versa, after enabling

typo: source

> the GDSC the PHY will enable the pipe clock, which would cause
> pipe_clk_src to be switched from a safe source to the working one.

Explaining how this fits together with the PHY power sequencing is good
but it needs to be reflected in the implementation too. Preferably using
good naming, but possibly also with a comment.

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/clk/qcom/Makefile              |  1 +
>  drivers/clk/qcom/clk-regmap-pipe-src.c | 62 ++++++++++++++++++++++++++
>  drivers/clk/qcom/clk-regmap-pipe-src.h | 24 ++++++++++
>  3 files changed, 87 insertions(+)
>  create mode 100644 drivers/clk/qcom/clk-regmap-pipe-src.c
>  create mode 100644 drivers/clk/qcom/clk-regmap-pipe-src.h
> 
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 671cf5821af1..03b945535e49 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -11,6 +11,7 @@ clk-qcom-y += clk-branch.o
>  clk-qcom-y += clk-regmap-divider.o
>  clk-qcom-y += clk-regmap-mux.o
>  clk-qcom-y += clk-regmap-mux-div.o
> +clk-qcom-y += clk-regmap-pipe-src.o
>  clk-qcom-$(CONFIG_KRAIT_CLOCKS) += clk-krait.o
>  clk-qcom-y += clk-hfpll.o
>  clk-qcom-y += reset.o
> diff --git a/drivers/clk/qcom/clk-regmap-pipe-src.c b/drivers/clk/qcom/clk-regmap-pipe-src.c
> new file mode 100644
> index 000000000000..02047987ab5f
> --- /dev/null
> +++ b/drivers/clk/qcom/clk-regmap-pipe-src.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022, Linaro Ltd.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/bitops.h>
> +#include <linux/regmap.h>
> +#include <linux/export.h>
> +
> +#include "clk-regmap-pipe-src.h"
> +
> +static inline struct clk_regmap_pipe_src *to_clk_regmap_pipe_src(struct clk_hw *hw)
> +{
> +	return container_of(to_clk_regmap(hw), struct clk_regmap_pipe_src, clkr);
> +}
> +
> +static int pipe_src_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_regmap_pipe_src *pipe = to_clk_regmap_pipe_src(hw);

Again, "pipe" is so overloaded and using "mux" (or possibly "src")
throughout would make the code easier to understand.

> +	struct clk_regmap *clkr = to_clk_regmap(hw);
> +	unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
> +	unsigned int val;
> +
> +	regmap_read(clkr->regmap, pipe->reg, &val);
> +	val = (val & mask) >> pipe->shift;
> +
> +	WARN_ON(unlikely(val != pipe->working_val && val != pipe->park_val));

Again, please drop unlikely() here.

> +
> +	return val == pipe->working_val;
> +}
> +
> +static int pipe_src_enable(struct clk_hw *hw)
> +{
> +	struct clk_regmap_pipe_src *pipe = to_clk_regmap_pipe_src(hw);
> +	struct clk_regmap *clkr = to_clk_regmap(hw);
> +	unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
> +	unsigned int val;
> +
> +	val = pipe->working_val << pipe->shift;
> +
> +	return regmap_update_bits(clkr->regmap, pipe->reg, mask, val);
> +}
> +
> +static void pipe_src_disable(struct clk_hw *hw)
> +{
> +	struct clk_regmap_pipe_src *pipe = to_clk_regmap_pipe_src(hw);
> +	struct clk_regmap *clkr = to_clk_regmap(hw);
> +	unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
> +	unsigned int val;
> +
> +	val = pipe->park_val << pipe->shift;
> +
> +	regmap_update_bits(clkr->regmap, pipe->reg, mask, val);
> +}
> +
> +const struct clk_ops clk_regmap_pipe_src_ops = {
> +	.enable = pipe_src_enable,
> +	.disable = pipe_src_disable,
> +	.is_enabled = pipe_src_is_enabled,
> +};
> +EXPORT_SYMBOL_GPL(clk_regmap_pipe_src_ops);
> diff --git a/drivers/clk/qcom/clk-regmap-pipe-src.h b/drivers/clk/qcom/clk-regmap-pipe-src.h
> new file mode 100644
> index 000000000000..3aa4a9f402cd
> --- /dev/null
> +++ b/drivers/clk/qcom/clk-regmap-pipe-src.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022, Linaro Ltd.
> + * Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> + */
> +
> +#ifndef __QCOM_CLK_REGMAP_PIPE_SRC_H__
> +#define __QCOM_CLK_REGMAP_PIPE_SRC_H__
> +
> +#include <linux/clk-provider.h>
> +#include "clk-regmap.h"
> +
> +struct clk_regmap_pipe_src {
> +	u32			reg;
> +	u32			shift;
> +	u32			width;
> +	u32			working_val;
> +	u32			park_val;

Naming is hard, but I believe something like ext_src_val (or
phy_src_val) and ref_src_val (or xo_src_val) would allow the code to be
more self-explanatory and not rely on looking up the commit message to
understand where "working" and "park" came from.

You probably need to add a comment in the implementation either way.

> +	struct clk_regmap	clkr;
> +};
> +
> +extern const struct clk_ops clk_regmap_pipe_src_ops;
> +
> +#endif

Johan
