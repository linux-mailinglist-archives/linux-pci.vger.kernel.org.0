Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A6B64C04A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Dec 2022 00:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbiLMXL3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 18:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbiLMXL3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 18:11:29 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3CD1A826;
        Tue, 13 Dec 2022 15:11:27 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id z4so4981624ljq.6;
        Tue, 13 Dec 2022 15:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zcKen45R05A6cb2yo+f/kUnBeLAGvq6Omg+I5PLGir4=;
        b=chMikJCO37X9VSMTOffPTIOXuJor6P7S68meuKrO6rewwEZmESNa2mVuNcoh8f7DuC
         GMqqK/ryVn+LF05C9uytr9IQzGXkax6pL3fAhxjg7W+aDXCuvKon+kqsvRR+DgfG7exT
         AX20av/8ZUJ81CX1enxDo516LlSPKCW+6l/k/8pRa7zor/4CXf7CObhDRRu62lvLguFJ
         KGy5oECp3cQbZrppCIS/gyiPSmdh52S3ZFVhoFKFboYY8TeKH+bqM1A8ikJ41z1++YRP
         mWeDyi7QoNDst7cqDX3msQTHufEvndIqwKA3SJlY2R1ID+IMdVtnimQEy8Qey4CCYsAP
         xEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcKen45R05A6cb2yo+f/kUnBeLAGvq6Omg+I5PLGir4=;
        b=oBkzPh2QGIUcpVPcE5kAY6152Ywg4P0gvXMNscT6Zc2G4Xi/Jv8Aioqd23+AnWquH6
         95n77SRpQkUzAqgEQGSM90SwIIJzdCg4OLg72k4A5lLgcsFYGzdFD5bLn+g1m/KfgRyI
         uW6Z6ac/hczNlpceefiq83TWOaKiAoISiiwGXgoZqHSdycVB1YrLfuFOW2j/5oaumP6m
         wOmlU2V2ogO6Cxxg8Rm7UVQ9lJv8mvKKt59UdUuZ6T+fiODGqJPS8IunI/IMzbdTaOtH
         M8lCsdNfEDNKHwnM7NzwxJFHEsxihyd/9B/XqaTiOrimbZ5p33MRrQBx4JubbwFPn4nx
         rJ3Q==
X-Gm-Message-State: ANoB5pl1v2t5n3i3X2e0ys4szgAhGmgsOAP73yPc9FF+W/025khxxQ0h
        r7Mq8JZ/Xd4q7JqWhjWkYg8=
X-Google-Smtp-Source: AA0mqf4tlY0YkdNise3JgLmOVbHRcM3xVt6faz7b9On/ePMIQKbYRCWpxo80XTbq8yhC412f2Ng11Q==
X-Received: by 2002:a2e:a5c5:0:b0:277:360c:f95e with SMTP id n5-20020a2ea5c5000000b00277360cf95emr5957903ljp.31.1670973085854;
        Tue, 13 Dec 2022 15:11:25 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id g9-20020a2eb5c9000000b002770a7e320esm427713ljn.81.2022.12.13.15.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 15:11:25 -0800 (PST)
Date:   Wed, 14 Dec 2022 02:11:22 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Frank Li <frank.li@nxp.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [EXT] RE: [PATCH v7 5/9] PCI: dwc: Avoid reading a register to
 detect whether eDMA exists
Message-ID: <20221213231122.irtewerzhz73dnxl@mobilestation>
References: <20221128161114.deacldwbckfnn6ft@mobilestation>
 <TYBPR01MB5341FA664D5F1FCA07294F96D8129@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <TYBPR01MB53413E1BE13CCA65307770FDD81D9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20221208140111.7phlnsxktxzsc55f@mobilestation>
 <TYBPR01MB5341B4EB94F1B829F0E0431CD81C9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <HE1PR0401MB23319A9F4AF7630A82249D65881C9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <20221211152849.y2dcxpc2teervlcl@mobilestation>
 <20221212125658.GD20655@thinkpad>
 <20221212165600.tfx3ewjt6z23kfaz@mobilestation>
 <20221212171102.GF20655@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221212171102.GF20655@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 12, 2022 at 10:41:02PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Dec 12, 2022 at 07:56:00PM +0300, Serge Semin wrote:
