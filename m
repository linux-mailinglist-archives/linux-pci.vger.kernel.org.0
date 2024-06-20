Return-Path: <linux-pci+bounces-9028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D2491096F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 17:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAAEA2822EB
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 15:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6BD1AF696;
	Thu, 20 Jun 2024 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pm4w85L1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270591AED5A;
	Thu, 20 Jun 2024 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896307; cv=none; b=Y9V0UFsK9RJxXqMDFMaFh4oTjWljUE+9fCSF8MKWIuSTj0NFuYr5wkAH5hjp939ZJpGdRYQVfHS2eHXlah9Le90xTIXQvTt4iKe1Rm64jzGtkZNwEhnJzMStP/FnlS/8TarsdwRJTslZcCOKEX8N8wrr3HxR15kheNHXnEJLSyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896307; c=relaxed/simple;
	bh=BQJCcQtirxB2NsQ9DEZ7h6l2NY6z1Y7N7Zei18H96NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNifMgGvUUbU1epflmNps6dXT6Pxvt0nG4ZVwT8/2lwZCXlt0yco80jyPbnqgH1jczL9EU4LP7hgeXo5g/SNVnD0Ue/KkE/9xuoAFUUiIeSaoQ8Wz5oBsqyqx2qhpp4f56vN4Wwm+md02EWCC3yHzJFfsPztqnpeYR3QRCGixK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pm4w85L1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2828AC2BD10;
	Thu, 20 Jun 2024 15:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718896306;
	bh=BQJCcQtirxB2NsQ9DEZ7h6l2NY6z1Y7N7Zei18H96NA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pm4w85L1UGEkJWoArD+dGELBdp3Fz2jkqrARACgDuB954rSkvT7sqEqrPx82yRvnA
	 A4Aj7j95BEwuCtgHHJMwbEqQTE6K0A66rqEPwWhsUgopEpoK2r1IjFZJ1riQda1t2X
	 GxWqs7ZyqjOSHr/dZvdghRN2y14Pew6nOC+Ngxd4=
Date: Thu, 20 Jun 2024 17:11:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 09/10] rust: pci: add basic PCI device / driver
 abstractions
Message-ID: <2024062011-property-hypnotist-e652@gregkh>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-10-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618234025.15036-10-dakr@redhat.com>

On Wed, Jun 19, 2024 at 01:39:55AM +0200, Danilo Krummrich wrote:
> +/// Abstraction for bindings::pci_device_id.
> +#[derive(Clone, Copy)]
> +pub struct DeviceId {
> +    /// Vendor ID
> +    pub vendor: u32,
> +    /// Device ID
> +    pub device: u32,
> +    /// Subsystem vendor ID
> +    pub subvendor: u32,
> +    /// Subsystem device ID
> +    pub subdevice: u32,
> +    /// Device class and subclass
> +    pub class: u32,
> +    /// Limit which sub-fields of the class
> +    pub class_mask: u32,
> +}

Note, this is exported to userspace, why can't you use the C structure
that's already defined for you?  This is going to get tricky over time
for the different busses, please use what is already there.

And question, how are you guaranteeing the memory layout of this
structure here?  Will rust always do this with no holes and no
re-arranging?

