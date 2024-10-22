Return-Path: <linux-pci+bounces-15050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDAC9AB87B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 23:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8C22841CE
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 21:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6D51CDA09;
	Tue, 22 Oct 2024 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bmvl3wC3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA31CDA04;
	Tue, 22 Oct 2024 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632768; cv=none; b=noK2osZ86lCUfHZhR+i5hmNNcKyYY1spSh2HM+6i1D8a2wvPy30kVKEY7+X20d8hRTXPRWlmjimsDYxCKan843t965rr+xjrArmd3+APBartw7PmujqRGHTtpXJVLUkYMo92F0fSUAO6u1mWOhrt96DTeVajzZrW7PFLD5gTLCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632768; c=relaxed/simple;
	bh=vBW0av7EC8pdFPFs1anS+QtqcIgaudmaxuc13fjq5aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oS/5j5LzO21Gsqr7+TPrvKml1neyR0RJ84HzrhcKl85yR9itmIK+YlbuEnqq73quQ3dRZ82lLdrnYVK4BSgk1zGL4ILEV8F2Xb+oz71EWtvd56Al76BPGE+zkct5xUPMjsPp3MuW3Xvzw7YNCmwpEijkOAwHSktixmc8LQYJieQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bmvl3wC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21A8C4CEE3;
	Tue, 22 Oct 2024 21:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729632767;
	bh=vBW0av7EC8pdFPFs1anS+QtqcIgaudmaxuc13fjq5aA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bmvl3wC3kXB+AIT+O17CFYh98qBKjfNFrAqXvAAif3sYk0IS1iKIGkIPDRizmHA3T
	 6FioJrJp0b1rBf+pq5B6/xsNnxLCBL7KuNjLVvEue6wQ0MjhtBc+lQQSus8/HnHBT6
	 PjsZk1UsjOcL0mlilO1sTP9o/i685DJJcvRaj0Uc7wUG0vKJiOaHVrEkvzPShaVBcq
	 KrslVJvgIJk0H9g6mAinLSScn8UjpicWvwmr8lZIIwDYhYvH0IGwzqoPL/jGvIDV6l
	 v6tCiVemtfxOWkQYlBOFX0weOIKGtY06zfmxRRYO0q0kChqqkXgv6NmvmvGcvgqCPG
	 xtJGhe4UzxwsQ==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	tmgross@umich.edu,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	lina@asahilina.net,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	robh@kernel.org,
	daniel.almeida@collabora.com,
	saravanak@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 03/16] rust: pass module name to `Module::init`
Date: Tue, 22 Oct 2024 23:31:40 +0200
Message-ID: <20241022213221.2383-4-dakr@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241022213221.2383-1-dakr@kernel.org>
References: <20241022213221.2383-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a subsequent patch we introduce the `Registration` abstraction used
to register driver structures. Some subsystems require the module name on
driver registration (e.g. PCI in __pci_register_driver()), hence pass
the module name to `Module::init`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/block/rnull.rs       |  2 +-
 rust/kernel/lib.rs           | 14 ++++++++++----
 rust/kernel/net/phy.rs       |  2 +-
 rust/macros/module.rs        |  6 ++++--
 samples/rust/rust_minimal.rs |  2 +-
 samples/rust/rust_print.rs   |  2 +-
 6 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
index 5de7223beb4d..0e0e9ed7851e 100644
--- a/drivers/block/rnull.rs
+++ b/drivers/block/rnull.rs
@@ -36,7 +36,7 @@ struct NullBlkModule {
 }
 
 impl kernel::Module for NullBlkModule {
-    fn init(_module: &'static ThisModule) -> Result<Self> {
+    fn init(_name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
         pr_info!("Rust null_blk loaded\n");
         let tagset = Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
 
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 4fdb0d91f2ad..83f76dc7bad2 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -80,7 +80,7 @@ pub trait Module: Sized + Sync + Send {
     /// should do.
     ///
     /// Equivalent to the `module_init` macro in the C API.
-    fn init(module: &'static ThisModule) -> error::Result<Self>;
+    fn init(name: &'static str::CStr, module: &'static ThisModule) -> error::Result<Self>;
 }
 
 /// A module that is pinned and initialised in-place.
@@ -88,13 +88,19 @@ pub trait InPlaceModule: Sync + Send {
     /// Creates an initialiser for the module.
     ///
     /// It is called when the module is loaded.
-    fn init(module: &'static ThisModule) -> impl init::PinInit<Self, error::Error>;
+    fn init(
+        name: &'static str::CStr,
+        module: &'static ThisModule,
+    ) -> impl init::PinInit<Self, error::Error>;
 }
 
 impl<T: Module> InPlaceModule for T {
-    fn init(module: &'static ThisModule) -> impl init::PinInit<Self, error::Error> {
+    fn init(
+        name: &'static str::CStr,
+        module: &'static ThisModule,
+    ) -> impl init::PinInit<Self, error::Error> {
         let initer = move |slot: *mut Self| {
-            let m = <Self as Module>::init(module)?;
+            let m = <Self as Module>::init(name, module)?;
 
             // SAFETY: `slot` is valid for write per the contract with `pin_init_from_closure`.
             unsafe { slot.write(m) };
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 910ce867480a..26631b0e127a 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -899,7 +899,7 @@ struct Module {
                 [$($crate::net::phy::create_phy_driver::<$driver>()),+];
 
             impl $crate::Module for Module {
-                fn init(module: &'static ThisModule) -> Result<Self> {
+                fn init(_name: &'static CStr, module: &'static ThisModule) -> Result<Self> {
                     // SAFETY: The anonymous constant guarantees that nobody else can access
                     // the `DRIVERS` static. The array is used only in the C side.
                     let drivers = unsafe { &mut DRIVERS };
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index a03266a78cfb..3292714ff82e 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -333,8 +333,10 @@ mod __module_init {{
                     ///
                     /// This function must only be called once.
                     unsafe fn __init() -> core::ffi::c_int {{
-                        let initer =
-                            <{type_} as kernel::InPlaceModule>::init(&super::super::THIS_MODULE);
+                        let initer = <{type_} as kernel::InPlaceModule>::init(
+                            kernel::c_str!(\"{name}\"),
+                            &super::super::THIS_MODULE
+                        );
                         // SAFETY: No data race, since `__MOD` can only be accessed by this module
                         // and there only `__init` and `__exit` access it. These functions are only
                         // called once and `__exit` cannot be called before or during `__init`.
diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
index 4aaf117bf8e3..1577dc34e563 100644
--- a/samples/rust/rust_minimal.rs
+++ b/samples/rust/rust_minimal.rs
@@ -17,7 +17,7 @@ struct RustMinimal {
 }
 
 impl kernel::Module for RustMinimal {
-    fn init(_module: &'static ThisModule) -> Result<Self> {
+    fn init(_name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
         pr_info!("Rust minimal sample (init)\n");
         pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
 
diff --git a/samples/rust/rust_print.rs b/samples/rust/rust_print.rs
index ba1606bdbd75..73763ea2dc09 100644
--- a/samples/rust/rust_print.rs
+++ b/samples/rust/rust_print.rs
@@ -41,7 +41,7 @@ fn arc_print() -> Result {
 }
 
 impl kernel::Module for RustPrint {
-    fn init(_module: &'static ThisModule) -> Result<Self> {
+    fn init(_name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
         pr_info!("Rust printing macros sample (init)\n");
 
         pr_emerg!("Emergency message (level 0) without args\n");
-- 
2.46.2


