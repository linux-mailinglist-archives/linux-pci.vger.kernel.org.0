Return-Path: <linux-pci+bounces-33761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192D0B21181
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 18:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7949F687A14
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E7A2E7169;
	Mon, 11 Aug 2025 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e/NbYi8G"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EF42E3B0C;
	Mon, 11 Aug 2025 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928270; cv=none; b=agQF8eiSkQuN4nVyIsEAR+x57NnWcszPApMkJS8QBXwhWfWaNCxkeqR2JJ+wXgbWMVFacr92T+IeymgmFEv1lnIL8u0rfFstRtwKWUL/fARiYsv851f2BSaOYSZN5c9WQq71UWG0jwBwVj2xfrgM2IxwVg4+t0TsIF1amkP+NCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928270; c=relaxed/simple;
	bh=ftvHFAqnHwpqfL/mJ4rFGS5HSYS4tKu3Io7v1aZzEOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sTH9q6FUE2b16v4uYe4EWS/iFqEkcSDy3SHSk4QJM8YQqZ8nLW0rXVAF4jw6oMsYaN0Sq7Ff+O+8ijksO5M1fMPUf/PQ+0AZAFIFyOmvbOLFXJphuUWFVNXL7rOjyjzZJXP5E483jbfgMMys8sJrPpcwZP/tGhU20eJw9USIKuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e/NbYi8G; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754928266;
	bh=ftvHFAqnHwpqfL/mJ4rFGS5HSYS4tKu3Io7v1aZzEOg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e/NbYi8GHMW4wSuhBbeRw7sYcq2qx+jxm49t2SbvANACBr3fxWKTuY10kwaOk8f6+
	 jhupI18JG+8zHkC3a2EwJpJEnwMd/xQI7RTL8CheG6sc3Z51WShUIZFYcoza5sPZPw
	 DF1YeSJGcBWI/qJ7E5ssxUR/am94oSZS6CdWX7eRGNQPta9t7JMfu+icKsKlrpUFvu
	 3iNmxjAQH13bDYJhsj2a8ucGh7FRgzO64k6Xq5q8MCY8IJ6bYYi1gROvtELSBksSK7
	 diAduKOy+S605ra7/6adodLZlnUKBbvMUsQZfH6c793WQPToc4hGcD7Pba7tjBQyCE
	 mnFwsLiUZ+YSg==
Received: from [192.168.0.23] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7637F17E090E;
	Mon, 11 Aug 2025 18:04:22 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Mon, 11 Aug 2025 13:03:43 -0300
Subject: [PATCH v9 5/7] rust: platform: add irq accessors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-topics-tyr-request_irq2-v9-5-0485dcd9bcbf@collabora.com>
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
In-Reply-To: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
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
index 8f028c76f9fa6154f440b48921ba16573a9d3c54..6d640887f69f35fc44fb3c0db3b10f879b55d107 100644
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
+            flags: irq::Flags,
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
+            flags: irq::Flags,
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


