Return-Path: <linux-pci+bounces-13141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0583977889
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 07:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2F51F24E7A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 05:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0442F187334;
	Fri, 13 Sep 2024 05:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="RpnuF73m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7CE15574A
	for <linux-pci@vger.kernel.org>; Fri, 13 Sep 2024 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726206969; cv=none; b=cMoTpKpJKn+sbsF3Ioi77i9jK+q2ARu3G1MjUVqZ4HTOHdkZ/G/shrK3QHPwK12AVoUbntk7/LbAOWNbLSRrPkN3x5yiz4CvRm8IW3S3pDcPjjFn9SlT43x0Eoq46Yxu1ptj7i4/zrdjo1iyumy2rD9qnQRoJm+VXrBNv+46m/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726206969; c=relaxed/simple;
	bh=9sFRQkKy5bkcGcxXKZ1rQ7oNNx41RkufxbrMYDjNWf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMe/k8OfRKtVMKhOJIFvGAsx211LOMU3j20x4FRtcB3By9uzjCZMm1ck/httzIIcGfHTjA0pZ38h7hdcnJ+pp+1Z+4ILEkiman8H1EPTWmyPrNiugOezS+Dxy6hFPQYrfzV6KZ6dWZDO1Z0E8YexlSsrqfwAfNdm++W9jZqeyKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=RpnuF73m; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1A2C33F2FC
	for <linux-pci@vger.kernel.org>; Fri, 13 Sep 2024 05:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726206963;
	bh=5EFFOs7efFr4Ld8082jWwc8FabCSVm99KY4+yZAtolE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=RpnuF73mK2Jwtej4j6ttF0IG1k7j87W/ZrUHbFh3w9i7v98Bbp1J/bT/mk/NwKljy
	 44TKkDCbOnelE/8hpOxc6wnm05/80BG6NIo7upSobEhqoN9hLopkys5Ng7v/0+RoP1
	 i2/wdmiEmW/sv5N9djQH8PP8cUn1n9VPz/ETN8gxOk/wtqjvYu5hFrxyHzawMChGzE
	 udvicoaelPnyxFFYwgACWp2X1TWbQfF2y/oIStLcKTFIq46stBIhq1DnHVMWIKcn6u
	 ayt7RjztxBs4KdUlKSt0FWKiEIGMZ9ww9/SS1JStToOrmF0TQu+MJb8k/wqsikL8dU
	 ezdchnwn+nb0w==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8d21b5cb5fso106846766b.0
        for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2024 22:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726206962; x=1726811762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EFFOs7efFr4Ld8082jWwc8FabCSVm99KY4+yZAtolE=;
        b=MUepJppSdGKEyCvVqMHWpUXhXi2CGQ+mVh2ABOkQHK0ySw9CFvLKE4qN28+g1JnvXp
         JGI9sJySg1XI1r66nc+A+tS2XR1tRYxksL5c0v8U80sVYWRcCQ/RHAnqHEq4S1F3ViIB
         wFAnLuhObatmk+ElzoLxrl8JpVa6HHgrKv0z9cgKazZROouTrWVb0BS5Xwp55ucMHfJ3
         TOYTB39kS1nwjwmjcqAuhJ8slSraiqBd7G9WvhDV7YV8bVwIm3d+ar7FmUcvMr7kZgrp
         Yj/QCqn90k8PzANW/f8bOQw2+BqVqlwXmZrR9qSTU/k6pNhZ0fNaeG2AJO+UufEkdCr4
         kzJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNbOTnjmMmoUC5Cm548jjcpEndm6kt/a/DNqycI+IJxP4/3QVj/KkivZobZ6iuwAT3EWHSrfIC7fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuEQYiHNLh9dWKVW5I5DaUv0BLIOnkkc/Otg226z0Li3/l0H5Y
	OI++ZOW5wUkZftNPHkh1c2L+1Ay/MQWQSKE/GVgfhcsnYBBPAELmjzOlzVxyXnDWfMJ0j0IAV5l
	MJ8fnbtCozwc9S2AN+pIwL8CBC3VU4JnfiPK9SeaxuY5u93Ix5vYdfH1KRebyQH/8qAuqP02ccj
	bBypIsGTTgyCmpdvfcE7tzBQicDsOQdvc0EE9kYqcMd51/rTSh
