Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C81B5261B0
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 14:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358351AbiEMMTX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 08:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344394AbiEMMTW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 08:19:22 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3BB134E2A
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 05:19:20 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x9so6645067qts.6
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yh7Ds3nqFPkMrrrTYXJbK8sBHDDYq37d1oj3cOHsPo8=;
        b=C/hd6Yj0PsOF0obMq2Vte9XSit4yVtODYCuhGUpodF+La3PC9EJevKwyI/+/2hgr2O
         4x3+FVQ0Hu6IYvoQd6t0ZYcSoO4vEH19bkKLCvYaTgum/EY1Gss6u9yp8lVLnGHs4Ywj
         h7SxH+dTPriqpyUlT96pXKB87dxN9NIvASh5UT1DbtJ174AqIJWhT5EXhr3Zm7tfsn/d
         PLqvOm7LxVIXakp9c2zemmiW8NQG1LipCDn+XrM1tOy/X3xm1tc38bAdi7Bh5FnNO/AL
         1OZ2YA682Viwlnr/1TVPGxM9NTDD8zoeHNTzQoUcB8EJpBIhvnkijv2T1biIod6levTX
         Uhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yh7Ds3nqFPkMrrrTYXJbK8sBHDDYq37d1oj3cOHsPo8=;
        b=qL6V/wlQxrAj0UaYG+0tRLn8nogZMb+qbitTbp3MS5yDQvdJPlKvSfD3IME33YNNiy
         lS+6p2Tfqr1JjPIT16hk5GiqmFbCuo/Y/A1qa7+ea/kilEiIWMtStrB9mBBM7nlvbpSu
         Hwkqbd5oMzGjAcLsFsUGcTMJ/T21J/CYH9y16OE6f9KTrvwvq2wU5Wbr7KaWKp+mQD0h
         n8B5r63Kh21vqNaCnORKPfKtlCF/Rqx8eS+gtdqDlV4Mz4cr9RTj4cP2xavYVAzCohEo
         0mdQwo4CNL/ObFo/5FBc+wJlpls4Qzh2/RBToBvHJM00kKgUoPl1eWHvzbD17/kW6D0n
         I9/g==
X-Gm-Message-State: AOAM530sKERBpix7kEHW7xVzzjmV8Ifk6k0fhU7VfT4YI1ifFX/pfEx4
        4VeTYGfH5Vy/5H6162zkMKbx1q7Ng/PJpKnADOM7zQ==
X-Google-Smtp-Source: ABdhPJwz/jsKMLSl033x/2/+66SPPDBunORwAq9KquUCwcUxVfaETxM9qTpTZoxXDgUPRCy32wLthedhYTZl7Z63y/Y=
X-Received: by 2002:a05:622a:4f:b0:2f3:e77c:2c7e with SMTP id
 y15-20020a05622a004f00b002f3e77c2c7emr4195838qtw.62.1652444359788; Fri, 13
 May 2022 05:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
 <20220512104545.2204523-7-dmitry.baryshkov@linaro.org> <Yn5GlR0UD2/pcOiy@hovoldconsulting.com>
In-Reply-To: <Yn5GlR0UD2/pcOiy@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 13 May 2022 15:19:08 +0300
Message-ID: <CAA8EJpqv8QfYhXfF875Y898=9GAZUfe6db=pYVAEq_DkpOcSGA@mail.gmail.com>
Subject: Re: [PATCH v8 06/10] PCI: dwc: Handle MSIs routed to multiple GIC interrupts
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
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

On Fri, 13 May 2022 at 14:52, Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, May 12, 2022 at 01:45:41PM +0300, Dmitry Baryshkov wrote:
> > On some of Qualcomm platforms each group of 32 MSI vectors is routed to the
> > separate GIC interrupt. Implement support for such configuraions by
> > parsing "msi0" ... "msi7" interrupts and attaching them to the chained
> > handler.
> >
> > Note, that if DT doesn't list an array of MSI interrupts and uses single
> > "msi" IRQ, the driver will limit the amount of supported MSI vectors
> > accordingly (to 32).
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  .../pci/controller/dwc/pcie-designware-host.c | 33 ++++++++++++++++++-
> >  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
> >  2 files changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 6b0c7b75391f..258bafa306dc 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -291,7 +291,8 @@ static void dw_pcie_msi_init(struct pcie_port *pp)
> >  static int dw_pcie_msi_host_init(struct pcie_port *pp)
> >  {
> >       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > -     struct platform_device *pdev = to_platform_device(pci->dev);
> > +     struct device *dev = pci->dev;
> > +     struct platform_device *pdev = to_platform_device(dev);
> >       int ret;
> >       u32 ctrl, num_ctrls;
> >
> > @@ -299,6 +300,36 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
> >       for (ctrl = 0; ctrl < num_ctrls; ctrl++)
> >               pp->irq_mask[ctrl] = ~0;
> >
> > +     if (pp->has_split_msi_irq) {
> > +             char irq_name[] = "msiXX";
> > +             int irq;
> > +
> > +             if (!pp->msi_irq[0]) {
> > +                     irq = platform_get_irq_byname_optional(pdev, irq_name);
>
> This looks broken; you're requesting "msiXX", not "msi0".

Yes, I'm preparing the updated patch.

>
> > +                     if (irq == -ENXIO) {
> > +                             num_ctrls = 1;
> > +                             pp->num_vectors = min((u32)MAX_MSI_IRQS_PER_CTRL, pp->num_vectors);
> > +                             dev_warn(dev, "No additional MSI IRQs, limiting amount of MSI vectors to %d\n",
> > +                                      pp->num_vectors);
> > +                     } else {
> > +                             pp->msi_irq[0] = irq;
> > +                     }
> > +             }
> > +
> > +             /* If we fallback to the single MSI ctrl IRQ, this loop will be skipped as num_ctrls is 1 */
> > +             for (ctrl = 1; ctrl < num_ctrls; ctrl++) {
> > +                     if (pp->msi_irq[ctrl])
> > +                             continue;
> > +
> > +                     snprintf(irq_name, sizeof(irq_name), "msi%d", ctrl);
> > +                     irq = platform_get_irq_byname(pdev, irq_name);
> > +                     if (irq < 0)
> > +                             return irq;
> > +
> > +                     pp->msi_irq[ctrl] = irq;
> > +             }
> > +     }
> > +
> >       if (!pp->msi_irq[0]) {
> >               int irq = platform_get_irq_byname_optional(pdev, "msi");
>
> Johan



-- 
With best wishes
Dmitry
