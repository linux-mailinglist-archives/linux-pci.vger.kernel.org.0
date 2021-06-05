Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064AB39CB3E
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jun 2021 23:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFEVgi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Jun 2021 17:36:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230010AbhFEVgi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Jun 2021 17:36:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E20B61355;
        Sat,  5 Jun 2021 21:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622928889;
        bh=SgbaIggFv9+4naB82BndY0teY9918UrGh8VLZ2Kwj5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=f40o9M/MQ15/sbspST4rUF3lPjxB+ajoWnsLy3Q3iHgBtR7Vz5CjRnhEfvSdd9cfH
         5GncrrzWKBAzlId5De9xgEg69muoP82uF/+L0iJakV/zUu2/hprGubMVYgkN8Mcd+g
         Py2RM1g3jkIwthfDcaWfj2ZFrpEwIFAtBRJVVEoXDKGF8nPGg4a2kTdBlFxZz+L8mA
         gNsY6Cqx7Yd20ZrUNry7W4z7RZb/Jw245R18LmXXmiIXXDyUsvVqyDlmEfhGO3lKz5
         8ntqsxLvxxfUX6ujMcjuIwCyBzdeeRSqLwVs9Xj4s6me7nIp1PL/KyFpyQAPCCS0Ha
         0EvCdFqPeA/xQ==
Date:   Sat, 5 Jun 2021 16:34:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     huangshuai@loongson.cn, Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V2 3/4] PCI: Improve the MRRS quirk for LS7A
Message-ID: <20210605213448.GA2327732@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H4FhW=D0am2QMx+HAMBXiZSap2OTgaBd2QhB-ZVCjzNdg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 04, 2021 at 05:43:36PM +0800, Huacai Chen wrote:
> Hi, Bjorn,
> 
> On Sat, May 29, 2021 at 4:32 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Fri, May 28, 2021 at 03:15:02PM +0800, Huacai Chen wrote:
> > > In new revision of LS7A, some PCIe ports support larger value than 256,
> > > but their maximum supported MRRS values are not detectable. Moreover,
> > > the current loongson_mrrs_quirk() cannot avoid devices increasing its
> > > MRRS after pci_enable_device(). So the only possible way is configure
> > > MRRS of all devices in BIOS, and add a PCI device flag (PCI_DEV_FLAGS_
> > > NO_INCREASE_MRRS) to stop the increasing MRRS operations.
> >
> > It's still not clear what the problem is.
> >
> > As far as I can tell from the PCIe spec, it is legal for an OS to
> > program any value for MRRS, and it is legal for an endpoint to
> > generate a Read Request with any size up to its MRRS.  If you
> > disagree, please cite the relevant section in the spec.
> >
> > There is no requirement for the OS to limit the MRRS based on a
> > restriction elsewhere in the system.  There is no mechanism for the OS
> > to even discover such a restriction.
> >
> > Of course, there is also no requirement that the PCIe Completions
> > carrying the read data be the same size as the MRRS.  If the non-PCIe
> > part of the system has a restriction on read burst size, that part of
> > the system can certainly break up the read and respond with several
> > PCIe Completions.
> >
> > If LS7A can't break up read requests, that sounds like a problem in
> > the LS7A design.  We should have a description of this erratum.  And
> > we should have some statement about this being fixed in future
> > designs, because we don't want to have to update the fixup with the
> > PCI vendor/device IDs every time new versions come out.
>
> Thanks for your information, but I think only Mr. Shuai Huang can
> explain the root cause, too.
> 
> > I also don't want to rely on some value left in MRRS by BIOS.  If
> > certain bridges have specific limits on what MRRS can be, the fixup
> > should have those limits in it.
>
> As I know, each port of LS7A has a different maximum MRRS value (Yes,
> as you said, this is unreasonable in PCIe spec. but it is a fact in
> LS7A), and also different between hardware revisions. So, the kernel
> cannot configure it, and relying on BIOS is the only way.

Maybe we should just set MRRS to the minimum (128 bytes) for
everything on this platform.

The generic MPS/MRRS config is messy enough already, and I'm hesitant
to add much complication for what seems to be a fairly broken PCIe
controller.

> > loongson_mrrs_quirk() doesn't look efficient.  We should not have to
> > run the fixup for *every* PCI device in the system.  Also, we should
> > not mark every *device* below an LS7A, because it's not the devices
> > that are defective.
> >
> > If it's the root port or the host bridge that's defective, we should
> > mark *that*, e.g., something along the lines of how quirk_no_ext_tags()
> > works.
> OK, I'll improve my code.
> 
> Huacai
> >
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > >  drivers/pci/pci.c    | 5 +++++
> > >  drivers/pci/quirks.c | 6 ++++++
> > >  include/linux/pci.h  | 2 ++
> > >  3 files changed, 13 insertions(+)
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index b717680377a9..6f0d2f5b6f30 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -5802,6 +5802,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
> > >
> > >       v = (ffs(rq) - 8) << 12;
> > >
> > > +     if (dev->dev_flags & PCI_DEV_FLAGS_NO_INCREASE_MRRS) {
> > > +             if (rq > pcie_get_readrq(dev))
> > > +                     return -EINVAL;
> > > +     }
> > > +
> > >       ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
> > >                                                 PCI_EXP_DEVCTL_READRQ, v);
> > >
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 66e4bea69431..10b3b2057940 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -264,6 +264,12 @@ static void loongson_mrrs_quirk(struct pci_dev *dev)
> > >                * any devices attached under these ports.
> > >                */
> > >               if (pci_match_id(bridge_devids, bridge)) {
> > > +                     dev->dev_flags |= PCI_DEV_FLAGS_NO_INCREASE_MRRS;
> > > +
> > > +                     if (pcie_bus_config == PCIE_BUS_DEFAULT ||
> > > +                         pcie_bus_config == PCIE_BUS_TUNE_OFF)
> > > +                             break;
> > > +
> > >                       if (pcie_get_readrq(dev) > 256) {
> > >                               pci_info(dev, "limiting MRRS to 256\n");
> > >                               pcie_set_readrq(dev, 256);
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index c20211e59a57..7fb2072a83b8 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -227,6 +227,8 @@ enum pci_dev_flags {
> > >       PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
> > >       /* Don't use Relaxed Ordering for TLPs directed at this device */
> > >       PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
> > > +     /* Don't increase BIOS's MRRS configuration */
> > > +     PCI_DEV_FLAGS_NO_INCREASE_MRRS = (__force pci_dev_flags_t) (1 << 12),
> > >  };
> > >
> > >  enum pci_irq_reroute_variant {
> > > --
> > > 2.27.0
> > >
