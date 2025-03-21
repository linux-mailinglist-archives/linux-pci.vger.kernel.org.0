Return-Path: <linux-pci+bounces-24366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603E3A6BDE1
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 16:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5605F17AD26
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 15:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB021DB356;
	Fri, 21 Mar 2025 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Umk6rLD+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E815F1D7E26;
	Fri, 21 Mar 2025 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742569164; cv=none; b=PnScb89NWQ/CRlEnLU96/4azOSsPHjOLgKo3b7X9OAhap4a5mrbkmtFiSIQPIb2OFMb7UynXSmTelwP/4sG7/WulVhu3DvxDV++uWAnIt1y+/QeRFhleqDlQujoS/ajehePheRCs+lN2z4uHegrgtOY/DP4BzjrVgrVMIFJaUL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742569164; c=relaxed/simple;
	bh=XK3ss92XB9PpaMbmmBVABAPs+6dJW9sFNmtLOGmVRwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8R8ECgxZejJF3xvXrHuMxfEVvv7lxNbUyrp0YQ0aPwTorkyLPsgMUZLGVrglL1z5xogoKHTIDquVcSa0UUUEAYGADTAkiIzuBpOnTs5dQrvYA8hml7HAQQYjK42bw6qwV+z6+8IJ6QBza7bU5yFZHGk31Ed3I9Qg5BJ+B4D7Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Umk6rLD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B28C4CEEC;
	Fri, 21 Mar 2025 14:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742569163;
	bh=XK3ss92XB9PpaMbmmBVABAPs+6dJW9sFNmtLOGmVRwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Umk6rLD+QQhysD2ySV+lZiJVTixCw6GXeItNx/BQVMzrYqlS6zGQlYsu/8Dp2d7L3
	 LgQeMj1DpTM0F1aW54X+lI3tBFcq9eZ8kX/F4yFiqm/Woc2H+pb9CfxDZVah0+uwiv
	 eZN8e7aZoUw+DuLDGrfqOybrt6PwWzTXfWx9oXnZLarnapKtIyK8+wRt1mexhr2/3O
	 /8JsqroJ5ime7A3ZmpkHcW9JOK6i3BCdlkERm9wJmY1AgezTbnT9pUQhsPtk80jlLg
	 QICtwkbfoJZsitlOYXWhBFISHbmjvcLFpar/vG4sJxHw7rEzULNRajXhJCwqPRWuBA
	 UmCbncsRiTtnw==
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
Subject: [PATCH v3 3/3] rust: platform: impl TryFrom<&Device> for &platform::Device
Date: Fri, 21 Mar 2025 15:57:58 +0100
Message-ID: <20250321145906.3163-4-dakr@kernel.org>
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

This allows us to get a &platform::Device from a generic &Device in a safe
way; the conversion fails if the device' bus type does not match with
the platform bus type.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/platform.rs | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index e37531bae8e9..d7796967cffa 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -5,7 +5,7 @@
 //! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
 
 use crate::{
-    bindings, device, driver,
+    bindings, container_of, device, driver,
     error::{to_result, Result},
     of,
     prelude::*,
@@ -17,7 +17,7 @@
 use core::{
     marker::PhantomData,
     ops::Deref,
-    ptr::{addr_of_mut, NonNull},
+    ptr::{addr_of, addr_of_mut, NonNull},
 };
 
 /// An adapter for the registration of platform drivers.
@@ -234,6 +234,24 @@ fn as_ref(&self) -> &device::Device {
     }
 }
 
+impl TryFrom<&device::Device> for &Device {
+    type Error = kernel::error::Error;
+
+    fn try_from(dev: &device::Device) -> Result<Self, Self::Error> {
+        if dev.bus_type_raw() != addr_of!(bindings::platform_bus_type) {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: We've just verified that the bus type of `dev` equals
+        // `bindings::platform_bus_type`, hence `dev` must be embedded in a valid
+        // `struct platform_device` as guaranteed by the corresponding C code.
+        let pdev = unsafe { container_of!(dev.as_raw(), bindings::platform_device, dev) };
+
+        // SAFETY: `pdev` is a valid pointer to a `struct platform_device`.
+        Ok(unsafe { &*pdev.cast() })
+    }
+}
+
 // SAFETY: A `Device` is always reference-counted and can be released from any thread.
 unsafe impl Send for Device {}
 
-- 
2.48.1


