Return-Path: <linux-pci+bounces-17699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466F79E448E
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 20:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD36166D25
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 19:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A944D1C3BE8;
	Wed,  4 Dec 2024 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ew5P/ekN"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B31A1B4130;
	Wed,  4 Dec 2024 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733340390; cv=pass; b=D/VUz0w5l6IfBkvIH4/ObSyHYwxF+CEGndgMbxcSIDtyBik2ET0BJjw05kS6G5JFWHB4yaZMM11EeAMfi4NMOwNn4Ud+95fW1RAD8UaGdJDs9bdAR5c6DBjmEQQ08fVGXQbehae861MaFvJQklTTwWbnHkx4pwXfDJzd2lHDGaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733340390; c=relaxed/simple;
	bh=h8ARnmfbTqF/cI3q9mowC7+FcZgp77jQGxY5HlVPKMU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ggD6OpOMUy4i7edSTO2d7L/zkm5emzUQhJ/L0/h+2D1YC+JbLgcVBOcfo7MHPIs/g4Rn54Rn8mCjjG/DLFZxEbq5FtwDI0aL6GrQHZo6HUgam2Dap5KUvczm5ADj31m4V18jgHmQNOMIPV1gU8BIQ29hw2r/NBXAcQBOhtdfth0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ew5P/ekN; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733340352; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XIwroMswiSsLiZ3HgtEZFwvaVmvR2N6pBF+Vt2d2mr72R7vZS4r26hLbYVEP3luaxIvZFKAzoBl4mS6kU6XmSHU+IiQcAMnudX1stUDfwSpaezqnhPl5Iw4QCOkeGr0EO92G+qWf9IqmbIuM1kmJJBdspRS4YttURnCbpYcQM9g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733340352; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iXSruM2DtO1V1jXF1qxqYiltGJ6X2Z7W1MHrcYL9i1k=; 
	b=gwD/aFMIjtpfd//dqdqUQ/HHPSpREM88fwB5DjrWtdA1aGf+VzsEMYYf8ZPWKeEQ/t2eIX/G1p5iOlaQJr79E/Y7h6vDIH0BbDMX2gO7QRfOI6nhtwVVYeJS7xRAqjBYDx4xBgk3RQIUx+YxdRGxn5NVSymwHYIxMV708ajxtKc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733340352;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=iXSruM2DtO1V1jXF1qxqYiltGJ6X2Z7W1MHrcYL9i1k=;
	b=ew5P/ekNO7qTA0tfv9Z+m25DEwH1Nj26NjGlST+5hFfBqXnNJNKPQD1KKw7SlFPD
	EVCosCCUjrdOvyGVc+BFQXf/qoUhVhRldDC6SsVUK8H5P5Nco1cHyZLPKTZ7UP3X2s8
	4zXHxa24cGe58pn9k0SLVujgkjz0EmJG+wDa3jfY=
Received: by mx.zohomail.com with SMTPS id 173334034960492.0857786888331;
	Wed, 4 Dec 2024 11:25:49 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v3 15/16] rust: platform: add basic platform device /
 driver abstractions
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20241022213221.2383-16-dakr@kernel.org>
Date: Wed, 4 Dec 2024 16:25:32 -0300
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
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7EA482EF-1D3E-4C3E-A805-4F404758610C@collabora.com>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-16-dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi Danilo,

