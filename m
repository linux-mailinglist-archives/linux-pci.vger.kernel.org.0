Return-Path: <linux-pci+bounces-15096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A35D39ABF19
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 08:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C533F1C2344B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 06:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409AE14D70E;
	Wed, 23 Oct 2024 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvKhH1gJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB0E14D6EB;
	Wed, 23 Oct 2024 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729665891; cv=none; b=HLTDDgdqzT0U9AxEu5BM2EzcM6rY2xvLNJSpQiEI8J2kVIxMu/gMAV9fNwntnCkzd5O+HFdi4keAVAbeKIum/DXq0yj7RUlWK/zuNW+J0lu5QwwnB+EuJszeFTzVkZvDd9Na3gz2QqvEDrma8Ij5vBooXlkxgHPBMfIFjGQI3A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729665891; c=relaxed/simple;
	bh=rzEk3BOSftDKTKSCxGLtfyh/P3vXUtgt17SCKP00L6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qebmHPOw0LAFV1sfndAlgwcrNmh+kFV8fLXFpvv14GMB8CqmOOz5Ubmxk/JBWYwBPKnYsP+7AlAmZBMVGjgzPxvltk5iKv4mFiIUmiEaT/KwxCJYfy2Zo435x3prj8SmIbaV9yVXvnpyLgAx9+NnMCMyNE5Ss3joHsIxewrrrjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvKhH1gJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A263AC4CEC7;
	Wed, 23 Oct 2024 06:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729665890;
	bh=rzEk3BOSftDKTKSCxGLtfyh/P3vXUtgt17SCKP00L6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HvKhH1gJw8EQyYYBxmzmb9QhMB4D1KHbE8cMHRJwxpYM6p05kNX5g2RMQjGK88cc0
	 1geejHY4TFos6z2oa9xbpuo9Vp9+tNwA16KahAvEvwBfftU/sBH2M+U0q5AxT98FLI
	 VWNmMNrvsc8TkRTLu0A8rt+g+iIMzsGKTNqmj86ZbHY5MiWbBHAMPQlPPBOy0tigu+
	 iOiWoeBc/Uh/W29Ns4b34bMxZrGDbgggrquzwIxSEgZz9Sdc2P0XSBhCpv0OCJUXRf
	 4OuORNPj5jaoxQZxbNHPXCN1EhTU5TGClqlNj87/P7A0rdKThKoTBNU61ol6Fc5uJU
	 A2SJ9W2QOrbOw==
Date: Wed, 23 Oct 2024 08:44:42 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	daniel.almeida@collabora.com, saravanak@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 15/16] rust: platform: add basic platform device /
 driver abstractions
Message-ID: <ZxibWpcswZxz5A07@pollux>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-16-dakr@kernel.org>
 <20241022234712.GB1848992-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022234712.GB1848992-robh@kernel.org>

