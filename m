Return-Path: <linux-pci+bounces-10502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11680934DA3
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 15:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0D3285331
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 13:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B0313D516;
	Thu, 18 Jul 2024 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvDIHzT9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C88484E11;
	Thu, 18 Jul 2024 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721307696; cv=none; b=r9JpsyqCM0dOgcSnzDcg6IOfRgUlbgdYS9YXhxed4r96gVDmAqsrMEFFPeteUHymE4SOpaHvpEw7cCcLEULdzAJL5hqUHSYcZHMh91JVfi7lRYCBMF4rd51rK94vtGgCnetG9uF/gLdsXTouJz31ODfGslYXYWLRdJ/6teKUUXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721307696; c=relaxed/simple;
	bh=mdwJYjPNqTr+Ia0NODkdrX29A4qTgc/06aRYk2Io+dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWjedmQVr3qvWUOp87pt4Yll5dVAdXQ4+0KqoBdtNhM3b9bcoW03YnZIryCV6xRLmxplogE009PaI1vygUHDiyU531AUpMO1HIFC1XO6rn66TSe7PG06zAGaIrSK2NPplIhCHMpfSpfkU9ltNmt/BVQoDYDMyZfQKJHUS0lZ/D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvDIHzT9; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so924710a12.0;
        Thu, 18 Jul 2024 06:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721307693; x=1721912493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqj/azH3y0tVii1awb9kdff2TTuTT8XVCxNe0eEpg1s=;
        b=JvDIHzT90Xz+Fhzyxlowl0qadw20xSCb+TTrPGVWX+RdOAD+1I1fUxier+wrpC59KB
         lQXvrL5AIvmLSdQjGc+apWwUzkNMvdrSJKsGMgqWtA3J3SpBHztXXhNCtDviK3ysR8v1
         0tcEwflS+MjtEifCci0W1OHvQKpfX6rmHPkvcmf0avRPrKbkDk/RhOS+2ydnnr0WuDtD
         cr5q7PUJkmf3UfbcVkWOZ8PuQnvUq6OSwprfkVxh/UjCJP49akfzavnamAOab2PxN8fq
         ZzaeWjQ1cR+S+L88Xzy7eeIxGMs8vgJ9C7E7hqZRbqFr+q4jTK7kalXoiJV2HczPKrVH
         sY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721307693; x=1721912493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqj/azH3y0tVii1awb9kdff2TTuTT8XVCxNe0eEpg1s=;
        b=ug6o1pnrHfETOxXYczAExTkEwGo4zCu/dIblVVgoRjGDxXjtY/o02eUpjtU/GRDJtI
         V0emK75osWa4KrJpM2QR1uHuPWYvp9kOHaNT+uPUqeviRDMiAYY3mYYqP+1k86jOS86Z
         5l3eLKDYGDofvwIR1QzLYyjMUVFn4R3abwOONxSoqpkDGqyqyep+S9ugNOBwEj4BKUaK
         jIp+P2ZdHPPXS1nSuzrP32bbf4nKg+Ydc3Xqn+cWjI8BHc4QI5sF5rKujeLHu+TWp0T9
         JYvgdC3QX8Ar+0d6PDc6mkPZTSYLiJN2Lz689F8SBSOdCaZjyHrhDoyDaApFK9ogf8mm
         3SvA==
X-Forwarded-Encrypted: i=1; AJvYcCX/thlq5DmDhGkFkBYqHQ065fYreOgWqLnyzhiB76rwZvPIvRwTau+j3uSLDImrbe9HNkcOzqnmDGp5uihEgXxVZxn/pzAea8WrTPTc6tEmvpBQu+BApIHWy/+6Jx461cUX
X-Gm-Message-State: AOJu0YxDC9Irk/zHCNhoA1BJMlMXNE/alD8FgtD0ZNpJIOqZAf6f3Ycq
	sDy9Gf6pLb6KBqK6XfChlVaiJLkmP22iIPcBzdWsGy1VC5WgJv2johWHOqfGrjr7HpianB23m9n
	q630cpM1G76zuIWZLdC6zSlAuC/I=
