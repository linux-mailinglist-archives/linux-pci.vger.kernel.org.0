Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86D2525F35
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 12:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379153AbiEMJuf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 05:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379149AbiEMJue (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 05:50:34 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC0528203A
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 02:50:33 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id h3so6432317qtn.4
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 02:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2/d6JMVM+IfX5VGpzFFWJq2aSU3gUsGcM3lDLoJ9M7g=;
        b=qzl6XB/NInDHcgfoo/BSuClC2RyCad9DBd6T4pYvHJskLboYjga0eye7vgFzOHnqjX
         t/7A77TvzR7tUJ4zklgYHl+QRIpwNfHV1K8TBKSYnfz6ayTeauIAO69HIL3DlY92KG4O
         9lDIAE2XVSY/BWjT5+L9cibK2v6T018o3ntQiFRj2kR5GV9WK9ss7/CJ2xWyd2hcnoZy
         RJlgmmOsrJ18gedoPPG65YABIqoymrHrZ7tYKgt4LwNOcepGy6nN0B8yl8Chr1qlVRSe
         XL/z8RlC+GJJzuUiwobJDyw3c9aY7pbY2Et4y5ImlwyrHDKzzzfdbrGFyad8+HJpMNel
         I2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2/d6JMVM+IfX5VGpzFFWJq2aSU3gUsGcM3lDLoJ9M7g=;
        b=5z26bGdOPLisHP+1SHvP2B1dLRbxNpjdfOrCnWqdrblKfFDhnGmR9M3F43H1HWPAeB
         lmIlWrw6/POwjJvz6gRoVljfo2ytXr7Mx+4jw4+xRyoPadlGIq3KTNdnd5SO0PGaFl0C
         kN0F4qkmgxrX1QTw/jlvxkFcZLZqUS3QIcODuVcb0KdE6xsT4IXSqCP21cQRou/2iuTl
         X57S3hoZWtPwlhUURTnup01cIfQQeN812ui+xd/hCaCucj+SQWj+aoQ/G3Nw0MUM25Fn
         13kVBPuSbqLxiINN7GEjbl+nl4DdatgvR+OTSniqXWhhhyi1NURw+K2kFLp0XtZDlXpp
         OkxQ==
X-Gm-Message-State: AOAM530UfJYWTb+OBDOWQAk1qaZB0cOS5svamxDe9pFh2ESV5OcINpqw
        BlOxhCr8PR2jZBlUJ6WULgeu/rvP8nLJ066VvqF7SA==
X-Google-Smtp-Source: ABdhPJy13WMKLbw5Kk6gWkYNK+lV5F3+Uq7ZlpudYETXrH8/GGqs+BTbagDeGIUJF2bQFn6N7SbHAZe13tf2pZch9uk=
X-Received: by 2002:a05:622a:4f:b0:2f3:e77c:2c7e with SMTP id
 y15-20020a05622a004f00b002f3e77c2c7emr3680636qtw.62.1652435432151; Fri, 13
 May 2022 02:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220512172909.2436302-1-dmitry.baryshkov@linaro.org>
 <20220512172909.2436302-3-dmitry.baryshkov@linaro.org> <Yn4T72U8GxwvIBBu@hovoldconsulting.com>
In-Reply-To: <Yn4T72U8GxwvIBBu@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 13 May 2022 12:50:21 +0300
Message-ID: <CAA8EJpqZBry9cZ=XhwvBgqib+Y8bL0Qb=J88S1cpkKhE+OKa7Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] clk: qcom: regmap: add PHY clock source implementation
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 13 May 2022 at 11:16, Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, May 12, 2022 at 08:29:06PM +0300, Dmitry Baryshkov wrote:
> > On recent Qualcomm platforms the QMP PIPE clocks feed into a set of
> > muxes which must be parked to the "safe" source (bi_tcxo) when
> > corresponding GDSC is turned off and on again. Currently this is
> > handcoded in the PCIe driver by reparenting the gcc_pipe_N_clk_src
> > clock. However the same code sequence should be applied in the
> > pcie-qcom endpoint, USB3 and UFS drivers.
>
> You seem to have ignored my comment regarding UFS and naming except for
> the updated Subject.
>
> For UFS the corresponding clocks would be named symbol clocks, which
> seems to suggest that a more generic name is warranted. I mentioned
> phy_mux as a possible alternative name for for pipe_mux (or pipe_src).

No, I did not. For some time I had named it clk_regmap_phy_src. Then I
decided against it on the grounds of being not descriptive enough too.
There are many PHY clocks (and sources), while this mechanism is used
only for pipe and symbol clocks. So I preferred to have a descriptive
name that is further extended to be used for symbol clocks rather than
a too broad name that is used only for pipe and symbol clocks. But if
you insist, I can change this.

>
> > Rather than copying this sequence over and over again, follow the
> > example of clk_rcg2_shared_ops and implement this parking in the
> > enable() and disable() clock operations. Supplement the regmap-mux with
> > the new clk_regmap_pipe_src type, which implements such multiplexers
> > as a simple gate clocks.
> >
> > This is possible since each of these multiplexers has just two clock
> > sources: working (pipe) and safe/park (bi_tcxo) clock sources. If the
> > clock is running off the external pipe source, report it as enabled and
> > report it as disabled otherwise.
> >
> > This way the PHY will disable the pipe clock before turning off the
> > GDSC, which in turn would lead to disabling corresponding pipe_clk_src
> > (and thus parked to a safe clock srouce). And vice versa, after enabling
>
> typo: source
>
> > the GDSC the PHY will enable the pipe clock, which would cause
> > pipe_clk_src to be switched from a safe source to the working one.
>
> Explaining how this fits together with the PHY power sequencing is good
> but it needs to be reflected in the implementation too. Preferably using
> good naming, but possibly also with a comment.

