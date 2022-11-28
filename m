Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F9963AD5A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 17:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiK1QLU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 11:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiK1QLT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 11:11:19 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E8C23143;
        Mon, 28 Nov 2022 08:11:18 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id d3so13719112ljl.1;
        Mon, 28 Nov 2022 08:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hNgjgdeb4Ut7vibTnIRtWpcVS4pTAfXThEtCvjhq93E=;
        b=kMP+t9hZ6vPsmcVmxcpd674YX4ASZidpmXfxN22BbmB6yIqmH73sqUJHyDJYJIRCX9
         iNDacVUyJyLyjSvYFL/pjNXYmX3N4+rsWgVIj7Z8xqRLNn9Hpm/Pat2/DolJrq2hs72Z
         wyOd2tH4VeTLvE2nOQOZ6JaHlj6ol/rvuGQ9eRlwtFcKN98sTsLjWot0iFIpZQDibjKi
         3tQfgUM2YZwHgdOML9X7NIdUpcgXkuSYMEMgM7FhSKlmJVVy3tvo1nnCei4QJeQ0AJa9
         1RkuRT/wIkx16HVCjtkGOVXb7ETun+lSTT9DUpG0rumxZTweL26EcguYq8u7DBAeyvFs
         9zKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNgjgdeb4Ut7vibTnIRtWpcVS4pTAfXThEtCvjhq93E=;
        b=iP2roxabQEuwbPT7QRrSch9qukevsbL7OCcB4O+NkHEdnWNUDBYYEFXBiDnKfxIsWw
         4kz9fPWL00y+BxLaxeelPPZI2FQiV/RsQrZbDTFHoExUE6yeNsFxX1MDVriNWCqr7KL/
         2UW+RY/AegKm5LnhdJ2YwI3FTpIg7qdxeBUhJN2WUZHYcrP87rMM5IrY+EcFrw+YIfIZ
         YJ3uTyL11lXY8Ert73EwFqnbmgkivNG6IclDl2LXW9TImsuUt+fLxtig/crbjX6epd1T
         aeD5CfpWr+je4oamSyg4tnikSxpkzpjz8ZCKDAnNWNCQothRQAuF8VrBfI1pMcJR4ufz
         4v8g==
X-Gm-Message-State: ANoB5pkjN6RarO2W0YxQwoDkZSmaoLETrssZIEZHIzIs+ftqx8Gx1lpf
        Jc8SHlYYJWGZYp9Og5GQv7Y=
X-Google-Smtp-Source: AA0mqf4BB0E+8rpc8Qa0pqcOKnPnmPKRPF+a0w8TkMJYU/k4GkrdGy1c/Zh2UmCxjjFFd9TohdGECw==
X-Received: by 2002:a2e:9007:0:b0:279:84ce:5f71 with SMTP id h7-20020a2e9007000000b0027984ce5f71mr7548639ljg.207.1669651876493;
        Mon, 28 Nov 2022 08:11:16 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651234c900b004b4823f02b0sm1771112lfr.152.2022.11.28.08.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:11:16 -0800 (PST)
Date:   Mon, 28 Nov 2022 19:11:14 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
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
Message-ID: <20221128161114.deacldwbckfnn6ft@mobilestation>
References: <20221121124400.1282768-1-yoshihiro.shimoda.uh@renesas.com>
 <20221121124400.1282768-6-yoshihiro.shimoda.uh@renesas.com>
 <20221122135550.GD157542@thinkpad>
 <20221127235532.u7q7oou36wymkpyf@mobilestation>
 <TYBPR01MB5341932B42719E026AA16D40D8139@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20221128115908.awhznkkrelk7h3nm@mobilestation>
 <TYBPR01MB534107A3C2B521BA0D67B4A7D8139@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYBPR01MB534107A3C2B521BA0D67B4A7D8139@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 28, 2022 at 12:41:11PM +0000, Yoshihiro Shimoda wrote:
> Hi Serge,
> 
> > From: Serge Semin, Sent: Monday, November 28, 2022 8:59 PM
> > 
> > On Mon, Nov 28, 2022 at 02:52:56AM +0000, Yoshihiro Shimoda wrote:
> > > Hi Serge,
> > >
> > > > From: Serge Semin, Sent: Monday, November 28, 2022 8:56 AM
> > > >
> <snip>
> > > > What does the dbi+0x8f8 CSR contain in the host
> > > > and EP registers space? Similarly could you also provide a content of
> > > > the +0x978 register?
> > >
> > > The dbi+0x8f8 and the +0x978 registers' values are 0x00000000.
> > > --------------- (sorry, replace tabs with spaces...)---------------
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -843,6 +843,10 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> > >  {
> > >         u32 val;
> > >
> > 
> > > +       dev_info(pci->dev, "%s: +0x8f8 = %08x, +0x978 = %08x\n", __func__,
> > > +               dw_pcie_readl_dma(pci, 0x8f8),
> > > +               dw_pcie_readl_dma(pci, 0x978));
> > > +
> > 
> > No, this should have been the dw_pcie_readl_dbi() calls instead of
> > dw_pcie_readl_!dma!(). What I try to understand from these values is
> > the real version of your controller (dbi+0x8f8) and whether the legacy
> > eDMA viewport registers range follows the documented convention of
> > having FFs in the dbi+0x978 register. My current assumption that
> > either your IP-core is newer than v5.30a or has some vendor-specific
> > modification. But let's see the value first.
> 

> Oops! I'm sorry for my bad code. After fixed the code, the values are:
> ---
> [    1.108943] pcie-rcar-gen4 e65d0000.pcie: dw_pcie_edma_find_chip: +0x8f8 = 3532302a, +0x978 = 00000000
> ---

@Yoshihiro. Got it. Thanks. Could you please confirm (double-check)
that what the content of the +0x978 CSR was really read by means of the
dw_pcie_readl_dbi() method?

@Mani, could you please have a look at the content of the +0x8f8 and
+0x978 CSRs in the CDM space of the available to you controllers?

I've reproduced the behavior what discovered by @Yoshihiro, but on
v5.40a IP-core only. It was expected for that controller version, but
v5.20a was supposed to have FFs in +0x978 for the unrolled iATU/eDMA
space. It's strange to see it didn't.

-Sergey

> 
> <snip>
> > > So, should I change the condition like below?
> > >
> > > ---
> > > -	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
> > > +	if ((val == 0xFFFFFFFF || val == 0x00000000) && pci->edma.reg_base) {
> > > ...
> > > -	} else if (val != 0xFFFFFFFF) {
> > > -	} else if (!(val == 0xFFFFFFFF || val == 0x00000000)) {
> > > ---
> > 
> > Definitely no. Even though it's impossible to have the eDMA controller
> > configured with zero number of read and write channels we shouldn't
> > assume that getting a zero value from the DMA_CTRL_VIEWPORT_OFF offset
> > means having the unrolled eDMA CSRs mapping. Let's have a look at the
> > content of the dbi+0x8f8 and dbi+0x978 offsets first. Based on these
> > values we'll come up with what to do next.
> 
> I got it.
> 
> Best regards,
> Yoshihiro Shimoda
> 
> > -Serge(y)
> > 
> > >
> > > Best regards,
> > > Yoshihiro Shimoda
> > >
> > > > -Sergey
> > > >
> > > > > >  	} else {
> > > > > >  		return -ENODEV;
> > > > > >  	}
> > > > > > --
> > > > > > 2.25.1
> > > > > >
> > > > >
> > > > > --
> > > > > மணிவண்ணன் சதாசிவம்
