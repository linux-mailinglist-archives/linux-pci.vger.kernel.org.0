Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CA051F996
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 12:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbiEIKVb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 06:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbiEIKVL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 06:21:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8A2101145;
        Mon,  9 May 2022 03:17:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2440F60C79;
        Mon,  9 May 2022 10:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCC3C385A8;
        Mon,  9 May 2022 10:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652091437;
        bh=YNfsqlT+ik0O8KSAQr8JF99F9smz8/G4yx71Mp/NcmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fNqzduKp2eb5/MxmWQSgMMPFJmVhr9pv4Sg9uopaZ/cLL6Tw7Dvg0iLE0dqL5vq4i
         Ln6pY8KEqnU5QMV4k8SBSjoHtTDUUfVTEg62VKyzHPZkRes7whzoI+jvLQyRozLEnW
         YqL+/DkIBRtnZPQx0JtpakUzAphJ+n21qHHKXQp8PlOUaTJ06NDB7NE9J6NFUjElxf
         e9pWCnO/SpjKhFS0Z3xoVTRb6gn9V2jycCzWZ6WEvbVuEHdwUBjjMNYBDv3xKCSX63
         p5TAvWVbUDFd6WW2pLXt6i91B1/lmaM6/O7qtUoXTyCvYmAz1GkBg0tL+Bw0EmSQvd
         V1hK0U8pzeKHQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1no0S2-00067O-LT; Mon, 09 May 2022 12:17:14 +0200
Date:   Mon, 9 May 2022 12:17:14 +0200
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
Subject: Re: [PATCH v4 2/5] clk: qcom: regmap: add pipe clk implementation
Message-ID: <YnjqKnkgsK+Eki4z@hovoldconsulting.com>
References: <20220501192149.4128158-1-dmitry.baryshkov@linaro.org>
 <20220501192149.4128158-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501192149.4128158-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, May 01, 2022 at 10:21:46PM +0300, Dmitry Baryshkov wrote:
> On recent Qualcomm platforms the QMP PIPE clocks feed into a set of
> muxes which must be parked to the "safe" source (bi_tcxo) when
> corresponding GDSC is turned off and on again. Currently this is
> handcoded in the PCIe driver by reparenting the gcc_pipe_N_clk_src
> clock. However the same code sequence should be applied in the
> pcie-qcom endpoint, USB3 and UFS drivers.

I noticed that the vendor kernel does not implement this for UFS (yet),
and the PHY PLL is left muxed in for UFS by the boot firmware on the
platforms I have.

But supposedly it is needed, so perhaps this should be reflected in the
naming from the start by using a more generic name than "pipe". Maybe
something like struct clk_regmap_phy_mux?
 
> Rather than copying this sequence over and over again, follow the
> example of clk_rcg2_shared_ops and implement this parking in the
> enable() and disable() clock operations. Suppliement the regmap-mux with

typo: supplement

> the new regmap-pipe implementation, which hides multiplexer behind
> simple branch-like clock. 

Please rephrase the above. I understand what you mean, but that may not
be case with someone less familiar with the details. Perhaps explain it
along the lines of modelling the multiplexer as a gate.

And you shouldn't take the "hiding" too far and obfuscate the fact that
this is a multiplexer in the implementation.

Renaming some of the structures and fields should make the
implementation more obvious. I already suggested adding a suffix to the
use of "pipe" which really refers to the pipe mux.

Similarly, using another name for the enable/disable value fields may
make it easier to see what it's going on here.

