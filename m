Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD58139B62A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 11:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFDJpf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 05:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDJpe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jun 2021 05:45:34 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E2AC06174A
        for <linux-pci@vger.kernel.org>; Fri,  4 Jun 2021 02:43:48 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id a8so9345622ioa.12
        for <linux-pci@vger.kernel.org>; Fri, 04 Jun 2021 02:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pEiM3enOUbsF09SBhtflsxZ+8qy9I6puWaARUFqs4+I=;
        b=OBZl9ANqqTYC9MD5OULOoJZbq+Xwafo6hWC2OMFoKgQRMRXx4GP+xnBHqbNTcho00m
         ya0ObfBhYnSe4h/UO+UfgR7BMv/jNER31lPRm73Y1cs7FSdItm3iMAzY2ueqzUXg9h2Z
         /RNcqI99m4E+OhlJHlZ3QX6mYea8hlXy+uPMddegzbdYnVTlRMdbevEGYr12X21RcRaa
         UwMQeYM3XKOn4itLHmoTt4VMA2TODvunu2ydeChdyTwQMW8FWSp46TXIn5owbfL8pXDN
         vQzeRV1uOkZ0qbOOLWANlL4cInknubo8IK7Oax2AdnuUmvhcOVpKRZkrjhu+QcXy3LZW
         O5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEiM3enOUbsF09SBhtflsxZ+8qy9I6puWaARUFqs4+I=;
        b=FFnZPuPq55ar+r/0OrzBfIhszaiIR5hwc5xr5ZF2RNz1k0kDYP+hSFixdeh4HE7/tZ
         g2St+X13xzzQLH4otSegiNZENv1ldfQ2rekxVK4KYMCmhoqA38Tl2m41idoSXe2cgcPH
         w/Ga5P2UdYR2TL7/ZjBw/kQawFThp49gopZtxxFqtbS/kg19xwh0rAIorO0+CAP3aXor
         r+eqpfuhTrmxrh+5FuneUCf3ioVi3epNYAqcTenK/0o6sV1rj7mLC4NO0M5YttqF35zO
         OM8V6frAylllkcPmqMVjjiz6uA4lNe89an6yKjIUnmWj0N0RWVh02DXjncdswlRdX+Hz
         iL3w==
X-Gm-Message-State: AOAM5311JLK8olMgRSKa5r6zBkxySupneNXFWxWWqrnV4LA1DICK5G8K
        bV38GnWVJbdHmvtUNQbhgrDMF248dV1ssoVEsec=
X-Google-Smtp-Source: ABdhPJxF196sktGrP0pNQQGu5zrgdCCC6xtlTggeEYsPsDl5vwr5/uT79iwHrmDjwvB0UAWl9mWGFMydIahr5d9ilvI=
X-Received: by 2002:a05:6602:2bfa:: with SMTP id d26mr3059877ioy.13.1622799828157;
 Fri, 04 Jun 2021 02:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210528071503.1444680-4-chenhuacai@loongson.cn> <20210528203224.GA1516603@bjorn-Precision-5520>
In-Reply-To: <20210528203224.GA1516603@bjorn-Precision-5520>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 4 Jun 2021 17:43:36 +0800
Message-ID: <CAAhV-H4FhW=D0am2QMx+HAMBXiZSap2OTgaBd2QhB-ZVCjzNdg@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] PCI: Improve the MRRS quirk for LS7A
To:     Bjorn Helgaas <helgaas@kernel.org>, huangshuai@loongson.cn
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

