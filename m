Return-Path: <linux-pci+bounces-12647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E3B9694B6
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 09:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2229A1C22199
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 07:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88041D619F;
	Tue,  3 Sep 2024 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Y2rHYSU1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C274F15250F
	for <linux-pci@vger.kernel.org>; Tue,  3 Sep 2024 07:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347291; cv=none; b=Y28cHlShdyII0uMIP/8OfSWXXzz7W5p4h1d/+BJBtgLRWxoTvhCkOg5R+du4/+4ctFmu0+we95dhVrlh5hLDIMMyGVfcCxUJUAR8YWib/LqbaCmScWrzNusULjeszXDprMakp710CPwBoOxvnWmqLySS+PzXzkloCQI2DEm0KhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347291; c=relaxed/simple;
	bh=lvnspfgdG8RnOKsGTxulNvDjv+V/NOumtkJZdWcAjNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1oXO1Ku3YC/71EIzwnxzIW0HJZb0p9XFknqPBr9fDLL1kL903w6kaFoqKcQ/xJAGHaonXjZH9hSGGs9URM/LL3BUrwH4Y0hi7ZLdpT6WaTwr4PUqkzErQ9+BWmrGOQBQdDe5400W0YaRSchpP3UytJGCSGN/ntFVlfdRRL4NSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Y2rHYSU1; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 11D5F3FD45
	for <linux-pci@vger.kernel.org>; Tue,  3 Sep 2024 07:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725347281;
	bh=E9IeXjZeXKINr590eMnz42qBhxuTSRtRjVk9tdvnGIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Y2rHYSU1wfrZGMeqpVg7G9GM5xXPf80ZyDHILHssg6RHRXXzIfdP05irtVTgFErZu
	 vt05I5ib2TQTz9wwsmcQtlTNJ0PmqLj97rQxTqVPq8FLoNK5XGwEQlzhY2KvhwKu0+
	 xW+KhwuV6Vk3/zvfheGjLsf4vOnpK6tiVsjspJb9me06j8+kC0woto8CNaHNlAkX2r
	 mEwRGnlvAZxABOPbKy88w72u9eW/AVU/k5LYwcjCmfrrIIfJ+a+PdUDxzlx7Tq4lpx
	 ltWi91r2DO6jJ5vBi+hDUkVfCuxtfGZCs0+mwKIJghHMXmAc/3lKo8ntAl4tLRangv
	 IcL7YfCeWtApQ==
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f50a90eabfso39067591fa.3
        for <linux-pci@vger.kernel.org>; Tue, 03 Sep 2024 00:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725347280; x=1725952080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9IeXjZeXKINr590eMnz42qBhxuTSRtRjVk9tdvnGIE=;
        b=DBOYhg7N6CD0vnpN3vgOPtDjSLYelvAgAmM1rv45h7o7YlGFCJGAuhd8mFBL81rIUS
         UOoCGRiWgAN6OpAxRwd82USpc6yVvihNQ1HVEBTDFON6XRc18yJMx0/9VahCzowdZCzE
         1hO2wER5tzeLBfeYW540GYPkm2SWAK227xoK1XhGP3XoeF8GfST9Um1jSBdEnu/3zPY8
         dDgLwINr/AoT+tBc4yOtZgo9BI8FAMF4/TMvbvWr0a90zJgPwIZthonEGr56AV1Vrjtb
         DFkGLvtT7tSbfi6TILa+pNIypNoPJOhl3WWUhdbVg8FRATd0YiJZ+pooJC2mVbj/hOCx
         arXA==
X-Forwarded-Encrypted: i=1; AJvYcCUtpU7ry4u40I6iYEiPtAUHZJNaVYfljog8NkkmSMGkCnO+Ak/MMDpzvxVNvirG96joaFff9fDRpLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YysRfxlSt9Gmx2oAhdhVnwQKI2maNxj0qgAxsPATa9Tl9Q6Uzny
	I8fL1y5amf5o35dg94rm44XZ2tUQg/gq/8jF6wyfnlP4QQvTvIoHmExIsXZ2JAZ9oQ1/giGWtKz
	w5Myu9Nu8hLfS/HVN9AV2YE+/83kPQCLHe+NQ6RGoZ9TyHJgEIu6y1yuZ9MZ0I04hP2b5uBqXt5
	MdzMQ4Sct594WunZiuKv6pWgAPUq0kzNFGjb+0a/8aBFY7JjoK
X-Received: by 2002:a2e:a99b:0:b0:2f1:59ed:879d with SMTP id 38308e7fff4ca-2f61038cbe8mr123997921fa.1.1725347279813;
        Tue, 03 Sep 2024 00:07:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELomf0Pm7PLRBKtRbKmyh3nATtRxjhi6Egemr9HtV7ypkbIR1ALOKGGdx4lGqYIivkX+CHSBn+/mOMuwO8WN4=
X-Received: by 2002:a2e:a99b:0:b0:2f1:59ed:879d with SMTP id
 38308e7fff4ca-2f61038cbe8mr123997671fa.1.1725347279167; Tue, 03 Sep 2024
 00:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903025544.286223-1-kai.heng.feng@canonical.com> <20240903042852.v7ootuenihi5wjpn@thinkpad>
