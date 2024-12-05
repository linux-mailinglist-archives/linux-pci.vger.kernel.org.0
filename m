Return-Path: <linux-pci+bounces-17770-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 063409E5831
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 15:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04EE31884212
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 14:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0E0218AC0;
	Thu,  5 Dec 2024 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGBaFtCo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A95A17579;
	Thu,  5 Dec 2024 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733408154; cv=none; b=SfCyAFi56zsYGJj8edbGzT1vAisVM1cpxc4mjQ8vWJXm/XC6ZslaUs6qZM4pZL1Uvh2Z8CuzcFI3oHvnpKIkEPFPjq8HGU1G5ZLSiPnqt2vws77uF2wbJ8znaoHmhJXyc333RsjsZXAeN/7fAe3l8/7iobDvVb6u0+ei9+hENH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733408154; c=relaxed/simple;
	bh=KzaLlrMOSYV96pirchpaX9zp5w3CHhhYNXDvSJp4QvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqCcmpqbrH5FGD3SM3pjR3YuQUrRq8TfaHefxMhl8ePuHoT4BQnEz3GjZ+8xvxYUEotNHXospZq4NJ5VpnvjLU5wb4PFMsgrE7288ZwzAxPrxJI4SULSTSQTH9hgSlHfmrXsIqO7dFrz9YsOV3JYW3U9z3eraKePOB0GQKqUBdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGBaFtCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D03DC4CEDC;
	Thu,  5 Dec 2024 14:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733408153;
	bh=KzaLlrMOSYV96pirchpaX9zp5w3CHhhYNXDvSJp4QvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IGBaFtCowUHZdIlxpTOCKXngVKHdfZBRRuPJaJmFyLMSPv6ziFnPg7v1pKpci/73F
	 +5tSuAup0lPU7CwUunY8LozDOOXIcvqRBsoUd09B1Sp5UDi5LPsxrpZZgjBYdDt8l9
	 5f3T7tqJOuNeLk4AASZ9tdfSXpZgwVKioaS6LTNCeGUuNkIbTysfOh+WK+YXBDAo2/
	 LYF1RCv67QACacIcR9moO0M5E4uObzBZHPtNXFUeCDzcqyfzH2IdO3FJtXbrPtEtpl
	 7HRHaQFASh/AfvqV7AJgz8nXGWNGw3I/I3ZFRyuaBWvyPCaDLQBx2DKX5wSqYW1zUz
	 lCWJUlIK4gnZw==
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
	saravanak@google.com,
	dirk.behme@de.bosch.com,
	j@jannau.net,
	fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v4 01/13] rust: pass module name to `Module::init`
