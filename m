Return-Path: <linux-pci+bounces-25026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C093CA76F54
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 22:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3343AB432
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 20:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC072206B6;
	Mon, 31 Mar 2025 20:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/+2mW+y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AEC21A45A;
	Mon, 31 Mar 2025 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452967; cv=none; b=Kc4rGvK3bnfmL/RM9OBqUIjRDXHsjgbzm1pcMt9l8qbDP6zTT/O/qAC6GGsFut+6qThYEwvlJAQ4WG6UCBlnaDRObMGBQLK/dlAV71ISrzWTtKYdWWZP2BdcTYsEIsH/Jki1nbl3/hX2oNXn3osU6QkvVSke6OsPK0brAbdxwTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452967; c=relaxed/simple;
	bh=qrHamV6jaiuFnZizd0nUtJBmUrT9qGDrGOwrWzjYKZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlTeb0q1yHEM3djhEyLyPNYKpMj6hiPAxw73vazrlaFHrCY0V6dMJLRGChja0EhirAhugqrgkuKNJP7EbXyCmbi7QnijWG4fAy18TU7zUyfn2Ark5foWVILp9S61RI/YmPqOvRfqqzdvM7oVQVlRdE32003RvoL3evKcSbAZlmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/+2mW+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E978BC4CEE3;
	Mon, 31 Mar 2025 20:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743452966;
	bh=qrHamV6jaiuFnZizd0nUtJBmUrT9qGDrGOwrWzjYKZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V/+2mW+yHhqtKcbzaLf8i5CXTcfYLBL+PTIhxRRZGHzb4BOGFJ9aqglEbzspXYtjI
	 HrAvqS/s6I5Iqj2zTEq3wuaaRmTFtZptBTsteO+QeKLsfqGSacXfMOKZbb3i+LqDFK
	 MF0/mkSYcQJo7Aapn7w7Oe+t6Bv4Xe01mWXTTNxNyZDvfYygsfuAAcJAUpsFDdSTbS
	 RWyDkCZUDMyCSDnt6b7ltOtHX3oaFQ2kD88ect/O+rgnypaniODdkrFV926IDlIupX
	 dIT9NH/T1rLqugqDRTfi3ZEBF3z6m3G5xh/sFEilLfOWIca/UsGAdP4PAYbZkIWW6p
	 BTraSG5Ob5/7g==
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
Subject: [PATCH 9/9] rust: dma: require a bound device
Date: Mon, 31 Mar 2025 22:28:02 +0200
Message-ID: <20250331202805.338468-10-dakr@kernel.org>
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

Require the Bound device context to be able to create new
dma::CoherentAllocation instances.

DMA memory allocations are only valid to be created for bound devices.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/dma.rs | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 8cdc76043ee7..605e01e35715 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -6,7 +6,7 @@
 
 use crate::{
     bindings, build_assert,
-    device::Device,
+    device::{Bound, Device},
     error::code::*,
     error::Result,
     transmute::{AsBytes, FromBytes},
@@ -22,10 +22,10 @@
 /// # Examples
 ///
 /// ```
-/// use kernel::device::Device;
+/// # use kernel::device::{Bound, Device};
 /// use kernel::dma::{attrs::*, CoherentAllocation};
 ///
-/// # fn test(dev: &Device) -> Result {
+/// # fn test(dev: &Device<Bound>) -> Result {
 /// let attribs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_WARN;
 /// let c: CoherentAllocation<u64> =
 ///     CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL, attribs)?;
@@ -143,16 +143,16 @@ impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
     /// # Examples
     ///
     /// ```
-    /// use kernel::device::Device;
+    /// # use kernel::device::{Bound, Device};
     /// use kernel::dma::{attrs::*, CoherentAllocation};
     ///
-    /// # fn test(dev: &Device) -> Result {
+    /// # fn test(dev: &Device<Bound>) -> Result {
     /// let c: CoherentAllocation<u64> =
     ///     CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL, DMA_ATTR_NO_WARN)?;
     /// # Ok::<(), Error>(()) }
     /// ```
     pub fn alloc_attrs(
-        dev: &Device,
+        dev: &Device<Bound>,
         count: usize,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
@@ -194,7 +194,7 @@ pub fn alloc_attrs(
     /// Performs the same functionality as [`CoherentAllocation::alloc_attrs`], except the
     /// `dma_attrs` is 0 by default.
     pub fn alloc_coherent(
-        dev: &Device,
+        dev: &Device<Bound>,
         count: usize,
         gfp_flags: kernel::alloc::Flags,
     ) -> Result<CoherentAllocation<T>> {
-- 
2.49.0


