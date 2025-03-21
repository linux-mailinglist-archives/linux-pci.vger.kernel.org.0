Return-Path: <linux-pci+bounces-24364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1692CA6BDDA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 15:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5FCB7A50DF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 14:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D0D1E47CC;
	Fri, 21 Mar 2025 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGYxR+2G"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10A71E0DD1;
	Fri, 21 Mar 2025 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742569156; cv=none; b=HP3cIVjEylUquJ1UA0CPsdfKe+OcxaIMn4IOZ9kDeZYpFvq3DCxHH2b9jyhJ7yCeL93H4tvDsjNFFB2U5UJ/8RQ3OulB6Vd2gtgDmoPw7tBKJyD/+WWLMh2vRpiuByFZjMUUZKx6tMgoTLzsu7CVtj8cMeHsvZZGUzuH87jtqvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742569156; c=relaxed/simple;
	bh=MKwm/fHil0GDCiiaBpnQB8YlsfUYdX6rYlCKMcY4+DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNNX2Jway4EIRSbr9cFOsY13JTIrsNnsqkUvJDc95SFwy+KJ9iawFDDkpaoyOBtvZzrK4RX6RnA0CjcndmFB8IxuDRA4PqVhZNq0IxCPOFnndNaUCNy3bflYfYY6BhZ3SJ58HDNxhU6wiK5+k2K+rA3QuSdYRrXvqGq9NDG28IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGYxR+2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C64AC4CEEC;
	Fri, 21 Mar 2025 14:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742569156;
	bh=MKwm/fHil0GDCiiaBpnQB8YlsfUYdX6rYlCKMcY4+DY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eGYxR+2GO3Lf2zTwHPHZP2hb+9yCggNXQghPGTGWHb/0YFawnsGhwpfT9NTKKmaa4
	 XNjQ6f2j6xs2eTjc0i+2My5QobvhXAfrtMxMvZ2qCMPxskQIYOJaBlUcK3aXFo31F2
	 CUqlMabLKWHaYgitBAu+1g/PcK4PgRI6BKgy08zX1YmV4dBF2pBqWtoV3EuGTZVgC5
	 xEJzxv/dmQCpcasUP+CV9lR6XF4UPSKFw2JOigYc+ANPKpy+BN1YNXSxHE5L7yD9de
	 OsoQJLVf5thfBq9wouiwgbzqLvk5Sc5lG51R7itCWRyLuX1ZikzRYJHiOgu0Vns53f
	 +1rJ5/wUZPC7Q==
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
Subject: [PATCH v3 1/3] rust: device: implement bus_type_raw()
Date: Fri, 21 Mar 2025 15:57:56 +0100
Message-ID: <20250321145906.3163-2-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321145906.3163-1-dakr@kernel.org>
References: <20250321145906.3163-1-dakr@kernel.org>
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