> On 22 Oct 2024, at 18:31, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> Implement the basic platform bus abstractions required to write a =
basic
> platform driver. This includes the following data structures:
>=20
> The `platform::Driver` trait represents the interface to the driver =
and
> provides `pci::Driver::probe` for the driver to implement.
>=20
> The `platform::Device` abstraction represents a `struct =
platform_device`.
>=20
> In order to provide the platform bus specific parts to a generic
> `driver::Registration` the `driver::RegistrationOps` trait is =
implemented
> by `platform::Adapter`.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> MAINTAINERS                     |   1 +
> rust/bindings/bindings_helper.h |   1 +
> rust/helpers/helpers.c          |   1 +
> rust/helpers/platform.c         |  13 ++
> rust/kernel/lib.rs              |   1 +
> rust/kernel/platform.rs         | 217 ++++++++++++++++++++++++++++++++
> 6 files changed, 234 insertions(+)
> create mode 100644 rust/helpers/platform.c
> create mode 100644 rust/kernel/platform.rs
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 87eb9a7869eb..173540375863 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6985,6 +6985,7 @@ F: rust/kernel/device.rs
> F: rust/kernel/device_id.rs
> F: rust/kernel/devres.rs
> F: rust/kernel/driver.rs
> +F: rust/kernel/platform.rs
>=20
> DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
> M: Nishanth Menon <nm@ti.com>
> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
> index 312f03cbdce9..217c776615b9 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -18,6 +18,7 @@
> #include <linux/of_device.h>
> #include <linux/pci.h>
> #include <linux/phy.h>
> +#include <linux/platform_device.h>
> #include <linux/refcount.h>
> #include <linux/sched.h>
> #include <linux/slab.h>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 8bc6e9735589..663cdc2a45e0 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -17,6 +17,7 @@
> #include "kunit.c"
> #include "mutex.c"
> #include "page.c"
> +#include "platform.c"
> #include "pci.c"
> #include "rbtree.c"
> #include "rcu.c"
> diff --git a/rust/helpers/platform.c b/rust/helpers/platform.c
> new file mode 100644
> index 000000000000..ab9b9f317301
> --- /dev/null
> +++ b/rust/helpers/platform.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/platform_device.h>
> +
> +void *rust_helper_platform_get_drvdata(const struct platform_device =
*pdev)
> +{
> + return platform_get_drvdata(pdev);
> +}
> +
> +void rust_helper_platform_set_drvdata(struct platform_device *pdev, =
void *data)
> +{
> + platform_set_drvdata(pdev, data);
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 5946f59f1688..9e8dcd6d7c01 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -53,6 +53,7 @@
> pub mod net;
> pub mod of;
> pub mod page;
> +pub mod platform;
> pub mod prelude;
> pub mod print;
> pub mod rbtree;
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> new file mode 100644
> index 000000000000..addf5356f44f
> --- /dev/null
> +++ b/rust/kernel/platform.rs
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Abstractions for the platform bus.
> +//!
> +//! C header: =
[`include/linux/platform_device.h`](srctree/include/linux/platform_device.=
h)
> +
> +use crate::{
> +    bindings, container_of, device,
> +    device_id::RawDeviceId,
> +    driver,
> +    error::{to_result, Result},
> +    of,
> +    prelude::*,
> +    str::CStr,
> +    types::{ARef, ForeignOwnable},
> +    ThisModule,
> +};
> +
> +/// An adapter for the registration of platform drivers.
> +pub struct Adapter<T: Driver>(T);
> +
> +impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
> +    type RegType =3D bindings::platform_driver;
> +
> +    fn register(
> +        pdrv: &mut Self::RegType,
> +        name: &'static CStr,
> +        module: &'static ThisModule,
> +    ) -> Result {
> +        pdrv.driver.name =3D name.as_char_ptr();
> +        pdrv.probe =3D Some(Self::probe_callback);
> +
> +        // Both members of this union are identical in data layout =
and semantics.
> +        pdrv.__bindgen_anon_1.remove =3D Some(Self::remove_callback);
> +        pdrv.driver.of_match_table =3D T::ID_TABLE.as_ptr();
> +
> +        // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
> +        to_result(unsafe { bindings::__platform_driver_register(pdrv, =
module.0) })
> +    }
> +
> +    fn unregister(pdrv: &mut Self::RegType) {
> +        // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
> +        unsafe { bindings::platform_driver_unregister(pdrv) };
> +    }
> +}
> +
> +impl<T: Driver + 'static> Adapter<T> {
> +    fn id_info(pdev: &Device) -> Option<&'static T::IdInfo> {
> +        let table =3D T::ID_TABLE;
> +        let id =3D T::of_match_device(pdev)?;
> +
> +        Some(table.info(id.index()))
> +    }
> +
> +    extern "C" fn probe_callback(pdev: *mut =
bindings::platform_device) -> core::ffi::c_int {
> +        // SAFETY: The platform bus only ever calls the probe =
callback with a valid `pdev`.
> +        let dev =3D unsafe { device::Device::from_raw(&mut =
(*pdev).dev) };
> +        // SAFETY: `dev` is guaranteed to be embedded in a valid =
`struct platform_device` by the
> +        // call above.
> +        let mut pdev =3D unsafe { Device::from_dev(dev) };
> +
> +        let info =3D Self::id_info(&pdev);
> +        match T::probe(&mut pdev, info) {
> +            Ok(data) =3D> {
> +                // Let the `struct platform_device` own a reference =
of the driver's private data.
> +                // SAFETY: By the type invariant `pdev.as_raw` =
returns a valid pointer to a
> +                // `struct platform_device`.
> +                unsafe { =
bindings::platform_set_drvdata(pdev.as_raw(), data.into_foreign() as _) =
};
> +            }
> +            Err(err) =3D> return Error::to_errno(err),
> +        }
> +
> +        0
> +    }
> +
> +    extern "C" fn remove_callback(pdev: *mut =
bindings::platform_device) {
> +        // SAFETY: `pdev` is a valid pointer to a `struct =
platform_device`.
> +        let ptr =3D unsafe { bindings::platform_get_drvdata(pdev) };
> +
> +        // SAFETY: `remove_callback` is only ever called after a =
successful call to
> +        // `probe_callback`, hence it's guaranteed that `ptr` points =
to a valid and initialized
> +        // `KBox<T>` pointer created through `KBox::into_foreign`.
> +        let _ =3D unsafe { KBox::<T>::from_foreign(ptr) };
> +    }
> +}
> +
> +/// Declares a kernel module that exposes a single platform driver.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// kernel::module_platform_driver! {
> +///     type: MyDriver,
> +///     name: "Module name",
> +///     author: "Author name",
> +///     description: "Description",
> +///     license: "GPL v2",
> +/// }
> +/// ```
> +#[macro_export]
> +macro_rules! module_platform_driver {
> +    ($($f:tt)*) =3D> {
> +        $crate::module_driver!(<T>, $crate::platform::Adapter<T>, { =
$($f)* });
> +    };
> +}
> +
> +/// IdTable type for platform drivers.
> +pub type IdTable<T> =3D &'static dyn =
kernel::device_id::IdTable<of::DeviceId, T>;
> +
> +/// The platform driver trait.
> +///
> +/// # Example
> +///
> +///```
> +/// # use kernel::{bindings, c_str, of, platform};
> +///
> +/// struct MyDriver;
> +///
> +/// kernel::of_device_table!(
> +///     OF_TABLE,
> +///     MODULE_OF_TABLE,
> +///     <MyDriver as platform::Driver>::IdInfo,
> +///     [
> +///         (of::DeviceId::new(c_str!("redhat,my-device")), ())
> +///     ]
> +/// );
> +///
> +/// impl platform::Driver for MyDriver {
> +///     type IdInfo =3D ();
> +///     const ID_TABLE: platform::IdTable<Self::IdInfo> =3D =
&OF_TABLE;
> +///
> +///     fn probe(
> +///         _pdev: &mut platform::Device,
> +///         _id_info: Option<&Self::IdInfo>,
> +///     ) -> Result<Pin<KBox<Self>>> {
> +///         Err(ENODEV)
> +///     }
> +/// }
> +///```
> +/// Drivers must implement this trait in order to get a platform =
driver registered. Please refer to
> +/// the `Adapter` documentation for an example.
> +pub trait Driver {
> +    /// The type holding information about each device id supported =
by the driver.
> +    ///
> +    /// TODO: Use associated_type_defaults once stabilized:
> +    ///
> +    /// type IdInfo: 'static =3D ();
> +    type IdInfo: 'static;
> +
> +    /// The table of device ids supported by the driver.
> +    const ID_TABLE: IdTable<Self::IdInfo>;
> +
> +    /// Platform driver probe.
> +    ///
> +    /// Called when a new platform device is added or discovered.
> +    /// Implementers should attempt to initialize the device here.
> +    fn probe(dev: &mut Device, id_info: Option<&Self::IdInfo>) -> =
Result<Pin<KBox<Self>>>;
> +
> +    /// Find the [`of::DeviceId`] within [`Driver::ID_TABLE`] =
matching the given [`Device`], if any.
> +    fn of_match_device(pdev: &Device) -> Option<&of::DeviceId> {
> +        let table =3D Self::ID_TABLE;
> +
> +        // SAFETY:
> +        // - `table` has static lifetime, hence it's valid for read,
> +        // - `dev` is guaranteed to be valid while it's alive, and so =
is
> +        //   `pdev.as_dev().as_raw()`.
> +        let raw_id =3D unsafe { =
bindings::of_match_device(table.as_ptr(), pdev.as_dev().as_raw()) };
> +
> +        if raw_id.is_null() {
> +            None
> +        } else {
> +            // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper =
of `struct of_device_id` and
> +            // does not add additional invariants, so it's safe to =
transmute.
> +            Some(unsafe { &*raw_id.cast::<of::DeviceId>() })
> +        }
> +    }
> +}
> +
> +/// The platform device representation.
> +///
> +/// A platform device is based on an always reference counted =
`device:Device` instance. Cloning a
> +/// platform device, hence, also increments the base device' =
reference count.
> +///
> +/// # Invariants
> +///
> +/// `Device` holds a valid reference of `ARef<device::Device>` whose =
underlying `struct device` is a
> +/// member of a `struct platform_device`.
> +#[derive(Clone)]
> +pub struct Device(ARef<device::Device>);
> +
> +impl Device {
> +    /// Convert a raw kernel device into a `Device`
> +    ///
> +    /// # Safety
> +    ///
> +    /// `dev` must be an `Aref<device::Device>` whose underlying =
`bindings::device` is a member of a
> +    /// `bindings::platform_device`.
> +    unsafe fn from_dev(dev: ARef<device::Device>) -> Self {
> +        Self(dev)
> +    }
> +
> +    fn as_dev(&self) -> &device::Device {

This has to be pub, since a platform::Device is at least as useful as a =
device::Device.

IOW: if an API takes &device::Device, there is no reason why someone =
with a &platform::Device
shouldn=E2=80=99t be able to call it.

In particular, having this as private makes it impossible for a platform =
driver to use Abdiel=E2=80=99s DMA allocator at [0].

> +        &self.0
> +    }
> +
> +    fn as_raw(&self) -> *mut bindings::platform_device {
> +        // SAFETY: By the type invariant `self.0.as_raw` is a pointer =
to the `struct device`
> +        // embedded in `struct platform_device`.
> +        unsafe { container_of!(self.0.as_raw(), =
bindings::platform_device, dev) }.cast_mut()
> +    }
> +}
> +
> +impl AsRef<device::Device> for Device {
> +    fn as_ref(&self) -> &device::Device {
> +        &self.0
> +    }
> +}
> --=20
> 2.46.2
>=20

=E2=80=94 Daniel

[0]: https://lkml.org/lkml/2024/12/3/1281


