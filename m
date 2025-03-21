Return-Path: <linux-pci+bounces-24411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1737EA6C570
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 22:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31EC178869
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 21:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E961E231CA5;
	Fri, 21 Mar 2025 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXGlofsL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEC6231CB0;
	Fri, 21 Mar 2025 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742593720; cv=none; b=sgapiNjqojtQ0dE2wUJJHMAYABk1xjSUMWXhYBoWyrbqjbIfebnEAIg4tJ/Yj7uW0o8se4siuc5mnOpP5l2s8BfgujkWHtBOUPwD1hSlonM8Pximj/djqRWuisThNXfNhIQAtnSvgyQ0O6HqeNWw064YSbo2bcqpH0W8zEwbpNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742593720; c=relaxed/simple;
	bh=pUsrb8mKMf/L0eA69D9oO6dXIRS7L12TDvKRAoBAesQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LA+ts+vXLvcSdLpEu8j0dY6O+oBE9URoO+fUfEFoy12LS7LmQY7i9WwYu0dTRBcUZF6xJEc5EC4aykEj3l186ByDyvtc5yhsZk+Ob7HsWXjysV5Dx5DPmenUMRzthUDM5h+9R6uIOu0MOsB839afzGkUfPA4pIMaZENLxnyfYSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXGlofsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C591C4CEEC;
	Fri, 21 Mar 2025 21:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742593720;
	bh=pUsrb8mKMf/L0eA69D9oO6dXIRS7L12TDvKRAoBAesQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HXGlofsLLdfd9Xiv098th5jHZLtENWYrOIII+uW5ypDyUf6xEdfQWajEdwcbaphgI
	 TUV2awcocJzpr4xaOJrvaLBlwCqwY+bZ03ynw0lIpJffNzoJtMz5c68fNYDkWaoVlu
	 QhFG7iPRu3Cf0j/v4VgV4+vODpQvZT7vYpCfld2KVoe4nEcbvIys0zVispWVUtmALF
	 aZBDA/A8yhhveueiJJIilgyG+4rU0Vb8+tU+V+XRyF8ZxYuzYVptP47NbbNYulGiLu
	 48NPJp0VKJL5NrH+0zMUVkQqKBiaQJziMM1n205Ls1AOJljOs1aLFh3JN+HVANsyZJ
	 Z+zMGjP5ZT6Fg==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v4 2/3] rust: pci: impl TryFrom<&Device> for &pci::Device
Date: Fri, 21 Mar 2025 22:47:54 +0100
Message-ID: <20250321214826.140946-3-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321214826.140946-1-dakr@kernel.org>
References: <20250321214826.140946-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement TryFrom<&device::Device> for &Device.

This allows us to get a &pci::Device from a generic &Device in a safe
way; the conversion fails if the device' bus type does not match with
the PCI bus type.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs |  1 -
 rust/kernel/pci.rs    | 25 +++++++++++++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 67a2fc46cf4c..0bbc67edd38d 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -66,7 +66,6 @@ pub(crate) fn as_raw(&self) -> *mut bindings::device {
     }
 
     /// Returns a raw pointer to the device' bus type.
-    #[expect(unused)]
     pub(crate) fn bus_type_raw(&self) -> *const bindings::bus_type {
         // SAFETY:
         // - By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 22a32172b108..8b7fcfe8bffc 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -6,7 +6,7 @@
 
 use crate::{
     alloc::flags::*,
-    bindings, device,
+    bindings, container_of, device,
     device_id::RawDeviceId,
     devres::Devres,
     driver,
@@ -20,7 +20,7 @@
 use core::{
     marker::PhantomData,
     ops::Deref,
-    ptr::{addr_of_mut, NonNull},
+    ptr::{addr_of, addr_of_mut, NonNull},
 };
 use kernel::prelude::*;
 
@@ -466,6 +466,27 @@ fn as_ref(&self) -> &device::Device {
     }
 }
 
+impl TryFrom<&device::Device> for &Device {
+    type Error = kernel::error::Error;
+
+    fn try_from(dev: &device::Device) -> Result<Self, Self::Error> {
+        #[allow(unused_unsafe)]
+        // SAFETY: rustc < 1.82 falsely treats this as unsafe, see:
+        // https://blog.rust-lang.org/2024/10/17/Rust-1.82.0.html#safely-addressing-unsafe-statics
+        if dev.bus_type_raw() != unsafe { addr_of!(bindings::pci_bus_type) } {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: We've just verified that the bus type of `dev` equals `bindings::pci_bus_type`,
+        // hence `dev` must be embedded in a valid `struct pci_dev` as guaranteed by the
+        // corresponding C code.
+        let pdev = unsafe { container_of!(dev.as_raw(), bindings::pci_dev, dev) };
+
+        // SAFETY: `pdev` is a valid pointer to a `struct pci_dev`.
+        Ok(unsafe { &*pdev.cast() })
+    }
+}
+
 // SAFETY: A `Device` is always reference-counted and can be released from any thread.
 unsafe impl Send for Device {}
 
-- 
2.48.1


