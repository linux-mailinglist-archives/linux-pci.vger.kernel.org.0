Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE3C627BC0
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 12:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbiKNLLL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 06:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbiKNLKy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 06:10:54 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B72C25DB
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 03:08:26 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id j12so9744701plj.5
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 03:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KjzJzFQC2/6epB7JVO7oOrhl78cI0AGNh3PIIuoCKYU=;
        b=g9PVUhl5k+9rr6jedKrFD2/PaCEdHdDfnplQ1Z++u2TfSx8MRRPdvOfmKKc5+b0X9H
         LQ+iN+N73TqoEk+/MxhkAJSULwgCzkxQPyRVMCPr9EicfFP8kj6MPxQ7BI6mYegf/A+g
         4F1GBS96SI33S42dYrx9EX0BoOgf1v2nmJEdk1g57K/iGcrSt6KyExlfY5ycEyrcS780
         OgPD/d2EtUumNxiwSUvRq78rt4lUUuQJWWd0mNw8HwQoLybuTG5Syo8vBcx4mw9ETv5Y
         EoKcOSX/BsmAvADQKR+4Ym4mqB0l1wIaIYRhKbj6cjqg2uW57gvKlqEWE7oD5Q4z+vTG
         yTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KjzJzFQC2/6epB7JVO7oOrhl78cI0AGNh3PIIuoCKYU=;
        b=MYsY7Fnw9nTZj2ZaV+eLVLVYuOlBbRFiqsrgoyNbCyAK7fGz0R8rldh02F8wkFuumy
         5WzxLK9Y+baxtJKwA65qzso5GzV5alq5T356Rg8urJFGalIoY6+efc1NmVKX11ceC0uV
         IW0W+APYI2vcQkxa10tmnssR8gd9wQtibcoQKuCjt5PNEgZhzTBlRkDAXWN8UP6O5tJU
         3TujlnkWczXROsins5XOO++dxZuFt5UjO6ekbTFdpiPOyK4XVMGp/MePcLzpOCPlesnR
         WAJ1ADKwCyjxAzxtUmHbh9o8rjry9Hpqz5XW/pvlOhqmQLkn9G5ESoFSokoLbSIhcXQb
         whlA==
X-Gm-Message-State: ANoB5plBSKlgaQ2vkLV4ioACyRVGsV6r+rjtN45bxIUkuBrp4yAzP6cN
        ZBAEYJTT0jWeG4jXEUBm2TSK
X-Google-Smtp-Source: AA0mqf4Lj3K25+WcHcmEYA2aICAYAplDpGpFukmOdtIAX3zw8Nr7S+1+L6mCRQH5JHwklt7LkG0vXA==
X-Received: by 2002:a17:902:b103:b0:187:3c62:5837 with SMTP id q3-20020a170902b10300b001873c625837mr12933926plr.123.1668424105576;
        Mon, 14 Nov 2022 03:08:25 -0800 (PST)
Received: from thinkpad ([117.248.0.54])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090a648f00b0020ad53b5883sm6304082pjj.14.2022.11.14.03.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 03:08:24 -0800 (PST)
Date:   Mon, 14 Nov 2022 16:38:20 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vidyas@nvidia.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, lpieralisi@kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v4 2/5] PCI: tegra194: Move dw_pcie_ep_linkup() to
 threaded IRQ handler
Message-ID: <20221114110820.GM3869@thinkpad>
References: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
 <20221025145101.116393-3-manivannan.sadhasivam@linaro.org>
 <20221114110654.GL3869@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221114110654.GL3869@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 14, 2022 at 04:37:00PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Oct 25, 2022 at 08:20:58PM +0530, Manivannan Sadhasivam wrote:
> > dw_pcie_ep_linkup() may take more time to execute depending on the EPF
> > driver implementation. Calling this API in the hard IRQ handler is not
> > encouraged since the hard IRQ handlers are supposed to complete quickly.
> > 
> > So move the dw_pcie_ep_linkup() call to threaded IRQ handler.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Sorry for resending it (something messed up with my email client).

Vidya, can you please review this patch?

Thanks,
Mani

> > ---
> >  drivers/pci/controller/dwc/pcie-tegra194.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > index 1b6b437823d2..a0d231b7a435 100644
> > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > @@ -287,6 +287,7 @@ struct tegra_pcie_dw {
> >  	struct gpio_desc *pex_refclk_sel_gpiod;
> >  	unsigned int pex_rst_irq;
> >  	int ep_state;
> > +	long link_status;
> >  };
> >  
> >  static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
> > @@ -450,9 +451,13 @@ static void pex_ep_event_hot_rst_done(struct tegra_pcie_dw *pcie)
> >  static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
> >  {
> >  	struct tegra_pcie_dw *pcie = arg;
> > +	struct dw_pcie_ep *ep = &pcie->pci.ep;
> >  	struct dw_pcie *pci = &pcie->pci;
> >  	u32 val, speed;
> >  
> > +	if (test_and_clear_bit(0, &pcie->link_status))
> > +		dw_pcie_ep_linkup(ep);
> > +
> >  	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
> >  		PCI_EXP_LNKSTA_CLS;
> >  	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> > @@ -499,7 +504,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
> >  static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
> >  {
> >  	struct tegra_pcie_dw *pcie = arg;
> > -	struct dw_pcie_ep *ep = &pcie->pci.ep;
> >  	int spurious = 1;
> >  	u32 status_l0, status_l1, link_status;
> >  
> > @@ -515,7 +519,8 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
> >  			link_status = appl_readl(pcie, APPL_LINK_STATUS);
> >  			if (link_status & APPL_LINK_STATUS_RDLH_LINK_UP) {
> >  				dev_dbg(pcie->dev, "Link is up with Host\n");
> > -				dw_pcie_ep_linkup(ep);
> > +				set_bit(0, &pcie->link_status);
> > +				return IRQ_WAKE_THREAD;
> >  			}
> >  		}
> >  
> > -- 
> > 2.25.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
