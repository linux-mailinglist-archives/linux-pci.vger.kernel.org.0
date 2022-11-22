Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192E5633E0F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 14:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbiKVNtu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 08:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbiKVNtt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 08:49:49 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07F157B66
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2022 05:49:47 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id y203so14413954pfb.4
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2022 05:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+P2ivfSFXLbWzT9PHNfJTpLAcw4nHOZdoUpRgaAM1gU=;
        b=fDTk2qBn/jf665HzklH6UgrbxkjDpJ1nhbZZBgIiVScnJcuXM3dqCYTfA66iUL7d1x
         xgp39O/842vNtoP/98WyzKWLw/dcDoDblPngnaWUJY6UCUjh+MNdk9IWbRswPEOumalm
         nG1/Fn8QT3qrhSs4GytV3EDzuY3esaC2eBpPKzpeZZheNCn2OqaExxIvpoX+lud+gMOs
         v9gaaMdzSvUCSBUMK0suNy/jtdG6sm37k/K7+kZlYmpo1ebgMYGur7k6cVJnoZZI2Ugn
         EyLqmBY8YLX09KmIwumwT7K7E+ZCgi4aqO7TAH0fx6gcN0yt1Wz33S9O9NPWy3nO4+CS
         RF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+P2ivfSFXLbWzT9PHNfJTpLAcw4nHOZdoUpRgaAM1gU=;
        b=RomYThtIe585LwSIlb5Dt287+vK3MhvQSHYyr6BkBdeEqnC8HZaEpO6m5/y7D2UH78
         9R5Lm8KqffO2TrZDdfItg4bRIAsyj5V76hL0eqh+LUkAflkY5rXBEotkD73SZaKOMEfh
         nX4wRgKOMoITqlLTVu1lJt57K7rmeX49+iqIBqXLzl7jI3gwmOjSW67uDCfMA7m5rQ2F
         UGPJiyJF1XYnJdO4Zf8dm1KAujF7esaPl5ydMEkPft+8UozhD5r1+st48TNs93lKXe6y
         OShmX5wgGsSZBJidbvCsLH8tyhI+7rjDL92J72ozDk2j+G1cBnhyHnwdxYjjGaTax6tr
         gQQg==
X-Gm-Message-State: ANoB5plsJsS8PO2YoNG7bsCzyiuCiDYqyAfsdHUvgHSvkKyHgYbOJoCJ
        FDg1jJfRVtUdPKiix+Cl+Kqa
X-Google-Smtp-Source: AA0mqf6xYGN0spP0aEoAK/0g3HTZzm3Evd3m91jBxcfLOeUT1xue0xoWw7S+r9p8/Vt32ziS0YkKpA==
X-Received: by 2002:aa7:9e5d:0:b0:54c:9e75:ab7 with SMTP id z29-20020aa79e5d000000b0054c9e750ab7mr4471439pfq.82.1669124987338;
        Tue, 22 Nov 2022 05:49:47 -0800 (PST)
Received: from thinkpad ([59.92.98.84])
        by smtp.gmail.com with ESMTPSA id jb4-20020a170903258400b00186b86ed450sm11953991plb.156.2022.11.22.05.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 05:49:46 -0800 (PST)
Date:   Tue, 22 Nov 2022 19:19:41 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vidyas@nvidia.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, lpieralisi@kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v4 2/5] PCI: tegra194: Move dw_pcie_ep_linkup() to
 threaded IRQ handler
Message-ID: <20221122134941.GC157542@thinkpad>
References: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
 <20221025145101.116393-3-manivannan.sadhasivam@linaro.org>
 <20221114110654.GL3869@thinkpad>
 <20221114110820.GM3869@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221114110820.GM3869@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 14, 2022 at 04:38:20PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Nov 14, 2022 at 04:37:00PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Oct 25, 2022 at 08:20:58PM +0530, Manivannan Sadhasivam wrote:
> > > dw_pcie_ep_linkup() may take more time to execute depending on the EPF
> > > driver implementation. Calling this API in the hard IRQ handler is not
> > > encouraged since the hard IRQ handlers are supposed to complete quickly.
> > > 
> > > So move the dw_pcie_ep_linkup() call to threaded IRQ handler.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Sorry for resending it (something messed up with my email client).
> 
> Vidya, can you please review this patch?
> 

Ping!

Thanks,
Mani

> Thanks,
> Mani
> 
> > > ---
> > >  drivers/pci/controller/dwc/pcie-tegra194.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > index 1b6b437823d2..a0d231b7a435 100644
> > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > @@ -287,6 +287,7 @@ struct tegra_pcie_dw {
> > >  	struct gpio_desc *pex_refclk_sel_gpiod;
> > >  	unsigned int pex_rst_irq;
> > >  	int ep_state;
> > > +	long link_status;
> > >  };
> > >  
> > >  static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
> > > @@ -450,9 +451,13 @@ static void pex_ep_event_hot_rst_done(struct tegra_pcie_dw *pcie)
> > >  static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
> > >  {
> > >  	struct tegra_pcie_dw *pcie = arg;
> > > +	struct dw_pcie_ep *ep = &pcie->pci.ep;
> > >  	struct dw_pcie *pci = &pcie->pci;
> > >  	u32 val, speed;
> > >  
> > > +	if (test_and_clear_bit(0, &pcie->link_status))
> > > +		dw_pcie_ep_linkup(ep);
> > > +
> > >  	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
> > >  		PCI_EXP_LNKSTA_CLS;
> > >  	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> > > @@ -499,7 +504,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
> > >  static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
> > >  {
> > >  	struct tegra_pcie_dw *pcie = arg;
> > > -	struct dw_pcie_ep *ep = &pcie->pci.ep;
> > >  	int spurious = 1;
> > >  	u32 status_l0, status_l1, link_status;
> > >  
> > > @@ -515,7 +519,8 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
> > >  			link_status = appl_readl(pcie, APPL_LINK_STATUS);
> > >  			if (link_status & APPL_LINK_STATUS_RDLH_LINK_UP) {
> > >  				dev_dbg(pcie->dev, "Link is up with Host\n");
> > > -				dw_pcie_ep_linkup(ep);
> > > +				set_bit(0, &pcie->link_status);
> > > +				return IRQ_WAKE_THREAD;
> > >  			}
> > >  		}
> > >  
> > > -- 
> > > 2.25.1
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
