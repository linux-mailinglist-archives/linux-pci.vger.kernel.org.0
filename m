Return-Path: <linux-pci+bounces-30556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AFEAE71C2
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 23:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE19178F30
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 21:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740CD25B314;
	Tue, 24 Jun 2025 21:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2GT07sN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4558F2550A4;
	Tue, 24 Jun 2025 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750802172; cv=none; b=k9EK0lV2tFVftL/G/uu8T/OobvaTUuZDZoX1YcoGekbpZ1ti7meouqh+O4DTeFfj99q1Yrc+nWe+RYF/duks897+qS5j791kchgfxQoXsFpjodpYefdNEZA5kCBLhU0cxFwuV4+4W8zAf8iY3Js5DPbCKNSMtXkAY129gCih8oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750802172; c=relaxed/simple;
	bh=2iMU85xcd+FS2UmQuxpkKbGqhdtchAImhjzX8IQdIV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIa3yPjqxjcKGXl/2Lb2UIQnSt7GitWXwwPWZB7tQ0g/AAE955HqTaMrS6ljJm1zbKeC9SUGSqR6nMZegjSV9LFFOK6shD4tbO/j9PxSSw49VXil5LrWNpqmqNx4edP/ssOBGwXBKzNL8c+Zzrn1RnoZv8J4Vs8v3QVJnMawyyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2GT07sN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22EDC4CEF2;
	Tue, 24 Jun 2025 21:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750802171;
	bh=2iMU85xcd+FS2UmQuxpkKbGqhdtchAImhjzX8IQdIV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m2GT07sNIb6uQupbUfR0mmbAejF5QjJCOLyCoIQI36IJGMY8MVKIg8O9PKTH7dUbj
	 eQpa2qFLACq0US5DEBq1suBADL4yD0VOKqO2bKzC1x3Eh1JnwtqlB0Lk+n5Ckn5pqP
	 fjYlnR3+FamjtbxHA6qmG5dm+rH6NJmUScY/6u7XgR+ofnAaxAtBAUMq5PfOUO++S3
	 yX89CUXrJzNw5m9mAj1X6WzH+YRFlH2g+9Ao+2O0Rp9CHLdJnAaVuwUJ7nJ9Gc5PZ8
	 1PLuY/znG/c6tV/8nWD0TvQXVU+t9c0r33JGCyR52lZnTQL8d4Hr02wyVT75YcsZzD
	 awNhj0MOfD8YA==
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
Subject: [PATCH v3 1/4] rust: revocable: support fallible PinInit types
Date: Tue, 24 Jun 2025 23:53:59 +0200
Message-ID: <20250624215600.221167-2-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624215600.221167-1-dakr@kernel.org>
References: <20250624215600.221167-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, Revocable::new() only supports infallible PinInit
implementations, i.e. impl PinInit<T, Infallible>.

This has been sufficient so far, since users such as Devres do not
support fallibility.

Since this is about to change, make Revocable::new() generic over the
error type E.

Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/devres.rs    | 2 +-
 rust/kernel/revocable.rs | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 57502534d985..544e50efab43 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -100,7 +100,7 @@ struct DevresInner<T> {
 impl<T> DevresInner<T> {
     fn new(dev: &Device<Bound>, data: T, flags: Flags) -> Result<Arc<DevresInner<T>>> {
         let inner = Arc::pin_init(
-            pin_init!( DevresInner {
+            try_pin_init!( DevresInner {
                 dev: dev.into(),
                 callback: Self::devres_callback,
                 data <- Revocable::new(data),
diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
index fa1fd70efa27..46768b374656 100644
--- a/rust/kernel/revocable.rs
+++ b/rust/kernel/revocable.rs
@@ -82,11 +82,11 @@ unsafe impl<T: Sync + Send> Sync for Revocable<T> {}
 
 impl<T> Revocable<T> {
     /// Creates a new revocable instance of the given data.
-    pub fn new(data: impl PinInit<T>) -> impl PinInit<Self> {
-        pin_init!(Self {
+    pub fn new<E>(data: impl PinInit<T, E>) -> impl PinInit<Self, E> {
+        try_pin_init!(Self {
             is_available: AtomicBool::new(true),
             data <- Opaque::pin_init(data),
-        })
+        }? E)
     }
 
     /// Tries to access the revocable wrapped object.
-- 
2.49.0


