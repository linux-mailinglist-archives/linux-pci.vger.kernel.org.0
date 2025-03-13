Return-Path: <linux-pci+bounces-23598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1EFA5F133
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 11:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB56D19C21C4
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 10:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5FF1FBC87;
	Thu, 13 Mar 2025 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="B92emiyE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5184E25FA25;
	Thu, 13 Mar 2025 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862695; cv=none; b=WXIUpNYk0gsmvrZNO3rnUm28x7gajpKQaQUZmJ4YYQ/TLUeWFALeQug9T4h4WcBHydgQ0sX+5mtNc7Au4GDB8lLpOxgJYvXJ3VcUElwlhGp95wDcobnUpQSVEu84kJnYPuaqWg28pchxLaVA9tq58hRQQ9lni4Sl2dBT7WdUlxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862695; c=relaxed/simple;
	bh=buE1atiYPYQ607nxgunbzSf/tfSUHJlGFsw5PTuvC/k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QjO6Qssgqg0T4gmEdh8Z7ZeBm9BM8zVlS+PgpNrHVWdKwLGhgbsi4VoR3BvD76/RnHeyuLL/sFJqvCXugHENMxpeSC+MbF8/N1QWqbP0W7aKjHc0tq3akjWTPWD8XiA94aWazXCjqOhsCg6gD9LCq6QThZZWjffWQTiVvbTL6+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=B92emiyE; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741862685; x=1742121885;
	bh=cEp0z9a1YFho7EAFWzdcM9E6nSuKjT0pUbaWukOFjiE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=B92emiyE4n0MDgfkevUR+bMzJG4iQTRtouqNmwaNhuRkELHDxE2SoIBB2mhg+2qAv
	 OVgWcCVhHTP3dns3k5g5CoNhUpmhcP6YD2F+WUYRN21ft52tsrehwEqAg//x8ShXgO
	 yf4MmXVrNqkQmjekJIpjkUlhf68ejUEccqc+aEP9Vq9PiZufTwnCC+82dwQvcJQwa2
	 DikqHHoRbk5pHfG+MAUiQgp0a74WucxZZvewBQa1mhLMapVUwn2yKePeT1jXLULumO
	 yqP8BvVH/GZlzPtmpby4qGS5fVBOvIu046BVv6kLDaWiUFOGcjpU5nCvT8S1hpv3Z6
	 kr3cTSHrMg0Lw==
Date: Thu, 13 Mar 2025 10:44:38 +0000
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 3/4] rust: pci: fix unrestricted &mut pci::Device
Message-ID: <D8F2S8YNYGZP.3JQKC7ZMRAB2C@proton.me>
In-Reply-To: <20250313021550.133041-4-dakr@kernel.org>
References: <20250313021550.133041-1-dakr@kernel.org> <20250313021550.133041-4-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 89a882be85537588231892a321560284113bea8d
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 13, 2025 at 3:13 AM CET, Danilo Krummrich wrote:
> As by now, pci::Device is implemented as:
>
> =09#[derive(Clone)]
> =09pub struct Device(ARef<device::Device>);
>
> This may be convenient, but has the implication that drivers can call
> device methods that require a mutable reference concurrently at any
> point of time.

Which methods take mutable references? The `set_master` method you
mentioned also took a shared reference before this patch.

> Instead define pci::Device as
>
> =09pub struct Device<Ctx: DeviceContext =3D Normal>(
> =09=09Opaque<bindings::pci_dev>,
> =09=09PhantomData<Ctx>,
> =09);
>
> and manually implement the AlwaysRefCounted trait.
>
> With this we can implement methods that should only be called from
> bus callbacks (such as probe()) for pci::Device<Core>. Consequently, we
> make this type accessible in bus callbacks only.
>
> Arbitrary references taken by the driver are still of type
> ARef<pci::Device> and hence don't provide access to methods that are
> reserved for bus callbacks.
>
> Fixes: 1bd8b6b2c5d3 ("rust: pci: add basic PCI device / driver abstractio=
ns")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Two small nits below, but it already looks good:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>  drivers/gpu/nova-core/driver.rs |   4 +-
>  rust/kernel/pci.rs              | 126 ++++++++++++++++++++------------
>  samples/rust/rust_driver_pci.rs |   8 +-
>  3 files changed, 85 insertions(+), 53 deletions(-)
>

> @@ -351,20 +361,8 @@ fn deref(&self) -> &Self::Target {
>  }
> =20
>  impl Device {

One alternative to implementing `Deref` below would be to change this to
`impl<Ctx: DeviceContext> Device<Ctx>`. But then one would lose the
ability to just do `&pdev` to get a `Device` from a `Device<Core>`... So
I think the deref way is better. Just wanted to mention this in case
someone re-uses this pattern.

> -    /// Create a PCI Device instance from an existing `device::Device`.
> -    ///
> -    /// # Safety
> -    ///
> -    /// `dev` must be an `ARef<device::Device>` whose underlying `bindin=
gs::device` is a member of
> -    /// a `bindings::pci_dev`.
> -    pub unsafe fn from_dev(dev: ARef<device::Device>) -> Self {
> -        Self(dev)
> -    }
> -
>      fn as_raw(&self) -> *mut bindings::pci_dev {
> -        // SAFETY: By the type invariant `self.0.as_raw` is a pointer to=
 the `struct device`
> -        // embedded in `struct pci_dev`.
> -        unsafe { container_of!(self.0.as_raw(), bindings::pci_dev, dev) =
as _ }
> +        self.0.get()
>      }
> =20
>      /// Returns the PCI vendor ID.

>  impl AsRef<device::Device> for Device {
>      fn as_ref(&self) -> &device::Device {
> -        &self.0
> +        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a=
 pointer to a valid
> +        // `struct pci_dev`.
> +        let dev =3D unsafe { addr_of_mut!((*self.as_raw()).dev) };
> +
> +        // SAFETY: `dev` points to a valid `struct device`.
> +        unsafe { device::Device::as_ref(dev) }

Why not use `&**self` instead (ie go through the `Deref` impl)?

> @@ -77,7 +77,7 @@ fn probe(pdev: &mut pci::Device, info: &Self::IdInfo) -=
> Result<Pin<KBox<Self>>>
> =20
>          let drvdata =3D KBox::new(
>              Self {
> -                pdev: pdev.clone(),
> +                pdev: (&**pdev).into(),

It might be possible to do:

    impl From<&pci::Device<Core>> for ARef<pci::Device> { ... }

Then this line could become `pdev: pdev.into()`.

---
Cheers,
Benno

>                  bar,
>              },
>              GFP_KERNEL,



