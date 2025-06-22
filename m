Return-Path: <linux-pci+bounces-30319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 482B6AE30DB
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 18:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3880716C122
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 16:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728A2201033;
	Sun, 22 Jun 2025 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQTGAJX5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E5E1F5423;
	Sun, 22 Jun 2025 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750610499; cv=none; b=qg4nz11V77/kHG0e4kQm4+M+TRoRk2GPW9/7PfRevrHQa/J+IeEqsyweUghNB91uvSw5EkXPJn5EeKXZd15GtbM/en0k21MiJeBu9lPhsqzEZUTpOjKA1UJTahMRDaGbaU8TnQhBzu7URpA0Zjh8zi7OR2N2IxPnz9UyYbluJ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750610499; c=relaxed/simple;
	bh=YeMl5gWrowwdhB4vjOFO00ruw6lOsJ7HM1stb5uHsKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyYDiriZRl8ACkNK6py8ll93QdIKoYUTTla/p+jRjWKhHW6uvGCLsSCJquEmUmRxD7DTX6Ca+QT2qF3qMXU0cZFIAN6zR3jCzLdegi1p5ucp8y/vhIEhLqw0IEEHMoLbf5k2vUN/1Htw3BMn8KHT28bibzjFaCySny2MVr2t0SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQTGAJX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A6CC4CEF0;
	Sun, 22 Jun 2025 16:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750610498;
	bh=YeMl5gWrowwdhB4vjOFO00ruw6lOsJ7HM1stb5uHsKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TQTGAJX51ezU2zY2Qj80DiA+W8Q7M4kzfv6oGbedC2oF/PVo+NhKsyr/+oIDwfBEj
	 TaaPPtTheYE9ynzm+UPq9d0mzgTvk1KjrDqOtyVoKypLiaiclpWN4ucrMdmvJaUjgK
	 XRE0vEWJevAseB4suVSHxaWYFce7/NSh6UXbeK82rKQ3fO/rocVOrIluP+ic+JReKa
	 wU/cxojOARs4QmaMC00SmD69x2lnNqf/2JI423gOgrjO211cJopZ4grJ/uwSeGPP8z
	 /V9FZKfT3CMRwbVD5KjC4mW5n1E+DERY0zqXM07MlY1KJRHzHHCy9W8HZonf9yll6Y
	 i37qDKnLJuXJg==
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
Subject: [PATCH v2 4/4] rust: devres: implement register_release()
Date: Sun, 22 Jun 2025 18:40:41 +0200
Message-ID: <20250622164050.20358-5-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250622164050.20358-1-dakr@kernel.org>
References: <20250622164050.20358-1-dakr@kernel.org>
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
 rust/kernel/devres.rs | 84 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 15a0a94e992b..4b61e94d34a0 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -16,6 +16,7 @@
     sync::{rcu, Completion},
     types::{ARef, ForeignOwnable, Opaque},
 };
+use core::ops::Deref;
 
 use pin_init::Wrapper;
 
@@ -345,3 +346,86 @@ pub fn register<T, E>(dev: &Device<Bound>, data: impl PinInit<T, E>, flags: Flag
 
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
+    P: ForeignOwnable,
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
+        let _ = unsafe { P::from_foreign(ptr.cast()) };
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


