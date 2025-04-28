Return-Path: <linux-pci+bounces-26939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D0DA9F30E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 16:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFECD3B9EA1
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 14:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D809E26C387;
	Mon, 28 Apr 2025 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="id8IA0JP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2B826B2D6;
	Mon, 28 Apr 2025 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848917; cv=none; b=Svaj77cY0GO+eerR+8T9pbo59mKaxCmU9vRWCyQvkj422cxNY02U9ZqT+c/vvG5hjedXTsx9Z6NfvS52Se16ZRbUo28guLdpWKv/LtDGxIzXWNEsJX4tGnCZ2VPhfzjIhPsXf9c3Jk4xET5VcBbTDfpbXAS3bI/Rlu/J8LLKE7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848917; c=relaxed/simple;
	bh=5M8AWy35CAncMHrQE1PZU5bOW2RDloVLDLoTAFvZ3MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aO6HIAtZxR08d+u6626yNKEoFWY6RMiZHI2eVhpbi2x5yGah//LytTqk2NYV7QLoOCGHi9cy7mBHGZ9TeuKYIkz6dfA0gbAyfT874D1YdKRV07H+dNzCsP/zEU12xOs+8SN94GS6CJyG1g7mB2CwRAsI0B9M1CGmWN2+fK7suXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=id8IA0JP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D5DC4CEE4;
	Mon, 28 Apr 2025 14:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745848916;
	bh=5M8AWy35CAncMHrQE1PZU5bOW2RDloVLDLoTAFvZ3MA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=id8IA0JP+++5cZz4RIVLAbb1dShoh3Nm0GaSCXncUuOVlz81ErC1HXtWd+Suk1g9m
	 HUE3DDZ1Vw8xb/XR3aNaFc9YISQ14Jg7fliGaSF2AGIkM1fQYzi21XkNOxH7e2/p1O
	 z/0HHzMrsepWG7+j3Vwt0+zcN92e7CLHkCzPeEHmRmZPA4AibqWiD5gEe1i3SISbc1
	 7hPcfWcbq7NuLDiflZLAe5JE0lKZ05i0f+rNN67oHR7p8CsS8EuRIzO+NrmWkB7QB8
	 HJRwbQej3AV021hXQfjzU0Ih41DqT4Ms6A5oYHOj+Fo4k2Dcrtr45sYs68h1gognBc
	 gMuSy/53r/HgQ==
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
	Danilo Krummrich <dakr@kernel.org>,
	Christian Schrefl <chrisi.schrefl@gmail.com>
Subject: [PATCH v2 2/3] rust: devres: implement Devres::access_with()
Date: Mon, 28 Apr 2025 16:00:28 +0200
Message-ID: <20250428140137.468709-3-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428140137.468709-1-dakr@kernel.org>
References: <20250428140137.468709-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a direct accessor for the data stored within the Devres for
cases where we can prove that we own a reference to a Device<Bound>
(i.e. a bound device) of the same device that was used to create the
corresponding Devres container.

Usually, when accessing the data stored within a Devres container, it is
not clear whether the data has been revoked already due to the device
being unbound and, hence, we have to try whether the access is possible
and subsequently keep holding the RCU read lock for the duration of the
access.

However, when we can prove that we hold a reference to Device<Bound>
matching the device the Devres container has been created with, we can
guarantee that the device is not unbound for the duration of the
lifetime of the Device<Bound> reference and, hence, it is not possible
for the data within the Devres container to be revoked.

Therefore, in this case, we can bypass the atomic check and the RCU read
lock, which is a great optimization and simplification for drivers.

Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/devres.rs | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 1e58f5d22044..cf6fc09b2c05 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -181,6 +181,44 @@ pub fn new_foreign_owned(dev: &Device<Bound>, data: T, flags: Flags) -> Result {
 
         Ok(())
     }
+
+    /// Obtain `&'a T`, bypassing the [`Revocable`].
+    ///
+    /// This method allows to directly obtain a `&'a T`, bypassing the [`Revocable`], by presenting
+    /// a `&'a Device<Bound>` of the same [`Device`] this [`Devres`] instance has been created with.
+    ///
+    /// # Errors
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
+    ///     let bar = devres.access(dev.as_ref())?;
+    ///
+    ///     let _ = bar.read32(0x0);
+    ///
+    ///     // might_sleep()
+    ///
+    ///     bar.write32(0x42, 0x0);
+    ///
+    ///     Ok(())
+    /// }
+    /// ```
+    pub fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a T> {
+        if self.0.dev.as_raw() != dev.as_raw() {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: `dev` being the same device as the device this `Devres` has been created for
+        // proves that `self.0.data` hasn't been revoked and is guaranteed to not be revoked as
+        // long as `dev` lives; `dev` lives at least as long as `self`.
+        Ok(unsafe { self.deref().access() })
+    }
 }
 
 impl<T> Deref for Devres<T> {
-- 
2.49.0


