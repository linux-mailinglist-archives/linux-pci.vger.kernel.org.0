Return-Path: <linux-pci+bounces-12713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7886E96AE24
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 03:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB40A1F2541C
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 01:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D1529A2;
	Wed,  4 Sep 2024 01:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="W5sCZTaX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1267E10A12
	for <linux-pci@vger.kernel.org>; Wed,  4 Sep 2024 01:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725415051; cv=none; b=P5aW33x16jsBqQlAXGJqTgwN/QcQNJKxuFF8dxPtxy+e99a854UXvSBlNle5hVd1Wx27sCxt2OiGkDs6gtVtWSF3PAyhmyyuzOphGvO8Flf5bl6QSnwIcGL58JhSpOct8bvxYrNlec35kpUp8urgfsnwbH4Vzx4VNZjtgdG5OMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725415051; c=relaxed/simple;
	bh=KrsbuzwRzYAt6vJq9F6VDrlgJqybkvD+/vneeWdcLf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/Doa+0Xv9SN6a/wQmYT2lOrIAE3ub/aC4Mc1dKcypFm/JFWbZayirqhe6jiQDXk7u5rzcXfafasT5VYjIABkDrY0QOxZU8+LT0xU91xCWDu+AD3bTSLY+m8lFFExnC0/b7MmvmAo7O1tXGvE+JkdeJlzO8ojzJwE9S4PYAARhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=W5sCZTaX; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1F26E3F2F2
	for <linux-pci@vger.kernel.org>; Wed,  4 Sep 2024 01:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725415045;
	bh=86SfZLfRe8f8K84AmtfIpgYOcyHznOWRKrIg/kGiMzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=W5sCZTaXx0wypPsUnIPG98SewSSlZJ6E28E+m2p4x16ByCw7yij64y2m8Q4tAGYpi
	 R9aQX0jRY48Z7D9D6Qhkn+8Ks4hdxx+iJDCvEyBOIGkYEfaWvyjkme6So3SPGQzYBi
	 Gmda9D7CMc4Fhap9qVkjcHVudGYjMBndLpW9/u2+/JQbwyX2nm9aerypZCG1ore3sh
	 m8sJZtmvE0YGRXXrbIwA7SC5GLCtl9zC/n9/hpUjAaq7XUsLBPVlnEAUVMHdAwH3Ce
	 HX0XWKefsnezkAad4xmFDS1Zkq+/4Qfy9oUGyR19Qx7/p6nvCMM02XIZFblBl5VGw4
	 +CnszKVmTAakA==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c3c245a8easo69244a12.1
        for <linux-pci@vger.kernel.org>; Tue, 03 Sep 2024 18:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725415042; x=1726019842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86SfZLfRe8f8K84AmtfIpgYOcyHznOWRKrIg/kGiMzg=;
        b=OBUHFz59Gmpq94Wj4j5kNXko5Hl1wiK2tfN+SdgyARsfYHSe4AKAylHwMvFvkNVbMq
         Hfg0yIAsKj8PLN1xbDKXOe9iF0u8ycji/pFEJ7JCgG5gtO9LP2+rfw9EklH7am3jwg4+
         ExXrnoO6f4iBSP0KOjjEunXXx/PByp6/16+/CCDKUhe54D2pwfOh29Pyr4bw2aOl+rqM
         mNpJGhN4wMcytTOJ6qhcO38QM5mmyEv5eTv6sbq4elJpuvLJ+hfC5e0CDFzYEp8/zi0j
         41aSa9mqXPwqr7R4jEKC6w1p5zAgmBt3bWqJTp65VcuDRUTip16V23yHTfhpGfnCQHd0
         0LJw==
X-Forwarded-Encrypted: i=1; AJvYcCXmlOhecqXewPZ6xytq7aWA5y118uq67YxMaK5AHTM5zzvTyFRtKKARw8fkRvAb5fc0+5ADx4T+b8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/IZtZlRIQrIEeXkKFdM5HvUyJR5swHfXYX3NvejRnXC/q193M
	keItLGrhqRRMUiEjog1iB9m1YVH4Kja5ldjD8j9o+eEB9SwTGsVxmJ0xdszvmanRKK7k0SfyN7L
	UrzGfJC4uKrRhSMHDBlvuYoqNdOKZJjqe0/NKlQhhWE15AGuTr64LQ6jnDojPlk+C5bEsB3zybV
	FydzjFiPwYNFlMBV2L4u/SNuuRJRSCmxmtIVeaM3eSVX2X3Qwn
