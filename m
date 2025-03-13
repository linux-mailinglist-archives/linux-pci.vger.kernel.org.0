Return-Path: <linux-pci+bounces-23642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC23A5F7FF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE2519C45DC
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 14:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EB3267F53;
	Thu, 13 Mar 2025 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Egk/Df7Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BF9267F4F;
	Thu, 13 Mar 2025 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875961; cv=none; b=s9lajWk6qfCB2pJeTbmNbWxY9RFFQT814SL+84H+EAupmTli3zOe5FnKaWcz4H6/R3ZH0is/LPl7hTj/FX1jkPSnHQlsk4Otk4RKQMJH6llOwdzo7MZaXuE9GRqzCIa6by8EBiZn5K0nlkK+6Ur/kUu9OMCuGQ35xNWtp90GuPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875961; c=relaxed/simple;
	bh=CZx6TwMA0NCh5fjlQFkDkBD0jjZYUy/h1Qs71+ifFJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqYlGYm39DDmXniTpqGFcDL5AFJWY7CjfOpgPmxZ3KLBDqAiiPyQa46RWvreDZ1Dm5vIX7isEH1TZisMoWHq85tn+N5YyLff4HnLAerJc/nCxO831Srco1aTnAs6v9S3kp4mldBPnU+I/ff4lLnn/Q+blfcRmQA2W53SWrdm8CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Egk/Df7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B8BC4CEDD;
	Thu, 13 Mar 2025 14:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875960;
	bh=CZx6TwMA0NCh5fjlQFkDkBD0jjZYUy/h1Qs71+ifFJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Egk/Df7QgTF4jkaGx8zGZQ9I6MBHi8FpKUeBCjhX1EEYiVwPcoPxBqcctA+UEjCZn
	 nG0cI2wLCDQ8wCrfpZiEVT3BJ2dEzwmJ0iuZPgtwpOyPsHFNliagzvdAhTRSH3SyxQ
	 VyQI+fdeul9I4cHBjHW/h8PI4jKHEvXeIGl5ZT+gcrVUjOgUBXTpvdnaPCO54vNan0
	 3CVuUM6nrO+6eS+x96Pm/hQ53rGeGMGd9AhR97s5IFFyTw4QOfe2VuIZUd7fDOiFCF
	 L65p25TegzwUG5VpUvqneiC03UBeVcuUREtLUBfVi2ERT/VxCgwLpM8S8jytkGlpSZ
	 FA389rd5x/NZQ==
Date: Thu, 13 Mar 2025 15:25:55 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 3/4] rust: pci: fix unrestricted &mut pci::Device
Message-ID: <Z9Lq8xyTbIzfPhRX@pollux>
References: <20250313021550.133041-1-dakr@kernel.org>
 <20250313021550.133041-4-dakr@kernel.org>
 <D8F2S8YNYGZP.3JQKC7ZMRAB2C@proton.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8F2S8YNYGZP.3JQKC7ZMRAB2C@proton.me>

On Thu, Mar 13, 2025 at 10:44:38AM +0000, Benno Lossin wrote:
> On Thu Mar 13, 2025 at 3:13 AM CET, Danilo Krummrich wrote:
> > As by now, pci::Device is implemented as:
> >
> > 	#[derive(Clone)]
> > 	pub struct Device(ARef<device::Device>);
> >
> > This may be convenient, but has the implication that drivers can call
> > device methods that require a mutable reference concurrently at any
> > point of time.
> 
> Which methods take mutable references? The `set_master` method you
> mentioned also took a shared reference before this patch.

Yeah, that's basically a bug that I never fixed (until now), since making it
take a mutable reference would not have changed anything in terms of
accessibility.

> 
> > Instead define pci::Device as
> >
> > 	pub struct Device<Ctx: DeviceContext = Normal>(
> > 		Opaque<bindings::pci_dev>,
> > 		PhantomData<Ctx>,
> > 	);
> >
> > and manually implement the AlwaysRefCounted trait.
> >
> > With this we can implement methods that should only be called from
> > bus callbacks (such as probe()) for pci::Device<Core>. Consequently, we
> > make this type accessible in bus callbacks only.
> >
> > Arbitrary references taken by the driver are still of type
> > ARef<pci::Device> and hence don't provide access to methods that are
> > reserved for bus callbacks.
> >
> > Fixes: 1bd8b6b2c5d3 ("rust: pci: add basic PCI device / driver abstractions")
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> Two small nits below, but it already looks good:
> 
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> 
> > ---
> >  drivers/gpu/nova-core/driver.rs |   4 +-
> >  rust/kernel/pci.rs              | 126 ++++++++++++++++++++------------
> >  samples/rust/rust_driver_pci.rs |   8 +-
> >  3 files changed, 85 insertions(+), 53 deletions(-)
> >
> 
> > @@ -351,20 +361,8 @@ fn deref(&self) -> &Self::Target {
> >  }
> >  
> >  impl Device {
> 
> One alternative to implementing `Deref` below would be to change this to
> `impl<Ctx: DeviceContext> Device<Ctx>`. But then one would lose the
> ability to just do `&pdev` to get a `Device` from a `Device<Core>`... So
> I think the deref way is better. Just wanted to mention this in case
> someone re-uses this pattern.
> 
> > -    /// Create a PCI Device instance from an existing `device::Device`.
> > -    ///
> > -    /// # Safety
> > -    ///
> > -    /// `dev` must be an `ARef<device::Device>` whose underlying `bindings::device` is a member of
> > -    /// a `bindings::pci_dev`.
> > -    pub unsafe fn from_dev(dev: ARef<device::Device>) -> Self {
> > -        Self(dev)
> > -    }
> > -
> >      fn as_raw(&self) -> *mut bindings::pci_dev {
> > -        // SAFETY: By the type invariant `self.0.as_raw` is a pointer to the `struct device`
> > -        // embedded in `struct pci_dev`.
> > -        unsafe { container_of!(self.0.as_raw(), bindings::pci_dev, dev) as _ }
> > +        self.0.get()
> >      }
> >  
> >      /// Returns the PCI vendor ID.
> 
> >  impl AsRef<device::Device> for Device {
> >      fn as_ref(&self) -> &device::Device {
> > -        &self.0
> > +        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
> > +        // `struct pci_dev`.
> > +        let dev = unsafe { addr_of_mut!((*self.as_raw()).dev) };
> > +
> > +        // SAFETY: `dev` points to a valid `struct device`.
> > +        unsafe { device::Device::as_ref(dev) }
> 
> Why not use `&**self` instead (ie go through the `Deref` impl)?

`&**self` gives us a `Device` (i.e. `pci::Device`), not a `device::Device`.

> 
> > @@ -77,7 +77,7 @@ fn probe(pdev: &mut pci::Device, info: &Self::IdInfo) -> Result<Pin<KBox<Self>>>
> >  
> >          let drvdata = KBox::new(
> >              Self {
> > -                pdev: pdev.clone(),
> > +                pdev: (&**pdev).into(),
> 
> It might be possible to do:
> 
>     impl From<&pci::Device<Core>> for ARef<pci::Device> { ... }
> 
> Then this line could become `pdev: pdev.into()`.

Yeah, having to write `&**pdev` was bothering me too, and I actually tried what
you suggest, but it didn't compile -- I'll double check.

