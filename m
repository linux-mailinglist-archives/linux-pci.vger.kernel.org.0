Return-Path: <linux-pci+bounces-3759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B24A85BB73
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 13:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322122824D3
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 12:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE3967C64;
	Tue, 20 Feb 2024 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnbvSuoR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F01664AB;
	Tue, 20 Feb 2024 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430986; cv=none; b=kKoWij6W3WmRK7v/m1CKPEg0fyZmQFAGxfvDjsn/REmQd1O9UDM/UoMFYxV/mPfvpey2J6Zdjh7eu7oWne2qiktdfTvTO2HvBACgu4Jw+nyFUcTVmpFpbysqUk7eKttdlqA4N3BWf7HfvbwId3e/z21gdBKDhN6IgEcL8spLcY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430986; c=relaxed/simple;
	bh=33VirXyTFbVT+zysoG/H2c2cJMVZuHmlBqex6Y08+KY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T43BPncVSnvzDoEG9FdlkioWKAGbits1zLZvfar3+lkonJRdmToZxnIQwJCtHyp5sudyBzN3+NWFGN6CPAZiBVsnsVN3JYGQJZOu/D0bKNL8NFdAELXjZ7zfhvcSWjFjg6SlwePhi70lBvgDF8rKhSS0NfMxuEWUtNbZUAzZh8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnbvSuoR; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5a0dc313058so320932a12.0;
        Tue, 20 Feb 2024 04:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708430984; x=1709035784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiO9eJtO+uVQrXr/q4ZZrBli+HXxDKVU2SENBjkhnPg=;
        b=cnbvSuoRmGzViflTyfXA3EZkIPmk3vCOVBvKo3QrtiMO53ZmXR+XEA91t+49VZdmlc
         u/JnBoUl3+bYX3/fuo9M77lkkmsQOMySuG4lfWJMmVImlvz4WQAhL3uOLlFDFaMF8657
         0+0U5xOm2qZ4GzWprBQ2MULLowuHEbkF7HbkQiN2L9MAYGoSVTXGY1jt2oluXgwsDMRm
         HN7AbE+vOVjZd03qumsC9euXa07t9K3hP9NOctxp27GTddLs+q/SVIlR8AeOk9ZnDZQ1
         vJQWhI7ObK4qrMXGy32ShGSykAwJtzM1igh+gT4EfJaRwY430oO6gJjPG+oF1WDnlCV0
         fplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708430984; x=1709035784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiO9eJtO+uVQrXr/q4ZZrBli+HXxDKVU2SENBjkhnPg=;
        b=T824JsUop/J4Sgzi1EdZNQ4Zuw8cFIRKjoUydH3ZYsuTMrH8NHxbFcXNppBvC9cyjN
         ZbHpyrdTAdmOxuQtZHhtqVDJDdILhOIhpJIkT7a97vBNLGP3hT6l2qB6ezgNIdWeFmGU
         3zdF2YXGAh3l93QC8j4OSaHmKLSTPuc0ruTjmBZ3Y0glV5nBcWqVhZJ673zu1hOKqrgt
         BLNUbiyJ3Y5Y3TfpZU9ocYvCj4q0PRlraoK8g5vORaIDa1Ds4x0ASXbZtpkLCvvLxaTt
         tuOOLfB3p/j0l4Ft0o8QwizNtfOJvxQlD/N94MDuP9syCXr+hbhK9fml4j9I38mZrnkj
         eYHg==
X-Forwarded-Encrypted: i=1; AJvYcCX7HCIBTJs46MnQynFCvtQLxsSheGvw7QyoLDyHaHr1PBvn3Z7RYwzt+m3Mums7HFLXK0O3PRXm0pKuLB4bXI6XrcwfcCxh6D+QGQKMgkU4rMGctH76J4oQysx8gg6f5bdBUx4IBbTs8fNzRVLu1CGv1cOCLl0YtIBaKeuM0xplq4xNrw==
X-Gm-Message-State: AOJu0Yyz1OfciaBDeCzIOQhKMJCQk2q3CD9YQq9kF0vm+7m7xfD7gDp1
	As5BCu14PoYl+y5aC+pIXOhs8ISc7dih8VJa0by+5LQ81LlTtPPd9Iu16XDA61LayRKXp1a4Sfd
	t6CBWUi+XhWHZBXOZHqzgalGBN4s=
