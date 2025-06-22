Return-Path: <linux-pci+bounces-30316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D32AE30D5
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 18:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634B91890B9C
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 16:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21201F5834;
	Sun, 22 Jun 2025 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USPwYkms"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B32AE8E;
	Sun, 22 Jun 2025 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750610485; cv=none; b=IzVWXVWAmtMMSicw5PewERddKbcyrWKQG9NCDlh3O36/ebXb/0EvYbDUepopPA1h2IwAgsTUyo5koORk4gfZ3WNSYks+rri8kq8t+02JEASNP6nafqvrPSODm3NNHmdt9o4j/xzXyv8NdVbmdwPyW/Lam7Cw/TjKREsCcfuqH68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750610485; c=relaxed/simple;
	bh=U2lNMOoZ5HlWXq74SYihka3ZDd0webYnAlwntlr3428=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPFrd0Pd2HI3L5Px4JwTR+y0jd0mliHjVVkVN+CZa+f0ZeGk+sLfJpcaWDfrlwqwXam37Ter4pzFQURfbRj8lUYtAQP3kRU7tQZPsg/uNQnx4ysHleThL6nhm9/alnlTPUzXhYMzZBHe0VFAOrkYlMTVyOIoz275PTCtnDx3C6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USPwYkms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C03C4CEF0;
	Sun, 22 Jun 2025 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750610485;
	bh=U2lNMOoZ5HlWXq74SYihka3ZDd0webYnAlwntlr3428=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=USPwYkmsvVqoai+rnv13hTNqXdpyVmFGzCSR5wWewjyWh8FGrEe98vYicD+NmUtMW
	 QYUoiNB/LNfHKnS2z6tLwvFfIHkorXjOFCcWWyHiIbFD1qrx6/kfzuEJRt4Dn//UuZ
	 iuZbzsIwMcGuhMT3u8K2rPy9ix4AoS/ueVJiXNwdXTio9W3tRRyYdNk5yXFVqTGIPw
	 7gSKzTjMP4De8Dn5SXZsuz/K5rlgaY2Ik731+DRklyM/fXIKZF6MnOhdr3M+kp7yJr
	 Zd5xZewo1SkFZ9YA1cJm9ZyagvVnE8xzZ0CuKOS7PG0i5buDxB4uFLrqarNVGdynFd
	 5WLlNwXUcliyQ==
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
Subject: [PATCH v2 1/4] rust: revocable: support fallible PinInit types
Date: Sun, 22 Jun 2025 18:40:38 +0200
Message-ID: <20250622164050.20358-2-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250622164050.20358-1-dakr@kernel.org>
References: <20250622164050.20358-1-dakr@kernel.org>
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


