Return-Path: <linux-pci+bounces-15049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AC89AB878
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 23:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19EBA2841B6
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 21:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE581CCED1;
	Tue, 22 Oct 2024 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2J/uoJD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B0A1CCB31;
	Tue, 22 Oct 2024 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632762; cv=none; b=ssCjK1yIvEYzb0sZMIFRV97eWlDjnc1cO47FLqUjIhYwgZAWt5ga6zBdht1a5/PDmWcPBL8TYlR3ZbC0tPjKHpPmqr9/CQBXD2XI6fpE+a2JbLzydULYtcBJM1Boxz+PheW7QP7PkaQMIR3kGn7TfMaTH0lnYKF8tzoKzXv11PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632762; c=relaxed/simple;
	bh=upo39o0TQIUfHpAEP1eM1ZcDVF3KOz3s/hyBNkmOhW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaGVeO2s8qmh918CKgpUvsz95zO9Idx8Kl873KUHZleue3+iFSaqVVE4UUNGKySU5hRFmeaGRcVA+Ul0NnM2VYTZGfjg6oJnRfobjdjxXuv/w7rX8uvSVyoRddS3QiRkWbwF3w4yohGJTaFd6sozQIdw+mI9tL59MLsGX5eY1yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2J/uoJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DD6C4CEC7;
	Tue, 22 Oct 2024 21:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729632762;
	bh=upo39o0TQIUfHpAEP1eM1ZcDVF3KOz3s/hyBNkmOhW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t2J/uoJDdDbhKKmHgaNSNYBwDDiFMryaAYLZPPFG4c0iUAaqzBjZzwv1RCld/GZ2H
	 3m11s68J/yhe4CHrWomGLlx8iEhzE7eUYq5Z5/4f/3F+8f9b/pYSIGLF3HpsAzs9Ia
	 oP8UivU74DvEzGCyPp390Bu1S2Jj+7WYs+3zimby8GEMgVIJhUBRK8wOtpTOVIrWSb
	 kP1AqADavHA20exqfK3hFgRluwzK7dREWt8GVBF7u4bndIRP5LMVSETWoTKdkdcChI
	 Lc691muolL50JBvhjETw3P6fHG3A1N/aqhwDFLieXX/6gBLbyBr5wg6gbFb6RcQC8J
	 6bve+8WBiRRWg==
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
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 02/16] rust: introduce `InPlaceModule`
Date: Tue, 22 Oct 2024 23:31:39 +0200
Message-ID: <20241022213221.2383-3-dakr@kernel.org>
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

From: Wedson Almeida Filho <walmeida@microsoft.com>

This allows modules to be initialised in-place in pinned memory, which
enables the usage of pinned types (e.g., mutexes, spinlocks, driver
registrations, etc.) in modules without any extra allocations.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/lib.rs    | 23 +++++++++++++++++++++++
 rust/macros/module.rs | 28 ++++++++++++----------------
 2 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b62451f64f6e..4fdb0d91f2ad 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -83,6 +83,29 @@ pub trait Module: Sized + Sync + Send {
     fn init(module: &'static ThisModule) -> error::Result<Self>;
 }
 
+/// A module that is pinned and initialised in-place.
+pub trait InPlaceModule: Sync + Send {
+    /// Creates an initialiser for the module.
+    ///
+    /// It is called when the module is loaded.
+    fn init(module: &'static ThisModule) -> impl init::PinInit<Self, error::Error>;
+}
+
+impl<T: Module> InPlaceModule for T {
+    fn init(module: &'static ThisModule) -> impl init::PinInit<Self, error::Error> {
+        let initer = move |slot: *mut Self| {
+            let m = <Self as Module>::init(module)?;
+
+            // SAFETY: `slot` is valid for write per the contract with `pin_init_from_closure`.
+            unsafe { slot.write(m) };
+            Ok(())
+        };
+
+        // SAFETY: On success, `initer` always fully initialises an instance of `Self`.
+        unsafe { init::pin_init_from_closure(initer) }
+    }
+}
+
 /// Equivalent to `THIS_MODULE` in the C API.
 ///
 /// C header: [`include/linux/init.h`](srctree/include/linux/init.h)
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index aef3b132f32b..a03266a78cfb 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -232,6 +232,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             mod __module_init {{
                 mod __module_init {{
                     use super::super::{type_};
+                    use kernel::init::PinInit;
 
                     /// The \"Rust loadable module\" mark.
                     //
@@ -242,7 +243,8 @@ mod __module_init {{
                     #[used]
                     static __IS_RUST_MODULE: () = ();
 
-                    static mut __MOD: Option<{type_}> = None;
+                    static mut __MOD: core::mem::MaybeUninit<{type_}> =
+                        core::mem::MaybeUninit::uninit();
 
                     // Loadable modules need to export the `{{init,cleanup}}_module` identifiers.
                     /// # Safety
@@ -331,20 +333,14 @@ mod __module_init {{
                     ///
                     /// This function must only be called once.
                     unsafe fn __init() -> core::ffi::c_int {{
-                        match <{type_} as kernel::Module>::init(&super::super::THIS_MODULE) {{
-                            Ok(m) => {{
-                                // SAFETY: No data race, since `__MOD` can only be accessed by this
-                                // module and there only `__init` and `__exit` access it. These
-                                // functions are only called once and `__exit` cannot be called
-                                // before or during `__init`.
-                                unsafe {{
-                                    __MOD = Some(m);
-                                }}
-                                return 0;
-                            }}
-                            Err(e) => {{
-                                return e.to_errno();
-                            }}
+                        let initer =
+                            <{type_} as kernel::InPlaceModule>::init(&super::super::THIS_MODULE);
+                        // SAFETY: No data race, since `__MOD` can only be accessed by this module
+                        // and there only `__init` and `__exit` access it. These functions are only
+                        // called once and `__exit` cannot be called before or during `__init`.
+                        match unsafe {{ initer.__pinned_init(__MOD.as_mut_ptr()) }} {{
+                            Ok(m) => 0,
+                            Err(e) => e.to_errno(),
                         }}
                     }}
 
@@ -359,7 +355,7 @@ unsafe fn __exit() {{
                         // called once and `__init` was already called.
                         unsafe {{
                             // Invokes `drop()` on `__MOD`, which should be used for cleanup.
-                            __MOD = None;
+                            __MOD.assume_init_drop();
                         }}
                     }}
 
-- 
2.46.2


