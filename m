Return-Path: <linux-pci+bounces-30559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90351AE71CA
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 23:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59307189FE7D
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 21:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1A625B30E;
	Tue, 24 Jun 2025 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKcdUGuS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E433E25B30D;
	Tue, 24 Jun 2025 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750802186; cv=none; b=bEb55GM+Um+jDTP2vBBQv1SVpD9V9xsy+gbd1Kkx9XuERCOk8fZzWdxVKwxD1iEsH1/haZHmQ4WrEQTX1dZoLUkoOAwSZDxfRb1n1UP7CZ6CeI+BGiEDEqmJ6MRR0ek9Ow/QXzASKHaSHLiBYEsPwHMOEmITCMon/2WYApZIvts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750802186; c=relaxed/simple;
	bh=YW/ds6pprKKQoy3LKVLjqadOwFxWlgr4J1KG6YTdzrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fv2iNRZce9ZI7HyCXkCP9BLVdw/TF+t+PD9G1jZUGll9gU0kPDvGr5Qa9kY61TTxiVQjVvqFe99xgOXyZ0o1YwFm6Umy65miM05kKDDYVUXuwLcqJWjKLBbKyo8ihm8un8OQIzadEu2TmQY953dhUI55HHHN6DqFkAm791MzRTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKcdUGuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EEEC4CEE3;
	Tue, 24 Jun 2025 21:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750802185;
	bh=YW/ds6pprKKQoy3LKVLjqadOwFxWlgr4J1KG6YTdzrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UKcdUGuSMF5k9b0dDwYIXsT6x4C30Gad32hUYQh9PartgGZtbWG6Id2KBkxQxieDB
	 ZYW5xVr51JWs3xs1bnkik5K56+IGVmDXOluAUbJNg32XoLUbufCVojGxe2eCZQV0ZB
	 VX2HAfRPSfKmCVqtga4JrcZ4dTArSnRdQTDNBGQoFTGNI9p6/+g8AceQ0wF6DopVyQ
	 QZzxBiYXWWU+pkUVOp5dcnUXJ+NTd4iAKElMSoWjZSaPjILJ+MIFA3ZwmSvOfxFm00
	 9dCuCAQzDA3Ec4VSeBuKVhuPDm+3OsShpFl7GNjXVI8jVpP+2nOh3/5dadH92aTztG
	 Nq1oUy+gKlWOA==
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
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 4/4] rust: devres: implement register_release()
Date: Tue, 24 Jun 2025 23:54:02 +0200
Message-ID: <20250624215600.221167-5-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624215600.221167-1-dakr@kernel.org>
References: <20250624215600.221167-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

register_release() is useful when a device resource has associated data,
but does not require the capability of accessing it or manually releasing
it.

If we would want to be able to access the device resource and release the
device resource manually before the device is unbound, but still keep
access to the associated data, we could implement it as follows.

	struct Registration<T> {
	   inner: Devres<RegistrationInner>,
	   data: T,
	}

However, if we never need to access the resource or release it manually,
register_release() is great optimization for the above, since it does not
require the synchronization of the Devres type.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/devres.rs | 90 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index eeffdc8115aa..ff33e835c44f 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -16,6 +16,7 @@
     sync::{rcu, Completion},
     types::{ARef, ForeignOwnable, ScopeGuard, Opaque},
 };
+use core::ops::Deref;
 
 use pin_init::Wrapper;
 
@@ -347,3 +348,92 @@ pub fn register<T, E>(dev: &Device<Bound>, data: impl PinInit<T, E>, flags: Flag
 
     register_foreign(dev, data)
 }
+
+/// [`Devres`]-releaseable resource.
+///
+/// Register an object implementing this trait with [`register_release`]. Its `release`
+/// function will be called once the device is being unbound.
+pub trait Release {
+    /// Called once the [`Device`] given to [`register_release`] is unbound.
+    fn release(&self);
+}
+
+impl<T: Release> Release for crate::sync::ArcBorrow<'_, T> {
+    fn release(&self) {
+        self.deref().release();
+    }
+}
+
+impl<T: Release> Release for Pin<&'_ T> {
+    fn release(&self) {
+        self.deref().release();
+    }
+}
+
+impl<T: Release> Release for &'_ T {
+    fn release(&self) {
+        (*self).release();
+    }
+}
+
+/// Consume the `data`, [`Release::release`] and [`Drop::drop`] `data` once `dev` is unbound.
+///
+/// # Examples
+///
+/// ```no_run
+/// use kernel::{device::{Bound, Device}, devres, devres::Release, sync::Arc};
+///
+/// /// Registration of e.g. a class device, IRQ, etc.
+/// struct Registration<T> {
+///     data: T,
+/// }
+///
+/// impl<T> Registration<T> {
+///     fn new(data: T) -> Result<Arc<Self>> {
+///         // register
+///
+///         Ok(Arc::new(Self { data }, GFP_KERNEL)?)
+///     }
+/// }
+///
+/// impl<T> Release for Registration<T> {
+///     fn release(&self) {
+///        // unregister
+///     }
+/// }
+///
+/// fn from_bound_context(dev: &Device<Bound>) -> Result {
+///     let reg = Registration::new(0x42)?;
+///
+///     devres::register_release(dev, reg.clone())
+/// }
+/// ```
+pub fn register_release<P>(dev: &Device<Bound>, data: P) -> Result
+where
+    P: ForeignOwnable + 'static,
+    for<'a> P::Borrowed<'a>: Release,
+{
+    let ptr = data.into_foreign();
+
+    #[allow(clippy::missing_safety_doc)]
+    unsafe extern "C" fn callback<P>(ptr: *mut kernel::ffi::c_void)
+    where
+        P: ForeignOwnable,
+        for<'a> P::Borrowed<'a>: Release,
+    {
+        // SAFETY: `ptr` is the pointer to the `ForeignOwnable` leaked above and hence valid.
+        unsafe { P::borrow(ptr.cast()) }.release();
+
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
-- 
2.49.0


