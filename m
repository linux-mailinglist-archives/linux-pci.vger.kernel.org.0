Return-Path: <linux-pci+bounces-15048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E5D9AB876
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 23:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1096B22C34
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 21:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472261CCEFE;
	Tue, 22 Oct 2024 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxW0kewj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BD61CBEA6;
	Tue, 22 Oct 2024 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632757; cv=none; b=ILPtzPpBpeIpviZhZbi3rqeM/AhWxpG3TEa3ZPBKv28zd+N0waLYW0vyC3df9avNNIunOtetJLtJzylqqs09P/yRoOtr+WqkZ0oY8wQDi8YLkayM8JUFEwkXdiXcfTyUnUjqIQjUxNtGvdUCQV2/8Rc39V4Om0z9smVbvQeWcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632757; c=relaxed/simple;
	bh=L71CeWkKcTgg8yRMExLlk2AGwztXkb1QDYXmPtLBCvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrEfIgCPfRfGg+hwc2+cVQmhtBWSFKkE52POWwTn7aqQNj0y5n29B65bnb3Dd+YDfvLVsrLUdROWPBaGhtLLr0SJpgzzqly8ATxWv7BkAv3r7c5l3VhFKZ3DdUvZj5a9E6S+jbZnG3cOqgNTiLuSkABaTaqi4HolYII6dM1y7RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxW0kewj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E34DC4CEE3;
	Tue, 22 Oct 2024 21:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729632756;
	bh=L71CeWkKcTgg8yRMExLlk2AGwztXkb1QDYXmPtLBCvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DxW0kewjSPunvZASRyzymLysmqKhXVSiwQMZ/l8zdwRx2ib6ntkP+TYC/G/fcXOty
	 wI7YXG0bzS35faS1Gqcgdiy17oZubE0zAjiQwGPUYuiyXbPV/0TZjQ5fGOQGXgIcsF
	 kM53feURJvfi0/9rRcg9HlgzbyIc+LnsKU7fEBAbrwmER4obZxO9C7QK7bwIXdqWFi
	 qAYXLSzmFdT/SgSQPoj40UZc4z+9k2J1KubnmmZdPtWeD0GY9GcACjnlJaBjfjbLfl
	 cyBkh1TfEk5ZXwYsMCfzYjOyTL26Oo/oHtsyGfWyUfEsq6srKPAx0QOEp47fqyfMk3
	 H+4bcWr3QlEwg==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	tmgross@umich.edu,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	lina@asahilina.net,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	robh@kernel.org,
	daniel.almeida@collabora.com,
	saravanak@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 01/16] rust: init: introduce `Opaque::try_ffi_init`
Date: Tue, 22 Oct 2024 23:31:38 +0200
Message-ID: <20241022213221.2383-2-dakr@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241022213221.2383-1-dakr@kernel.org>
References: <20241022213221.2383-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

This is the same as `Opaque::ffi_init`, but returns a `Result`.

This is used by subsequent patches to implement the FFI init of static
driver structures on registration.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/types.rs | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index ced143600eb1..236e8de5844b 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -239,14 +239,22 @@ pub const fn uninit() -> Self {
     /// uninitialized. Additionally, access to the inner `T` requires `unsafe`, so the caller needs
     /// to verify at that point that the inner value is valid.
     pub fn ffi_init(init_func: impl FnOnce(*mut T)) -> impl PinInit<Self> {
+        Self::try_ffi_init(move |slot| {
+            init_func(slot);
+            Ok(())
+        })
+    }
+
+    /// Similar to [`Self::ffi_init`], except that the closure can fail.
+    ///
+    /// To avoid leaks on failure, the closure must drop any fields it has initialised before the
+    /// failure.
+    pub fn try_ffi_init<E>(
+        init_func: impl FnOnce(*mut T) -> Result<(), E>,
+    ) -> impl PinInit<Self, E> {
         // SAFETY: We contain a `MaybeUninit`, so it is OK for the `init_func` to not fully
         // initialize the `T`.
-        unsafe {
-            init::pin_init_from_closure::<_, ::core::convert::Infallible>(move |slot| {
-                init_func(Self::raw_get(slot));
-                Ok(())
-            })
-        }
+        unsafe { init::pin_init_from_closure(|slot| init_func(Self::raw_get(slot))) }
     }
 
     /// Returns a raw pointer to the opaque data.
-- 
2.46.2


