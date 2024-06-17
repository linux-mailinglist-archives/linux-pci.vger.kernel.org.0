Return-Path: <linux-pci+bounces-8898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEBB90BFD7
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 01:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFAA281578
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 23:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51E71991CA;
	Mon, 17 Jun 2024 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igel-co-jp.20230601.gappssmtp.com header.i=@igel-co-jp.20230601.gappssmtp.com header.b="i4h8a0/j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE86DDA6
	for <linux-pci@vger.kernel.org>; Mon, 17 Jun 2024 23:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718667683; cv=none; b=U0AZb8ZNE7erNyN4GPEC2GoCt64gqwiR06sw0qM3Osa9vczkUVab4c/OfoMPMHa58qBo42QA0JsWeuZlH7xuk5i9YXXRS0ZM/72H7+c1ebt5I+toLO7Jph3HE/wlKSGRbk9mjXQIbitWSdu0LeWnEjFWN2p9PnOTNxZ2mY5KV0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718667683; c=relaxed/simple;
	bh=EGhZKCLc8GCsyFE0K97AbCX92rQpazxSUjuv0Ul1A0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JO4ye6J0FhfqPw2+Pb/5AKQSreU489yrjn02QViybvY35xlL2yL0jZbGtiq6RmR8b0pRxuLIKoWyAJTvmWHvMmBYoFL/nL5VgZxs3ASxEUCPtIKIIMt5UdcPJJVlv/8C3dmPMJD+0UV36k6lZXONin5YjKami/qbCpxsKxENkoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp; spf=pass smtp.mailfrom=igel.co.jp; dkim=pass (2048-bit key) header.d=igel-co-jp.20230601.gappssmtp.com header.i=@igel-co-jp.20230601.gappssmtp.com header.b=i4h8a0/j; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igel.co.jp
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-80b7699abcaso1368713241.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Jun 2024 16:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1718667680; x=1719272480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezjr4vOTDpa5tlXOg2IPrvZ97jwXmLsTTeegkWPsjjE=;
        b=i4h8a0/jTlSqm5BygRdNK4uLt1zvm86178dj2O3hhtJb9exu6YBlHiA7TNcruDfzBP
         Vg+tyXAOklGzGewv3rpgxD0faUgPY+DEZU7yqGwTzS1jQSyafQOh/z+MQRoFjL3bGo3J
         46RNzJ3RYd9w6NucDzmx5yPPQIF0nYbG65hh2MQkRg8MEDvJzgqe5laVhjjhbkxVgQ1K
         C9+xXpfaedT0WR7cyHz0zynrmQObQXYABY2/NFNmu9Ozaw5jEoFUSi/rG59ZZKfPRYnX
         r9vW/Bq9aB2+EzeSsADJdEKFq9yPmg1NXk82R2an9QWqceTCdQq18Ltjxo4HmJdmRXDQ
         9Gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718667680; x=1719272480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezjr4vOTDpa5tlXOg2IPrvZ97jwXmLsTTeegkWPsjjE=;
        b=lsPdmg70m9/sANtkXO1k1IIPtyiJLZYzrcRCqZBT/Om6lX4HSuoCOp1NnWh9+exnRE
         4xP1je3RRBru5ZN/zU+XTZ6YHNv2OBsNyWFwErbtxi+6vYgtgeyVXHvrsqAPO/5iLZGN
         W0UTmwREG445e7cLiUAD0NJGTgUFabgOhDgiNNqcNe8SWaX711Uq0t4JF6p8o5FvLeGC
         XCN9NNh16Jg8KMEWCz5HqDqv2REbYWiB7J2cI3NNwuznGOSFNvo5LilcBUoXXRLDb7e9
         izaYHr0KP552wrk5Nh3qDr1P3AiNZY3YDvFXVbs01Q5akQmLPM42bK1UdOM32RGlArjT
         ypOA==
X-Forwarded-Encrypted: i=1; AJvYcCVjRMc6+aSgS3tJbAG0Qk3DgwSsKJuc8vNtAmlZC1WTmIitSdm3F5Yd/FX1TL55sBFllAfTPPzJ9291eRR7ytfLMFdum9cYTllq
X-Gm-Message-State: AOJu0Yw4UDuOTdcMFtrL0WDpko8dZYjD1ZTewxv+WIM7KPoDb5hLRUJj
	Z70OQUcw/4qKqUfMD2liFswcD6ex6oKa24m8eSJQz/tRFmKWw0DJ2SNlT+ur+djWUWE0Mi+cu0U
	agH0ZeuuelN8fH6dSB/vq5FeXzjIUa7Q1m15e5w==
X-Google-Smtp-Source: AGHT+IGCgko3dsG3RDOkEu9eXynGhaJ1dXjxNzPfiQTSWcQAxhegQKdCUwWdN5c+CVRDaodxxBKvr7orivmk/rM0Jac=
X-Received: by 2002:a67:cf89:0:b0:48c:55b9:e9f with SMTP id
 ada2fe7eead31-48dae3e2d13mr10931067137.33.1718667680251; Mon, 17 Jun 2024
 16:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad> <20240520090809-mutt-send-email-mst@kernel.org>
 <20240614095033.GA59574@thinkpad>
