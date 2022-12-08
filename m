Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4D064713C
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 15:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiLHOBS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 09:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiLHOBR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 09:01:17 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CD539E;
        Thu,  8 Dec 2022 06:01:16 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id s8so2166993lfc.8;
        Thu, 08 Dec 2022 06:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=royGBGeQe03mj6YzpytN9j6h7rr5KUHJiZDkbf1e+NI=;
        b=O9F+0oZbPEu/1g4NGegNtl0Nyo/+SpwWR7RHxRZCnriug9e0tBeSlU/dEng8tDbQnr
         9Dz5fes9pHILNrd5iQaWbWbERtpkfhCQ4iqAHev6dR5UHkRaSn+Duw9fc7oD+B9bEZNy
         Y9wWYW94q8G/eUIX6CqsmZGRtQcV15h3iEROcJFKkgxIAWTiyEgLaBqpKHi5scFRo9ts
         PfHZ1DhmHUScQZZoqh2bNjBmx2gQXFuJ0cSG91yb3OiCqhRbDOKjXu0ruK+ivBZPaNBS
         39+D5DeilJh+3cELXSU2iPRQFyA7aeXPqkT2wbDHkudc3rJUU26drukYpreuH/RkuwBD
         gdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=royGBGeQe03mj6YzpytN9j6h7rr5KUHJiZDkbf1e+NI=;
        b=d6ydvDa33LUJ5477WH1CQfox4rS7TSPdgKPJHQm5zs3Yepz7Jznrjj9KGjW6nEhQRj
         Dmbs2FZlDpULV4VWAFRzsliMdfgCT8aTKvefhST9O6mrFEIgyM/htTFB4ffceMVWjy03
         v/EnNuga471fexrTzScHFtDhaOXJ2dq275z+Ny+WnUnaEk8BFH/Hg5igmT5YMfbdX9v5
         QHUvvQehz3pFZI9p3gsmGOqgpQOI7wUp/JAMZSDbo/No4zshYKvdzREV3uMwBN2G2Wd7
         kl88dMkn0fSuNd1Luxv5nV2LCdkf4J711GJvZQeghABRq3HX1zx0idXHgZ0KM5o3OUZZ
         UvIA==
X-Gm-Message-State: ANoB5plla25rCnngzMk2TX5YT2NtHjq/A5J2B4m+55R2h1OLdEoBab3q
        62WS6++T0K0EbKCxhJ+cDk8=
X-Google-Smtp-Source: AA0mqf7ChOf5ktMT5YTqhw8zRkvR+EfOySECV3MkenBcEEoi+VLpr1qBIIv1gDiVElayN+ZXjfssUw==
X-Received: by 2002:a05:6512:2f0:b0:4a9:d072:f5c1 with SMTP id m16-20020a05651202f000b004a9d072f5c1mr649233lfq.51.1670508074031;
        Thu, 08 Dec 2022 06:01:14 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id m18-20020a194352000000b004b55ca53543sm2278805lfj.233.2022.12.08.06.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 06:01:13 -0800 (PST)
Date:   Thu, 8 Dec 2022 17:01:11 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
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
Subject: Re: [PATCH v7 5/9] PCI: dwc: Avoid reading a register to detect
 whether eDMA exists
Message-ID: <20221208140111.7phlnsxktxzsc55f@mobilestation>
References: <20221121124400.1282768-1-yoshihiro.shimoda.uh@renesas.com>
 <20221121124400.1282768-6-yoshihiro.shimoda.uh@renesas.com>
 <20221122135550.GD157542@thinkpad>
 <20221127235532.u7q7oou36wymkpyf@mobilestation>
 <TYBPR01MB5341932B42719E026AA16D40D8139@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20221128115908.awhznkkrelk7h3nm@mobilestation>
 <TYBPR01MB534107A3C2B521BA0D67B4A7D8139@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20221128161114.deacldwbckfnn6ft@mobilestation>
 <TYBPR01MB5341FA664D5F1FCA07294F96D8129@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <TYBPR01MB53413E1BE13CCA65307770FDD81D9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYBPR01MB53413E1BE13CCA65307770FDD81D9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cc += Frank Li

@Frank could you have a look at the thread and check the content of
the CSRs dbi+0x8f8 and dbi+0x978 on available to you DW PCIe +EDMA
devices?

