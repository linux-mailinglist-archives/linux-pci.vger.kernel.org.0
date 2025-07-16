Return-Path: <linux-pci+bounces-32275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7422CB078FE
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 17:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483E24E4146
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 15:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BD9264A7C;
	Wed, 16 Jul 2025 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGnEeUrH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4A720F09C;
	Wed, 16 Jul 2025 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678252; cv=none; b=W1y78VOb+S5GBntdGIk71g4yw49wkI9H6/Vhdek61F38VcUsXhRsMN4tx7s3eiBtdtNzFo5IWkluYfb7dXNnh+FDEfUErszmV/8OuHBWWUdD9A3iqf6mFyp7O2vfWYc3k7CMDk1SYZSUQPjM1sTcvfvGgyGbEminunFUNv1Wesg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678252; c=relaxed/simple;
	bh=8A0P5pFC62KPF2LTzI6kCXSFRrpf1gYMsQRML8Ajos0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rp5I2TZXY8nKHt/c8Y3RiZRKeR1qUFvnPde9nmlyUk+2TZWQzxaF5BlnFr622uxLx2cmwHSUsESahHZ11TOH713PSR9hpoi0pvrVeLaf+xTZ9pzDX9xOMXVPF8ailOyy5IukgSB21PdendZJkxF/GMr1cgBzu3kF03DWGBzhi74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGnEeUrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A47CC4CEE7;
	Wed, 16 Jul 2025 15:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752678251;
	bh=8A0P5pFC62KPF2LTzI6kCXSFRrpf1gYMsQRML8Ajos0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dGnEeUrHSf7tYpBinPj4pTMBZbfmsuN4/JigEEtmTsoGAsJp1nh/hm+2o35eAcWmq
	 fJLNmVKfO2AGxi8SR9zJ8q0TPgxUIfNw/T9/TVz6Ut3hZGVQrPz2CvFIYVetOUqL4U
	 P0Dxy825wNeeO30+90TR3PnoTRgdKVrNoh3ZnV18iQumOdMXkE8s71RSse0QZrtK1F
	 0WydMHonLTLF0k5RgM10j1Wxs5qfrQoXEq//+4+rxkYAlrXUrdbI6qLvnnktd/aT6q
	 9a3NHfRMoZt6FJXy3L80t7De0ODZRnSfSH0PrJMzvH7sbF+QaTJh4dMEqKX/kQAoIa
	 57L2k/vDlhRPw==
From: Danilo Krummrich <dakr@kernel.org>
To: abdiel.janulgue@gmail.com,
	daniel.almeida@collabora.com,
	robin.murphy@arm.com,
	a.hindborg@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 1/5] rust: dma: implement `dma::Device` trait
Date: Wed, 16 Jul 2025 17:02:46 +0200
Message-ID: <20250716150354.51081-2-dakr@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716150354.51081-1-dakr@kernel.org>
References: <20250716150354.51081-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a trait that defines the DMA specific methods of devices.

The `dma::Device` trait is to be implemented by bus device
representations, where the underlying bus is capable of DMA, such as
`pci::Device` or `platform::Device`.

Reviewed-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/dma.rs | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 2ac4c47aeed3..f0af23d08e8d 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -5,14 +5,21 @@
 //! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
 
 use crate::{
-    bindings, build_assert,
-    device::{Bound, Device},
+    bindings, build_assert, device,
+    device::Bound,
     error::code::*,
     error::Result,
     transmute::{AsBytes, FromBytes},
     types::ARef,
 };
 
+/// Trait to be implemented by DMA capable bus devices.
+///
+/// The [`dma::Device`](Device) trait should be implemented by bus specific device representations,
+/// where the underlying bus is DMA capable, such as [`pci::Device`](::kernel::pci::Device) or
+/// [`platform::Device`](::kernel::platform::Device).
+pub trait Device: AsRef<device::Device<Core>> {}
+
 /// Possible attributes associated with a DMA mapping.
 ///
 /// They can be combined with the operators `|`, `&`, and `!`.
@@ -132,7 +139,7 @@ pub mod attrs {
 // Hence, find a way to revoke the device resources of a `CoherentAllocation`, but not the
 // entire `CoherentAllocation` including the allocated memory itself.
 pub struct CoherentAllocation<T: AsBytes + FromBytes> {
-    dev: ARef<Device>,
+    dev: ARef<device::Device>,
     dma_handle: bindings::dma_addr_t,
     count: usize,
     cpu_addr: *mut T,
@@ -154,7 +161,7 @@ impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
     /// # Ok::<(), Error>(()) }
     /// ```
     pub fn alloc_attrs(
-        dev: &Device<Bound>,
+        dev: &device::Device<Bound>,
         count: usize,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
@@ -199,7 +206,7 @@ pub fn alloc_attrs(
     /// Performs the same functionality as [`CoherentAllocation::alloc_attrs`], except the
     /// `dma_attrs` is 0 by default.
     pub fn alloc_coherent(
-        dev: &Device<Bound>,
+        dev: &device::Device<Bound>,
         count: usize,
         gfp_flags: kernel::alloc::Flags,
     ) -> Result<CoherentAllocation<T>> {
-- 
2.50.0


