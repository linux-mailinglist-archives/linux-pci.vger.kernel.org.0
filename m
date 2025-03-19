Return-Path: <linux-pci+bounces-24167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5C0A69A37
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 21:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E8046840C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 20:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB78214812;
	Wed, 19 Mar 2025 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdMiZXcU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B258210E0;
	Wed, 19 Mar 2025 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742416295; cv=none; b=ctLoBGdYGQiry/peqXLvbe/ZHFnPOIl20TNsgs+UzlsI/Py/VLTDxSDJbA9i8kQYBZobuHNVnjEkKWlyaggg7l3rchywlMqKcejyN70oibA/4QBBsySEe4iqe136BKk8z/5eLy0ZeG0yj/OUpCFapfsDIMd7m6cnqqKLmqxhyos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742416295; c=relaxed/simple;
	bh=8dSbmv6RUXno2wJjkEPEkGjO99eu0MpD6e+agTv04vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJHr/8IBPRv3cRwawDtP03Y+fJxgDwoAVbcUghtvoIpJ90D8e1WuCg3dZDtVDyi2OaBhrAZez8ana0ktbrCohTt6+VvGLxrA0f7kB22RByxoy6AHokB6P6BUsajKlTxYAXJCpJ+F0yZYExTBkYdWG7mnlrbRJ0ZSqm9zlGllyZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdMiZXcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012C9C4CEE4;
	Wed, 19 Mar 2025 20:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742416295;
	bh=8dSbmv6RUXno2wJjkEPEkGjO99eu0MpD6e+agTv04vE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GdMiZXcUBwYVxbdCg/A4RqfgFZb7QwFmp96v/B5fdXrFMCap6wzgWr+ASfnY71f0R
	 fkEo3oZtjuJFGqnS8TwpPrV/5Q0t3Ccgm4dWUrdWitH6gCIV2+Aua/wyB+sEpdZCXT
	 KWuxYZPGHC+BMll1ksUN70PAuEFsOpXLzRDvhsXeWxXJsL6UD3YMlNIMBd4Yl/rfqy
	 vVdJ1inQ2E3XHGscx79qSVMNx2i/KT5F++PW1pOd4jXDf57xmRFcNknLni7qPsXQKM
	 0bh2eyNsELxhE2mpU+7AR/RiFvDeGF5iVhRAuc3x3vfPbVSr7jv/hfOh1NZnS1Zjnq
	 P40uxgUVCTKOw==
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
Subject: [PATCH 4/4] rust: platform: impl TryFrom<&Device> for &platform::Device
Date: Wed, 19 Mar 2025 21:30:28 +0100
Message-ID: <20250319203112.131959-5-dakr@kernel.org>
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

This allows us to get a &platform::Device from a generic &Device in a safe
way; the conversion fails if the device' bus type does not match with
the platform bus type.

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


