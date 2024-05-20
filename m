Return-Path: <linux-pci+bounces-7684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0408CA1D6
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 20:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 382E8B2279A
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 18:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FD9137744;
	Mon, 20 May 2024 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J0URmMVf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248B81CA81;
	Mon, 20 May 2024 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716228862; cv=none; b=LU0B0zE0MRPg4L4dMa9fyhcJFD5X0cPlQI0E1lsWspBU+dnyhRyIyqM8+DtDhr1nUbzkHABeGgFiGh+jqv2bqnWdS8pOvzgpGs8i3/eJQumhJvv9IFb8v3j1W1wWYlDMrCZC+rg3yKdCCu/RvUMbpSp6v8s+hQ9aHdl/4zTUxnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716228862; c=relaxed/simple;
	bh=m6bHTXykoFx6Hbb7YiKl6wWWVCoM3d/dk+VUEkUxdTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCoSdt24/Wui5yUi+Gsl9HazX4/Q9cOiHOsxOpBPfQOI2uKF7/pIJ+xq/4l63Pj/bhirizk0FRRcS8y7zItvcaiuZxDTKeK99fmP63RafLlGlLyfrdE09LWDpSzMDeniZu8RfTGXSWyE1yaCWhhbzuqow98qlTfpa/kedEmJvY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J0URmMVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29541C2BD10;
	Mon, 20 May 2024 18:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716228861;
	bh=m6bHTXykoFx6Hbb7YiKl6wWWVCoM3d/dk+VUEkUxdTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J0URmMVfwcBDfVPn15SmvvswWdTvsLI9XaIKVNRCNiWYcHET0l3DnPumiDi/1xuF3
	 uNuAynPa3UWjYqkRLGgt1FuKOYqvMCddSHMLpjVvV/Uue0/2sA74N53kfhUj89I4U3
	 vHzos9mcG4nzuqfjclAvBaO3pGEnkwotkGhjl0DA=
Date: Mon, 20 May 2024 20:14:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 02/11] rust: add driver abstraction
Message-ID: <2024052045-lived-retiree-d8b9@gregkh>
References: <20240520172554.182094-1-dakr@redhat.com>
 <20240520172554.182094-3-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520172554.182094-3-dakr@redhat.com>

On Mon, May 20, 2024 at 07:25:39PM +0200, Danilo Krummrich wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> This defines general functionality related to registering drivers with
> their respective subsystems, and registering modules that implement
> drivers.
> 
> Co-developed-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> Co-developed-by: Andreas Hindborg <a.hindborg@samsung.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  rust/kernel/driver.rs        | 492 +++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs           |   4 +-
>  rust/macros/module.rs        |   2 +-
>  samples/rust/rust_minimal.rs |   2 +-
>  samples/rust/rust_print.rs   |   2 +-
>  5 files changed, 498 insertions(+), 4 deletions(-)
>  create mode 100644 rust/kernel/driver.rs
> 
> diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> new file mode 100644
> index 000000000000..e0cfc36d47ff
> --- /dev/null
> +++ b/rust/kernel/driver.rs
> @@ -0,0 +1,492 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Generic support for drivers of different buses (e.g., PCI, Platform, Amba, etc.).
> +//!
> +//! Each bus/subsystem is expected to implement [`DriverOps`], which allows drivers to register
> +//! using the [`Registration`] class.

Why are you creating new "names" here?  "DriverOps" is part of a 'struct
device_driver' why are you separating it out here?  And what is
'Registration'?  That's a bus/class thing, not a driver thing.

And be very careful of the use of the word 'class' here, remember, there
is 'struct class' as part of the driver model :)