X-Received: by 2002:a05:6402:35ce:b0:5c4:95b:b186 with SMTP id 4fb4d7f45d1cf-5c413e0958amr3462315a12.6.1726206962640;
        Thu, 12 Sep 2024 22:56:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC2NRhInvexl5Lhlay7osyz26YHo8SHvD+HwckMmf2VYiqH9OESB/Yug3HDG1+xPGk/QAZwCaKnUZasLXH4+E=
X-Received: by 2002:a05:6402:35ce:b0:5c4:95b:b186 with SMTP id
 4fb4d7f45d1cf-5c413e0958amr3462295a12.6.1726206962076; Thu, 12 Sep 2024
 22:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903025544.286223-1-kai.heng.feng@canonical.com>
 <20240903042852.v7ootuenihi5wjpn@thinkpad> <CAAd53p4EWEuu-V5hvOHtKZQxCJNf94+FOJT+_ryu0s2RpB1o-Q@mail.gmail.com>
 <ZtciXnbQJ88hjfDk@kbusch-mbp> <CAAd53p4cyOvhkorHBkt227_KKcCoKZJ+SM13n_97fmTTq_HLuQ@mail.gmail.com>
 <20240904062219.x7kft2l3gq4qsojc@thinkpad> <CAAd53p5ox-CiNd6nHb4ogL-K2wr+dNYBtRxiw8E6jf7HgLsH-A@mail.gmail.com>
 <20240912104547.00005865@linux.intel.com>
In-Reply-To: <20240912104547.00005865@linux.intel.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 13 Sep 2024 13:55:49 +0800
Message-ID: <CAAd53p698eNQdZqPFHCmpPQ7pkDoyT4_C9ERXJ4X=V_8QFO8pQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: vmd: Delay interrupt handling on MTL VMD controller
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Keith Busch <kbusch@kernel.org>, 
	jonathan.derrick@linux.dev, acelan.kao@canonical.com, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kaihengfeng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nirmal,

