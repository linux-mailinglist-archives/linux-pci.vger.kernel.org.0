Return-Path: <linux-pci+bounces-7673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0808CA150
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 19:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5BB1F21511
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 17:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02121384A8;
	Mon, 20 May 2024 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TymEYWOR"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF2C1384AE
	for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226027; cv=none; b=ELFLn85wJiWPPjna0lQENKGwWDE5XpmuzOJgwQSauQfVERGCXERuxKXrAPN6tz3ebIOJkZtQtf3YTuknDMDCQScS4AV0pBGPG+SxXwCwrfYC0gnyXsh/erAhFTU8IhdaMM4W4bwbXqyMJMsYMlcax2BWg9lMCPQDFBbDhwOONXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226027; c=relaxed/simple;
	bh=HLxn+yy/99tAi8nj3dRf0FfZndbE49uTmIZinfHUwRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFlBwrYQXrib7B9PsOe8sAuySQ42ohfdQxmYAvH7QGYedHNfMbx58FH27/3y7TVy2hddmzm5udKTuy1j9KF3zw1kqiPImeG9WyV1DJbOreq+Eep7bubKoE7OPhqzjMeUK0RN5gdp7FpffkFKVdyzAgVkQaDpYvzqi56iHFUd564=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TymEYWOR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716226024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2szcc1h6YvmKD7Qd7G/Viagtvo0+d8wDp1xeEAOqWQ=;
	b=TymEYWOREsqxljrpM+UAHtGjTkDdJRlPlEIwQzaMb5rsc28EDYJAUzjjhDzPhl134bGdYn
	fyXJD4WbWSDWZunFD8bWJGl/zV8X1x3g5xNrE5pAbRwvfpJKyrwSWNnEZb9tVe0ueQeR+n
	u8T5ZMKLY8YovUatuHekrz1y74AkH04=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-sMn-XnsWMYOPAYZXZkr8ug-1; Mon, 20 May 2024 13:27:02 -0400
X-MC-Unique: sMn-XnsWMYOPAYZXZkr8ug-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-351bd229b88so5936819f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 10:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716226022; x=1716830822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2szcc1h6YvmKD7Qd7G/Viagtvo0+d8wDp1xeEAOqWQ=;
        b=QQSbQXD3jxob3qjb0LRF6vON+S0UjBZR0EPCwYV28aoAbZllQR45vtmjeqdARWeR+n
         C2en60+Wbc1yYK/HCqBXhrgMkdECYHFhDAlMeZ397Z231D6zPnbnKNM+cGUGlIRKkRO4
         KttdeCb4M7AuKRBwmpWC+EMMgyZgS8ATnG6/gDKQf1BCncLKp7d3wj2zsKcg/EWYmwuj
         0aiM5TLa2nKEky9UH6Kr8Qw/dURMgUPMvWWkMT/zGbDZo2jpMdkFJAjrHV58s+0x02cP
         sm2WBR+GLwknTdjpxGV0OgWgPmu0eyao5BIswkWa8vraw1aqUM4YbUWiMuyNtIkzFbUc
         PG+g==
X-Forwarded-Encrypted: i=1; AJvYcCUKvpa1KPTGwra3U7gmDrbffnLSLsaX+y3vKTTTFaFuKNvGxv04dDk7NEhsVuMxMsCO1QVFDMxti1ytq404OhPs0T9yrrneekKU
X-Gm-Message-State: AOJu0YzaOwJHjVaC8Wu5vvMipeLD+D3sD42Hv9YGwejlBzwF6hbr8Wpw
	PWxuD5zk3q5u/dUoxXP6UFajC0Aah2aOjykk3CvOvev1MhckipyZNRQ3acNqyLNseiJe2nRO1Of
	/EAREVm6y9iPXWKbxEFg4pH47LYWBgubWvLb7fiZcn4UGyAVWGzksYxbq3A==
X-Received: by 2002:a5d:6884:0:b0:351:d3e1:a547 with SMTP id ffacd0b85a97d-351d3e1a614mr11481492f8f.6.1716226021099;
        Mon, 20 May 2024 10:27:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr7pN/+1T/SxXBrpWkGnaFsOuSQnfr+1EG4cOBwzMMTuZBSshqhYfkJ1Gp9nzPBLwrRiw7kg==
X-Received: by 2002:a5d:6884:0:b0:351:d3e1:a547 with SMTP id ffacd0b85a97d-351d3e1a614mr11481470f8f.6.1716226020381;
        Mon, 20 May 2024 10:27:00 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354c9bcaa98sm2238571f8f.4.2024.05.20.10.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 10:26:59 -0700 (PDT)
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
	lyude@redhat.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [RFC PATCH 02/11] rust: add driver abstraction
Date: Mon, 20 May 2024 19:25:39 +0200
Message-ID: <20240520172554.182094-3-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520172554.182094-1-dakr@redhat.com>
References: <20240520172554.182094-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <wedsonaf@gmail.com>

This defines general functionality related to registering drivers with
their respective subsystems, and registering modules that implement
drivers.

Co-developed-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Asahi Lina <lina@asahilina.net>
Co-developed-by: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/driver.rs        | 492 +++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs           |   4 +-
 rust/macros/module.rs        |   2 +-
 samples/rust/rust_minimal.rs |   2 +-
 samples/rust/rust_print.rs   |   2 +-
 5 files changed, 498 insertions(+), 4 deletions(-)
 create mode 100644 rust/kernel/driver.rs

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
new file mode 100644
index 000000000000..e0cfc36d47ff
--- /dev/null
+++ b/rust/kernel/driver.rs
@@ -0,0 +1,492 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic support for drivers of different buses (e.g., PCI, Platform, Amba, etc.).
+//!
+//! Each bus/subsystem is expected to implement [`DriverOps`], which allows drivers to register
+//! using the [`Registration`] class.
+
+use crate::{
+    alloc::{box_ext::BoxExt, flags::*},
+    error::code::*,
+    error::Result,
+    str::CStr,
+    sync::Arc,
+    ThisModule,
+};
+use alloc::boxed::Box;
+use core::{cell::UnsafeCell, marker::PhantomData, ops::Deref, pin::Pin};
+
+/// A subsystem (e.g., PCI, Platform, Amba, etc.) that allows drivers to be written for it.
+pub trait DriverOps {
+    /// The type that holds information about the registration. This is typically a struct defined
+    /// by the C portion of the kernel.
+    type RegType: Default;
+
+    /// Registers a driver.
+    ///
+    /// # Safety
+    ///
+    /// `reg` must point to valid, initialised, and writable memory. It may be modified by this
+    /// function to hold registration state.
+    ///
+    /// On success, `reg` must remain pinned and valid until the matching call to
+    /// [`DriverOps::unregister`].
+    unsafe fn register(
+        reg: *mut Self::RegType,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result;
+
+    /// Unregisters a driver previously registered with [`DriverOps::register`].
+    ///
+    /// # Safety
+    ///
+    /// `reg` must point to valid writable memory, initialised by a previous successful call to
+    /// [`DriverOps::register`].
+    unsafe fn unregister(reg: *mut Self::RegType);
+}
+
+/// The registration of a driver.
+pub struct Registration<T: DriverOps> {
+    is_registered: bool,
+    concrete_reg: UnsafeCell<T::RegType>,
+}
+
+// SAFETY: `Registration` has no fields or methods accessible via `&Registration`, so it is safe to
+// share references to it with multiple threads as nothing can be done.
+unsafe impl<T: DriverOps> Sync for Registration<T> {}
+
+impl<T: DriverOps> Registration<T> {
+    /// Creates a new instance of the registration object.
+    pub fn new() -> Self {
+        Self {
+            is_registered: false,
+            concrete_reg: UnsafeCell::new(T::RegType::default()),
+        }
+    }
+
+    /// Allocates a pinned registration object and registers it.
+    ///
+    /// Returns a pinned heap-allocated representation of the registration.
+    pub fn new_pinned(name: &'static CStr, module: &'static ThisModule) -> Result<Pin<Box<Self>>> {
+        let mut reg = Pin::from(Box::new(Self::new(), GFP_KERNEL)?);
+        reg.as_mut().register(name, module)?;
+        Ok(reg)
+    }
+
+    /// Registers a driver with its subsystem.
+    ///
+    /// It must be pinned because the memory block that represents the registration is potentially
+    /// self-referential.
+    pub fn register(
+        self: Pin<&mut Self>,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result {
+        // SAFETY: We never move out of `this`.
+        let this = unsafe { self.get_unchecked_mut() };
+        if this.is_registered {
+            // Already registered.
+            return Err(EINVAL);
+        }
+
+        // SAFETY: `concrete_reg` was initialised via its default constructor. It is only freed
+        // after `Self::drop` is called, which first calls `T::unregister`.
+        unsafe { T::register(this.concrete_reg.get(), name, module) }?;
+
+        this.is_registered = true;
+        Ok(())
+    }
+}
+
+impl<T: DriverOps> Default for Registration<T> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl<T: DriverOps> Drop for Registration<T> {
+    fn drop(&mut self) {
+        if self.is_registered {
+            // SAFETY: This path only runs if a previous call to `T::register` completed
+            // successfully.
+            unsafe { T::unregister(self.concrete_reg.get()) };
+        }
+    }
+}
+
+/// Conversion from a device id to a raw device id.
+///
+/// This is meant to be implemented by buses/subsystems so that they can use [`IdTable`] to
+/// guarantee (at compile-time) zero-termination of device id tables provided by drivers.
+///
+/// Originally, RawDeviceId was implemented as a const trait. However, this unstable feature is
+/// broken/gone in 1.73. To work around this, turn IdArray::new() into a macro such that it can use
+/// concrete types (which can still have const associated functions) instead of a trait.
+///
+/// # Safety
+///
+/// Implementers must ensure that:
+///   - [`RawDeviceId::ZERO`] is actually a zeroed-out version of the raw device id.
+///   - [`RawDeviceId::to_rawid`] stores `offset` in the context/data field of the raw device id so
+///     that buses can recover the pointer to the data.
+pub unsafe trait RawDeviceId {
+    /// The raw type that holds the device id.
+    ///
+    /// Id tables created from [`Self`] are going to hold this type in its zero-terminated array.
+    type RawType: Copy;
+
+    /// A zeroed-out representation of the raw device id.
+    ///
+    /// Id tables created from [`Self`] use [`Self::ZERO`] as the sentinel to indicate the end of
+    /// the table.
+    const ZERO: Self::RawType;
+}
+
+/// A zero-terminated device id array, followed by context data.
+#[repr(C)]
+pub struct IdArray<T: RawDeviceId, U, const N: usize> {
+    ids: [T::RawType; N],
+    sentinel: T::RawType,
+    id_infos: [Option<U>; N],
+}
+
+impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
+    const U_NONE: Option<U> = None;
+
+    /// Returns an `IdTable` backed by `self`.
+    ///
+    /// This is used to essentially erase the array size.
+    pub const fn as_table(&self) -> IdTable<'_, T, U> {
+        IdTable {
+            first: &self.ids[0],
+            _p: PhantomData,
+        }
+    }
+
+    /// Creates a new instance of the array.
+    ///
+    /// The contents are derived from the given identifiers and context information.
+    #[doc(hidden)]
+    pub const unsafe fn new(raw_ids: [T::RawType; N], infos: [Option<U>; N]) -> Self
+    where
+        T: RawDeviceId + Copy,
+        T::RawType: Copy + Clone,
+    {
+        Self {
+            ids: raw_ids,
+            sentinel: T::ZERO,
+            id_infos: infos,
+        }
+    }
+
+    #[doc(hidden)]
+    pub const fn get_offset(idx: usize) -> isize
+    where
+        T: RawDeviceId + Copy,
+        T::RawType: Copy + Clone,
+    {
+        // SAFETY: We are only using this dummy value to get offsets.
+        let array = unsafe { Self::new([T::ZERO; N], [Self::U_NONE; N]) };
+        // SAFETY: Both pointers are within `array` (or one byte beyond), consequently they are
+        // derived from the same allocated object. We are using a `u8` pointer, whose size 1,
+        // so the pointers are necessarily 1-byte aligned.
+        let ret = unsafe {
+            (&array.id_infos[idx] as *const _ as *const u8)
+                .offset_from(&array.ids[idx] as *const _ as _)
+        };
+        core::mem::forget(array);
+        ret
+    }
+}
+
+// Creates a new ID array. This is a macro so it can take as a parameter the concrete ID type in
+// order to call to_rawid() on it, and still remain const. This is necessary until a new
+// const_trait_impl implementation lands, since the existing implementation was removed in Rust
+// 1.73.
+#[macro_export]
+#[doc(hidden)]
+macro_rules! _new_id_array {
+    (($($args:tt)*), $id_type:ty) => {{
+        /// Creates a new instance of the array.
+        ///
+        /// The contents are derived from the given identifiers and context information.
+        const fn new< U, const N: usize>(ids: [$id_type; N], infos: [Option<U>; N])
+            -> $crate::driver::IdArray<$id_type, U, N>
+        where
+            $id_type: $crate::driver::RawDeviceId + Copy,
+            <$id_type as $crate::driver::RawDeviceId>::RawType: Copy + Clone,
+        {
+            let mut raw_ids =
+                [<$id_type as $crate::driver::RawDeviceId>::ZERO; N];
+            let mut i = 0usize;
+            while i < N {
+                let offset: isize = $crate::driver::IdArray::<$id_type, U, N>::get_offset(i);
+                raw_ids[i] = ids[i].to_rawid(offset);
+                i += 1;
+            }
+
+            // SAFETY: We are passing valid arguments computed with the correct offsets.
+            unsafe {
+                $crate::driver::IdArray::<$id_type, U, N>::new(raw_ids, infos)
+            }
+       }
+
+        new($($args)*)
+    }}
+}
+
+/// A device id table.
+///
+/// The table is guaranteed to be zero-terminated and to be followed by an array of context data of
+/// type `Option<U>`.
+pub struct IdTable<'a, T: RawDeviceId, U> {
+    first: &'a T::RawType,
+    _p: PhantomData<&'a U>,
+}
+
+impl<T: RawDeviceId, U> AsRef<T::RawType> for IdTable<'_, T, U> {
+    fn as_ref(&self) -> &T::RawType {
+        self.first
+    }
+}
+
+/// Counts the number of parenthesis-delimited, comma-separated items.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::count_paren_items;
+///
+/// assert_eq!(0, count_paren_items!());
+/// assert_eq!(1, count_paren_items!((A)));
+/// assert_eq!(1, count_paren_items!((A),));
+/// assert_eq!(2, count_paren_items!((A), (B)));
+/// assert_eq!(2, count_paren_items!((A), (B),));
+/// assert_eq!(3, count_paren_items!((A), (B), (C)));
+/// assert_eq!(3, count_paren_items!((A), (B), (C),));
+/// ```
+#[macro_export]
+macro_rules! count_paren_items {
+    (($($item:tt)*), $($remaining:tt)*) => { 1 + $crate::count_paren_items!($($remaining)*) };
+    (($($item:tt)*)) => { 1 };
+    () => { 0 };
+}
+
+/// Converts a comma-separated list of pairs into an array with the first element. That is, it
+/// discards the second element of the pair.
+///
+/// Additionally, it automatically introduces a type if the first element is warpped in curly
+/// braces, for example, if it's `{v: 10}`, it becomes `X { v: 10 }`; this is to avoid repeating
+/// the type.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::first_item;
+///
+/// #[derive(PartialEq, Debug)]
+/// struct X {
+///     v: u32,
+/// }
+///
+/// assert_eq!([] as [X; 0], first_item!(X, ));
+/// assert_eq!([X { v: 10 }], first_item!(X, ({ v: 10 }, Y)));
+/// assert_eq!([X { v: 10 }], first_item!(X, ({ v: 10 }, Y),));
+/// assert_eq!([X { v: 10 }], first_item!(X, (X { v: 10 }, Y)));
+/// assert_eq!([X { v: 10 }], first_item!(X, (X { v: 10 }, Y),));
+/// assert_eq!([X { v: 10 }, X { v: 20 }], first_item!(X, ({ v: 10 }, Y), ({ v: 20 }, Y)));
+/// assert_eq!([X { v: 10 }, X { v: 20 }], first_item!(X, ({ v: 10 }, Y), ({ v: 20 }, Y),));
+/// assert_eq!([X { v: 10 }, X { v: 20 }], first_item!(X, (X { v: 10 }, Y), (X { v: 20 }, Y)));
+/// assert_eq!([X { v: 10 }, X { v: 20 }], first_item!(X, (X { v: 10 }, Y), (X { v: 20 }, Y),));
+/// assert_eq!([X { v: 10 }, X { v: 20 }, X { v: 30 }],
+///            first_item!(X, ({ v: 10 }, Y), ({ v: 20 }, Y), ({v: 30}, Y)));
+/// assert_eq!([X { v: 10 }, X { v: 20 }, X { v: 30 }],
+///            first_item!(X, ({ v: 10 }, Y), ({ v: 20 }, Y), ({v: 30}, Y),));
+/// assert_eq!([X { v: 10 }, X { v: 20 }, X { v: 30 }],
+///            first_item!(X, (X { v: 10 }, Y), (X { v: 20 }, Y), (X {v: 30}, Y)));
+/// assert_eq!([X { v: 10 }, X { v: 20 }, X { v: 30 }],
+///            first_item!(X, (X { v: 10 }, Y), (X { v: 20 }, Y), (X {v: 30}, Y),));
+/// ```
+#[macro_export]
+macro_rules! first_item {
+    ($id_type:ty, $(({$($first:tt)*}, $second:expr)),* $(,)?) => {
+        {
+            type IdType = $id_type;
+            [$(IdType{$($first)*},)*]
+        }
+    };
+    ($id_type:ty, $(($first:expr, $second:expr)),* $(,)?) => { [$($first,)*] };
+}
+
+/// Converts a comma-separated list of pairs into an array with the second element. That is, it
+/// discards the first element of the pair.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::second_item;
+///
+/// assert_eq!([] as [u32; 0], second_item!());
+/// assert_eq!([10u32], second_item!((X, 10u32)));
+/// assert_eq!([10u32], second_item!((X, 10u32),));
+/// assert_eq!([10u32], second_item!(({ X }, 10u32)));
+/// assert_eq!([10u32], second_item!(({ X }, 10u32),));
+/// assert_eq!([10u32, 20], second_item!((X, 10u32), (X, 20)));
+/// assert_eq!([10u32, 20], second_item!((X, 10u32), (X, 20),));
+/// assert_eq!([10u32, 20], second_item!(({ X }, 10u32), ({ X }, 20)));
+/// assert_eq!([10u32, 20], second_item!(({ X }, 10u32), ({ X }, 20),));
+/// assert_eq!([10u32, 20, 30], second_item!((X, 10u32), (X, 20), (X, 30)));
+/// assert_eq!([10u32, 20, 30], second_item!((X, 10u32), (X, 20), (X, 30),));
+/// assert_eq!([10u32, 20, 30], second_item!(({ X }, 10u32), ({ X }, 20), ({ X }, 30)));
+/// assert_eq!([10u32, 20, 30], second_item!(({ X }, 10u32), ({ X }, 20), ({ X }, 30),));
+/// ```
+#[macro_export]
+macro_rules! second_item {
+    ($(({$($first:tt)*}, $second:expr)),* $(,)?) => { [$($second,)*] };
+    ($(($first:expr, $second:expr)),* $(,)?) => { [$($second,)*] };
+}
+
+/// Defines a new constant [`IdArray`] with a concise syntax.
+///
+/// It is meant to be used by buses and subsystems to create a similar macro with their device id
+/// type already specified, i.e., with fewer parameters to the end user.
+///
+/// # Examples
+///
+// TODO: Exported but not usable by kernel modules (requires `const_trait_impl`).
+/// ```ignore
+/// #![feature(const_trait_impl)]
+/// # use kernel::{define_id_array, driver::RawDeviceId};
+///
+/// #[derive(Copy, Clone)]
+/// struct Id(u32);
+///
+/// // SAFETY: `ZERO` is all zeroes and `to_rawid` stores `offset` as the second element of the raw
+/// // device id pair.
+/// unsafe impl const RawDeviceId for Id {
+///     type RawType = (u64, isize);
+///     const ZERO: Self::RawType = (0, 0);
+///     fn to_rawid(&self, offset: isize) -> Self::RawType {
+///         (self.0 as u64 + 1, offset)
+///     }
+/// }
+///
+/// define_id_array!(A1, Id, (), []);
+/// define_id_array!(A2, Id, &'static [u8], [(Id(10), None)]);
+/// define_id_array!(A3, Id, &'static [u8], [(Id(10), Some(b"id1")), ]);
+/// define_id_array!(A4, Id, &'static [u8], [(Id(10), Some(b"id1")), (Id(20), Some(b"id2"))]);
+/// define_id_array!(A5, Id, &'static [u8], [(Id(10), Some(b"id1")), (Id(20), Some(b"id2")), ]);
+/// define_id_array!(A6, Id, &'static [u8], [(Id(10), None), (Id(20), Some(b"id2")), ]);
+/// define_id_array!(A7, Id, &'static [u8], [(Id(10), Some(b"id1")), (Id(20), None), ]);
+/// define_id_array!(A8, Id, &'static [u8], [(Id(10), None), (Id(20), None), ]);
+/// ```
+#[macro_export]
+macro_rules! define_id_array {
+    ($table_name:ident, $id_type:ty, $data_type:ty, [ $($t:tt)* ]) => {
+        const $table_name:
+            $crate::driver::IdArray<$id_type, $data_type, { $crate::count_paren_items!($($t)*) }> =
+                $crate::_new_id_array!((
+                    $crate::first_item!($id_type, $($t)*), $crate::second_item!($($t)*)), $id_type);
+    };
+}
+
+/// Defines a new constant [`IdTable`] with a concise syntax.
+///
+/// It is meant to be used by buses and subsystems to create a similar macro with their device id
+/// type already specified, i.e., with fewer parameters to the end user.
+///
+/// # Examples
+///
+// TODO: Exported but not usable by kernel modules (requires `const_trait_impl`).
+/// ```ignore
+/// #![feature(const_trait_impl)]
+/// # use kernel::{define_id_table, driver::RawDeviceId};
+///
+/// #[derive(Copy, Clone)]
+/// struct Id(u32);
+///
+/// // SAFETY: `ZERO` is all zeroes and `to_rawid` stores `offset` as the second element of the raw
+/// // device id pair.
+/// unsafe impl const RawDeviceId for Id {
+///     type RawType = (u64, isize);
+///     const ZERO: Self::RawType = (0, 0);
+///     fn to_rawid(&self, offset: isize) -> Self::RawType {
+///         (self.0 as u64 + 1, offset)
+///     }
+/// }
+///
+/// define_id_table!(T1, Id, &'static [u8], [(Id(10), None)]);
+/// define_id_table!(T2, Id, &'static [u8], [(Id(10), Some(b"id1")), ]);
+/// define_id_table!(T3, Id, &'static [u8], [(Id(10), Some(b"id1")), (Id(20), Some(b"id2"))]);
+/// define_id_table!(T4, Id, &'static [u8], [(Id(10), Some(b"id1")), (Id(20), Some(b"id2")), ]);
+/// define_id_table!(T5, Id, &'static [u8], [(Id(10), None), (Id(20), Some(b"id2")), ]);
+/// define_id_table!(T6, Id, &'static [u8], [(Id(10), Some(b"id1")), (Id(20), None), ]);
+/// define_id_table!(T7, Id, &'static [u8], [(Id(10), None), (Id(20), None), ]);
+/// ```
+#[macro_export]
+macro_rules! define_id_table {
+    ($table_name:ident, $id_type:ty, $data_type:ty, [ $($t:tt)* ]) => {
+        const $table_name: Option<$crate::driver::IdTable<'static, $id_type, $data_type>> = {
+            $crate::define_id_array!(ARRAY, $id_type, $data_type, [ $($t)* ]);
+            Some(ARRAY.as_table())
+        };
+    };
+}
+
+/// Custom code within device removal.
+pub trait DeviceRemoval {
+    /// Cleans resources up when the device is removed.
+    ///
+    /// This is called when a device is removed and offers implementers the chance to run some code
+    /// that cleans state up.
+    fn device_remove(&self);
+}
+
+impl DeviceRemoval for () {
+    fn device_remove(&self) {}
+}
+
+impl<T: DeviceRemoval> DeviceRemoval for Arc<T> {
+    fn device_remove(&self) {
+        self.deref().device_remove();
+    }
+}
+
+impl<T: DeviceRemoval> DeviceRemoval for Box<T> {
+    fn device_remove(&self) {
+        self.deref().device_remove();
+    }
+}
+
+/// A kernel module that only registers the given driver on init.
+///
+/// This is a helper struct to make it easier to define single-functionality modules, in this case,
+/// modules that offer a single driver.
+pub struct Module<T: DriverOps> {
+    _driver: Pin<Box<Registration<T>>>,
+}
+
+impl<T: DriverOps> crate::Module for Module<T> {
+    fn init(name: &'static CStr, module: &'static ThisModule) -> Result<Self> {
+        Ok(Self {
+            _driver: Registration::new_pinned(name, module)?,
+        })
+    }
+}
+
+/// Declares a kernel module that exposes a single driver.
+///
+/// It is meant to be used as a helper by other subsystems so they can more easily expose their own
+/// macros.
+#[macro_export]
+macro_rules! module_driver {
+    (<$gen_type:ident>, $driver_ops:ty, { type: $type:ty, $($f:tt)* }) => {
+        type Ops<$gen_type> = $driver_ops;
+        type ModuleType = $crate::driver::Module<Ops<$type>>;
+        $crate::prelude::module! {
+            type: ModuleType,
+            $($f)*
+        }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 4ba3d4a49e9c..698121c925f3 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -13,6 +13,7 @@
 
 #![no_std]
 #![feature(coerce_unsized)]
+#![feature(const_refs_to_cell)]
 #![feature(dispatch_from_dyn)]
 #![feature(new_uninit)]
 #![feature(receiver_trait)]
@@ -29,6 +30,7 @@
 pub mod alloc;
 mod build_assert;
 pub mod device;
+pub mod driver;
 pub mod error;
 pub mod init;
 pub mod ioctl;
@@ -69,7 +71,7 @@ pub trait Module: Sized + Sync {
     /// should do.
     ///
     /// Equivalent to the `module_init` macro in the C API.
-    fn init(module: &'static ThisModule) -> error::Result<Self>;
+    fn init(name: &'static str::CStr, module: &'static ThisModule) -> error::Result<Self>;
 }
 
 /// Equivalent to `THIS_MODULE` in the C API.
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 27979e582e4b..3e7a6a8560f5 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -275,7 +275,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             }}
 
             fn __init() -> core::ffi::c_int {{
-                match <{type_} as kernel::Module>::init(&THIS_MODULE) {{
+                match <{type_} as kernel::Module>::init(kernel::c_str!(\"{name}\"), &THIS_MODULE) {{
                     Ok(m) => {{
                         unsafe {{
                             __MOD = Some(m);
diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
index 2a9eaab62d1c..3b918ff5eebb 100644
--- a/samples/rust/rust_minimal.rs
+++ b/samples/rust/rust_minimal.rs
@@ -17,7 +17,7 @@ struct RustMinimal {
 }
 
 impl kernel::Module for RustMinimal {
-    fn init(_module: &'static ThisModule) -> Result<Self> {
+    fn init(_name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
         pr_info!("Rust minimal sample (init)\n");
         pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
 
diff --git a/samples/rust/rust_print.rs b/samples/rust/rust_print.rs
index 6eabb0d79ea3..722275a735f1 100644
--- a/samples/rust/rust_print.rs
+++ b/samples/rust/rust_print.rs
@@ -40,7 +40,7 @@ fn arc_print() -> Result {
 }
 
 impl kernel::Module for RustPrint {
-    fn init(_module: &'static ThisModule) -> Result<Self> {
+    fn init(_name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
         pr_info!("Rust printing macros sample (init)\n");
 
         pr_emerg!("Emergency message (level 0) without args\n");
-- 
2.45.1


