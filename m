Return-Path: <linux-pci+bounces-23762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB87BA615E7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 17:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47216880638
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 16:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF588204693;
	Fri, 14 Mar 2025 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaCB7CaD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21B7204691;
	Fri, 14 Mar 2025 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968582; cv=none; b=V98eS21AWABtH37oX9caGLSQq2fkOjdUbfR0lp9xczgSPPgjHzIhLpEQHYfJBMQK4aHyGnoCLN5j5EAvJXDzrrxWTKariUNX6WS/WZauSK4BF30xmBSEBqGLBBS/wp7E1lnG7Y8JoYWj7cvPJLwxC8J47wdr2j/ZBXcFMsbTtr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968582; c=relaxed/simple;
	bh=akJ9UD9pTqLZxu203+TWIhfr05IV0kfKDAxe/p6scoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQleSJQc3O//0MR/+lrgTK78DGabLhZ4Y1zlv/hm9x5TPWhz8x2J9z9RPUNElQ+hBPSVy8dRRclF/3yMF+qMGzsx3uKQtxEdE5c3HrUz9D9JskX8gU8+ksM1BE7wTlEEV7/SJWsODWHuECH1RZOwJUkxVULAYgVXNahu24cWJ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaCB7CaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC94C4CEE9;
	Fri, 14 Mar 2025 16:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741968582;
	bh=akJ9UD9pTqLZxu203+TWIhfr05IV0kfKDAxe/p6scoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oaCB7CaD50UW2LPaQBWIcd+2TPa/XrqBNaoL0XepuJVj9f0NGEcMmtt1ZdfdVAPdo
	 734+McUOGv+aGDuuNvcIgynLqhwBdDN6kkPpISJxM2MXH4YUxsYexv0oGI12ngY2GA
	 +NkhTCjoldBsXhqjoiZ6MwcxJDhJ9Y0ztwcjAbE6PKZQ9h3zlpk5/NmNJ4xgfoDqM/
	 x5a7polT8Wwaf9hiC+ALFibDmyNc2F+I0okfZ7RbkAXdP2u1X1ixB6Om6EB+9t3B/u
	 dbSr3QRi9h51l2zPEV6la0ZgDNuA90h2u29dBPB7OfRDWTvvGnVFJfrc83T5HZvRJb
	 UJSWWelwRbnpw==
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
Subject: [PATCH v2 1/4] rust: pci: use to_result() in enable_device_mem()
Date: Fri, 14 Mar 2025 17:09:04 +0100
Message-ID: <20250314160932.100165-2-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314160932.100165-1-dakr@kernel.org>
References: <20250314160932.100165-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify enable_device_mem() by using to_result() to handle the return
value of the corresponding FFI call.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
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


