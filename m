Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AD453E8ED
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jun 2022 19:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiFFQfV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jun 2022 12:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241783AbiFFQfU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jun 2022 12:35:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF065A0B7;
        Mon,  6 Jun 2022 09:35:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A43E60F80;
        Mon,  6 Jun 2022 16:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7411EC385A9;
        Mon,  6 Jun 2022 16:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654533316;
        bh=HeKvPcFU8axWThjfKOuIbOklyymvjKBlfRrKQHMpvYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t5ZPxJ24OMXc8YiaYgvvRvUryVh6Z0C+/TysM93P6NaK1EZvuZ5J5YbiFHNudQNc4
         LBGslzZ4vV/yDDcnEvtLIw8YAVtmFplytavcUl19PKgbgdH3UjX0+3tPiTk+i5klUI
         ugWYx+JDhSZuTRd3ejarIobYudG2B81LFNIQx9TFeumx+Ew6ONjCzPAZn5ct0d8PLa
         PbzgMo0XZ8NIxrer/yxvWTE9lenbcMNukL3/mE1Hui6BerGX0e2UAGXbim0fD43yqy
         +VV1b35uj6e5YKAjsVzMrSPnEDOmHjtrIGSiEiSQantod6WCSz2PYx9bNUa3MEXEbt
         28MasRGnIW01Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nyFh8-0004Ez-Ax; Mon, 06 Jun 2022 18:35:10 +0200
Date:   Mon, 6 Jun 2022 18:35:10 +0200
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
Subject: Re: [PATCH v10 1/5] clk: qcom: regmap: add PHY clock source
 implementation
Message-ID: <Yp4svqvO4QX+z3UO@hovoldconsulting.com>
References: <20220603084454.1861142-1-dmitry.baryshkov@linaro.org>
 <20220603084454.1861142-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603084454.1861142-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 03, 2022 at 11:44:50AM +0300, Dmitry Baryshkov wrote:
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
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/clk/qcom/Makefile             |  1 +
>  drivers/clk/qcom/clk-regmap-phy-mux.c | 62 +++++++++++++++++++++++++++
>  drivers/clk/qcom/clk-regmap-phy-mux.h | 33 ++++++++++++++
>  3 files changed, 96 insertions(+)
>  create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.c
>  create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.h
> 
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 36789f5233ef..08594230c1c1 100644
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
> index 000000000000..a1adc075b471
> --- /dev/null
> +++ b/drivers/clk/qcom/clk-regmap-phy-mux.c
> @@ -0,0 +1,62 @@
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
> +#include "clk-regmap-phy-mux.h"
> +
> +#define PHY_MUX_MASK		GENMASK(1, 0)
> +#define PHY_MUX_PHY_SRC		0
> +#define PHY_MUX_REF_SRC		2
> +
> +static inline struct clk_regmap_phy_mux *to_clk_regmap_phy_mux(struct clk_regmap *clkr)
> +{
> +	return container_of(clkr, struct clk_regmap_phy_mux, clkr);
> +}
> +
> +static int phy_mux_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clkr = to_clk_regmap(hw);
> +	struct clk_regmap_phy_mux *phy_mux = to_clk_regmap_phy_mux(clkr);
> +	unsigned int val;
> +
> +	regmap_read(clkr->regmap, phy_mux->reg, &val);
> +	val = FIELD_GET(PHY_MUX_MASK, val);

As reported by the build bot, you need to include linux/bitfield.h
explicitly for the FIELD macros.

Johan
