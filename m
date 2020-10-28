Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FF929D5C4
	for <lists+linux-pci@lfdr.de>; Wed, 28 Oct 2020 23:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgJ1WIi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 18:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730356AbgJ1WI3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 18:08:29 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4C6C0613D1
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2020 15:08:29 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id k25so898240lji.9
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2020 15:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/UQj19JKtDpSfgvXQNknUjoiBrB2/VS8uj570M8Ll4=;
        b=ntz4C1F9/qbnPT91Mb1tcX8fbmyjK1YLSwwGi/QAdHbUk0y1Li1hGcVrxpVr0W6K+o
         k+XxpcdL3FoX7V6CqQhQ3DrzGZQSAZr1te8tRWZqQwH9TbuJ/8dmUBuSvsR7pp/CiHQq
         GWp6YWtZ9V3xGi/Dn850cWfMQADMBEzSUKbujnYrBXbZgSKCV44Dsu9rt7uFsCjixMI9
         sMFkCwOG7BYwvx31n6stFPw0/omZUNqBinHsFTUYC4H0+PuxUzyei4IDpMDeT05Wh03D
         3QdABPxpa8n200pNv8+Lo7ofJ9annbx1ele+5wamVvClxkzZTNxPJmRgULUwMdUGrI2N
         Ymug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/UQj19JKtDpSfgvXQNknUjoiBrB2/VS8uj570M8Ll4=;
        b=afGQ0ZROcsGbgROevn/OoPv1Ajlfgtd8O3GIGaeYVsyFE3lQ7xspMi6wEodOMlU9j+
         xJfo4NcWDvs3QTK44CSftzGKmstrtDCpeaIlZSZjrXwYnem0uZBTER1KWIb/DU7anqrK
         05InS5wXo52AGGg1wWOCEYKOJaPdgplPuPeGU8Lx6EGUwFZSUejCl4ce+tRf96k+zM4B
         MPAosSUSC3Qp4+CiGh6Lsgzqk9wCG7rwbkN1sqw4jWlstfN+U0UMwjOF7qsfLPfYaJMd
         +tGdksmLdKx/uzGX7OrAwPmPHe29yMvEpiSQ52H0VFFTBdFNXzQFBNqfuHMbB9ZSxMdt
         EXUQ==
X-Gm-Message-State: AOAM533VKXn7w8i/imxnAf2pSLFQu8z2BBdOjUgexnRsyQDRVkqKRaMe
        uo0tt1/8s2e0Bn8UHSFy9zha5pQV52v2w7OT/H9JNw==
X-Google-Smtp-Source: ABdhPJxBt01sDJcp4h/oFPiPreDew3wQhJVQA4p5TXmmXlblXmJ34ts9wMngCW1tMya7Qfpx4DgHf0ODFD6UUPG0GuY=
X-Received: by 2002:a2e:8845:: with SMTP id z5mr553669ljj.216.1603922907250;
 Wed, 28 Oct 2020 15:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <d76b70c1-17f6-60d7-b027-5ecda491101c@bstnet.org> <20201028215246.GA351595@bjorn-Precision-5520>
In-Reply-To: <20201028215246.GA351595@bjorn-Precision-5520>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 28 Oct 2020 15:07:51 -0700
Message-ID: <CACK8Z6HLPyc_o9kvy09gjm+OQ7DLyvV2wB0boXCthEesra0t-g@mail.gmail.com>
Subject: Re: Kernel 5.9 IOMMU groups regression/change
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Boris V." <borisvk@bstnet.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 28, 2020 at 2:52 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rajat, LKML]
>

Thanks for copying me. (I don't look at mailing lists actively - so
missed this). Taking a look at this now.

Thanks,

Rajat


