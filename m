Return-Path: <linux-pci+bounces-10037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3AC92C8E1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 05:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59EC31F2329A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 03:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA1E17BDA;
	Wed, 10 Jul 2024 03:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwsEFc0B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782FD282F1;
	Wed, 10 Jul 2024 03:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720580681; cv=none; b=lJ5LGBcaCNtOeBOnvpG8i1hjxIQGtTg6C9YK03PWAQOcRmAIu6jtuo0S7u44Qr6KqlJWgh7ZCcoaqXNjDjt1nGs19g//BFyJwsitRslHAoCvIgwGomRk1qz3j6rLzEpCay2BVAw2cqX/riM2/tc3CqXMZ9qHmpAyp1lgrQ/yf/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720580681; c=relaxed/simple;
	bh=AQz3Cv2NIz7LkfUyRe1/U1+XxUvl5V1K9MXenuYDXR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VbYkSRxF3dvabE4anDmYKq15rQkcnljzM05nUlACZC1aTw7N7Mc/iAAxo6n5LO6gD16T8K+f1hpvh7NIzZAsY8n46n7d8sFBTiEpfydYCRGbPCGXlJ1ySjeJgAkyWDDIEu2dZbVGs1kUL/J8/HAzQVu3OHvAxL6yvVs6Ql6+qBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwsEFc0B; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111b0so4004359a12.3;
        Tue, 09 Jul 2024 20:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720580678; x=1721185478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiRh6FzC2PDiy7SQD4Z/jXEccHUb8k/3zJYxkqcVVSE=;
        b=lwsEFc0BvtsCqDoX+NY6I93UDOSFlR7lV6BuU4SXTrCB0hu8+Hlyl8JxfVI4NF/rQC
         OdqR4Ie8v9AdlZh1GKow0m1+uMDw9P2EmC/h+H9Hduq9aK/tyOvEvvMvUsobyxektG/y
         sgCB0aVl1DH98guVAF1A/jELa88IVJK3hYOckl/tks3kTS8XjiBvrBVNNlF6qgL618FE
         G9Gh8xVTli8ViCv2L/MLOpI5dMA1IJYAb7/JpZtnUEb9GnecViDdM/ys1qVo9yuJe0jp
         RMTF3Rl6sxuiqtp9Z9t+mzCk3ZmXzBYCimrvcUaU2gO33cGBNQCPiiNpC0mMGpuPtorq
         tZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720580678; x=1721185478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiRh6FzC2PDiy7SQD4Z/jXEccHUb8k/3zJYxkqcVVSE=;
        b=LD2vLGqdS0kJNraaPDVqheBDgoMJ9NOQsLygKDIrvXYgoTs6bCJc0Y0BpUYh3g7Qok
         aar/Mc/BpQc1FLi6FZjSzhIEgwrXW4ZD4vzwgh0nQRk9r8mz6PsJx9pkrEqhWQ5J9xD8
         e4eEvc6YoNTEBbKBNoZ7MKFkDklzjsEhM3lkylARwMPaUuWfeH+KI8X6JkvCZNGH/5WZ
         lfsRaz09t2A5jpasErG5iA56rfFaQ3sQovaz3sxyAXrFDVAmYyUqSg+it7matDP2hZTv
         p0Bk5UagkO5abMgvSsWMC0ZCzwKqZ0DPKqUa+ckpJ1w1bTcqRtKGFqRtIULbJ7nIf+u7
         l8Nw==
X-Forwarded-Encrypted: i=1; AJvYcCV+MwR2O6qVBNmGegtgDEAHYUjtlm04t8EwFO+kNIJ8SmO0QzAzQsnsWSyoEjhL1cTvdF49g5KNC+mjaXb4tAbOMxVNjHRztg1SQd/m4L1iB3hp/y6YxKr7ywEqKPgO7KN7
X-Gm-Message-State: AOJu0YwC6nDYqwNhxKEdPwf4g/36Uk0JoAQG2ar/yH77dq6dPUksupaF
	jihrLo/3W1kTbou8dsKKsjKw4XqRAHjXR82c0merZ5Fu4uS+XSh/dI7CxmeOMSyaG21fApzxvSC
	e4IfT1Jp53NUkfnxmDtRunCPPiZo=
