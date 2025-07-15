Return-Path: <linux-pci+bounces-32171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1827B062C5
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 17:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFBE21894D03
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 15:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3D825A2C0;
	Tue, 15 Jul 2025 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iSy5VCDY"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D664921B9E2;
	Tue, 15 Jul 2025 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592635; cv=none; b=nYzHqDDAzS4UcBaoO6ylakBkiEqo6DYrWeVui1Uz1q0DPqU3gkCf6FraeFqeq3XLeVn5MXnlXPcv7rL6diYkEDbipzL0Abgd6ymseOmkb+q8vFqaRbI5c+7S5w8sqfpmAAQhxzm8XQaaxV9v8tzcrlM28v2UHjQJRx7Y7dcQVgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592635; c=relaxed/simple;
	bh=hDBDz41qpLHB3oj7BUa1RgzJiVkl4PhvA5k8G6iWXYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O6lqV4tB7n/6ewQWV1ra8Bf3UK07pkubUZ+XNj+v0IICNhMwSA6U+Jl4zsh5bqqwacJFC7mt/LiY1fx7xcuo8va7sbjoA7n046mSIeS7RfBpFHTj3IGMxEOs4XXS+j7HpzLuLzI0+YpLDkZGXZs5C0HS9iiJoWMgYmI1KVByxQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iSy5VCDY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752592632;
	bh=hDBDz41qpLHB3oj7BUa1RgzJiVkl4PhvA5k8G6iWXYQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iSy5VCDYtR6JhPh0S18NACM1GdFqtkoIxhNo5fbN9tRJLTnXZvERKziXwboBAEw20
	 vbKJsHJWab8vRhMB35Q/BOZ/zwu4NxnKLJA9hJ4RT9Rv5PF4MfsYjRUAbRMzhqS/Ab
	 1oIHYKtfuPCKRjj6Ntm1OUgav8lR47EiHvMhvB+7S5ujnYu6vVRoW340X46BhqfpfL
	 /rPDWYTa3u2SU/nXUmzNYsVUZgEqlBaKuUzdcsiBdt0qrB+dvnVc+s6U/qmH1Ad6We
	 EXaeJGBwBWgm/Hv6z30ku84fYiENv0jsogl3aXO72fOKnMDkz2pB0a66Bb0QYrH9L9
	 53mXvJYdxgEtw==
Received: from [192.168.0.2] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6296A17E1324;
	Tue, 15 Jul 2025 17:17:09 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 15 Jul 2025 12:16:42 -0300
Subject: [PATCH v7 5/6] rust: platform: add irq accessors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-topics-tyr-request_irq2-v7-5-d469c0f37c07@collabora.com>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
In-Reply-To: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-pci@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

These accessors can be used to retrieve a irq::Registration and
irq::ThreadedRegistration from a platform device by
index or name. Alternatively, drivers can retrieve an IrqRequest from a
bound platform device for later use.

These accessors ensure that only valid IRQ lines can ever be registered.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/platform.rs | 146 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 145 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index ced43367d900bcb87c0ce1af3981f5e5af129840..ba334bfdaf1db4cb60a33ef275739958bc4c77d5 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -5,8 +5,11 @@
 //! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
 
 use crate::{
-    acpi, bindings, container_of, device, driver,
+    acpi, bindings, container_of,
+    device::{self, Bound},
+    driver,
     error::{from_result, to_result, Result},
+    irq::{self, IrqRequest},
     of,
     prelude::*,
     types::Opaque,
@@ -226,6 +229,147 @@ fn as_raw(&self) -> *mut bindings::platform_device {
     }
 }
 