X-Google-Smtp-Source: AGHT+IH3W9d9qdi3QNlKqfqpXHy9SgKN+QOgk2wFLB6FpnYBYWEXNizsFHWgmT+Y0vTimhvdL78ifGCMazZTPhYS2+k=
X-Received: by 2002:a17:90a:4e46:b0:299:1ae1:51b2 with SMTP id
 t6-20020a17090a4e4600b002991ae151b2mr10432276pjl.4.1708430983668; Tue, 20 Feb
 2024 04:09:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240218101831.113469-1-minda.chen@starfivetech.com>
 <20240218101831.113469-2-minda.chen@starfivetech.com> <SHXPR01MB0863FCE82CA2155E52A3EB6FE650A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
In-Reply-To: <SHXPR01MB0863FCE82CA2155E52A3EB6FE650A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
From: David Abdurachmanov <david.abdurachmanov@gmail.com>
Date: Tue, 20 Feb 2024 14:09:06 +0200
Message-ID: <CAEn-LTphwFA6KgCZWsqiMMob2Xw4t4sCZ70U0u0z2=yJOpyGHA@mail.gmail.com>
Subject: Re: [PATCH v15 15/23] PCI: microchip: Add event irqchip field to host
 port and add PLDA irqchip
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Conor Dooley <conor@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Daire McNamara <daire.mcnamara@microchip.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Mason Huo <mason.huo@starfivetech.com>, 
	Leyfoon Tan <leyfoon.tan@starfivetech.com>, Kevin Xie <kevin.xie@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 1:02=E2=80=AFPM Minda Chen <minda.chen@starfivetech=
.com> wrote:
>
>
> >
> > As PLDA dts binding doc(Documentation/devicetree/bindings/pci/
> > plda,xpressrich3-axi-common.yaml) showed, PLDA PCIe contains an interru=
pt
> > controller.
> >
> > Microchip PolarFire PCIE event IRQs includes PLDA interrupts and Polarf=
ire their
> > own interrupts. The interrupt irqchip ops includes ack/mask/unmask inte=
rrupt
> > ops, which will write correct registers.
> > Microchip Polarfire PCIe additional interrupts require to write Polarfi=
re SoC
> > self-defined registers. So Microchip PCIe event irqchip ops can not be =
re-used.
> >
> > To support PLDA its own event IRQ process, implements PLDA irqchip ops =
and
> > add event irqchip field to struct pcie_plda_rp.
> >
> > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  .../pci/controller/plda/pcie-microchip-host.c | 66 ++++++++++++++++++-
> >  drivers/pci/controller/plda/pcie-plda.h       |  3 +
> >  2 files changed, 68 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c
> > b/drivers/pci/controller/plda/pcie-microchip-host.c
> > index b3df373a2141..beaf5c27da84 100644
> > --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> > +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> > @@ -770,6 +770,64 @@ static struct irq_chip mc_event_irq_chip =3D {
> >       .irq_unmask =3D mc_unmask_event_irq,
> >  };
> >
> Hi Thomas
>   I think this patch code it is easy to review. If you busy, Could you le=
t other
> IRQ maintainer review? Thanks.
>
> Hi Lorenzo, Bjorn and Krzysztof

Hi Minda,

This patchset seems to have broken threading (lore, mailman). I have
seen other folks on IRC mentioning that too.

I am not sure if that requires re-sending, but let's wait for others to com=
ment.

Cheers,
david

