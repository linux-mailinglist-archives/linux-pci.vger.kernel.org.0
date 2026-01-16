Return-Path: <linux-pci+bounces-45050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87844D32353
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 14:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0ABBC3013339
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 13:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B37A27B347;
	Fri, 16 Jan 2026 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="H+QFkpKR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C8B23D7F7
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768571864; cv=none; b=SGCOVlqxIvtUXVzazPrQ74mVfnRMYqWjkrjWiszzOjdWT0IMLRZBlFX7SdIaQ6zwAWcqyL7P+aUGsFAjMrdGM8ilOLNv/U8KAkHHniviRuMODGvc7t1JzXeT1l2J+WdtaB595Q3jb5bDd4R/EMNtNsQPeQwv6Xpk1VdZ8dGWJ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768571864; c=relaxed/simple;
	bh=1tQJsd7iXjjxus53VyDjtHpbaTTaU0lZRlI9haMNmiI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u7TNtUb3mxEB1D7XKkfavSGAQLKWS5nExyRj6G4tFwXjB/O86yqwrkbkmiv0TOGB5UcHPq6br0Cn9/AlXrO7LBKBGTvoAoprTvfcwCHCFA+Uom4JkVjPcDgt/e10Su9fjvdQqs9avUOue8c2Toyu/GiKk4WAl8di7YR64HntFIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=H+QFkpKR; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 2B165240104
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 14:57:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1768571854; bh=RrFaP2szCaQivKfNbTX6qWof933IJE11wwKe8XlBzEY=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=H+QFkpKRASvDndidspqvyVGXAxCMJ2D+rgPjPhZJcHibHiQkjgQSvtTXbbeKirGe/
	 rSxjRp9ZOJ7BxX5pN/nxaFgfLpWTFcUI1/KYsfhVGOcVppX29Rdwr5EDQLFsZ7iFWI
	 3OR7PZyS3fMzERj+0Qcuv5sDFgB+y5cZDZZmxYltFL7vYg9kiM25+buZMopP8I+aZ7
	 TjdUSdAuCw4kjkzHlYJOg2H3uW4xkOH/Igm6Vo/Sb1asD3KoJxCu7/ZUQ5bjjKeXk3
	 6qxovpDkV+ho+MLCFuUFUqlXlAlUtgI9daCxGY2ZS0r5zyFqwh6odxuF4cPcZ+weDb
	 4tacC+TFeTVpQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dt1d52TmMz6tm8;
	Fri, 16 Jan 2026 14:57:29 +0100 (CET)
Message-ID: <08956b4fe99619064a4424d500837807ba4c92e6.camel@posteo.de>
Subject: Re: [PATCH v9 2/5] rust: io: factor common I/O helpers into Io trait
From: Markus Probst <markus.probst@posteo.de>
To: Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dakr@kernel.org, aliceryhl@google.com, bhelgaas@google.com, 
	kwilczynski@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 helgaas@kernel.org, 	cjia@nvidia.com, smitra@nvidia.com, ankita@nvidia.com,
 aniketa@nvidia.com, 	kwankhede@nvidia.com, targupta@nvidia.com,
 acourbot@nvidia.com, 	joelagnelf@nvidia.com, jhubbard@nvidia.com,
 zhiwang@kernel.org, 	daniel.almeida@collabora.com
Date: Fri, 16 Jan 2026 13:57:32 +0000
In-Reply-To: <20260115212657.399231-3-zhiw@nvidia.com>
References: <20260115212657.399231-1-zhiw@nvidia.com>
	 <20260115212657.399231-3-zhiw@nvidia.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 66sLA9g==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-0l0YM7+hBS4rt3w0z3cp"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-0l0YM7+hBS4rt3w0z3cp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-01-15 at 23:26 +0200, Zhi Wang wrote:
> The previous Io<SIZE> type combined both the generic I/O access helpers
> and MMIO implementation details in a single struct.
>=20
> To establish a cleaner layering between the I/O interface and its concret=
e
> backends, paving the way for supporting additional I/O mechanisms in the
> future, Io<SIZE> need to be factored.
>=20
> Factor the common helpers into new {Io, Io64} traits, and move the
> MMIO-specific logic into a dedicated Mmio<SIZE> type implementing that
> trait. Rename the IoRaw to MmioRaw and update the bus MMIO implementation=
s
> to use MmioRaw.
>=20
> No functional change intended.
>=20
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  drivers/gpu/drm/tyr/regs.rs            |   1 +
>  drivers/gpu/nova-core/gsp/sequencer.rs |   5 +-
>  drivers/gpu/nova-core/regs/macros.rs   |  90 +++++---
>  drivers/gpu/nova-core/vbios.rs         |   1 +
>  rust/kernel/devres.rs                  |  14 +-
>  rust/kernel/io.rs                      | 291 +++++++++++++++++++------
>  rust/kernel/io/mem.rs                  |  16 +-
>  rust/kernel/io/poll.rs                 |  16 +-
>  rust/kernel/pci/io.rs                  |  12 +-
>  samples/rust/rust_driver_pci.rs        |   2 +
>  10 files changed, 317 insertions(+), 131 deletions(-)

