Return-Path: <linux-pci+bounces-7699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E726A8CA7B4
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 07:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7302B22556
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 05:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678E640BF5;
	Tue, 21 May 2024 05:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtYpIcUe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423783D963;
	Tue, 21 May 2024 05:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716270186; cv=none; b=A8D2C0h4Co0ocvLc8wLhA+1Br02tm13fVYNESlibLVyWMVDZTDXHEj9jp4uCmAcLwdyUaXfEVCWz5tfz3sEK3fyT+VRmii6gK1WreS7u3yKA9/TJc18VLnELIBjjhirVSWtSxi3MooTVZ5LQOGiqCdmZvgiUWjp7ZQB26ibARew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716270186; c=relaxed/simple;
	bh=WXDULDhlS+P1LFJpdyb14ettr8QU9Kdr6GqCzoSRiXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVm6m9SH5hinMFDePetDq9eGvuxmlh4zJuy+S8oRehUx2dcYFhvto9C0zX6EjPLMMnMyF+7emCSklpwBR3+uUccLAHJdH0j1ai3pNqAq3Xos88/wsJPVcW/bHlmshk0DVO/LTqoS9RW9UxhBQ770GT6WQHqvZNr4CQHiePgtYJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtYpIcUe; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a387fbc9so822584166b.1;
        Mon, 20 May 2024 22:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716270182; x=1716874982; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eN6lzfF0TF9YL/tL1ueWEL5A+JkIp+mxATt/0iGA22A=;
        b=LtYpIcUekMeIrppMl4CDd9sNGNIyx8I6V8fu123NeLFK+l/YZqRf1Dt4/L2SKPIXnG
         L0jAmMXF/su82yWi05pckVfLxr9Do9O5hczTWaJ1LKmBmtvi7g4+I/KlEdz6NB/tapcs
         gyC0+NB1t4CwX5RA4UK4idKUtVm72qbY/rz32npu/5TY2dIv3DpXDTZDYO+GhOtrnC0V
         4qq5c8vkStH52M7Nyw9q7mMx8ka+b0Q5EZxHV0qWDclcP+uf083z7ZdTJ5KZyinW5hGB
         A938zbf0tEvJBgU6CwMUTYj0X1nocbsRGZwiKkpbIto4oKcJzl8jgvuT8ZXvXXSl+ASJ
         KkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716270182; x=1716874982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eN6lzfF0TF9YL/tL1ueWEL5A+JkIp+mxATt/0iGA22A=;
        b=WRMqH19+lgIhKx0Sf9m6C1WleaXagbfExwPoTnbRd0yN7pdby/BTTAqHQjKStb0s2Q
         cD8iDjRMGCRa6wlMddnNI+RnZ1fUge3pVW724CsoyciDaHIex8RVZSP05XdF9s/gTLuE
         saGCFhdCFTVRCWCqBwOcVAQHT1aU+j4vWWtzm01AT9NIlREmkobx+SELc7ZpPZ4B1Tx5
         IJYGOnMUkqeQ4GCVvuxkFyCQxFwGdyGfywgF45UIJ8hIibUiE8sieHqTGvYG/g4P/ELX
         9X+uFZAq1tQHqFKjZdVrCCBBLko1hR4HSs7UwXALIUG7ARCPJUzIYPGd7QldSa64QLGL
         sf1w==
X-Forwarded-Encrypted: i=1; AJvYcCVCPgNixZwK0uwSKp90ijzF/BAdZPC0+GatK2hpoqqdFy6VMxVQDr+TVjf5oJaXyKmAI9PuYhazPnvAM3XYWXHzSSB5ebogg1FWC7/1IKuRivg5JuJne2GvoZBwOzsGALR5gu1YA+NXR73XmjAquFZCKYdLXCv3/ABRmQu3yRqETtBVbK52m4k=
X-Gm-Message-State: AOJu0YzZiWPt4/jDHQoxW6JRIMwzHjQITDhvaR7/DBWL/rPPV29ea/ot
	7tKcSm9tfRDIatB07XqdnmTQ24dVSmHULKPAxStMCokC1Zsv+um4ksioftbTlfDM3BElENYIBlz
	OUToHoUp3nCnddjKq/F1yX8oGNqo=
