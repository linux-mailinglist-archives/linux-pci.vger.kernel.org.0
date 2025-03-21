Return-Path: <linux-pci+bounces-24410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E821A6C56D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 22:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB643BBCF0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 21:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B808233729;
	Fri, 21 Mar 2025 21:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErGzGUeW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212DE233725;
	Fri, 21 Mar 2025 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742593717; cv=none; b=uq7AdFjr0eWxSq2TK9dgxmx5uRXWwHCVFbgdR51mkQlQvxLaAWaflX5PDfzKtyCJ6woG1EnrsDEOaIN0to0UAmg2n7Sx+HTI8Hq6gZWxCr/xfgop2CqDzSVSytfuyTjh+mnmTAbfiuxOVhQ+O4eHCQH3ii47DrxhjsoP4lPrsIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742593717; c=relaxed/simple;
	bh=MKwm/fHil0GDCiiaBpnQB8YlsfUYdX6rYlCKMcY4+DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EA3UUjlTCSkkBISbnpVQjfTKEO5RVTvrvQRyCvfwBWzuqYIGvKvCQ1fJvK30VEGGjX/cjQKhQWQLmR/5u7tGCIlXA+nkHxWsmiGgtTotRRb7fV29fahx4kDvnQnzgRzshYj+eT/4ULBLYtDfEYbnSZAljaXdC8DRee6kuUhFR4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErGzGUeW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E7EC4CEEA;
	Fri, 21 Mar 2025 21:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742593716;
	bh=MKwm/fHil0GDCiiaBpnQB8YlsfUYdX6rYlCKMcY4+DY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ErGzGUeWHbq+jsK4mK0XixzZvRI8yW42+Q7dZbFSRUa6/P11+KQNUAQuYEjf1QoaJ
	 PuQVkND+QgmP0jUk4K+lKzjLZ5eqvHwpJE0Si77vKqr2yaPL844mma6AGcXAV1sL2f
	 G8OGC9AiGQReDTO10zROrYzjlBFfnCZrTVakzCrRX+rbId6c9t55TRqqGkkD9qlOax
	 JQE0SvrPctCwIsVQ8ralYer+ZPBpe0YoQATM/HLx30Rrx5QZv1+bs8iXxP6ttbDDby
	 ieFe2tI1XTNYgnRY4Sqak28E3XR2CwS86UsmVTf8edXStpNXAq2gyidX/TO0ANRitE
	 axiu3jYaMMERQ==
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
Subject: [PATCH v4 1/3] rust: device: implement bus_type_raw()
Date: Fri, 21 Mar 2025 22:47:53 +0100
Message-ID: <20250321214826.140946-2-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321214826.140946-1-dakr@kernel.org>
References: <20250321214826.140946-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement bus_type_raw(), which returns a raw pointer to the device'
struct bus_type.

This is useful for bus devices, to implement the following trait.

	impl TryFrom<&Device> for &pci::Device

With this a caller can try to get the bus specific device from a generic
device in a safe way. try_from() will only succeed if the generic
device' bus type pointer matches the pointer of the bus' type.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 21b343a1dc4d..67a2fc46cf4c 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -65,6 +65,16 @@ pub(crate) fn as_raw(&self) -> *mut bindings::device {
         self.0.get()
     }
 
+    /// Returns a raw pointer to the device' bus type.
+    #[expect(unused)]
+    pub(crate) fn bus_type_raw(&self) -> *const bindings::bus_type {
+        // SAFETY:
+        // - By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
+        // - `dev->bus` is a pointer to a `const struct bus_type`, which is only ever set at device
+        //    creation.
+        unsafe { (*self.as_raw()).bus }
+    }
+
     /// Convert a raw C `struct device` pointer to a `&'a Device`.
     ///
     /// # Safety
-- 
2.48.1