> +impl DeviceId {
> +    const PCI_ANY_ID: u32 = !0;
> +
> +    /// PCI_DEVICE macro.
> +    pub const fn new(vendor: u32, device: u32) -> Self {
> +        Self {
> +            vendor,
> +            device,
> +            subvendor: DeviceId::PCI_ANY_ID,
> +            subdevice: DeviceId::PCI_ANY_ID,
> +            class: 0,
> +            class_mask: 0,
> +        }
> +    }
> +
> +    /// PCI_DEVICE_CLASS macro.
> +    pub const fn with_class(class: u32, class_mask: u32) -> Self {
> +        Self {
> +            vendor: DeviceId::PCI_ANY_ID,
> +            device: DeviceId::PCI_ANY_ID,
> +            subvendor: DeviceId::PCI_ANY_ID,
> +            subdevice: DeviceId::PCI_ANY_ID,
> +            class,
> +            class_mask,
> +        }
> +    }

Why just these 2 subsets of the normal PCI_DEVICE* macros?

> +
> +    /// PCI_DEVICE_ID macro.
> +    pub const fn to_rawid(&self, offset: isize) -> bindings::pci_device_id {

PCI_DEVICE_ID is defined to be "0x02" in pci_regs.h, I don't think you
want that duplication here, right?

> +        bindings::pci_device_id {
> +            vendor: self.vendor,
> +            device: self.device,
> +            subvendor: self.subvendor,
> +            subdevice: self.subdevice,
> +            class: self.class,
> +            class_mask: self.class_mask,
> +            driver_data: offset as _,
> +            override_only: 0,
> +        }
> +    }
> +}
> +
> +// SAFETY: `ZERO` is all zeroed-out and `to_rawid` stores `offset` in `pci_device_id::driver_data`.
> +unsafe impl RawDeviceId for DeviceId {
> +    type RawType = bindings::pci_device_id;
> +
> +    const ZERO: Self::RawType = bindings::pci_device_id {
> +        vendor: 0,
> +        device: 0,
> +        subvendor: 0,
> +        subdevice: 0,
> +        class: 0,
> +        class_mask: 0,
> +        driver_data: 0,
> +        override_only: 0,

This feels rough, why can't the whole memory chunk be set to 0 for any
non-initialized values?  What happens if a new value gets added to the C
side, how will this work here?

> +    };
> +}
> +
> +/// Define a const pci device id table
> +///
> +/// # Examples
> +///
> +/// See [`Driver`]
> +///
> +#[macro_export]
> +macro_rules! define_pci_id_table {
> +    ($data_type:ty, $($t:tt)*) => {
> +        type IdInfo = $data_type;
> +        const ID_TABLE: $crate::device_id::IdTable<'static, $crate::pci::DeviceId, $data_type> = {
> +            $crate::define_id_array!(ARRAY, $crate::pci::DeviceId, $data_type, $($t)* );
> +            ARRAY.as_table()
> +        };
> +    };
> +}
> +pub use define_pci_id_table;
> +
> +/// The PCI driver trait.
> +///
> +/// # Example
> +///
> +///```
> +/// # use kernel::{bindings, define_pci_id_table, pci, sync::Arc};
> +///
> +/// struct MyDriver;
> +/// struct MyDeviceData;
> +///
> +/// impl pci::Driver for MyDriver {
> +///     type Data = Arc<MyDeviceData>;
> +///
> +///     define_pci_id_table! {
> +///         (),
> +///         [ (pci::DeviceId::new(bindings::PCI_VENDOR_ID_REDHAT,
> +///                               bindings::PCI_ANY_ID as u32),
> +///            None)
> +///         ]
> +///     }
> +///
> +///     fn probe(
> +///         _pdev: &mut pci::Device,
> +///         _id_info: Option<&Self::IdInfo>
> +///     ) -> Result<Self::Data> {
> +///         Err(ENODEV)
> +///     }
> +///
> +///     fn remove(_data: &Self::Data) {
> +///     }
> +/// }
> +///```
> +/// Drivers must implement this trait in order to get a PCI driver registered. Please refer to the
> +/// `Adapter` documentation for an example.
> +pub trait Driver {
> +    /// Data stored on device by driver.
> +    ///
> +    /// Corresponds to the data set or retrieved via the kernel's
> +    /// `pci_{set,get}_drvdata()` functions.
> +    ///
> +    /// Require that `Data` implements `ForeignOwnable`. We guarantee to
> +    /// never move the underlying wrapped data structure.
> +    ///
> +    /// TODO: Use associated_type_defaults once stabilized:
> +    ///
> +    /// `type Data: ForeignOwnable = ();`
> +    type Data: ForeignOwnable;

Does this mean this all can be 'static' in memory and never dynamically
allocated?  If so, good, if not, why not?

> +
> +    /// The type holding information about each device id supported by the driver.
> +    ///
> +    /// TODO: Use associated_type_defaults once stabilized:
> +    ///
> +    /// type IdInfo: 'static = ();
> +    type IdInfo: 'static;

What does static mean here?

> +
> +    /// The table of device ids supported by the driver.
> +    const ID_TABLE: IdTable<'static, DeviceId, Self::IdInfo>;
> +
> +    /// PCI driver probe.
> +    ///
> +    /// Called when a new platform device is added or discovered.

This is not a platform device

> +    /// Implementers should attempt to initialize the device here.
> +    fn probe(dev: &mut Device, id: Option<&Self::IdInfo>) -> Result<Self::Data>;
> +
> +    /// PCI driver remove.
> +    ///
> +    /// Called when a platform device is removed.

This is not a platform device.

> +    /// Implementers should prepare the device for complete removal here.
> +    fn remove(data: &Self::Data);

No suspend?  No resume?  No shutdown?  only probe/remove?  Ok, baby
steps are nice :)


> +}
> +
> +/// The PCI device representation.
> +///
> +/// A PCI device is based on an always reference counted `device:Device` instance. Cloning a PCI
> +/// device, hence, also increments the base device' reference count.
> +#[derive(Clone)]
> +pub struct Device(ARef<device::Device>);
> +
> +impl Device {
> +    /// Create a PCI Device instance from an existing `device::Device`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `dev` must be an `ARef<device::Device>` whose underlying `bindings::device` is a member of
> +    /// a `bindings::pci_dev`.
> +    pub unsafe fn from_dev(dev: ARef<device::Device>) -> Self {
> +        Self(dev)
> +    }
> +
> +    fn as_raw(&self) -> *mut bindings::pci_dev {
> +        // SAFETY: Guaranteed by the type invaraints.
> +        unsafe { container_of!(self.0.as_raw(), bindings::pci_dev, dev) as _ }
> +    }
> +
> +    /// Enable the Device's memory.
> +    pub fn enable_device_mem(&self) -> Result {
> +        // SAFETY: Safe by the type invariants.
> +        let ret = unsafe { bindings::pci_enable_device_mem(self.as_raw()) };
> +        if ret != 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(())
> +        }
> +    }
> +
> +    /// Set the Device's master.
> +    pub fn set_master(&self) {
> +        // SAFETY: Safe by the type invariants.
> +        unsafe { bindings::pci_set_master(self.as_raw()) };
> +    }

Why just these 2 functions?  Just an example, or you don't need anything
else yet?

thanks,

greg k-h

