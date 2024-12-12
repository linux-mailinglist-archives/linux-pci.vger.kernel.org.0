Return-Path: <linux-pci+bounces-18307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330DC9EF272
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 17:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5976F178D7B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 16:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5D522914D;
	Thu, 12 Dec 2024 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci9rbztr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC312288FD;
	Thu, 12 Dec 2024 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021329; cv=none; b=b+BwRNWuc0aO0tsrT5QqNIXfuSwPM4j0KeNC3LORrZ9D5igpVfZKv0+u7MrjRVU+XE6Zv1oCd3a6+wjw0BALVYtSIjg/wHmHCTeS7XspHYsEvkrsWBjVe8K5i2GMlJMxHaK9+ZluD5/0X8CwmmwnsTKl2wBnYaJDZOqiBXyalOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021329; c=relaxed/simple;
	bh=qGSHWpF8AwiVqHzGCBSZ8iAgZfzAVJgvQwZpKGoYuto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uf7mAaZElg0wmShQKD4w9eqf/EUVGX0Y3kcq8hvF20IH6ivGmiC1uVPSphWiyBaEyTD9k4PKL0dgmOGYXQpQr/Zi5W8hZbs5PM0whGi0cgJ1ZYubDHHsLw/QM3rmlNMLA+TVaRudDIlAV3oEXOen5TNuxXPfdFYBqMCZmnZ4YjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci9rbztr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E02AC4CEDD;
	Thu, 12 Dec 2024 16:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734021329;
	bh=qGSHWpF8AwiVqHzGCBSZ8iAgZfzAVJgvQwZpKGoYuto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ci9rbztr7nUJrJ5NBN8lg4lS0o1vpf/lHcfYqM1IC5c0lcucRgBvwvFTO6NGdPxC8
	 2PIX3a6e3U29LK+eHxjuEyL3K7fUwoKtmrqV6pVb5drHDcJnqgCA+f6RvdTlPm71/k
	 tGEPMB7I/YTHXoWys0pC3x1RSKu5W8PUGFcLyJRvQWwmose4TPwQjtS8NCSIfr97XB
	 MiKKLaIU+HSa3gZoH/ZqLvPN/HFSmEo+I6MPKt0aeDk1JdvHHnPEHvrtFNyGSR8aZd
	 DiG3ixnEMI78JZBoq3caeijATXLBWHYH5NKsUU7SOWeQtmFGdqwjQtdFWEfV2Kpy1p
	 QmmO39q+lST6A==
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
Subject: [PATCH v6 05/16] rust: types: add `Opaque::pin_init`
Date: Thu, 12 Dec 2024 17:33:36 +0100
Message-ID: <20241212163357.35934-6-dakr@kernel.org>
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
2.47.1


