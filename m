Return-Path: <linux-pci+bounces-12865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B6396E76F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 03:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C911C22ECE
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 01:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CB0282FE;
	Fri,  6 Sep 2024 01:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="s/z06XT8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED9010E0
	for <linux-pci@vger.kernel.org>; Fri,  6 Sep 2024 01:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725587838; cv=none; b=S+Tkk1K7TcjRXrYnVeRy5ZFUIu6XGxgBak8mSZsd9IO8mKowdmfl50LjxkwECQiIqpY2oP30zZODSP3xezsKljh/Wmmi21ZIqaUpKF1HN83fP36Pc8h94iaVMqyzuxCvz6848pFxugiFvTfA8MJzCkCNcvYyTV2IhHgdqly1Swg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725587838; c=relaxed/simple;
	bh=0cOHGAjR+tN+R6qMQ7WgMAGz6qbMfSjySeMki3cDKDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqLTc68UwwxFsT9fhXzGZDJHhoaL0vsLzfJnnx0bhCshmfMa6O9tr0ir20WwZU7YW17EtgoTooRksEY8uA2NcWoKNRQXR7wWzLyb6QtYZTfTc9L7zTtHsd9dQ46nP5KrOWCwLRh/h2DRBwku6ziZz9wJMInUrg/Diwgm+hdfiY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=s/z06XT8; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4A96B3F2BA
	for <linux-pci@vger.kernel.org>; Fri,  6 Sep 2024 01:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725587833;
	bh=EL3eloeKhhdUIy+w5WuH4wnRWV+F7GryQMB+9nuDDIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=s/z06XT86zAHanVdYTksOL7uqTdOxs4MiHFHB8t/YYUX6m7fyZ4diyiLuyGJbdLKN
	 Uv56MQkCqrvXu3V3phpMpQGaZLxf0GsehWEwXKTgO8sCHog9bjwVdLq46juRTguCk/
	 MhZpLXe9gJAcPiuG0d0roskMGop4kkDVRp9oh32aXDEUNWCNXXc2zDbSQM9PxWKZVt
	 2Glse+ZNESoB+MSLd8JYv+KGIZT2oQiFHmKqKM4Io7QN1HjHwvxxvh5GpgBtsKXiIG
	 DbguUxTEqWEBMKaWYUJ17raWhl4yDqEuSj/VzjCDH0e8kNWfJNJhoa1blWFYdIzzJ+
	 SvleqohvYQnPQ==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5becd2ca7e7so2115906a12.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Sep 2024 18:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725587832; x=1726192632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EL3eloeKhhdUIy+w5WuH4wnRWV+F7GryQMB+9nuDDIk=;
        b=U99V+cj5mhwyMSb/S9syJSbjmeKPj2dNMTj4BWGN7cI2txxWIEuPRrnwNi0Ezw+1ag
         ioM2Oo8o1yjrFHVJpIxLzKzV/Hv1ID8pz94ZyC5XMg3rcT8p27ZZewpH27A7kDx8uzLH
         46nn93JSDSQYJTTgEyqiRk4yoaHyiFNenA+PgVpi0zKxR5laWUNRWhQbmxhZRDJkhZZh
         PJ/3tjC3baEHs8ndqDumuUoVN/GIv4t5bfulcNThr0eXQi0E279r57ImXM13nTBwBYBa
         /LcR8rKRjv1bKfyTp7iIgWQ0nhaKOyF/Cvo7zbJtdzQKBkJCK8ZxmYxeHdWPnwDcJCCe
         fOuA==
X-Forwarded-Encrypted: i=1; AJvYcCW5f7CWdOKtyvRNIyYz7zRih8OeR3Vb0ykHfD5YfF9CHZVJWvVtQeUzgfHI8ISYi8Jw5vln1/daROQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Ep5r+SuHR9nQ4Gpu1uTl0JQ+O0RAF1+NfqrfBImPSbCB3Ggi
	RhuTGBg0rA6oBJXkajPuPskxH70/sk/xvk2udq5/oFloJSBB3B0+L2AKxImFy3up/q3e4EIQK7f
	8uPrf91GdAun9rPmkXORw0AqT4ItsEA9sSxtpx/e2jfW8MzNdE/pMNxHGzkdpuMN/db1+4MEjvx
	X3ISx+ZUUgISMcJsTwoSDjH5nwKGlf6GwqnMzyUX3pb1RLmGp7
X-Received: by 2002:a05:6402:84d:b0:5c2:5248:a929 with SMTP id 4fb4d7f45d1cf-5c3db976252mr1141574a12.7.1725587832394;
        Thu, 05 Sep 2024 18:57:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpPt58F5FS0DqOKKD4R5wPwUJrt37QUevH9yHBuKznjg+BH2JoJ/tb87I6p7X1+ghoza/DchGHc/QjTK3idJo=
X-Received: by 2002:a05:6402:84d:b0:5c2:5248:a929 with SMTP id
 4fb4d7f45d1cf-5c3db976252mr1141551a12.7.1725587831840; Thu, 05 Sep 2024
 18:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903025544.286223-1-kai.heng.feng@canonical.com>
 <20240903042852.v7ootuenihi5wjpn@thinkpad> <CAAd53p4EWEuu-V5hvOHtKZQxCJNf94+FOJT+_ryu0s2RpB1o-Q@mail.gmail.com>
 <ZtciXnbQJ88hjfDk@kbusch-mbp> <CAAd53p4cyOvhkorHBkt227_KKcCoKZJ+SM13n_97fmTTq_HLuQ@mail.gmail.com>
 <20240904062219.x7kft2l3gq4qsojc@thinkpad>