> This is possible since each of this
> multiplexers has just two clock sources: working (pipe) and safe
> (bi_tcxo) clock sources. If the clock is running off the external pipe
> source, report it as enable and report it as disabled otherwise.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/clk/qcom/Makefile          |  1 +
>  drivers/clk/qcom/clk-regmap-pipe.c | 62 ++++++++++++++++++++++++++++++
>  drivers/clk/qcom/clk-regmap-pipe.h | 24 ++++++++++++
>  3 files changed, 87 insertions(+)
>  create mode 100644 drivers/clk/qcom/clk-regmap-pipe.c
>  create mode 100644 drivers/clk/qcom/clk-regmap-pipe.h
> 
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 671cf5821af1..882c8ecc2e93 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -11,6 +11,7 @@ clk-qcom-y += clk-branch.o
>  clk-qcom-y += clk-regmap-divider.o
>  clk-qcom-y += clk-regmap-mux.o
>  clk-qcom-y += clk-regmap-mux-div.o
> +clk-qcom-y += clk-regmap-pipe.o
>  clk-qcom-$(CONFIG_KRAIT_CLOCKS) += clk-krait.o
>  clk-qcom-y += clk-hfpll.o
>  clk-qcom-y += reset.o
> diff --git a/drivers/clk/qcom/clk-regmap-pipe.c b/drivers/clk/qcom/clk-regmap-pipe.c
> new file mode 100644
> index 000000000000..9a7c27cc644b
> --- /dev/null
> +++ b/drivers/clk/qcom/clk-regmap-pipe.c
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
> +#include "clk-regmap-pipe.h"
> +
> +static inline struct clk_regmap_pipe *to_clk_regmap_pipe(struct clk_hw *hw)
> +{
> +	return container_of(to_clk_regmap(hw), struct clk_regmap_pipe, clkr);
> +}
> +
> +static int pipe_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_regmap_pipe *pipe = to_clk_regmap_pipe(hw);
> +	struct clk_regmap *clkr = to_clk_regmap(hw);
> +	unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
> +	unsigned int val;
> +
> +	regmap_read(clkr->regmap, pipe->reg, &val);
> +	val = (val & mask) >> pipe->shift;
> +
> +	WARN_ON(unlikely(val != pipe->enable_val && val != pipe->disable_val));
> +
> +	return val == pipe->enable_val;
> +}
> +
> +static int pipe_enable(struct clk_hw *hw)
> +{
> +	struct clk_regmap_pipe *pipe = to_clk_regmap_pipe(hw);
> +	struct clk_regmap *clkr = to_clk_regmap(hw);
> +	unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
> +	unsigned int val;
> +
> +	val = pipe->enable_val << pipe->shift;
> +
> +	return regmap_update_bits(clkr->regmap, pipe->reg, mask, val);

So the above would be more obvious as something like

	static int pipe_mux_enable() {
		...

		val = mux->pipe_clk_val << mux->shift;
		...
	}

instead making it look like it is a gate (or maybe phy_mux_enable()
etc).

> +}
> +
> +static void pipe_disable(struct clk_hw *hw)
> +{
> +	struct clk_regmap_pipe *pipe = to_clk_regmap_pipe(hw);
> +	struct clk_regmap *clkr = to_clk_regmap(hw);
> +	unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
> +	unsigned int val;
> +
> +	val = pipe->disable_val << pipe->shift;

And similar by using something like xo_clk_val here.

> +
> +	regmap_update_bits(clkr->regmap, pipe->reg, mask, val);
> +}
> +
> +const struct clk_ops clk_regmap_pipe_ops = {
> +	.enable = pipe_enable,
> +	.disable = pipe_disable,
> +	.is_enabled = pipe_is_enabled,
> +};
> +EXPORT_SYMBOL_GPL(clk_regmap_pipe_ops);
> diff --git a/drivers/clk/qcom/clk-regmap-pipe.h b/drivers/clk/qcom/clk-regmap-pipe.h
> new file mode 100644
> index 000000000000..cfaa792a029b
> --- /dev/null
> +++ b/drivers/clk/qcom/clk-regmap-pipe.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022, Linaru Ltd.
> + * Author: Dmitry Baryshkov
> + */
> +
> +#ifndef __QCOM_CLK_REGMAP_PIPE_H__
> +#define __QCOM_CLK_REGMAP_PIPE_H__
> +
> +#include <linux/clk-provider.h>
> +#include "clk-regmap.h"
> +
> +struct clk_regmap_pipe {
> +	u32			reg;
> +	u32			shift;
> +	u32			width;
> +	u32			enable_val;
> +	u32			disable_val;

So this could be
	
	pipe_clk_val
	xo_clk_val

and you wouldn't need to add comments in every mux definition.

> +	struct clk_regmap	clkr;
> +};
> +
> +extern const struct clk_ops clk_regmap_pipe_ops;
> +
> +#endif

Johan