> +use crate::{
> +    alloc::{box_ext::BoxExt, flags::*},
> +    error::code::*,
> +    error::Result,
> +    str::CStr,
> +    sync::Arc,
> +    ThisModule,
> +};
> +use alloc::boxed::Box;
> +use core::{cell::UnsafeCell, marker::PhantomData, ops::Deref, pin::Pin};
> +
> +/// A subsystem (e.g., PCI, Platform, Amba, etc.) that allows drivers to be written for it.
> +pub trait DriverOps {

Again, why is this not called DeviceDriver?

> +    /// The type that holds information about the registration. This is typically a struct defined
> +    /// by the C portion of the kernel.
> +    type RegType: Default;
> +
> +    /// Registers a driver.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `reg` must point to valid, initialised, and writable memory. It may be modified by this
> +    /// function to hold registration state.
> +    ///
> +    /// On success, `reg` must remain pinned and valid until the matching call to
> +    /// [`DriverOps::unregister`].
> +    unsafe fn register(
> +        reg: *mut Self::RegType,
> +        name: &'static CStr,
> +        module: &'static ThisModule,
> +    ) -> Result;
> +
> +    /// Unregisters a driver previously registered with [`DriverOps::register`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// `reg` must point to valid writable memory, initialised by a previous successful call to
> +    /// [`DriverOps::register`].
> +    unsafe fn unregister(reg: *mut Self::RegType);
> +}
> +
> +/// The registration of a driver.
> +pub struct Registration<T: DriverOps> {
> +    is_registered: bool,

Why does a driver need to know if it is registered or not?  Only the
driver core cares about that, please do not expose that, it's racy and
should not be relied on.

> +    concrete_reg: UnsafeCell<T::RegType>,
> +}
> +
> +// SAFETY: `Registration` has no fields or methods accessible via `&Registration`, so it is safe to
> +// share references to it with multiple threads as nothing can be done.
> +unsafe impl<T: DriverOps> Sync for Registration<T> {}
> +
> +impl<T: DriverOps> Registration<T> {
> +    /// Creates a new instance of the registration object.
> +    pub fn new() -> Self {
> +        Self {
> +            is_registered: false,
> +            concrete_reg: UnsafeCell::new(T::RegType::default()),
> +        }
> +    }
> +
> +    /// Allocates a pinned registration object and registers it.
> +    ///
> +    /// Returns a pinned heap-allocated representation of the registration.
> +    pub fn new_pinned(name: &'static CStr, module: &'static ThisModule) -> Result<Pin<Box<Self>>> {
> +        let mut reg = Pin::from(Box::new(Self::new(), GFP_KERNEL)?);
> +        reg.as_mut().register(name, module)?;
> +        Ok(reg)
> +    }
> +
> +    /// Registers a driver with its subsystem.
> +    ///
> +    /// It must be pinned because the memory block that represents the registration is potentially
> +    /// self-referential.
> +    pub fn register(
> +        self: Pin<&mut Self>,
> +        name: &'static CStr,
> +        module: &'static ThisModule,
> +    ) -> Result {
> +        // SAFETY: We never move out of `this`.
> +        let this = unsafe { self.get_unchecked_mut() };
> +        if this.is_registered {
> +            // Already registered.
> +            return Err(EINVAL);
> +        }
> +
> +        // SAFETY: `concrete_reg` was initialised via its default constructor. It is only freed
> +        // after `Self::drop` is called, which first calls `T::unregister`.
> +        unsafe { T::register(this.concrete_reg.get(), name, module) }?;
> +
> +        this.is_registered = true;

Again, the driver core knows if it is registered or not, that's all that
matters, the rust side should never care.

> +        Ok(())
> +    }
> +}
> +
> +impl<T: DriverOps> Default for Registration<T> {
> +    fn default() -> Self {
> +        Self::new()
> +    }
> +}
> +
> +impl<T: DriverOps> Drop for Registration<T> {
> +    fn drop(&mut self) {
> +        if self.is_registered {
> +            // SAFETY: This path only runs if a previous call to `T::register` completed
> +            // successfully.
> +            unsafe { T::unregister(self.concrete_reg.get()) };

Can't the rust code ensure that this isn't run if register didn't
succeed?  Having a boolean feels really wrong here (can't that race?)

> +        }
> +    }
> +}
> +
> +/// Conversion from a device id to a raw device id.
> +///
> +/// This is meant to be implemented by buses/subsystems so that they can use [`IdTable`] to
> +/// guarantee (at compile-time) zero-termination of device id tables provided by drivers.
> +///
> +/// Originally, RawDeviceId was implemented as a const trait. However, this unstable feature is
> +/// broken/gone in 1.73. To work around this, turn IdArray::new() into a macro such that it can use
> +/// concrete types (which can still have const associated functions) instead of a trait.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that:
> +///   - [`RawDeviceId::ZERO`] is actually a zeroed-out version of the raw device id.
> +///   - [`RawDeviceId::to_rawid`] stores `offset` in the context/data field of the raw device id so
> +///     that buses can recover the pointer to the data.
> +pub unsafe trait RawDeviceId {
> +    /// The raw type that holds the device id.
> +    ///
> +    /// Id tables created from [`Self`] are going to hold this type in its zero-terminated array.
> +    type RawType: Copy;
> +
> +    /// A zeroed-out representation of the raw device id.
> +    ///
> +    /// Id tables created from [`Self`] use [`Self::ZERO`] as the sentinel to indicate the end of
> +    /// the table.
> +    const ZERO: Self::RawType;

All busses have their own way of creating "ids" and that is limited to
the bus code itself, why is any of this in the rust side?  What needs
this?  A bus will create the id for the devices it manages, and can use
it as part of the name it gives the device (but not required), so all of
this belongs to the bus, NOT to a driver, or a device.

> +}
> +
> +/// A zero-terminated device id array, followed by context data.

Why?  What is this for?

> +#[repr(C)]
> +pub struct IdArray<T: RawDeviceId, U, const N: usize> {
> +    ids: [T::RawType; N],
> +    sentinel: T::RawType,
> +    id_infos: [Option<U>; N],
> +}
> +
> +impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
> +    const U_NONE: Option<U> = None;
> +
> +    /// Returns an `IdTable` backed by `self`.
> +    ///
> +    /// This is used to essentially erase the array size.
> +    pub const fn as_table(&self) -> IdTable<'_, T, U> {
> +        IdTable {
> +            first: &self.ids[0],
> +            _p: PhantomData,
> +        }
> +    }
> +
> +    /// Creates a new instance of the array.
> +    ///
> +    /// The contents are derived from the given identifiers and context information.
> +    #[doc(hidden)]
> +    pub const unsafe fn new(raw_ids: [T::RawType; N], infos: [Option<U>; N]) -> Self
> +    where
> +        T: RawDeviceId + Copy,
> +        T::RawType: Copy + Clone,
> +    {
> +        Self {
> +            ids: raw_ids,
> +            sentinel: T::ZERO,
> +            id_infos: infos,
> +        }
> +    }
> +
> +    #[doc(hidden)]
> +    pub const fn get_offset(idx: usize) -> isize
> +    where
> +        T: RawDeviceId + Copy,
> +        T::RawType: Copy + Clone,
> +    {
> +        // SAFETY: We are only using this dummy value to get offsets.
> +        let array = unsafe { Self::new([T::ZERO; N], [Self::U_NONE; N]) };
> +        // SAFETY: Both pointers are within `array` (or one byte beyond), consequently they are
> +        // derived from the same allocated object. We are using a `u8` pointer, whose size 1,
> +        // so the pointers are necessarily 1-byte aligned.
> +        let ret = unsafe {
> +            (&array.id_infos[idx] as *const _ as *const u8)
> +                .offset_from(&array.ids[idx] as *const _ as _)
> +        };
> +        core::mem::forget(array);
> +        ret
> +    }
> +}
> +
> +// Creates a new ID array. This is a macro so it can take as a parameter the concrete ID type in
> +// order to call to_rawid() on it, and still remain const. This is necessary until a new
> +// const_trait_impl implementation lands, since the existing implementation was removed in Rust
> +// 1.73.

