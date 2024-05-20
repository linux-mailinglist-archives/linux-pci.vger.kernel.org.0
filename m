Return-Path: <linux-pci+bounces-7672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E468CA14C
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 19:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D411C210F5
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 17:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1233753E13;
	Mon, 20 May 2024 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXtih3sE"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C10137C5A
	for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226023; cv=none; b=VbfN2yyDkXzGsrhIKeY19dfQoAS0NNf99LWiENy2rYHOQ99SbF3IeV9DXSqQfAdXecdbl0T4m6j+tW4OUufsRujyIa3qva7xtZ2K9lOh8xeWv5do172Fcb6bPowILULsxWfwtbj6ssrNuUP8OQ+mF2rkwEvpJbu4ZLRObaf3NJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226023; c=relaxed/simple;
	bh=rAhFipo4bK8HmFg4tJSDidtDJaUeETRwaBwak+PMNa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7ghbskCTVDz5MgsDW1Xt8nK2mATKJfEU2o4gGtTvnDZFiTboRtwWO/fCqO+VRZD5aPTITSHyeOeCn/PAP9vneJQK4BQsKl9We/KJgShrJgJ/bcwlBwSeQ9IqS9gBBxvZHlJ+D5EJ+ijWNv9z32ZGX+J5qCOZ3WiYGDqniDAj08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXtih3sE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716226020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R91zVu6bvxpu1aXFiFEweUnqMPVUvsNACvUAs6c3Gw8=;
	b=NXtih3sEu3EVoULI8ELtahmVpQ2Sx/VtfC/RoDIOjWZyF1dOZEKWcND9kzXbJrvTNJSHyu
	oG8Vdy0AWmEwLvhNgAdafotemtWYkPXNhSNkr3K399jOy3NwIplaNXavUu1c3gRvGbzc1x
	Tmti/1Th249tL9PVrMOjpdARr+kYmuk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-IQCZzAtKNDm1STrEQfhqLw-1; Mon, 20 May 2024 13:26:59 -0400
X-MC-Unique: IQCZzAtKNDm1STrEQfhqLw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34dc66313b3so7172315f8f.2
        for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 10:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716226018; x=1716830818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R91zVu6bvxpu1aXFiFEweUnqMPVUvsNACvUAs6c3Gw8=;
        b=u/HUrrw9QK9LlTMP4+XntysnVNWogXQ6157W3RSRN+dYgh3uYJkIESA1y7bzxV4bO/
         MWNSfPzYH1UkJdfUvVYoM6mL2WaZ4GGlOeI+0bx40OZkb0KGfNwBLGd+lQvP5skbDHDG
         1os5SUk/bBtJzU9i+biUZDlgzWXN8T54KRVryNvKQeGocTO+Z2ShTiq2bHea/LvfBR7a
         VWtPSQN3JCec33FanbKk/MVThMBQPOPtb/UIfTJM4gwmp/PuiPPkp343u3hkEgUOXR0c
         ouDSwoZIfkkghYNmNiksGT4wBIIfl+Ur18H+ksAhUTjH/GmCU+n12FFDoxttJXyReFvd
         ac+g==
X-Forwarded-Encrypted: i=1; AJvYcCVn2P9CHqWMM3Es/YTHAHZ02CK+t9pUr5+kI6GnKB6jJbs9DYvRP35MrGZ4XAQ/p93YqCYQ6+PSkPbgKn81z6o/I4/zTg/mUrp8
X-Gm-Message-State: AOJu0YwfvM5MagOypTPtopBnHfSFY2YA1cQGhK+33JL6Mbc493/7Rp5P
	/hfdrIliwDxKbuQSTt4EeHAtyZxKD/TOiQOXSEBFKccsWdsoGXaKRapB8rMGrrkyRxLu2bgaVxb
	1cSb3JctaAaVoCY7wZZvoCxnlnHza7PYfqVZvz0GEkq0C4TlRZ87m0Schsg==
X-Received: by 2002:a05:6000:1968:b0:34f:96ba:ca3a with SMTP id ffacd0b85a97d-3504a61c7cemr32867600f8f.13.1716226017551;
        Mon, 20 May 2024 10:26:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs4uhCF4pA+lofxQie6yGvKq+LktARuDSM8VVafM6mbOTF89vjV0qTL+7VA81QWNIEkG1APA==