X-Google-Smtp-Source: AGHT+IFWv44tk0TgIYASqqilojZdgUrZpLjalRFnNy7WwtNlAq63N3NzPaLK6F2nKTP8D27Er9z/+gTMYINFHxSyuyM=
X-Received: by 2002:a17:906:9a8f:b0:a62:7ef:ca4a with SMTP id
 a640c23a62f3a-a6207efcb29mr162655266b.70.1716270182130; Mon, 20 May 2024
 22:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520172554.182094-1-dakr@redhat.com> <20240520172554.182094-3-dakr@redhat.com>
 <2024052045-lived-retiree-d8b9@gregkh>
In-Reply-To: <2024052045-lived-retiree-d8b9@gregkh>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 21 May 2024 15:42:50 +1000
Message-ID: <CAPM=9txQPmYU593MAR97yyCoHaQR3o+E_N1D2mJjP23Gevzddw@mail.gmail.com>
Subject: Re: [RFC PATCH 02/11] rust: add driver abstraction
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Danilo Krummrich <dakr@redhat.com>, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 May 2024 at 04:14, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, May 20, 2024 at 07:25:39PM +0200, Danilo Krummrich wrote:
> > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> >
> > This defines general functionality related to registering drivers with
> > their respective subsystems, and registering modules that implement
> > drivers.
> >
> > Co-developed-by: Asahi Lina <lina@asahilina.net>
> > Signed-off-by: Asahi Lina <lina@asahilina.net>
> > Co-developed-by: Andreas Hindborg <a.hindborg@samsung.com>
> > Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > ---
> >  rust/kernel/driver.rs        | 492 +++++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs           |   4 +-
> >  rust/macros/module.rs        |   2 +-
> >  samples/rust/rust_minimal.rs |   2 +-
> >  samples/rust/rust_print.rs   |   2 +-
> >  5 files changed, 498 insertions(+), 4 deletions(-)
> >  create mode 100644 rust/kernel/driver.rs
> >
> > diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> > new file mode 100644
> > index 000000000000..e0cfc36d47ff
> > --- /dev/null
> > +++ b/rust/kernel/driver.rs
> > @@ -0,0 +1,492 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Generic support for drivers of different buses (e.g., PCI, Platform, Amba, etc.).
> > +//!
> > +//! Each bus/subsystem is expected to implement [`DriverOps`], which allows drivers to register
> > +//! using the [`Registration`] class.
>
> Why are you creating new "names" here?  "DriverOps" is part of a 'struct
> device_driver' why are you separating it out here?  And what is
> 'Registration'?  That's a bus/class thing, not a driver thing.
>
> And be very careful of the use of the word 'class' here, remember, there
> is 'struct class' as part of the driver model :)
>
> > +use crate::{
> > +    alloc::{box_ext::BoxExt, flags::*},
> > +    error::code::*,
> > +    error::Result,
> > +    str::CStr,
> > +    sync::Arc,
> > +    ThisModule,
> > +};
> > +use alloc::boxed::Box;
> > +use core::{cell::UnsafeCell, marker::PhantomData, ops::Deref, pin::Pin};
> > +
> > +/// A subsystem (e.g., PCI, Platform, Amba, etc.) that allows drivers to be written for it.
> > +pub trait DriverOps {
>
> Again, why is this not called DeviceDriver?

This is not the same as the C device_driver, it might mildly align in
concept with it, but I'm not sure it shares enough to align it name
wise with the C one.

> > +    /// The type that holds information about the registration. This is typically a struct defined
> > +    /// by the C portion of the kernel.
> > +    type RegType: Default;
> > +
> > +    /// Registers a driver.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `reg` must point to valid, initialised, and writable memory. It may be modified by this
> > +    /// function to hold registration state.
> > +    ///
> > +    /// On success, `reg` must remain pinned and valid until the matching call to
> > +    /// [`DriverOps::unregister`].
> > +    unsafe fn register(
> > +        reg: *mut Self::RegType,
> > +        name: &'static CStr,
> > +        module: &'static ThisModule,
> > +    ) -> Result;
> > +
> > +    /// Unregisters a driver previously registered with [`DriverOps::register`].
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `reg` must point to valid writable memory, initialised by a previous successful call to
> > +    /// [`DriverOps::register`].
> > +    unsafe fn unregister(reg: *mut Self::RegType);
> > +}
> > +
> > +/// The registration of a driver.
> > +pub struct Registration<T: DriverOps> {
> > +    is_registered: bool,
>
> Why does a driver need to know if it is registered or not?  Only the
> driver core cares about that, please do not expose that, it's racy and
> should not be relied on.

From the C side this does look unusual because on the C side something
like struct pci_driver is statically allocated everywhere.
In this rust abstraction, these are allocated dynamically, so instead
of just it always being safe to just call register/unregister
with static memory, a flag is kept around to say if the unregister
should happen at all, as the memory may have
been allocated but never registered. This is all the Registration is
for, it's tracking the bus _driver structure allocation, and
whether the bus register/unregister have been called since the object
was allocated.

I'm not sure it makes sense (or if you can at all), have a static like
pci_driver object here to match how C does things.

> > +impl<T: DriverOps> Drop for Registration<T> {
> > +    fn drop(&mut self) {
> > +        if self.is_registered {
> > +            // SAFETY: This path only runs if a previous call to `T::register` completed
> > +            // successfully.
> > +            unsafe { T::unregister(self.concrete_reg.get()) };
>
> Can't the rust code ensure that this isn't run if register didn't
> succeed?  Having a boolean feels really wrong here (can't that race?)

There might be a way of using Option<> here but I don't think it adds
anything over and above using an explicit bool.

> > +///
> > +/// This is meant to be implemented by buses/subsystems so that they can use [`IdTable`] to
> > +/// guarantee (at compile-time) zero-termination of device id tables provided by drivers.
> > +///
> > +/// Originally, RawDeviceId was implemented as a const trait. However, this unstable feature is
> > +/// broken/gone in 1.73. To work around this, turn IdArray::new() into a macro such that it can use
> > +/// concrete types (which can still have const associated functions) instead of a trait.
> > +///
> > +/// # Safety
> > +///
> > +/// Implementers must ensure that:
> > +///   - [`RawDeviceId::ZERO`] is actually a zeroed-out version of the raw device id.
> > +///   - [`RawDeviceId::to_rawid`] stores `offset` in the context/data field of the raw device id so
> > +///     that buses can recover the pointer to the data.
> > +pub unsafe trait RawDeviceId {
> > +    /// The raw type that holds the device id.
> > +    ///
> > +    /// Id tables created from [`Self`] are going to hold this type in its zero-terminated array.
> > +    type RawType: Copy;
> > +
> > +    /// A zeroed-out representation of the raw device id.
> > +    ///
> > +    /// Id tables created from [`Self`] use [`Self::ZERO`] as the sentinel to indicate the end of
> > +    /// the table.
> > +    const ZERO: Self::RawType;
>
> All busses have their own way of creating "ids" and that is limited to
> the bus code itself, why is any of this in the rust side?  What needs
> this?  A bus will create the id for the devices it manages, and can use
> it as part of the name it gives the device (but not required), so all of
> this belongs to the bus, NOT to a driver, or a device.

Consider this a base class (Trait) for bus specific IDs.

> > +}
> > +
> > +// Creates a new ID array. This is a macro so it can take as a parameter the concrete ID type in
> > +// order to call to_rawid() on it, and still remain const. This is necessary until a new
> > +// const_trait_impl implementation lands, since the existing implementation was removed in Rust
> > +// 1.73.
>
> Again, what are these id lists for?  Busses work on individual ids that
> they create dynamically.
>
> You aren't thinking this is an id that could be used to match devices to
> drivers, are you?  That's VERY bus specific, and also specified already
> in .c code for those busses and passed to userspace.  That doesn't
> belong here.
>
> If this isn't that list, what exactly is this?

Rust traits have to be specified somewhere, a RawDeviceId is the basis
for other DeviceId Traits to be implemented on top off, those then
talk to the C side ones.

All the pci and nova code is posted as well for you to work this out,
like you asked for. The use cases are all there to be reviewed, and
should help answer these sorts of questions.


>
> > +#[macro_export]
> > +#[doc(hidden)]
> > +macro_rules! _new_id_array {
> > +    (($($args:tt)*), $id_type:ty) => {{
> > +        /// Creates a new instance of the array.
> > +        ///
> > +        /// The contents are derived from the given identifiers and context information.
> > +        const fn new< U, const N: usize>(ids: [$id_type; N], infos: [Option<U>; N])
> > +            -> $crate::driver::IdArray<$id_type, U, N>
> > +        where
> > +            $id_type: $crate::driver::RawDeviceId + Copy,
> > +            <$id_type as $crate::driver::RawDeviceId>::RawType: Copy + Clone,
> > +        {
> > +            let mut raw_ids =
> > +                [<$id_type as $crate::driver::RawDeviceId>::ZERO; N];
> > +            let mut i = 0usize;
> > +            while i < N {
> > +                let offset: isize = $crate::driver::IdArray::<$id_type, U, N>::get_offset(i);
> > +                raw_ids[i] = ids[i].to_rawid(offset);
> > +                i += 1;
> > +            }
> > +
> > +            // SAFETY: We are passing valid arguments computed with the correct offsets.
> > +            unsafe {
> > +                $crate::driver::IdArray::<$id_type, U, N>::new(raw_ids, infos)
> > +            }
> > +       }
> > +
> > +        new($($args)*)
> > +    }}
> > +}
> > +
> > +/// A device id table.
> > +///
> > +/// The table is guaranteed to be zero-terminated and to be followed by an array of context data of
> > +/// type `Option<U>`.
> > +pub struct IdTable<'a, T: RawDeviceId, U> {
> > +    first: &'a T::RawType,
> > +    _p: PhantomData<&'a U>,
> > +}
>
> All busses have different ways of matching drivers to devices, and they
> might be called a "device id table" and it might not.  The driver core
> doesn't care, and neither should this rust code.  That's all
> bus-specific and unique to each and every one of them.  None of this
> should be needed here at all.

This is just a base Trait, for the bus specifics to implement.
Consider it a bunch of C macros or a bunch of C++ vfuncs, whatever
mental model helps more.

> Shouldn't this go in some common header somewhere?  Why is this here?

Again to reiterate what Danilo said, rust has no header files. Things
that in C we would put in header files (macros, struct definitions,
inlines) go into rust code and other rust code references it.

Now there might be some sense in splitting things further into
separate rust files if this concept is going to confuse people, and
what is "core" device code, and what is "template" device code. But
I'm not sure how much sense that makes really.

Maybe the device table stuff should be in a separate file?

> > +/// Custom code within device removal.
>
> You better define the heck out of "device removal" as specified last
> time this all came up.  From what I can see here, this is totally wrong
> and confusing and will be a mess.
>
> Do it right, name it properly.
>
> I'm not reviewingn beyond here, sorry.  It's the merge window and I
> shouldn't have even looked at this until next week anyway.
>
> But I was hoping that the whole long rant I gave last time would be
> addressed at least a little bit.  I don't see that it has :(

I won't comment too much on the specifics here, but you've twice got
to this stage, said something is wrong, change it, and given no
actionable feedback on what is wrong, or what to change.

I've looked at this code for a few hours today with the device docs
and core code and can't spot what you are seeing that is wrong here,
which means I don't expect anyone else is going to unless you can help
educate us more.

Dave.