Again, what are these id lists for?  Busses work on individual ids that
they create dynamically.

You aren't thinking this is an id that could be used to match devices to
drivers, are you?  That's VERY bus specific, and also specified already
in .c code for those busses and passed to userspace.  That doesn't
belong here.

If this isn't that list, what exactly is this?

> +#[macro_export]
> +#[doc(hidden)]
> +macro_rules! _new_id_array {
> +    (($($args:tt)*), $id_type:ty) => {{
> +        /// Creates a new instance of the array.
> +        ///
> +        /// The contents are derived from the given identifiers and context information.
> +        const fn new< U, const N: usize>(ids: [$id_type; N], infos: [Option<U>; N])
> +            -> $crate::driver::IdArray<$id_type, U, N>
> +        where
> +            $id_type: $crate::driver::RawDeviceId + Copy,
> +            <$id_type as $crate::driver::RawDeviceId>::RawType: Copy + Clone,
> +        {
> +            let mut raw_ids =
> +                [<$id_type as $crate::driver::RawDeviceId>::ZERO; N];
> +            let mut i = 0usize;
> +            while i < N {
> +                let offset: isize = $crate::driver::IdArray::<$id_type, U, N>::get_offset(i);
> +                raw_ids[i] = ids[i].to_rawid(offset);
> +                i += 1;
> +            }
> +
> +            // SAFETY: We are passing valid arguments computed with the correct offsets.
> +            unsafe {
> +                $crate::driver::IdArray::<$id_type, U, N>::new(raw_ids, infos)
> +            }
> +       }
> +
> +        new($($args)*)
> +    }}
> +}
> +
> +/// A device id table.
> +///
> +/// The table is guaranteed to be zero-terminated and to be followed by an array of context data of
> +/// type `Option<U>`.
> +pub struct IdTable<'a, T: RawDeviceId, U> {
> +    first: &'a T::RawType,
> +    _p: PhantomData<&'a U>,
> +}

