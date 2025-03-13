Return-Path: <linux-pci+bounces-23559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A10B1A5E9B5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 03:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD87F7A4818
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 02:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B54139566;
	Thu, 13 Mar 2025 02:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJzMIPiX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A393113790B;
	Thu, 13 Mar 2025 02:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741832257; cv=none; b=HF3mzdks6foDbimv1oCsjwVM2IoiuzcN4kX6MLSwUgFN9mMZT0YhrPjVdYfd3ROW3HTphtFCFRwu+3hpnK686M94duSRuj8kqvaeKdlxdNTytlP0CaVMppjQni2FU47iJrqhKz46euARz2BJ2caR2jZkDiqqS6y3XUWnQJShn2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741832257; c=relaxed/simple;
	bh=HvX+AHLHCHoEnMD4UbcyM9MX38qRT1eA7SvQJ4hOUWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NU5tUkhCv8XdsqQ+uXHtLww1nKe0CfrZ1jn+BU2ZPyS9U0k8JhFqOOYNBvkFcpRNIO/r2b3q7McWKyBSPgtIaN+L10S4VoONoqQ4sFQ2g5Ql4qGdEjeCBHqI1+GrtoEET4KD6i6qraUR+GtjH9mxKrVvqtU9hX7b389OUDs6ZI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJzMIPiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7CCC4CEEF;
	Thu, 13 Mar 2025 02:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741832257;
	bh=HvX+AHLHCHoEnMD4UbcyM9MX38qRT1eA7SvQJ4hOUWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WJzMIPiXqDXBVNj3ZIF+MAt/vHAmDU+T3LeBTd8wwj8l6JBVBc7waQXIeyoPSn420
	 zgkRQLQSUig7Zn/JDS5cRBj7PVsDgqV0gFX6QdJ14UOUx3DrcgyYWdrB+4q7YUj3da
	 Ens5ElD5bPzG9bDaeJ9HZfPcGMzBvE1UQUkrofJwd/NVp5QUlaNN7GXPDkVVEVLBGX
	 bXQz8P6sAQH+Ock5MhJjVqUXQr1wGnXC/BVApzOvPgRS8265juUy1B9Yg6gZIVtyfu
	 TDVR+cn1JhY/+io1vFyj2AICLvwGc7cSIe4RQ6EpDcQaGeoOdJUVSWDysCDcqr4Sw8
	 S8wsg/0fC7K/w==
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
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 1/4] rust: pci: use to_result() in enable_device_mem()
Date: Thu, 13 Mar 2025 03:13:31 +0100
Message-ID: <20250313021550.133041-2-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313021550.133041-1-dakr@kernel.org>
References: <20250313021550.133041-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify enable_device_mem() by using to_result() to handle the return
value of the corresponding FFI call.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 4c98b5b9aa1e..386484dcf36e 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -382,12 +382,7 @@ pub fn device_id(&self) -> u16 {
     /// Enable memory resources for this device.
     pub fn enable_device_mem(&self) -> Result {
         // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
-        let ret = unsafe { bindings::pci_enable_device_mem(self.as_raw()) };
-        if ret != 0 {
-            Err(Error::from_errno(ret))
-        } else {
-            Ok(())
-        }
+        to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()) })
     }
 
     /// Enable bus-mastering for this device.
-- 
2.48.1


