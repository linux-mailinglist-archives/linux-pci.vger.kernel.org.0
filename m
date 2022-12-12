Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A113649F2D
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 13:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiLLM5I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 07:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiLLM5H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 07:57:07 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B8BF03A
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 04:57:06 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id jn7so11955845plb.13
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 04:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CELbTlwFp87wl7bxggIsIf62V1a0MEPUVNJySL6sh4g=;
        b=vvF+j1oNR+EuMz/CdeTCYmJ0xO7ITp2aWZ/59uFCy3EQl/Y6lA7mrdri94n0vv8bmU
         eu8ms3Dt1861vOO4ETpCLVRyf4HLpvPNAF1wBkZtgd3EG6KipX+dvqzOmEdOtPxCzCcq
         SQfJRTwB44b6md0belT+W/1jSGkpO+lxpkTmAB0PbHBnuwwB4/XagzQ7uwWy8UnShxXQ
         Z8D0h+GYxleYc9vT04jdnoMbm9ZLXzIUAqKoeLdF/1UcVkyPL/LSpqkVqfzcUqbFw/Px
         +rC2OJsB3Ox815U6v4RG/iis0w5QVyyADgjBwj2iPGGYCvatZo2Bld5VB75eX54I3qeA
         NCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CELbTlwFp87wl7bxggIsIf62V1a0MEPUVNJySL6sh4g=;
        b=ce9608EaVCdJ3Q0hfgwSeahgnaskdEUYTZ4rGT1gReiO3rQ3XvfDgPAJusxSTx0A4B
         JP/oOolbY5m6hoRZllcj0XI5szepyYUHZ0nIh2DiFcsxpmOYDYQmaSpNoE0okWUEzYO8
         FOJq7qg3Kl45JHnzwqOvlm7hkLdahiPRuPe70uvlq1uOG1sqM/LMpUjBtgv/46QDXoIU
         W+CGD6MDZl1v5lJf/Z+oFLwrWhBcchjO96c3LNpmqMLWt2jOdqAYVbyKWn2ko5HVNP3Z
         E3B1gom1q3KghF34lZJcPRds8DkVjYx3xISFxHxkAboGPa5ajY/+2ikxBictoFF/YFhx
         PMAQ==
X-Gm-Message-State: ANoB5pmQ3URuORwQ7NybbVbdAbWzy39hOsqPo1wlUC0ebkE5IAlmusHF
        k829yZb0WNHdUknUmVzkMJFG
X-Google-Smtp-Source: AA0mqf5sFNxTahjCUzcoxuTmNba9WUk1OqF5FDvHjL3I9YROradJGvubUSpoWlAJzBAmQ5cSBL9u8g==
X-Received: by 2002:a17:90a:1b0b:b0:219:396c:9e32 with SMTP id q11-20020a17090a1b0b00b00219396c9e32mr16732121pjq.16.1670849825786;
        Mon, 12 Dec 2022 04:57:05 -0800 (PST)
Received: from thinkpad ([220.158.159.33])
        by smtp.gmail.com with ESMTPSA id mv10-20020a17090b198a00b002135e8074b1sm5384030pjb.55.2022.12.12.04.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 04:57:04 -0800 (PST)
Date:   Mon, 12 Dec 2022 18:26:58 +0530
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
Message-ID: <20221212125658.GD20655@thinkpad>
References: <TYBPR01MB5341932B42719E026AA16D40D8139@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20221128115908.awhznkkrelk7h3nm@mobilestation>
 <TYBPR01MB534107A3C2B521BA0D67B4A7D8139@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20221128161114.deacldwbckfnn6ft@mobilestation>
 <TYBPR01MB5341FA664D5F1FCA07294F96D8129@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <TYBPR01MB53413E1BE13CCA65307770FDD81D9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20221208140111.7phlnsxktxzsc55f@mobilestation>
 <TYBPR01MB5341B4EB94F1B829F0E0431CD81C9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <HE1PR0401MB23319A9F4AF7630A82249D65881C9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <20221211152849.y2dcxpc2teervlcl@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221211152849.y2dcxpc2teervlcl@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

On Sun, Dec 11, 2022 at 06:28:49PM +0300, Serge Semin wrote:
> Hi Frank
> 
> On Fri, Dec 09, 2022 at 03:52:42PM +0000, Frank Li wrote:
> > Hi Serge,
> > 
> > > From: Serge Semin, Sent: Thursday, December 8, 2022 11:01 PM
> > >
> > > Cc += Frank Li
> > >
> > > @Frank could you have a look at the thread and check the content of
> > > the CSRs dbi+0x8f8 and dbi+0x978 on available to you DW PCIe +EDMA
> > > devices?
> > 
> 
> > [    2.598038] imx6q-pcie 5f010000.pcie_ep: imx_add_pcie_ep: +0x8f8 = 3438302a, +0x978 = 00010001
> 
> Thanks for the reply. So it's 4.80a with the legacy viewport-based
> access. Alas it isn't what we need in this thread. We'll need
> @Mani's respond in order to decide how to fix the auto-detection
> procedure.
> 

Sorry for the late reply!

With below diff on the EP:

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 6f3805228a18..0eb4d3218738 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -665,6 +665,10 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
        if (val == 0xFFFFFFFF && pci->edma.reg_base) {
                pci->edma.mf = EDMA_MF_EDMA_UNROLL;
 
+               dev_info(pci->dev, "%s: +0x8f8 = %08x, +0x978 = %08x\n", __func__,
+                       dw_pcie_readl_dbi(pci, 0x8f8),
+                       dw_pcie_readl_dbi(pci, 0x978));
+
                val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
        } else if (val != 0xFFFFFFFF) {
                pci->edma.mf = EDMA_MF_EDMA_LEGACY;


The output was:

qcom-pcie-ep 1c08000.pcie-ep: dw_pcie_edma_find_chip: +0x8f8 = 3533302a, +0x978 = ffffffff

Hope this helps!

Thanks,
Mani

> -Serge(y)
> 
> > 
> > Frank Li
> > 
> > 

-- 
மணிவண்ணன் சதாசிவம்
