Return-Path: <linux-pci+bounces-24268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8C4A6B0BB
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 23:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5C2484E9A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 22:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D288022AE5D;
	Thu, 20 Mar 2025 22:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSq/oMcD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61F71B422A;
	Thu, 20 Mar 2025 22:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742509716; cv=none; b=YpboVLBGldkvGcbQuooza2RajZo6FQl5eUJ21KltfYEcxMaxKAdBOZIs/cZHS942eltScH4l1a7DzkaQqUk5tEdSlzly1V5gk5/DQeChfWPHINU7d2jlhiefTE2ffRVwMisH1gJ4F6wthKGwCLk3AzCqPpSehgnLnlh9uBnvZJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742509716; c=relaxed/simple;
	bh=SQZafYFP1JrZU2z5rRL7rGUnXA9Ni4v/58cfQdkfXYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGRvz1gdN2noXuYQ8NjDIHaOR81y1x3YRXZS4O8Vv5TxdtlmvN7lzI1vzO+vWI040VcsftC8kBTD2rGCW8KykQUaSTWNClIqSuheaUXMwSaYydJLEJ/ZhaUMg92MJpOgGnu/LX8c2Ngvb6XoUlFs7MbJkY/LsvKKV6rMwPnh9+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSq/oMcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA72C4CEDD;
	Thu, 20 Mar 2025 22:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742509716;
	bh=SQZafYFP1JrZU2z5rRL7rGUnXA9Ni4v/58cfQdkfXYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LSq/oMcDW+enuh/46SbHigMnLYowagFmQYDdPVo8zfcXTE8TUMy4rax0NlGxd3hx4
	 4UTuey/6goNyoOYCEa3D3L2wror774GObVbo7hFlRxfQK7BVLaocRcVtfPypMPTF/S
	 GMn62Og6Jct4tiYa3wcG+1OuftWMBwlcIpaAMuLxfVvWjhP8mJXsSFzptisIE9cnON
	 DSNVIFvBQDfVQT2jIYpDVDAMzGyoSAqG8RsZzMHjF9ETwMr+GDjjULSNvlXap/qFam
	 SCneUP1p7XI1K57kLjhF84agQsDBtxe55yD2MHRoMvjElh8+vaezqO2QJOcZuTO1+7
	 RVEncmCmwp9ww==
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
Subject: [PATCH v2 2/4] rust: device: implement bus_type_raw()
Date: Thu, 20 Mar 2025 23:27:44 +0100
Message-ID: <20250320222823.16509-3-dakr@kernel.org>
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

Implement bus_type_raw(), which returns a raw pointer to the device'
struct bus_type.

This is useful for bus devices, to implement the following trait.

	impl TryFrom<&Device> for &pci::Device

With this a caller can try to get the bus specific device from a generic
device in a safe way. try_from() will only succeed if the generic
device' bus type pointer matches the pointer of the bus' type.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index f6bdc2646028..1b554fdd93e9 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -80,6 +80,16 @@ pub fn parent<'a>(&self) -> Option<&'a Self> {
         }
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


