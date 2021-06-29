Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178093B6CEC
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 05:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhF2DXZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 23:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbhF2DXY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 23:23:24 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E04C061574
        for <linux-pci@vger.kernel.org>; Mon, 28 Jun 2021 20:20:57 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id i189so24938695ioa.8
        for <linux-pci@vger.kernel.org>; Mon, 28 Jun 2021 20:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H4Q0qI7TS1vfj8Xl+91/h1jeTQwskqL5ssAhdIBsxk4=;
        b=Z61MSuCVR8PNot1PGuUbu0lMUSrn/e2eb2N8ZWP/mmxWYZ4n2l9wyn7McRuToHruA+
         pbr3bcVU7/+eCj8wsEOtO0l1L1CZ9V9hBc6QfYfXKWHLB1t5AAoOgu1cAD8XBSxO0z2R
         Abs++ryVuIFxRzbtGs+QpLk8EiiNCt5+Zs8tPmon+HC3EB6daUoMfz5l1J1zKUlgMAw/
         yrSR6HVOzXuOlqcDhiy5/xG3bD2CIQQrYp241XjPKKlQfIBHApZBh5xnbrRZzwERpYtG
         hEhKYuLeQdwClwvasLX33L8JoxipnlEYhZ+Qj8Gkm/rt7gqpc0uvJZZ+Li7uYEhVbh/z
         Getw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H4Q0qI7TS1vfj8Xl+91/h1jeTQwskqL5ssAhdIBsxk4=;
        b=GF7hhO/aH9zynPwMpdMpD1zKGmBm6pA6e2RIBXkMdmECuCPr7yJqCJUl5i34g+yI03
         vY7hAxw8wUyabBz2prwbiSJh5UjjAU9AjxbBFmt1IWnvL0/1eKfJuOQ1fFg9B/xd9Tai
         PClnZbUwXJs+c5bRflHH3adbMcx2ODGgk3w85TkNhlBY/76s6gOTTaibP3CrPHk9CEOl
         1DAggnzNPcEeGNjtvm1tXYQRe5T1+KV4UJiPoZARE0fBdv2HJwemBxxCKRrYi9+cjCHt
         xjpmRKOnQ/3IMTYMuAY8v6rnazDvpotepB7u1ycXQmlwwOjLovdNsQIgrt0jNoxR4pSK
         91dA==
X-Gm-Message-State: AOAM533uPVLWOvM2Yo3d3lCsLmZ2YQt9cDKSfm8InUQJCrAU60yZ/2r1
        d6qm0+NFXyLo586gFUiop5O7wWwa5uS04g/FBds=
X-Google-Smtp-Source: ABdhPJyn7/0QgzEpi4x00Sa72KyF68O5pEsgqhpU4L1hWul9vWD9955A5gbvty3e6GYtDlQvCSqslGiYOYmG589aMgo=
X-Received: by 2002:a02:9f05:: with SMTP id z5mr2336206jal.23.1624936856627;
 Mon, 28 Jun 2021 20:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210628101027.1372370-4-chenhuacai@loongson.cn> <20210628223510.GA3956387@bjorn-Precision-5520>
