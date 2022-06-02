Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D072453B919
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 14:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiFBMsg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 08:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbiFBMsf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 08:48:35 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37038BD19
        for <linux-pci@vger.kernel.org>; Thu,  2 Jun 2022 05:48:30 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p130so316497iod.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Jun 2022 05:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sooqa1gs29vdUfVWNr6XLIeMcsGBllRuf+hpT5OEhy0=;
        b=OG+3PRaK1mvJqwLq9xdKyLHHvD/eKClb/qYRmFlTNP0EAOlnmjBv4uouiCkhN9opxx
         Ja+Fqx8ig8SHlclJRlu5QqINDS2SBlI2VPs409lMKWTet7M0dspmjFhiLxJyK4tAnBu6
         DOpivJ2hj3xkYZNYRLPVAww7ZjIXnKmCvR9k4w0Ym+hg9v1AULz1A02qsXet+2dM9j2n
         crSsjwguAmLElF6CcChXk/1oS73eq36bNAG7Bq8Rp02ITlXlR5O0/5gfrMqbLQSp31fR
         2WEaydklMEgh4y6qBRI+V9n1nvCiMM3afMY8Oh5hoJj0F/aIRie8ZWE7dvEDIGeGtt1t
         5qDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sooqa1gs29vdUfVWNr6XLIeMcsGBllRuf+hpT5OEhy0=;
        b=kLgLW6RxGrDQrnsDOrSCZwVXJz/0TBPcNvSwF+JuwUHCr6OwaWi0socrL5szs/4eU9
         UcQtIYnvQQapxyWyD3YFb2kA7b2x0+z7xtJCJV8Ca3hQGzJkNMfymN4uIlMWG4+Jpt8E
         fDHQOBlMQiyZqhF8osV14XoqD/JhometjOZ5oQTPmLOAAlsQ/2ehGGa604mq0DSxQr0V
         ktbmYpUItZIEXkQesUH01yxIyvX62BPWuRhYR2Wl/iYO9NiurtY5iJuFdkc/HCBGF6lD
         mxmpHnDcussQeA31bnV/D/NLmw8Xy3xUinSMmU7HUarJ9saLk02w/2GI/2CqVadaGwPO
         Zg+g==
X-Gm-Message-State: AOAM533iFOhkD9RvPgVimUhF8stMe/Zwvkro/bdRPmxiioZmUIjH6aaA
        6r2tVElAKofRloSFEAuDAHAMKA6ZSx8MkQWc0qDzeeSajgrUsLB4AQc=
X-Google-Smtp-Source: ABdhPJx33ZpC7EnseyQSzDMm4qtuboMIo4G1L9O6uo24QAv5iuFlA8997Dkvz7doMYioM1C1ApnR3TvaB29bkuS9tjE=
X-Received: by 2002:a6b:fb05:0:b0:657:655e:a287 with SMTP id
 h5-20020a6bfb05000000b00657655ea287mr2490804iog.211.1654174110243; Thu, 02
 Jun 2022 05:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220430084846.3127041-6-chenhuacai@loongson.cn> <20220531233527.GA797502@bhelgaas>
In-Reply-To: <20220531233527.GA797502@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 2 Jun 2022 20:48:20 +0800
Message-ID: <CAAhV-H49bwGf8=qs3GSLv-7wZHv_mW05kY4OktgvDviuscgVrg@mail.gmail.com>
Subject: Re: [PATCH V13 5/6] PCI: Add quirk for LS7A to avoid reboot failure
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
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

Hi, Bjorn,