X-Google-Smtp-Source: AGHT+IF862RAyNxSA5v3VYIjwsLWIcnaqFyQPzreBRTwDVIrswUJU+XfQifI+N27WlvTLi3Rpwz9+OQ3NvNuPGwp1Ks=
X-Received: by 2002:a50:fb0b:0:b0:57d:42f6:63fe with SMTP id
 4fb4d7f45d1cf-594bb773f1bmr3432494a12.22.1720580677246; Tue, 09 Jul 2024
 20:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612065315.2048110-1-chenhuacai@loongson.cn> <20240709212414.GA195866@bhelgaas>
In-Reply-To: <20240709212414.GA195866@bhelgaas>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Wed, 10 Jul 2024 11:04:24 +0800
Message-ID: <CAAhV-H6=nOf_cSv7K3hS3jdXsGcWR7Go30EFyZeqxYNQKhtH8A@mail.gmail.com>
Subject: Re: [PATCH] PCI: loongson: Add LS7A MSI enablement quirk
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, loongarch@lists.linux.dev, linux-pci@vger.kernel.org, 
	Jianmin Lv <lvjianmin@loongson.cn>, Xuefeng Li <lixuefeng@loongson.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org, 
	Sheng Wu <wusheng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bjorn,

On Wed, Jul 10, 2024 at 5:24=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Wed, Jun 12, 2024 at 02:53:15PM +0800, Huacai Chen wrote:
> > LS7A chipset can be used as a downstream bridge which connected to a
> > high-level host bridge. In this case DEV_LS7A_PCIE_PORT5 is used as the
> > upward port. We should always enable MSI caps of this port, otherwise
> > downstream devices cannot use MSI.
>
> Can you clarify this topology a bit?  Since DEV_LS7A_PCIE_PORT5
> apparently has a class of PCI_CLASS_BRIDGE_HOST, I guess that in PCIe
> terms, it is basically a PCI host bridge (Root Complex, if you prefer)
> that is materialized as a PCI Endpoint?
Now most of the existing LoongArch CPUs don't have an integrated PCIe
RC, instead they have HyperTransport controllers. But the latest CPU
(Loongson-3C6000) has an integrated PCIe RC and removed
HyperTransport.

LS7A bridge can work together with both old (HT) CPUs and new (PCIe)
CPUs. If it is connected to an old CPU, its upstream port is a HT
port, and DEV_LS7A_PCIE_PORT5 works as a normal downstream PCIe port.
If it is connected to a new CPU, DEV_LS7A_PCIE_PORT5 works as an
upstream port (the class code becomes PCI_CLASS_BRIDGE_HOST) and the
HT port is idle.

>
> I'm curious about what's going on here because the normal PCI MSI
> support should set PCI_MSI_FLAGS_ENABLE since it's completely
> specified by the spec, which says it controls whether *this function*
> can use MSI.
>
> But in this case PCI_MSI_FLAGS_ENABLE seems to have non-architected
> behavior of controlling MSI from *other* devices below this host
> bridge?  That's a little bit weird too because MSI looks like DMA to
> any bridges upstream from the device that is using MSI, and the Bus
> Master Enable bit in those bridges controls whether they forward those
> MSI DMA accesses upstream.  And of course the PCI core should already
> make sure those bridges have Bus Master Enable set when downstream
> devices use MSI.
In my opinion this is a hardware bug, when DEV_LS7A_PCIE_PORT5 works
as a host bridge, it should enable MSI automatically. But
unfortunately hardware doesn't behave like this, so we need a quirk
here.

Huacai

>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Sheng Wu <wusheng@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/pci/controller/pci-loongson.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/contro=
ller/pci-loongson.c
> > index 8b34ccff073a..ffc581605834 100644
> > --- a/drivers/pci/controller/pci-loongson.c
> > +++ b/drivers/pci/controller/pci-loongson.c
> > @@ -163,6 +163,18 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
> >                       DEV_LS7A_HDMI, loongson_pci_pin_quirk);
> >
> > +static void loongson_pci_msi_quirk(struct pci_dev *dev)
> > +{
> > +     u16 val, class =3D dev->class >> 8;
> > +
> > +     if (class =3D=3D PCI_CLASS_BRIDGE_HOST) {
> > +             pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &=
val);
> > +             val |=3D PCI_MSI_FLAGS_ENABLE;
> > +             pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, =
val);
> > +     }
> > +}
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT5, l=
oongson_pci_msi_quirk);
> > +
> >  static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bu=
s)
> >  {
> >       struct pci_config_window *cfg;
> > --
> > 2.43.0
> >

