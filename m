Return-Path: <linux-pci+bounces-33681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8AAB1FD51
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 02:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C683B9DE2
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 00:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564B4199223;
	Mon, 11 Aug 2025 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CoXQ2C6b"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD4E19539F;
	Mon, 11 Aug 2025 00:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754872393; cv=none; b=eJcDkfhLeqjLoVv/Jp+NRHMy+VZ7T1ecv4gSgZzX/558uiA/3g3MFfajE+R1JlM+qeynwQo8JgAwuu78avIvIsyGKVPRbQycaSK4HUNf9W+vdhkln4dsBs14kzX6R/cQaDmHY7LXe5pBIIhSwvZs7t0XtfyK+vfRb6DpfW5LQH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754872393; c=relaxed/simple;
	bh=Dd+6P2rEkSurWWDJcsJvnm07xO7Q2w99oFGtjKlf0+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rc3PuEfNaB+jUNps03hKnkWYHYPS1quuR1iXICfp0nT7xs7QJJ5qQx1WlRVJQ2YCi0BeV+giED0Nl3DTcl7jLywJikjddGyv/8tBmfbOM/HgyISTA7bbgT95MgCGeBdpwLYCf+AWSOOXD8zF2l2rpsmxtsTJdUyMdxcoAFcOkwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CoXQ2C6b; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754872389;
	bh=Dd+6P2rEkSurWWDJcsJvnm07xO7Q2w99oFGtjKlf0+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CoXQ2C6b3lYKyBVyto1zxvl3Wl7f1kgmHa86eXivXX5bq7TQmyF9+OWMmdNMYEn5z
	 LSEJJJXZPS0oTQv9NgRzwBIzfhwMYKGr49RFEhYvgVlVCgRkDuOiXr/UcjDlNrC22O
	 hCcjbKMu9mLZsTbIkpmHKOzJRiO1LQ0FTt91aPBZUVmHYborXoa+d71UMDkU7sjQUd
	 ZFy9JKNohoBDr5rcIzj0+qNAVtBXNOG+s9a/oUO8GE4F30D9DDctVAOvfjN6l7s0Ju
	 PeR/1lR8qtGeBmGTXUlVzw6GHv9t8D1hL/s9oJgSlVXHAAyfbje/DUNV5OpX07XXqv
	 mRZ/pLvnfnEEg==
Received: from [192.168.0.23] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F2C2D17E090E;
	Mon, 11 Aug 2025 02:33:04 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Sun, 10 Aug 2025 21:32:18 -0300
Subject: [PATCH v8 5/6] rust: platform: add irq accessors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-topics-tyr-request_irq2-v8-5-8163f4c4c3a6@collabora.com>
References: <20250810-topics-tyr-request_irq2-v8-0-8163f4c4c3a6@collabora.com>
In-Reply-To: <20250810-topics-tyr-request_irq2-v8-0-8163f4c4c3a6@collabora.com>
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
 linux-pci@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>, 
 Dirk Behme <dirk.behme@de.bosch.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

These accessors can be used to retrieve a irq::Registration and
irq::ThreadedRegistration from a platform device by
index or name. Alternatively, drivers can retrieve an IrqRequest from a
bound platform device for later use.

These accessors ensure that only valid IRQ lines can ever be registered.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/platform.rs | 142 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 8f028c76f9fa6154f440b48921ba16573a9d3c54..8351588911991efaad8c749faf4b3e6a35995e2c 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -10,6 +10,7 @@
     driver,
     error::{from_result, to_result, Result},
     io::{mem::IoRequest, Resource},
+    irq::{self, IrqRequest},
     of,
     prelude::*,
     types::Opaque,
@@ -284,6 +285,147 @@ pub fn io_request_by_name(&self, name: &CStr) -> Option<IoRequest<'_>> {
     }
 }
 
+macro_rules! define_irq_accessor_by_index {
+    ($(#[$meta:meta])* $fn_name:ident, $request_fn:ident, $reg_type:ident, $handler_trait:ident) => {
+        $(#[$meta])*
+        pub fn $fn_name<'a, T: irq::$handler_trait + 'static>(
+            &'a self,
+            flags: irq::flags::Flags,
+            index: u32,
+            name: &'static CStr,
+            handler: impl PinInit<T, Error> + 'a,
+        ) -> Result<impl PinInit<irq::$reg_type<T>, Error> + 'a> {
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
+        pub fn $fn_name<'a, T: irq::$handler_trait + 'static>(
+            &'a self,
+            flags: irq::flags::Flags,
+            irq_name: &CStr,
+            name: &'static CStr,
+            handler: impl PinInit<T, Error> + 'a,
+        ) -> Result<impl PinInit<irq::$reg_type<T>, Error> + 'a> {
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
2.50.1


