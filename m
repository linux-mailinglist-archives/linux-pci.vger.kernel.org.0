Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63F663A77D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 12:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiK1L7R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 06:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiK1L7O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 06:59:14 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92951A23F;
        Mon, 28 Nov 2022 03:59:12 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id z4so12848821ljq.6;
        Mon, 28 Nov 2022 03:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5vpEfdF1xjqyrkyVB6kidNL3O8KQ6nD1fDQ23Wi/emU=;
        b=bE2NgtoMlhG4XXT2Omx/SuiTKFr/F09W9z1qpRaF0UhE0yYdZnApoQgitVw+VeSTXY
         /ad4MfwB0xYpE1na7XEzmlkkGkLzTtDEVBQuybU1z4bKCQmQfUeUnwRsfo8R3WL6wN2t
         lXAEGMc3fK2W186FcdCGdFaKtBH+iBHYOSSK54mqPU6UnUM0kTH+rQHs7NPQsqoWD2jd
         fmpFCS5oEG4dqy1kJCwOcJDZ7tx2jBm3fZalCH/wECFgnqz/BmK+2seYgM4JmnX07J8L
         GcxnRVM2tiS+Oo84a2iEXOHCPqlQxIH+LC7WJM1/nlUXhtxZsvZcKGOoBwCd2FsMYxNB
         Av2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5vpEfdF1xjqyrkyVB6kidNL3O8KQ6nD1fDQ23Wi/emU=;
        b=QjGUExTcV5b96kyftKnnkU+1UqUGowxdRb1xAPhCq3Ln1Y2ZOCn/NJerj1F2klT0Kh
         8Sm/iuHVGsiEOlpHDOPM13I0qiSFdJe1lQSOlBmhj5Q6QI8sQAsGznwnzHmayX9EkBbe
         ZjKes5VZ3ZTDsO2YVSHe+UhEeuYyEEnB2xjLpXFfDjskDz66ZaaKseg0Qq5SPAZYbM5s
         Mcep4No3RXHoS4F+A9resjoBk5A9MZrHHJsLDpgEmjokCfxx7V27+y4i9kXtw4fZejCM
         M9NnLNlo7zt74k+SJcD34qNMlIBMm/P+CmoNnLmdRzMMOB99S3X3yfLdJKiXfKfJpXxv
         J7Lw==
X-Gm-Message-State: ANoB5pnJOPI4lgLLWQYPM9GQzcFRZqkf7hlW868B/EA4+vfWIarF+qRT
        36jzRtmJ3GtBjFXVfMPfvVg=
X-Google-Smtp-Source: AA0mqf6sOOVvUH6AOUwzEQSgOHr6Wh4eH0HYu1R4m3wKJKln7q90oYMRsigL2Ah96K8Zi3Vig/ujTg==
X-Received: by 2002:a2e:b894:0:b0:277:1c8f:7e8c with SMTP id r20-20020a2eb894000000b002771c8f7e8cmr12164166ljp.296.1669636751078;
        Mon, 28 Nov 2022 03:59:11 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id bf31-20020a2eaa1f000000b00279a25c2427sm414675ljb.139.2022.11.28.03.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 03:59:10 -0800 (PST)
Date:   Mon, 28 Nov 2022 14:59:08 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
Subject: Re: [PATCH v7 5/9] PCI: dwc: Avoid reading a register to detect
 whether eDMA exists
Message-ID: <20221128115908.awhznkkrelk7h3nm@mobilestation>
References: <20221121124400.1282768-1-yoshihiro.shimoda.uh@renesas.com>
 <20221121124400.1282768-6-yoshihiro.shimoda.uh@renesas.com>
 <20221122135550.GD157542@thinkpad>
 <20221127235532.u7q7oou36wymkpyf@mobilestation>
 <TYBPR01MB5341932B42719E026AA16D40D8139@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYBPR01MB5341932B42719E026AA16D40D8139@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 28, 2022 at 02:52:56AM +0000, Yoshihiro Shimoda wrote:
