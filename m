Return-Path: <linux-pci+bounces-37507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9B2BB5EFD
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 07:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D5619E6628
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 05:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9425D1D2F42;
	Fri,  3 Oct 2025 05:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPpaWhpu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7D186284
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 05:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759468658; cv=none; b=kckhCYHZc5Yt7DvyyapGvj2cCN9ZT2h8s1iNSRStrgW8rBGtJu/eXSuILblfKOgmXGOEOsHjs6TL4TKFm9Dn/ydQYFFBDZBTt8vyUk/JB5aXfX6lKvGMoMvVT52dtxpE+pEihLqtYbGcEJUjM3Gb9Pj/2Fru1DTkbtaIoBBPxk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759468658; c=relaxed/simple;
	bh=Z2Y81LlUFwk3gxOXZJLXdqOFOiD2/v2QqzTaop2dMaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAK9UeBdJfYHyigOMPRWM9JAMKjBTAEq6m5pdtudO2sbarX4a8bCsjXF4cxEDtdjYp/kGJDLJe81G3CxvljFg/SuXgNPrdSngnEayg1McxNsigbz8wZZ98peKXzVH/baCnUHAu6F43vmWQjoFgfWNgRQ1cG3+MiwPgBusKJ6nq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPpaWhpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F810C19423
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 05:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759468658;
	bh=Z2Y81LlUFwk3gxOXZJLXdqOFOiD2/v2QqzTaop2dMaA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kPpaWhpuHUOSOwga8bn3D88eChRUTxdUtq7d96QK4F0rn4MpqFzuVePQVlXZ6E0DA
	 9vEfpazvjCrC/h037lBWgKM066PegzaBTaEhNEM1+QLvSKjrfvUhYNM1ZdmkVX1BxW
	 O3pRdiF9PjgZ8A6f12xtZjR76KwUxZM34OBI2Z+EDWAETgAhGN3AhwQIRiOP8JT6CV
	 Q6EEcBUh19ttdSsVGpqoZBw1Y9P/s5pq8ckPyShEYlLYpF+XvdeVSi/Y91NxisuF0d
	 JAb7HiBBB8jpKsvnFgSZv4f9DrdLJpSQEHNYPVATUP3+KF4/uF+fI1x9eg6QdtuctE
	 t10T3R6n3TaWA==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-749399349ddso24784637b3.3
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 22:17:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtXhR8pNHDi/EvbDSjSi71IlirWi3TdGAehugUeFSUyoVTwOSfrkLj0jsk6g9I3NcNdxPgbwkITWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+QWuGPLSTdxt3RVWCRXi01HKypc+ziVOIHrH4ziGXyFb5/tgY
	ycm8vBa+AtqIRmy6LBfdIu/gppkVIJdOgHxc40ikE7vbGibGOYl7Uac/sd1wH0BWPXpA1DeCib/
	68lHRBJJpdvde3mghOMbIz8kEf5/g5rSB/VAULvztEA==
X-Google-Smtp-Source: AGHT+IGdBlneGZHjagqqDS29B/yex75iQO6mqALt9p/66aApGavg9sp5v0xUJ6Ye4R3Dseu8qf9L+JPbG2wVcgjpxcQ=
X-Received: by 2002:a53:c5c5:0:b0:636:fd5:ed02 with SMTP id
 956f58d0204a3-63b9a0f2c80mr1357439d50.45.1759468657232; Thu, 02 Oct 2025
 22:17:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org> <20250929174831.GJ2695987@ziepe.ca>
 <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
 <20250930163837.GQ2695987@ziepe.ca> <aN7KUNGoHrFHzagu@google.com>
 <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com> <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com>
