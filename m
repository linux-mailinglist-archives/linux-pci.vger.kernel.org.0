Return-Path: <linux-pci+bounces-25759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5BDA87316
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 19:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E1A3BBF30
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB99F1F416A;
	Sun, 13 Apr 2025 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFSym/Vd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A44B1F30C0;
	Sun, 13 Apr 2025 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744565923; cv=none; b=pM3zDARDs99tjUUk2J9U7TG4zmx6AegU1UCWrzCgbvLpEi6Tc3LN32Enf7fz2e0VEMgCCOQ/0BxP6kSPnB4jLT90MFtaGNkT52sM+lc0Z7ZsG6dJERcDHkjjQesB4tzj7Yw8mneTGHKeu4dLCXatZkQ98WXUFFVWrzm3+F8YOmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744565923; c=relaxed/simple;
	bh=qrHamV6jaiuFnZizd0nUtJBmUrT9qGDrGOwrWzjYKZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYeuovL330cl8LntIdqcxau3ktemOnuqZw99tFVTuI9/mB/hRclarEruTEPqs9f0wIV63jcCEgbQoWmabKVtgmJThC4+Z8VDUJ8Ua/L7xByCdi1EtPQ3vOP9EAwOYI11Epsr3tFoA3hBnZcBb67Uzl0K2c9AKpn0wTvtXolpnyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFSym/Vd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6244DC4CEDD;
	Sun, 13 Apr 2025 17:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744565923;
	bh=qrHamV6jaiuFnZizd0nUtJBmUrT9qGDrGOwrWzjYKZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SFSym/VdI/ob8900eqtkABOB8d4ZkcvzWufgWOdEi0lz3GJs2JPj7j3j6TU64/f65
	 S/v4qrAWkFvlYv0opqQMGBM13FJ0jHA84I0n4X7TOrG1uk1FsZwWC9k7QLmRxshp+M
	 /8VidumpMFEWeMVmzqmLdGqiyiVpb2f8z0pSLIgEgDm/iboWwupRSssj5rJQPTD5LV
	 IHeHmB467Q8ZxGdI4ZL9WgvZIMQI4uMpTzJG/81srB+R9/wn2iZX/r6NCJGXu0jQy5
	 PI+EFI6fi+awMiGxpVeDrnmziWUfXkTdFec5uJwghedk+BFtsqCSBMvboDqq8uXIGF
	 u8G7wU4GoU6QQ==
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
Subject: [PATCH v2 9/9] rust: dma: require a bound device
Date: Sun, 13 Apr 2025 19:37:04 +0200
Message-ID: <20250413173758.12068-10-dakr@kernel.org>
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


