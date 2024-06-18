Return-Path: <linux-pci+bounces-8914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D91E90CFD7
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 15:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375261C23527
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 13:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71455161305;
	Tue, 18 Jun 2024 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igel-co-jp.20230601.gappssmtp.com header.i=@igel-co-jp.20230601.gappssmtp.com header.b="Q7EBPoBI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2EA161337
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715115; cv=none; b=UVdwZLoQbciCYWuFLue/5XHQRYkLxImWzuvplljzHTD2UeA8I9zR05F/1WZ4EVLoOaHLVD6BDdgPsIyYhOVfiTzPvtKAb2A5QZwFZ7WsCOkzfnGcCJF3e9mQpYRBxnea/+EWL6v3FhKbmCRuq024NXNlY2ojnBb5ScKjSPWIazE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715115; c=relaxed/simple;
	bh=XHre21X9SwCqotdXW8/lphzofkaGVwsXiWQNcSyjcfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuBe9XfuRLU38FhHxB13+Oxwk6N2kCrc3hHM9Uua4n5nmPtNThAhsS1305phyowyBeNnyaFC1YGeFAhpNDAUeb9YR8s/Fe+0Re41MIUQVPLzCyEoDJBk7B9Nf8mBNDd9T7xJabiPjiVtK37T8XoAmoVjYqdbj0ln0xpFaGe6LFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp; spf=pass smtp.mailfrom=igel.co.jp; dkim=pass (2048-bit key) header.d=igel-co-jp.20230601.gappssmtp.com header.i=@igel-co-jp.20230601.gappssmtp.com header.b=Q7EBPoBI; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igel.co.jp
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-48d7a81a594so2153755137.2
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 05:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1718715112; x=1719319912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hpl86i4haxOVUtbofDOWEJznXKEeJqry7m19gSTHFGs=;
        b=Q7EBPoBIZlgUnNQXutxpyZn55e1d4CeTT/FxSH1YN0gfJ/BNFhuiO95gGqAXNKaQGk
         9dWmTJNR9kVHlJZvgyeTetGB6eJa9xdtbqJvAhOMZ/eOUkPQnlYQzt4kKwk4pZUvChNk
         GWqcEOwOhVeMvpXeeeDCU3HzCNnSw228FWUDQ6BYHdFlzheFk2zzQA52yF08L09yn7o+
         Leb0qG446ESf0ivV87ofkphIpeF+zam3jOooWHVukwD/LOmUBwJBVZIbIwgIk1vvf1Vy
         UNRErZ4lhTJUOO2jSN3Mz1+JNKXo/1J4Ao13JS6L2prqA4p2bIqvdu2LtML2+buaosYA
         GxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718715112; x=1719319912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hpl86i4haxOVUtbofDOWEJznXKEeJqry7m19gSTHFGs=;
        b=YmB5wKLk+kLOBKg7OZ+aYWXHJcTuvh9rUCBX74yNQ47plTJ+sKB0986k+z3+/QQ0+x
         wDkzPnQFoXwCVRacxweC7N3UL/VIIN8EhgllEesM+hfEuXu/itzUE4E1f1DMOeISGyQC
         53NpInguwKTJfau6CAUvMe7rR2nv+yxaKr+UXBiviqAzcPfOUdp+QdcvLhMdXByscaZ/
         Ye96DPbBekYgh8CvsasyTn1bktlteG66idKs12CK74x/FSyjHxuJh23Q8Oe9ZM3CHcaa
         Fq/G+knavDpBfKYEXUGnjOIcCEjVjJ1fS3NiSvNTzJsB3/weohDQJYYQhMbs5Xm9pwc9
         JBhg==
X-Forwarded-Encrypted: i=1; AJvYcCVSzu1b3xESt13Px8ffE5retn/qu88EuNdx2uBXpywx/OdAWTL/4WnweyveXGfkO96vCtuuUVquN5s/L5v4HzkZdLi+OiG7u/JS
X-Gm-Message-State: AOJu0YxHvPNF3tLOWZK9/vbp9ulPJE52szix0Y/nqxCmEg0bMVUQcwOV
	p2SuQuXIszpkVPtsGAgz99k0Z6he81nFmRpppuG4fGtfAky2pblYMtTcOZnSucp/i345+4wA2xB
	N5A1k/p/rJvuph2LdgFoEJMq3XGDX2n+CIS2H+g==
