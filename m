Return-Path: <linux-pci+bounces-25023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0823BA76F4F
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 22:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B441D1666CA
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 20:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1624D13C918;
	Mon, 31 Mar 2025 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnSZSNZF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC39521ADC5;
	Mon, 31 Mar 2025 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452957; cv=none; b=jMEAun1p9smZn8zr3U5zT7ig3dghFsyCgzjLt6AgwQ/M7yHeS7uguwy30e7eSxAj6MRdq+GNPPrjOxXldnQvOVjHofUlUOMR2xdfykQdJKJDrNK+CHftFG+MIEyAjdTT1dWQxtq5gPH5pYjFQ5RnSA4uYtvMQcm+CB3PHIGjPvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452957; c=relaxed/simple;
	bh=4LBQYOuKWUMJKxTctedQtQnbNZFRSegEXeOdIXP3acY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOi4/4V+ah91pRmv09JkMyFHRpsIvpU9Xeh3crFSJ0kvUqyYQLTgZQv9Ofr+oDv0saoyIIj9PiVH31wj6U198WyuXHG81p2y5Umcsm4fvUQeXiFyx3LVEBvDXDUYiJOJ58Nj22wntOzPbHgFzxYvI591QX4u4xxzPOEYk2bD2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnSZSNZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAE9C4CEE5;
	Mon, 31 Mar 2025 20:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743452954;
	bh=4LBQYOuKWUMJKxTctedQtQnbNZFRSegEXeOdIXP3acY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PnSZSNZFiPLA+JW4CNZQW+GSBuNbsGx57oQDJaYQQWb4AX+fHsMPh37/lTp7YJoIW
	 fbDl9cD9HxY4LFAvn2W2Cz+NXwWjjYxF9EgdX3cmUyTEitNDx4AowIcmYjTHN8sVdc
	 cUwp3P49l/bIgKpOBu4+ARPSKX2JA0txJLx3zvoho9ecCXkyZACppYEjTqnA7Jl6NL
	 N4Y9UO0Z4nf1wjp6GL8NhDZjsXQRbQIm4AR6SUbzS3Zqeq8eHJzYg6WpaR/1Oj1jnD
	 NnQGU0q6EDofYUNSGwXWSsR+kKJ/8VazrM3736PSxGrvBaV1CAahQI/IrDZh7a9lxD
	 phZ+su4qUzeYg==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
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
Subject: [PATCH 6/9] rust: device: implement Bound device context
Date: Mon, 31 Mar 2025 22:27:59 +0200
Message-ID: <20250331202805.338468-7-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331202805.338468-1-dakr@kernel.org>
References: <20250331202805.338468-1-dakr@kernel.org>
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
 rust/kernel/device.rs | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 2d98e650376e..a7da1519439d 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -230,13 +230,19 @@ pub trait DeviceContext: private::Sealed {}
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
 
@@ -265,7 +271,12 @@ fn deref(&self) -> &Self::Target {
 #[macro_export]
 macro_rules! impl_device_context_deref {
     ($device:tt) => {
-        kernel::__impl_device_context_deref!($crate::device::Core, $crate::device::Normal, $device);
+        kernel::__impl_device_context_deref!($crate::device::Core, $crate::device::Bound, $device);
+        kernel::__impl_device_context_deref!(
+            $crate::device::Bound,
+            $crate::device::Normal,
+            $device
+        );
     };
 }
 
@@ -287,6 +298,7 @@ fn from(dev: &$device<$src>) -> Self {
 macro_rules! impl_device_context_into_aref {
     ($device:tt) => {
         kernel::__impl_device_context_into_aref!($crate::device::Core, $device);
+        kernel::__impl_device_context_into_aref!($crate::device::Bound, $device);
     };
 }
 
-- 
2.49.0


