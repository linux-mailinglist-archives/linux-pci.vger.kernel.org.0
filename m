Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD94F3B78CD
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 21:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhF2TpY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Jun 2021 15:45:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232573AbhF2TpW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jun 2021 15:45:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CB71613E3;
        Tue, 29 Jun 2021 19:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624995774;
        bh=iuRiPxJWbOWvWA3ZtgCp3sBWPHpm/XMAzYn47v0LG3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sNo66bWyrTn//DTNMFnCZ0pVbBljYVD51AvLUz0IXLBiBZqP2W823Uau/5YgOlxws
         TWiy6jpJ+Gz+FHIMwp9I846EPhlwZbtjnlz9isB+Qpm3Msurvxm4C+RZe8KxRRSjsa
         69sNXiU0AR4hrtt+K1XOn2OPmryJMCrgB8ZpmJnQGqJ+UwmdBAHvck8U3SP2EAT+SN
         7AonfPy4l2Wap+xwV28mL2CMF0uXlMdS5UC4V7HQuwdRRFxFMXrSObjLuiGtu5BflR
         4wWtay4YRJkAg+Oo5NzuFqR/uWLAlkGIJ88V82Ti4JJmGZbh1Eg5cL+ntCht66vVMs
         ignFFjq/dO2YA==
Date:   Tue, 29 Jun 2021 14:42:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V4 3/4] PCI: Improve the MRRS quirk for LS7A
Message-ID: <20210629194252.GA4079683@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H72fyOHGyOMk7OE5HmZUec5J1vE2K3D2bxrerikk9QBUw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 29, 2021 at 11:20:45AM +0800, Huacai Chen wrote:
> On Tue, Jun 29, 2021 at 6:35 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Jun 28, 2021 at 06:10:26PM +0800, Huacai Chen wrote:
> > > In new revision of LS7A, some PCIe ports support larger value than 256,
> > > but their maximum supported MRRS values are not detectable. Moreover,
> > > the current loongson_mrrs_quirk() cannot avoid devices increasing its
> > > MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
> > > will actually set a big value in its driver. So the only possible way
> > > is configure MRRS of all devices in BIOS, and add a PCI bus flag (i.e.,
> > > PCI_BUS_FLAGS_NO_INC_MRRS) to stop the increasing MRRS operations.
> > >
> > > However, according to PCIe Spec, it is legal for an OS to program any
> > > value for MRRS, and it is also legal for an endpoint to generate a Read
> > > Request with any size up to its MRRS. As the hardware engineers say, the
> > > root cause here is LS7A doesn't break up large read requests. In detail,
> > > LS7A PCIe port reports CA (Completer Abort) if it receives a Memory Read
> > > request with a size that's "too big" (Yes, that is a problem in the LS7A
> > > hardware design).
> > >
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > >  drivers/pci/pci.c    |  5 +++++
> > >  drivers/pci/quirks.c | 41 +++++++++++------------------------------
> > >  include/linux/pci.h  |  1 +
> > >  3 files changed, 17 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 8d4ebe095d0c..0f1ff4a6fe44 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -5812,6 +5812,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
> > >
> > >       v = (ffs(rq) - 8) << 12;
> > >
> > > +     if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_INC_MRRS) {
> > > +             if (rq > pcie_get_readrq(dev))
> > > +                     return -EINVAL;
> >
> > I'd prefer to make this simpler, so we just never touch MRRS at all,
> > like this:
> >
> >   @@ -5785,6 +5785,9 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
> >           u16 v;
> >           int ret;
> >
> >   +       if (<loongson-quirk>)
> >   +               return -EINVAL;
> >   +
> >           if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
> >                   return -EINVAL;
> >
> > What would that break?  It's just harder to analyze the behavior if it
> > depends on what the driver is trying to do.  AFAIK, devices should
> > *work* correctly with any value of MRRS.
>
> This disables both increase and decrease MRRS, and so make
> pcie_bus_config completely useless. I think allowing decrease MRRS is
> useful in the PEER2PEER case.

True.  The MPS/MRRS algorithm, including pcie_bus_config, is very
complicated and poorly understood, so I'm a little hesitant to
complicate it even more with one-off quirks.  I'd really prefer to
push LS7A off into a corner and have the generic MPS/MRRS algorithm
ignore it completely.

But I guess just keeping pcie_set_readrq() from *increasing* MRRS
doesn't add too much complication and should always be safe.

Bjorn
