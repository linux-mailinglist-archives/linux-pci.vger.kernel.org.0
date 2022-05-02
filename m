Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4082516DF1
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 12:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384378AbiEBKOc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 06:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384385AbiEBKO3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 06:14:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29A6165A4
        for <linux-pci@vger.kernel.org>; Mon,  2 May 2022 03:11:00 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id iq10so12316874pjb.0
        for <linux-pci@vger.kernel.org>; Mon, 02 May 2022 03:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=51p6qZNBJiDNSyR06sFL2MDxuNy9668AYthskXARKF4=;
        b=bEA9U7BV/mb3zQiT1s76YPHqv6RCcRKwIdeA3+hQi0G7dKWkAZxwskhDN9Egh0O2TF
         EeYb5cTstgq2E4l/KJwUH0PnhU1fGB3Xw8R1cMk1VlrFhH+yArlaPb+BrAVfPBTCNjn+
         CGSn2MqG0MGPA9fXwybVrfcggMY950JGLytW+jkZB2TnsH3oGN80bITjWSC8esW476wX
         2VBiZedZkHTXW17CNWuUR0LcnAUX0ESZmNwbVhn4WQfB3I0wj8jyJqSoJIkFmuuxKwF+
         nPT3BwooOgKNBbYNjpWxHFdVkBJAq+ZjWuqVz5XrZp2ACcaMW1nL+2njb/IcAIk1HiRc
         fHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=51p6qZNBJiDNSyR06sFL2MDxuNy9668AYthskXARKF4=;
        b=3s0NrdVYwHURreiWscCBjRfn+cw76xR8HR/ec6NzbhL250l6Mru/esFFbFU6XNAlkY
         1w67aGrQXTl+8C/L/LACYbMZ2N3Ikn4p0lsypIC5mwu20psAS+QQuaxYKCJIw5SwCdPP
         PY37akqsRLn+X3gMZarKgL09IjBK4rZdmHKk8kQhlfQVEcs5BqonWFnFi8BplPqfpshR
         +fpY+4+nZB3v3c4p0HoE9GVVjBZ8he9acvUtdNzBICRdl7pxOnxzEiWuag2Se4nWSHFb
         7jcCeF75DlTyf5Cy/CO7s8DeeNOiDmrxV8vFJKeQUA72okIj5entFDEyZo5YiXuWXcPU
         iZnA==
X-Gm-Message-State: AOAM530omCg2LTLJDuzNlE2RY5TnASdNlGPlBsVIj9FVf3xOJzWpZ5fP
        Ax9uPp7J8x+V7aRz6wUrVyvH
X-Google-Smtp-Source: ABdhPJzEtjr+0BChtfyBzyEORpBftBSZP2W/TPoMuupJQBJE6Eo9PXxESeWUchF9F1WziEdRc82pvQ==
X-Received: by 2002:a17:902:ef45:b0:155:cede:5a9d with SMTP id e5-20020a170902ef4500b00155cede5a9dmr10751503plx.93.1651486260027;
        Mon, 02 May 2022 03:11:00 -0700 (PDT)
Received: from thinkpad ([27.111.75.99])
        by smtp.gmail.com with ESMTPSA id d29-20020a631d1d000000b003c14af50641sm10940497pgd.89.2022.05.02.03.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 03:10:59 -0700 (PDT)
Date:   Mon, 2 May 2022 15:40:53 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Message-ID: <20220502101053.GF5053@thinkpad>
References: <20220501192149.4128158-1-dmitry.baryshkov@linaro.org>
 <20220501192149.4128158-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501192149.4128158-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

Sorry for chiming in late and providing comments that might have been addressed
before. But I have few questions below:

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

Selecting the clk parents in the enable/disable callback seems fine to me but
the way it is implemented doesn't look right.

First this "pipe_clksrc" is a mux clk by design, since we can only select the
parent. But you are converting it to a gate clk now.

Instead of that, my proposal would be to make this clk a composite one i.e,.
gate clk + mux clk. So even though the gate clk here would be a hack, we are
not changing the definition of mux clk.

So you can introduce a new ops like "clk_regmap_mux_gate_ops" and implement the
parent switching logic in the enable/disable callbacks. Additional benefit of
this ops is, in the future we can also support "gate + mux" clks easily.

Also, please don't use the "enable_val/disable_val" members. It should be
something like "mux_sel_pre/mux_sel_post".

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

Linaro

> + * Author: Dmitry Baryshkov

No email?

Thanks,
Mani

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
> +	struct clk_regmap	clkr;
> +};
> +
> +extern const struct clk_ops clk_regmap_pipe_ops;
> +
> +#endif
> -- 
> 2.35.1
> 
