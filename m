Return-Path: <linux-pci+bounces-24270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B13A6B0C0
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 23:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6E3188A323
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 22:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFE522B8C7;
	Thu, 20 Mar 2025 22:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5TnhhjS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82681B422A;
	Thu, 20 Mar 2025 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742509724; cv=none; b=r5/4TYJ0s439xNYTAX+/FVXdyjl9mY2wtXjNROu8wC4pSB0OOLyJcDWCj2q1ISYsCPRcS7yFfeMT8jAsKMV7zjO2BELqaY2JWnPu2B3JnWPNL3nCNwATjBLFG9nPgRXZi2R9Ai/RxIC6PRkxLTWlbPPqiWKzNOcRdtx2KAqApwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742509724; c=relaxed/simple;
	bh=uKiDVjqXqoM1jJa6VHOyG2y9M/M3KF8/oYD/JGcLH6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuovsKSv+8sjSSPrf4kvCEcGrDUysK45n/okobRBU4957vJ+w9NkRuygKzuGbP7T8+wCra9+EkKHjEmVb2q0LB1ZndyQ29f2Q+0o6MV+dQikCnOTYoJs+ctnLK5FD4NHVUI6jsCRtgOVWxARAVuDnb1NroIIhu08TFvts9wSysA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5TnhhjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9852BC4CEE3;
	Thu, 20 Mar 2025 22:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742509723;
	bh=uKiDVjqXqoM1jJa6VHOyG2y9M/M3KF8/oYD/JGcLH6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O5TnhhjS8/65mAe7kflOqEpFEWsoZ/1SlwSLgDGc/CSvOpY4LJen769jEqHMdBG5A
	 qMCEgqdbwprJwpV0MFJiJbnwyu3geHNWpZNjA+WCZEIHTkHw/SfT86shnxoCHNS24g
	 MoCnoefJWM+Rz7aVEimnU0WOeATLiJ6iQRZIFXdn0T99dAPJXmdvQ3hKO+eAaKF68y
	 pux/gXoIyE5CwTSsKH+kc0O6P0nqXPFpNrJWSGtfFDdFLdKIyk+oH99dR/ecFybupK
	 f7vVaAx54q/P5odJAhwQSpCZWa6nWHt1FKFsNJvkMijtDz2YnLF1ddAgeodB9e4jw/
	 s5OXrRvb0D29A==
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
Subject: [PATCH v2 4/4] rust: platform: impl TryFrom<&Device> for &platform::Device
Date: Thu, 20 Mar 2025 23:27:46 +0100
Message-ID: <20250320222823.16509-5-dakr@kernel.org>
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

This allows us to get a &platform::Device from a generic &Device in a safe
way; the conversion fails if the device' bus type does not match with
the platform bus type.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/platform.rs | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index e37531bae8e9..c17fc6e7c596 100644
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
+        // `struct platform_device`.
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