Date: Thu,  5 Dec 2024 15:14:32 +0100
Message-ID: <20241205141533.111830-2-dakr@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205141533.111830-1-dakr@kernel.org>
References: <20241205141533.111830-1-dakr@kernel.org>
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
 drivers/block/rnull.rs          |  2 +-
 rust/kernel/lib.rs              | 14 ++++++++++----
 rust/kernel/net/phy.rs          |  2 +-
 rust/kernel/sync/lock/global.rs |  6 ++++--
 rust/macros/lib.rs              |  6 ++++--
 rust/macros/module.rs           |  7 +++++--
 samples/rust/rust_minimal.rs    |  2 +-
 samples/rust/rust_print_main.rs |  2 +-
 8 files changed, 27 insertions(+), 14 deletions(-)

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
index e1065a7551a3..686db6aa3323 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -90,7 +90,7 @@ pub trait Module: Sized + Sync + Send {
     /// should do.
     ///
     /// Equivalent to the `module_init` macro in the C API.
-    fn init(module: &'static ThisModule) -> error::Result<Self>;
+    fn init(name: &'static str::CStr, module: &'static ThisModule) -> error::Result<Self>;
 }
 
 /// A module that is pinned and initialised in-place.
@@ -98,13 +98,19 @@ pub trait InPlaceModule: Sync + Send {
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
index b89c681d97c0..0f41df2e6b96 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -903,7 +903,7 @@ struct Module {
                 [$($crate::net::phy::create_phy_driver::<$driver>()),+];
 
             impl $crate::Module for Module {
-                fn init(module: &'static ThisModule) -> Result<Self> {
+                fn init(_name: &'static CStr, module: &'static ThisModule) -> Result<Self> {
                     // SAFETY: The anonymous constant guarantees that nobody else can access
                     // the `DRIVERS` static. The array is used only in the C side.
                     let drivers = unsafe { &mut DRIVERS };
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
index 480ee724e3cc..feff4638e20b 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -187,6 +187,7 @@ pub fn get_mut(&mut self) -> &mut T {
 /// ```
 /// # mod ex {
 /// # use kernel::prelude::*;
+/// # use kernel::str;
 /// kernel::sync::global_lock! {
 ///     // SAFETY: Initialized in module initializer before first use.
 ///     unsafe(uninit) static MY_COUNTER: Mutex<u32> = 0;
@@ -199,7 +200,7 @@ pub fn get_mut(&mut self) -> &mut T {
 /// }
 ///
 /// impl kernel::Module for MyModule {
-///     fn init(_module: &'static ThisModule) -> Result<Self> {
+///     fn init(_name: &'static str::CStr, _module: &'static ThisModule) -> Result<Self> {
 ///         // SAFETY: Called exactly once.
 ///         unsafe { MY_COUNTER.init() };
 ///
@@ -216,6 +217,7 @@ pub fn get_mut(&mut self) -> &mut T {
 /// # mod ex {
 /// # use kernel::prelude::*;
 /// use kernel::sync::{GlobalGuard, GlobalLockedBy};
+/// # use kernel::str;
 ///
 /// kernel::sync::global_lock! {
 ///     // SAFETY: Initialized in module initializer before first use.
@@ -239,7 +241,7 @@ pub fn get_mut(&mut self) -> &mut T {
 /// }
 ///
 /// impl kernel::Module for MyModule {
-///     fn init(_module: &'static ThisModule) -> Result<Self> {
+///     fn init(_name: &'static str::CStr, _module: &'static ThisModule) -> Result<Self> {
 ///         // SAFETY: Called exactly once.
 ///         unsafe { MY_MUTEX.init() };
 ///
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 4ab94e44adfe..d669f9cd1726 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -32,6 +32,7 @@
 ///
 /// ```
 /// use kernel::prelude::*;
+/// use kernel::str;
 ///
 /// module!{
 ///     type: MyModule,
@@ -45,7 +46,7 @@
 /// struct MyModule(i32);
 ///
 /// impl kernel::Module for MyModule {
-///     fn init(_module: &'static ThisModule) -> Result<Self> {
+///     fn init(_name: &'static str::CStr, _module: &'static ThisModule) -> Result<Self> {
 ///         let foo: i32 = 42;
 ///         pr_info!("I contain:  {}\n", foo);
 ///         Ok(Self(foo))
@@ -65,6 +66,7 @@
 ///
 /// ```
 /// use kernel::prelude::*;
+/// use kernel::str;
 ///
 /// module!{
 ///     type: MyDeviceDriverModule,
@@ -78,7 +80,7 @@
 /// struct MyDeviceDriverModule;
 ///
 /// impl kernel::Module for MyDeviceDriverModule {
-///     fn init(_module: &'static ThisModule) -> Result<Self> {
+///     fn init(_name: &'static str::CStr, _module: &'static ThisModule) -> Result<Self> {
 ///         Ok(Self)
 ///     }
 /// }
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 2587f41b0d39..1f14ef55341a 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -333,8 +333,11 @@ mod __module_init {{
                     ///
                     /// This function must only be called once.
                     unsafe fn __init() -> kernel::ffi::c_int {{
-                        let initer =
-                            <{type_} as kernel::InPlaceModule>::init(&super::super::THIS_MODULE);
+                        let initer = <{type_} as kernel::InPlaceModule>::init(
+                            kernel::c_str!(\"{name}\"),
+                            &super::super::THIS_MODULE
+                        );
+
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
 
diff --git a/samples/rust/rust_print_main.rs b/samples/rust/rust_print_main.rs
index aed90a6feecf..0853d767439b 100644
--- a/samples/rust/rust_print_main.rs
+++ b/samples/rust/rust_print_main.rs
@@ -41,7 +41,7 @@ fn arc_print() -> Result {
 }
 
 impl kernel::Module for RustPrint {
-    fn init(_module: &'static ThisModule) -> Result<Self> {
+    fn init(_name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
         pr_info!("Rust printing macros sample (init)\n");
 
         pr_emerg!("Emergency message (level 0) without args\n");
-- 
2.47.0