> Hi Serge,
> 
> > From: Serge Semin, Sent: Monday, November 28, 2022 8:56 AM
> > 
> > On Tue, Nov 22, 2022 at 07:25:50PM +0530, Manivannan Sadhasivam wrote:
> > > + Serge (who authored EDMA support)
> > 
> > Thanks @Mani. It's strange to see a fix for a patch which hasn't been even
> > merged in yet and miss the patch author in the Cc list.)
> > 
> > @Yoshihiro, on the next patchset revisions please don't forget to add
> > my email address to the copy list.
> 
> Sure! I'll add your email address on the next patchset revisions.
> 
> > > Thanks,
> > > Mani
> > >
> > > On Mon, Nov 21, 2022 at 09:43:56PM +0900, Yoshihiro Shimoda wrote:
> > > > Since reading value of PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL was
> > > > 0x00000000 on one of SoCs (R-Car S4-8), it cannot find the eDMA.
> > > > So, directly read the eDMA register if edma.reg_base is not zero.
> > > >
> > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > index 637d01807c67..2cc8584da6f4 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > @@ -836,8 +836,7 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> > > >  {
> > > >  	u32 val;
> > > >
> > 
> > > > -	val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > > > -	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
> > > > +	if (pci->edma.reg_base) {
> > > >  		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> > > >
> > > >  		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> > > > @@ -845,6 +844,7 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> > > >  		pci->edma.mf = EDMA_MF_EDMA_LEGACY;
> > > >
> > > >  		pci->edma.reg_base = pci->dbi_base + PCIE_DMA_VIEWPORT_BASE;
> > > > +		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > 
> > Look what you suggest here:
> > < u32 val;
> > < ...
> > < if (pci->edma.reg_base) {
> > < 	...
> > < } else if (val != 0xFFFFFFFF) {
> > < 	...
> > < } else {
> > < ...
> > 
> > It would be strange if your compiler didn't warn about 'val' being used
> > uninitialized here, which in its turn would introduce a regression for
> > the platforms with the indirectly accessible eDMA registers.
> 
> You're correct. It's strange. I don't know why my using compiler [1] didn't
> warn about the 'val' though...
> 
> [1]
> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/11.1.0/x86_64-gcc-11.1.0-nolibc-aarch64-linux.tar.xz
> 
> > Anyway you can't just drop something what didn't work for you
> > hardware. The method you suggest to fix here works fine for multiple
> > DW PCIe IP-cores. Judging by the HW manuals it should work at least up
> > to v5.30a. Are you sure that your controller is of v5.20a? I see you
> > overwrite the IP-core version for the PCIe host driver only. Why is
> > that necessary? Does the version auto-detection procedure work
> > incorrectly for you?
> 
> Thank you for pointed it out! I realized that overwriting the IP-core
> Version was not needed. So, I'll drop it on v8.
> ---
> #define DWC_VERSION             0x520a
> ...
> struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct device *dev)
> {
> ...
> 	rcar->dw.version = DWC_VERSION;
> ---
> 
> > What does the dbi+0x8f8 CSR contain in the host
> > and EP registers space? Similarly could you also provide a content of
> > the +0x978 register?
> 
> The dbi+0x8f8 and the +0x978 registers' values are 0x00000000.
> --------------- (sorry, replace tabs with spaces...)---------------
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -843,6 +843,10 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  {
>         u32 val;
> 

> +       dev_info(pci->dev, "%s: +0x8f8 = %08x, +0x978 = %08x\n", __func__,
> +               dw_pcie_readl_dma(pci, 0x8f8),
> +               dw_pcie_readl_dma(pci, 0x978));
> +

No, this should have been the dw_pcie_readl_dbi() calls instead of
dw_pcie_readl_!dma!(). What I try to understand from these values is
the real version of your controller (dbi+0x8f8) and whether the legacy
eDMA viewport registers range follows the documented convention of
having FFs in the dbi+0x978 register. My current assumption that
either your IP-core is newer than v5.30a or has some vendor-specific
modification. But let's see the value first.

>         if (pci->edma.reg_base) {
>                 pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> -------------------------------------------------------------------
> 
> ----- Output -----
> # dmesg | grep edma
> [    1.108709] pcie-rcar-gen4 e65d0000.pcie: dw_pcie_edma_find_chip: +0x8f8 = 00000000, +0x978 = 00000000
> ------------------
> 

> So, should I change the condition like below?
> 
> ---
> -	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
> +	if ((val == 0xFFFFFFFF || val == 0x00000000) && pci->edma.reg_base) {
> ...
> -	} else if (val != 0xFFFFFFFF) {
> -	} else if (!(val == 0xFFFFFFFF || val == 0x00000000)) {
> ---

Definitely no. Even though it's impossible to have the eDMA controller
configured with zero number of read and write channels we shouldn't
assume that getting a zero value from the DMA_CTRL_VIEWPORT_OFF offset
means having the unrolled eDMA CSRs mapping. Let's have a look at the
content of the dbi+0x8f8 and dbi+0x978 offsets first. Based on these
values we'll come up with what to do next.

-Serge(y)

> 
> Best regards,
> Yoshihiro Shimoda
> 
> > -Sergey
> > 
> > > >  	} else {
> > > >  		return -ENODEV;
> > > >  	}
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > --
> > > மணிவண்ணன் சதாசிவம்
