Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEC54FF05D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 09:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiDMHI7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 03:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiDMHI7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 03:08:59 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3B81C901
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 00:06:38 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id i186so741581vsc.9
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 00:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tZdyjOi7z4KK2aBnHBLowY/dv/i24VdQBUn22Y2ZH60=;
        b=UCgsy8yChAMPVpXRqWPmj0CMm3bK9sK5pFogrcsLuEuOKPZp2tnu4kswTn4drPUVJZ
         m+rYMPGtEeM5Gf8TWbq8wUamb9Keb1SlWUTTRYDf/Mlf1CNgBGloy4nMIyvT/0mPizk6
         A8QppKRjNdK/Wu6Oi96ZYPjkkSiI1yRDvyWtoPmnGTGW5M6UZHHDCS4G+/xFEEXTq2lF
         rHYh5xDFbJ+E2lmkB6YdewR29bgnD2vz0R+QL31BdtmR2NV1s3ByS0/yDXosK5gWSrsm
         07iOPxJnY6iw/vAq4JZGnIHmGLg8jQT7wWsNXX3AC24JOtt0fH0MLzw23jvOQP2BNJLx
         Luaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZdyjOi7z4KK2aBnHBLowY/dv/i24VdQBUn22Y2ZH60=;
        b=2NeJ110OyA2XzaBBdVPuXKUDgrKgeqGr/qh3l+Pv2/79pMqdkX3/0GEPRfzXGM4xlL
         QbtwxI3aYntsMDg/dzjc+MR+HcO/H3RaFD68STciKl2jGuUKXI6tY/+0BeLfbJSXb2wT
         jJecSWPe5oCfTPmSBeIb6eTc9PoMlj2gzHgRcJ+5r8KcChCAF6Y9LUiQNeUZm1RHZKVe
         WPAk/xWnF0M6MFT02xbeBm13Yg6cnHqxjfkWEFs3SI+HTRgN6eldFlmlH/gbtaSM1fWZ
         Nw6o3nb5ZMuyUhHK+HoFvM6HRPhzdEW4qzg442qhmNpv15IvPInhiyTnwDtyfUHChxIz
         0Yqw==
X-Gm-Message-State: AOAM533+ejqh7I5OKgkpd5P4TjKPA6gu2CWIQclxZzW7mvmqkSkGI94i
        6e8V50tcxCGlguTLkUKaAMByQMxZX1l3VPRPXDXdHuqB/aqIjQ==
X-Google-Smtp-Source: ABdhPJwjAtQ/rYDqmv2lwTewqiJBTxmeM21Anjy5qq9ZAvNgvynZHye8vuBir3owpOrIYaNUotgBv2G8AH+YZpbfpDM=
X-Received: by 2002:a67:ea4f:0:b0:328:1db4:d85c with SMTP id
 r15-20020a67ea4f000000b003281db4d85cmr8517368vso.20.1649833598055; Wed, 13
 Apr 2022 00:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220226104731.76776-1-chenhuacai@loongson.cn>
 <20220226104731.76776-5-chenhuacai@loongson.cn> <YlWRYTuS6194hVjV@robh.at.kernel.org>
In-Reply-To: <YlWRYTuS6194hVjV@robh.at.kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 13 Apr 2022 15:06:26 +0800
Message-ID: <CAAhV-H7+KMqzcMFRBtoBtg2eCbxArs8o=9CnBV98pU9MjRkGaQ@mail.gmail.com>
Subject: Re: [PATCH V12 4/6] PCI: loongson: Improve the MRRS quirk for LS7A
To:     Rob Herring <robh@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
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

Hi, Rob,