On Thu, Dec 08, 2022 at 12:26:18PM +0000, Yoshihiro Shimoda wrote:
> Hi Serge, Manivannan,
> 
> > From: Yoshihiro Shimoda, Sent: Tuesday, November 29, 2022 9:22 AM
> > 
> > > From: Serge Semin, Sent: Tuesday, November 29, 2022 1:11 AM
> > >
> > > On Mon, Nov 28, 2022 at 12:41:11PM +0000, Yoshihiro Shimoda wrote:
> > > > Hi Serge,
> > > >
> > > > > From: Serge Semin, Sent: Monday, November 28, 2022 8:59 PM
> > > > >
> > > > > On Mon, Nov 28, 2022 at 02:52:56AM +0000, Yoshihiro Shimoda wrote:
> > > > > > Hi Serge,
> > <snip>
> > > > > No, this should have been the dw_pcie_readl_dbi() calls instead of
> > > > > dw_pcie_readl_!dma!(). What I try to understand from these values is
> > > > > the real version of your controller (dbi+0x8f8) and whether the legacy
> > > > > eDMA viewport registers range follows the documented convention of
> > > > > having FFs in the dbi+0x978 register. My current assumption that
> > > > > either your IP-core is newer than v5.30a or has some vendor-specific
> > > > > modification. But let's see the value first.
> > > >
> > >
> > > > Oops! I'm sorry for my bad code. After fixed the code, the values are:
> > > > ---
> > > > [    1.108943] pcie-rcar-gen4 e65d0000.pcie: dw_pcie_edma_find_chip: +0x8f8 = 3532302a, +0x978 = 00000000
> > > > ---
> > >
> > > @Yoshihiro. Got it. Thanks. Could you please confirm (double-check)
> > > that what the content of the +0x978 CSR was really read by means of the
> > > dw_pcie_readl_dbi() method?
> > 
> > Yes, I used dw_pcie_readl_dbi() like below.
> > 
> > --------------- (sorry, tabs replaced with spaces) ---------------
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -843,6 +843,10 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> >  {
> >         u32 val;
> > 
> > +       dev_info(pci->dev, "%s: +0x8f8 = %08x, +0x978 = %08x\n", __func__,
> > +               dw_pcie_readl_dbi(pci, 0x8f8),
> > +               dw_pcie_readl_dbi(pci, 0x978));
> > +
> >         if (pci->edma.reg_base) {
> >                 pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> > ------------------------------------------------------------------
> > 
> > > @Mani, could you please have a look at the content of the +0x8f8 and
> > > +0x978 CSRs in the CDM space of the available to you controllers?
> > >
> > > I've reproduced the behavior what discovered by @Yoshihiro, but on
> > > v5.40a IP-core only. It was expected for that controller version, but
> > > v5.20a was supposed to have FFs in +0x978 for the unrolled iATU/eDMA
> > > space. It's strange to see it didn't.
> 

> So, should I add a quirk flag for my controller like below?
> ---
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 69665a8a002e..384bd2c0ea75 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -844,7 +844,7 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>         u32 val;
> 
>         val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);

> -       if (val == 0xFFFFFFFF && pci->edma.reg_base) {
> +       if ((pci->no_dma_ctrl_reg || val == 0xFFFFFFFF) && pci->edma.reg_base) {
>                 pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> 
>                 val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);

Very much no. I have just got rid from such boolean flags from the DW
PCI private data.

Please be patient. Maintainers not always respond as soon as we would
want. Please note my patchset also stalls due to your discovery (DW
eDMA patches still under review).

What we have discovered here is the undocumented behavior. The
HW-manuals from 4.80 up to 5.30 say that the register dbi+0x978 must
have FFs if the register doesn't exist. A similar rule is defined for
the iATU CSRs space and it's working well at least up to IP-core
5.40a. The viewport-based eDMA CSRs space has been removed from the
HW-manuals since IP-core 5.40a and I can assure that IP-core 5.40a has
zeros in dbi+0x978 on the real HW. I do have another devices with eDMA
but all of them have been synthesized with the legacy viewport-based
eDMA access, so I can't check whether the FFs statement is correct for
the devices older than 5.40. You detected the problem on the IP-core
5.20a, but @Mani didn't see it on his devices. Neither does Frank
AFAIU. That's why I asked him and @Frank to check what value the
dbi+0x8f8 and dbi+0x978 registers have in their devices at hand. After
that we'll either add the IP-core version based test here:
< -       val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
< +       if (dw_pcie_ver_is_ge(pci, 5?0A)) {
< +               val = 0xFFFFFFFF;
< +       else
< +               val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
or add a new capability flag if @Mani has IP-core 5.20a with FFs in
the CSRs dbi+0x978. Like this:
< -       val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
< +       if (dw_pcie_cap_is(pci, EDMA_UNROLL)) {
< +               val = 0xFFFFFFFF;
< +       else
< +               val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);

So the main goal of this activity is to check whether your discovery
is a bug on your particular device or is a bug in the HW-manuals. If
the later is correct then the eDMA CSRs space auto-detection procedure
should be fixed to be executed up to the corresponding IP-core
version. If the former is correct then we'll add a new capability
flag. In anyway having the new boolean field in the device private
data wouldn't be a good option since there is the capabilities API
available in the driver.

-Serge(y)

> ---
> 
> Best regards,
> Yoshihiro Shimoda
> 
> > > -Sergey
> > >
> > > >
> > > > <snip>
> > > > > > So, should I change the condition like below?
> > > > > >
> > > > > > ---
> > > > > > -	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
> > > > > > +	if ((val == 0xFFFFFFFF || val == 0x00000000) && pci->edma.reg_base) {
> > > > > > ...
> > > > > > -	} else if (val != 0xFFFFFFFF) {
> > > > > > -	} else if (!(val == 0xFFFFFFFF || val == 0x00000000)) {
> > > > > > ---
> > > > >
> > > > > Definitely no. Even though it's impossible to have the eDMA controller
> > > > > configured with zero number of read and write channels we shouldn't
> > > > > assume that getting a zero value from the DMA_CTRL_VIEWPORT_OFF offset
> > > > > means having the unrolled eDMA CSRs mapping. Let's have a look at the
> > > > > content of the dbi+0x8f8 and dbi+0x978 offsets first. Based on these
> > > > > values we'll come up with what to do next.
> > > >
> > > > I got it.
> > > >
> > > > Best regards,
> > > > Yoshihiro Shimoda
> > > >
> > > > > -Serge(y)
> > > > >
> > > > > >
> > > > > > Best regards,
> > > > > > Yoshihiro Shimoda
> > > > > >
> > > > > > > -Sergey
> > > > > > >
> > > > > > > > >  	} else {
> > > > > > > > >  		return -ENODEV;
> > > > > > > > >  	}
> > > > > > > > > --
> > > > > > > > > 2.25.1
> > > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > மணிவண்ணன் சதாசிவம்
