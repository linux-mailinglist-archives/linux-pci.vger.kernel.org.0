Return-Path: <linux-pci+bounces-8941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EB990E006
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 01:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC7F1C226C8
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 23:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5478117A92C;
	Tue, 18 Jun 2024 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NENU/ngc"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5AE1849D9
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754056; cv=none; b=N6N71gbcNocqHm3ErmNLnCg1+1OgvLZtg5cHXMIR4w4tqZK/+xEAzws5zrBf00Ecim2ilTS17ba+wWO8b9uxcauJwIJxHXMa1FGikkeydxY96mEIMvkgx04vQ5wNqhidzihv8BltqvNiFBPszlgtoGUIvDIALzsg1d4ORvTW9nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754056; c=relaxed/simple;
	bh=MLFfiEGNgBcr9bLiufmhyDYAqVr8JMOqYi/vywiSXPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYih0oKJhBLlIkgquu9IK5X0ysRaeg0461H+73ylOC1Ly/bkYTY43fZL8hALAisHE/ufprUPhM9DtyBej2UN2+HWOgPekZqbT0CbHaqt+gO8avq/ahUVd1znl8EeUMjP6vgVZO6knjaOqC8stDaFZnp0Wsf8YWBT4rx+Ijgcsw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NENU/ngc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718754053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1qjkzHfzy3NUrrPbUMcZvTn0a95wVyUbECTV/h26qqI=;
	b=NENU/ngcNaDrUpC48f/BpY5z8D9XQMMeDYlhY4KsvGsH+x262yaWIRYoEoT802UHvEURd2
	KCyTWpddiCD74JLKho3EbV6dx6KGUsFWNKmx8t4HAIvdxaGqhI1QaqJLsnini5DfEbv/ML
	qcXSji4iZvE/F6ebwGwnmYZIHCKsTk8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-9EGvT5YrM7-vPTzGCdE6UA-1; Tue, 18 Jun 2024 19:40:47 -0400
X-MC-Unique: 9EGvT5YrM7-vPTzGCdE6UA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42183fdb37cso44087095e9.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 16:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718754046; x=1719358846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qjkzHfzy3NUrrPbUMcZvTn0a95wVyUbECTV/h26qqI=;
        b=cIvGqTk72qzYAnU6uhP7ZhEGJBHNVejilNnkhcOUl7iD1Vqq4IKYGS5EgPbJTqrw6Z
         H1YyDvEGO0Avmrjn95mDhxl2r0f3mIhSIGKKZZRME8HkD/2ZiJt0LxxMzEuSia31GiIQ
         tzL8IcE/gAxiWw0CGdUMaF4xfCKM30Nx7GmXVKRp4jJTszr8kV6gfAonesKYZdtiOXxI
         J2v4DtQC5x9xEhip6eG8kYOXU6SjpNQJAsY1mR4JsS+WBWrD0HAB3V6sRz9/CFsCU7IJ
         /dYPyRA/rdbhZV3NUFeg2A3ypvmfIjJZd7QmGCvJSCIeqIcBj3Bmxb8j10njco3OFMIL
         BVtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhUiCAaYMHJq6uuduNtv0h1NZvdIXRUoeUgK3VeU2KajsSNsN9QaDCf6uun9TzaXbgoyzr39cYx4656Z4kigLH9y5d6YRxONe7
X-Gm-Message-State: AOJu0YwJS4dDghMy39tawzF0rzszyTSu+B8UEc3k1vifbPF1sg2Dd+Os
	xnZM+GLLKge95zGAzCWm8Z5Hg983qrdXtcRWOhxB6Gi7oqImWqqK0Wf3tywfSncuKc8Zu+m+tzT
	zYip3GmTg/uo5bagCnzwBsYjdvF1tQdYLe90rVEwByuZQd5pgVESrOYwkYw==
X-Received: by 2002:a05:600c:26d1:b0:422:35:d19d with SMTP id 5b1f17b1804b1-4247529df2emr5259425e9.36.1718754046255;
        Tue, 18 Jun 2024 16:40:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDw6Fk9C824R3TVe0mbmNmXLCAKpwzyBK1V1rVulamZFyXGPFnWYHmT55mcrVs+DxsV8w/Pw==
X-Received: by 2002:a05:600c:26d1:b0:422:35:d19d with SMTP id 5b1f17b1804b1-4247529df2emr5259325e9.36.1718754045909;
        Tue, 18 Jun 2024 16:40:45 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-423034f4129sm198773995e9.14.2024.06.18.16.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 16:40:45 -0700 (PDT)
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
	lyude@redhat.com,
	robh@kernel.org,
	daniel.almeida@collabora.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH v2 01/10] rust: pass module name to `Module::init`
Date: Wed, 19 Jun 2024 01:39:47 +0200
Message-ID: <20240618234025.15036-2-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240618234025.15036-1-dakr@redhat.com>
References: <20240618234025.15036-1-dakr@redhat.com>
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

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/lib.rs           | 14 ++++++++++----
 rust/kernel/net/phy.rs       |  2 +-
 rust/macros/module.rs        |  3 ++-
 samples/rust/rust_minimal.rs |  2 +-
 samples/rust/rust_print.rs   |  2 +-
 5 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index a791702b4fee..5af00e072a58 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -71,7 +71,7 @@ pub trait Module: Sized + Sync + Send {
     /// should do.
     ///
     /// Equivalent to the `module_init` macro in the C API.
-    fn init(module: &'static ThisModule) -> error::Result<Self>;
+    fn init(name: &'static str::CStr, module: &'static ThisModule) -> error::Result<Self>;
 }
 
 /// A module that is pinned and initialised in-place.
@@ -79,13 +79,19 @@ pub trait InPlaceModule: Sync + Send {
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
index fd40b703d224..ccb2552dc107 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -887,7 +887,7 @@ struct Module {
                 [$($crate::net::phy::create_phy_driver::<$driver>()),+];
 
             impl $crate::Module for Module {
-                fn init(module: &'static ThisModule) -> Result<Self> {
+                fn init(_name: &'static CStr, module: &'static ThisModule) -> Result<Self> {
                     // SAFETY: The anonymous constant guarantees that nobody else can access
                     // the `DRIVERS` static. The array is used only in the C side.
                     let drivers = unsafe { &mut DRIVERS };
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 105be4797f85..be03b2cf77a1 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -302,7 +302,8 @@ mod __module_init {{
                     ///
                     /// This function must only be called once.
                     unsafe fn __init() -> core::ffi::c_int {{
-                        let initer = <{type_} as kernel::InPlaceModule>::init(&super::super::THIS_MODULE);
+                        let initer = <{type_} as kernel::InPlaceModule>::init(kernel::c_str!(\"{name}\"),
+                                                                              &super::super::THIS_MODULE);
                         // SAFETY: No data race, since `__MOD` can only be accessed by this module
                         // and there only `__init` and `__exit` access it. These functions are only
                         // called once and `__exit` cannot be called before or during `__init`.
diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
index 2a9eaab62d1c..3b918ff5eebb 100644
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
index 6eabb0d79ea3..722275a735f1 100644
--- a/samples/rust/rust_print.rs
+++ b/samples/rust/rust_print.rs
@@ -40,7 +40,7 @@ fn arc_print() -> Result {
 }
 
 impl kernel::Module for RustPrint {
-    fn init(_module: &'static ThisModule) -> Result<Self> {
+    fn init(_name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
         pr_info!("Rust printing macros sample (init)\n");
 
         pr_emerg!("Emergency message (level 0) without args\n");
-- 
2.45.1


