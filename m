Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A014642314
	for <lists+linux-pci@lfdr.de>; Mon,  5 Dec 2022 07:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiLEGt4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Dec 2022 01:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiLEGtz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2022 01:49:55 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026F4120BE
        for <linux-pci@vger.kernel.org>; Sun,  4 Dec 2022 22:49:54 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so10515600pjm.2
        for <linux-pci@vger.kernel.org>; Sun, 04 Dec 2022 22:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0dsmzh0tDK+exIXrmu3T3ewgjPHUQ+78VtJXJJPsmA8=;
        b=v6pRTbOpTmEfnzfNcWsP6VbH3mVmL3L8bJytFB7fE/fdvR2NHJrQ8ErH/MQfYEqx8a
         MVIct0AA0clZflPQu7DtaaCHYRHfwi/EKJL5GVQkppZGVwHNWn7EZdyYei14bkk7zf0+
         dhl8rz5iIQTvDnwqqBIrg0akKSoh1FGghHenRqvflpTcVNxvbLInnFUDquZX79g2KU7J
         Jtp2T4qhZ8DPjYvmu/Nj0v2vNGUJvkCRlKD84EobdL56UPrC6/cRRIoPNGGECxDKNqwx
         s49G0hsDVDW2T+kpDmjDkfkpap7DL6XkyTgnXlUUUDOpwM06u1bhe89XlNet42uvkKyP
         rFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0dsmzh0tDK+exIXrmu3T3ewgjPHUQ+78VtJXJJPsmA8=;
        b=EoIxoYsXUGpgttI9krER3z5POtHoWrpR1i/pfrPdilYMHcyCsPJFZc26SGaW8aJ8Tf
         oY5uHypi0inxyfIAPmpn2CWLpxnZ2mgM9xIiry+5sBzYenIccSgDqcH6tdIwZxum9uGt
         NQFKy3zz8KWcYlWeWfj9UJ3esSzsuKF4jw17GkGZZ3/aizDmR+Rd21ATln7n+DKPjiA1
         1KRT3B8ICCV+VLv7sItwThiHPXkcGE84GmXGEvyyTfLHaO/4hyPEwDx4TXBRcQVgQEnR
         cri+2kKyqUHCv1WyeR8LNwW3SwwavQ9bJkkm/AxREtUmeWvTaR//qY511VnnpDiEiafX
         h7/w==
X-Gm-Message-State: ANoB5pmI3JwTRFBHcMc1YTWpAjGAUTn0eam5IY6BsrKzR4K/lxhCDEtY
        MBYzqPsQtVpXfuEq0YfE0qj+
X-Google-Smtp-Source: AA0mqf4VwzGPvcooAz6S8z6TcuyuKUNXEY+QNd6OQvPZrR38ewOvAjLzFZZpgTkF7lQA7f7BzXDTKg==
X-Received: by 2002:a17:902:dac2:b0:189:7d5:26ea with SMTP id q2-20020a170902dac200b0018907d526eamr63603737plx.145.1670222993455;
        Sun, 04 Dec 2022 22:49:53 -0800 (PST)
Received: from thinkpad ([59.92.98.136])
        by smtp.gmail.com with ESMTPSA id d129-20020a621d87000000b00573a1f0589bsm5027609pfd.186.2022.12.04.22.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 22:49:52 -0800 (PST)
Date:   Mon, 5 Dec 2022 12:19:46 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vidyas@nvidia.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, lpieralisi@kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v4 2/5] PCI: tegra194: Move dw_pcie_ep_linkup() to
 threaded IRQ handler
Message-ID: <20221205064621.GA4514@thinkpad>
References: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
 <20221025145101.116393-3-manivannan.sadhasivam@linaro.org>
 <20221114110654.GL3869@thinkpad>
 <20221114110820.GM3869@thinkpad>
 <20221122134941.GC157542@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221122134941.GC157542@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 22, 2022 at 07:19:41PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Nov 14, 2022 at 04:38:20PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Nov 14, 2022 at 04:37:00PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Oct 25, 2022 at 08:20:58PM +0530, Manivannan Sadhasivam wrote:
> > > > dw_pcie_ep_linkup() may take more time to execute depending on the EPF
> > > > driver implementation. Calling this API in the hard IRQ handler is not
> > > > encouraged since the hard IRQ handlers are supposed to complete quickly.
> > > > 
> > > > So move the dw_pcie_ep_linkup() call to threaded IRQ handler.
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Sorry for resending it (something messed up with my email client).
> > 
> > Vidya, can you please review this patch?
> > 
> 
> Ping!
> 

Ping again. Vidya, only your t-b tag is missing to get this series merged. Can
you please test and report back.

There are few series that depends on this including a couple from you.

Thanks,
Mani

> Thanks,
> Mani
> 
> > Thanks,
> > Mani
> > 
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-tegra194.c | 9 +++++++--
> > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > index 1b6b437823d2..a0d231b7a435 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > @@ -287,6 +287,7 @@ struct tegra_pcie_dw {
> > > >  	struct gpio_desc *pex_refclk_sel_gpiod;
> > > >  	unsigned int pex_rst_irq;
> > > >  	int ep_state;
> > > > +	long link_status;
> > > >  };
> > > >  
> > > >  static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
> > > > @@ -450,9 +451,13 @@ static void pex_ep_event_hot_rst_done(struct tegra_pcie_dw *pcie)
> > > >  static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
> > > >  {
> > > >  	struct tegra_pcie_dw *pcie = arg;
> > > > +	struct dw_pcie_ep *ep = &pcie->pci.ep;
> > > >  	struct dw_pcie *pci = &pcie->pci;
> > > >  	u32 val, speed;
> > > >  
> > > > +	if (test_and_clear_bit(0, &pcie->link_status))
> > > > +		dw_pcie_ep_linkup(ep);
> > > > +
> > > >  	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
> > > >  		PCI_EXP_LNKSTA_CLS;
> > > >  	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> > > > @@ -499,7 +504,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
> > > >  static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
> > > >  {
> > > >  	struct tegra_pcie_dw *pcie = arg;
> > > > -	struct dw_pcie_ep *ep = &pcie->pci.ep;
> > > >  	int spurious = 1;
> > > >  	u32 status_l0, status_l1, link_status;
> > > >  
> > > > @@ -515,7 +519,8 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
> > > >  			link_status = appl_readl(pcie, APPL_LINK_STATUS);
> > > >  			if (link_status & APPL_LINK_STATUS_RDLH_LINK_UP) {
> > > >  				dev_dbg(pcie->dev, "Link is up with Host\n");
> > > > -				dw_pcie_ep_linkup(ep);
> > > > +				set_bit(0, &pcie->link_status);
> > > > +				return IRQ_WAKE_THREAD;
> > > >  			}
> > > >  		}
> > > >  
> > > > -- 
> > > > 2.25.1
> > > > 
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