>=20
> +/// Represents a region of I/O space of a fixed size.
> +///
> +/// This is an abstract representation to be implemented by arbitrary I/=
O
> +/// backends (e.g. MMIO, I2C, etc.).
> +///
> +/// Provides common helpers for offset validation and address
> +/// calculation on top of a base address and maximum size.
> +pub trait IoBase {
> +    /// Minimum usable size of this region.
> +    const MIN_SIZE: usize;
> =20
>      /// Returns the base address of this mapping.
> -    #[inline]
> -    pub fn addr(&self) -> usize {
> -        self.0.addr()
> -    }
> +    fn addr(&self) -> usize;
> =20
>      /// Returns the maximum size of this mapping.
> -    #[inline]
> -    pub fn maxsize(&self) -> usize {
> -        self.0.maxsize()
> -    }
> -
> -    #[inline]
> -    const fn offset_valid<U>(offset: usize, size: usize) -> bool {
> -        let type_size =3D core::mem::size_of::<U>();
> -        if let Some(end) =3D offset.checked_add(type_size) {
> -            end <=3D size && offset % type_size =3D=3D 0
> -        } else {
> -            false
> -        }
> -    }
> +    fn maxsize(&self) -> usize;
> =20
> +    /// Returns the absolute I/O address for a given `offset`,
> +    /// performing runtime bound checks.
>      #[inline]
>      fn io_addr<U>(&self, offset: usize) -> Result<usize> {
> -        if !Self::offset_valid::<U>(offset, self.maxsize()) {
> +        if !offset_valid::<U>(offset, self.maxsize()) {
>              return Err(EINVAL);
>          }
> =20
> @@ -239,50 +242,198 @@ fn io_addr<U>(&self, offset: usize) -> Result<usiz=
e> {
>          self.addr().checked_add(offset).ok_or(EINVAL)
>      }
> =20
> +    /// Returns the absolute I/O address for a given `offset`,
> +    /// performing compile-time bound checks.
>      #[inline]
>      fn io_addr_assert<U>(&self, offset: usize) -> usize {
> -        build_assert!(Self::offset_valid::<U>(offset, SIZE));
> +        build_assert!(offset_valid::<U>(offset, Self::MIN_SIZE));
> =20
>          self.addr() + offset
>      }
> +}
> +
> +/// Types implementing this trait (e.g. MMIO BARs or PCI config regions)
> +/// can share the same IoKnownSize accessors.
> +///
> +/// In this context, "known size" represents the static guarantee regard=
ing
> +/// the minimum accessible size requested from the I/O backend.
> +///
> +/// Note that the actual size of the resource provided by the hardware
> +/// (e.g., the physical BAR size) might be larger than this "known size"=
.
> +pub trait IoKnownSize: IoBase {
> +    /// Infallible 8-bit read with compile-time bounds check.
> +    fn read8(&self, offset: usize) -> u8;
> +
> +    /// Infallible 16-bit read with compile-time bounds check.
> +    fn read16(&self, offset: usize) -> u16;
> +
> +    /// Infallible 32-bit read with compile-time bounds check.
> +    fn read32(&self, offset: usize) -> u32;
> +
> +    /// Infallible 8-bit write with compile-time bounds check.
> +    fn write8(&self, value: u8, offset: usize);
> +
> +    /// Infallible 16-bit write with compile-time bounds check.
> +    fn write16(&self, value: u16, offset: usize);
> =20
> -    define_read!(read8, try_read8, readb -> u8);
> -    define_read!(read16, try_read16, readw -> u16);
> -    define_read!(read32, try_read32, readl -> u32);
> +    /// Infallible 32-bit write with compile-time bounds check.
> +    fn write32(&self, value: u32, offset: usize);
> +}
> +
> +/// Types implementing this trait (e.g. MMIO BARs or PCI config regions)
> +/// can share the same Io accessors.
> +///
> +/// This trait defines the accessors for performing runtime-checked
> +/// operations on an I/O region. Note that due to the runtime checks, th=
ese
> +/// operations may be more expensive than those provided by
> +/// [`IoKnownSize`].
> +///
> +/// Implement this trait when:
> +/// - The I/O backend cannot guarantee a minimum accessible size for the
> +///   region.
> +/// - The I/O backend wishes to return meaningful error codes when the
> +///   driver accesses the region.
> +pub trait Io: IoBase {
> +    /// Fallible 8-bit read with runtime bounds check.
> +    fn try_read8(&self, offset: usize) -> Result<u8>;
> +
> +    /// Fallible 16-bit read with runtime bounds check.
> +    fn try_read16(&self, offset: usize) -> Result<u16>;
> +
> +    /// Fallible 32-bit read with runtime bounds check.
> +    fn try_read32(&self, offset: usize) -> Result<u32>;
> +
> +    /// Fallible 8-bit write with runtime bounds check.
> +    fn try_write8(&self, value: u8, offset: usize) -> Result;
> +
> +    /// Fallible 16-bit write with runtime bounds check.
> +    fn try_write16(&self, value: u16, offset: usize) -> Result;
> +
> +    /// Fallible 32-bit write with runtime bounds check.
> +    fn try_write32(&self, value: u32, offset: usize) -> Result;

How would this work with I2C as a IO backend?

I2C by itself doesn't have 32-bit IO, which the trait requires.

There is
"byte data" - 8 bit
"word data" - 16 bit
"block data" - arbitrary number of bytes (in SMBus limited to 32 bytes.
Outside of SMBus it could be higher)

Note that I only require "byte data" for my led driver.

Thanks
- Markus Probst


--=-0l0YM7+hBS4rt3w0z3cp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmlqQ7QbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEDR2H/jnrUPSwOkQAKpxRR+LhyFgHOI9f+dl
P0Mh8IBr+ngCVcxNmRABpwGsoMXcxEALhFKOrSuDLOnhTsU5aZz8WWGdH4IQ1dDe
xe0BWT5B51/yegMNaLSzcYjPyY3oO7zlyKk9wsEIL73MkleIg8RrnMEWCAexeTNk
dpbFjwkDoULgd34dpG83yC8cPE5MEW1U9NVUk+v2lnjewbHJH31ffzbFJ0NILz0F
m9SUC44FOLXyGKW8e/azA1cH9rnb3wp3bmJmKtpyrUPFE3hdmXnFG2BhZIzRPrHx
oJdZKRkZlZ0DCdn5V9dBwNSFKas5ktgcI+HKOqTH4MqvwDl9oPmgrWT5CzIeOTUg
XW08hqC/nDIOIfe7KRCm/vydasWoTZWSTelFHTrP404eovQvsO9b8GcFTYA0tzT+
lDERJu/tOf28P4vl8usPa2PPB84OqM+etTU6k3CRz0vRpUUxDCLka0FMM97okFpx
Wq9W+ataPZVL1JObJij0zhBfuHERMCXD7CQB5AONNG5KPp4I8lDh+4UEruW+s0l3
u11/Gr5laIzHo+2Wkc5bnbxlurVkp4f0rtetRLsST+SWnN1oInttxplN/H+haoBU
hCOp2jvXy2Jgvnb7s/w1KvtF7D81lvxOUt3zhhpjpXjZMov1GnwdFeSYsWaugMKy
mSuQxOXLG4unCKQoGXEUFwv/
=MkT8
-----END PGP SIGNATURE-----

--=-0l0YM7+hBS4rt3w0z3cp--

