Return-Path: <linux-pci+bounces-17416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6551D9DA85C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 14:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066B216150F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 13:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31F61FCF43;
	Wed, 27 Nov 2024 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORt6JtB7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED8E1F9F7B;
	Wed, 27 Nov 2024 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732713549; cv=none; b=TFPpJR934kmNEbJWR4HDaSvU02HKUuAkw6HF/bFNDmIFqOTtomf70tJp4YRbMTz8u/1OIRFgatBa1JAfIAuWtAJnsMJ7TCyjybq0e9aaodifXgFnmwW2684NKJWSOymEL7Ut9wUClVlCBVsf6IW9WK94P0eKmhBlVWb+dFxvmPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732713549; c=relaxed/simple;
	bh=kxL0Zkeo5uAXQmY3VqSiVP2yx4xsPIvyi5uasz7Z0ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jEo1CruuoC8NttK4fKKGv+6uO8N3XfJYrFAth1H1XRMkPHmIwldwoe0zI+t0+FchxMQEDsaJZ8bl83VBpOTxHrOMoxbXvLszPQmMydmbxustd+FU7UHWjJ+9y/bI4iF1PcHbH/cIKursLaQVRf9BCP0uLnlXcbh65DtgblMVyD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORt6JtB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC04C4CECC;
	Wed, 27 Nov 2024 13:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732713549;
	bh=kxL0Zkeo5uAXQmY3VqSiVP2yx4xsPIvyi5uasz7Z0ac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ORt6JtB7U+kKQVqsLrg/2z2unpSAKuiURGH9TN3R/vzbn2nYg1TIY8o3LgB063SWy
	 V3ZPFzFI6d1hUzdmD/tJtbfAL43R+5I4dtDgYw4Mrsq8+jN81Alndgx/W66PRMrZ8m
	 nFBZyIETqFx/tVb+MOyU0evcQMOoXLr8b38wYYmrT8/cRx8Y/e4b8+vlFDJmOIpSrE
	 nIcjXBM8CKmgvETimKjWtm2c6z6yxunignSIh6wERI7sDR5bFCrasSPUti0WUa4uiC
	 eYnKzKXKrXj3SHBwQand1QhFmGrTpn96wFXWeItINJuxa0bLPLlA81yNJqi6DVOF0X
	 5cT+hcq0vYCvQ==
Message-ID: <38d708b5-7a73-4736-909c-eefd3c938769@kernel.org>
Date: Wed, 27 Nov 2024 14:19:02 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/16] rust: add devres abstraction
To: Alice Ryhl <aliceryhl@google.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com,
 fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
 daniel.almeida@collabora.com, saravanak@google.com,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-11-dakr@kernel.org>
 <CAH5fLgjdKRCECmZbjC-+6SQffFtgimfxhDJ3grVw1_hbQec1-Q@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CAH5fLgjdKRCECmZbjC-+6SQffFtgimfxhDJ3grVw1_hbQec1-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/27/24 1:21 PM, Alice Ryhl wrote:
