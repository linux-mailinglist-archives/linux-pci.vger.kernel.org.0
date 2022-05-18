Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D9B52C1DB
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 20:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbiERR6O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 13:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiERR6N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 13:58:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF658AE68;
        Wed, 18 May 2022 10:58:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FF55B8218F;
        Wed, 18 May 2022 17:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC29AC385A5;
        Wed, 18 May 2022 17:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652896689;
        bh=/lf475nm3zuRlZT8wMBYstjA3ck/eTxGA0KChiE/CYE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=h9HFVrD7LlHHf71r8KWnJIPgC3IclfVv/K91EQbJ+wHimWDEjK/iB1a5GL9bzEy9Z
         qjK8kl58NHJ9MRVciwI+CM9FMKKhSUUZ1i+74z2aQI1bQPIx9vBaCXlGnPk5sIgPq1
         w/VhFWf2uJPeycJchUC0y0Sy5dqbDfXF3OQETkBu8w2GO0IH3Q9ZSH2ukge46Tb1ho
         mqC8J3vsz33GLS/6+h1aHkXumtBrpQUKFlXPbx4X5hFhfL6WF7+23gMM5+TyMoE17U
         QKOgU17IsL5OTRjy6LYtVhNpSQvRafD9k/uXs1a+JNl2aad7ioag8cHHm6gPQSoZl+
         yiZcqAtD8IQoA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220513175339.2981959-3-dmitry.baryshkov@linaro.org>
References: <20220513175339.2981959-1-dmitry.baryshkov@linaro.org> <20220513175339.2981959-3-dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v6 2/5] clk: qcom: regmap: add PHY clock source implementation
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Date:   Wed, 18 May 2022 10:58:06 -0700
User-Agent: alot/0.10
Message-Id: <20220518175808.EC29AC385A5@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Dmitry Baryshkov (2022-05-13 10:53:36)
> diff --git a/drivers/clk/qcom/clk-regmap-phy-mux.c b/drivers/clk/qcom/clk=
-regmap-phy-mux.c
> new file mode 100644
> index 000000000000..d7a45f7fa1aa
> --- /dev/null
> +++ b/drivers/clk/qcom/clk-regmap-phy-mux.c
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

clk-provider.h for clk_hw/clk_ops usage. It helps with grep to identify
clk providers.

> +
> +#include "clk-regmap-phy-mux.h"

Same for clk-regmap.h, avoid include hell.

> +
> +static inline struct clk_regmap_phy_mux *to_clk_regmap_phy_mux(struct cl=
k_hw *hw)
> +{
> +       return container_of(to_clk_regmap(hw), struct clk_regmap_phy_mux,=
 clkr);
> +}
> +
> +static int phy_mux_is_enabled(struct clk_hw *hw)
> +{
> +       struct clk_regmap_phy_mux *phy_mux =3D to_clk_regmap_phy_mux(hw);
> +       struct clk_regmap *clkr =3D to_clk_regmap(hw);
> +       unsigned int mask =3D GENMASK(phy_mux->width + phy_mux->shift - 1=
, phy_mux->shift);
> +       unsigned int val;
> +
> +       regmap_read(clkr->regmap, phy_mux->reg, &val);
> +       val =3D (val & mask) >> phy_mux->shift;

Can this use FIELD_GET?

> +
> +       WARN_ON(val !=3D phy_mux->phy_src_val && val !=3D phy_mux->ref_sr=
c_val);
> +
> +       return val =3D=3D phy_mux->phy_src_val;
> +}
> +
> +static int phy_mux_enable(struct clk_hw *hw)
> +{
> +       struct clk_regmap_phy_mux *phy_mux =3D to_clk_regmap_phy_mux(hw);
> +       struct clk_regmap *clkr =3D to_clk_regmap(hw);
> +       unsigned int mask =3D GENMASK(phy_mux->width + phy_mux->shift - 1=
, phy_mux->shift);
> +       unsigned int val;
> +
> +       val =3D phy_mux->phy_src_val << phy_mux->shift;

Can this use FIELD_PREP?

> +
> +       return regmap_update_bits(clkr->regmap, phy_mux->reg, mask, val);
> +}
> +
> +static void phy_mux_disable(struct clk_hw *hw)
> +{
> +       struct clk_regmap_phy_mux *phy_mux =3D to_clk_regmap_phy_mux(hw);
> +       struct clk_regmap *clkr =3D to_clk_regmap(hw);
> +       unsigned int mask =3D GENMASK(phy_mux->width + phy_mux->shift - 1=
, phy_mux->shift);
> +       unsigned int val;
> +
> +       val =3D phy_mux->ref_src_val << phy_mux->shift;
> +
> +       regmap_update_bits(clkr->regmap, phy_mux->reg, mask, val);
> +}
> +
> +const struct clk_ops clk_regmap_phy_mux_ops =3D {
> +       .enable =3D phy_mux_enable,
> +       .disable =3D phy_mux_disable,
> +       .is_enabled =3D phy_mux_is_enabled,
> +};
> +EXPORT_SYMBOL_GPL(clk_regmap_phy_mux_ops);
> diff --git a/drivers/clk/qcom/clk-regmap-phy-mux.h b/drivers/clk/qcom/clk=
-regmap-phy-mux.h
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

Remove "special" please. Everything is special :)

> + *
> + * If the clock is running off the from-PHY source, report it as enabled.

from-PHY is @phy_src_val? Maybe add that information like "from-PHY
source (@phy_src_val)"

> + * Report it as disabled otherwise (if it uses reference source).

Same for @ref_src_val

> + *
> + * This way the PHY will disable the pipe clock before turning off the G=
DSC,
> + * which in turn would lead to disabling corresponding pipe_clk_src (and=
 thus
> + * it being parked to a safe, reference clock source). And vice versa, a=
fter
> + * enabling the GDSC the PHY will enable the pipe clock, which would cau=
se
> + * pipe_clk_src to be switched from a safe source to the working one.

Might as well make it into real kernel-doc at the same time.

> + */
> +
> +struct clk_regmap_phy_mux {
> +       u32                     reg;
> +       u32                     shift;
> +       u32                     width;

Technically neither of these need to be u32 and could be u8 to save a
byte or two. The other thing is that possibly the width and shift never
changes? The RCG layout is pretty well fixed. Does hardcoding it work?

> +       u32                     phy_src_val;
> +       u32                     ref_src_val;

I feel like "_val" is redundant. Just "ref_src" and "phy_src"? Shorter
is nice.

> +       struct clk_regmap       clkr;
> +};
> +
> +extern const struct clk_ops clk_regmap_phy_mux_ops;
