Return-Path: <linux-pci+bounces-18147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EF69ECF19
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 15:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0AE168D33
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 14:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E1619FA93;
	Wed, 11 Dec 2024 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="BJQiYfyV"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC641494CC;
	Wed, 11 Dec 2024 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928843; cv=pass; b=ZrO8iiye1qI8ci/r+rQnwLpoFUeWeSaPBcEwCMne6H0YQR8gnXq2GGZbnURlM+VM+zW+NWtatyYrdv2Kdaj3qm8rTW+ZQfs+vfIE33CK1muH3ffvYyVhT3bmPBeOx4QLlcQ8RlP2MCA4nh20qlJi7FkY52VwkZfZmkoZFqI+Q/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928843; c=relaxed/simple;
	bh=UIWky3ex/k5L6KRTSSs1e2IkNUC9a5Rx+3kFXhJBrvg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=T116hRF7aIdut/cSWcjl9DDhyqptwb4M/e6aEfZ5s+U7AG8/kK1X1OseHWCzmdf9gNBKWQV/suHqaME+2qkMcL1ADFlLkXTViul+8IZXW3RmKSGvdGtBRY/iljb9dMDCiaIycBv0EwR+PYgKMN1RLrlwh1M1KGNYQkeR2I6d+Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=BJQiYfyV; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733928796; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Cm19pc1oDFuD+8xrNwsKFvKy+4fXp3KWRCjyiUnyJH3QC2qYVfBOaGozm5FDF4lryii+U8DB2QS6AYmIj1/D37D/Roui6Em7u2JoxgA0+mibu/s68liWDHLMhjQ7u80VSwYMkXRx0/e4FnMHHthtkrEkgw/U3/sxmOSfMpm2CK0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733928796; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=La5d4CeOyUbXhv/hA3YkVuNUHhTc6V2xvbNkhh7eqVk=; 
	b=nQrTzlLpWJxTwdO+YHH/m5pFDFT/c+MwHy1NpJ9ycV9eMHeyk3tmbTXlyxz4bEFAcadoGFw/K6e4wf6WqSTQeeAxqrOHushrw92gQUJt+pCnwvNtAzJcuKkPKgOf09PsW91fYB47nHqNo8HHUY0k68upbCJHjzUAktdX0pEJeMY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733928796;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=La5d4CeOyUbXhv/hA3YkVuNUHhTc6V2xvbNkhh7eqVk=;
	b=BJQiYfyVwzWF0KWsPUV2tMc4SzNAdwmuO2+6PgnUhO84Nqiig2qLIACLQw2QlraR
	N+qbY/S3NXgep128O7HsgY1dAIfSVcyjt1vppu7MkjhfvQYFR0q/WCi8Eenpl9tQhdA
	g3mzZHoixvGXrrZm5Jnk7KiubhKAsMTOAmQQJDVs=
Received: by mx.zohomail.com with SMTPS id 173392879429365.08449904994575;
	Wed, 11 Dec 2024 06:53:14 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v4 06/13] rust: add `io::{Io, IoRaw}` base types
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20241205141533.111830-7-dakr@kernel.org>
Date: Wed, 11 Dec 2024 11:52:55 -0300
Cc: gregkh@linuxfoundation.org,
 rafael@kernel.org,
 bhelgaas@google.com,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 benno.lossin@proton.me,
 tmgross@umich.edu,
 a.hindborg@samsung.com,
 aliceryhl@google.com,
 airlied@gmail.com,
 fujita.tomonori@gmail.com,
 lina@asahilina.net,
 pstanner@redhat.com,
 ajanulgu@redhat.com,
 lyude@redhat.com,
 robh@kernel.org,
 saravanak@google.com,
 dirk.behme@de.bosch.com,
 j@jannau.net,
 fabien.parent@linaro.org,
 chrisi.schrefl@gmail.com,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <747785E6-600F-4D6B-9EB4-6E5CC8BDFD60@collabora.com>
References: <20241205141533.111830-1-dakr@kernel.org>
 <20241205141533.111830-7-dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi Danilo,

