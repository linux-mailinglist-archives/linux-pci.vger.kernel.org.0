Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19FD53546A
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 22:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbiEZU32 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 16:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiEZU31 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 16:29:27 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CFDC1EE6
        for <linux-pci@vger.kernel.org>; Thu, 26 May 2022 13:29:25 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id h18so1858662qvj.11
        for <linux-pci@vger.kernel.org>; Thu, 26 May 2022 13:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7U8ZxQJcCt/aMdBrHfCcBBglr9/HQ3epyWgRB+XBNQ=;
        b=C1pwrXuf/a3Rus/0i1yLLGIWkl+ZKCRp1bMczp3YWWS5G0T10MNpbweX0RL4iJoFv1
         fkvxJ/fUR/6MVoP2R7jpkm/XVkTOjRCwbMNe15mzo4Pr7wCFrRYnz6ShhMq516/aFqjF
         YRZPXkVU8XE3II8CtsKYgiJ7H1gE203ju79VVaA+RIh4D6V2am+2apFH4QBorL72H9KY
         6VEdOH15xkaG5Jps0xyfm8i0+rvlVVeLIbtI+YjooI9LaoNXVDYN/1SizRKytW5tQbX/
         yB0hG7NFnqxiAyDr1+stokkDWBnsn4JHP7Vnh3AIoU345gwtJtKZ3FpD0eD8ihpkDYY7
         nkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7U8ZxQJcCt/aMdBrHfCcBBglr9/HQ3epyWgRB+XBNQ=;
        b=I+sbo9P0K45MV5SQCz1gufL8iBk3cFHNeqHWW6mwByT+SYkbtRzR6OguEGQI47bKJN
         pnB3k/yr4WgV8GEbQ0rk4NndE77gT8qJAUw1IB+xULGGdArbuETuJnLArzd9Oeiul54z
         7JgnwN/7Ozo9+ZQ37OQJbNtEyMEEEnY7WJrD0tsH1bqQusJQy92GabP2RiYcvnTieMHm
         qOC4d8872Jt3JYQBwORnkpTDBJ+pkCLHV4gejY7XIBrojDHLTJlvYIIPwCZA8XRMOo6q
         NwLWH6mHyIeF4ST58Vz341kW87piaybBufo3mWt3GnU6mtHHKBVprkHLfvBwwNrhVddo
         8WlQ==
X-Gm-Message-State: AOAM5324YW0FhMaQSDbr87cKiHFFyclIDtgoZtD8zVhxLX6epMVe96da
        BtAAoFCvL7BrrR22VatNH+MLcDVTcC0yY/21Oeqadg==
X-Google-Smtp-Source: ABdhPJzWE6+/aFfASD6rZIFfbyF9nJaVk/sa/ZUHMyOQjnKRJ3h7r8yBH5vrbLsawyP3ZThVvAXaqR5lwwPSQ7yJ3X4=
X-Received: by 2002:a05:6214:931:b0:461:d289:b7f6 with SMTP id
 dk17-20020a056214093100b00461d289b7f6mr32636342qvb.55.1653596964734; Thu, 26
 May 2022 13:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
 <20220523181836.2019180-7-dmitry.baryshkov@linaro.org> <20220526184228.GF54904-robh@kernel.org>
In-Reply-To: <20220526184228.GF54904-robh@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 26 May 2022 23:29:13 +0300
Message-ID: <CAA8EJpqWb5=Zt0EL5WF3GuPLZL-u-G-1WPL8F6Qp2hKL1sj6Qg@mail.gmail.com>
Subject: Re: [PATCH v12 6/8] PCI: dwc: Implement special ISR handler for split
 MSI IRQ setup
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

On Thu, 26 May 2022 at 21:42, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, May 23, 2022 at 09:18:34PM +0300, Dmitry Baryshkov wrote:
> > If the PCIe DWC controller uses split MSI IRQs for reporting MSI
> > vectors, it is possible to detect, which group triggered the interrupt.
> > Provide an optimized version of MSI ISR handler that will handle just a
> > single MSI group instead of handling all of them.
>
> A lot more complexity to save 7 register reads...

Thus it is a separate patch. It can be dropped w/o any issues.

>
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  .../pci/controller/dwc/pcie-designware-host.c | 86 ++++++++++++++-----
> >  1 file changed, 65 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 98a57249ecaf..2b2de517301a 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -52,34 +52,42 @@ static struct msi_domain_info dw_pcie_msi_domain_info = {
> >       .chip   = &dw_pcie_msi_irq_chip,
> >  };
> >
> > +static inline irqreturn_t dw_handle_single_msi_group(struct pcie_port *pp, int i)
> > +{
> > +     int pos;
> > +     unsigned long val;
> > +     u32 status;
> > +     struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +
> > +     status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
> > +                                (i * MSI_REG_CTRL_BLOCK_SIZE));
> > +     if (!status)
> > +             return IRQ_NONE;
> > +
> > +     val = status;
> > +     pos = 0;
> > +     while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
> > +                                 pos)) != MAX_MSI_IRQS_PER_CTRL) {
>
> for_each_set_bit() doesn't work here?

Good question, I just moved the existing DWC code.

>
> > +             generic_handle_domain_irq(pp->irq_domain,
> > +                                       (i * MAX_MSI_IRQS_PER_CTRL) +
> > +                                       pos);
> > +             pos++;
> > +     }
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> >  /* MSI int handler */
> >  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
> >  {
> > -     int i, pos;
> > -     unsigned long val;
> > -     u32 status, num_ctrls;
> > +     int i;
> > +     u32 num_ctrls;
> >       irqreturn_t ret = IRQ_NONE;
> > -     struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >
> >       num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> >
> > -     for (i = 0; i < num_ctrls; i++) {
> > -             status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
> > -                                        (i * MSI_REG_CTRL_BLOCK_SIZE));
> > -             if (!status)
> > -                     continue;
> > -
> > -             ret = IRQ_HANDLED;
> > -             val = status;
> > -             pos = 0;
> > -             while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
> > -                                         pos)) != MAX_MSI_IRQS_PER_CTRL) {
> > -                     generic_handle_domain_irq(pp->irq_domain,
> > -                                               (i * MAX_MSI_IRQS_PER_CTRL) +
> > -                                               pos);
> > -                     pos++;
> > -             }
> > -     }
> > +     for (i = 0; i < num_ctrls; i++)
> > +             ret |= dw_handle_single_msi_group(pp, i);
> >
> >       return ret;
> >  }



-- 
With best wishes
Dmitry
