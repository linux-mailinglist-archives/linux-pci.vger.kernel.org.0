Return-Path: <linux-pci+bounces-31452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84EFAF8165
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 21:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E980C563193
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 19:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070FD2FEE1A;
	Thu,  3 Jul 2025 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="IuVdeHPY"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261ED2FD893;
	Thu,  3 Jul 2025 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751571080; cv=pass; b=sg55hIBBPIPvYRFLna5kSOMpsnXLhE15QULTG0wlGkJ6Td+U891+cJXSbDj4vynA1z9kNI+dcPGMMfh8bxFCycUWv3SdQ6HKJwdh4EMNMlceiWL6HFEvp10TJPG6qNjfBWUhG3CKLYPXCJNrO2eyi+elX6p16YHPCkPko0nP8iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751571080; c=relaxed/simple;
	bh=ZLDLUqsL9OVHvTzOI6upwErEbN1KGeykv+eKN7VI/Dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kjvuaG9Kh2O6OqU71gS4DRHxL+yO74p8R6c7t5tSojkypvVUnSqgBvFQpuk4FGcosx6icHEkF3rX9UeFDaZ9rVtydT8G4NaGslfomB+mh8edEcbGw/6pUVJaDKS6I7F+HhrKPj+Mv22q5/Yackr3iSPm+FC0vf40UrR4nijwbbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=IuVdeHPY; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751571062; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e+AZRwDOHIFeaOCKT6aPMwFCpTUF2yvll6ii+KdcvwAKKdvsmM725JBbm4qwPkW5uyzk2OZHIUayKhXrubKloYw+XZU7KmGFehb3tDBFsGYyLE1WA/AzX05q8qDL1mS0kgOIfddXVN/ZzQIRcCkKaus4fOM4glzIqjgkdiv18eM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751571062; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sVrpre0c7L2TaP9WKeCKO5pMHXH39R9mkb4dxL3v/Eg=; 
	b=KNMX8CUrrzDgGwBOYhDWTOLKm4rmPWO+3JDkgP0GRB1GYMGIyqyyRwrLOOJDl8uhyZhxAy/g4m6JbbCqeMBHbNMcqPZleI3y/FQ0wTyp5omLnWvOdO3LgpbX2eJ0cnCV1vDwoOmkq4zje+5x0g1arWMYh0UUNtM0DhjzxCjQnI8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751571062;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=sVrpre0c7L2TaP9WKeCKO5pMHXH39R9mkb4dxL3v/Eg=;
	b=IuVdeHPYvvuVWlyfjLVqsdP2GONVOUv1RxQOIa8rcPdBmGwABCdKl0T1hAKXi4sr
	/5OwmfLDzrr1fv/p9IIkTOmQjSl/x66ZxwjSww6/m3tKG2DbARtQUySn1VT5SfouKj/
	hBTekPh61Y71hvLxkz4kEtijGdZv9yVf3j5MqElE=
Received: by mx.zohomail.com with SMTPS id 17515710610641017.9677972502745;
	Thu, 3 Jul 2025 12:31:01 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 03 Jul 2025 16:30:03 -0300
Subject: [PATCH v6 5/6] rust: platform: add irq accessors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-topics-tyr-request_irq-v6-5-74103bdc7c52@collabora.com>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
In-Reply-To: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Benno Lossin <lossin@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-pci@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

These accessors can be used to retrieve a irq::Registration and
irq::ThreadedRegistration from a platform device by
index or name. Alternatively, drivers can retrieve an IrqRequest from a
bound platform device for later use.

These accessors ensure that only valid IRQ lines can ever be registered.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/platform.rs | 143 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 142 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 5b21fa517e55348582622ec10471918919502959..bfcb4962dda7ec420dc86dfa04311be0462ad9f2 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -5,8 +5,11 @@
 //! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
 
 use crate::{
-    bindings, container_of, device, driver,
+    bindings, container_of,
+    device::{self, Bound},
+    driver,
     error::{to_result, Result},
+    irq::{self, request::IrqRequest},
     of,
     prelude::*,
     str::CStr,
@@ -190,6 +193,144 @@ fn as_raw(&self) -> *mut bindings::platform_device {
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
+            irq_name: &'static CStr,
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
+    pub fn request_irq_by_index(&self, index: u32) -> Result<IrqRequest<'_>> {
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
+    /// Returns an [`IrqRequest`] for the IRQ at the given index, but does not print an error if the IRQ cannot be obtained.
+    pub fn request_optional_irq_by_index(&self, index: u32) -> Result<IrqRequest<'_>> {
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
+    pub fn request_irq_by_name(&self, name: &'static CStr) -> Result<IrqRequest<'_>> {
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
+    /// Returns an [`IrqRequest`] for the IRQ with the given name, but does not print an error if the IRQ cannot be obtained.
+    pub fn request_optional_irq_by_name(&self, name: &'static CStr) -> Result<IrqRequest<'_>> {
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
+        irq_by_index, request_irq_by_index, Registration, Handler
+    );
+    define_irq_accessor_by_name!(
+        /// Returns a [`irq::Registration`] for the IRQ with the given name.
+        irq_by_name, request_irq_by_name, Registration, Handler
+    );
+    define_irq_accessor_by_index!(
+        /// Does the same as [`Self::irq_by_index`], except that it does not
+        /// print an error message if the IRQ cannot be obtained.
+        optional_irq_by_index, request_optional_irq_by_index, Registration, Handler
+    );
+    define_irq_accessor_by_name!(
+        /// Does the same as [`Self::irq_by_name`], except that it does not
+        /// print an error message if the IRQ cannot be obtained.
+        optional_irq_by_name, request_optional_irq_by_name, Registration, Handler
+    );
+
+    define_irq_accessor_by_index!(
+        /// Returns a [`irq::ThreadedRegistration`] for the IRQ at the given index.
+        threaded_irq_by_index, request_irq_by_index, ThreadedRegistration, ThreadedHandler
+    );
+    define_irq_accessor_by_name!(
+        /// Returns a [`irq::ThreadedRegistration`] for the IRQ with the given name.
+        threaded_irq_by_name, request_irq_by_name, ThreadedRegistration, ThreadedHandler
+    );
+    define_irq_accessor_by_index!(
+        /// Does the same as [`Self::threaded_irq_by_index`], except that it
+        /// does not print an error message if the IRQ cannot be obtained.
+        optional_threaded_irq_by_index, request_optional_irq_by_index, ThreadedRegistration, ThreadedHandler
+    );
+    define_irq_accessor_by_name!(
+        /// Does the same as [`Self::threaded_irq_by_name`], except that it
+        /// does not print an error message if the IRQ cannot be obtained.
+        optional_threaded_irq_by_name, request_optional_irq_by_name, ThreadedRegistration, ThreadedHandler
+    );
+}
+
 // SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
 // argument.
 kernel::impl_device_context_deref!(unsafe { Device });

-- 
2.50.0


