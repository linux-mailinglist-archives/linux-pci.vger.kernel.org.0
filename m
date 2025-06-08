Return-Path: <linux-pci+bounces-29178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45F8AD156C
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 00:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60AE3AB284
	for <lists+linux-pci@lfdr.de>; Sun,  8 Jun 2025 22:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0989B20A5DD;
	Sun,  8 Jun 2025 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="OnD+4dIP"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9F41C8603;
	Sun,  8 Jun 2025 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749423476; cv=pass; b=SXRVPkobXMEcxrZbXHLW5CiYdIvL4ws+L8uYJpbTygm01FXQJoHo5H1F4gOkM0RUirN5CgdcuRBsL05VZTCv92yz8wxFQRU12Cj0GEEZvfQoPFgTYdQG956wavREJKUOz25Y8vf3bGrdD/dTjj5MnQURJMk1cjZX8mIdYaD6A+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749423476; c=relaxed/simple;
	bh=vp1n0dPmM9Jv1QSY817zVrVw8wlQQbwLpS+TPCd20f0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pyyXOOjRNJERMlKCY8GXSFj5MCcaS/mSQ9L7DOsRWr1e4OrIf9j2DEy/jdEzue+mzbgbIesXatHeQda7MrRzgHN2yJF5vl4J72GOJ4CQAilOEuxE7nD2AT0kN6M6M6r5Sfl1NQ7BKIw/P9mZzLn6jzht5HB0Oz6KjnxkN9kkZkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=OnD+4dIP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749423457; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CzU9ry4XUR1KMaG9C3RWB5tGEdrs/GUphTZsehj1T+P7JmgLU4iroJhUdHf1c0JmR9+LxlDFp7V4Dk415cTqfqGmU2L/7CEMGuY9q1h60OD6zFUZuU0H0E8ln5randAsnUdu50ejcWYPtSaQHMAydLeG2W9QtM+VEPddajYyI0c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749423457; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XRbbben/QY/MMFrHBuqsPAvzfh0OcItaymTLVE+DFmU=; 
	b=OBA7932ex3oBPOdIeIZPj3bvw588E6DrPJwQNdP7KBUis7Lz3w9aVvXvAhoc/JkrvFesmdXbUBz9RLp9Q58zPcJH/ICDOl6lTbRjXOq0c1QenYQVglFInswkNHHHvvZd4hBpMgct2qdmx+2uWf6kcj6InMjbAzWtPRHlHDwXCqY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749423457;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=XRbbben/QY/MMFrHBuqsPAvzfh0OcItaymTLVE+DFmU=;
	b=OnD+4dIPUs9KQvRJ+5PjS+wGy3rIa/3KnSiCQaQT1W64iOW6An25xjR3B9seTQbE
	YyJ1GcGFR5vv+7knINV/hnpFX//h+5Xxx9swYiIiv175Iscw5trWpWHayV7fDcC62Qy
	I55U+GL8I8Pj9GiOM/tQDL6cgdM/FYvL06lX7/OA=
Received: by mx.zohomail.com with SMTPS id 1749423454750891.7034064700115;
	Sun, 8 Jun 2025 15:57:34 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Sun, 08 Jun 2025 19:51:10 -0300
Subject: [PATCH v4 5/6] rust: platform: add irq accessors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250608-topics-tyr-request_irq-v4-5-81cb81fb8073@collabora.com>
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
In-Reply-To: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
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
index or name.

These accessors ensure that only valid IRQ lines can ever be registered.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/platform.rs | 127 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 5b21fa517e55348582622ec10471918919502959..3a97e40b2da75f1a48fade3e61760a5814f34653 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -5,9 +5,11 @@
 //! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
 
 use crate::{
-    bindings, container_of, device, driver,
+    bindings, container_of,
+    device::{self, Bound},
+    driver,
     error::{to_result, Result},
-    of,
+    irq, of,
     prelude::*,
     str::CStr,
     types::{ForeignOwnable, Opaque},
@@ -190,6 +192,127 @@ fn as_raw(&self) -> *mut bindings::platform_device {
     }
 }
 
