Return-Path: <linux-pci+bounces-12671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129DC96A2B8
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 17:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466A11C22AD8
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 15:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60081188A3B;
	Tue,  3 Sep 2024 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pe8E5BrJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0EA189BB1;
	Tue,  3 Sep 2024 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377395; cv=none; b=B1P3xCpebHYDIj2FsAf4nWvPrTEXq5foaJH3FUt6APD8jd5+YlScuuC+MPoxmHs88FzU19iqi4LJx+nGwuRefosEoe6V9YqYA4cg6fBuGG2FHckCVfcVPddcFKQhKgLnf/Mnubt/MfAlpJ5xwyl6YQWIAoUqf+VMjqknZGQ7gUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377395; c=relaxed/simple;
	bh=dblwvqMPF5fBICfFMv+0MNTWwSGo/n+wPvrSIkmE3TI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tL1g9r0hhHe3y+86JwU97JSrOOMcZD8YxaZC6xqK0uY3wfKsW1vmmOtN6skolpLw7Y/jTZUE4plo/1AJmENNP9cIsfgY2wmbEtjFwyc73GN4YICtYYtbaUIL72c1SRvFTarOP7EtqZER+XALJUB+MtL7hjGh7So5pewXZxfmNtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pe8E5BrJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725377393; x=1756913393;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dblwvqMPF5fBICfFMv+0MNTWwSGo/n+wPvrSIkmE3TI=;
  b=Pe8E5BrJFmTcwZxrwvsTUF+7eb2TI0rrfllemyDuFXwP2BVY1/eeiIyp
   wnPSGDRzKO9pD9t645nvO/XT8O7rS3tmBuLH0ZrP3bqkCWwiQ8AquQSFS
   sBPC728+DxV4DAvluTU3GJBg4sWNFe020l4RinvWHZkzbR3KVzkJq1uIC
   r2NUBkKwHk8XbdEAKCK7q0d5dwDuIyIX6yJYhxhTm2oTGw/to4wqNbFuj
   k/ffnmJQbrX+1XjrsRDKJq5kzM04gQaL/gl1PgW0R13PoLRddfiJ6gfb+
   bggjJxa+UAUqGknw48syejQSSCfLC7cuTdtM3GNa3nu25NgkXBCEumP0r
   g==;
X-CSE-ConnectionGUID: OEJUj4pySyOYFK8BLhdkUQ==
X-CSE-MsgGUID: QEYizpcfQ4a+oEVD82WVRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23550010"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="23550010"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 08:29:52 -0700
X-CSE-ConnectionGUID: vjTBr9YrSuyfBA5TEnKrLQ==
X-CSE-MsgGUID: DlK2nhFWRO6XFYsZWDlVjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="64941379"
Received: from unknown (HELO localhost) ([10.2.132.131])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 08:29:51 -0700
Date: Tue, 3 Sep 2024 08:29:50 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 jonathan.derrick@linux.dev, acelan.kao@canonical.com,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Delay interrupt handling on MTL VMD
 controller
Message-ID: <20240903082950.00006d1e@linux.intel.com>
In-Reply-To: <CAAd53p4EWEuu-V5hvOHtKZQxCJNf94+FOJT+_ryu0s2RpB1o-Q@mail.gmail.com>
References: <20240903025544.286223-1-kai.heng.feng@canonical.com>
	<20240903042852.v7ootuenihi5wjpn@thinkpad>
	<CAAd53p4EWEuu-V5hvOHtKZQxCJNf94+FOJT+_ryu0s2RpB1o-Q@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Sep 2024 15:07:45 +0800
Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> On Tue, Sep 3, 2024 at 12:29=E2=80=AFPM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Sep 03, 2024 at 10:55:44AM +0800, Kai-Heng Feng wrote: =20
> > > Meteor Lake VMD has a bug that the IRQ raises before the DMA
> > > region is ready, so the requested IO is considered never
> > > completed: [   97.343423] nvme nvme0: I/O 259 QID 2 timeout,
> > > completion polled [   97.343446] nvme nvme0: I/O 384 QID 3
> > > timeout, completion polled [   97.343459] nvme nvme0: I/O 320 QID
> > > 4 timeout, completion polled [   97.343470] nvme nvme0: I/O 707
> > > QID 5 timeout, completion polled
> > >
> > > The is documented as erratum MTL016 [0]. The suggested workaround
> > > is to "The VMD MSI interrupt-handler should initially perform a
> > > dummy register read to the MSI initiator device prior to any
> > > writes to ensure proper PCIe ordering." which essentially is
> > > adding a delay before the interrupt handling.
> > > =20
> >
> > Why can't you add a dummy register read instead? Adding a delay for
> > PCIe ordering is not going to work always. =20
>=20
> This can be done too. But it can take longer than 4us delay, so I'd
> like to keep it a bit faster here.