On Tue, Oct 22, 2024 at 06:47:12PM -0500, Rob Herring wrote:
> On Tue, Oct 22, 2024 at 11:31:52PM +0200, Danilo Krummrich wrote:
> > Implement the basic platform bus abstractions required to write a basic
> > platform driver. This includes the following data structures:
> > 
> > The `platform::Driver` trait represents the interface to the driver and
> > provides `pci::Driver::probe` for the driver to implement.
> > 
> > The `platform::Device` abstraction represents a `struct platform_device`.
> > 
> > In order to provide the platform bus specific parts to a generic
> > `driver::Registration` the `driver::RegistrationOps` trait is implemented
> > by `platform::Adapter`.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  MAINTAINERS                     |   1 +
> >  rust/bindings/bindings_helper.h |   1 +
> >  rust/helpers/helpers.c          |   1 +
> >  rust/helpers/platform.c         |  13 ++
> >  rust/kernel/lib.rs              |   1 +
> >  rust/kernel/platform.rs         | 217 ++++++++++++++++++++++++++++++++
> >  6 files changed, 234 insertions(+)
> >  create mode 100644 rust/helpers/platform.c
> >  create mode 100644 rust/kernel/platform.rs
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 87eb9a7869eb..173540375863 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6985,6 +6985,7 @@ F:	rust/kernel/device.rs
> >  F:	rust/kernel/device_id.rs
> >  F:	rust/kernel/devres.rs
> >  F:	rust/kernel/driver.rs
> > +F:	rust/kernel/platform.rs
> >  
> >  DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
> >  M:	Nishanth Menon <nm@ti.com>
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> > index 312f03cbdce9..217c776615b9 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -18,6 +18,7 @@
> >  #include <linux/of_device.h>
> >  #include <linux/pci.h>
> >  #include <linux/phy.h>
> > +#include <linux/platform_device.h>
> >  #include <linux/refcount.h>
> >  #include <linux/sched.h>
> >  #include <linux/slab.h>
> > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > index 8bc6e9735589..663cdc2a45e0 100644
> > --- a/rust/helpers/helpers.c
> > +++ b/rust/helpers/helpers.c
> > @@ -17,6 +17,7 @@
> >  #include "kunit.c"
> >  #include "mutex.c"
> >  #include "page.c"
> > +#include "platform.c"
> >  #include "pci.c"
> >  #include "rbtree.c"
> >  #include "rcu.c"
> > diff --git a/rust/helpers/platform.c b/rust/helpers/platform.c
> > new file mode 100644
> > index 000000000000..ab9b9f317301
> > --- /dev/null
> > +++ b/rust/helpers/platform.c
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/platform_device.h>
> > +
> > +void *rust_helper_platform_get_drvdata(const struct platform_device *pdev)
> > +{
> > +	return platform_get_drvdata(pdev);
> > +}
> > +
> > +void rust_helper_platform_set_drvdata(struct platform_device *pdev, void *data)
> > +{
> > +	platform_set_drvdata(pdev, data);
> > +}
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 5946f59f1688..9e8dcd6d7c01 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -53,6 +53,7 @@
> >  pub mod net;
> >  pub mod of;
> >  pub mod page;
> > +pub mod platform;
> >  pub mod prelude;
> >  pub mod print;
> >  pub mod rbtree;
> > diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> > new file mode 100644
> > index 000000000000..addf5356f44f
> > --- /dev/null
> > +++ b/rust/kernel/platform.rs
> > @@ -0,0 +1,217 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Abstractions for the platform bus.
> > +//!
> > +//! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
> > +
> > +use crate::{
> > +    bindings, container_of, device,
> > +    device_id::RawDeviceId,
> > +    driver,
> > +    error::{to_result, Result},
> > +    of,
> > +    prelude::*,
> > +    str::CStr,
> > +    types::{ARef, ForeignOwnable},
> > +    ThisModule,
> > +};
> > +
> > +/// An adapter for the registration of platform drivers.
> > +pub struct Adapter<T: Driver>(T);
> > +
> > +impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
> > +    type RegType = bindings::platform_driver;
> > +
> > +    fn register(
> > +        pdrv: &mut Self::RegType,
> > +        name: &'static CStr,
> > +        module: &'static ThisModule,
> > +    ) -> Result {
> > +        pdrv.driver.name = name.as_char_ptr();
> > +        pdrv.probe = Some(Self::probe_callback);
> > +
> > +        // Both members of this union are identical in data layout and semantics.
> > +        pdrv.__bindgen_anon_1.remove = Some(Self::remove_callback);
> > +        pdrv.driver.of_match_table = T::ID_TABLE.as_ptr();
> > +
> > +        // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
> > +        to_result(unsafe { bindings::__platform_driver_register(pdrv, module.0) })
> > +    }
> > +
> > +    fn unregister(pdrv: &mut Self::RegType) {
> > +        // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
> > +        unsafe { bindings::platform_driver_unregister(pdrv) };
> > +    }
> > +}
> > +
> > +impl<T: Driver + 'static> Adapter<T> {
> > +    fn id_info(pdev: &Device) -> Option<&'static T::IdInfo> {
> > +        let table = T::ID_TABLE;
> > +        let id = T::of_match_device(pdev)?;
> > +
> > +        Some(table.info(id.index()))
> > +    }
> > +
> > +    extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> core::ffi::c_int {
> > +        // SAFETY: The platform bus only ever calls the probe callback with a valid `pdev`.
> > +        let dev = unsafe { device::Device::from_raw(&mut (*pdev).dev) };
> > +        // SAFETY: `dev` is guaranteed to be embedded in a valid `struct platform_device` by the
> > +        // call above.
> > +        let mut pdev = unsafe { Device::from_dev(dev) };
> > +
> > +        let info = Self::id_info(&pdev);
> > +        match T::probe(&mut pdev, info) {
> > +            Ok(data) => {
> > +                // Let the `struct platform_device` own a reference of the driver's private data.
> > +                // SAFETY: By the type invariant `pdev.as_raw` returns a valid pointer to a
> > +                // `struct platform_device`.
> > +                unsafe { bindings::platform_set_drvdata(pdev.as_raw(), data.into_foreign() as _) };
> > +            }
> > +            Err(err) => return Error::to_errno(err),
> > +        }
> > +
> > +        0
> > +    }
> > +
> > +    extern "C" fn remove_callback(pdev: *mut bindings::platform_device) {
> > +        // SAFETY: `pdev` is a valid pointer to a `struct platform_device`.
> > +        let ptr = unsafe { bindings::platform_get_drvdata(pdev) };
> > +
> > +        // SAFETY: `remove_callback` is only ever called after a successful call to
> > +        // `probe_callback`, hence it's guaranteed that `ptr` points to a valid and initialized
> > +        // `KBox<T>` pointer created through `KBox::into_foreign`.
> > +        let _ = unsafe { KBox::<T>::from_foreign(ptr) };
> > +    }
> > +}
> > +
> > +/// Declares a kernel module that exposes a single platform driver.
> > +///
> > +/// # Examples
> > +///
> > +/// ```ignore
> > +/// kernel::module_platform_driver! {
> > +///     type: MyDriver,
> > +///     name: "Module name",
> > +///     author: "Author name",
> > +///     description: "Description",
> > +///     license: "GPL v2",
> > +/// }
> > +/// ```
> > +#[macro_export]
> > +macro_rules! module_platform_driver {
> > +    ($($f:tt)*) => {
> > +        $crate::module_driver!(<T>, $crate::platform::Adapter<T>, { $($f)* });
> > +    };
> > +}
> > +
> > +/// IdTable type for platform drivers.
> > +pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<of::DeviceId, T>;
> > +
> > +/// The platform driver trait.
> > +///
> > +/// # Example
> > +///
> > +///```
> > +/// # use kernel::{bindings, c_str, of, platform};
> > +///
> > +/// struct MyDriver;
> > +///
> > +/// kernel::of_device_table!(
> > +///     OF_TABLE,
> > +///     MODULE_OF_TABLE,
> > +///     <MyDriver as platform::Driver>::IdInfo,
> > +///     [
> > +///         (of::DeviceId::new(c_str!("redhat,my-device")), ())
> 
> All compatible strings have to be documented as do vendor prefixes and 
> I don't think "redhat" is one. An exception is you can use 
> "test,<whatever>" and not document it.

