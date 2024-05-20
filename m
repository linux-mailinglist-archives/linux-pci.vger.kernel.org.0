Return-Path: <linux-pci+bounces-7679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D608CA15D
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 19:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30D67B21D1C
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 17:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C6813A875;
	Mon, 20 May 2024 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvzrCzGo"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C0513A41B
	for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226051; cv=none; b=DhWD7viFNQAzoN/L/wfRWVAa6JCc64oP9QAd2UQhbdyKzsfayf6R3oZqqO+BE2nOvpcliGeHq2RIwZHpsOcXHiEgeNGGiPnuS4pfaaNjcq13XH4yb15jjRoPtuUPdbof1c992NtVYI1Nh/5PiO3bJe+sIHDqXdAOpJqkHgbW38c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226051; c=relaxed/simple;
	bh=Pf+OOnuHz5mcZsGqaVhIEIMHurAZcjaBobj/NJHA3CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlfV8YKP9TT4wb7nqTJLfgrzw57LTsXxUs73Vw4k03KHqzqjyZHBWrtKEFq862/0IkcnMNRSK9p1xDAH/34tKZSuPxZEGhypruHqpk/P0ii7ZBNVvXb3pavEtqRJo/RqM5avHvY4HSYOAbLlpE8xg3vx11SsJqmGw0JnlvTwqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SvzrCzGo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716226048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1CsnJXGBZcLyYjfrlAMv2FyBTh8bc+Mt3a3EbW5Rnks=;
	b=SvzrCzGo9wb2DXXlFn5leFcfH0Ok8ax85GHnujv3sSaCXzxc3fWYxmyILkAFDSveCfq+iU
	A1TwcOIIArL8YwJdMh1bPX9pIykLt/VPoZjbgRY8Vvgjt47mvAtXLQmN050AbjHfibPAsx
	ZR/IFYijSgZl+lY4rhFyrusppqWZlKs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-pyBgG96wPI-qIzMbH9ytMg-1; Mon, 20 May 2024 13:27:26 -0400
X-MC-Unique: pyBgG96wPI-qIzMbH9ytMg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2e2035036f5so110750061fa.0
        for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 10:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716226045; x=1716830845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CsnJXGBZcLyYjfrlAMv2FyBTh8bc+Mt3a3EbW5Rnks=;
        b=uvIY9lzQ0BwqPvZRWcT9oreKbJeznfcxi3ATG9u8uMi4LNUPMFE/H6EwKYdaHSotte
         GblGFR5L23GkrdvDQzF06gm6Y5viWkq+zaFYzvr1ZB4hXZo1SwVHipiVxUJ5+ySb0h+/
         kcrZmgA2Q9qnXC4HlNiCbQJZs1YW0K237iV81tlDkkMKdh0hkAsnzd6BtkoLXuimWwKg
         lbC01gINQUbjLrxT5847bHiKAyBmNgMZJxSBc7dbVfdm0b+IjNHn1aCxHm/pQ+p/Bdjj
         iYLDyfsbp854oZvF3JdWy5EOyHZYVhpa7h7qUx5nP077bo2SeF3vExtP7Hn0Yx3BH5O/
         KNMg==
X-Forwarded-Encrypted: i=1; AJvYcCXq5BEZHdalzrB7pX2tsmPVFp1D7xl8XeVODjSTFnlHwi/+vsDES7vRpIzOiSJuV7jtruEJAHXkn07A1r5WElFDBurLXYYc0jfS
X-Gm-Message-State: AOJu0Yy1i2/jLqpmSWyPWuydjpdxh7BetKz+x95z2knBeAOU5fzwm3oH
	gCz08geKqyIq4FSG0L67bxRLRdlM8sc3KKDxgUuj4ZuPj5SVv09MiDCnLKlSCuQE1q/teqEKB3A
	vbXgg2f6kr3CVleUHxwvzOdfCXea8nvGzZGR2afm5f5oLjUdxfXzOOtYB3w==
X-Received: by 2002:a2e:be9f:0:b0:2e3:ba0e:de12 with SMTP id 38308e7fff4ca-2e51ff5cf48mr319538851fa.22.1716226045285;
        Mon, 20 May 2024 10:27:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbLE5+nNhphlxlGh18a3Zy/HbW451IH7B3zyMvPHBImYdCotrNMydqRvyk8NUf6/7klPUZ8Q==
X-Received: by 2002:a2e:be9f:0:b0:2e3:ba0e:de12 with SMTP id 38308e7fff4ca-2e51ff5cf48mr319538611fa.22.1716226044936;
        Mon, 20 May 2024 10:27:24 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42009eda143sm363816305e9.14.2024.05.20.10.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 10:27:24 -0700 (PDT)
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
Subject: [RFC PATCH 08/11] rust: add devres abstraction
Date: Mon, 20 May 2024 19:25:45 +0200
Message-ID: <20240520172554.182094-9-dakr@redhat.com>
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

Add a Rust abstraction for the kernel's devres (device resource
management) implementation.

The Devres type acts as a container to manage the lifetime and
accessibility of device bound resources. Therefore it registers a
devres callback and revokes access to the resource on invocation.

Users of the Devres abstraction can simply free the corresponding
resources in their Drop implementation, which is invoked when either the
Devres instance goes out of scope or the devres callback leads to the
resource being revoked, which implies a call to drop_in_place().

Co-developed-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/helpers.c        |   5 ++
 rust/kernel/devres.rs | 151 ++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs    |   1 +
 3 files changed, 157 insertions(+)
 create mode 100644 rust/kernel/devres.rs