X-Google-Smtp-Source: AGHT+IFXeGp9YUEHJoLa9UObvkczqZCDhS1G7x7XY5+3lN6j1NYoUFvk0Q9sAg6yiIKlDD4SCrb/Gx1lNR4Foyvw3dc=
X-Received: by 2002:a05:6402:40d5:b0:59e:a222:80f6 with SMTP id
 4fb4d7f45d1cf-5a05d0efa3emr3744381a12.27.1721307692110; Thu, 18 Jul 2024
 06:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhV-H6=nOf_cSv7K3hS3jdXsGcWR7Go30EFyZeqxYNQKhtH8A@mail.gmail.com>
 <20240710194830.GA255085@bhelgaas>
In-Reply-To: <20240710194830.GA255085@bhelgaas>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Thu, 18 Jul 2024 21:01:17 +0800
Message-ID: <CAAhV-H678eySqhLr8cYhCsrJqm1acFcRAFJY_dQOpEHkRLVAGQ@mail.gmail.com>
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

Sorry for the late reply.

On Thu, Jul 11, 2024 at 3:48=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Wed, Jul 10, 2024 at 11:04:24AM +0800, Huacai Chen wrote:
> > Hi, Bjorn,
> >
> > On Wed, Jul 10, 2024 at 5:24=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > >
> > > On Wed, Jun 12, 2024 at 02:53:15PM +0800, Huacai Chen wrote:
> > > > LS7A chipset can be used as a downstream bridge which connected to =
a
> > > > high-level host bridge. In this case DEV_LS7A_PCIE_PORT5 is used as=
 the
> > > > upward port. We should always enable MSI caps of this port, otherwi=
se
> > > > downstream devices cannot use MSI.
> > >
> > > Can you clarify this topology a bit?  Since DEV_LS7A_PCIE_PORT5
> > > apparently has a class of PCI_CLASS_BRIDGE_HOST, I guess that in PCIe
> > > terms, it is basically a PCI host bridge (Root Complex, if you prefer=
)
> > > that is materialized as a PCI Endpoint?
> >
> > Now most of the existing LoongArch CPUs don't have an integrated PCIe
> > RC, instead they have HyperTransport controllers. But the latest CPU
> > (Loongson-3C6000) has an integrated PCIe RC and removed
> > HyperTransport.
> >
> > LS7A bridge can work together with both old (HT) CPUs and new (PCIe)
> > CPUs. If it is connected to an old CPU, its upstream port is a HT
> > port, and DEV_LS7A_PCIE_PORT5 works as a normal downstream PCIe port.
> > If it is connected to a new CPU, DEV_LS7A_PCIE_PORT5 works as an
> > upstream port (the class code becomes PCI_CLASS_BRIDGE_HOST) and the
> > HT port is idle.
>
> What does lspci look like for both the old HT and the new PCIe CPUs?
When LS7A connect to HT,

00:00.0 Host bridge: Loongson Technology LLC Hyper Transport Bridge Control=
ler
00:00.1 Host bridge: Loongson Technology LLC Hyper Transport Bridge
Controller (rev 01)
00:00.2 Host bridge: Loongson Technology LLC Device 7a20 (rev 01)
00:00.3 Host bridge: Loongson Technology LLC Device 7a30
00:03.0 Ethernet controller: Loongson Technology LLC Device 7a13
00:04.0 USB controller: Loongson Technology LLC OHCI USB Controller (rev 02=
)
00:04.1 USB controller: Loongson Technology LLC EHCI USB Controller (rev 02=
)
00:05.0 USB controller: Loongson Technology LLC OHCI USB Controller (rev 02=
)
00:05.1 USB controller: Loongson Technology LLC EHCI USB Controller (rev 02=
)
00:07.0 Audio device: Loongson Technology LLC HDA (High Definition
Audio) Controller
00:08.0 SATA controller: Loongson Technology LLC Device 7a18
00:09.0 PCI bridge: Loongson Technology LLC Device 7a49
00:0d.0 PCI bridge: Loongson Technology LLC Device 7a49
00:0f.0 PCI bridge: Loongson Technology LLC Device 7a69
00:10.0 PCI bridge: Loongson Technology LLC Device 7a59
00:13.0 PCI bridge: Loongson Technology LLC Device 7a59
00:16.0 System peripheral: Loongson Technology LLC Device 7a1b
00:19.0 USB controller: Loongson Technology LLC Device 7a34
02:00.0 Non-Volatile memory controller: Shenzhen Longsys Electronics
Co., Ltd. SM2263EN/SM2263XT-based OEM NVME SSD (DRAM-less) (rev 03)
04:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Oland [Radeon HD 8570 / R5 430 OEM / R7 240/340 / Radeon 520
OEM] (rev 87)
04:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI]
Oland/Hainan/Cape Verde/Pitcairn HDMI Audio [Radeon HD 7000 Series]