In-Reply-To: <20240614095033.GA59574@thinkpad>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Tue, 18 Jun 2024 08:41:09 +0900
Message-ID: <CANXvt5ojosFbt60Gcfym1DX96W7SiX4X15dMGdSCVEPhUTpk=w@mail.gmail.com>
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Let's clarify the situation.

The Virtio device and driver are not working properly due to a
combination of the following reasons:

1. Regarding VIRTIO_F_ACCESS_PLATFORM:
- The modern spec includes VIRTIO_F_ACCESS_PLATFORM, which allows
Physical DMAC to be used.
- This feature is not available in the legacy spec.

2. Regarding Virtio PCIe Capability:
- The modern spec requires Virtio PCIe Capability.
- In some environments, Virtio PCIe Capability cannot be provided.

Ideas to solve this problem:
1. Introduce an ACCESS_PLATFORM-like flag in the legacy spec:
There are some unused bits, but it may be difficult to make changes to
the legacy spec at this stage.

2. Mani's Idea:
I think it is best to add support for modern virtio PCI device to make
use of IOMMU. Legacy devices can continue to use physical address.

The meaning of "Legacy devices can continue to use physical address"
is not fully understood. @mani Could you explain more?

3. Wait until the HW supports the modern spec:
This depends on the chip vendor.

Option 3 is essentially doing nothing, so it would be preferable to
consider other ideas.

Best,
Shunsuke

2024=E5=B9=B46=E6=9C=8814=E6=97=A5(=E9=87=91) 18:50 Manivannan Sadhasivam <=
mani@kernel.org>:
>
> On Mon, May 20, 2024 at 09:22:54AM -0400, Michael S. Tsirkin wrote:
> > On Thu, May 16, 2024 at 02:59:13PM +0200, Manivannan Sadhasivam wrote:
> > > On Thu, May 16, 2024 at 01:38:40PM +0900, Shunsuke Mie wrote:
> > > > Hi virtio folks,
> > > >
> > >
> > > You forgot to CC the actual Virtio folks. I've CCed them now.
> > >
> > > > I'm writing to discuss finding a workaround with Virtio drivers and=
 legacy
> > > > devices with limited memory access.
> > > >
> > > > # Background
> > > > The Virtio specification defines a feature (VIRTIO_F_ACCESS_PLATFOR=
M) to
> > > > indicate devices requiring restricted memory access or IOMMU transl=
ation. This
> > > > feature bit resides at position 33 in the 64-bit Features register =
on modern
> > > > interfaces. When the linux virtio driver finds the flag, the driver=
 uses DMA
> > > > API that handles to use of appropriate memory.
> > > >
> > > > # Problem
> > > > However, legacy devices only have a 32-bit register for the feature=
s bits.
> > > > Consequently, these devices cannot represent the ACCESS_PLATFORM bi=
t. As a
> > > > result, legacy devices with restricted memory access cannot functio=
n
> > > > properly[1]. This is a legacy spec issue, but I'd like to find a wo=
rkaround.
> > > >
> > > > # Proposed Solutions
> > > > I know these are not ideal, but I propose the following solution.
> > > > Driver-side:
> > > >     - Implement special handling similar to xen_domain.
> > > > In xen_domain, linux virtio driver enables to use the DMA API.
> > > >     - Introduce a CONFIG option to adjust the DMA API behavior.
> > > > Device-side:
> > > > Due to indistinguishability from the guest's perspective, a device-=
side
> > > > solution might be difficult.
> > > >
> > > > I'm open to any comments or suggestions you may have on this issue =
or
> > > > alternative approaches.
> > > >
> > > > [1] virtio-net PCI endpoint function using PCIe Endpoint Framework,
> > > > https://lore.kernel.org/lkml/54ee46c3-c845-3df3-8ba0-0ee79a2acab1@i=
gel.co.jp/t/
> > > > The Linux PCIe endpoint framework is used to implement the virtio-n=
et device on
> > > > a legacy interface. This is necessary because of the framework and =
hardware
> > > > limitation.
> > > >
> > >
> > > We can fix the endpoint framework limitation, but the problem lies wi=
th some
> > > platforms where we cannot write to vendor capability registers and st=
ill have
> > > IOMMU.
> > >
> > > - Mani
> >
> > What are vendor capability registers and what do they have to do
> > with the IOMMU?
> >
>
> Virtio spec v1.2, sec 4.1.4 says,
>
> "Each structure can be mapped by a Base Address register (BAR) belonging =
to the
> function, or accessed via the special VIRTIO_PCI_CAP_PCI_CFG field in the=
 PCI
> configuration space.
>
> The location of each structure is specified using a vendor-specific PCI
> capability located on the capability list in PCI configuration space of t=
he
> device."
>
> So this means the device has to expose the virtio structures through vend=
or
> specific capability isn't it?
>
> And only in that case, it can expose VIRTIO_F_ACCESS_PLATFORM bit for mak=
ing
> use of IOMMU translation.
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