All busses have different ways of matching drivers to devices, and they
might be called a "device id table" and it might not.  The driver core
doesn't care, and neither should this rust code.  That's all
bus-specific and unique to each and every one of them.  None of this
should be needed here at all.

> +
> +impl<T: RawDeviceId, U> AsRef<T::RawType> for IdTable<'_, T, U> {
> +    fn as_ref(&self) -> &T::RawType {
> +        self.first
> +    }
> +}
> +
> +/// Counts the number of parenthesis-delimited, comma-separated items.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::count_paren_items;
> +///
> +/// assert_eq!(0, count_paren_items!());
> +/// assert_eq!(1, count_paren_items!((A)));
> +/// assert_eq!(1, count_paren_items!((A),));
> +/// assert_eq!(2, count_paren_items!((A), (B)));
> +/// assert_eq!(2, count_paren_items!((A), (B),));
> +/// assert_eq!(3, count_paren_items!((A), (B), (C)));
> +/// assert_eq!(3, count_paren_items!((A), (B), (C),));
> +/// ```
> +#[macro_export]
> +macro_rules! count_paren_items {
> +    (($($item:tt)*), $($remaining:tt)*) => { 1 + $crate::count_paren_items!($($remaining)*) };
> +    (($($item:tt)*)) => { 1 };
> +    () => { 0 };
> +}

Shouldn't this go in some common header somewhere?  Why is this here?

