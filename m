Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0357F4C9213
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 18:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiCARmX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 12:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbiCARmW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 12:42:22 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693DD5F4DD
        for <linux-pci@vger.kernel.org>; Tue,  1 Mar 2022 09:41:40 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id i5so16880891oih.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Mar 2022 09:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dj9jClIeUnpps0dqvQJqNq3ULWQwNcCV3LH2BxUJGms=;
        b=TcyAz5Y+hFUh8EDGKhQQp8PP/lNhvlR/qhCtRH4jyxwoU7jQ3m8JXa+y0XP6UOjfdx
         JKEqBWZS73vw/zH2uo1wizbmjHTl+FS/iHyRafKXJxbsSEcAaH3sOt3RS2TynuB9OiRQ
         SG+r9xDw98qwxF8CKQo6H3GFrt5g0wdkJrOd36a7kcevJds9YEelN3k7c61RzIBmtdB/
         dgd7lDSrPEfviuPtmtu8WUD+8kRhDB3VBtlFwt98k2G0ZfA3LZSvAsTwmeLwbTFxEcDd
         Px+1JhCvcaxTdpHUwJvqe9SGVl8vL+qpFC5SugNtKPijfpxC2/xkrQeV7zgnV3/JlQg3
         4Z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dj9jClIeUnpps0dqvQJqNq3ULWQwNcCV3LH2BxUJGms=;
        b=vg2urT9WVWWQYfJuspegJFT5x/FmnEu3vFWjDR2XolBc61ltOkw3/DqjSy9rlE4IMd
         dHw6wBxLo9rUzC5mF+u0rgmdS9YU2o7K0RJD2vC4YpQ5t2NAZcvznb31Y+de7Kn2auQu
         nehUrB7DDOiRomaGn9R9dICdFkrPSwshJvyM3spZmqPtiU8xhQy/gLew4KBJ3VcP1mxN
         06N+R2FYv2xMG6xKNjSiuVEDbe3ABGnhUgDgEU+yz3+8AsWIZXTQsF7oSYf64wc7i2nY
         El2OarQuGzqteuwHtweoDp3beV1hKgfjBARHiikgA8C7QDu7r3elcrmDp/WQt8grm0ad
         L/wg==
X-Gm-Message-State: AOAM532uUPCl65ro5tp/fjFDLpAOIPqfspLtmTiLTpKtMy0uIAD21G5N
        wPaR7ZWcU/+uQhutn0s/MjTsDw==
X-Google-Smtp-Source: ABdhPJw9T2ag+1PboNShZd97DGAbxwRAr1BkU149XaLa6NR+zTE37rZpaQ/gTvrxQfNxN5LqMQNR+w==
X-Received: by 2002:a05:6808:188b:b0:2d4:70f2:3cfa with SMTP id bi11-20020a056808188b00b002d470f23cfamr15842992oib.168.1646156499704;
        Tue, 01 Mar 2022 09:41:39 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id y6-20020a4a86c6000000b0031bf43a9212sm6441136ooh.11.2022.03.01.09.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 09:41:38 -0800 (PST)
Date:   Tue, 1 Mar 2022 09:43:31 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 03/11] clk: qcom: gdsc: add support for clocks tied to
 the GDSC
Message-ID: <Yh5bQ8FqwN7wOkb8@ripper>
References: <20220204144645.3016603-1-dmitry.baryshkov@linaro.org>
 <20220204144645.3016603-4-dmitry.baryshkov@linaro.org>
 <Yf2jRAf5UKYSMYxe@builder.lan>
 <f521a273-7250-ddca-0e56-b1b27bd75117@linaro.org>
 <3bc0461d-3a2e-f994-e712-dfc8be04c9b4@quicinc.com>
 <CAA8EJpo8Abvfea8mYZo0opp=7RSpvp+WnC06tGgr1YeWzOFLPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpo8Abvfea8mYZo0opp=7RSpvp+WnC06tGgr1YeWzOFLPw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon 28 Feb 22:47 PST 2022, Dmitry Baryshkov wrote:

> Hi,
> 
> On Tue, 1 Mar 2022 at 09:42, Prasad Malisetty <quic_pmaliset@quicinc.com> wrote:
> > I discussed with internal team. setting gcc_pcie_n_pipe_clk src in pcie
> > driver doesn't have any relation with gdsc.
> >
> > But we are making sure that gcc_pcie_n_pipe_clk src is bi_tcxo before
> > enabling the clocks and switching to pipe_clk src after PHY is enalbe.
> >
> > During suspend switching back to bi_tcxo as we enabling the clock as
> > part of resume.
> 
> So... I assume that if we implement the enable/disable() ops in a way
> similar to clk_rcg2_shared_ops, we can drop all manual handling of
> pipe_clk sources.
> 
> Bjorn, Taniya WDYT?
> 