X-Received: by 2002:a05:6402:254b:b0:5c2:6d3e:d99b with SMTP id 4fb4d7f45d1cf-5c26d3edbe0mr2530717a12.16.1725415041899;
        Tue, 03 Sep 2024 18:57:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAEHK8NpR3SZTrSJQCZIajOEVMuJzNnwXMh2xQ/7TcBQy/Pca7lrnwoNVuynFnCfC34vYbYyVkSk/Uuv9WUHE=
X-Received: by 2002:a05:6402:254b:b0:5c2:6d3e:d99b with SMTP id
 4fb4d7f45d1cf-5c26d3edbe0mr2530703a12.16.1725415041133; Tue, 03 Sep 2024
 18:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903025544.286223-1-kai.heng.feng@canonical.com>
 <20240903042852.v7ootuenihi5wjpn@thinkpad> <CAAd53p4EWEuu-V5hvOHtKZQxCJNf94+FOJT+_ryu0s2RpB1o-Q@mail.gmail.com>
 <ZtciXnbQJ88hjfDk@kbusch-mbp>
In-Reply-To: <ZtciXnbQJ88hjfDk@kbusch-mbp>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 4 Sep 2024 09:57:08 +0800
Message-ID: <CAAd53p4cyOvhkorHBkt227_KKcCoKZJ+SM13n_97fmTTq_HLuQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: vmd: Delay interrupt handling on MTL VMD controller
To: Keith Busch <kbusch@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, nirmal.patel@linux.intel.com, 
	jonathan.derrick@linux.dev, acelan.kao@canonical.com, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 10:51=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Tue, Sep 03, 2024 at 03:07:45PM +0800, Kai-Heng Feng wrote:
> > On Tue, Sep 3, 2024 at 12:29=E2=80=AFPM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Tue, Sep 03, 2024 at 10:55:44AM +0800, Kai-Heng Feng wrote:
> > > > Meteor Lake VMD has a bug that the IRQ raises before the DMA region=
 is
> > > > ready, so the requested IO is considered never completed:
> > > > [   97.343423] nvme nvme0: I/O 259 QID 2 timeout, completion polled
> > > > [   97.343446] nvme nvme0: I/O 384 QID 3 timeout, completion polled
> > > > [   97.343459] nvme nvme0: I/O 320 QID 4 timeout, completion polled
> > > > [   97.343470] nvme nvme0: I/O 707 QID 5 timeout, completion polled
> > > >
> > > > The is documented as erratum MTL016 [0]. The suggested workaround i=
s to
> > > > "The VMD MSI interrupt-handler should initially perform a dummy reg=
ister
> > > > read to the MSI initiator device prior to any writes to ensure prop=
er
> > > > PCIe ordering." which essentially is adding a delay before the inte=
rrupt
> > > > handling.
> > > >
> > >
> > > Why can't you add a dummy register read instead? Adding a delay for P=
CIe
> > > ordering is not going to work always.
> >
> > This can be done too. But it can take longer than 4us delay, so I'd
> > like to keep it a bit faster here.
>
> An added delay is just a side effect of the read. The read flushes
> pending device-to-host writes, which is most likely what the errata
> really requires. I think Mani is right, you need to pay that register
> read penalty to truly fix this.

OK, will change the quirk to perform dummy register read.

But I am not sure which is the "MSI initiator device", is it VMD
controller or NVMe devices?

Kai-Heng

>
> > > > +     /* Erratum MTL016 */
> > > > +     VMD_FEAT_INTERRUPT_QUIRK        =3D (1 << 6),
> > > >  };
> > > >
> > > >  #define VMD_BIOS_PM_QUIRK_LTR        0x1003  /* 3145728 ns */
> > > > @@ -90,6 +94,8 @@ static DEFINE_IDA(vmd_instance_ida);
> > > >   */
> > > >  static DEFINE_RAW_SPINLOCK(list_lock);
> > > >
> > > > +static bool interrupt_delay;
> > > > +
> > > >  /**
> > > >   * struct vmd_irq - private data to map driver IRQ to the VMD shar=
ed vector
> > > >   * @node:    list item for parent traversal.
> > > > @@ -105,6 +111,7 @@ struct vmd_irq {
> > > >       struct vmd_irq_list     *irq;
> > > >       bool                    enabled;
> > > >       unsigned int            virq;
> > > > +     bool                    delay_irq;
> > >
> > > This is unused. Perhaps you wanted to use this instead of interrupt_d=
elay?
> >
> > This is leftover, will scratch this.
>
> Maybe you should actually use it instead of making a global? The quirk
> says it is device specific, so no need to punish every device if it
> doesn't need it (unlikely as it is to see such a thing).