> On Tue, Oct 27, 2020 at 08:31:09PM +0100, Boris V. wrote:
> > On 25/10/2020 20:45, Boris V. wrote:
> > > With upgrade to kernel 5.9 my VMs stopped working, because some devices
> > > can't be passed through.
> > > This is caused by different IOMMU groups and devices being in the same
> > > group.
> > >
> > > For ex. with kernel 5.8 this are IOMMU groups:
> > > IOMMU Group 40:
> > >         08:01.0 PCI bridge [0604]: ASMedia Technology Inc. Device
> > > [1b21:118f]
> > >         09:00.0 Ethernet controller [0200]: Intel Corporation I211
> > > Gigabit Network Connection [8086:1539] (rev 03)
> > > IOMMU Group 43:
> > >         0c:00.0 SATA controller [0106]: ASMedia Technology Inc. ASM1062
> > > Serial ATA Controller [1b21:0612] (rev 02)
> > > IOMMU Group 44:
> > >         0d:00.0 USB controller [0c03]: ASMedia Technology Inc. ASM1042A
> > > USB 3.0 Host Controller [1b21:1142]
> > >
> > > Ethernet, SATA and USB controller in its own group.
> > >
> > > And with 5.9, everything is in one group:
> > > IOMMU Group 29:
> > >         00:1c.0 PCI bridge [0604]: Intel Corporation C610/X99 series
> > > chipset PCI Express Root Port #1 [8086:8d10] (rev d5)
> > >         00:1c.3 PCI bridge [0604]: Intel Corporation C610/X99 series
> > > chipset PCI Express Root Port #4 [8086:8d16] (rev d5)
> > >         00:1c.4 PCI bridge [0604]: Intel Corporation C610/X99 series
> > > chipset PCI Express Root Port #5 [8086:8d18] (rev d5)
> > >         00:1c.6 PCI bridge [0604]: Intel Corporation C610/X99 series
> > > chipset PCI Express Root Port #7 [8086:8d1c] (rev d5)
> > >         07:00.0 PCI bridge [0604]: ASMedia Technology Inc. Device
> > > [1b21:118f]
> > >         08:01.0 PCI bridge [0604]: ASMedia Technology Inc. Device
> > > [1b21:118f]
> > >         08:03.0 PCI bridge [0604]: ASMedia Technology Inc. Device
> > > [1b21:118f]
> > >         08:04.0 PCI bridge [0604]: ASMedia Technology Inc. Device
> > > [1b21:118f]
> > >         09:00.0 Ethernet controller [0200]: Intel Corporation I211
> > > Gigabit Network Connection [8086:1539] (rev 03)
> > >         0c:00.0 SATA controller [0106]: ASMedia Technology Inc. ASM1062
> > > Serial ATA Controller [1b21:0612] (rev 02)
> > >         0d:00.0 USB controller [0c03]: ASMedia Technology Inc. ASM1042A
> > > USB 3.0 Host Controller [1b21:1142]
> > >
> > >
> > > This seems to be caused by commit
> > > 52fbf5bdeeef415b28b8e6cdade1e48927927f60.
> > > commit 52fbf5bdeeef415b28b8e6cdade1e48927927f60
> > > Author: Rajat Jain <rajatja@google.com>
> > > Date:   Tue Jul 7 15:46:02 2020 -0700
> > >
> > >     PCI: Cache ACS capability offset in device
> > >
> > >     Currently the ACS capability is being looked up at a number of
> > > places. Read
> > >     and store it once at enumeration so that it can be used by all
> > > later.  No
> > >     functional change intended.
> > >
> > >     Link:
> > > https://lore.kernel.org/r/20200707224604.3737893-2-rajatja@google.com
> > >     Signed-off-by: Rajat Jain <rajatja@google.com>
> > >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > >  drivers/pci/p2pdma.c |  2 +-
> > >  drivers/pci/pci.c    | 20 ++++++++++++++++----
> > >  drivers/pci/pci.h    |  2 +-
> > >  drivers/pci/probe.c  |  2 +-
> > >  drivers/pci/quirks.c |  8 ++++----
> > >  include/linux/pci.h  |  1 +
> > >  6 files changed, 24 insertions(+), 11 deletions(-)
> > >
> > >
> > > If I revert this commit, I get back old groups.
> > >
> > > In commit log there is message 'No functional change intended'. But
> > > there is functional change.
> > >
> > > This is Intel Core i7-5930K CPU and X99 chipset. But I see the same
> > > thing on other Intel systems (didn't test on AMD).
> >
> > Some more info.
> > Problem seems to be that pci_dev_specific_enable_acs() is not called
> > anymore.
> > Before, pci_enable_acs() was called from pci_init_capabilities() and in
> > pci_enable_acs(), pci_dev_specific_enable_acs() was called.
> > I don't know anything about PCI and this stuff, but I'm guessing that this
> > function enable ACS for some Intel devices.
> > But after this commit, pci_acs_init() is called from pci_init_capabilities()
> > and if pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS) returns 0,
> > pci_enable_acs() and pci_dev_specific_enable_acs() is not called anymore.
> > If I apply for ex. this patch bellow, groups are right again and everything
> > works as before.
>
> Thanks very much for the report and the debugging.  Maybe we can get
> this sorted and fixed for v5.10-rc2 or -rc3.
>
> > diff -ur linux-5.9.1.orig/drivers/pci/pci.c linux-5.9.1/drivers/pci/pci.c
> > --- linux-5.9.1.orig/drivers/pci/pci.c  2020-10-17 08:31:22.000000000 +0200
> > +++ linux-5.9.1/drivers/pci/pci.c       2020-10-27 19:01:32.650010803 +0100
> > @@ -3502,9 +3502,7 @@
> >  void pci_acs_init(struct pci_dev *dev)
> >  {
> >         dev->acs_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> > -
> > -       if (dev->acs_cap)
> > -               pci_enable_acs(dev);
> > +       pci_enable_acs(dev);
> >  }
> >
> >  /**
> >
> >
