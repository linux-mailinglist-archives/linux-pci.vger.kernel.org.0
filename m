Return-Path: <linux-pci+bounces-30821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB38CAEA79C
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBE93A2D69
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013CB2F0E57;
	Thu, 26 Jun 2025 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6XB3FS2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9383203706;
	Thu, 26 Jun 2025 20:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968065; cv=none; b=UHXmZBZuRPMhBH6pgGaPW3a6XQ1LnRUuIqgk+tcdv/hDNCxCAAx7chPIclMmVF2GeehH/a5ccG4dn6IsIDqI9T+npdxFIg+wYjp3fV5BJ5ySnnjLzQP/AjGpe/RInJ/kVFIg9kp/CKXxoE+1m+LF1b2JJuXvyk7RV7E6vq5CB4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968065; c=relaxed/simple;
	bh=HcFaulFtC1Q2YuLQK6Yl9c2cSI0ryIdx5q7fmtmagns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgrOQO4Uz7PlNePjpQ0UGvl5uUkgjoTtMzR8vku7iNbGr+WVlq7MBVXiaJf0BJRu+7s8LbSfkPLYNdmIKXirlffnhQ2IqnWAWQ+yTm4HO8rVlCX/dO5j/FW2cqJv+AKaQIYcqpbwmb+KZnW+iUFJ6fEFAtNVg1ucCtAmjFqRjNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6XB3FS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB9EC4CEEF;
	Thu, 26 Jun 2025 20:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750968065;
	bh=HcFaulFtC1Q2YuLQK6Yl9c2cSI0ryIdx5q7fmtmagns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6XB3FS2RMY1iAqbuo9dNyGQo/k+w5iLHe4q+Pq2ysSCqRUMO6uYk8e47mw1jOtmp
	 wWdO1bdfwlZN/HDNFE3jEUp5QB3OW0Ks44Xu9KUKtodhKDzuH3kIkq24lDXR6NS5IL
	 BX3V1KvXWtIJv4DCkcB4QKGtA8etqbOSpQR9StOwiqhU4r7MflSt8xBEg49rSxwr1f
	 uzA7I77DIsijQcRvMHKIqtqOp+uoiSsubyRiYGadmocUZMa6HcAX5tcfbx9fI+uqWJ
	 R9psKeLKx4CoJBKT8AM2khjTs3o5zCqfGD7y08DDCUEiQmb441TVMFSndvNmNy1YgV
	 aaca3DbQBNbGw==
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
Subject: [PATCH v4 1/5] rust: revocable: support fallible PinInit types
Date: Thu, 26 Jun 2025 22:00:39 +0200
Message-ID: <20250626200054.243480-2-dakr@kernel.org>
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
index 8ede607414fd..fd8b75aa03bc 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -100,7 +100,7 @@ struct DevresInner<T: Send> {
 impl<T: Send> DevresInner<T> {
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


