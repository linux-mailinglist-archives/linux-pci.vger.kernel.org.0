Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CB24CB14E
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 22:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245298AbiCBV3p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 16:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245117AbiCBV3p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 16:29:45 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E66C5599
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 13:29:01 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a8so6489531ejc.8
        for <linux-pci@vger.kernel.org>; Wed, 02 Mar 2022 13:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pMmnRVFQRjI8AqV12Mymv/9X2y9Tr9aEJRNOFwMqokI=;
        b=PKN/5y+9eRzOYkGO7UqDxKFtJg50SR5bKBNAz4zdMn2X8ps5MrK5KJ4uehuht1c2YV
         jQKP/mWufUcCoCXIYtRxUNklcvtJ4OhPMJVLAd2j+7yVeu4kJboedeQgmBrNxp/5bfyc
         c/xeWra+/36afhI8uabB7wejo70iNnr8WzdpR8S6ocmCwNI5yC7Zhywi0LtNGhDlaytp
         7JVWYpPj4oN8GMR74pksjSw2ECAvVtREYqZtLlUyTCjSDAKAW3OVlSME0KNP1diaSWlX
         WoDEUtz2896Ycz0f6Kp8gCo6cJOnxu7P2POrH25v08uDre89dyOgJGkMlQcZtFovLD21
         qA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pMmnRVFQRjI8AqV12Mymv/9X2y9Tr9aEJRNOFwMqokI=;
        b=iG3RcfPQFdCK1yUpQ4DQaghT0+4hpxIVPBKLQZtPNYnlCDhFs0w2aPtBfo72+8p5sU
         3yF8kRNdifMvRcGvOc3nSbmYuCz0ISkd8SJn5JMta6/OAsK5a/Gv5VIT+zG2Y7ZoXXcz
         3iNtVOvFPzALoQlxdFgJeKV1EZnviv0Dks3RKl3CyHiCC4qkU4lMGTomC9hD2gTUutja
         uNjFdCbeRqB4PiI+BtWlpGejwBpS/Wz+zsPrR7i0+SPzCqKP/Wivc61EiBeL+1jCva97
         ahOUVZAPxsvYyBdwnNT5pOofovzszcFHFgYdylmGDlXt6qyJjjinZ6SHn/qg2RBBoy8N
         gn7Q==
X-Gm-Message-State: AOAM531o2C6wt0OjBUX24JZRg3d9OejbGBH5RAhEPY+oVqSy2BpSHNDp
        EE1MqJzxiFM1yzRoIooHFCRhPOXCxQ5YrHk8va8=
X-Google-Smtp-Source: ABdhPJy2X8GuUhat7Nszu2l88bZxL3l6ZYbXQWVk2Ogrjo1NDuxR48X0cGTk+6Depwf+zsYiky0NW2oD6eL7L8OGGo8=
X-Received: by 2002:a17:907:1c13:b0:6da:62bb:f1ff with SMTP id
 nc19-20020a1709071c1300b006da62bbf1ffmr3765577ejc.276.1646256539479; Wed, 02
 Mar 2022 13:28:59 -0800 (PST)
MIME-Version: 1.0
References: <CAHrpEqR8ZwNVFqqRo0hAAt8aDDrduXnBRTTw3G868wkOP3EKYg@mail.gmail.com>
 <20220302212119.GA754158@bhelgaas>
In-Reply-To: <20220302212119.GA754158@bhelgaas>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Wed, 2 Mar 2022 15:28:48 -0600
Message-ID: <CAHrpEqSBLMU-RO8moqvSQUcP62N7xqpNyHfH1UERB_qAByK+2Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI: imx6: add PCIe embedded DMA support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 2, 2022 at 3:21 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Mar 02, 2022 at 02:49:45PM -0600, Zhi Li wrote:
> > On Wed, Mar 2, 2022 at 2:15 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > In subject:
> > >
> > >   PCI: imx6: Add embedded DMA support
> > >
> > > to match existing style.  "PCIe" seems superfluous here since we
> > > already mentioned it earlier in the subject.
> >
> > Sorry, it is PCI when git log to check old history.
>
> I don't understand.  But maybe this would be better?
>
>   PCI: imx6: Add embedded DMA controller support
>
> > > On Tue, Mar 01, 2022 at 09:26:45PM -0600, Frank Li wrote:
> > > > ...
>
> > > > The DMA can transfer data to any remote address location
> > > > regardless PCI address space size.
> > >
> > > What is this sentence telling us?  Is it merely that the DMA "inbound
> > > address space" may be larger than the MMIO "outbound address space"?
> > > I think there's no necessary connection between them, and there's no
> > > need to call it out as though it's something special.
> >
> > There are outbound address windows. such as 256M, but RC sides have more
> > than 256M ddr memory, such as 16GB. If CPU or external DMA controller,
> > only can access 256M
> > address space.
> >
> > But if using an embedded DMA controller,  it can access the whole RC's
> > 16G address without
> > changing iAtu mapping.
> >
> > I want to say why I need enable embedded DMA for EP.
>
> OK, so if IIUC, the DMA controller is embedded in the imx6 host bridge
> (of course; that's obvious from what you're doing here).  And unlike
> DMA from devices *below* the host bridge, DMAs from the embedded
> controller don't go through the iATU, so they are not subject to any
> of the iATU limitations.  Right?

Yes!

>
> > > > +static int imx_add_pcie_dma(struct imx6_pcie *imx6_pcie,
> > > > +                         struct platform_device *pdev,
> > > > +                         struct resource *dbi_base)
> > >
> > > IIUC this is already in pci->dbi_base, so why not use that instead of
> > > passing it in?  Passing both a struct and the contents of a member of
> > > the struct is an opportunity for a mistake.
> >
> > pci->dbi_base just provides a virtual address.
> > I can change dbi_base as dbi_res.
>
> Ah, I missed that you use the CPU physical address from the struct
> resource.
>
> Strictly speaking, what you need is not the CPU physical address, but
> the DMA address that appears on the PCI bus.  In your case, these
> likely have identical values, but the logical PCI architecture, which
> allows things like IOMMUs, does not guarantee this.

I think dw_edma driver may not use this physical address.
But dw_edma_probe() requested fill in this data.

>
> > > > +{
> > > > +     unsigned int pcie_dma_offset;
> > > > +     struct dw_pcie *pci = imx6_pcie->pci;
> > > > +     struct device *dev = pci->dev;
> > > > +     struct dw_edma_chip *dma = &imx6_pcie->dma_chip;
> > > > +     int i = 0;
> > > > +     u64 pbase;
> > > > +     void *vbase;
> > > > +     int sz = PAGE_SIZE;
> > > > +
> > > > +     pcie_dma_offset = 0x970;
> > > > +
> > > > +     pbase = dbi_base->start + pcie_dma_offset;
> > > > +     vbase = pci->dbi_base + pcie_dma_offset;