>   Now the code is pending several weeks. Maybe this patch is blocking.
> Actually I write irqchip ops(ack/mask/unmask) like microchip irqchip ops.
> They looks very simple that write PLDA mask or status register. They all =
call the
> same function plda_hwirq_to_mask(). Now you can see this function below.
> Except INTx interrupt, one irqnum mapping to one register bit. The PLDA r=
egister
> graph can be seen 14th patch, which can show all the PLDA interrupts and =
easy to
>  get PLDA codes logic.
>
>   Now the 6.9-next will be closed less than 20 days. I still hope the ref=
actoring patches
> (patch 1 - 16) can be accepted to 6.9. (Starfive and PLDA patches have to=
 be delayed
> to 6.10 or later). I will try my best to achieve it because this series p=
atches reviewed lasts
> a long period and Conor have reviewed all the refactoring patches.
>
> I have no experience in refactoring code before this series patches. I tr=
y my best to do this.
> Maybe I did something wrong in this. Please forgive me.
>
> > +static u32 plda_hwirq_to_mask(int hwirq) {
> > +     u32 mask;
> > +
> > +     /* hwirq 23 - 0 are the same with register */
> > +     if (hwirq < EVENT_PM_MSI_INT_INTX)
> > +             mask =3D BIT(hwirq);
> > +     else if (hwirq =3D=3D EVENT_PM_MSI_INT_INTX)
> > +             mask =3D PM_MSI_INT_INTX_MASK;
> > +     else
> > +             mask =3D BIT(hwirq + PCI_NUM_INTX - 1);
> > +
> > +     return mask;
> > +}
> > +
> > +static void plda_ack_event_irq(struct irq_data *data) {
> > +     struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> > +
> > +     writel_relaxed(plda_hwirq_to_mask(data->hwirq),
> > +                    port->bridge_addr + ISTATUS_LOCAL); }
> > +
> > +static void plda_mask_event_irq(struct irq_data *data) {
> > +     struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> > +     u32 mask, val;
> > +
> > +     mask =3D plda_hwirq_to_mask(data->hwirq);
> > +
> > +     raw_spin_lock(&port->lock);
> > +     val =3D readl_relaxed(port->bridge_addr + IMASK_LOCAL);
> > +     val &=3D ~mask;
> > +     writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
> > +     raw_spin_unlock(&port->lock);
> > +}
> > +
> > +static void plda_unmask_event_irq(struct irq_data *data) {
> > +     struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> > +     u32 mask, val;
> > +
> > +     mask =3D plda_hwirq_to_mask(data->hwirq);
> > +
> > +     raw_spin_lock(&port->lock);
> > +     val =3D readl_relaxed(port->bridge_addr + IMASK_LOCAL);
> > +     val |=3D mask;
> > +     writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
> > +     raw_spin_unlock(&port->lock);
> > +}
> > +
> > +static struct irq_chip plda_event_irq_chip =3D {
> > +     .name =3D "PLDA PCIe EVENT",
> > +     .irq_ack =3D plda_ack_event_irq,
> > +     .irq_mask =3D plda_mask_event_irq,
> > +     .irq_unmask =3D plda_unmask_event_irq,
> > +};
> > +
> >  static const struct plda_event_ops plda_event_ops =3D {
> >       .get_events =3D plda_get_events,
> >  };
> > @@ -777,7 +835,9 @@ static const struct plda_event_ops plda_event_ops =
=3D
> > {  static int plda_pcie_event_map(struct irq_domain *domain, unsigned i=
nt irq,
> >                              irq_hw_number_t hwirq)
> >  {
> > -     irq_set_chip_and_handler(irq, &mc_event_irq_chip, handle_level_ir=
q);
> > +     struct plda_pcie_rp *port =3D (void *)domain->host_data;
> > +
> > +     irq_set_chip_and_handler(irq, port->event_irq_chip, handle_level_=
irq);
> >       irq_set_chip_data(irq, domain->host_data);
> >
> >       return 0;
> > @@ -962,6 +1022,9 @@ static int plda_init_interrupts(struct platform_de=
vice
> > *pdev,
> >       if (!port->event_ops)
> >               port->event_ops =3D &plda_event_ops;
> >
> > +     if (!port->event_irq_chip)
> > +             port->event_irq_chip =3D &plda_event_irq_chip;
> > +
> >       ret =3D plda_pcie_init_irq_domains(port);
> >       if (ret) {
> >               dev_err(dev, "failed creating IRQ domains\n"); @@ -1039,6=
 +1102,7
> > @@ static int mc_platform_init(struct pci_config_window *cfg)
> >               return ret;
> >
> >       port->plda.event_ops =3D &mc_event_ops;
> > +     port->plda.event_irq_chip =3D &mc_event_irq_chip;
> >
> >       /* Address translation is up; safe to enable interrupts */
> >       ret =3D plda_init_interrupts(pdev, &port->plda, &mc_event); diff =
--git
> > a/drivers/pci/controller/plda/pcie-plda.h
> > b/drivers/pci/controller/plda/pcie-plda.h
> > index e0e5e7cc8434..a3ce01735bea 100644
> > --- a/drivers/pci/controller/plda/pcie-plda.h
> > +++ b/drivers/pci/controller/plda/pcie-plda.h
> > @@ -107,6 +107,8 @@ enum plda_int_event {
> >
> >  #define PLDA_NUM_DMA_EVENTS                  16
> >
> > +#define EVENT_PM_MSI_INT_INTX                        (PLDA_NUM_DMA_EVE=
NTS +
> > PLDA_INTX)
> > +#define EVENT_PM_MSI_INT_MSI                 (PLDA_NUM_DMA_EVENTS +
> > PLDA_MSI)
> >  #define PLDA_MAX_EVENT_NUM                   (PLDA_NUM_DMA_EVENTS +
> > PLDA_INT_EVENT_NUM)
> >
> >  /*
> > @@ -155,6 +157,7 @@ struct plda_pcie_rp {
> >       raw_spinlock_t lock;
> >       struct plda_msi msi;
> >       const struct plda_event_ops *event_ops;
> > +     const struct irq_chip *event_irq_chip;
> >       void __iomem *bridge_addr;
> >       int num_events;
> >  };
> > --
> > 2.17.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

