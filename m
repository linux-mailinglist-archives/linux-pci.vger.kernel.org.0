Return-Path: <linux-pci+bounces-18794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 147CF9F811D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 18:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB29167382
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 17:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF8019F43B;
	Thu, 19 Dec 2024 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9i2Cceu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D4B1990B7;
	Thu, 19 Dec 2024 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627909; cv=none; b=sp7wyH5pn5d5PI/XPzZssh7Ffk1inFwexYJJi+YJKCX8Ep5kFdZY3L6v8TKndWUhOAde62TcV6uMWaU43h328SWcJsfCgEN4Tl2ImSVpsmVYyr46KtTj8n1vDjbyZJPBnlGusPQ6GQFGQMgDiN1kel2eHUux3aKA0vkB2DL+WCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627909; c=relaxed/simple;
	bh=69hWLiyjD6Myi2ieGy4epCECplKr7dvq19o0ps311zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucNB4ZO2VtIwsqaBJGAgdatIgqJcwtINNnz8RW/E2pUFl5wxjoIgdYeTOXM8lXEatVoFRJA/i81nWWuSnLuNVNzEdSV2HMb7PfJl7tnlC5YGZHhTR5xAWegvSBpQpkWknU/uG2xZOSAABu6BaIBxRwGzDe/bukWotevQdbdbIIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9i2Cceu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CE2C4CED4;
	Thu, 19 Dec 2024 17:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734627908;
	bh=69hWLiyjD6Myi2ieGy4epCECplKr7dvq19o0ps311zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S9i2CceulVzRth4QDCkzrxTOLnRCjsO0fd1PKPACF1LmzbrSq6l/Re4Nbi7MNBZTt
	 vKRsOGG3UJ8TmSm0TDVT7GMx0oyGntAVbQtt22kL0VzkTzO/yeCbcIluXnsR+dhv0C
	 6qA6JInGvSa0P1D1VmWbwEMY8FhoLZ9WrT9ojhYqDJGOt4nBGZlIBPhOZBPfAoKF2/
	 ti7V6r/xj4m3obg+Mgt+2fpIKQX0wjQllmDoqDu36JQTSpjJgRAlIhYeEXGYCGRDKf
	 FzmZVwGr28xxVqO9S3J1vWE9cMoUae/GcGjF1+akTuSiWgNFdXty6MvGvTFNpTtXxK
	 HCEmXtPSePNng==
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
Subject: [PATCH v7 05/16] rust: types: add `Opaque::pin_init`
Date: Thu, 19 Dec 2024 18:04:07 +0100
Message-ID: <20241219170425.12036-6-dakr@kernel.org>
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

Analogous to `Opaque::new` add `Opaque::pin_init`, which instead of a
value `T` takes a `PinInit<T>` and returns a `PinInit<Opaque<T>>`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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
2.47.1


