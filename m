Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0822E50B522
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 12:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446642AbiDVKiK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 06:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446731AbiDVKiG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 06:38:06 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F12DFFF
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 03:35:13 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2ec05db3dfbso80700287b3.7
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 03:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W1a63l7xhBoRHTCuZlMrqgXMiCx76hX8oxGNJT4mvPY=;
        b=ekebjoo5lFkQDlWsBX1ZfsGBvvIUYcZUfxvJmQEQbMM0fTiabYtP9ISWhJdPrrr7Um
         dLL5/Jh0RXAWvXEemfUwz3kLVm7cJTgrdQeTIkK1SfGHT0piRfcBEbiMKGEFntYsx/sa
         /eqM/p0SNUUflH8m8qW6ZFPAMApHOD4j2sL72S8lAKy5zmo6qcLpVpsbf3mMbxIueXoS
         YoseYf1948P84Q+4Jlq4hD/1YZeBRGXZW5yIvAp/Y13UaSyT/ABCr5UF4DuNr7F6T2qS
         NGOG5QffIPuKAwXK4QhuZF09NFhsZktNztcDFgGk5fx7qThwVWsU0vJZx7u9SFl6VFGd
         KyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W1a63l7xhBoRHTCuZlMrqgXMiCx76hX8oxGNJT4mvPY=;
        b=M5K91/0BWMzFez1iAuBtlYd6XCB7AFw1sei2TW8EDS+T6Ki8NtHt6NZPuK2fh6575n
         ZcjeeZNtOUCkr2MzFaDYGm4UlkTSJeyy15Nj2QT/FgFDd7J9YhLkjBHvvFn8qIFLiFUw
         T+GHBjeSCl+kzdrQYbp1i9O6mo5wDK60SCiWs8v9om/JtMCtNHnw7b2pCDV1Fvg0yK9q
         g6DnYuC9U+rKmbD25XFRP37fHsUHAGGNNdAKa5jqVn1nZY3bCZZf2E+Nn9SWrHhCNjho
         Y5Zev2FSdr+BfFhr3vgHQo64AltUJ89TBpivusQdTMxpemqpN/qv01UuoUKYrOSdg488
         4Mog==
X-Gm-Message-State: AOAM532fsiPGhE2eNrpn9dzHRF0bG9FCZAM+SDS4zm1xeBnP7koHmVEa
        4BiQOfHwJuSWlxFP/1EFkcjoV0vT7ArYIFiqjBMr3g==
X-Google-Smtp-Source: ABdhPJxff+t9e+dmQ4LGqXXOr+3yKds5iXTKx+5F5KSWKEjactT/K3yMRiQhJuXxmtEhHEybpyQdr0bwpbBEI5w7lzQ=
X-Received: by 2002:a81:7405:0:b0:2eb:e280:63ec with SMTP id
 p5-20020a817405000000b002ebe28063ecmr3982763ywc.278.1650623712258; Fri, 22
 Apr 2022 03:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220421102041.17345-1-johan+linaro@kernel.org>
 <20220421102041.17345-2-johan+linaro@kernel.org> <de4f9514-5132-f208-d43f-4c50afcda203@linaro.org>
 <YmKBgGHtfDcO1Mkg@hovoldconsulting.com>
