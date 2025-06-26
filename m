Return-Path: <linux-pci+bounces-30824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F884AEA7A1
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55481C45297
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA3B2F271C;
	Thu, 26 Jun 2025 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv1356gN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5E62F0E32;
	Thu, 26 Jun 2025 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968079; cv=none; b=m3YP6JRQ4gFx/e7AuyPz5AtNZsqeZKCA3QsyP2+w0AzzPsDH5x40X9+kCY62KZQDMi+oA1Wgw2dLeCH5Fbt50jXsttEM7j6MiEDdzSVuV5voVmKQ+yubIS010WgVSOL3747CxiJ4BsLnIYxPxKvPXg/x3Qz+KJnWqoMEI0SeGDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968079; c=relaxed/simple;
	bh=IwBkUuZuKXf37LiSFQBM34dVIoN+RIBZCvqe+2DZasM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8t1QDLfkJ/ACYJhaOzCfjmWwSwbLCIsaEpIPrfO6pgG9oV+3kR0/x7yLB7L91QaHeCu9UFAwhOvEosOSXD3GYHz6IPdLR3To8Mn4pa4+46MqvURsV8lrphj2ReiTVmFSbLW0vEqakl50o1xSNUEBKUPwIM1sNr9GXlltOYdms8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rv1356gN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFA3C4CEF1;
	Thu, 26 Jun 2025 20:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750968079;
	bh=IwBkUuZuKXf37LiSFQBM34dVIoN+RIBZCvqe+2DZasM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rv1356gND7vpbgjlLg24OkT1wrnzKTeomeh3ymunNL2eqqUGZXbD7k7aKWi1URiSf
	 5F9cmAWwanzvQ73RC539FM2QwstBkUgWgvB+6cD36U+g3t7wUcZUE7gpjrCKyRcX73
	 rbqJ8Y3iyiG8IryrEo6cARiH762Qa3tvzaQwBai1TiGiTnD0/bAfRRslzflvD4n28U
	 gDd7ij2A+61NbfAO5S0EHL7SNM6sTew02r6oKpWMUIpmTaSjcRLSyrqKOLHARFlW8n
	 TYsknfDFK71jp9I8aVu9408R/1997RXjco8vIMkvNezyjdYZG/W9TrH2U5+5rX6NnT
	 +t1QrxWdABXSg==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v4 4/5] rust: types: ForeignOwnable: Add type Target
Date: Thu, 26 Jun 2025 22:00:42 +0200
Message-ID: <20250626200054.243480-5-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626200054.243480-1-dakr@kernel.org>
References: <20250626200054.243480-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ForeignOwnable::Target defines the payload data of a ForeignOwnable. For
Arc<T> for instance, ForeignOwnable::Target would just be T.

This is useful for cases where a trait bound is required on the target
type of the ForeignOwnable. For instance:

	fn example<P>(data: P)
	   where
	      P: ForeignOwnable,
	      P::Target: MyTrait,
	{}

Suggested-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc/kbox.rs | 2 ++
 rust/kernel/sync/arc.rs   | 1 +
 rust/kernel/types.rs      | 4 ++++
 3 files changed, 7 insertions(+)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index c386ff771d50..66fad9777567 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -403,6 +403,7 @@ unsafe impl<T: 'static, A> ForeignOwnable for Box<T, A>
 where
     A: Allocator,
 {
+    type Target = T;
     type PointedTo = T;
     type Borrowed<'a> = &'a T;
     type BorrowedMut<'a> = &'a mut T;
@@ -435,6 +436,7 @@ unsafe impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
 where
     A: Allocator,
 {
+    type Target = T;
     type PointedTo = T;
     type Borrowed<'a> = Pin<&'a T>;
     type BorrowedMut<'a> = Pin<&'a mut T>;
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index c7af0aa48a0a..24fb63597d35 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -374,6 +374,7 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
 
 // SAFETY: The `into_foreign` function returns a pointer that is well-aligned.
 unsafe impl<T: 'static> ForeignOwnable for Arc<T> {
+    type Target = T;
     type PointedTo = ArcInner<T>;
     type Borrowed<'a> = ArcBorrow<'a, T>;
     type BorrowedMut<'a> = Self::Borrowed<'a>;
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 3958a5f44d56..74c787b352a9 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -27,6 +27,9 @@
 /// [`into_foreign`]: Self::into_foreign
 /// [`PointedTo`]: Self::PointedTo
 pub unsafe trait ForeignOwnable: Sized {
+    /// The payload type of the foreign-owned value.
+    type Target;
+
     /// Type used when the value is foreign-owned. In practical terms only defines the alignment of
     /// the pointer.
     type PointedTo;
@@ -128,6 +131,7 @@ unsafe fn try_from_foreign(ptr: *mut Self::PointedTo) -> Option<Self> {
 
 // SAFETY: The `into_foreign` function returns a pointer that is dangling, but well-aligned.
 unsafe impl ForeignOwnable for () {
+    type Target = ();
     type PointedTo = ();
     type Borrowed<'a> = ();
     type BorrowedMut<'a> = ();
-- 
2.49.0


