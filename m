Return-Path: <linux-pci+bounces-24269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 413F9A6B0BD
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 23:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DD4487A91
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 22:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEB522A4F8;
	Thu, 20 Mar 2025 22:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAF5iJQT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63901B422A;
	Thu, 20 Mar 2025 22:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742509720; cv=none; b=Iet1xDAYEtTQpuWZ8igzhadzWk1kwmo8hDoy/uubC20UAZqjPS3kLKfDjwcsRtbCE5tSqM1HBcR/xKcilZbACNjHqZg+1QK+tlYzz+MByFod4BkAsjw67lIW6wc3z1ycDUfa1jg98DDY83EDBR61M5d1mLwS7B8ZFX4wdsTV3wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742509720; c=relaxed/simple;
	bh=R3UfaAoWA9hqb0IAABlkpB/RL6uS8H409kUbpJ/3C60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ho9aqfrOl6u4C3O3DliaLKjWG6t2Fj9yytmEJmBz8NKq3Djfl77ko57j0AJleKtEUQRvmlqp0cVGg4WyZmJUGQGrRm+yqAJR0hrNZkjTqrM6BmwwV/Tby42iFqsVskzdlNgES6tL1R39819q0DkYmgEAKZ/1FU93AgoPmmhOZTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAF5iJQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC935C4CEDD;
	Thu, 20 Mar 2025 22:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742509720;
	bh=R3UfaAoWA9hqb0IAABlkpB/RL6uS8H409kUbpJ/3C60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BAF5iJQTPJZfYskoNEbj43YnWINaxd/u4Nhz3KSjFsfW1tLXJOTtejb0HMKgEQrHQ
	 KdlHGUpfHTc2pNRmEKRJ7ORU7Sbv0vnUix39ChJQadfvMXNLpI4fY1S2FBLHrlZLpz
	 rvlycKez0bexTK9u7vWvUzdY/8Bmg8LFB/cWD2zGkxw+dNYqoQSjLiXW0KuM/DWshW
	 /zKjrRTO0bJWeQnMXVTyo71h20H00pZvYmsH/mkw3RLz7Yzl7Qc8NlLj0hWTrkgz5/
	 3OzDB2XTQIhyDK05aFKcNgi+fMJ//hA2ArhL3ffxrxjA5Fqh1m2HwWFsgtXKVR4Db3
	 8PeXbcEUBW+aA==
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
Subject: [PATCH v2 3/4] rust: pci: impl TryFrom<&Device> for &pci::Device
Date: Thu, 20 Mar 2025 23:27:45 +0100
Message-ID: <20250320222823.16509-4-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320222823.16509-1-dakr@kernel.org>
References: <20250320222823.16509-1-dakr@kernel.org>
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
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs |  1 -
 rust/kernel/pci.rs    | 21 +++++++++++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 1b554fdd93e9..190719a04686 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -81,7 +81,6 @@ pub fn parent<'a>(&self) -> Option<&'a Self> {
     }
 
     /// Returns a raw pointer to the device' bus type.
-    #[expect(unused)]
     pub(crate) fn bus_type_raw(&self) -> *const bindings::bus_type {
         // SAFETY:
         // - By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 22a32172b108..b717bcdb9abf 100644
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
 
@@ -466,6 +466,23 @@ fn as_ref(&self) -> &device::Device {
     }
 }
 
+impl TryFrom<&device::Device> for &Device {
+    type Error = kernel::error::Error;
+
+    fn try_from(dev: &device::Device) -> Result<Self, Self::Error> {
+        if dev.bus_type_raw() != addr_of!(bindings::pci_bus_type) {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: We've just verified that the bus type of `dev` equals `bindings::pci_bus_type`,
+        // hence `dev` must be embedded in a valid `struct pci_dev`.
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


