Return-Path: <linux-pci+bounces-18312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1D19EF31C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 17:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6EA6176008
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 16:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971F823EC14;
	Thu, 12 Dec 2024 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLUrjHle"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6637C23A1BF;
	Thu, 12 Dec 2024 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021365; cv=none; b=Bm8hnd+GE7+z2oJLFHM3I2dKbJoZ/A8UULHy4RxktF/4P9JimsWTLDMEuwCr1TaV6uP3/j3t7qTlXgR8YvQIXcH1f+nwXNuL/nt6NM0ZnGfG6unhto845wow6jm9Dgvd7VL2ZnSxOM+bdwIA9WSdG34i8SQaJQyjiRgiudZEDr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021365; c=relaxed/simple;
	bh=JoB/TWuxSjeFZj9j0HdqqjpSItx1y68w+DxLZG/A9oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+9qlYsSyBRQLqGllO0sk+lcdQCx/DlrASjleOJ/Eizks9i+ayiQVsjSxmwOvEjZvVPJDPoKoQisF4BS0diwjwlekXUyY3tA2TWgHl3SjSF8HTPYZABTVzzOO1FQFy3hl2UKP8X8SXybdqU5lZmwTyBl+7XVt3Ptjf84VXeD7j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLUrjHle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99180C4CEDE;
	Thu, 12 Dec 2024 16:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734021365;
	bh=JoB/TWuxSjeFZj9j0HdqqjpSItx1y68w+DxLZG/A9oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLUrjHleWMf0KB6MdwFvBrhh8ZeVMw5dKe9IQnHol+UbWqjB0mdbOINkVlRBQUb+W
	 ccAxusxefi94Xprga4+LP4sIBhA1F45ffSDMQUHGdJnTImiZbQT6TvziWebPx8xbg1
	 XtUwCSBv+amBprKXSSZ+tbTXOLBCoYjzGW8syeCW/s9t+g6BbEqz3P5ZEwWS3s7aNF
	 2ET5mrEN3K8eZ/bhU06j6pih9WlXSZBF4YqiAKSatpBL8eNmXNkxD13Og4Pb+d4XXx
	 nWLkSXYP8SM+l+Fdn8hJL2QKWLZe/jCp5D7mLt0D0Q5S4ISkN1G3EsE/w9VrADX09q
	 zIDR/dxFvQVzg==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
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
	daniel.almeida@collabora.com,
	saravanak@google.com,
	dirk.behme@de.bosch.com,
	j@jannau.net,
	fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com,
	paulmck@kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	rcu@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v6 10/16] rust: pci: implement I/O mappable `pci::Bar`
Date: Thu, 12 Dec 2024 17:33:41 +0100
Message-ID: <20241212163357.35934-11-dakr@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212163357.35934-1-dakr@kernel.org>
References: <20241212163357.35934-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement `pci::Bar`, `pci::Device::iomap_region` and
`pci::Device::iomap_region_sized` to allow for I/O mappings of PCI BARs.

To ensure that a `pci::Bar`, and hence the I/O memory mapping, can't
out-live the PCI device, the `pci::Bar` type is always embedded into a
`Devres` container, such that the `pci::Bar` is revoked once the device
is unbound and hence the I/O mapped memory is unmapped.

A `pci::Bar` can be requested with (`pci::Device::iomap_region_sized`) or
without (`pci::Device::iomap_region`) a const generic representing the
minimal requested size of the I/O mapped memory region. In case of the
latter only runtime checked I/O reads / writes are possible.

