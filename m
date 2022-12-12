Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CED64A598
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 18:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiLLRLO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 12:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiLLRLN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 12:11:13 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AB4F012
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 09:11:11 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id a9so12715012pld.7
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 09:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t3u/nVZJHpGCzeYVaXbEmuoHr+YBxPeJ4XXfnsKaIXE=;
        b=GivM+ebkHs8v48Owrby0PybWizU37lZTlfX2dG1AmFM8zSmi7I3oQK9OGWIc0QdUvt
         V9T2BfFGBn6GksVa1fkpw0MC2Sicnv9h54ucdd4vtal9Qg6mQ08W6hVeqzhD5hfUArz8
         abitU9Iiep8XqUHRvj5o6dsul1pOoOqURHS6HwzE2/Kt5u6SxdmYFIIaBgQZxiLOpeGf
         BkzUW/0WbEm8Jv3SWg3GMUPn+AB7lVJRgl6OaaMfhIOAB7QGFinM3S64opmtYEosqWi6
         5MbBgTzgO/0EKqCOd71miG+iPvjR1PraTy3kImYYnOc4kQpkL1Eovthm2TWsP9egLgxc
         73bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3u/nVZJHpGCzeYVaXbEmuoHr+YBxPeJ4XXfnsKaIXE=;
        b=wzL65epq4MAi/ypM+vqgkR/Oy5XInrIJGaEr7uZ91bD/7Qm115ntz/3vO0PNgasm5T
         PwMeycY7wXox0rkezLqOarWE+v4uV9k0QXnyI6+B7Vfl+Um0yDnbqjiD7cpYJPUic1Zh
         V68hS4F+ZmZ2PwoYj71azsi4TjtZaa1l1XkZHfTLE+CyVHIFpkL7nTz4aymwjOXjhK1K
         fVxsLc7WBC9fbsJxR77u7ylRrafXC+Urpn+GuF8bQGnJXHt0gJTRwH0/iubfPGdfnxZQ
         XjJ9XXPmvh9ZtL5ZoaR8Bei/Hcu59XueQyer+pw11oJZQNBmSIjL/nf2A5aQFKl1BkVr
         WkKw==
X-Gm-Message-State: ANoB5pl5rh1Mnv2HNNRqcSO8FgxB9d7gQTxwN9rUq+HxTGzTWGRJstP6
        2SjRl3L8Rni6DkA3n8dxlm6U
X-Google-Smtp-Source: AA0mqf5AMEbjgbbuGJR6rTD/93rr7CbkqeCM8QvgOdkRz+OLRhJfuKpkC1FZMmkg/vgnUaMgPoL4hQ==
X-Received: by 2002:a17:902:b942:b0:186:def0:66f2 with SMTP id h2-20020a170902b94200b00186def066f2mr16985830pls.11.1670865070371;
        Mon, 12 Dec 2022 09:11:10 -0800 (PST)
Received: from thinkpad ([220.158.158.154])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902d4c100b0017f7c4e260fsm6632416plg.150.2022.12.12.09.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 09:11:09 -0800 (PST)
Date:   Mon, 12 Dec 2022 22:41:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Frank Li <frank.li@nxp.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "Sergey.Semin@baikalelectronics.ru" 
        <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [EXT] RE: [PATCH v7 5/9] PCI: dwc: Avoid reading a register to
 detect whether eDMA exists
Message-ID: <20221212171102.GF20655@thinkpad>
References: <TYBPR01MB534107A3C2B521BA0D67B4A7D8139@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20221128161114.deacldwbckfnn6ft@mobilestation>
 <TYBPR01MB5341FA664D5F1FCA07294F96D8129@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <TYBPR01MB53413E1BE13CCA65307770FDD81D9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20221208140111.7phlnsxktxzsc55f@mobilestation>
 <TYBPR01MB5341B4EB94F1B829F0E0431CD81C9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <HE1PR0401MB23319A9F4AF7630A82249D65881C9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <20221211152849.y2dcxpc2teervlcl@mobilestation>
 <20221212125658.GD20655@thinkpad>
 <20221212165600.tfx3ewjt6z23kfaz@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221212165600.tfx3ewjt6z23kfaz@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 12, 2022 at 07:56:00PM +0300, Serge Semin wrote:
> On Mon, Dec 12, 2022 at 06:26:58PM +0530, Manivannan Sadhasivam wrote:
> > Hi Serge,
> > 
> > On Sun, Dec 11, 2022 at 06:28:49PM +0300, Serge Semin wrote:
> > > Hi Frank
> > > 
> > > On Fri, Dec 09, 2022 at 03:52:42PM +0000, Frank Li wrote:
> > > > Hi Serge,
> > > > 
> > > > > From: Serge Semin, Sent: Thursday, December 8, 2022 11:01 PM
> > > > >
> > > > > Cc += Frank Li
> > > > >
> > > > > @Frank could you have a look at the thread and check the content of
> > > > > the CSRs dbi+0x8f8 and dbi+0x978 on available to you DW PCIe +EDMA
> > > > > devices?
> > > > 
> > > 
> > > > [    2.598038] imx6q-pcie 5f010000.pcie_ep: imx_add_pcie_ep: +0x8f8 = 3438302a, +0x978 = 00010001
> > > 
> > > Thanks for the reply. So it's 4.80a with the legacy viewport-based
> > > access. Alas it isn't what we need in this thread. We'll need
> > > @Mani's respond in order to decide how to fix the auto-detection
> > > procedure.
> > > 
> > 
> 
> > Sorry for the late reply!
> > 
> > With below diff on the EP:
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 6f3805228a18..0eb4d3218738 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -665,6 +665,10 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> >         if (val == 0xFFFFFFFF && pci->edma.reg_base) {
> >                 pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> >  
> > +               dev_info(pci->dev, "%s: +0x8f8 = %08x, +0x978 = %08x\n", __func__,
> > +                       dw_pcie_readl_dbi(pci, 0x8f8),
> > +                       dw_pcie_readl_dbi(pci, 0x978));
> > +
> >                 val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> >         } else if (val != 0xFFFFFFFF) {
> >                 pci->edma.mf = EDMA_MF_EDMA_LEGACY;
> > 
> > 
> > The output was:
> > 
> > qcom-pcie-ep 1c08000.pcie-ep: dw_pcie_edma_find_chip: +0x8f8 = 3533302a, +0x978 = ffffffff
> > 
> > Hope this helps!
> 
> Great! Thanks. This indeed helps. So it's 5.30a IP-core. Just one
> quick question. Does that device have eDMA embedded into the DW PCIe
> controller?
> 

Yes it is and it is the test platform I use for eDMA/PCI_EP work.

Thanks,
Mani

> -Serge(y)
> 
> > 
> > Thanks,
> > Mani
> > 
> > > -Serge(y)
> > > 
> > > > 
> > > > Frank Li
> > > > 
> > > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
