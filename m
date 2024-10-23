Return-Path: <linux-pci+bounces-15120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A228C9ACC33
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 16:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C925B21810
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 14:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C9E1BE23F;
	Wed, 23 Oct 2024 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+PoQIej"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338A2E56A;
	Wed, 23 Oct 2024 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693437; cv=none; b=JzN5edASNXQWhWPqTa/UVPlP39E1z5uKO8eBUOwzxHxgGDGcOxPtAMAEuRU87oyw6OLGDI3lr7NATEMrRsqTFSCy9Hppom9iUIvUsJ2vQe8HU9f0uf+3rW0j3XDuY/zVuCqesoUNliyJntxIo1eNthoI4p0jyFFQV+1bQIfVs1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693437; c=relaxed/simple;
	bh=GSKWRm7+KiJmw4ntv/ripLnaQt+ggFemxRWiNQsqGxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ow0sscsGboOaTybcLhDdolgjAT9QTi3h43EdssV8TijEks0P1HOdH6lnVs/QntkcMgutVFK0A0FfiwFCPgr2gPJpRAuL57K8GsemQ+rMjuiHnIFkRFSWSuF2Etf6ECfHkp/i4ELzD7Vu/Dd4iC82UNhILZZg3CMX0Obmq9nxkDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+PoQIej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55A9C4CEC6;
	Wed, 23 Oct 2024 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693436;
	bh=GSKWRm7+KiJmw4ntv/ripLnaQt+ggFemxRWiNQsqGxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+PoQIejVNC+d9UpeYu7lvUT1gGdGf7SMf24VgTMpN7DTaZQtFFjOK6K5xBp7Qv8T
	 NnMtirHIDUQKrSGNtQcnmtXv1u2sve41YM4ABKHqUdz4N9GCgDK3a++h4gpdoB/v/g
	 hRPc9dE6yE0aBVtH+utpIv4XZlufsTUnCytk6fj3HThNpjYtrJL7fiuiubn0FUEI/9
	 rRcBS0tr23alae5QSUI4Mc5SoDuY7Lp6ZEsghKg9OMMMcfFW5RMYZ6arNxlUbLmmS7
	 dLCuJtC5f0IxqZ+PM/Kyh2ECUDMEYEna9EBx4vXzoCjGP8bR3eQVhnQkqpvhyQxEtM
	 gwBipMQxMzFfg==
Date: Wed, 23 Oct 2024 09:23:55 -0500
From: Rob Herring <robh@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
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
Message-ID: <20241023142355.GA623906-robh@kernel.org>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-16-dakr@kernel.org>
 <20241022234712.GB1848992-robh@kernel.org>
 <ZxibWpcswZxz5A07@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxibWpcswZxz5A07@pollux>