On Sat, May 29, 2021 at 4:32 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, May 28, 2021 at 03:15:02PM +0800, Huacai Chen wrote:
> > In new revision of LS7A, some PCIe ports support larger value than 256,
> > but their maximum supported MRRS values are not detectable. Moreover,
> > the current loongson_mrrs_quirk() cannot avoid devices increasing its
> > MRRS after pci_enable_device(). So the only possible way is configure
> > MRRS of all devices in BIOS, and add a PCI device flag (PCI_DEV_FLAGS_
> > NO_INCREASE_MRRS) to stop the increasing MRRS operations.
>
> It's still not clear what the problem is.
>
> As far as I can tell from the PCIe spec, it is legal for an OS to
> program any value for MRRS, and it is legal for an endpoint to
> generate a Read Request with any size up to its MRRS.  If you
> disagree, please cite the relevant section in the spec.
>
> There is no requirement for the OS to limit the MRRS based on a
> restriction elsewhere in the system.  There is no mechanism for the OS
> to even discover such a restriction.
>
> Of course, there is also no requirement that the PCIe Completions
> carrying the read data be the same size as the MRRS.  If the non-PCIe
> part of the system has a restriction on read burst size, that part of
> the system can certainly break up the read and respond with several
> PCIe Completions.
>
> If LS7A can't break up read requests, that sounds like a problem in
> the LS7A design.  We should have a description of this erratum.  And
> we should have some statement about this being fixed in future
> designs, because we don't want to have to update the fixup with the
> PCI vendor/device IDs every time new versions come out.
Thanks for your information, but I think only Mr. Shuai Huang can
explain the root cause, too.

>
> I also don't want to rely on some value left in MRRS by BIOS.  If
> certain bridges have specific limits on what MRRS can be, the fixup
> should have those limits in it.
As I know, each port of LS7A has a different maximum MRRS value (Yes,
as you said, this is unreasonable in PCIe spec. but it is a fact in
LS7A), and also different between hardware revisions. So, the kernel
cannot configure it, and relying on BIOS is the only way.

>
> loongson_mrrs_quirk() doesn't look efficient.  We should not have to
> run the fixup for *every* PCI device in the system.  Also, we should
> not mark every *device* below an LS7A, because it's not the devices
> that are defective.
>
> If it's the root port or the host bridge that's defective, we should
> mark *that*, e.g., something along the lines of how quirk_no_ext_tags()
> works.
OK, I'll improve my code.

Huacai
>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/pci/pci.c    | 5 +++++
> >  drivers/pci/quirks.c | 6 ++++++
> >  include/linux/pci.h  | 2 ++
> >  3 files changed, 13 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b717680377a9..6f0d2f5b6f30 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5802,6 +5802,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
> >
> >       v = (ffs(rq) - 8) << 12;
> >
> > +     if (dev->dev_flags & PCI_DEV_FLAGS_NO_INCREASE_MRRS) {
> > +             if (rq > pcie_get_readrq(dev))
> > +                     return -EINVAL;
> > +     }
> > +
> >       ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
> >                                                 PCI_EXP_DEVCTL_READRQ, v);
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 66e4bea69431..10b3b2057940 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -264,6 +264,12 @@ static void loongson_mrrs_quirk(struct pci_dev *dev)
> >                * any devices attached under these ports.
> >                */
> >               if (pci_match_id(bridge_devids, bridge)) {
> > +                     dev->dev_flags |= PCI_DEV_FLAGS_NO_INCREASE_MRRS;
> > +
> > +                     if (pcie_bus_config == PCIE_BUS_DEFAULT ||
> > +                         pcie_bus_config == PCIE_BUS_TUNE_OFF)
> > +                             break;
> > +
> >                       if (pcie_get_readrq(dev) > 256) {
> >                               pci_info(dev, "limiting MRRS to 256\n");
> >                               pcie_set_readrq(dev, 256);
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index c20211e59a57..7fb2072a83b8 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -227,6 +227,8 @@ enum pci_dev_flags {
> >       PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
> >       /* Don't use Relaxed Ordering for TLPs directed at this device */
> >       PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
> > +     /* Don't increase BIOS's MRRS configuration */
> > +     PCI_DEV_FLAGS_NO_INCREASE_MRRS = (__force pci_dev_flags_t) (1 << 12),
> >  };
> >
> >  enum pci_irq_reroute_variant {
> > --
> > 2.27.0
> >