+macro_rules! gen_irq_accessor {
+    ($(#[$meta:meta])* $fn_name:ident, $reg_type:ident, $handler_trait:ident, index, $irq_fn:ident) => {
+        $(#[$meta])*
+        pub fn $fn_name<T: irq::$handler_trait + 'static>(
+            &self,
+            index: u32,
+            flags: irq::flags::Flags,
+            name: &'static CStr,
+            handler: T,
+        ) -> Result<impl PinInit<irq::$reg_type<T>, Error> + '_> {
+            // SAFETY: `self.as_raw` returns a valid pointer to a `struct platform_device`.
+            let irq = unsafe { bindings::$irq_fn(self.as_raw(), index) };
+
+            if irq < 0 {
+                return Err(Error::from_errno(irq));
+            }
+
+            Ok(irq::$reg_type::<T>::register(
+                self.as_ref(),
+                irq as u32,
+                flags,
+                name,
+                handler,
+            ))
+        }
+    };
+
+    ($(#[$meta:meta])* $fn_name:ident, $reg_type:ident, $handler_trait:ident, name, $irq_fn:ident) => {
+        $(#[$meta])*
+        pub fn $fn_name<T: irq::$handler_trait + 'static>(
+            &self,
+            name: &'static CStr,
+            flags: irq::flags::Flags,
+            handler: T,
+        ) -> Result<impl PinInit<irq::$reg_type<T>, Error> + '_> {
+            // SAFETY: `self.as_raw` returns a valid pointer to a `struct platform_device`.
+            let irq = unsafe { bindings::$irq_fn(self.as_raw(), name.as_char_ptr()) };
+
+            if irq < 0 {
+                return Err(Error::from_errno(irq));
+            }
+
+            Ok(irq::$reg_type::<T>::register(
+                self.as_ref(),
+                irq as u32,
+                flags,
+                name,
+                handler,
+            ))
+        }
+    };
+}
+
+impl Device<Bound> {
+    gen_irq_accessor!(
+        /// Returns a [`irq::Registration`] for the IRQ at the given index.
+        irq_by_index, Registration, Handler, index, platform_get_irq
+    );
+    gen_irq_accessor!(
+        /// Returns a [`irq::Registration`] for the IRQ with the given name.
+        irq_by_name,
+        Registration,
+        Handler,
+        name,
+        platform_get_irq_byname
+    );
+    gen_irq_accessor!(
+        /// Does the same as [`Self::irq_by_index`], except that it does not
+        /// print an error message if the IRQ cannot be obtained.
+        optional_irq_by_index,
+        Registration,
+        Handler,
+        index,
+        platform_get_irq_optional
+    );
+    gen_irq_accessor!(
+        /// Does the same as [`Self::irq_by_name`], except that it does not
+        /// print an error message if the IRQ cannot be obtained.
+        optional_irq_by_name,
+        Registration,
+        Handler,
+        name,
+        platform_get_irq_byname_optional
+    );
+
+    gen_irq_accessor!(
+        /// Returns a [`irq::ThreadedRegistration`] for the IRQ at the given index.
+        threaded_irq_by_index,
+        ThreadedRegistration,
+        ThreadedHandler,
+        index,
+        platform_get_irq
+    );
+    gen_irq_accessor!(
+        /// Returns a [`irq::ThreadedRegistration`] for the IRQ with the given name.
+        threaded_irq_by_name,
+        ThreadedRegistration,
+        ThreadedHandler,
+        name,
+        platform_get_irq_byname
+    );
+    gen_irq_accessor!(
+        /// Does the same as [`Self::threaded_irq_by_index`], except that it
+        /// does not print an error message if the IRQ cannot be obtained.
+        optional_threaded_irq_by_index,
+        ThreadedRegistration,
+        ThreadedHandler,
+        index,
+        platform_get_irq_optional
+    );
+    gen_irq_accessor!(
+        /// Does the same as [`Self::threaded_irq_by_name`], except that it
+        /// does not print an error message if the IRQ cannot be obtained.
+        optional_threaded_irq_by_name,
+        ThreadedRegistration,
+        ThreadedHandler,
+        name,
+        platform_get_irq_byname_optional
+    );
+}
+
 // SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
 // argument.
 kernel::impl_device_context_deref!(unsafe { Device });

-- 
2.49.0


