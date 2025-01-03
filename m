Return-Path: <linux-pci+bounces-19244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C4AA00C61
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 17:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C47516475E
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 16:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616921FC7EE;
	Fri,  3 Jan 2025 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbHKslwZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1631FC10C;
	Fri,  3 Jan 2025 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735922834; cv=none; b=hmeCr+aW8MjYmG2vJvQCpFPTkWdZjY/TYX2jZAGDFWw9LAK6v/0JlkNZuf3TkDguIS/mkOm86MouFmGvs7bsl0xKMuNyv+Ii1Dy59O7x0ge/LsO2PU5erDsWjMYNNYlzE1xkiDbZOnfnBDXQ2tx8PNAYMxqzzVW1vLhHC9JCJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735922834; c=relaxed/simple;
	bh=OUnzSPYLSoc//E88dncYu34255MsFamAkyC4TSeJnOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8kt2LHdzhfSEdiXzkP0lg4JPkzE8wgNTn+2v5JFS7zG10i3k8DcXZq5df1KzTP4PAKDiMtp/DKq62sX2lLLz8Lp5vwszV21EuZfDv+MoV49cmd5lfLAnM2ndd4w/Jgx6kO6B3krz7rkZ7CWJugZsIHleMv+oxFJVcGQMLuFLiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbHKslwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7D1C4CECE;
	Fri,  3 Jan 2025 16:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735922833;
	bh=OUnzSPYLSoc//E88dncYu34255MsFamAkyC4TSeJnOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lbHKslwZsO3Yhwrdd9QB6XqQPYXeT7I4jNNqoYmM1YKxVhxS9nx+Er3CKFcnuiTb+
	 ah5gmWj9MvxhFeFsKFFoRpWHnCNiM0fZDnfwoyB2DUHaVlXlndk9J/AbFoH64ym3p9
	 g9w6XJ1CU8eYjDBN5qNu4VLIViQbbl4DAJbk1IyUYmLB4O2wHRwVWz0IK1dYXsvAKN
	 sM3pDihgDFNiiGoADiXeHDwwF3mOOh5pAJQ1k5bB0Gsw8Bg2Jp/BPZ4RHybbkhO5om
	 qQ6iW5Cepc6yfsTQ5IDgRJmQIOAOcuOGw2FgWw91Gb+jqoWGnqreVQ1ZfZIbsfT4wU
	 3IqWUegEatF1w==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	bhelgaas@google.com,
	fujita.tomonori@gmail.com
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 3/3] rust: driver: address soundness issue in `RegistrationOps`
Date: Fri,  3 Jan 2025 17:46:03 +0100
Message-ID: <20250103164655.96590-4-dakr@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103164655.96590-1-dakr@kernel.org>
References: <20250103164655.96590-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `RegistrationOps` trait holds some obligations to the caller and
implementers. While being documented, the trait and the corresponding
functions haven't been marked as unsafe.

Hence, markt the trait and functions unsafe and add the corresponding
safety comments.

This patch does not include any fuctional changes.

Reported-by: Gary Guo <gary@garyguo.net>
Closes: https://lore.kernel.org/rust-for-linux/20241224195821.3b43302b.gary@garyguo.net/
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/driver.rs   | 25 ++++++++++++++++++++-----
 rust/kernel/pci.rs      |  8 +++++---
 rust/kernel/platform.rs |  8 +++++---
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index c630e65098ed..2a16d5e64e6c 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -17,23 +17,35 @@
 /// For instance, the PCI subsystem would set `RegType` to `bindings::pci_driver` and call
 /// `bindings::__pci_register_driver` from `RegistrationOps::register` and
 /// `bindings::pci_unregister_driver` from `RegistrationOps::unregister`.
