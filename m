Return-Path: <linux-pci+bounces-30822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD7AAEA79D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE6D177464
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4012EF673;
	Thu, 26 Jun 2025 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MT7JGqZt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFB127510C;
	Thu, 26 Jun 2025 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968070; cv=none; b=a+nanqtzWzAZoUz6msEZWoHaZ/pU25PbRLALbHRx2CS+263/UZzmLUnNL7oBIrMlytj36+AjIjvSwHcQwOsNOe/HZIfkgqbuxtkrxopMOXZe0yXPjm/YeC99Q1YpJNbcmqN1WrgBPI340ZW86gc6lLbfwM3004EABGQ+3SbbGeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968070; c=relaxed/simple;
	bh=1lSsD+NjV1sjQecH58pl+Un6d0nvd5+fJTKF8ToIguM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcD1a4QxUmOgH7qLVZebk17gyaQU4V/KFP3UA4MCcvi6V97B00MLY9iptAYbIFnbz8sWesElgG9jC5OdsFSmr3hkhRjGwUzHlNOS1B/RSxAY3l/iMg2BKFj/hR3vZDvr+9H6JmgQdOcM5Pt9xijZ2xCR6bZm/NXbOcGZgIWaNvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MT7JGqZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA88C4CEF0;
	Thu, 26 Jun 2025 20:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750968070;
	bh=1lSsD+NjV1sjQecH58pl+Un6d0nvd5+fJTKF8ToIguM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MT7JGqZtsge9NEJUY9y9EGXRgkdmosnlfkPMBvfeTIZyfIkY59GB/L1dSLbPkgA9n
	 OZ65w7a468j+h5zJd9+NLY+oOglpCTLm8LKQkN5lLuFvFiHUQp1Medrlo135oKNZrF
	 WnVxD7BjvZ7kbj0elS7CPh5vO58+eFA2EheKeoHhzfVsZh8+lveY8YhZnxxvmHdg7U
	 szQdNnN0T9Qcc+SINRvi6R1gr4e/6OqPAXY9kQS8JPuxxZ3G9lZbOfTnrdJO4IKjCF
	 c2RrxgJIxSE4+ImIn9JO4FoF6IU63uvNY0ksfrFPkiZLuE3ekbqCsn/kpV2bC1ThtJ
	 2POx0MHcpuORA==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Airlie <airlied@redhat.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v4 2/5] rust: devres: replace Devres::new_foreign_owned()
Date: Thu, 26 Jun 2025 22:00:40 +0200
Message-ID: <20250626200054.243480-3-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626200054.243480-1-dakr@kernel.org>
References: <20250626200054.243480-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace Devres::new_foreign_owned() with devres::register().

The current implementation of Devres::new_foreign_owned() creates a full
Devres container instance, including the internal Revocable and
completion.

However, none of that is necessary for the intended use of giving full
ownership of an object to devres and getting it dropped once the given
device is unbound.

Hence, implement devres::register(), which is limited to consume the
given data, wrap it in a KBox and drop the KBox once the given device is
unbound, without any other synchronization.

Cc: Dave Airlie <airlied@redhat.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/device.c     |  7 ++++
 rust/kernel/cpufreq.rs    | 11 +++---
 rust/kernel/devres.rs     | 73 +++++++++++++++++++++++++++++++++------
 rust/kernel/drm/driver.rs | 14 ++++----
 4 files changed, 85 insertions(+), 20 deletions(-)

diff --git a/rust/helpers/device.c b/rust/helpers/device.c
index b2135c6686b0..502fef7e9ae8 100644
--- a/rust/helpers/device.c
+++ b/rust/helpers/device.c
@@ -8,3 +8,10 @@ int rust_helper_devm_add_action(struct device *dev,
 {
 	return devm_add_action(dev, action, data);
 }
+
+int rust_helper_devm_add_action_or_reset(struct device *dev,
+					 void (*action)(void *),
+					 void *data)
+{
+	return devm_add_action_or_reset(dev, action, data);
+}
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 11b03e9d7e89..dd84e2b4d7ae 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -13,7 +13,7 @@
     cpu::CpuId,
     cpumask,
     device::{Bound, Device},
-    devres::Devres,
+    devres,
     error::{code::*, from_err_ptr, from_result, to_result, Result, VTABLE_DEFAULT_ERROR},
     ffi::{c_char, c_ulong},
     prelude::*,
@@ -1046,10 +1046,13 @@ pub fn new() -> Result<Self> {
 
     /// Same as [`Registration::new`], but does not return a [`Registration`] instance.
     ///
-    /// Instead the [`Registration`] is owned by [`Devres`] and will be revoked / dropped, once the
+    /// Instead the [`Registration`] is owned by [`devres::register`] and will be dropped, once the
     /// device is detached.
-    pub fn new_foreign_owned(dev: &Device<Bound>) -> Result {
-        Devres::new_foreign_owned(dev, Self::new()?, GFP_KERNEL)
+    pub fn new_foreign_owned(dev: &Device<Bound>) -> Result
+    where
+        T: 'static,
+    {
+        devres::register(dev, Self::new()?, GFP_KERNEL)
     }
 }
 
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index fd8b75aa03bc..64458ca3d69f 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -9,12 +9,12 @@
     alloc::Flags,
     bindings,
     device::{Bound, Device},
-    error::{Error, Result},
+    error::{to_result, Error, Result},
     ffi::c_void,
     prelude::*,
     revocable::{Revocable, RevocableGuard},
     sync::{rcu, Arc, Completion},
-    types::ARef,
+    types::{ARef, ForeignOwnable},
 };
 
 #[pin_data]
@@ -184,14 +184,6 @@ pub fn new(dev: &Device<Bound>, data: T, flags: Flags) -> Result<Self> {
         Ok(Devres(inner))
     }
 
-    /// Same as [`Devres::new`], but does not return a `Devres` instance. Instead the given `data`
-    /// is owned by devres and will be revoked / dropped, once the device is detached.
-    pub fn new_foreign_owned(dev: &Device<Bound>, data: T, flags: Flags) -> Result {
-        let _ = DevresInner::new(dev, data, flags)?;
-
-        Ok(())
-    }
-
     /// Obtain `&'a T`, bypassing the [`Revocable`].
     ///
     /// This method allows to directly obtain a `&'a T`, bypassing the [`Revocable`], by presenting
@@ -261,3 +253,64 @@ fn drop(&mut self) {
         }
     }
 }
