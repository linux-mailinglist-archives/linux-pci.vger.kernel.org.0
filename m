Return-Path: <linux-pci+bounces-26938-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 719C1A9F30B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 16:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD5A3B4250
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 14:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792EB20CCC8;
	Mon, 28 Apr 2025 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNvwuZpN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9AB156677;
	Mon, 28 Apr 2025 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848911; cv=none; b=a7VbXOOEeYkiYI10droMmNxm0OKL0xhfKPyWbjvQ6fZx9IsqEijvRXQamgMNvnDJV2ybhEgxQtk1nPRpPjf756zsezuObzX5pNb6VBQf75vokMPu1She5aZGWLOdtgDkGemn6T+PMEhePklLHUUyqYcIqSZvi+68HOmrPHmQzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848911; c=relaxed/simple;
	bh=CUjbBsKsU/IXjZc/+tfdQ4SEXR2i4Xv3hgob/3UPMOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5rM9Oxlrry5oHEH/W2OjXux5KVkpNPdsQ/JRpr+KydlUDUuUGwdNNSFoI/r5Z6jPINn7j4jyJntSl5lRbg7yNbClh4EQlcHxq1yn5s2PON7h2VDwBLLgW79/jkGY7YyGerfRlLHwGfGwgaR09DjMIvj6PlvNXcmhkGWttYVdwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNvwuZpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B97C4CEEA;
	Mon, 28 Apr 2025 14:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745848910;
	bh=CUjbBsKsU/IXjZc/+tfdQ4SEXR2i4Xv3hgob/3UPMOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mNvwuZpNdykQnyVoSxc1MCSSI7Y7ycTKp33Zzt5HnYlYQ6RQc+t94MNAY7ItWkwm/
	 2pL9oaAofETHZzPCQe9wr1IAc30+waQW6caJB1Bt8Ee4gCLNAasyxsfxJ5D+j4a5I9
	 6RTo4Io0NvyBGSMyVkyIyp6JAIsGW4aiiWGVSkjcgZZM5LIWW6TGZRmxJ2cHiy58O8
	 UPa1t/+tqUaeNkK+YaOh8Ppuuu7q6DT82mlxKfCq/FK7Z5NQ//6wWrt5GculsCPtyD
	 2ftcFl+uSCMwxzZHXwBfFRYMCxwbOHHRjWwvIOieqczikakCouhhM6twMlreDrGhiU
	 RKc1NjtPMCA1A==
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
Subject: [PATCH v2 1/3] rust: revocable: implement Revocable::access()
Date: Mon, 28 Apr 2025 16:00:27 +0200
Message-ID: <20250428140137.468709-2-dakr@kernel.org>
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

Implement an unsafe direct accessor for the data stored within the
Revocable.

This is useful for cases where we can prove that the data stored within
the Revocable is not and cannot be revoked for the duration of the
lifetime of the returned reference.

Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/revocable.rs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
index 971d0dc38d83..db4aa46bb121 100644
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
+    /// as long as the returned `&T` lives.
+    pub unsafe fn access(&self) -> &T {
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