On Fri, Sep 13, 2024 at 1:45=E2=80=AFAM Nirmal Patel
<nirmal.patel@linux.intel.com> wrote:
>
> On Fri, 6 Sep 2024 09:56:59 +0800
> Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>
> > On Wed, Sep 4, 2024 at 2:22=E2=80=AFPM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Wed, Sep 04, 2024 at 09:57:08AM +0800, Kai-Heng Feng wrote:
> > > > On Tue, Sep 3, 2024 at 10:51=E2=80=AFPM Keith Busch <kbusch@kernel.=
org>
> > > > wrote:
> > > > >
> > > > > On Tue, Sep 03, 2024 at 03:07:45PM +0800, Kai-Heng Feng wrote:
> > > > > > On Tue, Sep 3, 2024 at 12:29=E2=80=AFPM Manivannan Sadhasivam
> > > > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > > > >
> > > > > > > On Tue, Sep 03, 2024 at 10:55:44AM +0800, Kai-Heng Feng
> > > > > > > wrote:
> > > > > > > > Meteor Lake VMD has a bug that the IRQ raises before the
> > > > > > > > DMA region is ready, so the requested IO is considered
> > > > > > > > never completed: [   97.343423] nvme nvme0: I/O 259 QID 2
> > > > > > > > timeout, completion polled [   97.343446] nvme nvme0: I/O
> > > > > > > > 384 QID 3 timeout, completion polled [   97.343459] nvme
> > > > > > > > nvme0: I/O 320 QID 4 timeout, completion polled [
> > > > > > > > 97.343470] nvme nvme0: I/O 707 QID 5 timeout, completion
> > > > > > > > polled
> > > > > > > >
> > > > > > > > The is documented as erratum MTL016 [0]. The suggested
> > > > > > > > workaround is to "The VMD MSI interrupt-handler should
> > > > > > > > initially perform a dummy register read to the MSI
> > > > > > > > initiator device prior to any writes to ensure proper
> > > > > > > > PCIe ordering." which essentially is adding a delay
> > > > > > > > before the interrupt handling.
> > > > > > >
> > > > > > > Why can't you add a dummy register read instead? Adding a
> > > > > > > delay for PCIe ordering is not going to work always.
> > > > > >
> > > > > > This can be done too. But it can take longer than 4us delay,
> > > > > > so I'd like to keep it a bit faster here.
> > > > >
> > > > > An added delay is just a side effect of the read. The read
> > > > > flushes pending device-to-host writes, which is most likely
> > > > > what the errata really requires. I think Mani is right, you
> > > > > need to pay that register read penalty to truly fix this.
> > > >
> > > > OK, will change the quirk to perform dummy register read.
> > > >
> > > > But I am not sure which is the "MSI initiator device", is it VMD
> > > > controller or NVMe devices?
> > > >
> > >
> > > 'MSI initiator' should be the NVMe device. My understanding is that
> > > the workaround suggests reading the NVMe register from the MSI
> > > handler before doing any write to the device to ensures that the
> > > previous writes from the device are flushed.
> >
> > Hmm, it would be really great to contain the quirk in VMD controller.
> > Is there anyway to do that right before generic_handle_irq()?
> >
> The bug is in hardware, I agree with Kai-Heng to contain it to VMD
> controller.

The problem I am facing right now is that I can't connect the virq to
NVMe's struct device to implement the quirk.

Do you have any idea how to achieve that?

Kai-Heng

>
> > >
> > > And this sounds like the workaround should be done in the NVMe
> > > driver as it has the knowledge of the NVMe registers. But isn't the
> > > NVMe driver already reading CQE status first up in the ISR?
> >
> > The VMD interrupt is fired before the CQE status update, hence the
> > bug.
> >
> > Kai-Heng
> >
> > >
> > > - Mani
> > >
> > > > Kai-Heng
> > > >
> > > > >
> > > > > > > > +     /* Erratum MTL016 */
> > > > > > > > +     VMD_FEAT_INTERRUPT_QUIRK        =3D (1 << 6),
> > > > > > > >  };
> > > > > > > >
> > > > > > > >  #define VMD_BIOS_PM_QUIRK_LTR        0x1003  /* 3145728
> > > > > > > > ns */ @@ -90,6 +94,8 @@ static
> > > > > > > > DEFINE_IDA(vmd_instance_ida); */
> > > > > > > >  static DEFINE_RAW_SPINLOCK(list_lock);
> > > > > > > >
> > > > > > > > +static bool interrupt_delay;
> > > > > > > > +
> > > > > > > >  /**
> > > > > > > >   * struct vmd_irq - private data to map driver IRQ to
> > > > > > > > the VMD shared vector
> > > > > > > >   * @node:    list item for parent traversal.
> > > > > > > > @@ -105,6 +111,7 @@ struct vmd_irq {
> > > > > > > >       struct vmd_irq_list     *irq;
> > > > > > > >       bool                    enabled;
> > > > > > > >       unsigned int            virq;
> > > > > > > > +     bool                    delay_irq;
> > > > > > >
> > > > > > > This is unused. Perhaps you wanted to use this instead of
> > > > > > > interrupt_delay?
> > > > > >
> > > > > > This is leftover, will scratch this.
> > > > >
> > > > > Maybe you should actually use it instead of making a global?
> > > > > The quirk says it is device specific, so no need to punish
> > > > > every device if it doesn't need it (unlikely as it is to see
> > > > > such a thing).
> > >
> > > --
> > > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D
>