-[0000:00]-+-00.0  0014:7a00
           +-00.1  0014:7a10
           +-00.2  0014:7a20
           +-00.3  0014:7a30
           +-03.0  0014:7a13
           +-04.0  0014:7a24
           +-04.1  0014:7a14
           +-05.0  0014:7a24
           +-05.1  0014:7a14
           +-07.0  0014:7a07
           +-08.0  0014:7a18
           +-09.0-[01]--
           +-0d.0-[02]----00.0  1d97:2263
           +-0f.0-[03]--
           +-10.0-[04]--+-00.0  1002:6611
           |            \-00.1  1002:aab0
           +-13.0-[05]--
           +-16.0  0014:7a1b
           \-19.0  0014:7a34

DEV_LS7A_PCIE_PORT5 is 00:13.0

When LS7A connect to PCIe,

00:00.0 Host bridge: Loongson Technology LLC Device 7a59
00:03.0 Ethernet controller: Loongson Technology LLC Device 7a13
00:04.0 USB controller: Loongson Technology LLC OHCI USB Controller (rev 02=
)
00:04.1 USB controller: Loongson Technology LLC EHCI USB Controller (rev 02=
)
00:05.0 USB controller: Loongson Technology LLC OHCI USB Controller (rev 02=
)
00:05.1 USB controller: Loongson Technology LLC EHCI USB Controller (rev 02=
)
00:06.0 Multimedia video controller: Loongson Technology LLC Device
7a25 (rev 01)
00:06.1 VGA compatible controller: Loongson Technology LLC Device 7a36 (rev=
 02)
00:06.2 Audio device: Loongson Technology LLC Device 7a37
00:07.0 Audio device: Loongson Technology LLC HDA (High Definition
Audio) Controller
00:08.0 SATA controller: Loongson Technology LLC Device 7a18
00:09.0 PCI bridge: Loongson Technology LLC Device 7a49
00:0a.0 PCI bridge: Loongson Technology LLC Device 7a39
00:0b.0 PCI bridge: Loongson Technology LLC Device 7a39
00:0c.0 PCI bridge: Loongson Technology LLC Device 7a39
00:0d.0 PCI bridge: Loongson Technology LLC Device 7a49
00:0f.0 PCI bridge: Loongson Technology LLC Device 7a69
00:10.0 PCI bridge: Loongson Technology LLC Device 7a59
00:16.0 System peripheral: Loongson Technology LLC Device 7a1b
00:17.0 ISA bridge: Loongson Technology LLC LPC Controller (rev 01)
00:19.0 USB controller: Loongson Technology LLC Device 7a34
00:1c.0 PCI bridge: Loongson Technology LLC Device 3c09
00:1d.0 IOMMU: Loongson Technology LLC Device 3c0f
00:1e.0 PCI bridge: Loongson Technology LLC Device 3c09
02:00.0 Ethernet controller: Device 1f0a:6801 (rev 01)
08:00.0 PCI bridge: Loongson Technology LLC Device 3c19
08:01.0 PCI bridge: Loongson Technology LLC Device 3c29
08:02.0 PCI bridge: Loongson Technology LLC Device 3c29
0c:00.0 PCI bridge: Loongson Technology LLC Device 3c19
0c:01.0 PCI bridge: Loongson Technology LLC Device 3c19
0c:04.0 IOMMU: Loongson Technology LLC Device 3c0f

-[0000:00]-+-00.0  0014:7a59
           +-03.0  0014:7a13
           +-04.0  0014:7a24
           +-04.1  0014:7a14
           +-05.0  0014:7a24
           +-05.1  0014:7a14
           +-06.0  0014:7a25
           +-06.1  0014:7a36
           +-06.2  0014:7a37
           +-07.0  0014:7a07
           +-08.0  0014:7a18
           +-09.0-[01]--
           +-0a.0-[02]----00.0  1f0a:6801
           +-0b.0-[03]--
           +-0c.0-[04]--
           +-0d.0-[05]--
           +-0f.0-[06]--
           +-10.0-[07]--
           +-16.0  0014:7a1b
           +-17.0  0014:7a0c
           +-19.0  0014:7a34
           +-1c.0-[08-0b]--+-00.0-[09]--
           |               +-01.0-[0a]--
           |               \-02.0-[0b]--
           +-1d.0  0014:3c0f
           \-1e.0-[0c-0e]--+-00.0-[0d]--
                           +-01.0-[0e]--
                           \-04.0  0014:3c0f