> > On Mon, Dec 12, 2022 at 06:26:58PM +0530, Manivannan Sadhasivam wrote:
> > > Hi Serge,
> > > 
> > > On Sun, Dec 11, 2022 at 06:28:49PM +0300, Serge Semin wrote:
> > > > Hi Frank
> > > > 
> > > > On Fri, Dec 09, 2022 at 03:52:42PM +0000, Frank Li wrote:
> > > > > Hi Serge,
> > > > > 
> > > > > > From: Serge Semin, Sent: Thursday, December 8, 2022 11:01 PM
> > > > > >
> > > > > > Cc += Frank Li
> > > > > >
> > > > > > @Frank could you have a look at the thread and check the content of
> > > > > > the CSRs dbi+0x8f8 and dbi+0x978 on available to you DW PCIe +EDMA
> > > > > > devices?
> > > > > 
> > > > 
> > > > > [    2.598038] imx6q-pcie 5f010000.pcie_ep: imx_add_pcie_ep: +0x8f8 = 3438302a, +0x978 = 00010001
> > > > 
> > > > Thanks for the reply. So it's 4.80a with the legacy viewport-based
> > > > access. Alas it isn't what we need in this thread. We'll need
> > > > @Mani's respond in order to decide how to fix the auto-detection
> > > > procedure.
> > > > 
> > > 
> > 
> > > Sorry for the late reply!
> > > 
> > > With below diff on the EP:
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 6f3805228a18..0eb4d3218738 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -665,6 +665,10 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> > >         if (val == 0xFFFFFFFF && pci->edma.reg_base) {
> > >                 pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> > >  
> > > +               dev_info(pci->dev, "%s: +0x8f8 = %08x, +0x978 = %08x\n", __func__,
> > > +                       dw_pcie_readl_dbi(pci, 0x8f8),
> > > +                       dw_pcie_readl_dbi(pci, 0x978));
> > > +
> > >                 val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> > >         } else if (val != 0xFFFFFFFF) {
> > >                 pci->edma.mf = EDMA_MF_EDMA_LEGACY;
> > > 
> > > 
> > > The output was:
> > > 
> > > qcom-pcie-ep 1c08000.pcie-ep: dw_pcie_edma_find_chip: +0x8f8 = 3533302a, +0x978 = ffffffff
> > > 
> > > Hope this helps!
> > 
> > Great! Thanks. This indeed helps. So it's 5.30a IP-core. Just one
> > quick question. Does that device have eDMA embedded into the DW PCIe
> > controller?
> > 
> 

> Yes it is and it is the test platform I use for eDMA/PCI_EP work.

So the procedure works well for IP-core 5.30a and AFAICS it doesn't
for 5.40a (eDMA viewport-based CSRs are missing in the HW-manual) and
for an unexpected reason in IP-core 5.20a synthesized for Renesas
R-Car Gen4 PCIe. Thus this seems more like a vendor-specific problem,
than a version-specific one since the HW-manual in both 5.20a and
5.30a cases state that the dbi+0x978 register must have FFs if the CSR
doesn't exist. It doesn't exist if the next statement is false:
!CX_PL_REG_DISABLE && CC_DMA_ENABLE && !CC_UNROLL_ENABLE && CC_DEVICE_TYPE!=3
So seeing the R-Car Gen4 PCIe has the unrolled eDMA mapping the
dbi+0x978 registers must contain FFs.

The best solution in this case would be to have a special
capability flag which would force the unrolled eDMA mapping for the
problematic devices. Like this:
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -840,8 +840,14 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
 	 * Indirect eDMA CSRs access has been completely removed since v5.40a
 	 * thus no space is now reserved for the eDMA channels viewport and
 	 * former DMA CTRL register is no longer fixed to FFs.
+	 *
+	 * Note some devices for unknown reason may have zeros in the eDMA CTRL
+	 * register even though the HW-manual explicitly states there must FFs
+	 * if the unrolled mapping is enabled. For such cases the low-level
+	 * drivers are supposed to manually activate the unrolled mapping to
+	 * bypass the auto-detection procedure.
 	 */
-	if (dw_pcie_ver_is_ge(pci, 540A)) {
+	if (dw_pcie_ver_is_ge(pci, 540A) || dw_pcie_cap_is(pci, EDMA_UNROLL)) {
 		val = 0xFFFFFFFF;
 	else
 		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -52,7 +52,8 @@
 /* DWC PCIe controller capabilities */
 #define DW_PCIE_CAP_REQ_RES		0
 #define DW_PCIE_CAP_IATU_UNROLL		1
-#define DW_PCIE_CAP_CDM_CHECK		2
+#define DW_PCIE_CAP_EDMA_UNROLL		2
+#define DW_PCIE_CAP_CDM_CHECK		3
 
 #define dw_pcie_cap_is(_pci, _cap) \
 	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)

The patch above is based on the updated version of my patchset, which
I'll resubmit for review tomorrow. I'll add @Yoshihiro in Cc-list of
the series.

-Serge(y)

> 
> Thanks,
> Mani
> 
> > -Serge(y)
> > 
> > > 
> > > Thanks,
> > > Mani
> > > 
> > > > -Serge(y)
> > > > 
> > > > > 
> > > > > Frank Li
> > > > > 
> > > > > 
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்
