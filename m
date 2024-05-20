Return-Path: <linux-pci+bounces-7654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CACF98C9B28
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 12:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F83E1F21B69
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 10:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949A3225AF;
	Mon, 20 May 2024 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igel-co-jp.20230601.gappssmtp.com header.i=@igel-co-jp.20230601.gappssmtp.com header.b="smTLNd5h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761A514285
	for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716200687; cv=none; b=AsTB/y4FE7e06e+NSgtN5o0zgg3SW2tXzTNq3efxGyaRIGvIqM0MIt78KkAjli/kiXOlsUbw0fd49Fz2ymdAJizUl/OpRuunSvlcrik95xqcz7mMtj7YNBCJucVJfzkUZ/jPdkA44R+dyX3pJiZU6QWkTVqQcXRJ052F+bYwUS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716200687; c=relaxed/simple;
	bh=6A0GF0XyBkHC3K8crOLyxfeIflMd1hxalZNXXZC0v2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPPFOwEgpM807HRwkzcfjlSg1a2NIn5X9DCrpOAMjq3F3eDi2s0aNz7c1UUqd4IUeQWBwB9KbVlwecz7/a5J2fZy2KqTqM1NM4oHZ2gKF6vbFf1v9hwhzTUsMA4EMbpwVx2SMrVA1agpTVDJvW9aIBWVEn338YnBI696xfvyVcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp; spf=pass smtp.mailfrom=igel.co.jp; dkim=pass (2048-bit key) header.d=igel-co-jp.20230601.gappssmtp.com header.i=@igel-co-jp.20230601.gappssmtp.com header.b=smTLNd5h; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igel.co.jp
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4df36a7a6f3so728675e0c.0
        for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 03:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1716200684; x=1716805484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYx1MYqKriQMaf8e5K+aZLI/jP8z9alvVTBfQskYD6k=;
        b=smTLNd5hDluDM0OlJbijxmwgSQAzFyI0PnkoAHsQN8oC32GzPgmCbyzrTa72gO65Pa
         7XTtcBIxfoaW3a734kEa1h7gGJGJ4v1RQ+rP1ayo4hgRx4l5lMZ8uLZh1spwpnGvH53F
         hutiy3nY8UR0BCe5bO1xl5DSfLQTaxr9M6ot5roG6Zuwsl884LSlW8sMCZJP/8YZQAEY
         1AovHrTpgBO+FtDsRHWtLBlRHwzwzaeirg6CDK+epDG/8f0TMHfGE5pZki9EPNmygXf2
         8YCDGaT/IhUIiJvzdKrSknZbvRVKzjSOYZ+1yyavwyIWf80iYu2LvFaFStAsn/PHz06C
         cczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716200684; x=1716805484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYx1MYqKriQMaf8e5K+aZLI/jP8z9alvVTBfQskYD6k=;
        b=iHS4oopS9sa1SbujvJWJHdpAS/gurrklWqI9/CUBmUeQR25VdDSSrX4vaapn6dpf62
         kpQ/eUwgNewt1yxNyRJeMq/Za3f7onVjFdKY8YQyk1RSfwJUjlxY0PcvHn3IKx1l1/dS
         7sKS/OYLapcn+zughL8piWZolGjVbrujbBYeKYdwodMWaS5eGJXbBXB7YdwaDErP7nS0
         werMvn7HRORmI+yWqx2zD71njoUxJVvYAmF6fkxD2EoImhPRLQi+6JeAyypSOpXWgNhS
         vhRkpe0isTpP1vLgWBZxKpaEMcWLx1xabofcG9KYqRAsNhXrFVKgS4c2ut7vBZfZNq6W
         OFfA==
X-Gm-Message-State: AOJu0YwaIJhL/dmXZ7xfsbZqcn85jBcHFUVPukdtIquH4MATPIoybu7P
	RCiGhapW6HiGZ1gzi85xooZF1hUO2cdyF2WAQ5zBRXdElQRzOAPUOqYJDUaCG8HZ3SOjh/s4Ftl
	JVcTxRYhIFzHBDR8KROEC5ddUqKmWGLWTOwe1Lw==
X-Google-Smtp-Source: AGHT+IHZYzTMr4tU5/8wKI+9VpalGfBtdoxBWlfNPxH+/8kN5nrKIHK4l87eO9LH8BVLZVy+9n42hB4h7V93qzAV43I=
X-Received: by 2002:a1f:ee4d:0:b0:4da:c69c:f5b2 with SMTP id
 71dfb90a1353d-4e16d8c3421mr3523381e0c.2.1716200683719; Mon, 20 May 2024
 03:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad>
In-Reply-To: <20240516125913.GC11261@thinkpad>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Mon, 20 May 2024 19:24:32 +0900
Message-ID: <CANXvt5rQdhS5XBnHFmFiN=fPO975jQ8dosH0L0ZP_51dd6cXag@mail.gmail.com>
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, virtualization@lists.linux.dev, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B45=E6=9C=8816=E6=97=A5(=E6=9C=A8) 21:59 Manivannan Sadhasivam <=
mani@kernel.org>:
>
> On Thu, May 16, 2024 at 01:38:40PM +0900, Shunsuke Mie wrote:
> > Hi virtio folks,
> >
>
> You forgot to CC the actual Virtio folks. I've CCed them now.
Oops. thank you.
> > I'm writing to discuss finding a workaround with Virtio drivers and leg=
acy
> > devices with limited memory access.
> >
> > # Background
> > The Virtio specification defines a feature (VIRTIO_F_ACCESS_PLATFORM) t=
o
> > indicate devices requiring restricted memory access or IOMMU translatio=
n. This
> > feature bit resides at position 33 in the 64-bit Features register on m=
odern
> > interfaces. When the linux virtio driver finds the flag, the driver use=
s DMA
> > API that handles to use of appropriate memory.
> >
> > # Problem
> > However, legacy devices only have a 32-bit register for the features bi=
ts.
> > Consequently, these devices cannot represent the ACCESS_PLATFORM bit. A=
s a
> > result, legacy devices with restricted memory access cannot function
> > properly[1]. This is a legacy spec issue, but I'd like to find a workar=
ound.
> >
> > # Proposed Solutions
> > I know these are not ideal, but I propose the following solution.
> > Driver-side:
> >     - Implement special handling similar to xen_domain.
> > In xen_domain, linux virtio driver enables to use the DMA API.
> >     - Introduce a CONFIG option to adjust the DMA API behavior.
> > Device-side:
> > Due to indistinguishability from the guest's perspective, a device-side
> > solution might be difficult.
> >
> > I'm open to any comments or suggestions you may have on this issue or
> > alternative approaches.
> >
> > [1] virtio-net PCI endpoint function using PCIe Endpoint Framework,
> > https://lore.kernel.org/lkml/54ee46c3-c845-3df3-8ba0-0ee79a2acab1@igel.=
co.jp/t/
> > The Linux PCIe endpoint framework is used to implement the virtio-net d=
evice on
> > a legacy interface. This is necessary because of the framework and hard=
ware
> > limitation.
> >
>
> We can fix the endpoint framework limitation, but the problem lies with s=
ome
> platforms where we cannot write to vendor capability registers and still =
have
> IOMMU.
I agree, this is a problem caused by the inability to set the
capability. I'm not sure, but are there any chips that support this?
Also, I wasn't aware of the IOMMU issue. I thought that if the Linux
DMA subsystem could handle IOMMU properly, there wouldn't be any
problems. Is that incorrect?

Shunsuke,
Best
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