> +
> +/// Converts a comma-separated list of pairs into an array with the first element. That is, it
> +/// discards the second element of the pair.
> +///
> +/// Additionally, it automatically introduces a type if the first element is warpped in curly
> +/// braces, for example, if it's `{v: 10}`, it becomes `X { v: 10 }`; this is to avoid repeating
> +/// the type.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::first_item;
> +///
> +/// #[derive(PartialEq, Debug)]
> +/// struct X {
> +///     v: u32,
> +/// }
> +///
> +/// assert_eq!([] as [X; 0], first_item!(X, ));
> +/// assert_eq!([X { v: 10 }], first_item!(X, ({ v: 10 }, Y)));
> +/// assert_eq!([X { v: 10 }], first_item!(X, ({ v: 10 }, Y),));
> +/// assert_eq!([X { v: 10 }], first_item!(X, (X { v: 10 }, Y)));
> +/// assert_eq!([X { v: 10 }], first_item!(X, (X { v: 10 }, Y),));
> +/// assert_eq!([X { v: 10 }, X { v: 20 }], first_item!(X, ({ v: 10 }, Y), ({ v: 20 }, Y)));
> +/// assert_eq!([X { v: 10 }, X { v: 20 }], first_item!(X, ({ v: 10 }, Y), ({ v: 20 }, Y),));
> +/// assert_eq!([X { v: 10 }, X { v: 20 }], first_item!(X, (X { v: 10 }, Y), (X { v: 20 }, Y)));
> +/// assert_eq!([X { v: 10 }, X { v: 20 }], first_item!(X, (X { v: 10 }, Y), (X { v: 20 }, Y),));
> +/// assert_eq!([X { v: 10 }, X { v: 20 }, X { v: 30 }],
> +///            first_item!(X, ({ v: 10 }, Y), ({ v: 20 }, Y), ({v: 30}, Y)));
> +/// assert_eq!([X { v: 10 }, X { v: 20 }, X { v: 30 }],
> +///            first_item!(X, ({ v: 10 }, Y), ({ v: 20 }, Y), ({v: 30}, Y),));
> +/// assert_eq!([X { v: 10 }, X { v: 20 }, X { v: 30 }],
> +///            first_item!(X, (X { v: 10 }, Y), (X { v: 20 }, Y), (X {v: 30}, Y)));
> +/// assert_eq!([X { v: 10 }, X { v: 20 }, X { v: 30 }],
> +///            first_item!(X, (X { v: 10 }, Y), (X { v: 20 }, Y), (X {v: 30}, Y),));
> +/// ```
> +#[macro_export]
> +macro_rules! first_item {
> +    ($id_type:ty, $(({$($first:tt)*}, $second:expr)),* $(,)?) => {
> +        {
> +            type IdType = $id_type;
> +            [$(IdType{$($first)*},)*]
> +        }
> +    };
> +    ($id_type:ty, $(($first:expr, $second:expr)),* $(,)?) => { [$($first,)*] };
> +}

Again, why here?

> +
> +/// Converts a comma-separated list of pairs into an array with the second element. That is, it
> +/// discards the first element of the pair.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::second_item;
> +///
> +/// assert_eq!([] as [u32; 0], second_item!());
> +/// assert_eq!([10u32], second_item!((X, 10u32)));
> +/// assert_eq!([10u32], second_item!((X, 10u32),));
> +/// assert_eq!([10u32], second_item!(({ X }, 10u32)));
> +/// assert_eq!([10u32], second_item!(({ X }, 10u32),));
> +/// assert_eq!([10u32, 20], second_item!((X, 10u32), (X, 20)));
> +/// assert_eq!([10u32, 20], second_item!((X, 10u32), (X, 20),));
> +/// assert_eq!([10u32, 20], second_item!(({ X }, 10u32), ({ X }, 20)));
> +/// assert_eq!([10u32, 20], second_item!(({ X }, 10u32), ({ X }, 20),));
> +/// assert_eq!([10u32, 20, 30], second_item!((X, 10u32), (X, 20), (X, 30)));
> +/// assert_eq!([10u32, 20, 30], second_item!((X, 10u32), (X, 20), (X, 30),));
> +/// assert_eq!([10u32, 20, 30], second_item!(({ X }, 10u32), ({ X }, 20), ({ X }, 30)));
> +/// assert_eq!([10u32, 20, 30], second_item!(({ X }, 10u32), ({ X }, 20), ({ X }, 30),));
> +/// ```
> +#[macro_export]
> +macro_rules! second_item {
> +    ($(({$($first:tt)*}, $second:expr)),* $(,)?) => { [$($second,)*] };
> +    ($(($first:expr, $second:expr)),* $(,)?) => { [$($second,)*] };
> +}

