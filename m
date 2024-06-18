Return-Path: <linux-pci+bounces-8949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA8590E01A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 01:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BCBFB23177
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 23:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8750C1993B9;
	Tue, 18 Jun 2024 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGwZJ4Yb"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED7F19939D
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754088; cv=none; b=txRp272UX5/fTGHy25QDxiqtp/Rtgaz7Z0vrKHw/p2wmzrlSI9znOAREFclTZrQYkprphoL+jGoGZhnBhfMuDNmazpOadRv3hrfd5OLvXbC8I/QrkCfwSGr0cKf7IRQlX4G2BiBah2/+FplpnpdKpMtxvfd6As8Pm6d/hVXPsMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754088; c=relaxed/simple;
	bh=RCEMwYVvuUbZz+/rEeI8myzcrUIo6owjk7lRZAsrGQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thE5itYUOurLMXtov8GjPsdsVZvoPcLKOkus2EKprLZq1JyxBJbhlDw1r/D7SR21hf8viJawWIw7jKf6cqmD8il+7jKzmId7C0SP3W4I5HwaZPl9iNXiEhcJtrAOn+fx+7J2GzRBQjINlqmNUDxmTDtrb+1rlQ25tWcB91FMJl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DGwZJ4Yb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718754085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UVH4NPjG6WbuLQxLO9Ab399xq2yWE6YB8L0prZ4B/nk=;
	b=DGwZJ4YbtYH9HOJ4/jek+UxxYAhSLg4AUFA61yu553L2BFT0ay0tkZFh0G2I+4fXj3TNzP
	AZv4F7ptLOlU45QbdFztreZ81iuuz4uy1naky197xC3tvpR0kYik/NJIZlvNJlKzvj0KY+
	MKoU2LfmnD5P0+GNJHkFiJSIqDnfou4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-a1ZCXxNgOJa-Fk5kPJldtg-1; Tue, 18 Jun 2024 19:41:24 -0400
X-MC-Unique: a1ZCXxNgOJa-Fk5kPJldtg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ec35a23e59so9652711fa.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 16:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718754083; x=1719358883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVH4NPjG6WbuLQxLO9Ab399xq2yWE6YB8L0prZ4B/nk=;
        b=Q2m1k2kLjuiC+HKBSOqeJ1D5ShgS43wdmI4Kt0X+BxnJh7RCDeRduflRg+wjdKqu4f
         sjQKk2Im52q63BQFpfPN2ZqN2iiRoCL81kNy4DeOoLh8D6OIp+J9uIBPQtnP9E+ZFk26
         ntb64bX7+TLwUdNc3mnngzBVXZsIn6TYs0aU+N53f9fI5S2NA5anBDPuBE5a5gTp3SwO
         TnLYArhVRXHXJlDoy6MerqKh6Ef0fxmCz7iylpkgiveXx9hRlK1i9CpvARNXSXvNavrM
         KpPPIh/VR1SNqEzzIpBNuBgUlv+5DaJqLp5in0Sx0BXkETpa3xXEXwmdYj/P6nTOs2gJ
         MF/g==
X-Forwarded-Encrypted: i=1; AJvYcCXpWNLG1gqB6PP/FaA2swOnxiEGu3L7Z7bCtjKJYj5KsHUM0J9Ji1UN71WRRgeNhv/e/tZ/Xq2U8Tuq51oIc4Hjo+ivtMwxy6j7
X-Gm-Message-State: AOJu0YzCQkFJwZOmHIHdv9BHBcSkl7jLu6e6/oI/6mVlGe4BZl3kEM3p
	86fEUCgPfVTHoXBT/53o9UUZ3IeQtDDkzfo88pAUbd6WQRKCVSlGrRzcQgrk5Szqcm4PAyF/UYA
	MAmzDHGQQVSLIFRbb3C8vWZg5Ksbp6e127LzsL3arGrAiYwSLV34qT6YdaQ==
X-Received: by 2002:a05:6512:2c9a:b0:52b:c15f:2613 with SMTP id 2adb3069b0e04-52ccaa62157mr550013e87.35.1718754083005;
        Tue, 18 Jun 2024 16:41:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoZ2RS3AlTl1V/f0PC+9/w7xUZieCfcwyUejXDg+egJxREfUqX3QPWZZGosxlVoeE0P/NjeQ==
X-Received: by 2002:a05:6512:2c9a:b0:52b:c15f:2613 with SMTP id 2adb3069b0e04-52ccaa62157mr549994e87.35.1718754082636;
        Tue, 18 Jun 2024 16:41:22 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e9145sm242850535e9.22.2024.06.18.16.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 16:41:22 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	lina@asahilina.net,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	robh@kernel.org,
	daniel.almeida@collabora.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH v2 10/10] rust: pci: implement I/O mappable `pci::Bar`
Date: Wed, 19 Jun 2024 01:39:56 +0200
Message-ID: <20240618234025.15036-11-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240618234025.15036-1-dakr@redhat.com>
References: <20240618234025.15036-1-dakr@redhat.com>
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
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/pci.rs | 142 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index a8230474e9b8..2b61fb59d4a7 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -5,14 +5,18 @@
 //! C header: [`include/linux/pci.h`](srctree/include/linux/pci.h)
 
 use crate::{
+    alloc::flags::*,
     bindings, container_of, device,
     device_id::{IdTable, RawDeviceId},
+    devres::Devres,
     driver,
     error::{to_result, Result},
+    io::Io,
     str::CStr,
     types::{ARef, ForeignOwnable},
     ThisModule,
 };
+use core::ops::Deref;
 use kernel::prelude::*; // for pinned_drop
 
 /// An adapter for the registration of PCI drivers.
@@ -281,9 +285,114 @@ pub trait Driver {
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
+/// `Bar` always holds an `Io` inststance that holds a valid pointer to the start of the I/O memory
+/// mapped PCI bar and its size.
+pub struct Bar<const SIZE: usize = 0> {
+    pdev: Device,
+    io: Io<SIZE>,
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
+        // SAFETY: `ioptr` is guaranteed to be the start of a valid I/O mapped memory region of size
+        // `len`.
+        let io = match unsafe { Io::new(ioptr, len as usize) } {
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
+    // SAFETY: `ioptr` must be a valid pointer to the memory mapped PCI bar number `num`.
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
+        // SAFETY: Safe by the invariants of `Device` and `Bar`.
+        unsafe { Self::do_release(&self.pdev, self.io.base_addr(), self.num) };
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
+        &self.io
+    }
+}
+
 impl Device {
     /// Create a PCI Device instance from an existing `device::Device`.
     ///
@@ -316,6 +425,39 @@ pub fn set_master(&self) {
         // SAFETY: Safe by the type invariants.
         unsafe { bindings::pci_set_master(self.as_raw()) };
     }
+
+    /// Returns the size of the given PCI bar resource.
+    pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
+        if !Bar::index_is_valid(bar) {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: Safe by the type invariant.
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
+
+    /// Returns a new `ARef` of the base `device::Device`.
+    pub fn as_dev(&self) -> ARef<device::Device> {
+        self.0.clone()
+    }
 }
 
 impl AsRef<device::Device> for Device {
-- 
2.45.1


