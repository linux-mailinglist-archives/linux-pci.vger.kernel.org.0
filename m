Return-Path: <linux-pci+bounces-31885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60044B00C40
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 21:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCDC541785
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 19:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B292FCE14;
	Thu, 10 Jul 2025 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9Wp6tm8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACB328981F;
	Thu, 10 Jul 2025 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752176772; cv=none; b=R72s9vAXlVnNo326+9TmcCEQFq15jR3Lj8ecqxJ6kxPVirJ2B9gqUWJGR3oh11gida9vLOmSxJIwyYOINAXjK4dX7hmo3Ue2gsFR+Xy2Mv8b6nPQQXElNEWSGAgU0Cfn5rd6NSJ2YYceKJd/68/ugDz6yfdwKe1nANuhHsGp7SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752176772; c=relaxed/simple;
	bh=9xIivPcMtqd4qQG4/znTLHx40UFibLjJ9Qa4eYva2FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grxHf62uCm4/k9dpcT1tCVvcr0viq67e1oqP1UuKHp7FVUpyQo5mrbz4gYYH79/aeBxhIFBQioThQj3iVO1fD5o4zN+E7la3B7oIXf3NEPIQwIRaM+dTYYePwjZZsMI6mP4Z6Tr8/JbpD4EkeUV9JDiNqcJ3wMl1F2WICcXIoQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9Wp6tm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2746C4CEF4;
	Thu, 10 Jul 2025 19:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752176772;
	bh=9xIivPcMtqd4qQG4/znTLHx40UFibLjJ9Qa4eYva2FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R9Wp6tm8cJCLCLczFBOXD3PJNewmSR3DzcFspxVEMYFq+xjuLm4Cro4Fmijyizvaq
	 7D8DyLkNIQ3I9RjM6ZfNqxxFYdpnHHGCcPKg93kNrJ57ni1bySy6SoVkK2Fer/Izbe
	 rNDrs56P60a3K4A4OraqZ04cLW/PNy7i0bU/L2DUwhEACkq1GB0Jc7Fsy48ndHOaXf
	 I6xc3txd+82EptIAuoISJA0/j6uEAAe9YVwBSAqgV2m1Qn6MJRbAamrwiLiBONmWmJ
	 /7ze5otREOvHCj3qa2IQNzu8H1ps6W2Zl4ns7oUMZ1m5v71rXgIeanERBJuHKUITnK
	 4VuQ/dtTTIM1Q==
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
Subject: [PATCH 1/5] rust: dma: implement `dma::Device` trait
Date: Thu, 10 Jul 2025 21:45:43 +0200
Message-ID: <20250710194556.62605-2-dakr@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710194556.62605-1-dakr@kernel.org>
References: <20250710194556.62605-1-dakr@kernel.org>
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


