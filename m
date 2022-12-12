Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7397E64A55B
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 17:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiLLQ4L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 11:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiLLQ4I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 11:56:08 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0812A1056C;
        Mon, 12 Dec 2022 08:56:05 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id g14so402261ljh.10;
        Mon, 12 Dec 2022 08:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v0t8m2A6LwTPew7a6nNoZdK7l+goAN0nhvA7Mx3wnVQ=;
        b=n1GdntSRerhgIwN23kYFsBHRr6Fc+V3zKMk5MiSQ00A22vhKaurSHWgaKGxu6/ZbKj
         Txe4uMpTCE8JrizcIwD2pGLhQm3jvR7NOO7wb7kfdtDE10hTwyvdPRL0OBOCU774flEF
         r0+eHPDrjdY9HFyhcVMY1ZMYlFfP5OGqS4dHsMKG+BkqeHjQkl9rFkof2PeF9/zeWCqF
         P7gcsaA5VKw6AihWCAZfIwfcYcVHOOtij1v6QX6/bpErHHf+7usvDogPapEkjUR68T4r
         fsnnvyYeFcCeNNoIgau+cnT4j0QlPSO2DMlmT2tsynQWRQ85zFbMBj2Su3wLKlyfepX6
         RCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0t8m2A6LwTPew7a6nNoZdK7l+goAN0nhvA7Mx3wnVQ=;
        b=FLOEWxtZljlmBCOKRA81tGXv85yuknR9uTVKvGNIaEyqP8jEiZlpv5FVvjCVchGMTY
         QwQqo+qYf0FeCTpNq/pf9D8Ogi2L83P4M6y81ieSz/N0KMUSSbrOBNxQiY9ReTXda85D
         iYadpY4BJE53wWbo3bTggUI8jug2asMBfSsWxj52OREljhpUfZz0z3FnUXjzh2ywbwrv
         5gUMYbHhi3+rMwcq9SjLKDpx4xEnUV0ef5Y0rKtHYnspGymzOjwzSL9wEkD18PWcjwLp
         ogwVTUUGRXAMsQRgVFawzEDRVNGQnReG8BCsgJ/CnWRosYwYVhcDWUtxJX/iEe9Z5U0+
         MSfw==
X-Gm-Message-State: ANoB5pktxc64K7+yAo/+ig3yWmvNhbu7SnCTPkolO092gsug/4rzJRaf
        HlN8upqPHRCLxg/JnOCQtpI=
X-Google-Smtp-Source: AA0mqf58Xa5Xi29wzEZ+b3IzTZ1Pjytm7Tua/eOiBd8ImCCACxda03rFc8j0kDRKp8EufFVT5Ph7Wg==
X-Received: by 2002:a05:651c:168d:b0:27a:23a:d77f with SMTP id bd13-20020a05651c168d00b0027a023ad77fmr4013481ljb.51.1670864163295;
        Mon, 12 Dec 2022 08:56:03 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id s1-20020a05651c200100b002771057e0e5sm28640ljo.76.2022.12.12.08.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 08:56:02 -0800 (PST)
Date:   Mon, 12 Dec 2022 19:56:00 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Message-ID: <20221212165600.tfx3ewjt6z23kfaz@mobilestation>
References: <20221128115908.awhznkkrelk7h3nm@mobilestation>
 <TYBPR01MB534107A3C2B521BA0D67B4A7D8139@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20221128161114.deacldwbckfnn6ft@mobilestation>
 <TYBPR01MB5341FA664D5F1FCA07294F96D8129@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <TYBPR01MB53413E1BE13CCA65307770FDD81D9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20221208140111.7phlnsxktxzsc55f@mobilestation>
 <TYBPR01MB5341B4EB94F1B829F0E0431CD81C9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <HE1PR0401MB23319A9F4AF7630A82249D65881C9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <20221211152849.y2dcxpc2teervlcl@mobilestation>
 <20221212125658.GD20655@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221212125658.GD20655@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 12, 2022 at 06:26:58PM +0530, Manivannan Sadhasivam wrote:
> Hi Serge,
> 
> On Sun, Dec 11, 2022 at 06:28:49PM +0300, Serge Semin wrote:
> > Hi Frank
> > 
> > On Fri, Dec 09, 2022 at 03:52:42PM +0000, Frank Li wrote:
> > > Hi Serge,
> > > 
> > > > From: Serge Semin, Sent: Thursday, December 8, 2022 11:01 PM
> > > >
> > > > Cc += Frank Li
> > > >
> > > > @Frank could you have a look at the thread and check the content of
> > > > the CSRs dbi+0x8f8 and dbi+0x978 on available to you DW PCIe +EDMA
> > > > devices?
> > > 
> > 
> > > [    2.598038] imx6q-pcie 5f010000.pcie_ep: imx_add_pcie_ep: +0x8f8 = 3438302a, +0x978 = 00010001
> > 
> > Thanks for the reply. So it's 4.80a with the legacy viewport-based
> > access. Alas it isn't what we need in this thread. We'll need
> > @Mani's respond in order to decide how to fix the auto-detection
> > procedure.
> > 
> 

> Sorry for the late reply!
> 
> With below diff on the EP:
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 6f3805228a18..0eb4d3218738 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -665,6 +665,10 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>         if (val == 0xFFFFFFFF && pci->edma.reg_base) {
>                 pci->edma.mf = EDMA_MF_EDMA_UNROLL;
>  
> +               dev_info(pci->dev, "%s: +0x8f8 = %08x, +0x978 = %08x\n", __func__,
> +                       dw_pcie_readl_dbi(pci, 0x8f8),
> +                       dw_pcie_readl_dbi(pci, 0x978));
> +
>                 val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
>         } else if (val != 0xFFFFFFFF) {
>                 pci->edma.mf = EDMA_MF_EDMA_LEGACY;
> 
> 
> The output was:
> 
> qcom-pcie-ep 1c08000.pcie-ep: dw_pcie_edma_find_chip: +0x8f8 = 3533302a, +0x978 = ffffffff
> 
> Hope this helps!

Great! Thanks. This indeed helps. So it's 5.30a IP-core. Just one
quick question. Does that device have eDMA embedded into the DW PCIe
controller?

-Serge(y)

> 
> Thanks,
> Mani
> 
> > -Serge(y)
> > 
> > > 
> > > Frank Li
> > > 
> > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