X-Google-Smtp-Source: AGHT+IHM2rE+8UWJqT3TFlQ4BLez3LcYyKN7Pm0k6QaOKuR+2xg82e3ooeA624IgBFTHiPK5E7zdlJDiyhuVx0Njf5w=
X-Received: by 2002:a05:6102:32d4:b0:48c:45a8:a3b2 with SMTP id
 ada2fe7eead31-48dae3ce706mr15039239137.24.1718715112334; Tue, 18 Jun 2024
 05:51:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad> <20240520090809-mutt-send-email-mst@kernel.org>
 <20240614095033.GA59574@thinkpad> <CANXvt5ojosFbt60Gcfym1DX96W7SiX4X15dMGdSCVEPhUTpk=w@mail.gmail.com>
 <20240618054115-mutt-send-email-mst@kernel.org> <CANXvt5psZAkEOJtxO250n6vjZTK7as-F-4qr1Rc3awZsmqWCpQ@mail.gmail.com>
 <20240618061705-mutt-send-email-mst@kernel.org> <CANXvt5pDjvVwFLS3p0a4hx1-MUJGsKHnpEsjejYUcmvTeKyFmg@mail.gmail.com>
 <20240618064231-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240618064231-mutt-send-email-mst@kernel.org>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Tue, 18 Jun 2024 21:51:41 +0900
Message-ID: <CANXvt5pbdsSMc9C-nV0MiOAJPVyxXKu5otwLp2yopqBdNLS26A@mail.gmail.com>
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B46=E6=9C=8818=E6=97=A5(=E7=81=AB) 19:47 Michael S. Tsirkin <mst=
@redhat.com>:
>
> On Tue, Jun 18, 2024 at 07:40:34PM +0900, Shunsuke Mie wrote:
> > 2024=E5=B9=B46=E6=9C=8818=E6=97=A5(=E7=81=AB) 19:33 Michael S. Tsirkin =
<mst@redhat.com>:
> > >
> > > On Tue, Jun 18, 2024 at 07:15:47PM +0900, Shunsuke Mie wrote:
> > > > Thank you for your response.
> > > >
> > > > 2024=E5=B9=B46=E6=9C=8818=E6=97=A5(=E7=81=AB) 18:47 Michael S. Tsir=
kin <mst@redhat.com>:
> > > > >
> > > > > On Tue, Jun 18, 2024 at 08:41:09AM +0900, Shunsuke Mie wrote:
> > > > > > Let's clarify the situation.
> > > > > >
> > > > > > The Virtio device and driver are not working properly due to a
> > > > > > combination of the following reasons:
> > > > > >
> > > > > > 1. Regarding VIRTIO_F_ACCESS_PLATFORM:
> > > > > > - The modern spec includes VIRTIO_F_ACCESS_PLATFORM, which allo=
ws
> > > > > > Physical DMAC to be used.
> > > > > > - This feature is not available in the legacy spec.
> > > > >
> > > > > ... because legacy drivers don't set it
> > > > >
> > > > > > 2. Regarding Virtio PCIe Capability:
> > > > > > - The modern spec requires Virtio PCIe Capability.
> > > > >
> > > > > It's a PCI capability actually. People have been asking
> > > > > about option to make it a pcie extended capability,
> > > > > but no one did the spec, qemu and driver work, yet.
> > > > >
> > > > > > - In some environments, Virtio PCIe Capability cannot be provid=
ed.
> > > > >
> > > > > why not?
> > > > PCIe Endpoint Controller chips are available from several vendors a=
nd allow
> > > > software to describe the behavior of PCIe Endpoint functions. Howev=
er, they
> > > > offer only limited functionality. Specifically, while PCIe bus comm=
unication is
> > > > programmable, PCIe Capabilities are fixed and cannot be made to sho=
w as
> > > > virtio's.
> > >
> > > Okay. So where could these structures live, if not in pci config?
> > What does "these structures" refer to? PCIe Capabilities? virtio config=
s?
>
> Virtio uses a bunch of read only structures that look like this:
>
> struct virtio_pci_cap {
>
>         ..... [skipped, specific to pci config caps] ...
>
>         u8 cfg_type;    /* Identifies the structure. */
>         u8 bar;         /* Where to find it. */
>         u8 id;          /* Multiple capabilities of the same type */
>         u8 padding[2];  /* Pad to full dword. */
>         le32 offset;    /* Offset within bar. */
>         le32 length;    /* Length of the structure, in bytes. */
> };
>
>
> The driver uses that to locate parts of device interface it
> later uses.
>
>
> Per spec, they are currently in pci config, you are saying some devices
> can't have this data in pci config - is that right? Where yes?
I understood. The configuration structure is in the space that is
indicated by BAR0.
Follows the instructions in the spec:
```
4.1.4.10 Legacy Interfaces: A Note on PCI Device Layout
Transitional devices MUST present part of configuration registers in a
legacy configuration structure in BAR0 in the first I/O region of the
PCI device, as documented below.
...
```

>
> > > --
> > > MST
> > >
>