On Wed, Jun 1, 2022 at 7:35 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sat, Apr 30, 2022 at 04:48:45PM +0800, Huacai Chen wrote:
> > Commit cc27b735ad3a75574a ("PCI/portdrv: Turn off PCIe services during
> > shutdown")
>
> Usual quoting style would be
>
>   cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during shutdown")
>   causes poweroff/reboot ...
OK, thanks.

>
> > causes poweroff/reboot failure on systems with LS7A chipset.
> > We found that if we remove "pci_command &= ~PCI_COMMAND_MASTER;" in
> > do_pci_disable_device(), it can work well. The hardware engineer says
> > that the root cause is that CPU is still accessing PCIe devices while
> > poweroff/reboot, and if we disable the Bus Master Bit at this time, the
> > PCIe controller doesn't forward requests to downstream devices, and also
> > doesn't send TIMEOUT to CPU, which causes CPU wait forever (hardware
> > deadlock). This behavior is a PCIe protocol violation (Bus Master should
> > not be involved in CPU MMIO transactions), and it will be fixed in new
> > revisions of hardware (add timeout mechanism for CPU read request,
> > whether or not Bus Master bit is cleared).
>
> LS7A might have bugs in that clearing Bus Master Enable prevents the
> root port from forwarding Memory or I/O requests in the downstream
> direction.
>
> But this feels like a bit of a band-aid because we don't know exactly
> what those requests are.  If we're removing the Root Port, I assume we
> think we no longer need any devices *below* the Root Port.
>
> If that's not the case, e.g., if we still need to produce console
> output or save state to a device, we probably should not be removing
> the Root Port at all.
Do you mean it is better to skip the whole pcie_port_device_remove()
instead of just removing the "clear bus master" operation for the
buggy hardware?

Huacai
>
> > On some x86 platforms, radeon/amdgpu devices can cause similar problems
> > [1][2]. Once before I wanted to make a single patch to solve "all of
> > these problems" together, but it seems unreasonable because maybe they
> > are not exactly the same problem. So, this patch just add a quirk for
> > LS7A to avoid clearing Bus Master bit in pcie_port_device_remove(), and
> > leave other platforms as is.
> >
> > [1] https://bugs.freedesktop.org/show_bug.cgi?id=97980
> > [2] https://bugs.freedesktop.org/show_bug.cgi?id=98638
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/pci/controller/pci-loongson.c | 17 +++++++++++++++++
> >  drivers/pci/pcie/portdrv_core.c       |  6 +++++-
> >  include/linux/pci.h                   |  1 +
> >  3 files changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> > index 83447264048a..49d8b8c24ffb 100644
> > --- a/drivers/pci/controller/pci-loongson.c
> > +++ b/drivers/pci/controller/pci-loongson.c
> > @@ -85,6 +85,23 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >                       DEV_PCIE_PORT_2, loongson_mrrs_quirk);
> >
> > +static void loongson_bmaster_quirk(struct pci_dev *pdev)
> > +{
> > +     /*
> > +      * Some Loongson PCIe ports will cause CPU deadlock if disable
> > +      * the Bus Master bit during poweroff/reboot.
> > +      */
> > +     struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
> > +
> > +     bridge->no_dis_bmaster = 1;
> > +}
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > +                     DEV_PCIE_PORT_0, loongson_bmaster_quirk);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > +                     DEV_PCIE_PORT_1, loongson_bmaster_quirk);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > +                     DEV_PCIE_PORT_2, loongson_bmaster_quirk);
> > +
> >  static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
> >  {
> >       struct pci_config_window *cfg;
> > diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> > index 604feeb84ee4..23f41e31a6c6 100644
> > --- a/drivers/pci/pcie/portdrv_core.c
> > +++ b/drivers/pci/pcie/portdrv_core.c
> > @@ -491,9 +491,13 @@ EXPORT_SYMBOL_GPL(pcie_port_find_device);
> >   */
> >  void pcie_port_device_remove(struct pci_dev *dev)
> >  {
> > +     struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> > +
> >       device_for_each_child(&dev->dev, NULL, remove_iter);
> >       pci_free_irq_vectors(dev);
> > -     pci_disable_device(dev);
> > +
> > +     if (!bridge->no_dis_bmaster)
> > +             pci_disable_device(dev);
> >  }
> >
> >  /**
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index d146eb28e6da..c52d6486ff99 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -570,6 +570,7 @@ struct pci_host_bridge {
> >       unsigned int    ignore_reset_delay:1;   /* For entire hierarchy */
> >       unsigned int    no_ext_tags:1;          /* No Extended Tags */
> >       unsigned int    no_inc_mrrs:1;          /* No Increase MRRS */
> > +     unsigned int    no_dis_bmaster:1;       /* No Disable Bus Master */
> >       unsigned int    native_aer:1;           /* OS may use PCIe AER */
> >       unsigned int    native_pcie_hotplug:1;  /* OS may use PCIe hotplug */
> >       unsigned int    native_shpc_hotplug:1;  /* OS may use SHPC hotplug */
> > --
> > 2.27.0
> >
