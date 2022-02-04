Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B90D4A953E
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 09:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357142AbiBDIhC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 03:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357140AbiBDIhB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 03:37:01 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D981C06173D
        for <linux-pci@vger.kernel.org>; Fri,  4 Feb 2022 00:37:01 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id y8so5080876qtn.8
        for <linux-pci@vger.kernel.org>; Fri, 04 Feb 2022 00:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1BEx5UcnylxDO/25ZWajjwqaaWquYPAonsg3ab3AzE=;
        b=QRmSClgZ9Uxad5V3j8eJxsLK9wzYtt2n4Pv9pgPjAGGoaOnTH4gBhnDOKnLczTuDtM
         Thv3VwBTPqc90UNtFMwXaasAeLEgG8vlK46Beov3AtgxAvJelz0owt1rgeu1s2sFyrx5
         8RskfZ61444bxLVZfCLq60C+8A3+pcOCiLIdKkuq4Qg204rX1DFrHDG56n9nEneU7H5i
         Cp/nfqsJ6J7mRkQf2FT1kCQB1mBT5PV8KRYDV7/2e59T4GDLZf64dlUSdqgodLtHYcd5
         BG5ioRYwAStC3/MHwE7xa/CyaadPtcoypc5RhLmg40F7sVeXax4oGyRn/oa7GGYuoKzP
         J16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1BEx5UcnylxDO/25ZWajjwqaaWquYPAonsg3ab3AzE=;
        b=pCUQqNtuiIMzoV+7RxpotNCt9jNshSPtLaUME507bpoBfPMi6aXpLBv0yQtasXD37R
         10+rtu5LtR0CkiJHDhbYHQ5P54pcaqRc3yhbME4p3iyMuiPlLzitQgwJDtc6Ilh+oXzp
         nQ1myf5F3ffGucQDd5t3uhZzsWTPZ9gaYudXyHrPPgWhJk42hus2YLg4A5RVr0yNi5nl
         J3ITytbePGKM8SAI6ccaRt901ps5me/dvkRJXVCbk4jfOI3dxo1hFiADNSxFGK282UuW
         2Zofzxkq9Tlw/9pTw4gqksCrPy/QmCWv0BBEeFcOv3ze3PNYSgLX4AfR8hVioFLjdyM+
         7AdQ==
X-Gm-Message-State: AOAM533I1O9zGaHevIxH1p28Ew3JOAVp9gRxZWaQPrgQbs+SvklQuYMa
        8/uFUngPQIiw6fihAS3RDTTd9KHmGdnWFa9KFSf9NA==
X-Google-Smtp-Source: ABdhPJwwBHNVj19sksx1L3udozsT0HFNCOLXBWK99frxEbPo+zKDCqqzC1D3ksBWGD7KnthPwEQQ14nU/P2vaS9kBA0=
X-Received: by 2002:a05:622a:14ce:: with SMTP id u14mr1260857qtx.370.1643963820246;
 Fri, 04 Feb 2022 00:37:00 -0800 (PST)
MIME-Version: 1.0
References: <20211218140223.500390-1-dmitry.baryshkov@linaro.org>
 <20211218140223.500390-3-dmitry.baryshkov@linaro.org> <YfylgC0OEdbpIR37@ripper>
In-Reply-To: <YfylgC0OEdbpIR37@ripper>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 4 Feb 2022 11:36:48 +0300
Message-ID: <CAA8EJpqofsiurrb30JE0W0a1DbStpM9ngtJCzQ2bcmTyO6w-7Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: qcom: Fix pipe_clk_src reparenting
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Krzysztof Wilczy??ski" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 4 Feb 2022 at 07:02, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>
> On Sat 18 Dec 06:02 PST 2021, Dmitry Baryshkov wrote:
>
> > The hardware requires that pipe_clk_src is fed from TCXO when GDSC is
> > disabled. It can be fed from PHY's pipe_clk once GDSC is enabled (which
> > is what is done by the downstream driver).
> >
> > Currently code does all clk_set_parent() calls after the
> > pm_runtime_get(), so the GDSC is already enabled.
> > Implement these requirements by moving pm_runtime_*() calls after
> > get_resources (so that get_resources() can ensure that the pipe clock
> > parent is TCXO).
> >
> > Fixes: aa9c0df98c29 ("PCI: qcom: Switch pcie_1_pipe_clk_src after PHY init in SC7280")
> > Cc: Prasad Malisetty <pmaliset@codeaurora.org>
> > Cc: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 52 ++++++++++++--------------
> >  1 file changed, 24 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 3a0f126db5a3..fbaae6f4eb18 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1188,6 +1188,9 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> >               res->ref_clk_src = devm_clk_get(dev, "ref");
> >               if (IS_ERR(res->ref_clk_src))
> >                       return PTR_ERR(res->ref_clk_src);
> > +
> > +             /* Ensure that the TCXO is a clock source for pcie_pipe_clk_src */
> > +             clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
> >       }
> >
> >       res->pipe_clk = devm_clk_get(dev, "pipe");
> > @@ -1208,9 +1211,9 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> >               return ret;
> >       }
> >
> > -     /* Set TCXO as clock source for pcie_pipe_clk_src */
> > +     /* Set pipe clock as clock source for pcie_pipe_clk_src */
> >       if (pcie->pipe_clk_need_muxing)
> > -             clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
> > +             clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
>
> At this point we've not yet called phy_power_on(), so I would expect the
> pipe_clk_src from the PHY to be disabled and hence we wouldn't be able
> to reparent the pipe_clk.
>
> But that makes me wonder what the actual requirement here is. Do we need
> just any signal on the pipe clock while initializing the controller? Or
> could we simply just move the pipe_clk parent scheme to the PHY driver
> as well?
>
>
> Is there a case where pipe_clk needs to provide a good clock signal,
> before the PHY has started to generate pipe_clk_src? Or is this scheme
> simply an open coded version of the parking of shared RCGs that we see
> all over the place?