On Wed, Oct 23, 2024 at 08:44:42AM +0200, Danilo Krummrich wrote:
> On Tue, Oct 22, 2024 at 06:47:12PM -0500, Rob Herring wrote:
> > On Tue, Oct 22, 2024 at 11:31:52PM +0200, Danilo Krummrich wrote:
> > > Implement the basic platform bus abstractions required to write a basic
> > > platform driver. This includes the following data structures:
> > > 
> > > The `platform::Driver` trait represents the interface to the driver and
> > > provides `pci::Driver::probe` for the driver to implement.
> > > 
> > > The `platform::Device` abstraction represents a `struct platform_device`.
> > > 
> > > In order to provide the platform bus specific parts to a generic
> > > `driver::Registration` the `driver::RegistrationOps` trait is implemented
> > > by `platform::Adapter`.
> > > 
> > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > ---
> > >  MAINTAINERS                     |   1 +
> > >  rust/bindings/bindings_helper.h |   1 +
> > >  rust/helpers/helpers.c          |   1 +
> > >  rust/helpers/platform.c         |  13 ++
> > >  rust/kernel/lib.rs              |   1 +
> > >  rust/kernel/platform.rs         | 217 ++++++++++++++++++++++++++++++++
> > >  6 files changed, 234 insertions(+)
> > >  create mode 100644 rust/helpers/platform.c
> > >  create mode 100644 rust/kernel/platform.rs
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 87eb9a7869eb..173540375863 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -6985,6 +6985,7 @@ F:	rust/kernel/device.rs
> > >  F:	rust/kernel/device_id.rs
> > >  F:	rust/kernel/devres.rs
> > >  F:	rust/kernel/driver.rs
> > > +F:	rust/kernel/platform.rs
> > >  
> > >  DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
> > >  M:	Nishanth Menon <nm@ti.com>
> > > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> > > index 312f03cbdce9..217c776615b9 100644
> > > --- a/rust/bindings/bindings_helper.h
> > > +++ b/rust/bindings/bindings_helper.h
> > > @@ -18,6 +18,7 @@
> > >  #include <linux/of_device.h>
> > >  #include <linux/pci.h>
> > >  #include <linux/phy.h>
> > > +#include <linux/platform_device.h>
> > >  #include <linux/refcount.h>
> > >  #include <linux/sched.h>
> > >  #include <linux/slab.h>
> > > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > > index 8bc6e9735589..663cdc2a45e0 100644
> > > --- a/rust/helpers/helpers.c
> > > +++ b/rust/helpers/helpers.c
> > > @@ -17,6 +17,7 @@
> > >  #include "kunit.c"
> > >  #include "mutex.c"
> > >  #include "page.c"
> > > +#include "platform.c"
> > >  #include "pci.c"
> > >  #include "rbtree.c"
> > >  #include "rcu.c"
> > > diff --git a/rust/helpers/platform.c b/rust/helpers/platform.c
> > > new file mode 100644
> > > index 000000000000..ab9b9f317301
> > > --- /dev/null
> > > +++ b/rust/helpers/platform.c
> > > @@ -0,0 +1,13 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include <linux/platform_device.h>
> > > +
> > > +void *rust_helper_platform_get_drvdata(const struct platform_device *pdev)
> > > +{
> > > +	return platform_get_drvdata(pdev);
> > > +}
> > > +
> > > +void rust_helper_platform_set_drvdata(struct platform_device *pdev, void *data)
> > > +{
> > > +	platform_set_drvdata(pdev, data);
> > > +}
> > > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > > index 5946f59f1688..9e8dcd6d7c01 100644
> > > --- a/rust/kernel/lib.rs
> > > +++ b/rust/kernel/lib.rs
> > > @@ -53,6 +53,7 @@
> > >  pub mod net;
> > >  pub mod of;
> > >  pub mod page;
> > > +pub mod platform;
> > >  pub mod prelude;
> > >  pub mod print;
> > >  pub mod rbtree;
> > > diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> > > new file mode 100644
> > > index 000000000000..addf5356f44f
> > > --- /dev/null
> > > +++ b/rust/kernel/platform.rs
> > > @@ -0,0 +1,217 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +//! Abstractions for the platform bus.
> > > +//!
> > > +//! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
> > > +
> > > +use crate::{
> > > +    bindings, container_of, device,
> > > +    device_id::RawDeviceId,
> > > +    driver,
> > > +    error::{to_result, Result},
> > > +    of,
> > > +    prelude::*,
> > > +    str::CStr,
> > > +    types::{ARef, ForeignOwnable},
> > > +    ThisModule,
> > > +};
> > > +
> > > +/// An adapter for the registration of platform drivers.
> > > +pub struct Adapter<T: Driver>(T);
> > > +
> > > +impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
> > > +    type RegType = bindings::platform_driver;
> > > +
> > > +    fn register(
> > > +        pdrv: &mut Self::RegType,
> > > +        name: &'static CStr,
> > > +        module: &'static ThisModule,
> > > +    ) -> Result {
> > > +        pdrv.driver.name = name.as_char_ptr();
> > > +        pdrv.probe = Some(Self::probe_callback);
> > > +
> > > +        // Both members of this union are identical in data layout and semantics.
> > > +        pdrv.__bindgen_anon_1.remove = Some(Self::remove_callback);
> > > +        pdrv.driver.of_match_table = T::ID_TABLE.as_ptr();
> > > +
> > > +        // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
> > > +        to_result(unsafe { bindings::__platform_driver_register(pdrv, module.0) })
> > > +    }
> > > +
> > > +    fn unregister(pdrv: &mut Self::RegType) {
> > > +        // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
> > > +        unsafe { bindings::platform_driver_unregister(pdrv) };
> > > +    }
> > > +}
> > > +
> > > +impl<T: Driver + 'static> Adapter<T> {
> > > +    fn id_info(pdev: &Device) -> Option<&'static T::IdInfo> {
> > > +        let table = T::ID_TABLE;
> > > +        let id = T::of_match_device(pdev)?;
> > > +
> > > +        Some(table.info(id.index()))
> > > +    }
> > > +
> > > +    extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> core::ffi::c_int {
> > > +        // SAFETY: The platform bus only ever calls the probe callback with a valid `pdev`.
> > > +        let dev = unsafe { device::Device::from_raw(&mut (*pdev).dev) };
> > > +        // SAFETY: `dev` is guaranteed to be embedded in a valid `struct platform_device` by the
> > > +        // call above.
> > > +        let mut pdev = unsafe { Device::from_dev(dev) };
> > > +
> > > +        let info = Self::id_info(&pdev);
> > > +        match T::probe(&mut pdev, info) {
> > > +            Ok(data) => {
> > > +                // Let the `struct platform_device` own a reference of the driver's private data.
> > > +                // SAFETY: By the type invariant `pdev.as_raw` returns a valid pointer to a
> > > +                // `struct platform_device`.
> > > +                unsafe { bindings::platform_set_drvdata(pdev.as_raw(), data.into_foreign() as _) };
> > > +            }
> > > +            Err(err) => return Error::to_errno(err),
> > > +        }
> > > +
> > > +        0
> > > +    }
> > > +
> > > +    extern "C" fn remove_callback(pdev: *mut bindings::platform_device) {
> > > +        // SAFETY: `pdev` is a valid pointer to a `struct platform_device`.
> > > +        let ptr = unsafe { bindings::platform_get_drvdata(pdev) };
> > > +
> > > +        // SAFETY: `remove_callback` is only ever called after a successful call to
> > > +        // `probe_callback`, hence it's guaranteed that `ptr` points to a valid and initialized
> > > +        // `KBox<T>` pointer created through `KBox::into_foreign`.
> > > +        let _ = unsafe { KBox::<T>::from_foreign(ptr) };
> > > +    }
> > > +}
> > > +
> > > +/// Declares a kernel module that exposes a single platform driver.
> > > +///
> > > +/// # Examples
> > > +///
> > > +/// ```ignore
> > > +/// kernel::module_platform_driver! {
> > > +///     type: MyDriver,
> > > +///     name: "Module name",
> > > +///     author: "Author name",
> > > +///     description: "Description",
> > > +///     license: "GPL v2",
> > > +/// }
> > > +/// ```
> > > +#[macro_export]
> > > +macro_rules! module_platform_driver {
> > > +    ($($f:tt)*) => {
> > > +        $crate::module_driver!(<T>, $crate::platform::Adapter<T>, { $($f)* });
> > > +    };
> > > +}
> > > +
> > > +/// IdTable type for platform drivers.
> > > +pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<of::DeviceId, T>;
> > > +
> > > +/// The platform driver trait.
> > > +///
> > > +/// # Example
> > > +///
> > > +///```
> > > +/// # use kernel::{bindings, c_str, of, platform};
> > > +///
> > > +/// struct MyDriver;
> > > +///
> > > +/// kernel::of_device_table!(
> > > +///     OF_TABLE,
> > > +///     MODULE_OF_TABLE,
> > > +///     <MyDriver as platform::Driver>::IdInfo,
> > > +///     [
> > > +///         (of::DeviceId::new(c_str!("redhat,my-device")), ())
> > 
> > All compatible strings have to be documented as do vendor prefixes and 
> > I don't think "redhat" is one. An exception is you can use 
> > "test,<whatever>" and not document it.
> 
> Yeah, I copied that from the sample driver, where it's probably wrong too.
> 
> I guess "vendor,device" would be illegal as well?