In-Reply-To: <20210628223510.GA3956387@bjorn-Precision-5520>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 29 Jun 2021 11:20:45 +0800
Message-ID: <CAAhV-H72fyOHGyOMk7OE5HmZUec5J1vE2K3D2bxrerikk9QBUw@mail.gmail.com>
Subject: Re: [PATCH V4 3/4] PCI: Improve the MRRS quirk for LS7A
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Tue, Jun 29, 2021 at 6:35 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Jun 28, 2021 at 06:10:26PM +0800, Huacai Chen wrote:
> > In new revision of LS7A, some PCIe ports support larger value than 256,
> > but their maximum supported MRRS values are not detectable. Moreover,
> > the current loongson_mrrs_quirk() cannot avoid devices increasing its
> > MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
> > will actually set a big value in its driver. So the only possible way
> > is configure MRRS of all devices in BIOS, and add a PCI bus flag (i.e.,
> > PCI_BUS_FLAGS_NO_INC_MRRS) to stop the increasing MRRS operations.
> >
> > However, according to PCIe Spec, it is legal for an OS to program any
> > value for MRRS, and it is also legal for an endpoint to generate a Read
> > Request with any size up to its MRRS. As the hardware engineers say, the
> > root cause here is LS7A doesn't break up large read requests. In detail,
> > LS7A PCIe port reports CA (Completer Abort) if it receives a Memory Read
> > request with a size that's "too big" (Yes, that is a problem in the LS7A
> > hardware design).
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/pci/pci.c    |  5 +++++
> >  drivers/pci/quirks.c | 41 +++++++++++------------------------------
> >  include/linux/pci.h  |  1 +
> >  3 files changed, 17 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 8d4ebe095d0c..0f1ff4a6fe44 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5812,6 +5812,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
> >
> >       v = (ffs(rq) - 8) << 12;
> >
> > +     if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_INC_MRRS) {
> > +             if (rq > pcie_get_readrq(dev))
> > +                     return -EINVAL;
>
> I'd prefer to make this simpler, so we just never touch MRRS at all,
> like this:
>
>   @@ -5785,6 +5785,9 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>           u16 v;
>           int ret;
>
>   +       if (<loongson-quirk>)
>   +               return -EINVAL;
>   +
>           if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
>                   return -EINVAL;
>
> What would that break?  It's just harder to analyze the behavior if it
> depends on what the driver is trying to do.  AFAIK, devices should
> *work* correctly with any value of MRRS.
This disables both increase and decrease MRRS, and so make
pcie_bus_config completely useless. I think allowing decrease MRRS is
useful in the PEER2PEER case.

>
> > +     }
> > +
> >       ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
> >                                                 PCI_EXP_DEVCTL_READRQ, v);
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index dee4798a49fc..4bbdf5a5425f 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -242,37 +242,18 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >                       DEV_LS7A_LPC, loongson_system_bus_quirk);
> >
> > -static void loongson_mrrs_quirk(struct pci_dev *dev)
> > -{
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
> > +static void loongson_mrrs_quirk(struct pci_dev *pdev)
> > +{
> > +     /*
> > +      * Some Loongson PCIe ports have h/w limitations of maximum read
> > +      * request size. They can't handle anything larger than this. So
> > +      * force this limit on any devices attached under these ports.
> > +      */
> > +     pdev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_INC_MRRS;
> >  }
> > -DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
> > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_0, loongson_mrrs_quirk);
> > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_1, loongson_mrrs_quirk);
> > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_2, loongson_mrrs_quirk);
>
> Thanks for making this quirk Loongson-specific.  Can you reverse the
> order of patches 2 and 3, so this fix happens before moving the quirk
> to drivers/pci/quirks.c?
OK, I will reverse them.

>
> >  /*
> >   * The Mellanox Tavor device gives false positive parity errors.  Disable
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 24306504226a..b336239b5282 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -240,6 +240,7 @@ enum pci_bus_flags {
> >       PCI_BUS_FLAGS_NO_MMRBC  = (__force pci_bus_flags_t) 2,
> >       PCI_BUS_FLAGS_NO_AERSID = (__force pci_bus_flags_t) 4,
> >       PCI_BUS_FLAGS_NO_EXTCFG = (__force pci_bus_flags_t) 8,
> > +     PCI_BUS_FLAGS_NO_INC_MRRS = (__force pci_bus_flags_t) 16,
>
> This is not a property of the *bus*.
>
> Apparently it's a property of the Root Port or maybe of the Root
> Complex itself.  What about RCiePs, which don't have a Root Port above
> them?  They still have an MRRS field in their Device Control
> registers.  Are there restrictions on how MRRS can be set for an
> RCiEP?
>
> If you need to restrict MRRS for RCiEPs as well as for devices below
> LS7A Root Ports, I think setting a bit in struct pci_host_bridge and
> using pci_find_host_bridge() would work.
OK, I will set a bit in pci_host_bridge.

Huacai
>
> If you don't need to restrict MRRS for RCiEPs (or if there are no
> RCiEPs at all) you could put a bit in the struct pci_dev and use
> pcie_find_root_port().  But this would consume a bit in *every*
> pci_dev on every system, so it's a little more wasteful in that sense.
>
> >  };
> >
> >  /* Values from Link Status register, PCIe r3.1, sec 7.8.8 */
> > --
> > 2.27.0
> >