Ack

>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/clk/qcom/Makefile              |  1 +
> >  drivers/clk/qcom/clk-regmap-pipe-src.c | 62 ++++++++++++++++++++++++++
> >  drivers/clk/qcom/clk-regmap-pipe-src.h | 24 ++++++++++
> >  3 files changed, 87 insertions(+)
> >  create mode 100644 drivers/clk/qcom/clk-regmap-pipe-src.c
> >  create mode 100644 drivers/clk/qcom/clk-regmap-pipe-src.h
> >
> > diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> > index 671cf5821af1..03b945535e49 100644
> > --- a/drivers/clk/qcom/Makefile
> > +++ b/drivers/clk/qcom/Makefile
> > @@ -11,6 +11,7 @@ clk-qcom-y += clk-branch.o
> >  clk-qcom-y += clk-regmap-divider.o
> >  clk-qcom-y += clk-regmap-mux.o
> >  clk-qcom-y += clk-regmap-mux-div.o
> > +clk-qcom-y += clk-regmap-pipe-src.o
> >  clk-qcom-$(CONFIG_KRAIT_CLOCKS) += clk-krait.o
> >  clk-qcom-y += clk-hfpll.o
> >  clk-qcom-y += reset.o
> > diff --git a/drivers/clk/qcom/clk-regmap-pipe-src.c b/drivers/clk/qcom/clk-regmap-pipe-src.c
> > new file mode 100644
> > index 000000000000..02047987ab5f
> > --- /dev/null
> > +++ b/drivers/clk/qcom/clk-regmap-pipe-src.c
> > @@ -0,0 +1,62 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2022, Linaro Ltd.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/bitops.h>
> > +#include <linux/regmap.h>
> > +#include <linux/export.h>
> > +
> > +#include "clk-regmap-pipe-src.h"
> > +
> > +static inline struct clk_regmap_pipe_src *to_clk_regmap_pipe_src(struct clk_hw *hw)
> > +{
> > +     return container_of(to_clk_regmap(hw), struct clk_regmap_pipe_src, clkr);
> > +}
> > +
> > +static int pipe_src_is_enabled(struct clk_hw *hw)
> > +{
> > +     struct clk_regmap_pipe_src *pipe = to_clk_regmap_pipe_src(hw);
>
> Again, "pipe" is so overloaded and using "mux" (or possibly "src")
> throughout would make the code easier to understand.

Argh. I missed that the code still uses 'pipe' here. Will fix it in
the next version.

>
> > +     struct clk_regmap *clkr = to_clk_regmap(hw);
> > +     unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
> > +     unsigned int val;
> > +
> > +     regmap_read(clkr->regmap, pipe->reg, &val);
> > +     val = (val & mask) >> pipe->shift;
> > +
> > +     WARN_ON(unlikely(val != pipe->working_val && val != pipe->park_val));
>
> Again, please drop unlikely() here.

Ack

>
> > +
> > +     return val == pipe->working_val;
> > +}
> > +
> > +static int pipe_src_enable(struct clk_hw *hw)
> > +{
> > +     struct clk_regmap_pipe_src *pipe = to_clk_regmap_pipe_src(hw);
> > +     struct clk_regmap *clkr = to_clk_regmap(hw);
> > +     unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
> > +     unsigned int val;
> > +
> > +     val = pipe->working_val << pipe->shift;
> > +
> > +     return regmap_update_bits(clkr->regmap, pipe->reg, mask, val);
> > +}
> > +
> > +static void pipe_src_disable(struct clk_hw *hw)
> > +{
> > +     struct clk_regmap_pipe_src *pipe = to_clk_regmap_pipe_src(hw);
> > +     struct clk_regmap *clkr = to_clk_regmap(hw);
> > +     unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
> > +     unsigned int val;
> > +
> > +     val = pipe->park_val << pipe->shift;
> > +
> > +     regmap_update_bits(clkr->regmap, pipe->reg, mask, val);
> > +}
> > +
> > +const struct clk_ops clk_regmap_pipe_src_ops = {
> > +     .enable = pipe_src_enable,
> > +     .disable = pipe_src_disable,
> > +     .is_enabled = pipe_src_is_enabled,
> > +};
> > +EXPORT_SYMBOL_GPL(clk_regmap_pipe_src_ops);
> > diff --git a/drivers/clk/qcom/clk-regmap-pipe-src.h b/drivers/clk/qcom/clk-regmap-pipe-src.h
> > new file mode 100644
> > index 000000000000..3aa4a9f402cd
> > --- /dev/null
> > +++ b/drivers/clk/qcom/clk-regmap-pipe-src.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) 2022, Linaro Ltd.
> > + * Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > + */
> > +
> > +#ifndef __QCOM_CLK_REGMAP_PIPE_SRC_H__
> > +#define __QCOM_CLK_REGMAP_PIPE_SRC_H__
> > +
> > +#include <linux/clk-provider.h>
> > +#include "clk-regmap.h"
> > +
> > +struct clk_regmap_pipe_src {
> > +     u32                     reg;
> > +     u32                     shift;
> > +     u32                     width;
> > +     u32                     working_val;
> > +     u32                     park_val;
>
> Naming is hard, but I believe something like ext_src_val (or
> phy_src_val) and ref_src_val (or xo_src_val) would allow the code to be
> more self-explanatory and not rely on looking up the commit message to
> understand where "working" and "park" came from.

Thanks. Yes, this looks more descriptive.

>
> You probably need to add a comment in the implementation either way.
>
> > +     struct clk_regmap       clkr;
> > +};
> > +
> > +extern const struct clk_ops clk_regmap_pipe_src_ops;
> > +
> > +#endif
>
> Johan



-- 
With best wishes
Dmitry
