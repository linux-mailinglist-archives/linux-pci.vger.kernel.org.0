Return-Path: <linux-pci+bounces-26806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D6AA9DB2B
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 15:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 350CA7A713B
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 13:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A14B1C3BEA;
	Sat, 26 Apr 2025 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zag3MiWr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAE21B81C1;
	Sat, 26 Apr 2025 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745674422; cv=none; b=dzaJ2dTd4WBdGbgsfloOYn485YZnRX5P6418dgnDjVmc0Wpl5zcLhKyzBzCeRVMpIDZjcYISyRZizz0yMxGyX7X18TbX2DTSLpaIAiLUNmJD1JQNABhy2/ADOKv9SEgdTJE+tkxoYgZcZGuLRdr2zSSl5qUTn5uW1wOLoz5X3Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745674422; c=relaxed/simple;
	bh=UW+j65AYZdybdRL+KuUdB/sVtlErJkIEvsNeks47yGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9b1bs8qJDkh7tprfmdi5azz0D2v354ek+53ttHVkdGW1etCqVASsTalV3imdZ3PmCLy4JG0EQWKEsIm8swaur9LpLMcYACT0SjQ3mFKh88odrxPxDI0FHyMEsKrEVxH6/i1K/rEQy7JC+3NuQpXRK+X33C7czH/IJuTA7OVfM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zag3MiWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A222C4CEE2;
	Sat, 26 Apr 2025 13:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745674421;
	bh=UW+j65AYZdybdRL+KuUdB/sVtlErJkIEvsNeks47yGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zag3MiWr0NmzUNNuwkhGufY7DfjrUl2ClThRXYGi/qLuun/Kez9hJBY7urs1YFQ59
	 FhzGoIMYOt/C+M1pZoaH3Dlh3/HDn3X5XKabhKQFk5Ee8QLMAfSE0NakNXumqCnstD
	 Yc5yLZw+ReduCmIWC0VLqf8UEgLdE8NFuyE/p7C6uvmDE2tGjFpysJ6BIsRlpXad/J
	 ODp3Z+2q3C/38fHshVZZaZQNbG1DxlxzuACk1EZenxM/69nc5Fw3F8cdI5CEMpMhJT
	 a9B4YRCq9JxurXkP1bB2PbUe0/P7hyTMmR5ScNXbakzDYCDsZdXC/zP2wAfmgHYw1A
	 MupvNrqWdM4Dw==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	zhiw@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	bskeggs@nvidia.com,
	acurrid@nvidia.com,
	joelagnelf@nvidia.com,
	ttabi@nvidia.com,
	acourbot@nvidia.com,
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
Subject: [PATCH 2/3] rust: devres: implement Devres::access_with()
Date: Sat, 26 Apr 2025 15:30:40 +0200
Message-ID: <20250426133254.61383-3-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250426133254.61383-1-dakr@kernel.org>
References: <20250426133254.61383-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a direct accessor for the data stored within the Devres for
cases where we can proof that we own a reference to a Device<Bound>
(i.e. a bound device) of the same device that was used to create the
corresponding Devres container.

Usually, when accessing the data stored within a Devres container, it is
not clear whether the data has been revoked already due to the device
being unbound and, hence, we have to try whether the access is possible
and subsequently keep holding the RCU read lock for the duration of the
access.

However, when we can proof that we hold a reference to Device<Bound>
matching the device the Devres container has been created with, we can
guarantee that the device is not unbound for the duration of the
lifetime of the Device<Bound> reference and, hence, it is not possible
for the data within the Devres container to be revoked.

Therefore, in this case, we can bypass the atomic check and the RCU read
lock, which is a great optimization and simplification for drivers.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/devres.rs | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 1e58f5d22044..ec2cd9cdda8b 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -181,6 +181,41 @@ pub fn new_foreign_owned(dev: &Device<Bound>, data: T, flags: Flags) -> Result {
 
         Ok(())
     }
+
+    /// Obtain `&'a T`, bypassing the [`Revocable`].
+    ///
+    /// This method allows to directly obtain a `&'a T`, bypassing the [`Revocable`], by presenting
+    /// a `&'a Device<Bound>` of the same [`Device`] this [`Devres`] instance has been created with.
+    ///
+    /// An error is returned if `dev` does not match the same [`Device`] this [`Devres`] instance
+    /// has been created with.
+    ///
+    /// # Example
+    ///
+    /// ```no_run
+    /// # use kernel::{device::Core, devres::Devres, pci};
+    ///
+    /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<0x4>>) -> Result<()> {
+    ///     let bar = devres.access_with(dev.as_ref())?;
+    ///
+    ///     let _ = bar.read32(0x0);
+    ///
+    ///     // might_sleep()
+    ///
+    ///     bar.write32(0x42, 0x0);
+    ///
+    ///     Ok(())
+    /// }
+    pub fn access_with<'s, 'd: 's>(&'s self, dev: &'d Device<Bound>) -> Result<&'s T> {
+        if self.0.dev.as_raw() != dev.as_raw() {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: `dev` being the same device as the device this `Devres` has been created for
+        // proofes that `self.0.data` hasn't been revoked and is guaranteed to not be revoked as
+        // long as `dev` lives; `dev` lives at least as long as `self`.
+        Ok(unsafe { self.deref().access() })
+    }
 }
 
 impl<T> Deref for Devres<T> {
-- 
2.49.0