+
+/// Consume `data` and [`Drop::drop`] `data` once `dev` is unbound.
+fn register_foreign<P>(dev: &Device<Bound>, data: P) -> Result
+where
+    P: ForeignOwnable + Send + 'static,
+{
+    let ptr = data.into_foreign();
+
+    #[allow(clippy::missing_safety_doc)]
+    unsafe extern "C" fn callback<P: ForeignOwnable>(ptr: *mut kernel::ffi::c_void) {
+        // SAFETY: `ptr` is the pointer to the `ForeignOwnable` leaked above and hence valid.
+        drop(unsafe { P::from_foreign(ptr.cast()) });
+    }
+
+    // SAFETY:
+    // - `dev.as_raw()` is a pointer to a valid and bound device.
+    // - `ptr` is a valid pointer the `ForeignOwnable` devres takes ownership of.
+    to_result(unsafe {
+        // `devm_add_action_or_reset()` also calls `callback` on failure, such that the
+        // `ForeignOwnable` is released eventually.
+        bindings::devm_add_action_or_reset(dev.as_raw(), Some(callback::<P>), ptr.cast())
+    })
+}
+
+/// Encapsulate `data` in a [`KBox`] and [`Drop::drop`] `data` once `dev` is unbound.
+///
+/// # Examples
+///
+/// ```no_run
+/// use kernel::{device::{Bound, Device}, devres};
+///
+/// /// Registration of e.g. a class device, IRQ, etc.
+/// struct Registration;
+///
+/// impl Registration {
+///     fn new() -> Self {
+///         // register
+///
+///         Self
+///     }
+/// }
+///
+/// impl Drop for Registration {
+///     fn drop(&mut self) {
+///        // unregister
+///     }
+/// }
+///
+/// fn from_bound_context(dev: &Device<Bound>) -> Result {
+///     devres::register(dev, Registration::new(), GFP_KERNEL)
+/// }
+/// ```
+pub fn register<T, E>(dev: &Device<Bound>, data: impl PinInit<T, E>, flags: Flags) -> Result
+where
+    T: Send + 'static,
+    Error: From<E>,
+{
+    let data = KBox::pin_init(data, flags)?;
+
+    register_foreign(dev, data)
+}
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index acb638086131..f63addaf7235 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -5,9 +5,7 @@
 //! C header: [`include/linux/drm/drm_drv.h`](srctree/include/linux/drm/drm_drv.h)
 
 use crate::{
-    bindings, device,
-    devres::Devres,
-    drm,
+    bindings, device, devres, drm,
     error::{to_result, Result},
     prelude::*,
     str::CStr,
@@ -130,18 +128,22 @@ fn new(drm: &drm::Device<T>, flags: usize) -> Result<Self> {
     }
 
     /// Same as [`Registration::new`}, but transfers ownership of the [`Registration`] to
-    /// [`Devres`].
+    /// [`devres::register`].
     pub fn new_foreign_owned(
         drm: &drm::Device<T>,
         dev: &device::Device<device::Bound>,
         flags: usize,
-    ) -> Result {
+    ) -> Result
+    where
+        T: 'static,
+    {
         if drm.as_ref().as_raw() != dev.as_raw() {
             return Err(EINVAL);
         }
 
         let reg = Registration::<T>::new(drm, flags)?;
-        Devres::new_foreign_owned(dev, reg, GFP_KERNEL)
+
+        devres::register(dev, reg, GFP_KERNEL)
     }
 
     /// Returns a reference to the `Device` instance for this registration.
-- 
2.49.0


