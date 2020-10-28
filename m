Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837E229DAE5
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 00:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390701AbgJ1Xif (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 19:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390699AbgJ1XiQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 19:38:16 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA6BC0613D1
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2020 16:38:15 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i2so1120649ljg.4
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2020 16:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iQ/6R88aK0D2mb8TdGnVnLE/2ZRNXK8gB3+E2IBDwgc=;
        b=QCJI140P3pGKI9lvaUhzCOU/iAhvWytr7HcKH1jkTIRk6xZIisw1pIcBYUl8dfN4yn
         2PJ6tGWR1giQRJ9D+3aHKy2xaUEbJr4dAYIwroMDCD/lkBs6dKk4RLArqogaY4J/DLMr
         16LPztmj5QWc2mI4R0iCvTl+uJBaaqT9098hdNkgL7ROJPRIrZxOQVnCoLpWCfBzRiMF
         U1E4O+0mGaYJIGoXwilOaazd9yP91WlNXvU8OSP302liwHZC02ph7hLwKy6XMOq/f/vg
         2jxSS0ellSbS/Bjj0RCaxvCApNcByB+w9aHaHwI0p4C2JT+qKUSTJFqTo3h833QI32Uv
         fF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQ/6R88aK0D2mb8TdGnVnLE/2ZRNXK8gB3+E2IBDwgc=;
        b=beCAYObFZYj4YckCMc16TmxqDDH1b8jISsZtwvcKeBR8gs1bzBescl3FOmKOJTuVFd
         MR/AvDBezoQk30iWZBBuTffQascn1lQl9+aKrK0HFmbQX4RL3JUkTFhH62PjoAGoTIeB
         akNmJywRfjo11tfMBY2FatXr+y3MIaCuunpzG+71gNWUo4dGckECy0bIB0mUHL/EIuu+
         nwB6pRk9aTjBJ//ON4DNx8NyA3LiRJRy3ukNsunizUOzvxt9XIOSFJVe90i8bXURpdGv
         QaE4DTAvKxEi7w9C0Pb5smgrMKMYha/rQ7kltBU4+gt0Yokc+mKBIa8gwyjWf9pr3f7V
         BPrA==
X-Gm-Message-State: AOAM532M9X7TtMEY/JDGWXoZ9sOIxdUrwmgtUXzHzAySCY2V6Ankibb4
        HYOYej5My8GyALmvjLYk96ZsZAxG22NocI7jzq0KHA==
X-Google-Smtp-Source: ABdhPJw2tfYbh52t5a4VkzECWP7h8Tj6epVccbveEWBW484yBkU76Ayc6xfjbyi2z4RN1I+3coh1pGQKn0rkS2be3Hc=
X-Received: by 2002:a05:651c:95:: with SMTP id 21mr569127ljq.307.1603928293334;
 Wed, 28 Oct 2020 16:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <d76b70c1-17f6-60d7-b027-5ecda491101c@bstnet.org>
 <20201028215246.GA351595@bjorn-Precision-5520> <CACK8Z6HLPyc_o9kvy09gjm+OQ7DLyvV2wB0boXCthEesra0t-g@mail.gmail.com>
In-Reply-To: <CACK8Z6HLPyc_o9kvy09gjm+OQ7DLyvV2wB0boXCthEesra0t-g@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 28 Oct 2020 16:37:37 -0700
Message-ID: <CACK8Z6G-nDAk6oNQ0pySUoh4fSmO++XuGVhQcykYgEQ9QCOM4Q@mail.gmail.com>
Subject: Re: Kernel 5.9 IOMMU groups regression/change
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Boris V." <borisvk@bstnet.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 28, 2020 at 3:07 PM Rajat Jain <rajatja@google.com> wrote:
>
> On Wed, Oct 28, 2020 at 2:52 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Rajat, LKML]
> >
>
> Thanks for copying me. (I don't look at mailing lists actively - so
> missed this). Taking a look at this now.
>
> Thanks,
>
> Rajat
>
>
> > On Tue, Oct 27, 2020 at 08:31:09PM +0100, Boris V. wrote:
> > > On 25/10/2020 20:45, Boris V. wrote:
> > > > With upgrade to kernel 5.9 my VMs stopped working, because some devices
> > > > can't be passed through.
> > > > This is caused by different IOMMU groups and devices being in the same
> > > > group.
> > > >
> > > > For ex. with kernel 5.8 this are IOMMU groups:
> > > > IOMMU Group 40:
> > > >         08:01.0 PCI bridge [0604]: ASMedia Technology Inc. Device
> > > > [1b21:118f]
> > > >         09:00.0 Ethernet controller [0200]: Intel Corporation I211
> > > > Gigabit Network Connection [8086:1539] (rev 03)
> > > > IOMMU Group 43:
> > > >         0c:00.0 SATA controller [0106]: ASMedia Technology Inc. ASM1062
> > > > Serial ATA Controller [1b21:0612] (rev 02)
> > > > IOMMU Group 44:
> > > >         0d:00.0 USB controller [0c03]: ASMedia Technology Inc. ASM1042A
> > > > USB 3.0 Host Controller [1b21:1142]
> > > >
> > > > Ethernet, SATA and USB controller in its own group.
> > > >
> > > > And with 5.9, everything is in one group:
> > > > IOMMU Group 29:
> > > >         00:1c.0 PCI bridge [0604]: Intel Corporation C610/X99 series
> > > > chipset PCI Express Root Port #1 [8086:8d10] (rev d5)
> > > >         00:1c.3 PCI bridge [0604]: Intel Corporation C610/X99 series
> > > > chipset PCI Express Root Port #4 [8086:8d16] (rev d5)
> > > >         00:1c.4 PCI bridge [0604]: Intel Corporation C610/X99 series
> > > > chipset PCI Express Root Port #5 [8086:8d18] (rev d5)
> > > >         00:1c.6 PCI bridge [0604]: Intel Corporation C610/X99 series
> > > > chipset PCI Express Root Port #7 [8086:8d1c] (rev d5)
> > > >         07:00.0 PCI bridge [0604]: ASMedia Technology Inc. Device
> > > > [1b21:118f]
> > > >         08:01.0 PCI bridge [0604]: ASMedia Technology Inc. Device
> > > > [1b21:118f]
> > > >         08:03.0 PCI bridge [0604]: ASMedia Technology Inc. Device
> > > > [1b21:118f]
> > > >         08:04.0 PCI bridge [0604]: ASMedia Technology Inc. Device
> > > > [1b21:118f]
> > > >         09:00.0 Ethernet controller [0200]: Intel Corporation I211
> > > > Gigabit Network Connection [8086:1539] (rev 03)
> > > >         0c:00.0 SATA controller [0106]: ASMedia Technology Inc. ASM1062
> > > > Serial ATA Controller [1b21:0612] (rev 02)
> > > >         0d:00.0 USB controller [0c03]: ASMedia Technology Inc. ASM1042A
> > > > USB 3.0 Host Controller [1b21:1142]
> > > >
> > > >
> > > > This seems to be caused by commit
> > > > 52fbf5bdeeef415b28b8e6cdade1e48927927f60.
> > > > commit 52fbf5bdeeef415b28b8e6cdade1e48927927f60
> > > > Author: Rajat Jain <rajatja@google.com>
> > > > Date:   Tue Jul 7 15:46:02 2020 -0700
> > > >
> > > >     PCI: Cache ACS capability offset in device
> > > >
> > > >     Currently the ACS capability is being looked up at a number of
> > > > places. Read
> > > >     and store it once at enumeration so that it can be used by all
> > > > later.  No
> > > >     functional change intended.
> > > >
> > > >     Link:
> > > > https://lore.kernel.org/r/20200707224604.3737893-2-rajatja@google.com
> > > >     Signed-off-by: Rajat Jain <rajatja@google.com>
> > > >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > >
> > > >  drivers/pci/p2pdma.c |  2 +-
> > > >  drivers/pci/pci.c    | 20 ++++++++++++++++----
> > > >  drivers/pci/pci.h    |  2 +-
> > > >  drivers/pci/probe.c  |  2 +-
> > > >  drivers/pci/quirks.c |  8 ++++----
> > > >  include/linux/pci.h  |  1 +
> > > >  6 files changed, 24 insertions(+), 11 deletions(-)
> > > >
> > > >
> > > > If I revert this commit, I get back old groups.
> > > >
> > > > In commit log there is message 'No functional change intended'. But
> > > > there is functional change.
> > > >
> > > > This is Intel Core i7-5930K CPU and X99 chipset. But I see the same
> > > > thing on other Intel systems (didn't test on AMD).
> > >
> > > Some more info.
> > > Problem seems to be that pci_dev_specific_enable_acs() is not called
> > > anymore.
> > > Before, pci_enable_acs() was called from pci_init_capabilities() and in
> > > pci_enable_acs(), pci_dev_specific_enable_acs() was called.
> > > I don't know anything about PCI and this stuff, but I'm guessing that this
> > > function enable ACS for some Intel devices.
> > > But after this commit, pci_acs_init() is called from pci_init_capabilities()
> > > and if pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS) returns 0,
> > > pci_enable_acs() and pci_dev_specific_enable_acs() is not called anymore.
> > > If I apply for ex. this patch bellow, groups are right again and everything
> > > works as before.
> >
> > Thanks very much for the report and the debugging.  Maybe we can get
> > this sorted and fixed for v5.10-rc2 or -rc3.

Thank Boris for reporting and debugging! The problem was because I
overlooked the fact that some rootports (the ones quirked with
*_intel_pch_acs_* functions in this case) may not expose a standard
ACS capability structure, but rather depend on quirks to enable ACS
for them using non standard registers. Your platform is in this
category. Can you please send lspci -vvvv and lspci -xxxx for one of
your rootports to confirm?

> >
> > > diff -ur linux-5.9.1.orig/drivers/pci/pci.c linux-5.9.1/drivers/pci/pci.c
> > > --- linux-5.9.1.orig/drivers/pci/pci.c  2020-10-17 08:31:22.000000000 +0200
> > > +++ linux-5.9.1/drivers/pci/pci.c       2020-10-27 19:01:32.650010803 +0100
> > > @@ -3502,9 +3502,7 @@
> > >  void pci_acs_init(struct pci_dev *dev)
> > >  {
> > >         dev->acs_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> > > -
> > > -       if (dev->acs_cap)
> > > -               pci_enable_acs(dev);
> > > +       pci_enable_acs(dev);
> > >  }
> > >
> > >  /**
> > >

Ack, yes, this is what needs to be done, and I just sent a patch at
https://lkml.org/lkml/2020/10/28/693.

Thanks,

Rajat

> > >