X-Received: by 2002:a05:6000:1968:b0:34f:96ba:ca3a with SMTP id ffacd0b85a97d-3504a61c7cemr32867560f8f.13.1716226016428;
        Mon, 20 May 2024 10:26:56 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354bd2e2a5asm6620842f8f.45.2024.05.20.10.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 10:26:55 -0700 (PDT)
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
Subject: [RFC PATCH 01/11] rust: add abstraction for struct device
Date: Mon, 20 May 2024 19:25:38 +0200
Message-ID: <20240520172554.182094-2-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520172554.182094-1-dakr@redhat.com>
References: <20240520172554.182094-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add an (always) reference counted abstraction for a generic struct
device. This abstraction encapsulates existing struct device instances
and manages its reference count.

Subsystems may use this abstraction as a base to abstract subsystem
specific device instances based on a generic struct device.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/helpers.c        |  1 +
 rust/kernel/device.rs | 76 +++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs    |  1 +
 3 files changed, 78 insertions(+)
 create mode 100644 rust/kernel/device.rs

diff --git a/rust/helpers.c b/rust/helpers.c
index 4c8b7b92a4f4..f9d2db1d1f33 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -23,6 +23,7 @@
 #include <kunit/test-bug.h>
 #include <linux/bug.h>
 #include <linux/build_bug.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errname.h>
 #include <linux/mutex.h>
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
new file mode 100644
index 000000000000..fafec70effb6
--- /dev/null
+++ b/rust/kernel/device.rs
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic devices that are part of the kernel's driver model.
+//!
+//! C header: [`include/linux/device.h`](../../../../include/linux/device.h)
+
+use crate::{
+    bindings,
+    types::{ARef, Opaque},
+};
+use core::ptr;
+
+/// A ref-counted device.
+///
+/// # Invariants
+///
+/// The pointer stored in `Self` is non-null and valid for the lifetime of the ARef instance. In
+/// particular, the ARef instance owns an increment on underlying object’s reference count.
+#[repr(transparent)]
+pub struct Device(Opaque<bindings::device>);
+
+impl Device {
+    /// Creates a new ref-counted instance of an existing device pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count.
+    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Self> {
+        // SAFETY: By the safety requirements, ptr is valid.
+        // Initially increase the reference count by one to compensate for the final decrement once
+        // this newly created `ARef<Device>` instance is dropped.
+        unsafe { bindings::get_device(ptr) };
+
+        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::device`.
+        let ptr = ptr.cast::<Self>();
+
+        // SAFETY: By the safety requirements, ptr is valid.
+        unsafe { ARef::from_raw(ptr::NonNull::new_unchecked(ptr)) }
+    }
+
+    /// Obtain the raw `struct device *`.
+    pub(crate) fn as_raw(&self) -> *mut bindings::device {
+        self.0.get()
+    }
+
+    /// Convert a raw `struct device` pointer to a `&Device`.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count for
+    /// the entire duration when the returned reference exists.
+    pub unsafe fn as_ref<'a>(ptr: *mut bindings::device) -> &'a Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        unsafe { &*ptr.cast() }
+    }
+}
+
+// SAFETY: Instances of `Device` are always ref-counted.
+unsafe impl crate::types::AlwaysRefCounted for Device {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference guarantees that the refcount is nonzero.
+        unsafe { bindings::get_device(self.as_raw()) };
+    }
+
+    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
+        unsafe { bindings::put_device(obj.cast().as_ptr()) }
+    }
+}
+
+// SAFETY: `Device` only holds a pointer to a C device, which is safe to be used from any thread.
+unsafe impl Send for Device {}
+
+// SAFETY: `Device` only holds a pointer to a C device, references to which are safe to be used
+// from any thread.
+unsafe impl Sync for Device {}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 9a943d99c71a..4ba3d4a49e9c 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -28,6 +28,7 @@
 
 pub mod alloc;
 mod build_assert;
+pub mod device;
 pub mod error;
 pub mod init;
 pub mod ioctl;
-- 
2.45.1