In-Reply-To: <20240903042852.v7ootuenihi5wjpn@thinkpad>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 3 Sep 2024 15:07:45 +0800
Message-ID: <CAAd53p4EWEuu-V5hvOHtKZQxCJNf94+FOJT+_ryu0s2RpB1o-Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: vmd: Delay interrupt handling on MTL VMD controller
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev, 
	acelan.kao@canonical.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 12:29=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Sep 03, 2024 at 10:55:44AM +0800, Kai-Heng Feng wrote:
> > Meteor Lake VMD has a bug that the IRQ raises before the DMA region is
> > ready, so the requested IO is considered never completed:
> > [   97.343423] nvme nvme0: I/O 259 QID 2 timeout, completion polled
> > [   97.343446] nvme nvme0: I/O 384 QID 3 timeout, completion polled
> > [   97.343459] nvme nvme0: I/O 320 QID 4 timeout, completion polled
> > [   97.343470] nvme nvme0: I/O 707 QID 5 timeout, completion polled
> >
> > The is documented as erratum MTL016 [0]. The suggested workaround is to
> > "The VMD MSI interrupt-handler should initially perform a dummy registe=
r
> > read to the MSI initiator device prior to any writes to ensure proper
> > PCIe ordering." which essentially is adding a delay before the interrup=
t
> > handling.
> >
>
> Why can't you add a dummy register read instead? Adding a delay for PCIe
> ordering is not going to work always.

This can be done too. But it can take longer than 4us delay, so I'd
like to keep it a bit faster here.

>
> > Hence add a delay before handle interrupt to workaround the erratum.
> >
> > [0] https://edc.intel.com/content/www/us/en/design/products/platforms/d=
etails/meteor-lake-u-p/core-ultra-processor-specification-update/errata-det=
ails/#MTL016
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217871
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/pci/controller/vmd.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.=
c
> > index a726de0af011..3433b3730f9c 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/srcu.h>
> >  #include <linux/rculist.h>
> >  #include <linux/rcupdate.h>
> > +#include <linux/delay.h>
> >
> >  #include <asm/irqdomain.h>
> >
> > @@ -74,6 +75,9 @@ enum vmd_features {
> >        * proper power management of the SoC.
> >        */
> >       VMD_FEAT_BIOS_PM_QUIRK          =3D (1 << 5),
> > +
> > +     /* Erratum MTL016 */
> > +     VMD_FEAT_INTERRUPT_QUIRK        =3D (1 << 6),
> >  };
> >
> >  #define VMD_BIOS_PM_QUIRK_LTR        0x1003  /* 3145728 ns */
> > @@ -90,6 +94,8 @@ static DEFINE_IDA(vmd_instance_ida);
> >   */
> >  static DEFINE_RAW_SPINLOCK(list_lock);
> >
> > +static bool interrupt_delay;
> > +
> >  /**
> >   * struct vmd_irq - private data to map driver IRQ to the VMD shared v=
ector
> >   * @node:    list item for parent traversal.
> > @@ -105,6 +111,7 @@ struct vmd_irq {
> >       struct vmd_irq_list     *irq;
> >       bool                    enabled;
> >       unsigned int            virq;
> > +     bool                    delay_irq;
>
> This is unused. Perhaps you wanted to use this instead of interrupt_delay=
?

This is leftover, will scratch this.

Kai-Heng

>
> - Mani
>
> >  };
> >
> >  /**
> > @@ -680,8 +687,11 @@ static irqreturn_t vmd_irq(int irq, void *data)
> >       int idx;
> >
> >       idx =3D srcu_read_lock(&irqs->srcu);
> > -     list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node)
> > +     list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node) {
> > +             if (interrupt_delay)
> > +                     udelay(4);
> >               generic_handle_irq(vmdirq->virq);
> > +     }
> >       srcu_read_unlock(&irqs->srcu, idx);
> >
> >       return IRQ_HANDLED;
> > @@ -1015,6 +1025,9 @@ static int vmd_probe(struct pci_dev *dev, const s=
truct pci_device_id *id)
> >       if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
> >               vmd->first_vec =3D 1;
> >
> > +     if (features & VMD_FEAT_INTERRUPT_QUIRK)
> > +             interrupt_delay =3D true;
> > +
> >       spin_lock_init(&vmd->cfg_lock);
> >       pci_set_drvdata(dev, vmd);
> >       err =3D vmd_enable_domain(vmd, features);
> > @@ -1106,7 +1119,8 @@ static const struct pci_device_id vmd_ids[] =3D {
> >       {PCI_VDEVICE(INTEL, 0xa77f),
> >               .driver_data =3D VMD_FEATS_CLIENT,},
> >       {PCI_VDEVICE(INTEL, 0x7d0b),
> > -             .driver_data =3D VMD_FEATS_CLIENT,},
> > +             .driver_data =3D VMD_FEATS_CLIENT |
> > +                            VMD_FEAT_INTERRUPT_QUIRK,},
> >       {PCI_VDEVICE(INTEL, 0xad0b),
> >               .driver_data =3D VMD_FEATS_CLIENT,},
> >       {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> > --
> > 2.43.0
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

