Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DEE3A4C9E
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jun 2021 06:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhFLEUC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Jun 2021 00:20:02 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:45688 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhFLEUB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Jun 2021 00:20:01 -0400
Received: by mail-io1-f49.google.com with SMTP id k5so23583984iow.12
        for <linux-pci@vger.kernel.org>; Fri, 11 Jun 2021 21:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMfo9SmEDWrsy733ImgWnawPC4LCVIr7AQPFKgdlarY=;
        b=eICZ1vtB1g2I5oiIG42S/0sKHItJhiaTGBlodWA/ip18xPj9rocyTqcfs9rP7jIIDx
         byNXPNZKPo4zfUjFYC6CSWc09bcIwiTuDORG1OPt+rzqKGN47X75QNARz8BX8Wkv6ig2
         SBGkSp/iEGRf2UUtaNtAQNplGw3W0f/Fbus95lxDy4Ezfs7QLfptJJd7dE+IMfjSqVLG
         sOo7A8XJ9Rk0aOIXZ8PFgv0/PCLJl69S8u+GYghgWyNXq2NwsO/bPHss72SK3v6wgy4c
         Q26ldOdmxiVAzVcMhcKt9Rmjx2Ln6LGQaHUzi/zdmn1klJ2MbpjZuOgmiCFaoUfoHZt3
         t+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMfo9SmEDWrsy733ImgWnawPC4LCVIr7AQPFKgdlarY=;
        b=TEXP6XYl6nPjB6t6HrLfOqfCVmimdP2p2Apnxk4Zouvirqtr6ZSm+tKGahXsOWco8Y
         i8iD9QuhVbqDPgHBBLM4AWsh9MCIb72sQLolAhRaxUi5x72bgk9GPwIGfzkl/jekqtF6
         WrdBBOstXZG3DvOSM0FwSudSJFCJ5YLt95SZUNEotHj4+uNIX/UujeTM8EkUSaPw0IRu
         onQQoPJkxD8p5RafT1tTs7/o436n5D+k4kTjRpTymEqr7GoTEsVZMVtzl5CzVDibdSAS
         ME2QQH020h51p71BhPHfKVDOvd84QKuglRMUFUE3s6gCLbhfCPT6jPiaRKHCs8BkZTiB
         82Fg==
X-Gm-Message-State: AOAM531rQxXggzkqlkMTZ5chIR1mseY5sBC9jeYbHE8lGobcZC0Zu9YW
        pxyphVPdg4VQnRM+ySK3VgsNjnH06GxhPzlc6y4=
X-Google-Smtp-Source: ABdhPJzDzOD4nZXKITX+RFw+DNi/gIT+pNzkljq5PG6Tyi74eQYT6NalRvCvO5ZBwAfD1Nn2mrYZsggHAnnjFm+0mMY=
X-Received: by 2002:a05:6638:1202:: with SMTP id n2mr6862932jas.57.1623471411209;
 Fri, 11 Jun 2021 21:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H4FhW=D0am2QMx+HAMBXiZSap2OTgaBd2QhB-ZVCjzNdg@mail.gmail.com>
 <20210605213448.GA2327732@bjorn-Precision-5520>
