Return-Path: <linux-pci+bounces-26805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E10DA9DB29
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 15:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88DFF1BC36E0
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 13:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2EA1B87E2;
	Sat, 26 Apr 2025 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDRbVIQW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC672F44;
	Sat, 26 Apr 2025 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745674416; cv=none; b=Ty7zPbaQ6u/HiuM2RraqwzY/VpM5o0pgx0Q3O/SyDl8X15F2xCLMqNj8+RYybFU/r6PMCIZorKwVDY8cWrxR+bpkD4QVzlMwXqvzSHLY1yL8G6qMXIRB8QLP8sKj6Niflm+AZcrmmFTJm/gG5000DMAGGvJcGx53pCPWJZaymG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745674416; c=relaxed/simple;
	bh=xSy/gE7sRWmsVIrx2/LKqUD05Ok0iMNH2/orbll76Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSiWZaa4LJWxrN9ahMioTsQ3T11o+heclzWOKBBeEplqPpaqioj2sqZ41lwK7vbsDRYepVZX33Yj+o1t4uSEnoQVJHe/HLVQnhRpFKYNiTS7K1PlKxYC+HJLGixU0dJXJMNr0APxitvQaPvTQVqlkzXK0Bs/Lkd17gcfXkxyf8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDRbVIQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2747C4CEE2;
	Sat, 26 Apr 2025 13:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745674416;
	bh=xSy/gE7sRWmsVIrx2/LKqUD05Ok0iMNH2/orbll76Sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDRbVIQWjMqQY9K5X1ptTXvtqX+LGm+wf9gsFSbZcFFFtEgotECWMEltSoQ4lTBeE
	 o8ovYHMonR/US9Zvrwjg73lX+qrCzedkWiBm8mBJC3m0yTgMPsjkKsD0cuHSdmus9V
	 7pVb3VU+PCKzpdwjXmvdOPzyUiTh+nmV85WJAcAtpXLzIq5k/CGjGUoqcIPhc9n3Iq
	 iYmE9sl+80ffHpp1x/nbbfgv3tYIdMorenmQMIM0YfbEKA0x5OiL4C70YGxLuEZ1Dk
	 HAp0YaY22pessLyZ4QRJa+a4GcNfsKa956o/8vp1rjkL6YN2k2MGT387ab4xRnQjNN
	 1Q8LCkgDeFTrQ==
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
Subject: [PATCH 1/3] rust: revocable: implement Revocable::access()
Date: Sat, 26 Apr 2025 15:30:39 +0200
Message-ID: <20250426133254.61383-2-dakr@kernel.org>
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

Implement an unsafe direct accessor for the data stored within the
Revocable.

This is useful for cases where we can proof that the data stored within
the Revocable is not and cannot be revoked for the duration of the
lifetime of the returned reference.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
The explicit lifetimes in access() probably don't serve a practical
purpose, but I found them to be useful for documentation purposes.
---
 rust/kernel/revocable.rs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
index 971d0dc38d83..33535de141ce 100644
--- a/rust/kernel/revocable.rs
+++ b/rust/kernel/revocable.rs
@@ -139,6 +139,18 @@ pub fn try_access_with<R, F: FnOnce(&T) -> R>(&self, f: F) -> Option<R> {
         self.try_access().map(|t| f(&*t))
     }
 
+    /// Directly access the revocable wrapped object.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure this [`Revocable`] instance hasn't been revoked and won't be revoked
+    /// for the duration of `'a`.
+    pub unsafe fn access<'a, 's: 'a>(&'s self) -> &'a T {
+        // SAFETY: By the safety requirement of this function it is guaranteed that
+        // `self.data.get()` is a valid pointer to an instance of `T`.
+        unsafe { &*self.data.get() }
+    }
+
     /// # Safety
     ///
     /// Callers must ensure that there are no more concurrent users of the revocable object.
-- 
2.49.0