Again, why here?

> +
> +/// Defines a new constant [`IdArray`] with a concise syntax.
> +///
> +/// It is meant to be used by buses and subsystems to create a similar macro with their device id
> +/// type already specified, i.e., with fewer parameters to the end user.
> +///
> +/// # Examples
> +///
> +// TODO: Exported but not usable by kernel modules (requires `const_trait_impl`).
> +/// ```ignore
> +/// #![feature(const_trait_impl)]
> +/// # use kernel::{define_id_array, driver::RawDeviceId};
> +///
> +/// #[derive(Copy, Clone)]
> +/// struct Id(u32);
> +///
> +/// // SAFETY: `ZERO` is all zeroes and `to_rawid` stores `offset` as the second element of the raw
> +/// // device id pair.
> +/// unsafe impl const RawDeviceId for Id {
> +///     type RawType = (u64, isize);
> +///     const ZERO: Self::RawType = (0, 0);
> +///     fn to_rawid(&self, offset: isize) -> Self::RawType {
> +///         (self.0 as u64 + 1, offset)
> +///     }
> +/// }
> +///
> +/// define_id_array!(A1, Id, (), []);
> +/// define_id_array!(A2, Id, &'static [u8], [(Id(10), None)]);
> +/// define_id_array!(A3, Id, &'static [u8], [(Id(10), Some(b"id1")), ]);
> +/// define_id_array!(A4, Id, &'static [u8], [(Id(10), Some(b"id1")), (Id(20), Some(b"id2"))]);
> +/// define_id_array!(A5, Id, &'static [u8], [(Id(10), Some(b"id1")), (Id(20), Some(b"id2")), ]);
> +/// define_id_array!(A6, Id, &'static [u8], [(Id(10), None), (Id(20), Some(b"id2")), ]);
> +/// define_id_array!(A7, Id, &'static [u8], [(Id(10), Some(b"id1")), (Id(20), None), ]);
> +/// define_id_array!(A8, Id, &'static [u8], [(Id(10), None), (Id(20), None), ]);
> +/// ```

Again, busses define this, put this in the bus-specific code that you
wish to define/match with, it does not belong here as every bus does it
differently.  Not all the world is PCI :)

