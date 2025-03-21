Return-Path: <linux-pci+bounces-24365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A314FA6BDDE
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 16:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5324517B426
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 14:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EC92253A5;
	Fri, 21 Mar 2025 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ru6hFph/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FCF1D7E26;
	Fri, 21 Mar 2025 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742569160; cv=none; b=kFuL0wPjX8iZ0RTXcT0NT6WuAOTWZjhtFU8Alxil1M8cOCxtYEb9JPRQVGMXtDyMHsxBgkyQGCbpBPqgxN6LcTYN0zMZmehh/Wk4oigPyV6ff9k+gkwfs8XkUWcRT8j7BdFAAQixNQ2Tp1cWKZUdQLqBgxrBaBImQQJF3c+Z2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742569160; c=relaxed/simple;
	bh=iqf+tTdt2jGaWlTQ8KsyRMl+ITOHzZS2Gb8CPaDPkn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzYx+wY/ehSjyJ403xFtnU/379VjVWJAszx9PwYFi3OZHrMu+u/8yk10Kl4UqvO0/AWCXdzZihZ3kx9sxAUvmnHSin4Q8TmK9FIdUH9b01ZpAxqv9A0gzKwg0o6pJKb+AF3a5ymd6AgwDqZoUR45UbPTg+ISCUrFkpo0xfgYJHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ru6hFph/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A3AC4CEE9;
	Fri, 21 Mar 2025 14:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742569160;
	bh=iqf+tTdt2jGaWlTQ8KsyRMl+ITOHzZS2Gb8CPaDPkn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ru6hFph/FKAqYte1+tuQpXsDEh3t7xuLslBTTqmN0N0LTAPHsJ+euP2vne/O8Up03
	 CGKsTOfp1aY1AoHyyVH6sXKWw45c36353613tXgbjXkyo0ky/vogtA6Yvl6IIeDBXd
	 DeAPj/c6u0Mq4SNME84YSTm8acr6F9AzU4mp9uALgq7rMwWKk9X5JzmWgNmjduLcKt
	 1J69SenBI/8GehEMnjIqom+VMzbU/SKc+bx6q3w78EOqP8M8VmXWSIqpTkvziWP3ll
	 BxD4eP8S+KdvD6oGR6S5oGQ+1bXume9RppnAXx5ss3J237JwyuVg3YWRZP4aPyVQOc
	 MhXEVo9IqXUFQ==
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
Subject: [PATCH v3 2/3] rust: pci: impl TryFrom<&Device> for &pci::Device
Date: Fri, 21 Mar 2025 15:57:57 +0100
Message-ID: <20250321145906.3163-3-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321145906.3163-1-dakr@kernel.org>
References: <20250321145906.3163-1-dakr@kernel.org>
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
 rust/kernel/pci.rs    | 22 ++++++++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

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
index 22a32172b108..c563129d29b6 100644
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
 
@@ -466,6 +466,24 @@ fn as_ref(&self) -> &device::Device {
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