> On 5 Dec 2024, at 11:14, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> I/O memory is typically either mapped through direct calls to =
ioremap()
> or subsystem / bus specific ones such as pci_iomap().
>=20
> Even though subsystem / bus specific functions to map I/O memory are
> based on ioremap() / iounmap() it is not desirable to re-implement =
them
> in Rust.
>=20
> Instead, implement a base type for I/O mapped memory, which =
generically
> provides the corresponding accessors, such as `Io::readb` or
> `Io:try_readb`.
>=20
> `Io` supports an optional const generic, such that a driver can =
indicate
> the minimal expected and required size of the mapping at compile time.
> Correspondingly, calls to the 'non-try' accessors, support compile =
time
> checks of the I/O memory offset to read / write, while the 'try'
> accessors, provide boundary checks on runtime.
>=20
> `IoRaw` is meant to be embedded into a structure (e.g. pci::Bar or
> io::IoMem) which creates the actual I/O memory mapping and initializes

Maybe the in-flight platform::IoMem would be the other example? I see no =
`io::IoMem` in
your patch other than the one in the doctest.

> `IoRaw` accordingly.
>=20
> To ensure that I/O mapped memory can't out-live the device it may be
> bound to, subsystems must embed the corresponding I/O memory type =
(e.g.
> pci::Bar) into a `Devres` container, such that it gets revoked once =
the
> device is unbound.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> rust/helpers/helpers.c |   1 +
> rust/helpers/io.c      | 101 ++++++++++++++++
> rust/kernel/io.rs      | 260 +++++++++++++++++++++++++++++++++++++++++
> rust/kernel/lib.rs     |   1 +
> 4 files changed, 363 insertions(+)
> create mode 100644 rust/helpers/io.c
> create mode 100644 rust/kernel/io.rs
>=20
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 060750af6524..63f9b1da179f 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -14,6 +14,7 @@
> #include "cred.c"
> #include "err.c"
> #include "fs.c"
> +#include "io.c"
> #include "jump_label.c"
> #include "kunit.c"
> #include "mutex.c"
> diff --git a/rust/helpers/io.c b/rust/helpers/io.c
> new file mode 100644
> index 000000000000..1dde6374c0e2
> --- /dev/null
> +++ b/rust/helpers/io.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/io.h>
> +
> +void __iomem *rust_helper_ioremap(phys_addr_t offset, size_t size)
> +{
> + return ioremap(offset, size);
> +}
> +
> +void rust_helper_iounmap(volatile void __iomem *addr)
> +{
> + return iounmap(addr);
> +}
> +
> +u8 rust_helper_readb(const volatile void __iomem *addr)
> +{
> + return readb(addr);
> +}
> +
> +u16 rust_helper_readw(const volatile void __iomem *addr)
> +{
> + return readw(addr);
> +}
> +
> +u32 rust_helper_readl(const volatile void __iomem *addr)
> +{
> + return readl(addr);
> +}
> +
> +#ifdef CONFIG_64BIT
> +u64 rust_helper_readq(const volatile void __iomem *addr)
> +{
> + return readq(addr);
> +}
> +#endif
> +
> +void rust_helper_writeb(u8 value, volatile void __iomem *addr)
> +{
> + writeb(value, addr);
> +}
> +
> +void rust_helper_writew(u16 value, volatile void __iomem *addr)
> +{
> + writew(value, addr);
> +}
> +
> +void rust_helper_writel(u32 value, volatile void __iomem *addr)
> +{
> + writel(value, addr);
> +}
> +
> +#ifdef CONFIG_64BIT
> +void rust_helper_writeq(u64 value, volatile void __iomem *addr)
> +{
> + writeq(value, addr);
> +}
> +#endif
> +
> +u8 rust_helper_readb_relaxed(const volatile void __iomem *addr)
> +{
> + return readb_relaxed(addr);
> +}
> +
> +u16 rust_helper_readw_relaxed(const volatile void __iomem *addr)
> +{
> + return readw_relaxed(addr);
> +}
> +
> +u32 rust_helper_readl_relaxed(const volatile void __iomem *addr)
> +{
> + return readl_relaxed(addr);
> +}
> +
> +#ifdef CONFIG_64BIT
> +u64 rust_helper_readq_relaxed(const volatile void __iomem *addr)
> +{
> + return readq_relaxed(addr);
> +}
> +#endif
> +
> +void rust_helper_writeb_relaxed(u8 value, volatile void __iomem =
*addr)
> +{
> + writeb_relaxed(value, addr);
> +}
> +
> +void rust_helper_writew_relaxed(u16 value, volatile void __iomem =
*addr)
> +{
> + writew_relaxed(value, addr);
> +}
> +
> +void rust_helper_writel_relaxed(u32 value, volatile void __iomem =
*addr)
> +{
> + writel_relaxed(value, addr);
> +}
> +
> +#ifdef CONFIG_64BIT
> +void rust_helper_writeq_relaxed(u64 value, volatile void __iomem =
*addr)
> +{
> + writeq_relaxed(value, addr);
> +}
> +#endif
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> new file mode 100644
> index 000000000000..36aa2ec1bcc8
> --- /dev/null
> +++ b/rust/kernel/io.rs
> @@ -0,0 +1,260 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Memory-mapped IO.
> +//!
> +//! C header: =
[`include/asm-generic/io.h`](srctree/include/asm-generic/io.h)
> +
> +use crate::error::{code::EINVAL, Result};
> +use crate::{bindings, build_assert};
> +
> +/// Raw representation of an MMIO region.
> +///
> +/// By itself, the existence of an instance of this structure does =
not provide any guarantees that
> +/// the represented MMIO region does exist or is properly mapped.
> +///
> +/// Instead, the bus specific MMIO implementation must convert this =
raw representation into an `Io`
> +/// instance providing the actual memory accessors. Only by the =
conversion into an `Io` structure
> +/// any guarantees are given.
> +pub struct IoRaw<const SIZE: usize =3D 0> {
> +    addr: usize,
> +    maxsize: usize,
> +}
> +
> +impl<const SIZE: usize> IoRaw<SIZE> {
> +    /// Returns a new `IoRaw` instance on success, an error =
otherwise.
> +    pub fn new(addr: usize, maxsize: usize) -> Result<Self> {
> +        if maxsize < SIZE {
> +            return Err(EINVAL);
> +        }
> +
> +        Ok(Self { addr, maxsize })
> +    }
> +
> +    /// Returns the base address of the MMIO region.
> +    #[inline]
> +    pub fn addr(&self) -> usize {
> +        self.addr
> +    }
> +
> +    /// Returns the maximum size of the MMIO region.
> +    #[inline]
> +    pub fn maxsize(&self) -> usize {
> +        self.maxsize
> +    }
> +}
> +
> +/// IO-mapped memory, starting at the base address @addr and spanning =
@maxlen bytes.
> +///
> +/// The creator (usually a subsystem / bus such as PCI) is =
responsible for creating the
> +/// mapping, performing an additional region request etc.
> +///
> +/// # Invariant
> +///
> +/// `addr` is the start and `maxsize` the length of valid I/O mapped =
memory region of size
> +/// `maxsize`.
> +///
> +/// # Examples
> +///
> +/// ```no_run
> +/// # use kernel::{bindings, io::{Io, IoRaw}};
> +/// # use core::ops::Deref;
> +///
> +/// // See also [`pci::Bar`] for a real example.
> +/// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
> +///
> +/// impl<const SIZE: usize> IoMem<SIZE> {
> +///     /// # Safety
> +///     ///
> +///     /// [`paddr`, `paddr` + `SIZE`) must be a valid MMIO region =
that is mappable into the CPUs
> +///     /// virtual address space.
> +///     unsafe fn new(paddr: usize) -> Result<Self>{
> +///         // SAFETY: By the safety requirements of this function =
[`paddr`, `paddr` + `SIZE`) is
> +///         // valid for `ioremap`.
> +///         let addr =3D unsafe { bindings::ioremap(paddr as _, =
SIZE.try_into().unwrap()) };
> +///         if addr.is_null() {
> +///             return Err(ENOMEM);
> +///         }
> +///
> +///         Ok(IoMem(IoRaw::new(addr as _, SIZE)?))
> +///     }
> +/// }
> +///
> +/// impl<const SIZE: usize> Drop for IoMem<SIZE> {
> +///     fn drop(&mut self) {
> +///         // SAFETY: `self.0.addr()` is guaranteed to be properly =
mapped by `Self::new`.
> +///         unsafe { bindings::iounmap(self.0.addr() as _); };
> +///     }
> +/// }
> +///
> +/// impl<const SIZE: usize> Deref for IoMem<SIZE> {
> +///    type Target =3D Io<SIZE>;
> +///
> +///    fn deref(&self) -> &Self::Target {
> +///         // SAFETY: The memory range stored in `self` has been =
properly mapped in `Self::new`.
> +///         unsafe { Io::from_raw(&self.0) }
> +///    }
> +/// }
> +///
> +///# fn no_run() -> Result<(), Error> {
> +/// // SAFETY: Invalid usage for example purposes.
> +/// let iomem =3D unsafe { IoMem::<{ core::mem::size_of::<u32>() =
}>::new(0xBAAAAAAD)? };
> +/// iomem.writel(0x42, 0x0);
> +/// assert!(iomem.try_writel(0x42, 0x0).is_ok());
> +/// assert!(iomem.try_writel(0x42, 0x4).is_err());
> +/// # Ok(())
> +/// # }
> +/// ```
> +#[repr(transparent)]
> +pub struct Io<const SIZE: usize =3D 0>(IoRaw<SIZE>);
> +
> +macro_rules! define_read {
> +    ($(#[$attr:meta])* $name:ident, $try_name:ident, $type_name:ty) =
=3D> {
> +        /// Read IO data from a given offset known at compile time.
> +        ///
> +        /// Bound checks are performed on compile time, hence if the =
offset is not known at compile
> +        /// time, the build will fail.
> +        $(#[$attr])*
> +        #[inline]
> +        pub fn $name(&self, offset: usize) -> $type_name {
> +            let addr =3D self.io_addr_assert::<$type_name>(offset);
> +
> +            // SAFETY: By the type invariant `addr` is a valid =
address for MMIO operations.
> +            unsafe { bindings::$name(addr as _) }
> +        }
> +
> +        /// Read IO data from a given offset.
> +        ///
> +        /// Bound checks are performed on runtime, it fails if the =
offset (plus the type size) is
> +        /// out of bounds.
> +        $(#[$attr])*
> +        pub fn $try_name(&self, offset: usize) -> Result<$type_name> =
{
> +            let addr =3D self.io_addr::<$type_name>(offset)?;
> +
> +            // SAFETY: By the type invariant `addr` is a valid =
address for MMIO operations.
> +            Ok(unsafe { bindings::$name(addr as _) })
> +        }
> +    };
> +}
> +
> +macro_rules! define_write {
> +    ($(#[$attr:meta])* $name:ident, $try_name:ident, $type_name:ty) =
=3D> {
> +        /// Write IO data from a given offset known at compile time.
> +        ///
> +        /// Bound checks are performed on compile time, hence if the =
offset is not known at compile
> +        /// time, the build will fail.
> +        $(#[$attr])*
> +        #[inline]
> +        pub fn $name(&self, value: $type_name, offset: usize) {
> +            let addr =3D self.io_addr_assert::<$type_name>(offset);
> +
> +            // SAFETY: By the type invariant `addr` is a valid =
address for MMIO operations.
> +            unsafe { bindings::$name(value, addr as _, ) }
> +        }
> +
> +        /// Write IO data from a given offset.
> +        ///
> +        /// Bound checks are performed on runtime, it fails if the =
offset (plus the type size) is
> +        /// out of bounds.
> +        $(#[$attr])*
> +        pub fn $try_name(&self, value: $type_name, offset: usize) -> =
Result {
> +            let addr =3D self.io_addr::<$type_name>(offset)?;
> +
> +            // SAFETY: By the type invariant `addr` is a valid =
address for MMIO operations.
> +            unsafe { bindings::$name(value, addr as _) }
> +            Ok(())
> +        }
> +    };
> +}
> +
> +impl<const SIZE: usize> Io<SIZE> {
> +    /// Converts an `IoRaw` into an `Io` instance, providing the =
accessors to the MMIO mapping.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `addr` is the start of a valid I/O =
mapped memory region of size
> +    /// `maxsize`.
> +    pub unsafe fn from_raw<'a>(raw: &IoRaw<SIZE>) -> &'a Self {
> +        // SAFETY: `Io` is a transparent wrapper around `IoRaw`.
> +        unsafe { &*core::ptr::from_ref(raw).cast() }
> +    }
> +
> +    /// Returns the base address of this mapping.
> +    #[inline]
> +    pub fn addr(&self) -> usize {
> +        self.0.addr()
> +    }
> +
> +    /// Returns the maximum size of this mapping.
> +    #[inline]
> +    pub fn maxsize(&self) -> usize {
> +        self.0.maxsize()
> +    }
> +
> +    #[inline]
> +    const fn offset_valid<U>(offset: usize, size: usize) -> bool {
> +        let type_size =3D core::mem::size_of::<U>();
> +        if let Some(end) =3D offset.checked_add(type_size) {
> +            end <=3D size && offset % type_size =3D=3D 0
> +        } else {
> +            false
> +        }
> +    }
> +
> +    #[inline]
> +    fn io_addr<U>(&self, offset: usize) -> Result<usize> {
> +        if !Self::offset_valid::<U>(offset, self.maxsize()) {
> +            return Err(EINVAL);
> +        }
> +
> +        // Probably no need to check, since the safety requirements =
of `Self::new` guarantee that
> +        // this can't overflow.
> +        self.addr().checked_add(offset).ok_or(EINVAL)
> +    }
> +
> +    #[inline]
> +    fn io_addr_assert<U>(&self, offset: usize) -> usize {
> +        build_assert!(Self::offset_valid::<U>(offset, SIZE));
> +
> +        self.addr() + offset
> +    }
> +
> +    define_read!(readb, try_readb, u8);
> +    define_read!(readw, try_readw, u16);
> +    define_read!(readl, try_readl, u32);
> +    define_read!(
> +        #[cfg(CONFIG_64BIT)]
> +        readq,
> +        try_readq,
> +        u64
> +    );
> +
> +    define_read!(readb_relaxed, try_readb_relaxed, u8);
> +    define_read!(readw_relaxed, try_readw_relaxed, u16);
> +    define_read!(readl_relaxed, try_readl_relaxed, u32);
> +    define_read!(
> +        #[cfg(CONFIG_64BIT)]
> +        readq_relaxed,
> +        try_readq_relaxed,
> +        u64
> +    );
> +
> +    define_write!(writeb, try_writeb, u8);
> +    define_write!(writew, try_writew, u16);
> +    define_write!(writel, try_writel, u32);
> +    define_write!(
> +        #[cfg(CONFIG_64BIT)]
> +        writeq,
> +        try_writeq,
> +        u64
> +    );
> +
> +    define_write!(writeb_relaxed, try_writeb_relaxed, u8);
> +    define_write!(writew_relaxed, try_writew_relaxed, u16);
> +    define_write!(writel_relaxed, try_writel_relaxed, u32);
> +    define_write!(
> +        #[cfg(CONFIG_64BIT)]
> +        writeq_relaxed,
> +        try_writeq_relaxed,
> +        u64
> +    );
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 200c5f99a805..d1f30b1a05fb 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -79,6 +79,7 @@
>=20
> #[doc(hidden)]
> pub use bindings;
> +pub mod io;
> pub use macros;
> pub use uapi;
>=20
> --=20
> 2.47.0
>=20

I rebased platform::IoMem on top of this, and it still works fine.

As I said, I am testing it by modifying the compatible in =
`rust_driver_platform`, and
I=E2=80=99ve been able to successfully map and read from a memory-mapped =
device register.

It=E2=80=99s a read-only register containing some information about the =
device, and the value
read matches what we get in the C driver.

Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Daniel Almeida  <daniel.almeida@collabora.com>


