Return-Path: <linux-pci+bounces-24164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3EDA69A31
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 21:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07AE74680E7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 20:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2FD214A92;
	Wed, 19 Mar 2025 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7k6vKpp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C9510E0;
	Wed, 19 Mar 2025 20:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742416284; cv=none; b=o/x53y355Xgq/lkZOVPRQ/oPiywBdGwBxt+Xu6HCh+VqKnMPXH/lnhILxxsqWD2wL5Se7zZxm+AGHE89RZhMOfl1orh1Yd7vcc3ZaTcPx+jZG5IoW+Z0MyLX4CTbO/DjedjlS4gwCuu1vwDlYdyPUnXS8DLeDp2aNY5Cm92MOgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742416284; c=relaxed/simple;
	bh=7/fXqZFF2VFB4dh0IoJT5tB8cl6kDShPSNOQnvkmn0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtFLzq4bXV2wOwlaVwbBzfpSb4Z71sJ9fRCtN8zCrLH9g50PR8fIOcUx9GuZshiXU/uZINXAzntYWr33sDgebroc7XiWHObCH0S/UyUJZPNcBuafwvQ8Biq6bAtuvxfuhMj4JYhB6YpgwMxEhLYG0Oc/AO2OLOTm0ef2v/ke4gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7k6vKpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244BBC4CEE4;
	Wed, 19 Mar 2025 20:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742416284;
	bh=7/fXqZFF2VFB4dh0IoJT5tB8cl6kDShPSNOQnvkmn0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l7k6vKppXEtsOHWzR8c7uFTnOGUeVfa+ssx5drIrT8f5K/G2TEHQxjKD3TXi27e07
	 jh/Ae3fkA5T1zkDly4foZ+CgS5lyVHUKb9nLlEUHtbbUhonqqvUsjHejXStlo6zCfI
	 ANa7BYf8Gh3cJqBLqYZXduLsSXdts5VgxNX/66mZSKWlzTYRZbMRhpQNGe6y+TFYY8
	 n7ji0+70dmq2FcUq3LPLeTsAvH3KGgJxy/8GjnV6qMTm+PwI0uzaKiqz6sNbVu5doS
	 Udb4F2Iosiw7S8dGMPxNDkoRVOkmkAlPfl1ABdokNR59YEWhbTOjdHemKAyFU15Q+Y
	 dZN26zfOx0VEA==
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
Subject: [PATCH 1/4] rust: device: implement Device::parent()
Date: Wed, 19 Mar 2025 21:30:25 +0100
Message-ID: <20250319203112.131959-2-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319203112.131959-1-dakr@kernel.org>
References: <20250319203112.131959-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device::parent() returns a reference to the device' parent device, if
any.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 21b343a1dc4d..76b341441f3f 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -65,6 +65,19 @@ pub(crate) fn as_raw(&self) -> *mut bindings::device {
         self.0.get()
     }
 
+    /// Returns a reference to the parent device, if any.
+    pub fn parent<'a>(&self) -> Option<&'a Self> {
+        // SAFETY: By the type invariant `self.as_raw()` is always valid.
+        let parent = unsafe { *self.as_raw() }.parent;
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