Co-developed-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs | 140 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 238eed06f388..a91f90585a1f 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -5,10 +5,14 @@
 //! C header: [`include/linux/pci.h`](srctree/include/linux/pci.h)
 
 use crate::{
+    alloc::flags::*,
     bindings, container_of, device,
     device_id::RawDeviceId,
+    devres::Devres,
     driver,
     error::{to_result, Result},
+    io::Io,
+    io::IoRaw,
     str::CStr,
     types::{ARef, ForeignOwnable, Opaque},
     ThisModule,
@@ -241,9 +245,115 @@ pub trait Driver {
 ///
 /// A PCI device is based on an always reference counted `device:Device` instance. Cloning a PCI
 /// device, hence, also increments the base device' reference count.
+///
+/// # Invariants
+///
+/// `Device` hold a valid reference of `ARef<device::Device>` whose underlying `struct device` is a
+/// member of a `struct pci_dev`.
 #[derive(Clone)]
 pub struct Device(ARef<device::Device>);
 
+/// A PCI BAR to perform I/O-Operations on.
+///
+/// # Invariants
+///
+/// `Bar` always holds an `IoRaw` inststance that holds a valid pointer to the start of the I/O
+/// memory mapped PCI bar and its size.
+pub struct Bar<const SIZE: usize = 0> {
+    pdev: Device,
+    io: IoRaw<SIZE>,
+    num: i32,
+}
+
+impl<const SIZE: usize> Bar<SIZE> {
+    fn new(pdev: Device, num: u32, name: &CStr) -> Result<Self> {
+        let len = pdev.resource_len(num)?;
+        if len == 0 {
+            return Err(ENOMEM);
+        }
+
+        // Convert to `i32`, since that's what all the C bindings use.
+        let num = i32::try_from(num)?;
+
+        // SAFETY:
+        // `pdev` is valid by the invariants of `Device`.
+        // `num` is checked for validity by a previous call to `Device::resource_len`.
+        // `name` is always valid.
+        let ret = unsafe { bindings::pci_request_region(pdev.as_raw(), num, name.as_char_ptr()) };
+        if ret != 0 {
+            return Err(EBUSY);
+        }
+
+        // SAFETY:
+        // `pdev` is valid by the invariants of `Device`.
+        // `num` is checked for validity by a previous call to `Device::resource_len`.
+        // `name` is always valid.
+        let ioptr: usize = unsafe { bindings::pci_iomap(pdev.as_raw(), num, 0) } as usize;
+        if ioptr == 0 {
+            // SAFETY:
+            // `pdev` valid by the invariants of `Device`.
+            // `num` is checked for validity by a previous call to `Device::resource_len`.
+            unsafe { bindings::pci_release_region(pdev.as_raw(), num) };
+            return Err(ENOMEM);
+        }
+
+        let io = match IoRaw::new(ioptr, len as usize) {
+            Ok(io) => io,
+            Err(err) => {
+                // SAFETY:
+                // `pdev` is valid by the invariants of `Device`.
+                // `ioptr` is guaranteed to be the start of a valid I/O mapped memory region.
+                // `num` is checked for validity by a previous call to `Device::resource_len`.
+                unsafe { Self::do_release(&pdev, ioptr, num) };
+                return Err(err);
+            }
+        };
+
+        Ok(Bar { pdev, io, num })
+    }
+
+    /// # Safety
+    ///
+    /// `ioptr` must be a valid pointer to the memory mapped PCI bar number `num`.
+    unsafe fn do_release(pdev: &Device, ioptr: usize, num: i32) {
+        // SAFETY:
+        // `pdev` is valid by the invariants of `Device`.
+        // `ioptr` is valid by the safety requirements.
+        // `num` is valid by the safety requirements.
+        unsafe {
+            bindings::pci_iounmap(pdev.as_raw(), ioptr as _);
+            bindings::pci_release_region(pdev.as_raw(), num);
+        }
+    }
+
+    fn release(&self) {
+        // SAFETY: The safety requirements are guaranteed by the type invariant of `self.pdev`.
+        unsafe { Self::do_release(&self.pdev, self.io.addr(), self.num) };
+    }
+}
+
+impl Bar {
+    fn index_is_valid(index: u32) -> bool {
+        // A `struct pci_dev` owns an array of resources with at most `PCI_NUM_RESOURCES` entries.
+        index < bindings::PCI_NUM_RESOURCES
+    }
+}
+
+impl<const SIZE: usize> Drop for Bar<SIZE> {
+    fn drop(&mut self) {
+        self.release();
+    }
+}
+
+impl<const SIZE: usize> Deref for Bar<SIZE> {
+    type Target = Io<SIZE>;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: By the type invariant of `Self`, the MMIO range in `self.io` is properly mapped.
+        unsafe { Io::from_raw(&self.io) }
+    }
+}
+
 impl Device {
     /// Create a PCI Device instance from an existing `device::Device`.
     ///
@@ -289,6 +399,36 @@ pub fn set_master(&self) {
         // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
         unsafe { bindings::pci_set_master(self.as_raw()) };
     }
+
+    /// Returns the size of the given PCI bar resource.
+    pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
+        if !Bar::index_is_valid(bar) {
+            return Err(EINVAL);
+        }
+
+        // SAFETY:
+        // - `bar` is a valid bar number, as guaranteed by the above call to `Bar::index_is_valid`,
+        // - by its type invariant `self.as_raw` is always a valid pointer to a `struct pci_dev`.
+        Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_into()?) })
+    }
+
+    /// Mapps an entire PCI-BAR after performing a region-request on it. I/O operation bound checks
+    /// can be performed on compile time for offsets (plus the requested type size) < SIZE.
+    pub fn iomap_region_sized<const SIZE: usize>(
+        &self,
+        bar: u32,
+        name: &CStr,
+    ) -> Result<Devres<Bar<SIZE>>> {
+        let bar = Bar::<SIZE>::new(self.clone(), bar, name)?;
+        let devres = Devres::new(self.as_ref(), bar, GFP_KERNEL)?;
+
+        Ok(devres)
+    }
+
+    /// Mapps an entire PCI-BAR after performing a region-request on it.
+    pub fn iomap_region(&self, bar: u32, name: &CStr) -> Result<Devres<Bar>> {
+        self.iomap_region_sized::<0>(bar, name)
+    }
 }
 
 impl AsRef<device::Device> for Device {
-- 
2.47.1


