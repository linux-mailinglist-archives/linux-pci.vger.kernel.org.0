Return-Path: <linux-pci+bounces-18790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D50B9F8114
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 18:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F2F189250E
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 17:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F89C19D8BD;
	Thu, 19 Dec 2024 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CP9kGCJx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E815252D;
	Thu, 19 Dec 2024 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627882; cv=none; b=Iak8rc5icBv7I5g5HANi43tJueU/lUC9wvSiF50Fy5hDgP0P3mv8pnhAt2RvnBcE8CzU+XLSHl9qpBVCGCVt8zmB9u/IpW/BQu89yr9Xms80cFOsHGLjHbsKc32k/2xWxeyDJA7lCqxW2APyOO9qfE4gAeTsLbWDDUz71kBnx5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627882; c=relaxed/simple;
	bh=qnI9EdwsG9kMkRPvMWH3A7l2tEEs2+Fz3s89mI50uEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJqGHN/a4dyIJvpUSJv9H6vNCJCYvaujEEQdm1+Rhq6T9w6bR9bhVUvhUnq7FEdwJsDPD6H1iKr8kN4CDLbWKbOieNF+r6l3r9UudDJu8zTOqeKCIWoyY1G7YzQ4Xu5idOD+oNRJlFgCIq9ivfosK0x7Oaz0NQfRr7ne9Qa5VnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CP9kGCJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367AFC4CED6;
	Thu, 19 Dec 2024 17:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734627881;
	bh=qnI9EdwsG9kMkRPvMWH3A7l2tEEs2+Fz3s89mI50uEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CP9kGCJxcy00iYj/AnT49cuVyY4W78Y33YKlg4/cenRHxHf01NA5sVAEg2sJHcs2Q
	 0CZqDFCKojGJfAXRIILJ59htnH28hUgt0gxV8RJVXXkKWsmOq6LqwME11kXVnkYyyu
	 BiY+Zjby2QE3KBzxnxBK7Ja6DAGJxyLMybCFtpQJttACVQGXVSaEEcxeGAlR0C79Xn
	 X184kF5Ry4sxmG7RScPloAVymYvEOJLGnDIAVLSo0u/uHYTGtWmGseVxNwJSbSQr4Q
	 itC0JrobApiYUmOFdxhlECM4e6W8QfMNk/fcT4ShRJWmJtPyrNxwl6dkcyqJt5eiu+
	 G2MbeH8+0xNgg==
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
Subject: [PATCH v7 01/16] rust: module: add trait `ModuleMetadata`
Date: Thu, 19 Dec 2024 18:04:03 +0100
Message-ID: <20241219170425.12036-2-dakr@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219170425.12036-1-dakr@kernel.org>
References: <20241219170425.12036-1-dakr@kernel.org>
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