Yes.

> > There's a check for undocumented compatibles. I guess I'll have to add 
> > rust parsing to it...
> > 
> > BTW, how do you compile this code in the kernel? 
> 
> You mean this example? It gets compiled as a KUnit doctest, but it obvously
> doesn't execute anything, so it's a compile only test.

Yes. That's a question for my own education.

> > 
> > > +///     ]
> > > +/// );
> > > +///
> > > +/// impl platform::Driver for MyDriver {
> > > +///     type IdInfo = ();
> > > +///     const ID_TABLE: platform::IdTable<Self::IdInfo> = &OF_TABLE;
> > > +///
> > > +///     fn probe(
> > > +///         _pdev: &mut platform::Device,
> > > +///         _id_info: Option<&Self::IdInfo>,
> > > +///     ) -> Result<Pin<KBox<Self>>> {
> > > +///         Err(ENODEV)
> > > +///     }
> > > +/// }
> > > +///```
> > > +/// Drivers must implement this trait in order to get a platform driver registered. Please refer to
> > > +/// the `Adapter` documentation for an example.
> > > +pub trait Driver {
> > > +    /// The type holding information about each device id supported by the driver.
> > > +    ///
> > > +    /// TODO: Use associated_type_defaults once stabilized:
> > > +    ///
> > > +    /// type IdInfo: 'static = ();
> > > +    type IdInfo: 'static;
> > > +
> > > +    /// The table of device ids supported by the driver.
> > > +    const ID_TABLE: IdTable<Self::IdInfo>;

Another thing. I don't think this is quite right. Well, this part is 
fine, but assigning the DT table to it is not. The underlying C code has 
2 id tables in struct device_driver (DT and ACPI) and then the bus 
specific one in the struct ${bus}_driver.

> > > +
> > > +    /// Platform driver probe.
> > > +    ///
> > > +    /// Called when a new platform device is added or discovered.
> > > +    /// Implementers should attempt to initialize the device here.
> > > +    fn probe(dev: &mut Device, id_info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>>;
> > > +
> > > +    /// Find the [`of::DeviceId`] within [`Driver::ID_TABLE`] matching the given [`Device`], if any.
> > > +    fn of_match_device(pdev: &Device) -> Option<&of::DeviceId> {
> > 
> > Is this visible to drivers? It shouldn't be.
> 
> Yeah, I think we should just remove it. Looking at struct of_device_id, it
> doesn't contain any useful information for a driver. I think when I added this I
> was a bit in "autopilot" mode from the PCI stuff, where struct pci_device_id is
> useful to drivers.

TBC, you mean other than *data, right? If so, I agree. 

The DT type and name fields are pretty much legacy, so I don't think the 
rust bindings need to worry about them until someone converts Sparc and 
PowerMac drivers to rust (i.e. never).

I would guess the PCI cases might be questionable, too. Like DT, drivers 
may be accessing the table fields, but that's not best practice. All the 
match fields are stored in pci_dev, so why get them from the match 
table? 

Rob

