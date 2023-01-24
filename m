Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752AA679196
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 08:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjAXHHh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 02:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbjAXHHf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 02:07:35 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F2C3D928
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 23:07:33 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso17630979pjg.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 23:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=10qmij4V+MIzk/qN3qyJK6AcW52V8wNmKNjlluc7Acs=;
        b=p/mTM7Dv8/B1ujCSAyWM2V7oR0YSlgCdNHz5tlbLnYIdzEpZsw0Z4YX8+rlTMqeXi/
         D9LC4x/ldsN1p71kpdds5p1z9CqW7iC7Hh6vUjaX1vqy85sMyUMZZrWHo4cl/rQ5FXGW
         Q5dg16mnNo9Lo0n44iwVjuAMhVoEwobMM2YUN/TElqh1YTv7jCin9tawy1mB/n0+LQDQ
         lOjH1ePu7crc6Hrqi0ALQ+7IA0Mla60iiWCQFfPAvvJ8IBdkDcu84NxWuNOXBaJP0t+R
         /22mY+akQZeHgEJNWUD2BV50l0tgPOKT9caef82Tlm7voIni0QmNB3i7T1UdH260fAKf
         nA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10qmij4V+MIzk/qN3qyJK6AcW52V8wNmKNjlluc7Acs=;
        b=VAATsTKU/sB+yiij0xe1PtojEnXwfo8zkkqGiw5LMy7hl4RnqzoEJnmctjmM6F01BU
         ewc+H1Xpj76kX7aBxNokmEzpQZkgfGQcAaznXEJwMjZrxbt1RBxZqbJLcHZuOAICP4QS
         PlX80jYIDUnCSSQQ1EVde6UAW2bwEuwSRy/0dgnVpIEd+d/ietnYNfCdcCzdQUbGoPDh
         GcSKZf1DZZzOTQKvOoJRz7/TGok/nwBuC8HXfkyouX71VAn25bgC444KTvlEqj5M+Q/b
         HCIFAKAoYDDpyYhHWCBuy3ygjSW3tFcloUhDAfqycPEWkqgtGZxmwbH1jYEOgc9Ky3iQ
         m1Bw==
X-Gm-Message-State: AFqh2koiNFrxfLfYI+rczdGEHks8/+UFk2pk6YzdM5m/vEDGVnlWM0hw
        abunLOlXdLu9x6rxRIrZh8vD
X-Google-Smtp-Source: AMrXdXufPcpAbIK+uwMgAVIrMZIa8RBbmyAruBsTz58SfyKep0f18QyMNXmKhmWKLda1CYbG3GGvZQ==
X-Received: by 2002:a17:902:cec7:b0:191:3993:801e with SMTP id d7-20020a170902cec700b001913993801emr35791336plg.56.1674544053101;
        Mon, 23 Jan 2023 23:07:33 -0800 (PST)
Received: from thinkpad ([117.193.209.165])
        by smtp.gmail.com with ESMTPSA id jk14-20020a170903330e00b00192721d4f2dsm893851plb.82.2023.01.23.23.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 23:07:32 -0800 (PST)
Date:   Tue, 24 Jan 2023 12:37:22 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vigneshr@ti.com
Subject: Re: [RESEND v4 2/5] PCI: tegra194: Move dw_pcie_ep_linkup() to
 threaded IRQ handler
Message-ID: <20230124070722.GA4947@thinkpad>
References: <20230111114059.6553-1-manivannan.sadhasivam@linaro.org>
 <20230111114059.6553-3-manivannan.sadhasivam@linaro.org>
 <7c9c11e5-c5f2-d36f-6204-ebc76646ee35@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c9c11e5-c5f2-d36f-6204-ebc76646ee35@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 23, 2023 at 12:52:18PM +0530, Vidya Sagar wrote:
> Thanks for pushing this change.
> 
> Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
> 

Thanks Vidya! I will push a next version with a fix for an issue
identified by kbot. Hopefully that will get merged for 6.3.

Thanks,
Mani

> On 1/11/2023 5:10 PM, Manivannan Sadhasivam wrote:
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
> >   drivers/pci/controller/dwc/pcie-tegra194.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > index 02d78a12b6e7..09825b4a075e 100644
> > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > @@ -286,6 +286,7 @@ struct tegra_pcie_dw {
> >          struct gpio_desc *pex_refclk_sel_gpiod;
> >          unsigned int pex_rst_irq;
> >          int ep_state;
> > +       long link_status;
> >   };
> > 
> >   static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
> > @@ -449,9 +450,13 @@ static void pex_ep_event_hot_rst_done(struct tegra_pcie_dw *pcie)
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
> > @@ -498,7 +503,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
> >   static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
> >   {
> >          struct tegra_pcie_dw *pcie = arg;
> > -       struct dw_pcie_ep *ep = &pcie->pci.ep;
> >          int spurious = 1;
> >          u32 status_l0, status_l1, link_status;
> > 
> > @@ -514,7 +518,8 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
> >                          link_status = appl_readl(pcie, APPL_LINK_STATUS);
> >                          if (link_status & APPL_LINK_STATUS_RDLH_LINK_UP) {
> >                                  dev_dbg(pcie->dev, "Link is up with Host\n");
> > -                               dw_pcie_ep_linkup(ep);
> > +                               set_bit(0, &pcie->link_status);
> > +                               return IRQ_WAKE_THREAD;
> >                          }
> >                  }
> > 
> > --
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்
