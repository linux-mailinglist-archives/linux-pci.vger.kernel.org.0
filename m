Return-Path: <linux-pci+bounces-17868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3311F9E77E0
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 19:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B98284CC4
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 18:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ABC1FFC69;
	Fri,  6 Dec 2024 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4PjlxcM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2CF2206A5;
	Fri,  6 Dec 2024 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733508833; cv=none; b=U2n+ujvvh1vwPqPQ+1tnpOekgYPKB/sPs1U8zhNOeY/CNI+ICXRiRkw2PRnFy1iXNQ+memriJF+gxdDlPtFd7djkW2BxkZu5BkXg+lnGLBkgLfh3EidunjjYYJDksjRk0KEYuC7EFBIoQY0fdwpGvvVqj3ULc2PUW5KSXX1G81g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733508833; c=relaxed/simple;
	bh=4ErpPL5RKiuQcrZig3s30EOBUc46OyFFUZ5BpiI6s8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msG4UhoqzhaFHT6nJ5+kqfBYHeUTbTRyvS9OxWSsklk0YWtg7LMRwZvYLhg6gCAuDp2bhAT/c0rK81RoZdqNWj1rJVFjE+AWk3z3Jwsd4NhPzj112YLJDTI6cqoASOl6QFhbACwAY01Cpq+gptuFLkppdzmodJwtLq1lc9EFkqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4PjlxcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C22AC4CED1;
	Fri,  6 Dec 2024 18:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733508833;
	bh=4ErpPL5RKiuQcrZig3s30EOBUc46OyFFUZ5BpiI6s8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A4PjlxcM/00JWSrZoVgU3sB06/hOdBzdPnD7f9XxmB7V5nTh+GKuLcLeohWkkS8zb
	 Ex7oNt/TVBFXPiol8NQvZTVCIK3za2UIDXdDm2rnptZPAozPPbXDouB9au8bzMB5yb
	 1gwhfo6rweiVkR4rqk6qRcab8wa77+CBPyLnMc3F889xvkvsfJrSZ/0h0Ca56ol0wG
	 TgxLvQHNJgh7WTzW8a28TMD0bHpqVvs2ILHV7BKg3msMDBqLXAIl1SuFTixoMrqG++
	 GKi/T4oaOUqr+fWf3fVFZ5QbhwhrYNwP/xuzMvKs018iNNiR2FoV2s+D3b3/Ds/xp6
	 lu9HpaDJel0hg==
Date: Fri, 6 Dec 2024 19:13:44 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH v4 02/13] rust: implement generic driver registration
Message-ID: <Z1M-2J1wtLwEhz8D@pollux>
References: <20241205141533.111830-1-dakr@kernel.org>
 <20241205141533.111830-3-dakr@kernel.org>
 <CAH5fLghRVFAb06YYfUbuyuR1pOK0cHzGk6A25c5hX3CyvMm+sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLghRVFAb06YYfUbuyuR1pOK0cHzGk6A25c5hX3CyvMm+sw@mail.gmail.com>

On Fri, Dec 06, 2024 at 02:57:19PM +0100, Alice Ryhl wrote:
> On Thu, Dec 5, 2024 at 3:16 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > Implement the generic `Registration` type and the `DriverOps` trait.
> >
> > The `Registration` structure is the common type that represents a driver
> > registration and is typically bound to the lifetime of a module. However,
> > it doesn't implement actual calls to the kernel's driver core to register
> > drivers itself.
> >
> > Instead the `DriverOps` trait is provided to subsystems, which have to
> > implement `DriverOps::register` and `DrvierOps::unregister`. Subsystems
> 
> typo
> 
> > have to provide an implementation for both of those methods where the
> > subsystem specific variants to register / unregister a driver have to
> > implemented.
> >
> > For instance, the PCI subsystem would call __pci_register_driver() from
> > `DriverOps::register` and pci_unregister_driver() from
> > `DrvierOps::unregister`.
> >
> > Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> [...]
> 
> > +/// The [`RegistrationOps`] trait serves as generic interface for subsystems (e.g., PCI, Platform,
> > +/// Amba, etc.) to provide the corresponding subsystem specific implementation to register /
> > +/// unregister a driver of the particular type (`RegType`).
> > +///
> > +/// For instance, the PCI subsystem would set `RegType` to `bindings::pci_driver` and call
> > +/// `bindings::__pci_register_driver` from `RegistrationOps::register` and
> > +/// `bindings::pci_unregister_driver` from `RegistrationOps::unregister`.
> > +pub trait RegistrationOps {
> > +    /// The type that holds information about the registration. This is typically a struct defined
> > +    /// by the C portion of the kernel.
> > +    type RegType: Default;
> 
> This Default implementation doesn't seem useful. You initialize it and

I think it is -- `RegType` is always the raw bindings:: type and in
`Registration::new` in `Opaque::try_ffi_init` we call
`ptr.write(T::RegType::default())` for - since `RegType` is a raw bindings::
type - zero initialization.

> then `register` calls a C function to initialize it. Having `register`
> return an `impl PinInit` seems like it would work better here.

This would work as well, but it would effectively move the common code from
`Registration::new` to the bus specific type.

I think it's quite nice that the bus specific code does not need to care about
messing with `try_pin_init`, `Opaque::try_ffi_init`, zero initialization, etc.,
but just needs to assign the relevant fields and call register.

> 
> > +    /// Registers a driver.
> > +    ///
> > +    /// On success, `reg` must remain pinned and valid until the matching call to
> > +    /// [`RegistrationOps::unregister`].
> > +    fn register(
> > +        reg: &mut Self::RegType,
> 
> If the intent is that RegType is going to be the raw bindings:: type,
> then this isn't going to work because you're creating &mut references
> to the raw type without a Opaque wrapper in between.

True, that seems unsound. Since this is called from when the corresponding
`Opaque` wrapper is created, I think we need to fall back to a raw pointer then
and make `register` and `unregister` unsafe.

I don't think that too big of a deal though, since those two should never be
called from anywhere else than `Registration:new` or `Registration::drop`.

> 
> > +        name: &'static CStr,
> > +        module: &'static ThisModule,
> > +    ) -> Result;
> > +
> > +    /// Unregisters a driver previously registered with [`RegistrationOps::register`].
> > +    fn unregister(reg: &mut Self::RegType);
> 
> I believe this handles pinning incorrectly. You can't hand out &mut
> references to pinned values.

Same as above.

> 
> Alice

