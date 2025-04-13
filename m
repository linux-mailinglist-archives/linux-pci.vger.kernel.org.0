Return-Path: <linux-pci+bounces-25756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 287B5A8730C
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 19:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74FDB1893722
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C941F3D50;
	Sun, 13 Apr 2025 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msAHhgy6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A96F1F3BBA;
	Sun, 13 Apr 2025 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744565911; cv=none; b=g2Gk3farAEsSJgZUzx7P34COkRDFKaPzD33KCpd0J6w/EBQhxDijpVbb0C6sKtE0j7my03nQZfcRMThq3iFThUAK8tdIVlNUd9zbG5G8Vg66iIg+4VKpqh4iG+52WV8rwNpHmHe/tNjCMkjiMIt3gh7dZt2P2SoW7c5S/IfmJGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744565911; c=relaxed/simple;
	bh=rK25OVJkr0b3s8LIVrUtyOi++yPYNHI2cdGfCMqMA5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BU8Nk1o4N97mU3LAdaXKoJMGzt0SWvpQpC6Q/AJKvXVFYxadCratvKYhkQZ7+ix/5iUs7RH1grMg4++sGFawbdRTIAY97Xn8YkoL/2ToKBeMyRDZkBnPD7I8D6lMz6CMkc65KMfd4FF40tNlCNrNKBe7du/1D6GScz0/wmelJRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msAHhgy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFF8C4CEE7;
	Sun, 13 Apr 2025 17:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744565910;
	bh=rK25OVJkr0b3s8LIVrUtyOi++yPYNHI2cdGfCMqMA5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=msAHhgy6WB40bIOajhgw3qtYYamXZ5RLmXknsxaC8s7425VFc78lAX9rJZfWsjb1d
	 DD+gDCkF6SZscet4h89ViFUUvhXVgvSry2Li030aningab+hbyCH8mPMyVAdCxS07e
	 uNwaV27p9JVZNP0TWXrXRiIpmENApTWztLZrDJRp09P6k91N06eAzNxNuUW0m1y69A
	 X8Pn4B4PPodR2IzRrb+dt/CU+ngtJLYvyDCUacG47nQyTvHFqKJCzJcscM1XI+xul1
	 JMSfZ3LGuR18GB937IRtvfsAx0AQmtoBuAQW8YlEdlY4jyK4T0U3iKZgIbVwj+SBqX
	 Npvi8vbM9sf5g==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	kwilczynski@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	abdiel.janulgue@gmail.com
Cc: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	robin.murphy@arm.com,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 6/9] rust: device: implement Bound device context
Date: Sun, 13 Apr 2025 19:37:01 +0200
Message-ID: <20250413173758.12068-7-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413173758.12068-1-dakr@kernel.org>
References: <20250413173758.12068-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Bound device context indicates that a device is bound to a driver.
It must be used for APIs that require the device to be bound, such as
Devres or dma::CoherentAllocation.

Implement Bound and add the corresponding Deref hierarchy, as well as the
corresponding ARef conversion for this device context.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 487211842f77..585a3fcfeea3 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -232,13 +232,19 @@ pub trait DeviceContext: private::Sealed {}
 /// any of the bus callbacks, such as `probe()`.
 pub struct Core;
 
+/// The [`Bound`] context is the context of a bus specific device reference when it is guranteed to
+/// be bound for the duration of its lifetime.
+pub struct Bound;
+
 mod private {
     pub trait Sealed {}
 
+    impl Sealed for super::Bound {}
     impl Sealed for super::Core {}
     impl Sealed for super::Normal {}
 }
 
+impl DeviceContext for Bound {}
 impl DeviceContext for Core {}
 impl DeviceContext for Normal {}
 
@@ -281,7 +287,14 @@ macro_rules! impl_device_context_deref {
         // `__impl_device_context_deref!`.
         kernel::__impl_device_context_deref!(unsafe {
             $device,
-            $crate::device::Core => $crate::device::Normal
+            $crate::device::Core => $crate::device::Bound
+        });
+
+        // SAFETY: This macro has the exact same safety requirement as
+        // `__impl_device_context_deref!`.
+        kernel::__impl_device_context_deref!(unsafe {
+            $device,
+            $crate::device::Bound => $crate::device::Normal
         });
     };
 }
@@ -304,6 +317,7 @@ fn from(dev: &$device<$src>) -> Self {
 macro_rules! impl_device_context_into_aref {
     ($device:tt) => {
         kernel::__impl_device_context_into_aref!($crate::device::Core, $device);
+        kernel::__impl_device_context_into_aref!($crate::device::Bound, $device);
     };
 }
 
-- 
2.49.0