Since the issue is due to the bug in silicon and we have limited
options. If community is okay to take some performance hit, then please
add more details about the patch above VMD_FEAT_INTERRUPT_QUIRK.

-nirmal
>=20
> > =20
> > > Hence add a delay before handle interrupt to workaround the
> > > erratum.
> > >
> > > [0]
> > > https://edc.intel.com/content/www/us/en/design/products/platforms/det=
ails/meteor-lake-u-p/core-ultra-processor-specification-update/errata-detai=
ls/#MTL016
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217871
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > >  drivers/pci/controller/vmd.c | 18 ++++++++++++++++--
> > >  1 file changed, 16 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/vmd.c
> > > b/drivers/pci/controller/vmd.c index a726de0af011..3433b3730f9c
> > > 100644 --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/srcu.h>
> > >  #include <linux/rculist.h>
> > >  #include <linux/rcupdate.h>
> > > +#include <linux/delay.h>
> > >
> > >  #include <asm/irqdomain.h>
> > >
> > > @@ -74,6 +75,9 @@ enum vmd_features {
> > >        * proper power management of the SoC.
> > >        */
> > >       VMD_FEAT_BIOS_PM_QUIRK          =3D (1 << 5),
> > > +
> > > +     /* Erratum MTL016 */
> > > +     VMD_FEAT_INTERRUPT_QUIRK        =3D (1 << 6),
> > >  };
> > >
> > >  #define VMD_BIOS_PM_QUIRK_LTR        0x1003  /* 3145728 ns */
> > > @@ -90,6 +94,8 @@ static DEFINE_IDA(vmd_instance_ida);
> > >   */
> > >  static DEFINE_RAW_SPINLOCK(list_lock);
> > >
> > > +static bool interrupt_delay;
> > > +
> > >  /**
> > >   * struct vmd_irq - private data to map driver IRQ to the VMD
> > > shared vector
> > >   * @node:    list item for parent traversal.
> > > @@ -105,6 +111,7 @@ struct vmd_irq {
> > >       struct vmd_irq_list     *irq;
> > >       bool                    enabled;
> > >       unsigned int            virq;
> > > +     bool                    delay_irq; =20
> >
> > This is unused. Perhaps you wanted to use this instead of
> > interrupt_delay? =20
>=20
> This is leftover, will scratch this.
>=20
> Kai-Heng
>=20
> >
> > - Mani
> > =20
> > >  };
> > >
> > >  /**
> > > @@ -680,8 +687,11 @@ static irqreturn_t vmd_irq(int irq, void
> > > *data) int idx;
> > >
> > >       idx =3D srcu_read_lock(&irqs->srcu);
> > > -     list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node)
> > > +     list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node) {
> > > +             if (interrupt_delay)
> > > +                     udelay(4);
> > >               generic_handle_irq(vmdirq->virq);
> > > +     }
> > >       srcu_read_unlock(&irqs->srcu, idx);
> > >
> > >       return IRQ_HANDLED;
> > > @@ -1015,6 +1025,9 @@ static int vmd_probe(struct pci_dev *dev,
> > > const struct pci_device_id *id) if (features &
> > > VMD_FEAT_OFFSET_FIRST_VECTOR) vmd->first_vec =3D 1;
> > >
> > > +     if (features & VMD_FEAT_INTERRUPT_QUIRK)
> > > +             interrupt_delay =3D true;
> > > +
> > >       spin_lock_init(&vmd->cfg_lock);
> > >       pci_set_drvdata(dev, vmd);
> > >       err =3D vmd_enable_domain(vmd, features);
> > > @@ -1106,7 +1119,8 @@ static const struct pci_device_id vmd_ids[]
> > > =3D { {PCI_VDEVICE(INTEL, 0xa77f),
> > >               .driver_data =3D VMD_FEATS_CLIENT,},
> > >       {PCI_VDEVICE(INTEL, 0x7d0b),
> > > -             .driver_data =3D VMD_FEATS_CLIENT,},
> > > +             .driver_data =3D VMD_FEATS_CLIENT |
> > > +                            VMD_FEAT_INTERRUPT_QUIRK,},
> > >       {PCI_VDEVICE(INTEL, 0xad0b),
> > >               .driver_data =3D VMD_FEATS_CLIENT,},
> > >       {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> > > --
> > > 2.43.0
> > > =20
> >
> > --
> > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D =20