To me it really sounds like the need here is to "park" the pipe clock
source on bi_tcxo while the PHY isn't providing a valid clock signal
into GCC. If so "parking" the clock the same way as the rcg2_shared_ops
seems reasonable in that case.

Also, looking at downstream, the USB pipe clock seems to be handled in a
similar fashion.


But I'm still wondering what the actual requirement for the pipe clock
is. Per your description Prasad, it seems that the PHY doesn't need the
pipe clock coming back from GCC during initialization - and the PCIe
controller driver enables the pipe_clk after powering on the phy.

On platforms prior to there being a mux involved (e.g. SDM845) we have a
branch that is marked BRANCH_HALT_SKIP. But do we have that because we
incorrectly enable the gcc_pipe_clk before we power on the PHY?

I thought we did this because gcc_pipe_clk was part of some feedback
loop when calibrating the PHY PLL, but if sc7280 can feed tcxo that
doesn't make sense. Is the incoming pipe_clk part of the PHY
initialization or not?

Can we move the enablement of gcc_pipe_clk to be done after we bring up
the PHY and thereby drop the BRANCH_HALT_SKIP on these platforms?

Regards,
Bjorn

> >
> >   Hi Taniya,
> >
> > Please provide your inputs.
> >
> > Thanks
> >
> > -Prasad
> > On 2/12/2022 1:22 AM, Dmitry Baryshkov wrote:
> > > On 05/02/2022 01:05, Bjorn Andersson wrote:
> > >> On Fri 04 Feb 08:46 CST 2022, Dmitry Baryshkov wrote:
> > >>
> > >>> On newer Qualcomm platforms GCC_PCIE_n_PIPE_CLK_SRC should be
> > >>> controlled
> > >>> together with the PCIE_n_GDSC. The clock should be fed from the TCXO
> > >>> before switching the GDSC off and can be fed from PCIE_n_PIPE_CLK once
> > >>> the GDSC is on.
> > >>>
> > >>> Since commit aa9c0df98c29 ("PCI: qcom: Switch pcie_1_pipe_clk_src after
> > >>> PHY init in SC7280") PCIe controller driver tries to manage this on
> > >>> it's
> > >>> own, resulting in the non-optimal code. Furthermore, if the any of the
> > >>> drivers will have the same requirements, the code would have to be
> > >>> dupliacted there.
> > >>>
> > >>> Move handling of such clocks to the GDSC code, providing special GDSC
> > >>> type.
> > >>>
> > >>
> > >> As discussed on IRC, I'm inclined not to take this, because looks to me
> > >> to be the same situation that we have with all GDSCs in SM8350 and
> > >> onwards - that some clocks must be parked on a safe parent before the
> > >> associated GDSC can be toggled.
> > >>
> > >> Prasad, please advice on what the actual requirements are wrt the
> > >> gcc_pipe_clk_src. When does it need to provide a valid signal and when
> > >> does it need to be parked?
> > >
> > > [Excuse me for the duplicate, Prasad's email was bouncing]
> > >
> > > Prasad, any comments?
> > >
> > >>
> > >> Regards,
> > >> Bjorn
> > >>
> > >>> Cc: Prasad Malisetty <pmaliset@codeaurora.org>
> > >>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > >>> ---
> > >>>   drivers/clk/qcom/gdsc.c | 41
> > >>> +++++++++++++++++++++++++++++++++++++++++
> > >>>   drivers/clk/qcom/gdsc.h | 14 ++++++++++++++
> > >>>   2 files changed, 55 insertions(+)
> > >>>
> > >>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> > >>> index 7e1dd8ccfa38..9913d1b70947 100644
> > >>> --- a/drivers/clk/qcom/gdsc.c
> > >>> +++ b/drivers/clk/qcom/gdsc.c
> > >>> @@ -45,6 +45,7 @@
> > >>>   #define TIMEOUT_US        500
> > >>>     #define domain_to_gdsc(domain) container_of(domain, struct gdsc,
> > >>> pd)
> > >>> +#define domain_to_pipe_clk_gdsc(domain) container_of(domain, struct
> > >>> pipe_clk_gdsc, base.pd)
> > >>>     enum gdsc_status {
> > >>>       GDSC_OFF,
> > >>> @@ -549,3 +550,43 @@ int gdsc_gx_do_nothing_enable(struct
> > >>> generic_pm_domain *domain)
> > >>>       return 0;
> > >>>   }
> > >>>   EXPORT_SYMBOL_GPL(gdsc_gx_do_nothing_enable);
> > >>> +
> > >>> +/*
> > >>> + * Special operations for GDSCs with attached pipe clocks.
> > >>> + * The clock should be parked to safe source (tcxo) before turning
> > >>> off the GDSC
> > >>> + * and can be switched on as soon as the GDSC is on.
> > >>> + *
> > >>> + * We remove respective clock sources from clocks map and handle
> > >>> them manually.
> > >>> + */
> > >>> +int gdsc_pipe_enable(struct generic_pm_domain *domain)
> > >>> +{
> > >>> +    struct pipe_clk_gdsc *sc = domain_to_pipe_clk_gdsc(domain);
> > >>> +    int i, ret;
> > >>> +
> > >>> +    ret = gdsc_enable(domain);
> > >>> +    if (ret)
> > >>> +        return ret;
> > >>> +
> > >>> +    for (i = 0; i< sc->num_clocks; i++)
> > >>> +        regmap_update_bits(sc->base.regmap, sc->clocks[i].reg,
> > >>> +                BIT(sc->clocks[i].shift + sc->clocks[i].width) -
> > >>> BIT(sc->clocks[i].shift),
> > >>> +                sc->clocks[i].on_value << sc->clocks[i].shift);
> > >>> +
> > >>> +    return 0;
> > >>> +}
> > >>> +EXPORT_SYMBOL_GPL(gdsc_pipe_enable);
> > >>> +
> > >>> +int gdsc_pipe_disable(struct generic_pm_domain *domain)
> > >>> +{
> > >>> +    struct pipe_clk_gdsc *sc = domain_to_pipe_clk_gdsc(domain);
> > >>> +    int i;
> > >>> +
> > >>> +    for (i = sc->num_clocks - 1; i >= 0; i--)
> > >>> +        regmap_update_bits(sc->base.regmap, sc->clocks[i].reg,
> > >>> +                BIT(sc->clocks[i].shift + sc->clocks[i].width) -
> > >>> BIT(sc->clocks[i].shift),
> > >>> +                sc->clocks[i].off_value << sc->clocks[i].shift);
> > >>> +
> > >>> +    /* In case of an error do not try turning the clocks again. We
> > >>> can not be sure about the GDSC state. */
> > >>> +    return gdsc_disable(domain);
> > >>> +}
> > >>> +EXPORT_SYMBOL_GPL(gdsc_pipe_disable);
> > >>> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
> > >>> index d7cc4c21a9d4..b1a2f0abe41c 100644
> > >>> --- a/drivers/clk/qcom/gdsc.h
> > >>> +++ b/drivers/clk/qcom/gdsc.h
> > >>> @@ -68,11 +68,25 @@ struct gdsc_desc {
> > >>>       size_t num;
> > >>>   };
> > >>>   +struct pipe_clk_gdsc {
> > >>> +    struct gdsc base;
> > >>> +    int num_clocks;
> > >>> +    struct {
> > >>> +        u32 reg;
> > >>> +        u32 shift;
> > >>> +        u32 width;
> > >>> +        u32 off_value;
> > >>> +        u32 on_value;
> > >>> +    } clocks[];
> > >>> +};
> > >>> +
> > >>>   #ifdef CONFIG_QCOM_GDSC
> > >>>   int gdsc_register(struct gdsc_desc *desc, struct
> > >>> reset_controller_dev *,
> > >>>             struct regmap *);
> > >>>   void gdsc_unregister(struct gdsc_desc *desc);
> > >>>   int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain);
> > >>> +int gdsc_pipe_enable(struct generic_pm_domain *domain);
> > >>> +int gdsc_pipe_disable(struct generic_pm_domain *domain);
> > >>>   #else
> > >>>   static inline int gdsc_register(struct gdsc_desc *desc,
> > >>>                   struct reset_controller_dev *rcdev,
> > >>> --
> > >>> 2.34.1
> > >>>
> > >
> > >
> 
> 
> 
> -- 
> With best wishes
> Dmitry