In-Reply-To: <20240904062219.x7kft2l3gq4qsojc@thinkpad>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 6 Sep 2024 09:56:59 +0800
Message-ID: <CAAd53p5ox-CiNd6nHb4ogL-K2wr+dNYBtRxiw8E6jf7HgLsH-A@mail.gmail.com>
Subject: Re: [PATCH] PCI: vmd: Delay interrupt handling on MTL VMD controller
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Keith Busch <kbusch@kernel.org>, nirmal.patel@linux.intel.com, 
	jonathan.derrick@linux.dev, acelan.kao@canonical.com, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 2:22=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Wed, Sep 04, 2024 at 09:57:08AM +0800, Kai-Heng Feng wrote:
> > On Tue, Sep 3, 2024 at 10:51=E2=80=AFPM Keith Busch <kbusch@kernel.org>=
 wrote:
> > >
> > > On Tue, Sep 03, 2024 at 03:07:45PM +0800, Kai-Heng Feng wrote:
> > > > On Tue, Sep 3, 2024 at 12:29=E2=80=AFPM Manivannan Sadhasivam
> > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > >
> > > > > On Tue, Sep 03, 2024 at 10:55:44AM +0800, Kai-Heng Feng wrote:
> > > > > > Meteor Lake VMD has a bug that the IRQ raises before the DMA re=
gion is
> > > > > > ready, so the requested IO is considered never completed:
> > > > > > [   97.343423] nvme nvme0: I/O 259 QID 2 timeout, completion po=
lled
> > > > > > [   97.343446] nvme nvme0: I/O 384 QID 3 timeout, completion po=
lled
> > > > > > [   97.343459] nvme nvme0: I/O 320 QID 4 timeout, completion po=
lled
> > > > > > [   97.343470] nvme nvme0: I/O 707 QID 5 timeout, completion po=
lled
> > > > > >
> > > > > > The is documented as erratum MTL016 [0]. The suggested workarou=
nd is to
> > > > > > "The VMD MSI interrupt-handler should initially perform a dummy=
 register
> > > > > > read to the MSI initiator device prior to any writes to ensure =
proper
> > > > > > PCIe ordering." which essentially is adding a delay before the =
interrupt
> > > > > > handling.
> > > > > >
> > > > >
> > > > > Why can't you add a dummy register read instead? Adding a delay f=
or PCIe
> > > > > ordering is not going to work always.
> > > >
> > > > This can be done too. But it can take longer than 4us delay, so I'd
> > > > like to keep it a bit faster here.
> > >
> > > An added delay is just a side effect of the read. The read flushes
> > > pending device-to-host writes, which is most likely what the errata
> > > really requires. I think Mani is right, you need to pay that register
> > > read penalty to truly fix this.
> >
> > OK, will change the quirk to perform dummy register read.
> >
> > But I am not sure which is the "MSI initiator device", is it VMD
> > controller or NVMe devices?
> >
>
> 'MSI initiator' should be the NVMe device. My understanding is that the
> workaround suggests reading the NVMe register from the MSI handler before=
 doing
> any write to the device to ensures that the previous writes from the devi=
ce are
> flushed.

Hmm, it would be really great to contain the quirk in VMD controller.
Is there anyway to do that right before generic_handle_irq()?

>
> And this sounds like the workaround should be done in the NVMe driver as =
it has
> the knowledge of the NVMe registers. But isn't the NVMe driver already re=
ading
> CQE status first up in the ISR?

The VMD interrupt is fired before the CQE status update, hence the bug.

Kai-Heng

>
> - Mani
>
> > Kai-Heng
> >
> > >
> > > > > > +     /* Erratum MTL016 */
> > > > > > +     VMD_FEAT_INTERRUPT_QUIRK        =3D (1 << 6),
> > > > > >  };
> > > > > >
> > > > > >  #define VMD_BIOS_PM_QUIRK_LTR        0x1003  /* 3145728 ns */
> > > > > > @@ -90,6 +94,8 @@ static DEFINE_IDA(vmd_instance_ida);
> > > > > >   */
> > > > > >  static DEFINE_RAW_SPINLOCK(list_lock);
> > > > > >
> > > > > > +static bool interrupt_delay;
> > > > > > +
> > > > > >  /**
> > > > > >   * struct vmd_irq - private data to map driver IRQ to the VMD =
shared vector
> > > > > >   * @node:    list item for parent traversal.
> > > > > > @@ -105,6 +111,7 @@ struct vmd_irq {
> > > > > >       struct vmd_irq_list     *irq;
> > > > > >       bool                    enabled;
> > > > > >       unsigned int            virq;
> > > > > > +     bool                    delay_irq;
> > > > >
> > > > > This is unused. Perhaps you wanted to use this instead of interru=
pt_delay?
> > > >
> > > > This is leftover, will scratch this.
> > >
> > > Maybe you should actually use it instead of making a global? The quir=
k
> > > says it is device specific, so no need to punish every device if it
> > > doesn't need it (unlikely as it is to see such a thing).
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