On Tue, Apr 12, 2022 at 10:49 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sat, Feb 26, 2022 at 06:47:29PM +0800, Huacai Chen wrote:
> > In new revision of LS7A, some PCIe ports support larger value than 256,
> > but their maximum supported MRRS values are not detectable. Moreover,
> > the current loongson_mrrs_quirk() cannot avoid devices increasing its
> > MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
> > will actually set a big value in its driver. So the only possible way
> > is configure MRRS of all devices in BIOS, and add a pci host bridge bit
> > flag (i.e., no_inc_mrrs) to stop the increasing MRRS operations.
> >
> > However, according to PCIe Spec, it is legal for an OS to program any
> > value for MRRS, and it is also legal for an endpoint to generate a Read
> > Request with any size up to its MRRS. As the hardware engineers say, the
> > root cause here is LS7A doesn't break up large read requests. In detail,
> > LS7A PCIe port reports CA (Completer Abort) if it receives a Memory Read
> > request with a size that's "too big" ("too big" means larger than the
> > PCIe ports can handle, which means 256 for some ports and 4096 for the
> > others, and of course this is a problem in the LS7A's hardware design).
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/pci/controller/pci-loongson.c | 47 ++++++++++-----------------
> >  drivers/pci/pci.c                     |  6 ++++
> >  include/linux/pci.h                   |  1 +
> >  3 files changed, 25 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> > index 48d9d283cb59..ba182f9d5718 100644
> > --- a/drivers/pci/controller/pci-loongson.c
> > +++ b/drivers/pci/controller/pci-loongson.c
> > @@ -67,37 +67,26 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >                       DEV_LS7A_LPC, system_bus_quirk);
> >
> > -static void loongson_mrrs_quirk(struct pci_dev *dev)
> > +static void loongson_mrrs_quirk(struct pci_dev *pdev)
> >  {
> > -     struct pci_bus *bus = dev->bus;
> > -     struct pci_dev *bridge;
> > -     static const struct pci_device_id bridge_devids[] = {
> > -             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
> > -             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
> > -             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
> > -             { 0, },
> > -     };
> > -
> > -     /* look for the matching bridge */
> > -     while (!pci_is_root_bus(bus)) {
> > -             bridge = bus->self;
> > -             bus = bus->parent;
> > -             /*
> > -              * Some Loongson PCIe ports have a h/w limitation of
> > -              * 256 bytes maximum read request size. They can't handle
> > -              * anything larger than this. So force this limit on
> > -              * any devices attached under these ports.
> > -              */
> > -             if (pci_match_id(bridge_devids, bridge)) {
> > -                     if (pcie_get_readrq(dev) > 256) {
> > -                             pci_info(dev, "limiting MRRS to 256\n");
> > -                             pcie_set_readrq(dev, 256);
> > -                     }
> > -                     break;
> > -             }
> > -     }
> > +     /*
> > +      * Some Loongson PCIe ports have h/w limitations of maximum read
> > +      * request size. They can't handle anything larger than this. So
> > +      * force this limit on any devices attached under these ports.
> > +      */
> > +     struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
> > +
> > +     if (!bridge)
>
> Isn't this condition impossible? I'd drop and just let the NULL
> dereference fault happen rather than continue on silently.
This is copied from quirk_no_ext_tags(), and it seems can be removed, thanks.

Huacai
>
> > +             return;
> > +
> > +     bridge->no_inc_mrrs = 1;
> >  }
> > -DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > +                     DEV_PCIE_PORT_0, loongson_mrrs_quirk);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > +                     DEV_PCIE_PORT_1, loongson_mrrs_quirk);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > +                     DEV_PCIE_PORT_2, loongson_mrrs_quirk);
> >
> >  static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
> >  {
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 9ecce435fb3f..72a15bf9eee8 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5993,6 +5993,7 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
> >  {
> >       u16 v;
> >       int ret;
> > +     struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> >
> >       if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
> >               return -EINVAL;
> > @@ -6011,6 +6012,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
> >
> >       v = (ffs(rq) - 8) << 12;
> >
> > +     if (bridge->no_inc_mrrs) {
> > +             if (rq > pcie_get_readrq(dev))
> > +                     return -EINVAL;
> > +     }
> > +
> >       ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
> >                                                 PCI_EXP_DEVCTL_READRQ, v);
> >
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 8253a5413d7c..01a464eb640a 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -569,6 +569,7 @@ struct pci_host_bridge {
> >       void            *release_data;
> >       unsigned int    ignore_reset_delay:1;   /* For entire hierarchy */
> >       unsigned int    no_ext_tags:1;          /* No Extended Tags */
> > +     unsigned int    no_inc_mrrs:1;          /* No Increase MRRS */
> >       unsigned int    native_aer:1;           /* OS may use PCIe AER */
> >       unsigned int    native_pcie_hotplug:1;  /* OS may use PCIe hotplug */
> >       unsigned int    native_shpc_hotplug:1;  /* OS may use SHPC hotplug */
> > --
> > 2.27.0
> >
