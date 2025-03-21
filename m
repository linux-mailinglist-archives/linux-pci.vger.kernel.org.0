Return-Path: <linux-pci+bounces-24412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CDDA6C577
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 22:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC341B6156D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 21:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B34234979;
	Fri, 21 Mar 2025 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSXH3xYj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAACD231CB0;
	Fri, 21 Mar 2025 21:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742593724; cv=none; b=HfTlzPkU+qZrfIWLbmhZseVOEwGXrrRtIB/t2BXX6MyLkZ4POsv1mi/Qte26BVIbZQIWPAfS+MmrKzYYYxZkuIBwx+WA6dIGB+1PRNHaX3wBeBL3kgaOYN0fDtLBHFuWOTnHdUy5hyECEPc4HEb8VdXEUjd6gfFc3rvjypjBWHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742593724; c=relaxed/simple;
	bh=pchn7jrYnae+/6/jOnvBapw0ww9YrRGTJKs+GVP37ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CD3ETUH2Evv9z249FYr/A8Sw/EeXQlFKJtbdVoqTGEV6UIufSUICudOaOwjq8+d38jjgKyO4GP0NhTxUMZVAwBdyIokTfcqUEs+PUbrmvl0iGbEV3Ierk+PYgQxhxjOMJpN2XuajgssPsZ0NnEOmOKpsprbJqVoLnwOeyJdENPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSXH3xYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B49C4CEE3;
	Fri, 21 Mar 2025 21:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742593723;
	bh=pchn7jrYnae+/6/jOnvBapw0ww9YrRGTJKs+GVP37ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GSXH3xYj+4omoFM9EBaVijExGJnZuNMPfRmDda3JliX+uQZtz+hxpXeW05o7b3ojz
	 QpWADyCBQcab7TsMr+DEiEaQ5/DSWqEwj8xMzxh/HrpANBxj9DIDLu69KN4HCEzxKL
	 j/JEl/+vzvXHf7xL87kXKY27DIzgQCK/Jfw/QL3pdWGO9FOPiHQdlMoryXBY965LGV
	 QUn3aWydtmEezlI7fDPhOcaMcYfbDZ9auEg9QqL7SBA+h28FVRyrae6dEM3KKRCKVO
	 QEKxlmE0jS1o9FpqMkktan3UwckqH0EkH7NAEAUSS03ndQzOFdOgjezMQ/K29ZaB3i
	 pyCOtFQ5oQPbg==
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
Subject: [PATCH v4 3/3] rust: platform: impl TryFrom<&Device> for &platform::Device
Date: Fri, 21 Mar 2025 22:47:55 +0100
Message-ID: <20250321214826.140946-4-dakr@kernel.org>
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

This allows us to get a &platform::Device from a generic &Device in a safe
way; the conversion fails if the device' bus type does not match with
the platform bus type.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/platform.rs | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index e37531bae8e9..b39ca2573020 100644
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
@@ -234,6 +234,27 @@ fn as_ref(&self) -> &device::Device {
     }
 }
 
+impl TryFrom<&device::Device> for &Device {
+    type Error = kernel::error::Error;
+
+    fn try_from(dev: &device::Device) -> Result<Self, Self::Error> {
+        #[allow(unused_unsafe)]
+        // SAFETY: rustc < 1.82 falsely treats this as unsafe, see:
+        // https://blog.rust-lang.org/2024/10/17/Rust-1.82.0.html#safely-addressing-unsafe-statics
+        if dev.bus_type_raw() != unsafe { addr_of!(bindings::platform_bus_type) } {
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


