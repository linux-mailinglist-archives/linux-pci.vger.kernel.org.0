Return-Path: <linux-pci+bounces-13130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 954C0976FBE
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 19:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A56E2875E6
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 17:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DCC1BF81F;
	Thu, 12 Sep 2024 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IPNLg8UV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770E51BF81E;
	Thu, 12 Sep 2024 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726163151; cv=none; b=GDLfzEhn0B60B3l7eVJnRsIz9uvuFM9z07krX1z5a5BrSLAACaT4BPxpfkjxpyYADve7Uw6QKI4UkrStimEYFxhVZAzlnCyFDvuBZcNLXSzMpeunDBaLEIq3APFD5y/2QakyZKKf8DFOxJwiA1PlDysUI4lbCFyHEjLGRVNsGWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726163151; c=relaxed/simple;
	bh=rgWZ+wPUFJKu15o8xmVTzieiONmEPf5d6/j+xtaSNuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DV+6n0/ngZPhuJ6Gn3bPAa3T4lgBGIk9fmekZeYCQExAti+ilBgNa6aWqFgK/ij6m89aUfM0amwdYaa50g2TFtguA8DAeiQSwMCpGzhFZU9rWUju8OzT60FN2c/JMuuDWZwwmka0Q/0UkyaGfKfmogOlvwkcHas1UF40YQ11i8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IPNLg8UV; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726163149; x=1757699149;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rgWZ+wPUFJKu15o8xmVTzieiONmEPf5d6/j+xtaSNuw=;
  b=IPNLg8UVPmDsWtndWmPvUYxCiGUk+7KrWSrylLMIp9KxUkxCC69Aknsw
   6efaDjnXELQlIP4XLtIMMB0VnZdFrgOq8hk/VJ57CYLbKWnuw1C5aSzOn
   pDWUDEmVGjYYIXIucVkRudgz3179EBhait9tsJGZmwFyoFYfJ5ACpL5og
   c7MAQ7YEnpJdRkC7+GkOhxNjFeY2aVb/VA+T5AcWo/4exNKVqu+maNR1t
   Df3A5Wh37Alettv93tWfHMfZ2q8A9b2gKaKNnIW2eWCcHh0JHgO8nrruN
   ZP4YoWiF5OTaHo0hnm5MsteUy1ydBWO301oYDG4BWZ1AlP0mLV7/1kknZ
   g==;
X-CSE-ConnectionGUID: ch7V3LlpRlOodlorCASCqQ==
X-CSE-MsgGUID: Pof275GxRK2drlDdT+F9Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25185977"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="25185977"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 10:45:49 -0700
X-CSE-ConnectionGUID: OcFEuW1zSUG/Ewqp6xxZHw==
X-CSE-MsgGUID: Ftl9is96TnqfrCC4G3McSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67764506"
Received: from unknown (HELO localhost) ([10.2.132.131])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 10:45:48 -0700
Date: Thu, 12 Sep 2024 10:45:47 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Keith Busch
 <kbusch@kernel.org>, jonathan.derrick@linux.dev, acelan.kao@canonical.com,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Delay interrupt handling on MTL VMD
 controller
