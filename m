Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3654252B39C
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 09:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiERHeg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 03:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbiERHeX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 03:34:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB38C9ECE;
        Wed, 18 May 2022 00:34:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DBE6B81EB2;
        Wed, 18 May 2022 07:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30207C385AA;
        Wed, 18 May 2022 07:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652859259;
        bh=q03n/rIHjcoPhvV6bQxULg+4tI2mUCnhFZ1qapZknH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDPBfY2YFoHPHmJDyaPiZgVyN97JxqZHqh+59JrJOWXedewLIXrdq69gilVI872F1
         wV40JPL71YuU16QmftIboIxIGrRXKBzYAsCMe5fpedFpxtBMwpjZy5lqVvw8wMNWDe
         An1BMONqhGZ18jmgGmtc8s8xsatXMWCXeQZuGcZS2isELsoZ/SAvs4Dx/ISrQqgAuu
         U7h15Ek6g/zImsnue021tRNLUX2kpEhBuu8FcvNFOs7V6xGwh85w8NItJBTRurMov2
         hp/SNgFEybUuaKsx69277ARQazRVyZtJavw7zBw9/5EBGfWIaDuA/i6S3l1vGe89gL
         qe6vhUab9Kc/A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nrECJ-0004D5-5e; Wed, 18 May 2022 09:34:19 +0200
Date:   Wed, 18 May 2022 09:34:19 +0200
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
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 2/5] clk: qcom: regmap: add PHY clock source
 implementation
Message-ID: <YoShe/rWXVq78+As@hovoldconsulting.com>
References: <20220513175339.2981959-1-dmitry.baryshkov@linaro.org>
 <20220513175339.2981959-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513175339.2981959-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 13, 2022 at 08:53:36PM +0300, Dmitry Baryshkov wrote:
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
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

This looks really good now. Thanks for sticking with it.

Just one nit below.

> diff --git a/drivers/clk/qcom/clk-regmap-phy-mux.h b/drivers/clk/qcom/clk-regmap-phy-mux.h
> new file mode 100644
> index 000000000000..6260912191c5
> --- /dev/null
> +++ b/drivers/clk/qcom/clk-regmap-phy-mux.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022, Linaro Ltd.
> + * Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> + */
> +
> +#ifndef __QCOM_CLK_REGMAP_PHY_MUX_H__
> +#define __QCOM_CLK_REGMAP_PHY_MUX_H__
> +
> +#include <linux/clk-provider.h>
> +#include "clk-regmap.h"
> +
> +/*
> + * A special clock implementation for PHY pipe and symbols clock sources.

s/sources/muxes/

> + *
> + * If the clock is running off the from-PHY source, report it as enabled.
> + * Report it as disabled otherwise (if it uses reference source).
> + *
> + * This way the PHY will disable the pipe clock before turning off the GDSC,

s|pipe|pipe/symbol|

> + * which in turn would lead to disabling corresponding pipe_clk_src (and thus
> + * it being parked to a safe, reference clock source). And vice versa, after
> + * enabling the GDSC the PHY will enable the pipe clock, which would cause

s|pipe|pipe/symbol|

> + * pipe_clk_src to be switched from a safe source to the working one.
> + */

You're still referring to the old pipe_clk_src name in two places in
this comment.

Should this be reflected in Subject as well (e.g. "PHY mux
implementation")?

> +
> +struct clk_regmap_phy_mux {
> +	u32			reg;
> +	u32			shift;
> +	u32			width;
> +	u32			phy_src_val;
> +	u32			ref_src_val;
> +	struct clk_regmap	clkr;
> +};
> +
> +extern const struct clk_ops clk_regmap_phy_mux_ops;
> +
> +#endif

With the above fixed:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

I've also tested the series on sc8280xp-crd and sa8295p-adp:

Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan
