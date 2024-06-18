Return-Path: <linux-pci+bounces-8942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEEA90E009
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 01:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D47FB2189B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 23:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F095718A936;
	Tue, 18 Jun 2024 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UasgZXeA"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B151891CF
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754059; cv=none; b=iYumt1UWuJwVzkZqI14T7xmm+rZH+AfgOa3tnerdo356KfN/wPyiXxaIxPc4O1uUiDqJTSTm+7L2TwrBQykrpogW9UEyrPXTF9URdeZhW5FCs8u0K36AVgKjTrXnm/vqgyKPQRvx9x88/O/d7Fs3SERxSCQdPkLwNpRWCrMmmxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754059; c=relaxed/simple;
	bh=+7YZ7zoHeaWY2jj+Hmsqe+5GAkc7KbDsloUj0Ihy+bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhicJNMDXCf7T5XmjBnyHiapzRu7+IDQzLPHt6LbjRfkw02Fli2xRDEaaLqNa6tUUXLaPJZZ0b7IHHMhtFVfxow74M07DJWNnWcFbn4n1CFOYLCg+JSgL/RneLGTFUdFbRINfNLopKjCh7f7v9bp7Ov785QTsulFxZVOk5DgUQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UasgZXeA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718754057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBDr9a0UbEqIFlf/LskXVOaMDv/jbs0Q1ckYvSRHn7Y=;
	b=UasgZXeASfmYdUUyHSZRsRdFuZl9n2h7uMCzTGfhDb6twUKCDEDfiIoP7l3V7VIA057ZZH
	QwLQwoV7XKQlu+R4ykXkraV7XuHfBqV7ONhHcP6kT03GgvJ+5YO1r6Ybay0pnVRFu7M1AD
	LEKPIAN0NV5Fg7X6IQjKxYiO8lKkAVc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-Be2ejHNLNxeSImeCu6TgDg-1; Tue, 18 Jun 2024 19:40:55 -0400
X-MC-Unique: Be2ejHNLNxeSImeCu6TgDg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4246ed3f877so11568415e9.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 16:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718754054; x=1719358854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBDr9a0UbEqIFlf/LskXVOaMDv/jbs0Q1ckYvSRHn7Y=;
        b=VkqFjICuq5Y52p3cEPda/0NXx+qYRNXCI0OBeLJpslTs59g3VtzQM2tNFP4oyNWHLN
         MwYkzbBofQ3/zptapRwWdDePXhJlcLsd0vFcwrMVCpO15kkurM/88fuW8PoRNt3WBLFh
         PR5S2yEXUhpX1FE6m9SZrUunvLxedomY4CyyhiFKoC6ds9bOZLChhPkYzn6nESTGCMHV
         idKmTiIRn3Vf/4nfWZOg+Fu+DGePpFe0WSrw7DnVBDyLtz58QsAnru5awDNHMhvnJcqq
         2kZYHr5ygBnqrUosgOGtJwhSbtnuBeveqTVSxk5W2f0vmx2T6p2K02Dv8NZDPVGCMKyi
         GE0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZQwoli6i/dE3tPpSwwe8jAOrEPFaHsexriHToFbsv+H/npyJU4qmWnyl9kzMVh/3NZwQhibumoW1ZBgFg92jz92x8OAAit1rG
X-Gm-Message-State: AOJu0YxxytyAkHT2PRWpizsGzyT6FkYaYY9XlpG2DhX5flqygiDTSc9K
	aSEm0DU7yI7DIUYJYDBrGXu56VRqKx5xC941P8BZyTrqR+uB83duHu7wyNnzSW/O3o2QMqh0aFI
	iyPcONQOXRuNwcJ5VR9ZNl3DMbUEBy0o2f0db69T/0jmzQJG+um937Y69Vg==
X-Received: by 2002:a05:600c:4999:b0:422:615f:6499 with SMTP id 5b1f17b1804b1-42475296a36mr5599295e9.31.1718754054191;
        Tue, 18 Jun 2024 16:40:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEufWj1Ckx6qQqVdF2phLsYFyC0caxpANSWAXdqR9eux02qPS2yQharLpwxEtuSMotu8Vow8w==
X-Received: by 2002:a05:600c:4999:b0:422:615f:6499 with SMTP id 5b1f17b1804b1-42475296a36mr5599025e9.31.1718754053787;
        Tue, 18 Jun 2024 16:40:53 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-362e3e1abd5sm1407662f8f.47.2024.06.18.16.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 16:40:53 -0700 (PDT)
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
Subject: [PATCH v2 03/10] rust: implement `IdArray`, `IdTable` and `RawDeviceId`
Date: Wed, 19 Jun 2024 01:39:49 +0200
Message-ID: <20240618234025.15036-4-dakr@redhat.com>
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

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Most subsystems use some kind of ID to match devices and drivers. Hence,
we have to provide Rust drivers an abstraction to register an ID table
for the driver to match.

Generally, those IDs are subsystem specific and hence need to be
implemented by the corresponding subsystem. However, the `IdArray`,
`IdTable` and `RawDeviceId` types provide a generalized implementation
that makes the life of subsystems easier to do so.

Co-developed-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Danilo Krummrich <dakr@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/device_id.rs | 336 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs       |   2 +
 2 files changed, 338 insertions(+)
 create mode 100644 rust/kernel/device_id.rs

diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
new file mode 100644
index 000000000000..c490300f29bb
--- /dev/null
+++ b/rust/kernel/device_id.rs
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic implementation of device IDs.
+//!
+//! Each bus / subsystem that matches device and driver through a bus / subsystem specific ID is
+//! expected to implement [`RawDeviceId`].
+
+use core::marker::PhantomData;
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
+///   - `to_rawid` is implemented and stores `offset` in the context/data field of the raw device
+///     id so that buses can recover the pointer to the data. (This should actually be a trait
+///     function, however, this requires `const_trait_impl`, and hence has to changed once the
+///     feature is stabilized.)
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
+// Creates a new ID array. This is a macro so it can take the concrete ID type as a parameter in
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
+            -> $crate::device_id::IdArray<$id_type, U, N>
+        where
+            $id_type: $crate::device_id::RawDeviceId + Copy,
+            <$id_type as $crate::device_id::RawDeviceId>::RawType: Copy + Clone,
+        {
+            let mut raw_ids =
+                [<$id_type as $crate::device_id::RawDeviceId>::ZERO; N];
+            let mut i = 0usize;
+            while i < N {
+                let offset: isize = $crate::device_id::IdArray::<$id_type, U, N>::get_offset(i);
+                raw_ids[i] = ids[i].to_rawid(offset);
+                i += 1;
+            }
+
+            // SAFETY: We are passing valid arguments computed with the correct offsets.
+            unsafe {
+                $crate::device_id::IdArray::<$id_type, U, N>::new(raw_ids, infos)
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
+/// ```
+/// # use kernel::{define_id_array, device_id::RawDeviceId};
+///
+/// #[derive(Copy, Clone)]
+/// struct Id(u32);
+///
+/// // SAFETY: `ZERO` is all zeroes and `to_rawid` stores `offset` as the second element of the raw
+/// // device id pair.
+/// unsafe impl RawDeviceId for Id {
+///     type RawType = (u64, isize);
+///     const ZERO: Self::RawType = (0, 0);
+/// }
+///
+/// impl Id {
+///     #[allow(clippy::wrong_self_convention)]
+///     const fn to_rawid(&self, offset: isize) -> <Id as RawDeviceId>::RawType {
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
+        const $table_name: $crate::device_id::IdArray<$id_type,
+                                                      $data_type, {
+                                                          $crate::count_paren_items!($($t)*)
+                                                      }> = $crate::_new_id_array!(
+                                                          ($crate::first_item!($id_type, $($t)*),
+                                                           $crate::second_item!($($t)*)),
+                                                          $id_type);
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
+/// ```
+/// # use kernel::{define_id_table, device_id::RawDeviceId};
+///
+/// #[derive(Copy, Clone)]
+/// struct Id(u32);
+///
+/// // SAFETY: `ZERO` is all zeroes and `to_rawid` stores `offset` as the second element of the raw
+/// // device id pair.
+/// unsafe impl RawDeviceId for Id {
+///     type RawType = (u64, isize);
+///     const ZERO: Self::RawType = (0, 0);
+/// }
+///
+/// impl Id {
+///     #[allow(clippy::wrong_self_convention)]
+///     const fn to_rawid(&self, offset: isize) -> <Id as RawDeviceId>::RawType {
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
+        const $table_name: Option<$crate::device_id::IdTable<'static, $id_type, $data_type>> = {
+            $crate::define_id_array!(ARRAY, $id_type, $data_type, [ $($t)* ]);
+            Some(ARRAY.as_table())
+        };
+    };
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 5382402cd3db..98e1a1425d17 100644
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
+pub mod device_id;
 pub mod driver;
 pub mod error;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
-- 
2.45.1