In-Reply-To: <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 2 Oct 2025 22:17:25 -0700
X-Gmail-Original-Message-ID: <CACePvbXheW_GGiyc5sN3SnEkCVVeNH4UvMORtMf5rZhCp_4OLg@mail.gmail.com>
X-Gm-Features: AS18NWAkHHcZteEE5y59KN1WzuX4-SFuUuOtF44jobT37gFzG7sC2OkctJb4CUs
Message-ID: <CACePvbXheW_GGiyc5sN3SnEkCVVeNH4UvMORtMf5rZhCp_4OLg@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
To: David Matlack <dmatlack@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 2:31=E2=80=AFPM David Matlack <dmatlack@google.com> =
wrote:
>
> On Thu, Oct 2, 2025 at 1:58=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote=
:
> >
> > On Thu, Oct 2, 2025 at 11:54=E2=80=AFAM David Matlack <dmatlack@google.=
com> wrote:
> > > > Then don't do generic devices until we get iommufd done and you hav=
e a
> > > > meaningful in-tree driver to consume what you are adding.
> > >
> > > I agree with Jason. I don't think we can reasonably make the argument
> > > that we need this series until we have actualy use-cases for it.
> > >
> > > I think we should focus on vfio-pci device preservation next, and use
> > > that to incrementally drive whatever changes are necessary to the PCI
> > > and generic device layer bit by bit.
> >
> > The feedback I got for the PCI V1 was to make it as minimal as
> > possible. We agree preserving the BUS MASTER bit is the first minimal
> > step. That is what I did in the V2 phase I series. Only the bus
> > master. I think the pci-lu-test driver did demo the bus master bit, it
> > is not vfio yet. At least that was the plan shared in the upstream
> > alignment meeting.
>
> What do the driver callbacks in patch 3 and patches 5-8 have to do
> with preserving the bus master bit? That's half the series.

I was thinking the pcie driver is for preserving the bus master bit on
the bridge. I just realized that the actual bus master bit preserve is
at the pci_dev level. The pcie driver call back is effectively no op.
Yes, I can delete those from the series and not save driver data at
all. Points taken.
>
> >
> > > For example, once we a basic vfio-pci device preservation working, we
> > > can start thinking about how to handle when that device is a VF, and =
we
> > > have to start also preserving the SR-IOV state on the PF and get the =
PF
> >
> > SR-IOV is a much bigger step than the BUS Master bit. I recall at one
> > point in the upstream discussion meeting that we don't do SR-IOV as
> > the first step. I am not opposed to it, we need to get to vfio and
> > SR-IOV eventually. I just feel that the PCI + VFIO + SR-IOV will be a
> > much bigger series. I worry the series size is not friendly for
> > reviewers. I wish there could be smaller incremental steps digestible.
>
> SR-IOV is not a first step, of course. That's not what I said. I'm
> saying SR-IOV is future work that could justify some of the larger
> changes in this series (e.g. driver callbacks). So I am suggesting we
> revisit those changes when we are working on SR-IOV.

Just to confirm my understanding aligned with you. We remove the
driver callbacks in PCI series until the vfio SR-IOV to add them back.

> > > driver involved in the process. At that point we can discuss how to
> > > solve that specific problem. Maybe the solution will look something l=
ike
> > > this series, maybe it will look like something else. There is open
> > > design space.
> >
> > Yes doable, just will delay the LUO/PCI series by a bit and a much
> > bigger series.
>
> There will not be one "LUO/PCI series". There will be many incremental st=
eps.

Oh, that is good then. I can still keep the PCI series as one incremental s=
tep.

>
> >
> > > Without approaching it this way, I don't see how we can't reasonably
> > > argue that anything in this series is necessary. And I suspect some
> > > parts of this series truly are unnecessary, at least in the short ter=
m.
> >
> > You have me on the double negatives, always not very good at those.
> > If the bigger series is what we want, I can do that. Just will have
> > some latency to get the VFIO.
>
> Oops, typo on my end. I meant "I don't see how we _can_ reasonably
> argue". I am saying we don't have enough justification (yet) for a lot
> of the code changes in this series.

Ack for removing driver callbacks in this series.

> > > In our internal implementation, the only dependent device that truly
> > > needed to participate is the PF driver when a VF is preserved.
> > > Everything else (e.g. pcieport callbacks) have just been no-ops.
> >
> > Your VF device does not need to preserve DMA? If you want to preserve
> > DMA the bus master bit is required, and the pcieport driver for the
> > PCI-PCI bridge is also required. I am not sure pure VF and PF without
> > any DMA makes practical sense.
>
> I'm saying the only drivers that actually needed to implement Live
> Update driver callbacks have been vfio-pci and PF drivers. The
> vfio-pci support doesn't exist yet upstream, and we are planning to
> use FD preservation there. So we don't know if driver callbacks will
> be needed for that. And we don't care about PF drivers until we get to
> supporting SR-IOV. So the driver callbacks all seem unnecessary at
> this point.

Ack.

>
> I totally agree we need to avoid clearing the bus master bit. Let's
> focus on that.

Ack.

Chris

