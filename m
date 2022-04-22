Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF55B50B54A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 12:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446688AbiDVKjm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 06:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446767AbiDVKji (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 06:39:38 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5D755209
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 03:36:39 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id p65so13687252ybp.9
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 03:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4zcLXpCy7SBjHdgWPDMiVMAfSv9GgL9PPHTJHm95g50=;
        b=TlZWQKiYpTuDxECbeXwF6tJvJGze7xTFNWlQD4B2jRWUPyNtSO32rIHpFbOH95KpZM
         s26ARO9kRKdZUXaE9W+5GAk4Biz6ra37er4NWm9KQgbRawLZiJ4N62G0EB9Mm35+FIPt
         VE0ppUmp9NOUmWczcYULL7OuU3fw+9RKxiZaP87uqLCwucSFLVBH5/tryhvBmqajwmoC
         dy7swc3bCfD7Q+nwTUg1K9U7fgliOrmqEuFIfYXlrNb6gziSxffXs9/Ac4SEgpIBkQwS
         hko+HrFRO72KcUP7tdIswvVyCkaDPDTJTQ4qtmZ3iuoFZRelgls7PmWUdYDm57FAvOFe
         jd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4zcLXpCy7SBjHdgWPDMiVMAfSv9GgL9PPHTJHm95g50=;
        b=RP0ePV4zpNjc7ImiDQXVtfH1QDNPvVgDS2NOuGVDKhpueA6amBv9D8G9ZwCFKv0JuU
         E1wBgAPFHmi5ZrrJC/CB2oO6lAmJimrsxIPB4Xb4xZTS+LQp8cMa2KUNUJnMyaf8VGon
         WEoDt8u3sYINpzuGBprZMYiDGNilKCdLeWPSR9gne7VYxADCOiYjt338MOPoaI9FOKet
         sa9/AdtgfMxZToYhK5G5nTBQDn2OopvduIvzclqIW5Fbjr5efuuYxWgJf7sOjWIWBK+D
         6/5S6YcIG/Wlpk9MU3BBOFk2Q55yCPAs5DFwiWVV/ZE8w2rRVA1VXcoNFX3TUviqt+md
         WxUw==
X-Gm-Message-State: AOAM533El+duGFP5fPwvobFvjghtGX0YxKMt9gcqkskg6YqmLMbXPedH
        KZ+PatK8E6/pFm7h6ZiIQMa3WsLVkaaxAlPOzxAweQ==
X-Google-Smtp-Source: ABdhPJz/ZFLFWoRZflZmG53V5oTsUDnKFJ76SRaHRYdcW5SRnzL6Jxlv23hnpEE1sIZLnoSq3Xe3/OdvM8uV/u46Xk0=
X-Received: by 2002:a25:84c1:0:b0:63e:7733:f95a with SMTP id
 x1-20020a2584c1000000b0063e7733f95amr3370991ybm.234.1650623798744; Fri, 22
 Apr 2022 03:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220421102041.17345-1-johan+linaro@kernel.org>
 <20220421102041.17345-3-johan+linaro@kernel.org> <55d6e32b-9cf4-384c-1036-1adfb867ece8@linaro.org>
 <YmJ+Ti81el2MzsHG@hovoldconsulting.com>
In-Reply-To: <YmJ+Ti81el2MzsHG@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 22 Apr 2022 13:36:27 +0300
Message-ID: <CAA8EJpq25Oi8scffT_u9kGN5CYM7nK4Wxh0Kep+eRFg8xngiHg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] arm64: dts: qcom: sc7280: move pipe mux handling
 to phy
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 22 Apr 2022 at 13:07, Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Apr 21, 2022 at 01:59:04PM +0300, Dmitry Baryshkov wrote:
> > On 21/04/2022 13:20, Johan Hovold wrote:
> > > The QMP PHY pipe clock remuxing is part of the PHY, which is both the
> > > producer and the consumer of the pipe clock.
> > >
> > > Update the PCIe controller and PHY node to reflect the new binding.
> > >
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > >   arch/arm64/boot/dts/qcom/sc7280.dtsi | 18 ++++++------------
> > >   1 file changed, 6 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > index c07765df9303..b3a9630262dc 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > @@ -1837,11 +1837,7 @@ pcie1: pci@1c08000 {
> > >                                     <0 0 0 3 &intc 0 0 0 438 IRQ_TYPE_LEVEL_HIGH>,
> > >                                     <0 0 0 4 &intc 0 0 0 439 IRQ_TYPE_LEVEL_HIGH>;
> > >
> > > -                   clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
> > > -                            <&gcc GCC_PCIE_1_PIPE_CLK_SRC>,
> > > -                            <&pcie1_lane 0>,
> > > -                            <&rpmhcc RPMH_CXO_CLK>,
> > > -                            <&gcc GCC_PCIE_1_AUX_CLK>,
> > > +                   clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
> > >                              <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> > >                              <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
> > >                              <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
> > > @@ -1849,11 +1845,7 @@ pcie1: pci@1c08000 {
> > >                              <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
> > >                              <&gcc GCC_DDRSS_PCIE_SF_CLK>;
> > >
> > > -                   clock-names = "pipe",
> > > -                                 "pipe_mux",
> > > -                                 "phy_pipe",
> > > -                                 "ref",
> > > -                                 "aux",
> > > +                   clock-names = "aux",
> > >                                   "cfg",
> > >                                   "bus_master",
> > >                                   "bus_slave",
> > > @@ -1910,8 +1902,10 @@ pcie1_lane: lanes@1c0e200 {
> > >                                   <0 0x01c0e600 0 0x170>,
> > >                                   <0 0x01c0e800 0 0x200>,
> > >                                   <0 0x01c0ee00 0 0xf4>;
> > > -                           clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
> > > -                           clock-names = "pipe0";
> > > +                           clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
> > > +                                    <&gcc GCC_PCIE_1_PIPE_CLK_SRC>,
> > > +                                    <&rpmhcc RPMH_CXO_CLK>;
> > > +                           clock-names = "pipe0", "mux", "ref";
> >
> > This will not be compatible with earlier DTB files, which was a problem
> > up to now.
>
> That depends. The above wasn't added until 5.16 so we may still be able
> to fix it.

That would depend on Rob/Krzyshtof. But the whole process should be described.
The driver can nod depend on the clocks being there.

>
> The NAK you got from Rob earlier was when you removed clocks that have
> been in the devicetree for several years:
>
>         https://lore.kernel.org/all/YgQ+tGhLqwUCsTUo@robh.at.kernel.org/
>
> and would still be needed by older kernels.
>
> Worst case, we need to keep both sets for sc7280 (i.e. like we need to
> do with the pipe clocks that have been around for years).
>
> Johan



-- 
With best wishes
Dmitry
