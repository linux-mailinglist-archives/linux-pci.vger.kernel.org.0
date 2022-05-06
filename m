Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5208B51D7C4
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 14:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391873AbiEFMev (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 08:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbiEFMeu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 08:34:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3316571;
        Fri,  6 May 2022 05:31:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4471FB835A7;
        Fri,  6 May 2022 12:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B40C385A8;
        Fri,  6 May 2022 12:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651840265;
        bh=VUkc4x5co6VINK47Df8xTVJtnK5r1B3tZxhcXs1qt+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S/kIT51r74siNrheaEI+xbkmHIPnhAb0FXAwC34wY2yxgI1ZKHT2arEQMuKjFzkV0
         KkFFeFumJIiEsWK3CJY7JN3c4ZWv7xH/PqgxrR7UweFDIwQixt8ZE/qLC1OGbWcAEi
         7+T451Y+u86fsrt5O7MMuR2j0s5hMG0LxfKsO9JlCC1rvYlvixY1DFZTAm2wgEvEPW
         UTJAdYHB7I8aatGONXX3eDHkOdf+N4OYrp2czmnr/QQxbPmR4OTU+6LAEBo91+Y+Wn
         LHIWTq16u0yesV3xcjduGCiYXACG9TWSiMowoiaUifezjozNB7qCd7FAezkinSzK4J
         LCEuAdHuAyLZg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nmx6u-0007O0-Ul; Fri, 06 May 2022 14:31:05 +0200
Date:   Fri, 6 May 2022 14:31:04 +0200
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
Message-ID: <YnUVCCXybHUSAYx2@hovoldconsulting.com>
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
> 
> Rather than copying this sequence over and over again, follow the
> example of clk_rcg2_shared_ops and implement this parking in the
> enable() and disable() clock operations. Suppliement the regmap-mux with
> the new regmap-pipe implementation, which hides multiplexer behind
> simple branch-like clock. This is possible since each of this
> multiplexers has just two clock sources: working (pipe) and safe
> (bi_tcxo) clock sources. If the clock is running off the external pipe
> source, report it as enable and report it as disabled otherwise.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

I think this is much better and it addresses most of my concerns with
the previous approach by keeping things simple and using a dedicated
implementation (i.e. separate from regmap-mux).

The purpose of the clock implementation can be documented in the source
and is reflected in the naming. It avoids the issues related to the
caching (locking and deferred muxing) which wasn't really needed in the
first place as these muxes are binary.

By implementing is_enabled() you also allow for inspecting the state
that the boot firmware left the mux in.

The only thing that comes to mind that wouldn't be possible is to
set the mux state using an assigned clock parent in devicetree to make
sure that XO is always selected before toggling the GDSC at probe.

But since that doesn't seem to work anyway when the boot firmware has
set things up (e.g. causes a modem here to reset) that would probably
need to be handled in the GDSC driver anyway (i.e. make sure the source
is XO before enabling the GDSC but only when it was actually disabled).

Taking that one step further would be to implement all this in the GDSC
driver from the start so that the PHY PLL is always muxed in while the
power domain is enabled (and only then)...

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

Since pipe is so overloaded already can we call this "pipe_mux" or
"pipe_src" instead of just "pipe"?

And similarly for

	pipe_mux_is_enabled()
	struct clk_regmap_pipe_mux
	struct clk_regmap_pipe_mux_ops

etc.

> +	struct clk_regmap *clkr = to_clk_regmap(hw);
> +	unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
> +	unsigned int val;
> +
> +	regmap_read(clkr->regmap, pipe->reg, &val);
> +	val = (val & mask) >> pipe->shift;
> +
> +	WARN_ON(unlikely(val != pipe->enable_val && val != pipe->disable_val));

This is not a hot path and there's rarely a need for unlikely().

> +
> +	return val == pipe->enable_val;
> +}

Johan
