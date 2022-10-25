Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1844860CF0D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 16:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiJYOcT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 10:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiJYOcR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 10:32:17 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDF8A8350
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 07:32:13 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d24so11118681pls.4
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 07:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T9egOhbu74WPH8putvhQW41m1t/pvVQ92w9D0cQIV7I=;
        b=NoeFrrvi5MJZHav8IeAOsmfGm0wGQGv8nBP8bhBwVHl+j6V9/1rJfn+dSZfV/1tiZx
         an12t+Rx+G6Lndv0BfRnHFOnv0rvMo8dXfGKh5HGcYiy5mV50GqhyF/rqSVMP8/RC542
         SFL5MAuZU80cD1SYlWVzhg31E9oeWD5gwS0FQiAzm2HcceRLN9mYIKw6GoarCPx8Fxch
         inW/xooti9NuMUT7Fo4sOxqpW65ihILWfj5nnI0hgygvNYlrKApvPPaJOdC/0ALOKB78
         VrkhLsx0mc7/aKGY67L0FrzjPPp2Vg20G52QMofHlyZ43ZevFcBbZu4AuGYXesWnBUFG
         5wFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9egOhbu74WPH8putvhQW41m1t/pvVQ92w9D0cQIV7I=;
        b=DcdPUj62njYxefb4a/LneX/9wQUr/5uAEUeFbXGZy2CSWTNl0IIC1Bqse7WRiaOTAt
         47iMnKJMRukfjLnrNpq12wdw5E18GMxvd5IT1is6UOLToAYg4f3WU+Q2Lr7Yv3gwKlo0
         zbyMFr7KkElWC2bmdhmbrRIoKflnKf3jROarSz3npAcHlug/6OAaLLqWQBqaDAWBTwz9
         Y/ETru/IhuFV1kVRD5OqdQYbZi6vOPW/ZoAv4OeLMdR+PlLu2C8dO2iVrc5fFf3znIZ6
         5X/JjK72HAHER27A/IvlynjHnW3EGJWWInTEdJScW4+z1f4km8SOMajLn6rG5cA9wxO2
         inUw==
X-Gm-Message-State: ACrzQf3+RomwchjHx//yBZjn29Tr4pBd/+X/iHJLz846M5A+68eGQrvr
        XQHkFmnU8xUMmYPc24av98s4
X-Google-Smtp-Source: AMsMyM6uemALfpw7U9QD0PvhW1r1pnVs3bpVCi8KkK6Z2ldfFFz061LSRaagTJtHzTJQ24uY2bCH3g==
X-Received: by 2002:a17:902:ec8a:b0:186:8869:8b0d with SMTP id x10-20020a170902ec8a00b0018688698b0dmr19370360plg.166.1666708333162;
        Tue, 25 Oct 2022 07:32:13 -0700 (PDT)
Received: from thinkpad ([117.193.208.236])
        by smtp.gmail.com with ESMTPSA id p25-20020a635b19000000b0044a4025cea1sm1301239pgb.90.2022.10.25.07.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:32:12 -0700 (PDT)
Date:   Tue, 25 Oct 2022 20:02:07 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vigneshr@ti.com
Subject: Re: [PATCH v3 2/5] PCI: tegra194: Move dw_pcie_ep_linkup() to
 threaded IRQ handler
Message-ID: <20221025143207.GB109941@thinkpad>
References: <20221006134927.41437-1-manivannan.sadhasivam@linaro.org>
 <20221006134927.41437-3-manivannan.sadhasivam@linaro.org>
 <5ec4b46f-2590-bd34-f6fa-e4e2eeb38b7b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ec4b46f-2590-bd34-f6fa-e4e2eeb38b7b@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vidya,

On Mon, Oct 10, 2022 at 07:53:52PM +0530, Vidya Sagar wrote:
> Hi Mani,
> Thanks for your change. One comment though.
> 
> On 10/6/2022 7:19 PM, Manivannan Sadhasivam wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > dw_pcie_ep_linkup() may take more time to execute depending on the EPF
> > driver implementation. Calling this API in the hard IRQ handler is not
> > encouraged since the hard IRQ handlers are supposed to complete quickly.
> > 
> > So move the dw_pcie_ep_linkup() call to threaded IRQ handler.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/pci/controller/dwc/pcie-tegra194.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > index 1b6b437823d2..6a487f52e1fb 100644
> > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > @@ -287,6 +287,7 @@ struct tegra_pcie_dw {
> >          struct gpio_desc *pex_refclk_sel_gpiod;
> >          unsigned int pex_rst_irq;
> >          int ep_state;
> > +       long link_status;
> >   };
> > 
> >   static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
> > @@ -450,9 +451,13 @@ static void pex_ep_event_hot_rst_done(struct tegra_pcie_dw *pcie)
> >   static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
> >   {
> >          struct tegra_pcie_dw *pcie = arg;
> > +       struct dw_pcie_ep *ep = &pcie->pci.ep;
> >          struct dw_pcie *pci = &pcie->pci;
> >          u32 val, speed;
> > 
> > +       if (test_and_clear_bit(0, &pcie->link_status))
> > +               dw_pcie_ep_linkup(ep);
> > +
> >          speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
> >                  PCI_EXP_LNKSTA_CLS;
> >          clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> > @@ -499,7 +504,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
> >   static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
> >   {
> >          struct tegra_pcie_dw *pcie = arg;
> > -       struct dw_pcie_ep *ep = &pcie->pci.ep;
> >          int spurious = 1;
> >          u32 status_l0, status_l1, link_status;
> > 
> > @@ -515,7 +519,7 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
> >                          link_status = appl_readl(pcie, APPL_LINK_STATUS);
> >                          if (link_status & APPL_LINK_STATUS_RDLH_LINK_UP) {
> >                                  dev_dbg(pcie->dev, "Link is up with Host\n");
> > -                               dw_pcie_ep_linkup(ep);
> > +                               set_bit(0, &pcie->link_status);
> 
> irq thread needs to be woken up at this point. So, please add
> return IRQ_WAKE_THREAD;
> 

Ah, missed that. Will add it in next version.

Thanks,
Mani

> Thanks,
> Vidya Sagar
> 
> >                          }
> >                  }
> > 
> > --
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்
