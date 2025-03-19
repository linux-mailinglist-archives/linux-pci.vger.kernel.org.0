Return-Path: <linux-pci+bounces-24166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C07A69A35
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 21:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8215C465E20
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 20:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE72219A67;
	Wed, 19 Mar 2025 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRa7KHcK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B5810E0;
	Wed, 19 Mar 2025 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742416291; cv=none; b=hyl+C8AgzF3aCOKo9paE0f4F8v55z3MQDtmXUJWwp8+n42Te1n41AwpYH353/0Dswaw1PDFfe17ttC50fVKafFbKYi1qgS+if6FVtrMQ3HX2NgjeTLxUJQ2jRGgRc8L16YKBHAy7a/FXveiG6gGXZK89aeyq6SdnTzbmzQZ4RUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742416291; c=relaxed/simple;
	bh=KwVDyqu7ToQAgJMSbumNmrl4oPW891U9MUKymaHYbyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zijfw3DZarZrN9B/ykKL51fQr+Of2QmnfIJdHO3hKIcRhAjGP4S1USzF0xIWrSoyoBXPjygpV2zgiEk/na+i+LLCpNliY56EBYNx08cVwS/DvR3XGPYVaj+gvp/baAleQtYVU3IRG5j3YqSofCIYq0Td59P+WYc6fHKhUm3pfx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRa7KHcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60182C4CEE4;
	Wed, 19 Mar 2025 20:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742416291;
	bh=KwVDyqu7ToQAgJMSbumNmrl4oPW891U9MUKymaHYbyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kRa7KHcKMGJofJCG9g4R/I8lxiJdyxmQywzQ0865p1/w+HO3UuItMgv8hyY+SRJuQ
	 1GcffmCAfwAPd3OG5vpznRg/yyM2HiYOQ+nrseUdKo8mHyoiJ9gHByIjE0VSywEcHD
	 DHCezEP749urwQcmq4JMcgqZNc8Lur1Ong8CK5sB+0gRsrFR0vul7vGvGkprDc+QbO
	 2XqcXv6xwe6AiNr5vjsygmCx4efLEXqWFisBZd3J5jnGNclGwwInuW91dqHEyt4arf
	 lHt8J3vlxE67z/yA1cBY9AXX/IEZagW/ixwfXhJNGzoiQyI1jooTJE+wEkYEyYxooN
	 X4R6AfQleEIKg==
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
Subject: [PATCH 3/4] rust: pci: impl TryFrom<&Device> for &pci::Device
Date: Wed, 19 Mar 2025 21:30:27 +0100
Message-ID: <20250319203112.131959-4-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319203112.131959-1-dakr@kernel.org>
References: <20250319203112.131959-1-dakr@kernel.org>
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

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs |  1 -
 rust/kernel/pci.rs    | 21 +++++++++++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index e2de0efd4a27..34244c139afc 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -79,7 +79,6 @@ pub fn parent<'a>(&self) -> Option<&'a Self> {
     }
 
     /// Returns a raw pointer to the device' bus type.
-    #[expect(unused)]
     pub(crate) fn bus_type_raw(&self) -> *const bindings::bus_type {
         // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
         unsafe { (*self.as_raw()).bus }
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