Yeah, I copied that from the sample driver, where it's probably wrong too.

I guess "vendor,device" would be illegal as well?

> 
> There's a check for undocumented compatibles. I guess I'll have to add 
> rust parsing to it...
> 
> BTW, how do you compile this code in the kernel? 

You mean this example? It gets compiled as a KUnit doctest, but it obvously
doesn't execute anything, so it's a compile only test.

> 
> > +///     ]
> > +/// );
> > +///
> > +/// impl platform::Driver for MyDriver {
> > +///     type IdInfo = ();
> > +///     const ID_TABLE: platform::IdTable<Self::IdInfo> = &OF_TABLE;
> > +///
> > +///     fn probe(
> > +///         _pdev: &mut platform::Device,
> > +///         _id_info: Option<&Self::IdInfo>,
> > +///     ) -> Result<Pin<KBox<Self>>> {
> > +///         Err(ENODEV)
> > +///     }
> > +/// }
> > +///```
> > +/// Drivers must implement this trait in order to get a platform driver registered. Please refer to
> > +/// the `Adapter` documentation for an example.
> > +pub trait Driver {
> > +    /// The type holding information about each device id supported by the driver.
> > +    ///
> > +    /// TODO: Use associated_type_defaults once stabilized:
> > +    ///
> > +    /// type IdInfo: 'static = ();
> > +    type IdInfo: 'static;
> > +
> > +    /// The table of device ids supported by the driver.
> > +    const ID_TABLE: IdTable<Self::IdInfo>;
> > +
> > +    /// Platform driver probe.
> > +    ///
> > +    /// Called when a new platform device is added or discovered.
> > +    /// Implementers should attempt to initialize the device here.
> > +    fn probe(dev: &mut Device, id_info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>>;
> > +
> > +    /// Find the [`of::DeviceId`] within [`Driver::ID_TABLE`] matching the given [`Device`], if any.
> > +    fn of_match_device(pdev: &Device) -> Option<&of::DeviceId> {
> 
> Is this visible to drivers? It shouldn't be.

Yeah, I think we should just remove it. Looking at struct of_device_id, it
doesn't contain any useful information for a driver. I think when I added this I
was a bit in "autopilot" mode from the PCI stuff, where struct pci_device_id is
useful to drivers.

> I just removed most of the 
> calls of the C version earlier this year. Drivers should only need the 
> match data. The preferred driver C API is device_get_match_data(). That 
> is firmware agnostic and works for DT, ACPI and old platform 
> driver_data. Obviously, ACPI is not supported here, but it will be soon 
> enough. We could perhaps get away with not supporting the platform 
> driver_data because that's generally not used on anything in the last 10 
> years.

Otherwise `of_match_device` is only used in `probe_callback` to get the device
info structure, which we indeed should use device_get_match_data() for.

> 
> Another potential issue is keeping the match logic for probe and the 
> match logic for the data in sync. If you implement your own logic here 
> in rust and probe is using the C version, they might not be the same. 
> Best case, we have 2 implementations of the same thing.
> 
> > +        let table = Self::ID_TABLE;
> > +
> > +        // SAFETY:
> > +        // - `table` has static lifetime, hence it's valid for read,
> > +        // - `dev` is guaranteed to be valid while it's alive, and so is
> > +        //   `pdev.as_dev().as_raw()`.
> > +        let raw_id = unsafe { bindings::of_match_device(table.as_ptr(), pdev.as_dev().as_raw()) };
> 
> of_match_device depends on CONFIG_OF. There's an empty static inline, 
> but seems bindgen can't handle those. Prior versions added a helper 
> function, but that's going to scale terribly. Can we use an annotation 
> for CONFIG_OF here (assuming we can't get rid of using this directly)?
> 
> > +
> > +        if raw_id.is_null() {
> > +            None
> > +        } else {
> > +            // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and
> > +            // does not add additional invariants, so it's safe to transmute.
> > +            Some(unsafe { &*raw_id.cast::<of::DeviceId>() })
> > +        }
> > +    }
> > +}
> 