> +#[macro_export]
> +macro_rules! define_id_array {
> +    ($table_name:ident, $id_type:ty, $data_type:ty, [ $($t:tt)* ]) => {
> +        const $table_name:
> +            $crate::driver::IdArray<$id_type, $data_type, { $crate::count_paren_items!($($t)*) }> =
> +                $crate::_new_id_array!((
> +                    $crate::first_item!($id_type, $($t)*), $crate::second_item!($($t)*)), $id_type);
> +    };
> +}
> +
> +/// Defines a new constant [`IdTable`] with a concise syntax.
> +///
> +/// It is meant to be used by buses and subsystems to create a similar macro with their device id
> +/// type already specified, i.e., with fewer parameters to the end user.
> +///
> +/// # Examples
> +///
> +// TODO: Exported but not usable by kernel modules (requires `const_trait_impl`).
> +/// ```ignore
> +/// #![feature(const_trait_impl)]
> +/// # use kernel::{define_id_table, driver::RawDeviceId};
> +///
> +/// #[derive(Copy, Clone)]
> +/// struct Id(u32);
> +///
> +/// // SAFETY: `ZERO` is all zeroes and `to_rawid` stores `offset` as the second element of the raw
> +/// // device id pair.
> +/// unsafe impl const RawDeviceId for Id {
> +///     type RawType = (u64, isize);
> +///     const ZERO: Self::RawType = (0, 0);
> +///     fn to_rawid(&self, offset: isize) -> Self::RawType {
> +///         (self.0 as u64 + 1, offset)
> +///     }
> +/// }
> +///
> +/// define_id_table!(T1, Id, &'static [u8], [(Id(10), None)]);
> +/// define_id_table!(T2, Id, &'static [u8], [(Id(10), Some(b"id1")), ]);
> +/// define_id_table!(T3, Id, &'static [u8], [(Id(10), Some(b"id1")), (Id(20), Some(b"id2"))]);
> +/// define_id_table!(T4, Id, &'static [u8], [(Id(10), Some(b"id1")), (Id(20), Some(b"id2")), ]);
> +/// define_id_table!(T5, Id, &'static [u8], [(Id(10), None), (Id(20), Some(b"id2")), ]);
> +/// define_id_table!(T6, Id, &'static [u8], [(Id(10), Some(b"id1")), (Id(20), None), ]);
> +/// define_id_table!(T7, Id, &'static [u8], [(Id(10), None), (Id(20), None), ]);
> +/// ```
> +#[macro_export]
> +macro_rules! define_id_table {
> +    ($table_name:ident, $id_type:ty, $data_type:ty, [ $($t:tt)* ]) => {
> +        const $table_name: Option<$crate::driver::IdTable<'static, $id_type, $data_type>> = {
> +            $crate::define_id_array!(ARRAY, $id_type, $data_type, [ $($t)* ]);
> +            Some(ARRAY.as_table())
> +        };
> +    };
> +}

Again, see above, does not belong here.

> +
> +/// Custom code within device removal.

You better define the heck out of "device removal" as specified last
time this all came up.  From what I can see here, this is totally wrong
and confusing and will be a mess.

Do it right, name it properly.

I'm not reviewingn beyond here, sorry.  It's the merge window and I
shouldn't have even looked at this until next week anyway.

But I was hoping that the whole long rant I gave last time would be
addressed at least a little bit.  I don't see that it has :(


> +pub trait DeviceRemoval {
> +    /// Cleans resources up when the device is removed.
> +    ///
> +    /// This is called when a device is removed and offers implementers the chance to run some code
> +    /// that cleans state up.
> +    fn device_remove(&self);
> +}
> +
> +impl DeviceRemoval for () {
> +    fn device_remove(&self) {}
> +}
> +
> +impl<T: DeviceRemoval> DeviceRemoval for Arc<T> {
> +    fn device_remove(&self) {
> +        self.deref().device_remove();
> +    }
> +}
> +
> +impl<T: DeviceRemoval> DeviceRemoval for Box<T> {
> +    fn device_remove(&self) {
> +        self.deref().device_remove();
> +    }
> +}
> +
> +/// A kernel module that only registers the given driver on init.
> +///
> +/// This is a helper struct to make it easier to define single-functionality modules, in this case,
> +/// modules that offer a single driver.
> +pub struct Module<T: DriverOps> {
> +    _driver: Pin<Box<Registration<T>>>,
> +}
> +
> +impl<T: DriverOps> crate::Module for Module<T> {
> +    fn init(name: &'static CStr, module: &'static ThisModule) -> Result<Self> {
> +        Ok(Self {
> +            _driver: Registration::new_pinned(name, module)?,
> +        })
> +    }
> +}
> +
> +/// Declares a kernel module that exposes a single driver.

There is no requirement that a kernel module only exposes a single
driver, so what exactly is this used for?  Is this some attempt to make
the module_driver() macro in rust?  Why?  Only add something like that
if you really need it (i.e. you have a bus in rust and you want the
benifit of having that macro to save you some lines of code.)  I don't
see that happening here...

greg k-h