-pub trait RegistrationOps {
+///
+/// # Safety
+///
+/// A call to [`RegistrationOps::unregister`] for a given instance of `RegType` is only valid if a
+/// preceding call to [`RegistrationOps::register`] has been successful.
+pub unsafe trait RegistrationOps {
     /// The type that holds information about the registration. This is typically a struct defined
     /// by the C portion of the kernel.
     type RegType: Default;
 
     /// Registers a driver.
     ///
+    /// # Safety
+    ///
     /// On success, `reg` must remain pinned and valid until the matching call to
     /// [`RegistrationOps::unregister`].
-    fn register(
+    unsafe fn register(
         reg: &Opaque<Self::RegType>,
         name: &'static CStr,
         module: &'static ThisModule,
     ) -> Result;
 
     /// Unregisters a driver previously registered with [`RegistrationOps::register`].
-    fn unregister(reg: &Opaque<Self::RegType>);
+    ///
+    /// # Safety
+    ///
+    /// Must only be called after a preceding successful call to [`RegistrationOps::register`] for
+    /// the same `reg`.
+    unsafe fn unregister(reg: &Opaque<Self::RegType>);
 }
 
 /// A [`Registration`] is a generic type that represents the registration of some driver type (e.g.
@@ -68,7 +80,8 @@ pub fn new(name: &'static CStr, module: &'static ThisModule) -> impl PinInit<Sel
                 // just been initialised above, so it's also valid for read.
                 let drv = unsafe { &*(ptr as *const Opaque<T::RegType>) };
 
-                T::register(drv, name, module)
+                // SAFETY: `drv` is guaranteed to be pinned until `T::unregister`.
+                unsafe { T::register(drv, name, module) }
             }),
         })
     }
@@ -77,7 +90,9 @@ pub fn new(name: &'static CStr, module: &'static ThisModule) -> impl PinInit<Sel
 #[pinned_drop]
 impl<T: RegistrationOps> PinnedDrop for Registration<T> {
     fn drop(self: Pin<&mut Self>) {
-        T::unregister(&self.reg);
+        // SAFETY: The existence of `self` guarantees that `self.reg` has previously been
+        // successfully registered with `T::register`
+        unsafe { T::unregister(&self.reg) };
     }
 }
 
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index d5e7f0b15303..4c98b5b9aa1e 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -23,10 +23,12 @@
 /// An adapter for the registration of PCI drivers.
 pub struct Adapter<T: Driver>(T);
 
-impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+// SAFETY: A call to `unregister` for a given instance of `RegType` is guaranteed to be valid if
+// a preceding call to `register` has been successful.
+unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
     type RegType = bindings::pci_driver;
 
-    fn register(
+    unsafe fn register(
         pdrv: &Opaque<Self::RegType>,
         name: &'static CStr,
         module: &'static ThisModule,
@@ -45,7 +47,7 @@ fn register(
         })
     }
 
-    fn unregister(pdrv: &Opaque<Self::RegType>) {
+    unsafe fn unregister(pdrv: &Opaque<Self::RegType>) {
         // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
         unsafe { bindings::pci_unregister_driver(pdrv.get()) }
     }
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 03287794f9d0..50e6b0421813 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -19,10 +19,12 @@
 /// An adapter for the registration of platform drivers.
 pub struct Adapter<T: Driver>(T);
 
-impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+// SAFETY: A call to `unregister` for a given instance of `RegType` is guaranteed to be valid if
+// a preceding call to `register` has been successful.
+unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
     type RegType = bindings::platform_driver;
 
-    fn register(
+    unsafe fn register(
         pdrv: &Opaque<Self::RegType>,
         name: &'static CStr,
         module: &'static ThisModule,
@@ -44,7 +46,7 @@ fn register(
         to_result(unsafe { bindings::__platform_driver_register(pdrv.get(), module.0) })
     }
 
-    fn unregister(pdrv: &Opaque<Self::RegType>) {
+    unsafe fn unregister(pdrv: &Opaque<Self::RegType>) {
         // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
         unsafe { bindings::platform_driver_unregister(pdrv.get()) };
     }
-- 
2.47.1


