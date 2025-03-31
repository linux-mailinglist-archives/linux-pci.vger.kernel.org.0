Return-Path: <linux-pci+bounces-25020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6642A76F48
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 22:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A801887283
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 20:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEA121B9DC;
	Mon, 31 Mar 2025 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIXeGIBW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA2D21A45F;
	Mon, 31 Mar 2025 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452942; cv=none; b=h1yT8AeCQQK793X88vVzZR+xjxEuy1hs/lVKyAGiasANgMKTD+AovfBSXu0cF54NP1DIFhiskPPg+xll0JWJPW0iZxsamYfpvMsbqrohlCnUQsjEVAdZfKH2h/9OWfUMPHeatCYukBxi57upAan5E9bWI+ckkyyVCw1iVftlC4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452942; c=relaxed/simple;
	bh=nxP79RjMxaLT6mWO28gxcx1n2NZPhyKfYT/HHlAu4b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1qBP67nB74laHoM6aK3sJQom0tkHhqJ6mFbhIoXUTMmC3bdGAN7b6sXOFC1qJIEX+eafnF51vQa2gnX/ei1YAEZoGhtFL1Xzqklrdx5eCN1TCMqLbdxEZiGWEZ4a7goGVBQF1WYkn5LBcG+T6rXi7qeH7meUAYIvGYwoftW2Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIXeGIBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1B7C4CEE5;
	Mon, 31 Mar 2025 20:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743452941;
	bh=nxP79RjMxaLT6mWO28gxcx1n2NZPhyKfYT/HHlAu4b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sIXeGIBWSrDXxazYUOOjVsRzWz3VGPhwJLQw7+9DK9AOt6UZaUdbbV2ea2ODgvR6P
	 FMzLwf7QolokWK/ELoXLcdA4edBlriOv+LaKqvotiBQ23CSVvj4Jzmpr99z4tDOACR
	 nLdPyw2VLZSLGd87rwDN1c5pWg2AaTrrj8vokjkkvuLUi/jqyT8GVT63arPmOWw5v6
	 76wV1SIRCp3WgGJnBgPDVrJ4ubY7SToxV1kGq/TNLdlSNwi4Aitw9Lio2dzFuihv1h
	 ofUnoHQDhdwfBJ2A3IPyC6vNr+o0nak2P6Ut94tU1znN4arveZxQM22yRLpH+CaNbg
	 nGNtExxR4Muzw==
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
Subject: [PATCH 3/9] rust: device: implement device context for Device
Date: Mon, 31 Mar 2025 22:27:56 +0200
Message-ID: <20250331202805.338468-4-dakr@kernel.org>
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

Analogous to bus specific device, implement the DeviceContext generic
for generic devices.

This is used for APIs that work with generic devices (such as Devres) to
evaluate the device' context.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 68652ba62b02..2d98e650376e 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -9,7 +9,7 @@
     str::CStr,
     types::{ARef, Opaque},
 };
-use core::{fmt, ptr};
+use core::{fmt, marker::PhantomData, ptr};
 
 #[cfg(CONFIG_PRINTK)]
 use crate::c_str;
@@ -42,7 +42,7 @@
 /// `bindings::device::release` is valid to be called from any thread, hence `ARef<Device>` can be
 /// dropped from any thread.
 #[repr(transparent)]
-pub struct Device(Opaque<bindings::device>);
+pub struct Device<Ctx: DeviceContext = Normal>(Opaque<bindings::device>, PhantomData<Ctx>);
 
 impl Device {
     /// Creates a new reference-counted abstraction instance of an existing `struct device` pointer.
@@ -59,7 +59,9 @@ pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
         // SAFETY: By the safety requirements ptr is valid
         unsafe { Self::as_ref(ptr) }.into()
     }
+}
 
+impl<Ctx: DeviceContext> Device<Ctx> {
     /// Obtain the raw `struct device *`.
     pub(crate) fn as_raw(&self) -> *mut bindings::device {
         self.0.get()
@@ -189,6 +191,9 @@ pub fn property_present(&self, name: &CStr) -> bool {
     }
 }
 
+kernel::impl_device_context_deref!(Device);
+kernel::impl_device_context_into_aref!(Device);
+
 // SAFETY: Instances of `Device` are always reference-counted.
 unsafe impl crate::types::AlwaysRefCounted for Device {
     fn inc_ref(&self) {
-- 
2.49.0