diff --git a/rust/helpers.c b/rust/helpers.c
index 1d3e800140fc..34061eca05a0 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -173,6 +173,11 @@ void rust_helper_rcu_read_unlock(void)
 EXPORT_SYMBOL_GPL(rust_helper_rcu_read_unlock);
 /* end rcu */
 
+int rust_helper_devm_add_action(struct device *dev, void (*action)(void *), void *data)
+{
+	return devm_add_action(dev, action, data);
+}
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
new file mode 100644
index 000000000000..bf7bd304cd9b
--- /dev/null
+++ b/rust/kernel/devres.rs
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Devres abstraction
+//!
+//! [`Devres`] represents an abstraction for the kernel devres (device resource management)
+//! implementation.
+
+use crate::{
+    alloc::Flags,
+    bindings,
+    device::Device,
+    error::{Error, Result},
+    prelude::*,
+    revocable::Revocable,
+    types::ARef,
+};
+
+use core::ffi::c_void;
+use core::ops::Deref;
+
+#[pin_data]
+struct DevresInner<T> {
+    dev: ARef<Device>,
+    #[pin]
+    data: Revocable<T>,
+}
+
+/// This abstraction is meant to be used by subsystems to containerize [`Device`] bound resources to
+/// manage their lifetime.
+///
+/// [`Device`] bound resources should be freed when either the resource goes out of scope or the
+/// [`Device`] is unbound respectively, depending on what happens first.
+///
+/// To achieve that [`Devres`] registers a devres callback on creation, which is called once the
+/// [`Device`] is unbound, revoking access to the encapsulated resource (see also [`Revocable`]).
+///
+/// After the [`Devres`] has been unbound it is not possible to access the encapsulated resource
+/// anymore.
+///
+/// [`Devres`] users should make sure to simply free the corresponding backing resource in `T`'s
+/// [`Drop`] implementation.
+///
+/// # Example
+///
+/// ```
+/// use kernel::devres::Devres;
+///
+/// // See also [`pci::Bar`] for a real example.
+/// struct IoRemap(IoMem);
+///
+/// impl IoRemap {
+///     fn new(usize paddr, usize len) -> Result<Self>{
+///         // assert success
+///         let addr = unsafe { bindings::ioremap(paddr as _); };
+///         let iomem = IoMem::new(addr, len)?;
+///
+///         Ok(IoRemap(iomem))
+///     }
+/// }
+///
+/// impl Drop for IoRemap {
+///     fn drop(&mut self) {
+///         unsafe { bindings::iounmap(self.0.ioptr as _); };
+///     }
+/// }
+///
+/// impl Deref for IoRemap {
+///    type Target = IoMem;
+///
+///    fn deref(&self) -> &Self::Target {
+///        &self.0
+///    }
+/// }
+///
+/// let devres = Devres::new(dev, IoRemap::new(0xBAAAAAAD, 0x4)?, GFP_KERNEL)?;
+///
+/// let res = devres.try_access().ok_or(ENXIO)?;
+/// res.writel(0xBAD);
+/// ```
+///
+pub struct Devres<T> {
+    inner: Pin<Box<DevresInner<T>>>,
+    callback: unsafe extern "C" fn(*mut c_void),
+}
+
+impl<T> DevresInner<T> {
+    fn as_ptr(&self) -> *const DevresInner<T> {
+        self as *const DevresInner<T>
+    }
+
+    fn as_cptr(&self) -> *mut c_void {
+        self.as_ptr() as *mut c_void
+    }
+}
+
+unsafe extern "C" fn devres_callback<T>(inner: *mut c_void) {
+    let inner = inner as *const DevresInner<T>;
+    let inner = unsafe { &*inner };
+
+    inner.data.revoke();
+}
+
+impl<T> Devres<T> {
+    /// Creates a new [`Devres`] instance of the give data.
+    pub fn new(dev: ARef<Device>, data: T, flags: Flags) -> Result<Self> {
+        let callback = devres_callback::<T>;
+
+        let inner = Box::pin_init(
+            pin_init!( DevresInner {
+                dev: dev,
+                data <- Revocable::new(data),
+            }),
+            flags,
+        )?;
+
+        let ret = unsafe {
+            bindings::devm_add_action(inner.dev.as_raw(), Some(callback), inner.as_cptr())
+        };
+
+        if ret != 0 {
+            return Err(Error::from_errno(ret));
+        }
+
+        // We have to store the exact callback function pointer used with
+        // `bindings::devm_add_action` for `bindings::devm_remove_action`. There compiler might put
+        // multiple definitions of `devres_callback<T>` for the same `T` in both the kernel itself
+        // and modules. Hence, we might see different pointer values depending on whether we look
+        // at `devres_callback<T>`'s address from `Devres::new` or `Devres::drop`.
+        Ok(Devres { inner, callback })
+    }
+}
+
+impl<T> Deref for Devres<T> {
+    type Target = Revocable<T>;
+
+    fn deref(&self) -> &Self::Target {
+        &self.inner.data
+    }
+}
+
+impl<T> Drop for Devres<T> {
+    fn drop(&mut self) {
+        unsafe {
+            bindings::devm_remove_action(
+                self.inner.dev.as_raw(),
+                Some(self.callback),
+                self.inner.as_cptr(),
+            )
+        }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index d7d415429517..11645060b444 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -30,6 +30,7 @@
 pub mod alloc;
 mod build_assert;
 pub mod device;
+pub mod devres;
 pub mod driver;
 pub mod error;
 pub mod init;
-- 
2.45.1