DEV_LS7A_PCIE_PORT5 becomes 00:00.0


Huacai

>
> With the old HT CPU, I imagine this:
>
>   [LS7A includes a HT port that doesn't appear as a PCI device and
>   basically implements a PCIe Root Complex]
>   00:00.0 Root Port to [bus 01-1f] (DEV_LS7A_PCIE_PORT5)
>
> With a new PCIe CPU, if DEV_LS7A_PCIE_PORT5 is a PCIe Upstream Port,
> it would be part of a switch, so I'm imagining something like this:
>
>   00:00.0 Root Port to [bus 01-1f] (integrated into Loongson-3C6000)
>   01:00.0 Upstream Port to [bus 02-1f] (DEV_LS7A_PCIE_PORT5)
>   02:00.0 Downstream Port to [bus 03-1f] (part of the LS7A switch)
>
> In both cases, 00:00.0 and 01:00.0 (DEV_LS7A_PCIE_PORT5) would be a
> Type 1 device that is enumerated as a PCI-to-PCI bridge, which would
> normally have a Class Code of 0x0604 (PCI_CLASS_BRIDGE_PCI).
>
> But you're saying DEV_LS7A_PCIE_PORT5 has a Class Code of
> PCI_CLASS_BRIDGE_HOST, which is 0x0600.  That would normally be a Type
> 0 device and would not have a secondary bus.
>
> > > I'm curious about what's going on here because the normal PCI MSI
> > > support should set PCI_MSI_FLAGS_ENABLE since it's completely
> > > specified by the spec, which says it controls whether *this function*
> > > can use MSI.
> > >
> > > But in this case PCI_MSI_FLAGS_ENABLE seems to have non-architected
> > > behavior of controlling MSI from *other* devices below this host
> > > bridge?  That's a little bit weird too because MSI looks like DMA to
> > > any bridges upstream from the device that is using MSI, and the Bus
> > > Master Enable bit in those bridges controls whether they forward thos=
e
> > > MSI DMA accesses upstream.  And of course the PCI core should already
> > > make sure those bridges have Bus Master Enable set when downstream
> > > devices use MSI.
> >
> > In my opinion this is a hardware bug, when DEV_LS7A_PCIE_PORT5 works
> > as a host bridge, it should enable MSI automatically. But
> > unfortunately hardware doesn't behave like this, so we need a quirk
> > here.
>
> I'm fine with the quirk to work around this issue.  But the commit log
> is confusing.
>
> > > > Cc: <stable@vger.kernel.org>
> > > > Signed-off-by: Sheng Wu <wusheng@loongson.cn>
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > >  drivers/pci/controller/pci-loongson.c | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/co=
ntroller/pci-loongson.c
> > > > index 8b34ccff073a..ffc581605834 100644
> > > > --- a/drivers/pci/controller/pci-loongson.c
> > > > +++ b/drivers/pci/controller/pci-loongson.c
> > > > @@ -163,6 +163,18 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON=
,
> > > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
> > > >                       DEV_LS7A_HDMI, loongson_pci_pin_quirk);
> > > >
> > > > +static void loongson_pci_msi_quirk(struct pci_dev *dev)
> > > > +{
> > > > +     u16 val, class =3D dev->class >> 8;
> > > > +
> > > > +     if (class =3D=3D PCI_CLASS_BRIDGE_HOST) {
> > > > +             pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAG=
S, &val);
> > > > +             val |=3D PCI_MSI_FLAGS_ENABLE;
> > > > +             pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLA=
GS, val);
> > > > +     }
> > > > +}
> > > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT=
5, loongson_pci_msi_quirk);
> > > > +
> > > >  static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus=
 *bus)
> > > >  {
> > > >       struct pci_config_window *cfg;
> > > > --
> > > > 2.43.0
> > > >
>