Message-ID: <20240912104547.00005865@linux.intel.com>
In-Reply-To: <CAAd53p5ox-CiNd6nHb4ogL-K2wr+dNYBtRxiw8E6jf7HgLsH-A@mail.gmail.com>
References: <20240903025544.286223-1-kai.heng.feng@canonical.com>
	<20240903042852.v7ootuenihi5wjpn@thinkpad>
	<CAAd53p4EWEuu-V5hvOHtKZQxCJNf94+FOJT+_ryu0s2RpB1o-Q@mail.gmail.com>
	<ZtciXnbQJ88hjfDk@kbusch-mbp>
	<CAAd53p4cyOvhkorHBkt227_KKcCoKZJ+SM13n_97fmTTq_HLuQ@mail.gmail.com>
	<20240904062219.x7kft2l3gq4qsojc@thinkpad>
	<CAAd53p5ox-CiNd6nHb4ogL-K2wr+dNYBtRxiw8E6jf7HgLsH-A@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Sep 2024 09:56:59 +0800
Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> On Wed, Sep 4, 2024 at 2:22=E2=80=AFPM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Wed, Sep 04, 2024 at 09:57:08AM +0800, Kai-Heng Feng wrote: =20
> > > On Tue, Sep 3, 2024 at 10:51=E2=80=AFPM Keith Busch <kbusch@kernel.or=
g>
> > > wrote: =20
> > > >
> > > > On Tue, Sep 03, 2024 at 03:07:45PM +0800, Kai-Heng Feng wrote: =20
> > > > > On Tue, Sep 3, 2024 at 12:29=E2=80=AFPM Manivannan Sadhasivam
> > > > > <manivannan.sadhasivam@linaro.org> wrote: =20
> > > > > >
> > > > > > On Tue, Sep 03, 2024 at 10:55:44AM +0800, Kai-Heng Feng
> > > > > > wrote: =20
> > > > > > > Meteor Lake VMD has a bug that the IRQ raises before the
> > > > > > > DMA region is ready, so the requested IO is considered
> > > > > > > never completed: [   97.343423] nvme nvme0: I/O 259 QID 2
> > > > > > > timeout, completion polled [   97.343446] nvme nvme0: I/O
> > > > > > > 384 QID 3 timeout, completion polled [   97.343459] nvme
> > > > > > > nvme0: I/O 320 QID 4 timeout, completion polled [
> > > > > > > 97.343470] nvme nvme0: I/O 707 QID 5 timeout, completion
> > > > > > > polled
> > > > > > >
> > > > > > > The is documented as erratum MTL016 [0]. The suggested
> > > > > > > workaround is to "The VMD MSI interrupt-handler should
> > > > > > > initially perform a dummy register read to the MSI
> > > > > > > initiator device prior to any writes to ensure proper
> > > > > > > PCIe ordering." which essentially is adding a delay
> > > > > > > before the interrupt handling.=20
> > > > > >
> > > > > > Why can't you add a dummy register read instead? Adding a
> > > > > > delay for PCIe ordering is not going to work always. =20
> > > > >
> > > > > This can be done too. But it can take longer than 4us delay,
> > > > > so I'd like to keep it a bit faster here. =20
> > > >
> > > > An added delay is just a side effect of the read. The read
> > > > flushes pending device-to-host writes, which is most likely
> > > > what the errata really requires. I think Mani is right, you
> > > > need to pay that register read penalty to truly fix this. =20
> > >
> > > OK, will change the quirk to perform dummy register read.
> > >
> > > But I am not sure which is the "MSI initiator device", is it VMD
> > > controller or NVMe devices?
> > > =20
> >
> > 'MSI initiator' should be the NVMe device. My understanding is that
> > the workaround suggests reading the NVMe register from the MSI
> > handler before doing any write to the device to ensures that the
> > previous writes from the device are flushed. =20
>=20
> Hmm, it would be really great to contain the quirk in VMD controller.
> Is there anyway to do that right before generic_handle_irq()?
>=20
The bug is in hardware, I agree with Kai-Heng to contain it to VMD
controller.
=20
> >
> > And this sounds like the workaround should be done in the NVMe
> > driver as it has the knowledge of the NVMe registers. But isn't the
> > NVMe driver already reading CQE status first up in the ISR? =20
>=20
> The VMD interrupt is fired before the CQE status update, hence the
> bug.
>=20
> Kai-Heng
>=20
> >
> > - Mani
> > =20
> > > Kai-Heng
> > > =20
> > > > =20
> > > > > > > +     /* Erratum MTL016 */
> > > > > > > +     VMD_FEAT_INTERRUPT_QUIRK        =3D (1 << 6),
> > > > > > >  };
> > > > > > >
> > > > > > >  #define VMD_BIOS_PM_QUIRK_LTR        0x1003  /* 3145728
> > > > > > > ns */ @@ -90,6 +94,8 @@ static
> > > > > > > DEFINE_IDA(vmd_instance_ida); */
> > > > > > >  static DEFINE_RAW_SPINLOCK(list_lock);
> > > > > > >
> > > > > > > +static bool interrupt_delay;
> > > > > > > +
> > > > > > >  /**
> > > > > > >   * struct vmd_irq - private data to map driver IRQ to
> > > > > > > the VMD shared vector
> > > > > > >   * @node:    list item for parent traversal.
> > > > > > > @@ -105,6 +111,7 @@ struct vmd_irq {
> > > > > > >       struct vmd_irq_list     *irq;
> > > > > > >       bool                    enabled;
> > > > > > >       unsigned int            virq;
> > > > > > > +     bool                    delay_irq; =20
> > > > > >
> > > > > > This is unused. Perhaps you wanted to use this instead of
> > > > > > interrupt_delay? =20
> > > > >
> > > > > This is leftover, will scratch this. =20
> > > >
> > > > Maybe you should actually use it instead of making a global?
> > > > The quirk says it is device specific, so no need to punish
> > > > every device if it doesn't need it (unlikely as it is to see
> > > > such a thing). =20
> >
> > --
> > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D =20