According to downstream sources, the gcc_pcie_N_pipe_clk_src is
switched to rpmh_xo_clk right before turning off the gcc_pcie_N_gdsc
and reparented back to pcie_N_pipe_clk right after turning all the
respective GDSC. Comments in the source also talk about the GDSC
rather than powering up the PHY or providing signal on the
pcie_N_pipe_clk. So, the basic story is the same as we have with the
shared clocks, but the trigger is different. As we manually toggle the
GDSC, we should also park the pipe_clk_src accordingly.

>
> Regards,
> Bjorn
>
> >
> >       ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
> >       if (ret < 0)
> > @@ -1276,6 +1279,11 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
> >       struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> >
> >       clk_bulk_disable_unprepare(res->num_clks, res->clks);
> > +
> > +     /* Set TCXO as clock source for pcie_pipe_clk_src */
> > +     if (pcie->pipe_clk_need_muxing)
> > +             clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
> > +
> >       regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> >  }
> >
> > @@ -1283,10 +1291,6 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
> >  {
> >       struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> >
> > -     /* Set pipe clock as clock source for pcie_pipe_clk_src */
> > -     if (pcie->pipe_clk_need_muxing)
> > -             clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
> > -
> >       return clk_prepare_enable(res->pipe_clk);
> >  }
> >
> > @@ -1542,11 +1546,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> >       if (!pci)
> >               return -ENOMEM;
> >
> > -     pm_runtime_enable(dev);
> > -     ret = pm_runtime_resume_and_get(dev);
> > -     if (ret < 0)
> > -             goto err_pm_runtime_disable;
> > -
> >       pci->dev = dev;
> >       pci->ops = &dw_pcie_ops;
> >       pp = &pci->pp;
> > @@ -1563,32 +1562,29 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> >       pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;
> >
> >       pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
> > -     if (IS_ERR(pcie->reset)) {
> > -             ret = PTR_ERR(pcie->reset);
> > -             goto err_pm_runtime_put;
> > -     }
> > +     if (IS_ERR(pcie->reset))
> > +             return PTR_ERR(pcie->reset);
> >
> >       pcie->parf = devm_platform_ioremap_resource_byname(pdev, "parf");
> > -     if (IS_ERR(pcie->parf)) {
> > -             ret = PTR_ERR(pcie->parf);
> > -             goto err_pm_runtime_put;
> > -     }
> > +     if (IS_ERR(pcie->parf))
> > +             return PTR_ERR(pcie->parf);
> >
> >       pcie->elbi = devm_platform_ioremap_resource_byname(pdev, "elbi");
> > -     if (IS_ERR(pcie->elbi)) {
> > -             ret = PTR_ERR(pcie->elbi);
> > -             goto err_pm_runtime_put;
> > -     }
> > +     if (IS_ERR(pcie->elbi))
> > +             return PTR_ERR(pcie->elbi);
> >
> >       pcie->phy = devm_phy_optional_get(dev, "pciephy");
> > -     if (IS_ERR(pcie->phy)) {
> > -             ret = PTR_ERR(pcie->phy);
> > -             goto err_pm_runtime_put;
> > -     }
> > +     if (IS_ERR(pcie->phy))
> > +             return PTR_ERR(pcie->phy);
> >
> >       ret = pcie->ops->get_resources(pcie);
> >       if (ret)
> > -             goto err_pm_runtime_put;
> > +             return ret;
> > +
> > +     pm_runtime_enable(dev);
> > +     ret = pm_runtime_resume_and_get(dev);
> > +     if (ret < 0)
> > +             goto err_pm_runtime_disable;
> >
> >       pp->ops = &qcom_pcie_dw_ops;
> >
> > --
> > 2.34.1
> >



-- 
With best wishes
Dmitry