> On Tue, Oct 22, 2024 at 11:33 PM Danilo Krummrich <dakr@kernel.org> wrote:
>>
>> Add a Rust abstraction for the kernel's devres (device resource
>> management) implementation.
>>
>> The Devres type acts as a container to manage the lifetime and
>> accessibility of device bound resources. Therefore it registers a
>> devres callback and revokes access to the resource on invocation.
>>
>> Users of the Devres abstraction can simply free the corresponding
>> resources in their Drop implementation, which is invoked when either the
>> Devres instance goes out of scope or the devres callback leads to the
>> resource being revoked, which implies a call to drop_in_place().
>>
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>>   MAINTAINERS            |   1 +
>>   rust/helpers/device.c  |  10 +++
>>   rust/helpers/helpers.c |   1 +
>>   rust/kernel/devres.rs  | 180 +++++++++++++++++++++++++++++++++++++++++
>>   rust/kernel/lib.rs     |   1 +
>>   5 files changed, 193 insertions(+)
>>   create mode 100644 rust/helpers/device.c
>>   create mode 100644 rust/kernel/devres.rs
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0a8882252257..97914d0752fb 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6983,6 +6983,7 @@ F:        include/linux/property.h
>>   F:     lib/kobj*
>>   F:     rust/kernel/device.rs
>>   F:     rust/kernel/device_id.rs
>> +F:     rust/kernel/devres.rs
>>   F:     rust/kernel/driver.rs
>>
>>   DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
>> diff --git a/rust/helpers/device.c b/rust/helpers/device.c
>> new file mode 100644
>> index 000000000000..b2135c6686b0
>> --- /dev/null
>> +++ b/rust/helpers/device.c
>> @@ -0,0 +1,10 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/device.h>
>> +
>> +int rust_helper_devm_add_action(struct device *dev,
>> +                               void (*action)(void *),
>> +                               void *data)
>> +{
>> +       return devm_add_action(dev, action, data);
>> +}
>> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
>> index e2f6b2197061..3acb2b9e52ec 100644
>> --- a/rust/helpers/helpers.c
>> +++ b/rust/helpers/helpers.c
>> @@ -11,6 +11,7 @@
>>   #include "bug.c"
>>   #include "build_assert.c"
>>   #include "build_bug.c"
>> +#include "device.c"
>>   #include "err.c"
>>   #include "io.c"
>>   #include "kunit.c"
>> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
>> new file mode 100644
>> index 000000000000..b23559f55214
>> --- /dev/null
>> +++ b/rust/kernel/devres.rs
>> @@ -0,0 +1,180 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Devres abstraction
>> +//!
>> +//! [`Devres`] represents an abstraction for the kernel devres (device resource management)
>> +//! implementation.
>> +
>> +use crate::{
>> +    alloc::Flags,
>> +    bindings,
>> +    device::Device,
>> +    error::{Error, Result},
>> +    prelude::*,
>> +    revocable::Revocable,
>> +    sync::Arc,
>> +};
>> +
>> +use core::ffi::c_void;
>> +use core::ops::Deref;
>> +
>> +#[pin_data]
>> +struct DevresInner<T> {
>> +    #[pin]
>> +    data: Revocable<T>,
>> +}
>> +
>> +/// This abstraction is meant to be used by subsystems to containerize [`Device`] bound resources to
>> +/// manage their lifetime.
>> +///
>> +/// [`Device`] bound resources should be freed when either the resource goes out of scope or the
>> +/// [`Device`] is unbound respectively, depending on what happens first.
>> +///
>> +/// To achieve that [`Devres`] registers a devres callback on creation, which is called once the
>> +/// [`Device`] is unbound, revoking access to the encapsulated resource (see also [`Revocable`]).
>> +///
>> +/// After the [`Devres`] has been unbound it is not possible to access the encapsulated resource
>> +/// anymore.
>> +///
>> +/// [`Devres`] users should make sure to simply free the corresponding backing resource in `T`'s
>> +/// [`Drop`] implementation.
>> +///
>> +/// # Example
>> +///
>> +/// ```no_run
>> +/// # use kernel::{bindings, c_str, device::Device, devres::Devres, io::Io};
>> +/// # use core::ops::Deref;
>> +///
>> +/// // See also [`pci::Bar`] for a real example.
>> +/// struct IoMem<const SIZE: usize>(Io<SIZE>);
>> +///
>> +/// impl<const SIZE: usize> IoMem<SIZE> {
>> +///     /// # Safety
>> +///     ///
>> +///     /// [`paddr`, `paddr` + `SIZE`) must be a valid MMIO region that is mappable into the CPUs
>> +///     /// virtual address space.
>> +///     unsafe fn new(paddr: usize) -> Result<Self>{
>> +///
>> +///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
>> +///         // valid for `ioremap`.
>> +///         let addr = unsafe { bindings::ioremap(paddr as _, SIZE.try_into().unwrap()) };
>> +///         if addr.is_null() {
>> +///             return Err(ENOMEM);
>> +///         }
>> +///
>> +///         // SAFETY: `addr` is guaranteed to be the start of a valid I/O mapped memory region of
>> +///         // size `SIZE`.
>> +///         let io = unsafe { Io::new(addr as _, SIZE)? };
>> +///
>> +///         Ok(IoMem(io))
>> +///     }
>> +/// }
>> +///
>> +/// impl<const SIZE: usize> Drop for IoMem<SIZE> {
>> +///     fn drop(&mut self) {
>> +///         // SAFETY: Safe as by the invariant of `Io`.
>> +///         unsafe { bindings::iounmap(self.0.base_addr() as _); };
>> +///     }
>> +/// }
>> +///
>> +/// impl<const SIZE: usize> Deref for IoMem<SIZE> {
>> +///    type Target = Io<SIZE>;
>> +///
>> +///    fn deref(&self) -> &Self::Target {
>> +///        &self.0
>> +///    }
>> +/// }
>> +///
>> +/// # fn no_run() -> Result<(), Error> {
>> +/// # // SAFETY: Invalid usage; just for the example to get an `ARef<Device>` instance.
>> +/// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
>> +///
>> +/// // SAFETY: Invalid usage for example purposes.
>> +/// let iomem = unsafe { IoMem::<{ core::mem::size_of::<u32>() }>::new(0xBAAAAAAD)? };
>> +/// let devres = Devres::new(&dev, iomem, GFP_KERNEL)?;
>> +///
>> +/// let res = devres.try_access().ok_or(ENXIO)?;
>> +/// res.writel(0x42, 0x0);
>> +/// # Ok(())
>> +/// # }
>> +/// ```
>> +pub struct Devres<T>(Arc<DevresInner<T>>);
>> +
>> +impl<T> DevresInner<T> {
>> +    fn new(dev: &Device, data: T, flags: Flags) -> Result<Arc<DevresInner<T>>> {
>> +        let inner = Arc::pin_init(
>> +            pin_init!( DevresInner {
>> +                data <- Revocable::new(data),
>> +            }),
>> +            flags,
>> +        )?;
>> +
>> +        // Convert `Arc<DevresInner>` into a raw pointer and make devres own this reference until
>> +        // `Self::devres_callback` is called.
>> +        let data = inner.clone().into_raw();
>> +
>> +        // SAFETY: `devm_add_action` guarantees to call `Self::devres_callback` once `dev` is
>> +        // detached.
>> +        let ret = unsafe {
>> +            bindings::devm_add_action(dev.as_raw(), Some(Self::devres_callback), data as _)
>> +        };
>> +
>> +        if ret != 0 {
>> +            // SAFETY: We just created another reference to `inner` in order to pass it to
>> +            // `bindings::devm_add_action`. If `bindings::devm_add_action` fails, we have to drop
>> +            // this reference accordingly.
>> +            let _ = unsafe { Arc::from_raw(data) };
>> +            return Err(Error::from_errno(ret));
>> +        }
>> +
>> +        Ok(inner)
>> +    }
>> +
>> +    #[allow(clippy::missing_safety_doc)]
>> +    unsafe extern "C" fn devres_callback(ptr: *mut c_void) {
>> +        let ptr = ptr as *mut DevresInner<T>;
>> +        // Devres owned this memory; now that we received the callback, drop the `Arc` and hence the
>> +        // reference.
>> +        // SAFETY: Safe, since we leaked an `Arc` reference to devm_add_action() in
>> +        //         `DevresInner::new`.
>> +        let inner = unsafe { Arc::from_raw(ptr) };
>> +
>> +        inner.data.revoke();
>> +    }
>> +}
>> +
>> +impl<T> Devres<T> {
>> +    /// Creates a new [`Devres`] instance of the given `data`. The `data` encapsulated within the
>> +    /// returned `Devres` instance' `data` will be revoked once the device is detached.
>> +    pub fn new(dev: &Device, data: T, flags: Flags) -> Result<Self> {
>> +        let inner = DevresInner::new(dev, data, flags)?;
>> +
>> +        Ok(Devres(inner))
>> +    }
>> +
>> +    /// Same as [`Devres::new`], but does not return a `Devres` instance. Instead the given `data`
>> +    /// is owned by devres and will be revoked / dropped, once the device is detached.
>> +    pub fn new_foreign_owned(dev: &Device, data: T, flags: Flags) -> Result {
>> +        let _ = DevresInner::new(dev, data, flags)?;
>> +
>> +        Ok(())
>> +    }
>> +}
>> +
>> +impl<T> Deref for Devres<T> {
>> +    type Target = Revocable<T>;
>> +
>> +    fn deref(&self) -> &Self::Target {
>> +        &self.0.data
>> +    }
>> +}
>> +
>> +impl<T> Drop for Devres<T> {
>> +    fn drop(&mut self) {
>> +        // Revoke the data, such that it gets dropped already and the actual resource is freed.
>> +        // `DevresInner` has to stay alive until the devres callback has been called. This is
>> +        // necessary since we don't know when `Devres` is dropped and calling
>> +        // `devm_remove_action()` instead could race with `devres_release_all()`.
>> +        self.revoke();
> 
> When the destructor runs, it's guaranteed that nobody is accessing the
> inner resource since the only way to do that is through the Devres
> handle, but its destructor is running. Therefore, you can skip the
> synchronize_rcu() call in this case.

Yeah, I think this optimization should be possible.

We'd require `Revocable` to have a `revoke_nosync` method for that I guess...

> 
> Alice
> 


