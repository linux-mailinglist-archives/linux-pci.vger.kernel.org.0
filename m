Return-Path: <linux-pci+bounces-18024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 975689EAED0
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 11:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A49416131C
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 10:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B1E210F5D;
	Tue, 10 Dec 2024 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hc7oKrvn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3B42080FE
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733828150; cv=none; b=LWK68LxIcCGmpqDG6kQB5+CXSjugE1ROVOuBb9HTAn3vdj/7e5Y0LURsSlmIk4dPUcByB3dgANuM3l7bI9FXluAE4/QIYgMbKGfPzeSqrmHndC5IS8DnsIIZYlKZ6h72gmGCH8LAwCb3bsK89ZXRkqWm7Trubr3KmfvPKwZteN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733828150; c=relaxed/simple;
	bh=dfXHaZApg1kAp8ngob6EwNugQ82l0HdC7g+rjbDHgZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AkXKm+dMMdhpCUrnaCLJuNrXw7aWAlMrrYGwNjxLPnCAdyis/ixuoZIaNj6bbN+ie8jeAqSjhyO+mf3ivs26IZyGBlpgbCjMQhbcCwuB7xjixn4exfeTh7ZD8jK9mlGUzqVxjfINn2yK5Okomrww6OeYP+BzeIdQFEvPHbFZUgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hc7oKrvn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434f09d18e2so29417075e9.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 02:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733828146; x=1734432946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfXHaZApg1kAp8ngob6EwNugQ82l0HdC7g+rjbDHgZQ=;
        b=Hc7oKrvnBTfMx1RQpq+fCnTOZlg0i9ATA2CqHmUpeNxhieXk7wOk9Gw3Ri3lgcrH+s
         /1wVD0iUIYF9oBI7ILjegYUwaWkPvNYqvZFCQFrudjwxLo2botBNKIB+XBcwzjO8jnwl
         2L9YRaN1+t7i/l6kZQExjq8S5kMyxGn+GDnsrJmReDJpkaico/uZvHDhkfV+F0rlfJOI
         cKSHFp1QDOyYi1VSjIxzR0b536+8Gh5K9Ug8n3mwzid0pfsouG3yKTdBSQjywmlyOgt2
         eE+RyOoMy/4VBvQIsU9HlfDwobRVFBlhw3qeRoujWLWo9mECA2ygXCyAWtjDT0ht1AeW
         iULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733828146; x=1734432946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfXHaZApg1kAp8ngob6EwNugQ82l0HdC7g+rjbDHgZQ=;
        b=NyyWLKahWiP44skA2wKXmIDo0dg7RoqU/bNvk6nGHL9E5UIVHnbFYcPM+gdZoG4U9k
         CFJXplOAqrxnFF6TttKHbLoU5KIDBgudI0ITYILVEo8WHgtQ7dOjpEkZlM6hijUPxJoL
         KWffWSbJNxOkg7JDD41DoWhJFDsm3kzgquQEHArK3mmlDuqR3ezAmNUZLBFgJCEyhQF9
         +GaD7YWO+JYKOEANfbs5bva9ZJ3r+8L9a1MoCcTF0O4TrxcoyasHeyBO0eIlboZ9pb12
         ZFwqaM4jN3Aw3hBIIqBFNxmL4Z1stwjwZXztZ2BuCDlZ6GIvVuqcHmZDdTjnnknls1I2
         QHSw==
X-Forwarded-Encrypted: i=1; AJvYcCU41NZhPco8JGP8QBT8JmB5haSkUDyBCvVX3ucE6GhzHeEK72rk6f+EoFokTm4EJCNjw71utIcwegA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw74BMrG2xFSB4fgAQapaC941wH13O3gfGbUrqZJ5T9t0tUbf/C
	ECmD3FSw/D+NLSmw4/oku9PLNqluwvcYJEQOWNITWUuJyfQLcgN0a/z4YCyOZMM8Fh/VxFzh12J
	WqDM7vg+hHVjlwma8aI0YLXR2GNanvwUntH/w
X-Gm-Gg: ASbGnct2jRAt+EtaKAdty9hT8q/T9E5ToOn3VybanLLq32amB0oNc7YeXckn0E1+wv+
	t7aRUx4pV0tTWtyUkCA545yt9Sv7ncePuWbWkO1htlNvtzbQDdlJyO0Wkr2gBAKDYxg==
X-Google-Smtp-Source: AGHT+IG0Y9INJmMgnj5Aq1qmzA2XI8kCQB+a+xINu5oEbG4VnKvTmmuaC9cO2DZywjG71233iorWGqYcrsutxnOfz+M=
X-Received: by 2002:a5d:64c6:0:b0:386:3213:5b9b with SMTP id
 ffacd0b85a97d-38632136068mr10993724f8f.43.1733828145989; Tue, 10 Dec 2024
 02:55:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205141533.111830-1-dakr@kernel.org> <20241205141533.111830-9-dakr@kernel.org>
 <CAH5fLgh6qgQ=SBn17biSRbqO8pNtSEq=5fDY3iuGzbuf2Aqjeg@mail.gmail.com> <Z1bKA5efDYxd8sTC@pollux.localdomain>
In-Reply-To: <Z1bKA5efDYxd8sTC@pollux.localdomain>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 10 Dec 2024 11:55:33 +0100
Message-ID: <CAH5fLgixvBWSf-3WDRj=Mxtn4ArQLqdKqMF0aSxyC6xVNPfTFQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/13] rust: pci: add basic PCI device / driver abstractions
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com, 
	j@jannau.net, fabien.parent@linaro.org, chrisi.schrefl@gmail.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:44=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Fri, Dec 06, 2024 at 03:01:18PM +0100, Alice Ryhl wrote:
> > On Thu, Dec 5, 2024 at 3:16=E2=80=AFPM Danilo Krummrich <dakr@kernel.or=
g> wrote:
> > >
> > > Implement the basic PCI abstractions required to write a basic PCI
> > > driver. This includes the following data structures:
> > >
> > > The `pci::Driver` trait represents the interface to the driver and
> > > provides `pci::Driver::probe` for the driver to implement.
> > >
> > > The `pci::Device` abstraction represents a `struct pci_dev` and provi=
des
> > > abstractions for common functions, such as `pci::Device::set_master`.
> > >
> > > In order to provide the PCI specific parts to a generic
> > > `driver::Registration` the `driver::RegistrationOps` trait is impleme=
nted
> > > by `pci::Adapter`.
> > >
> > > `pci::DeviceId` implements PCI device IDs based on the generic
> > > `device_id::RawDevceId` abstraction.
> > >
> > > Co-developed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >
> > > +/// The PCI device representation.
> > > +///
> > > +/// A PCI device is based on an always reference counted `device:Dev=
ice` instance. Cloning a PCI
> > > +/// device, hence, also increments the base device' reference count.
> > > +#[derive(Clone)]
> > > +pub struct Device(ARef<device::Device>);
> >
> > It seems more natural for this to be a wrapper around
> > `Opaque<bindings::pci_dev>`. Then you can have both &Device and
> > ARef<Device> depending on whether you want to hold a refcount or not.
>
> Yeah, but then every bus device has to re-implement the refcount dance we
> already have in `device::Device` for the underlying base `struct device`.
>
> I forgot to mention this in my previous reply to Boqun, but we even docum=
ented
> it this way in `device::Device` [1].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/rust/kernel/device.rs#n28

We could perhaps write a derive macro for AlwaysRefCounted that
delegates to the inner type? That way, we can have the best of both
worlds.

Alice