In-Reply-To: <20210605213448.GA2327732@bjorn-Precision-5520>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 12 Jun 2021 12:16:39 +0800
Message-ID: <CAAhV-H5kM9Q9F7O6xJ4gDYgyK+6eSmZJM5x5ER0UcxuMTwXaoQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] PCI: Improve the MRRS quirk for LS7A
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     huangshuai@loongson.cn, Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Sun, Jun 6, 2021 at 5:34 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Jun 04, 2021 at 05:43:36PM +0800, Huacai Chen wrote:
> > Hi, Bjorn,
> >
> > On Sat, May 29, 2021 at 4:32 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Fri, May 28, 2021 at 03:15:02PM +0800, Huacai Chen wrote:
> > > > In new revision of LS7A, some PCIe ports support larger value than 256,
> > > > but their maximum supported MRRS values are not detectable. Moreover,
> > > > the current loongson_mrrs_quirk() cannot avoid devices increasing its
> > > > MRRS after pci_enable_device(). So the only possible way is configure
> > > > MRRS of all devices in BIOS, and add a PCI device flag (PCI_DEV_FLAGS_
> > > > NO_INCREASE_MRRS) to stop the increasing MRRS operations.
> > >
> > > It's still not clear what the problem is.
> > >
> > > As far as I can tell from the PCIe spec, it is legal for an OS to
> > > program any value for MRRS, and it is legal for an endpoint to
> > > generate a Read Request with any size up to its MRRS.  If you
> > > disagree, please cite the relevant section in the spec.
> > >
> > > There is no requirement for the OS to limit the MRRS based on a
> > > restriction elsewhere in the system.  There is no mechanism for the OS
> > > to even discover such a restriction.
> > >
> > > Of course, there is also no requirement that the PCIe Completions
> > > carrying the read data be the same size as the MRRS.  If the non-PCIe
> > > part of the system has a restriction on read burst size, that part of
> > > the system can certainly break up the read and respond with several
> > > PCIe Completions.
> > >
> > > If LS7A can't break up read requests, that sounds like a problem in
> > > the LS7A design.  We should have a description of this erratum.  And
> > > we should have some statement about this being fixed in future
> > > designs, because we don't want to have to update the fixup with the
> > > PCI vendor/device IDs every time new versions come out.
> >
> > Thanks for your information, but I think only Mr. Shuai Huang can
> > explain the root cause, too.
> >
> > > I also don't want to rely on some value left in MRRS by BIOS.  If
> > > certain bridges have specific limits on what MRRS can be, the fixup
> > > should have those limits in it.
> >
> > As I know, each port of LS7A has a different maximum MRRS value (Yes,
> > as you said, this is unreasonable in PCIe spec. but it is a fact in
> > LS7A), and also different between hardware revisions. So, the kernel
> > cannot configure it, and relying on BIOS is the only way.
>
> Maybe we should just set MRRS to the minimum (128 bytes) for
> everything on this platform.
>
> The generic MPS/MRRS config is messy enough already, and I'm hesitant
> to add much complication for what seems to be a fairly broken PCIe
> controller.
I have had an offline discussion with Mr. Shuai Huang, and he told me
that the root cause is LS7A doesn't break up large read requests (Yes,
that is a problem in the LS7A design). But I think set MRRS to 128
bytes in the quirk is not enough, because as I said before, some
devices (e.g. Realtek 8169) set a big value in its driver. We cannot
block such operations if we don't touch the PCIe core.

Huacai
>
> > > loongson_mrrs_quirk() doesn't look efficient.  We should not have to
> > > run the fixup for *every* PCI device in the system.  Also, we should
> > > not mark every *device* below an LS7A, because it's not the devices
> > > that are defective.
> > >
> > > If it's the root port or the host bridge that's defective, we should
> > > mark *that*, e.g., something along the lines of how quirk_no_ext_tags()
> > > works.
> > OK, I'll improve my code.
> >
> > Huacai
> > >
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > >  drivers/pci/pci.c    | 5 +++++
> > > >  drivers/pci/quirks.c | 6 ++++++
> > > >  include/linux/pci.h  | 2 ++
> > > >  3 files changed, 13 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index b717680377a9..6f0d2f5b6f30 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -5802,6 +5802,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
> > > >
> > > >       v = (ffs(rq) - 8) << 12;
> > > >
> > > > +     if (dev->dev_flags & PCI_DEV_FLAGS_NO_INCREASE_MRRS) {
> > > > +             if (rq > pcie_get_readrq(dev))
> > > > +                     return -EINVAL;
> > > > +     }
> > > > +
> > > >       ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
> > > >                                                 PCI_EXP_DEVCTL_READRQ, v);
> > > >
> > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > index 66e4bea69431..10b3b2057940 100644
> > > > --- a/drivers/pci/quirks.c
> > > > +++ b/drivers/pci/quirks.c
> > > > @@ -264,6 +264,12 @@ static void loongson_mrrs_quirk(struct pci_dev *dev)
> > > >                * any devices attached under these ports.
> > > >                */
> > > >               if (pci_match_id(bridge_devids, bridge)) {
> > > > +                     dev->dev_flags |= PCI_DEV_FLAGS_NO_INCREASE_MRRS;
> > > > +
> > > > +                     if (pcie_bus_config == PCIE_BUS_DEFAULT ||
> > > > +                         pcie_bus_config == PCIE_BUS_TUNE_OFF)
> > > > +                             break;
> > > > +
> > > >                       if (pcie_get_readrq(dev) > 256) {
> > > >                               pci_info(dev, "limiting MRRS to 256\n");
> > > >                               pcie_set_readrq(dev, 256);
> > > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > > index c20211e59a57..7fb2072a83b8 100644
> > > > --- a/include/linux/pci.h
> > > > +++ b/include/linux/pci.h
> > > > @@ -227,6 +227,8 @@ enum pci_dev_flags {
> > > >       PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
> > > >       /* Don't use Relaxed Ordering for TLPs directed at this device */
> > > >       PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
> > > > +     /* Don't increase BIOS's MRRS configuration */
> > > > +     PCI_DEV_FLAGS_NO_INCREASE_MRRS = (__force pci_dev_flags_t) (1 << 12),
> > > >  };
> > > >
> > > >  enum pci_irq_reroute_variant {
> > > > --
> > > > 2.27.0
> > > >
