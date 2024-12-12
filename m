Return-Path: <linux-pci+bounces-18303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EC99EF298
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 17:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B22A188F9C4
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 16:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA40A235C56;
	Thu, 12 Dec 2024 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0JK/dyz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7823226555;
	Thu, 12 Dec 2024 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021299; cv=none; b=D2eUHPtQgsPRVE7ZTdA4o9BWYj2KjDrTQD/KPwZDNHkJQMsE2fHVw5rmpW5BkCsoaQlI28vkbcIpcze8C3SHSmn7NEiESt6EDdzgXHplL54tjbydOenlCx9f/Lvw8aj8XmdJoXQo6PE7sziPu5Jmhcn6XCwMQ+4Xp9iFEu3+kzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021299; c=relaxed/simple;
	bh=qnI9EdwsG9kMkRPvMWH3A7l2tEEs2+Fz3s89mI50uEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FX8Bo6GaXQHGxQbumqoMuBK0sl+KBoy6LMjghLYrLMrS+TWnLxif5YDzc9pBP2GaesgdtMX2ZPwK3hKdDKLqE+3Ru9fyDJICebe+kbDHLYKmqvNTxMnCYDreZsz+MkQkcDsezVaZf51k3UkCc4Hi0pIBN2Bcarf3l5sdaG2mLKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0JK/dyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF02C4CED0;
	Thu, 12 Dec 2024 16:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734021299;
	bh=qnI9EdwsG9kMkRPvMWH3A7l2tEEs2+Fz3s89mI50uEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T0JK/dyzmUprEY8p5NkKPpaYSffbPTefJaMy2enyX+EMt1inLdNNB9iGbVR5E7/zo
	 aOtL7nh+LbEJMuWuqAC1IVTCXKRCvu/nj2ObiH5JFzzy7Ren4qlpdwtzXdbRpw9mUM
	 FCJvlTjJZdKRQ8fmtkjgV+hUoYaDUHNVj07J7lTgYmZsQgQoEZoMGVUMe+F1+xr5DH
	 fEQ4AsJSSnK6Lk7jlvK+q+WRNDx3sr09rq8xQkgQwmxNY19vItbstVQHXLvukPfJIE
	 RVuH4QdVNMczKTh46JJwScawl8+9mDgFzqTagt52MZhnT751PUH6/mhk6+aEwKhCJA
	 IAlZn6X4eNe5Q==
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
	saravanak@google.com,
	dirk.behme@de.bosch.com,
	j@jannau.net,
	fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com,
	paulmck@kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	rcu@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v6 01/16] rust: module: add trait `ModuleMetadata`
Date: Thu, 12 Dec 2024 17:33:32 +0100
Message-ID: <20241212163357.35934-2-dakr@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212163357.35934-1-dakr@kernel.org>
References: <20241212163357.35934-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to access static metadata of a Rust kernel module, add the
`ModuleMetadata` trait.

In particular, this trait provides the name of a Rust kernel module as
specified by the `module!` macro.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/lib.rs    | 6 ++++++
 rust/macros/module.rs | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e1065a7551a3..61b82b78b915 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -116,6 +116,12 @@ fn init(module: &'static ThisModule) -> impl init::PinInit<Self, error::Error> {
     }
 }
 
+/// Metadata attached to a [`Module`] or [`InPlaceModule`].
+pub trait ModuleMetadata {
+    /// The name of the module as specified in the `module!` macro.
+    const NAME: &'static crate::str::CStr;
+}
+
 /// Equivalent to `THIS_MODULE` in the C API.
 ///
 /// C header: [`include/linux/init.h`](srctree/include/linux/init.h)
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 2587f41b0d39..cdf94f4982df 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -228,6 +228,10 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
                 kernel::ThisModule::from_ptr(core::ptr::null_mut())
             }};
 
+            impl kernel::ModuleMetadata for {type_} {{
+                const NAME: &'static kernel::str::CStr = kernel::c_str!(\"{name}\");
+            }}
+
             // Double nested modules, since then nobody can access the public items inside.
             mod __module_init {{
                 mod __module_init {{
-- 
2.47.1


