Return-Path: <linux-pci+bounces-18061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2A49EBE1D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 23:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3DA0283F2C
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 22:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35614211286;
	Tue, 10 Dec 2024 22:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAYAJDIY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D261F193F;
	Tue, 10 Dec 2024 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871007; cv=none; b=YHogdZ8v1VPqNrTI3TKhPeUVPnDTCyJk+xNtetvHpmf+5vuQPG3gD/5wD7TPAXBQQIFNgVOO5VvSbZewEwQYalMZIL8Nu6AEeyZ+USSR5ltBFYpyetI5O9hcxbG8YIcR8jY0OdWN38Q49wI8HgE/BvNWzuu5Q0ysXdTADbxevcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871007; c=relaxed/simple;
	bh=MNZnx40yHBgeJuxIq/O46ufjWWvnnyaUT4P7UVajjzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKM1EjNd8GzVtcIK6qaXwqT686t8ivJ7gTVMTKT3CR0jqs8BrHWyhTXINhCZ/e8GdgGlSkSAhawwZiUkqpZRAwu/5GeoDeR1kayGuzT8HBDrjmIyGKDj0Bh2JsyRSXzhBnRV3hhU7HtCHgj4VABr1VTLiqUSGbeRiyLKfY2j/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAYAJDIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F32C4CEE3;
	Tue, 10 Dec 2024 22:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733871005;
	bh=MNZnx40yHBgeJuxIq/O46ufjWWvnnyaUT4P7UVajjzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lAYAJDIYXx0rdyZThywzDCFQwGAymJgT+6gF+ZUHN13blVi2T0TCxyQQrUE/qkc96
	 w3s3BFbiHggzmEps8Pa6OxN21quOR1MWdyIr9m0hIOlBRhlL1rjXDQBpvqv9vUUYYH
	 pB8A2JXD3iLkE984DSO4dw4v8M8UxgDRkqz63sbwZqjJOq6Zu2Rk2Rh25jZUenngOH
	 mBVTi+4klJia4LK8SvuV9eUCGPqq52M6O0EXVCzU0WjunuIzVHxDUD+JsQtyHQqx1y
	 /QcIWxrJ3Bhh9yBm175UVcfbtfSJSHEkITxTWpMPtdplZuSUXqrIKJ5+FMtntbNQmT
	 q8I2M2PXvZxmQ==
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
Subject: [PATCH v5 01/16] rust: pass module name to `Module::init`
Date: Tue, 10 Dec 2024 23:46:28 +0100
Message-ID: <20241210224947.23804-2-dakr@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210224947.23804-1-dakr@kernel.org>
References: <20241210224947.23804-1-dakr@kernel.org>
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
index 9cca05dcf772..8e859dda70c3 100644
--- a/drivers/block/rnull.rs
+++ b/drivers/block/rnull.rs
@@ -37,7 +37,7 @@ struct NullBlkModule {
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