In-Reply-To: <YmKBgGHtfDcO1Mkg@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 22 Apr 2022 13:35:01 +0300
Message-ID: <CAA8EJpqTzcwAtxk+XtAWdZaKEx2=VduPiVBp+CWj=_C-921YJg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] phy: qcom-qmp: add support for pipe clock muxing
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 22 Apr 2022 at 13:20, Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Apr 21, 2022 at 02:08:27PM +0300, Dmitry Baryshkov wrote:
> > On 21/04/2022 13:20, Johan Hovold wrote:
> > > Some QMP PHYs need to remux to their pipe clock input to the pipe clock
> > > output generated by the PHY before powering on the PHY and restore the
> > > default source during power down.
> > >
> > > Add support for an optional pipe clock mux which will be reparented to
> > > the generated pipe clock before powering on the PHY and restored to the
> > > default reference source on power off.
> > >
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > >   drivers/phy/qualcomm/phy-qcom-qmp.c | 71 ++++++++++++++++++++++++++---
> > >   1 file changed, 65 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> > > index 7d2d1ab061f7..bc6db9670291 100644
> > > --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> > > @@ -3292,6 +3292,8 @@ struct qmp_phy_combo_cfg {
> > >    * @rx2: iomapped memory space for second lane's rx (in dual lane PHYs)
> > >    * @pcs_misc: iomapped memory space for lane's pcs_misc
> > >    * @pipe_clk: pipe clock
> > > + * @pipemux_clk: pipe clock source mux
> > > + * @piperef_clk: pipe clock default reference source
> > >    * @index: lane index
> > >    * @qmp: QMP phy to which this lane belongs
> > >    * @lane_rst: lane's reset controller
> > > @@ -3311,6 +3313,8 @@ struct qmp_phy {
> > >     void __iomem *rx2;
> > >     void __iomem *pcs_misc;
> > >     struct clk *pipe_clk;
> > > +   struct clk *pipemux_clk;
> > > +   struct clk *piperef_clk;
> > >     unsigned int index;
> > >     struct qcom_qmp *qmp;
> > >     struct reset_control *lane_rst;
> > > @@ -3346,6 +3350,7 @@ struct qcom_qmp {
> > >     void __iomem *dp_com;
> > >
> > >     struct clk_bulk_data *clks;
> > > +   struct clk *pipe_clksrc;
> >
> > Please move this to qmp_phy too.
>
> Ok.
>
> > > +   /* Get optional pipe clock mux and default reference source clock. */
> > > +   qphy->pipemux_clk = of_clk_get_by_name(np, "mux");
> > > +   if (IS_ERR(qphy->pipemux_clk)) {
> > > +           ret = PTR_ERR(qphy->pipemux_clk);
> > > +           if (ret == -EPROBE_DEFER)
> > > +                   return ret;
> > > +
> > > +           qphy->pipemux_clk = NULL;
> >
> > This makes the driver ignore every possible erorr except -EPROBE_DEFER.
> > However the driver should behave in quite the oppposite way. Please use
> > devm_clk_get_optional() instead. It would do that in better way.
>
> We'd need to add an optional version of devm_get_clk_from_child() for
> that due to the questionable "lane" child nodes this driver uses.
>
> The above works for an RFC, but testing for -EINVAL and -ENOENT handles
> a few more theoretical errnos until an optional helper is in place.
>
> > Not to mention that this code leaks a refcount on the clock.
>
> True, just like the driver has been doing with the pipe clock and lane
> reset since it was merged. I'll fix that up.
>
> > > +   } else {
> > > +           qphy->piperef_clk = of_clk_get_by_name(np, "ref");
> > > +           if (IS_ERR(qphy->piperef_clk)) {
> > > +                   ret = PTR_ERR(qphy->piperef_clk);
> > > +                   return dev_err_probe(dev, ret,
> > > +                                        "failed to get lane%d piperef_clk\n",
> > > +                                        id);
> > > +           }
> > > +   }
> > > +
> >
> > As a second thought.
> > This needs to be more explicit. If the chipset requires the pipe clock
> > remuxing, we must fail if the clocks were not provided. So depending on
> > the qmp instance/property the driver should either use devm_clk_get()
> > (instead of _optional) or skip this block completely.
>
> No, the kernel is not a DT validator (and we have the YAML bindings for
> that now).

It is not about DT validation. It is about passing a correct DT. The
file can come up from the kernel. It can come from the older kernel.
OR it can come from the vendor. Or it even might be being a part of
firmware flashed into the device.
So we can not assume that the DT is correct just because the in-kernel
DT passes YAML validation.

So, as I wrote, the whole patchset needs much more care about compatibility.

> > But this will not work with earlier DTS files.
>
> So this is not a problem (but if we really wanted to have the driver
> validate the DT it can be done by updating the compatible strings).

We should not update compatible strings just because the driver
changes. Compat strings describe the hardware, not the Linux point of
view on it.

-- 
With best wishes
Dmitry