+macro_rules! define_irq_accessor_by_index {
+    ($(#[$meta:meta])* $fn_name:ident, $request_fn:ident, $reg_type:ident, $handler_trait:ident) => {
+        $(#[$meta])*
+        pub fn $fn_name<T: irq::$handler_trait + 'static>(
+            &self,
+            flags: irq::flags::Flags,
+            index: u32,
+            name: &'static CStr,
+            handler: T,
+        ) -> Result<impl PinInit<irq::$reg_type<T>, Error> + '_> {
+            let request = self.$request_fn(index)?;
+
+            Ok(irq::$reg_type::<T>::new(
+                request,
+                flags,
+                name,
+                handler,
+            ))
+        }
+    };
+}
+
+macro_rules! define_irq_accessor_by_name {
+    ($(#[$meta:meta])* $fn_name:ident, $request_fn:ident, $reg_type:ident, $handler_trait:ident) => {
+        $(#[$meta])*
+        pub fn $fn_name<T: irq::$handler_trait + 'static>(
+            &self,
+            flags: irq::flags::Flags,
+            irq_name: &CStr,
+            name: &'static CStr,
+            handler: T,
+        ) -> Result<impl PinInit<irq::$reg_type<T>, Error> + '_> {
+            let request = self.$request_fn(irq_name)?;
+
+            Ok(irq::$reg_type::<T>::new(
+                request,
+                flags,
+                name,
+                handler,
+            ))
+        }
+    };
+}
+
+impl Device<Bound> {
+    /// Returns an [`IrqRequest`] for the IRQ at the given index, if any.
+    pub fn irq_by_index(&self, index: u32) -> Result<IrqRequest<'_>> {
+        // SAFETY: `self.as_raw` returns a valid pointer to a `struct platform_device`.
+        let irq = unsafe { bindings::platform_get_irq(self.as_raw(), index) };
+
+        if irq < 0 {
+            return Err(Error::from_errno(irq));
+        }
+
+        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `&self`.
+        Ok(unsafe { IrqRequest::new(self.as_ref(), irq as u32) })
+    }
+
+    /// Returns an [`IrqRequest`] for the IRQ at the given index, but does not
+    /// print an error if the IRQ cannot be obtained.
+    pub fn optional_irq_by_index(&self, index: u32) -> Result<IrqRequest<'_>> {
+        // SAFETY: `self.as_raw` returns a valid pointer to a `struct platform_device`.
+        let irq = unsafe { bindings::platform_get_irq_optional(self.as_raw(), index) };
+
+        if irq < 0 {
+            return Err(Error::from_errno(irq));
+        }
+
+        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `&self`.
+        Ok(unsafe { IrqRequest::new(self.as_ref(), irq as u32) })
+    }
+
+    /// Returns an [`IrqRequest`] for the IRQ with the given name, if any.
+    pub fn irq_by_name(&self, name: &CStr) -> Result<IrqRequest<'_>> {
+        // SAFETY: `self.as_raw` returns a valid pointer to a `struct platform_device`.
+        let irq = unsafe { bindings::platform_get_irq_byname(self.as_raw(), name.as_char_ptr()) };
+
+        if irq < 0 {
+            return Err(Error::from_errno(irq));
+        }
+
+        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `&self`.
+        Ok(unsafe { IrqRequest::new(self.as_ref(), irq as u32) })
+    }
+
+    /// Returns an [`IrqRequest`] for the IRQ with the given name, but does not
+    /// print an error if the IRQ cannot be obtained.
+    pub fn optional_irq_by_name(&self, name: &CStr) -> Result<IrqRequest<'_>> {
+        // SAFETY: `self.as_raw` returns a valid pointer to a `struct platform_device`.
+        let irq = unsafe {
+            bindings::platform_get_irq_byname_optional(self.as_raw(), name.as_char_ptr())
+        };
+
+        if irq < 0 {
+            return Err(Error::from_errno(irq));
+        }
+
+        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `&self`.
+        Ok(unsafe { IrqRequest::new(self.as_ref(), irq as u32) })
+    }
+
+    define_irq_accessor_by_index!(
+        /// Returns a [`irq::Registration`] for the IRQ at the given index.
+        request_irq_by_index, irq_by_index, Registration, Handler
+    );
+    define_irq_accessor_by_name!(
+        /// Returns a [`irq::Registration`] for the IRQ with the given name.
+        request_irq_by_name, irq_by_name, Registration, Handler
+    );
+    define_irq_accessor_by_index!(
+        /// Does the same as [`Self::request_irq_by_index`], except that it does
+        /// not print an error message if the IRQ cannot be obtained.
+        request_optional_irq_by_index, optional_irq_by_index, Registration, Handler
+    );
+    define_irq_accessor_by_name!(
+        /// Does the same as [`Self::request_irq_by_name`], except that it does
+        /// not print an error message if the IRQ cannot be obtained.
+        request_optional_irq_by_name, optional_irq_by_name, Registration, Handler
+    );
+
+    define_irq_accessor_by_index!(
+        /// Returns a [`irq::ThreadedRegistration`] for the IRQ at the given index.
+        request_threaded_irq_by_index, irq_by_index, ThreadedRegistration, ThreadedHandler
+    );
+    define_irq_accessor_by_name!(
+        /// Returns a [`irq::ThreadedRegistration`] for the IRQ with the given name.
+        request_threaded_irq_by_name, irq_by_name, ThreadedRegistration, ThreadedHandler
+    );
+    define_irq_accessor_by_index!(
+        /// Does the same as [`Self::request_threaded_irq_by_index`], except
+        /// that it does not print an error message if the IRQ cannot be
+        /// obtained.
+        request_optional_threaded_irq_by_index, optional_irq_by_index, ThreadedRegistration, ThreadedHandler
+    );
+    define_irq_accessor_by_name!(
+        /// Does the same as [`Self::request_threaded_irq_by_name`], except that
+        /// it does not print an error message if the IRQ cannot be obtained.
+        request_optional_threaded_irq_by_name, optional_irq_by_name, ThreadedRegistration, ThreadedHandler
+    );
+}
+
 // SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
 // argument.
 kernel::impl_device_context_deref!(unsafe { Device });

-- 
2.50.0


