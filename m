Return-Path: <linux-pci+bounces-30825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A453AEA7A7
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141F2561C90
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B0C2F0E53;
	Thu, 26 Jun 2025 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko6VVeNj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5912F0E4D;
	Thu, 26 Jun 2025 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968084; cv=none; b=T8QD6UDq2JCsJs7buvSvIQENv7/LQLleecFBe6YRqe7eaQBqErAaMUKOJsJRbsj1w8eIWDl9RzHBffZmiSHkgQgFd0CurcQ2bhhz0IHD/n8h1U90nHvie2kHtXZJq44pmZpmLwTFBFb383gdKcNpU3D2qTDxE+uXcwaJ009Yt6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968084; c=relaxed/simple;
	bh=4TQ9IPTgKMt3xedIjC4FAr1Kkj8BMJZaabqz8iQUEgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTvzWe1Cl3UuUxwmBiX5iR9C01onTBx9zk0usXx8DHtUR9gEhCZ6FtlrO5Ue8JORuorBNO1wg9t5Lg5j1rpW9r7vScvyd2AffX9CI+xbhsqbklskUOuOj7uYvS5fz2crXVGljrl7UQ5qMGQvZcM8IZCyBVZXzxNezJMnMmVn2HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ko6VVeNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4973C4CEEB;
	Thu, 26 Jun 2025 20:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750968083;
	bh=4TQ9IPTgKMt3xedIjC4FAr1Kkj8BMJZaabqz8iQUEgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ko6VVeNjjltedZWWEr9JHf3QkUmh01r1yUn9E3XF+Li18su0PKFM+PqTpgghPLqpz
	 CxhzeRJwLv3AEpk8nZKwLOl/rVw0YWvqrJ/sy9IUb/P2TfWuB0Rd+we08iX7EZQvCI
	 BNEjsZ+VSwIYdPK8K+ndN+CgdwCxsFeisHTm9AATI1svKMl+Bs1lw7Z5qNIlxZp17e
	 sLl/YrZRGw9mlhOzFAFFYqEosQrVr4BgP/RUYquAbeygkuoDxfcrK3RD4Dw3tQxeBS
	 swjl1S4UDvZx5w07eeF01ICNsr6qVfd1mQSmuflP3CChBlXIVFQnt/fybWZV2RvkdV
	 srfxv/LtrmdRA==
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
Subject: [PATCH v4 5/5] rust: devres: implement register_release()
Date: Thu, 26 Jun 2025 22:00:43 +0200
Message-ID: <20250626200054.243480-6-dakr@kernel.org>
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
 rust/kernel/devres.rs | 73 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 3ce8d6161778..92aca78874ff 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -353,3 +353,76 @@ pub fn register<T, E>(dev: &Device<Bound>, data: impl PinInit<T, E>, flags: Flag
 
     register_foreign(dev, data)
 }
+
+/// [`Devres`]-releaseable resource.
+///
+/// Register an object implementing this trait with [`register_release`]. Its `release`
+/// function will be called once the device is being unbound.
+pub trait Release {
+    /// The [`ForeignOwnable`] pointer type consumed by [`register_release`].
+    type Ptr: ForeignOwnable;
+
+    /// Called once the [`Device`] given to [`register_release`] is unbound.
+    fn release(this: Self::Ptr);
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
+/// struct Registration;
+///
+/// impl Registration {
+///     fn new() -> Result<Arc<Self>> {
+///         // register
+///
+///         Ok(Arc::new(Self, GFP_KERNEL)?)
+///     }
+/// }
+///
+/// impl Release for Registration {
+///     type Ptr = Arc<Self>;
+///
+///     fn release(this: Arc<Self>) {
+///        // unregister
+///     }
+/// }
+///
+/// fn from_bound_context(dev: &Device<Bound>) -> Result {
+///     let reg = Registration::new()?;
+///
+///     devres::register_release(dev, reg.clone())
+/// }
+/// ```
+pub fn register_release<P>(dev: &Device<Bound>, data: P) -> Result
+where
+    P: ForeignOwnable,
+    P::Target: Release<Ptr = P> + Send,
+{
+    let ptr = data.into_foreign();
+
+    #[allow(clippy::missing_safety_doc)]
+    unsafe extern "C" fn callback<P>(ptr: *mut kernel::ffi::c_void)
+    where
+        P: ForeignOwnable,
+        P::Target: Release<Ptr = P>,
+    {
+        // SAFETY: `ptr` is the pointer to the `ForeignOwnable` leaked above and hence valid.
+        let data = unsafe { P::from_foreign(ptr.cast()) };
+
+        P::Target::release(data);
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


