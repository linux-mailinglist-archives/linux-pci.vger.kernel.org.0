Return-Path: <linux-pci+bounces-24267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044C7A6B0B9
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 23:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E14A1892497
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 22:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAEA22A7FD;
	Thu, 20 Mar 2025 22:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVBKluKi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FED31B422A;
	Thu, 20 Mar 2025 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742509713; cv=none; b=JOBtDWT0R628vxSgbmILluokzkK6ZRkqw3L/rT/Dz/2DouPSQrE5Ywa5sVY/tm6T37Fe5pQZTg4vDGlkzw2IXKc4uwGuemrKum4SoVQorqzn7cUXdfLvbJ43ht22BUrTqXZ8K6aQhAAdl/YJQPfsvVfQkDjHSUOAPEIqJtiq6/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742509713; c=relaxed/simple;
	bh=HhRSRCpXSFmxEsrtP/Su72cgc0XjK9N/nmHPf0AN9A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyH9IszolMeXP3IFhpWjWbNbSYnrVwzsj3tTYbpP9ybz0OhP3RL+dmXyR7HarIp7E6CmFQFostNte8y+E0Ct29a7SsH4g8QKsckjsSkzZUnFw6Bb8FGvw+EeP0Zxd4VqWdpc4Kw2G1xvUNANg4NQYpYRE8OJ+aH5g7rZl5uWu0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVBKluKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3417C4CEE3;
	Thu, 20 Mar 2025 22:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742509712;
	bh=HhRSRCpXSFmxEsrtP/Su72cgc0XjK9N/nmHPf0AN9A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OVBKluKiT6sMtv+Gve8DS0qobblLGUkrPLSIXeU7MIR4BcU9stYxVYPX2gLFpAIqe
	 pe7jZeMikOu6dHKl9TTeYLOngqB2nj3AkVO225liBESTI45PHdTAQt49dyKoHNNMHr
	 ZDuS61/ov3FdkwO3PbX89Eh2lg3BsoeziMSqwOhxpSY/ylRFikkZTNEAMRgTOtkDtb
	 m4k5dma34/V3Ll3F3N/kz+td9vu7g46YtYOlxS1xM9DqZWcmfKpmR9B/lyJvvDJBTX
	 xY88PSgFxvv2bV5d0//2Dpy5yuAULJI5OxmgvPj9tLOLTpLHxV7qGwQscS8YOuKHYL
	 /l4R6+qO7sJvg==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 1/4] rust: device: implement Device::parent()
Date: Thu, 20 Mar 2025 23:27:43 +0100
Message-ID: <20250320222823.16509-2-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320222823.16509-1-dakr@kernel.org>
References: <20250320222823.16509-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device::parent() returns a reference to the device' parent device, if
any.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 21b343a1dc4d..f6bdc2646028 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -65,6 +65,21 @@ pub(crate) fn as_raw(&self) -> *mut bindings::device {
         self.0.get()
     }
 
+    /// Returns a reference to the parent device, if any.
+    pub fn parent<'a>(&self) -> Option<&'a Self> {
+        // SAFETY:
+        // - By the type invariant `self.as_raw()` is always valid.
+        // - The parent device is only ever set at device creation.
+        let parent = unsafe { (*self.as_raw()).parent };
+
+        if parent.is_null() {
+            None
+        } else {
+            // SAFETY: Since `parent` is not NULL, it must be a valid pointer to a `struct device`.
+            Some(unsafe { Self::as_ref(parent) })
+        }
+    }
+
     /// Convert a raw C `struct device` pointer to a `&'a Device`.
     ///
     /// # Safety
-- 
2.48.1


