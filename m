Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE53639E4A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 00:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiK0Xzi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Nov 2022 18:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK0Xzh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Nov 2022 18:55:37 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD0BBC93;
        Sun, 27 Nov 2022 15:55:36 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id f13so14958183lfa.6;
        Sun, 27 Nov 2022 15:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rW/OaynwezcBfthmHN1eZjbIoAQJ+mwHqyK5yAvp5is=;
        b=IqhJThko5CuzLdAN8rIyYd15uBg3KUIrcZPwmST2L2L0AacY3myyVXD1usMtQRtaVL
         uSmwP470jIDbf/hHHt1YPizuOz8bTypsnhpuN/gRSLXC8rXPY8mIoQMhShc0L8YpVhrr
         ov0XVkb5Ivvm+xAybcWi4crF1n19fSw6eG26QwftI32hVjQEqvlhXkDXFoWZwJ72W2Sg
         xxi1B0b3+RJKIqk5x6GXqwTT/LEV8DoFJajuHsI2jY9W3MS8TZePapbLiQrbNgCDwaoN
         OvhoeYWs14rmaFabfb7IocD82ROJdP/OQZuzt4W3JCN1FWg21YDMz7O+gTQ6ewLFy4rC
         wB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rW/OaynwezcBfthmHN1eZjbIoAQJ+mwHqyK5yAvp5is=;
        b=BtpoFpYs3MYaTNapVQlTk8cNRuzautoMIIAhvybVRUQPylogKUZGkd3Pbw6hFlTpVl
         w7AhQvWiPmY/dfERvdJeDtSYp1nn8Bqat3TPXBEOt2Z2YRH5GQwn/Y+N3CYwU0Fbcbaz
         Fh6HjKY2NtRz7a/IHTkXfrUVIkUylUqq6Y+OwTSsL/jMx9ZdYCdvJ9xcI2aIKKGlLeaU
         5rpZlzenDMoZSeI4pn+bkcjB907FLBw3ikDajM6VjPzVsAllywCjZES3ywa238HY+6C9
         bRuVXG/OHs4jRIaiyBr8dxAmlhaYspjETBAHTIt1fT8Pf5ttXxHK2XF//+Rza8Vr1ri2
         po0A==
X-Gm-Message-State: ANoB5pkjXq6YwlqSWiH2TtnhG6qEnzTInWYqxKFM6I9fQZ29cZ6FG9Lt
        LHPyhq/7edyolmY7YjDqTIOFxdbf+yLAgQ==
X-Google-Smtp-Source: AA0mqf6wpRnM6tTvXjKD9WooPEYhWo6KG3+M3C+BtLQS3Pqi6jA/HitFqWQCvIAKqCf3gxLuyvPCwQ==
X-Received: by 2002:ac2:4bc5:0:b0:4b4:c099:a994 with SMTP id o5-20020ac24bc5000000b004b4c099a994mr15436318lfq.193.1669593335085;
        Sun, 27 Nov 2022 15:55:35 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id u4-20020a05651220c400b004a4731f75a5sm1467071lfr.250.2022.11.27.15.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 15:55:34 -0800 (PST)
Date:   Mon, 28 Nov 2022 02:55:32 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v7 5/9] PCI: dwc: Avoid reading a register to detect
 whether eDMA exists
Message-ID: <20221127235532.u7q7oou36wymkpyf@mobilestation>
References: <20221121124400.1282768-1-yoshihiro.shimoda.uh@renesas.com>
 <20221121124400.1282768-6-yoshihiro.shimoda.uh@renesas.com>
 <20221122135550.GD157542@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221122135550.GD157542@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 22, 2022 at 07:25:50PM +0530, Manivannan Sadhasivam wrote:
> + Serge (who authored EDMA support)

Thanks @Mani. It's strange to see a fix for a patch which hasn't been even
merged in yet and miss the patch author in the Cc list.)

@Yoshihiro, on the next patchset revisions please don't forget to add
my email address to the copy list.

> 
> Thanks,
> Mani
> 
> On Mon, Nov 21, 2022 at 09:43:56PM +0900, Yoshihiro Shimoda wrote:
> > Since reading value of PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL was
> > 0x00000000 on one of SoCs (R-Car S4-8), it cannot find the eDMA.
> > So, directly read the eDMA register if edma.reg_base is not zero.
> > 
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 637d01807c67..2cc8584da6f4 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -836,8 +836,7 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> >  {
> >  	u32 val;
> >  

> > -	val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > -	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
> > +	if (pci->edma.reg_base) {
> >  		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> >  
> >  		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> > @@ -845,6 +844,7 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> >  		pci->edma.mf = EDMA_MF_EDMA_LEGACY;
> >  
> >  		pci->edma.reg_base = pci->dbi_base + PCIE_DMA_VIEWPORT_BASE;
> > +		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);

Look what you suggest here:
< u32 val;
< ...
< if (pci->edma.reg_base) {
< 	...
< } else if (val != 0xFFFFFFFF) {
< 	...
< } else {
< ...

It would be strange if your compiler didn't warn about 'val' being used
uninitialized here, which in its turn would introduce a regression for
the platforms with the indirectly accessible eDMA registers.

Anyway you can't just drop something what didn't work for you
hardware. The method you suggest to fix here works fine for multiple
DW PCIe IP-cores. Judging by the HW manuals it should work at least up
to v5.30a. Are you sure that your controller is of v5.20a? I see you
overwrite the IP-core version for the PCIe host driver only. Why is
that necessary? Does the version auto-detection procedure work
incorrectly for you? What does the dbi+0x8f8 CSR contain in the host
and EP registers space? Similarly could you also provide a content of
the +0x978 register?

-Sergey

> >  	} else {
> >  		return -ENODEV;
> >  	}
> > -- 
> > 2.25.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
