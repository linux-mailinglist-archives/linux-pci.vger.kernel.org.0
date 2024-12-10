Return-Path: <linux-pci+bounces-18065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957999EBE2A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 23:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FD1162CB2
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 22:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0CC21128B;
	Tue, 10 Dec 2024 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJ9dXppC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7BA211277;
	Tue, 10 Dec 2024 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871031; cv=none; b=h8hhDlFaS5GNHf8AolyD9ySGKOKEvTLfRxlMWS1foqGZUiT6J3SAUnKqBp2L79GOxeUfG0wV54bmygRid973QaB22LoYXF9QV1b2R13lpnFl3F8zOj8sFAvvzVswqDn+N1mgf5PQwCV7AItP0lwfjAlUctX9y5NTxqGoO+QPwbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871031; c=relaxed/simple;
	bh=bUHG0KiegapPYQm9XozqdNYI9p1uQ5GVt8r1LVX4JbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+9X3+QbNjfDVzebpn8BQAi5BDRoy128tTvwDz/4lfhSay5vVSAwq+Cg5iYeefhvqAjCYse+E27g+nR9HXEj9sUghlQnL81DLdWyq5hoydRAnXmH2ufK7Ymc7khjcQPBMwDyotH1vSkXabSMmNuLf8Ve/zh9/Xk1zPVmM6Zd9N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJ9dXppC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AC7C4CEE0;
	Tue, 10 Dec 2024 22:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733871031;
	bh=bUHG0KiegapPYQm9XozqdNYI9p1uQ5GVt8r1LVX4JbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fJ9dXppCT91pshm0qtiiZxCskY9alt00Xd2+BW2AE3OJhNTHNGLOmapR2FBdvZlKo
	 uYLtyDbeQyAq5YX+9aIdKD5/boc0ydhsW/YnHx3H7GI9F7e3aEmoC3XErRP78ZrRtt
	 lBzcoCwfYExUpLnZAFdE//FIfMuoila0mHPLsozSeLMp+DhJJvPpdeAhZ3aFbe0pg8
	 pSkiAH/gjNw/lHzqDcNmG1NWJPPuGxdyO/JlGm5jd6Pff1K4cAxHu7XdHca5NWndUq
	 oYlpkYMUTg/axdF33j/KLFV2lCJXC4QjWRbQLGmMlT+SYmbcIAVrfQn07HWm4pKpNM
	 Wvkdf6KoPhgzA==
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
	chrisi.schrefl@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v5 05/16] rust: types: add `Opaque::pin_init`
Date: Tue, 10 Dec 2024 23:46:32 +0100
Message-ID: <20241210224947.23804-6-dakr@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210224947.23804-1-dakr@kernel.org>
References: <20241210224947.23804-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Analogous to `Opaque::new` add `Opaque::pin_init`, which instead of a
value `T` takes a `PinInit<T>` and returns a `PinInit<Opaque<T>>`.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/types.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index ec6457bb3084..3aea6af9a0bc 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -281,6 +281,17 @@ pub const fn uninit() -> Self {
         }
     }
 
+    /// Create an opaque pin-initializer from the given pin-initializer.
+    pub fn pin_init(slot: impl PinInit<T>) -> impl PinInit<Self> {
+        Self::ffi_init(|ptr: *mut T| {
+            // SAFETY:
+            //   - `ptr` is a valid pointer to uninitialized memory,
+            //   - `slot` is not accessed on error; the call is infallible,
+            //   - `slot` is pinned in memory.
+            let _ = unsafe { init::PinInit::<T>::__pinned_init(slot, ptr) };
+        })
+    }
+
     /// Creates a pin-initializer from the given initializer closure.
     ///
     /// The returned initializer calls the given closure with the pointer to the inner `T` of this
-- 
2.47.0


