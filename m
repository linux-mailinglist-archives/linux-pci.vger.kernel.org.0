Return-Path: <linux-pci+bounces-40144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3D1C2E081
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 21:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B169F4EE04D
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 20:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBD526B2AD;
	Mon,  3 Nov 2025 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeQZni9g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4F1DFE26;
	Mon,  3 Nov 2025 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762201867; cv=none; b=out/eDHtNPVWroSr+Mlg/6yOYj6qaUhyis73SOAsijubkoedjAYNAz66GU0sWpxgdy2OwEJmLjad47LI/sOnjz7BYLYvg5WoBMq4DN5jg5ij/ptiIRKG1JXH2yskYCxiz2cP8MlqFDq7fgmWjDoqICDSZMmKgz5oPDG6hbjZtoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762201867; c=relaxed/simple;
	bh=hnILX0v25b0vY5FknnsJUl/uDB2Sg0obKQO5Mq0jSc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EodMWDX7xJI4ISsuHod106XNoC6S/NkyyhXBhljq2mezxNSPKGn7F95X997zN/I/09mi9nMrlcTLVdA4dHtLC4SOs29xC3O+jfEBlwBey55AJi7/AMWzqKpMKQG9YuDpt0KdiKnMnISQbd3kASq/dbgiZEtTJk485qwU9ifnSFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeQZni9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F331AC4CEF8;
	Mon,  3 Nov 2025 20:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762201867;
	bh=hnILX0v25b0vY5FknnsJUl/uDB2Sg0obKQO5Mq0jSc0=;
	h=From:To:Cc:Subject:Date:From;
	b=UeQZni9gnxqtO7kQ7gBXGA8HzmLtNYuOsbTNT2UPVxlc84rJgQM915jWjH4oB6vrA
	 mjoP+Xuhky2daC3xyI9gZeRAOfxoqCSWVIL6HLtAPiTm+5jVpAxJrMiyx/lHLxtIBO
	 KiJ6huDmFNyHT2KQuPJ6vYLwQsUzHhW99kCmP0RSW8wQj6djnHGb5gt75ZNRvgQJ+1
	 ohuOteM7zs91NpqiYDDTbDjw9tRPKBteSaR8a8slhTf0oYoSl4NGACKWePfwm+c9mM
	 Z7T3C6gJc8QlgSDmCgf1eILIqHDJmQuBKQOEH6Ctom21lAZ2BSBNEG+2NfnUxjiGf6
	 jNItPBkjywrsQ==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	kwilczynski@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 1/2] rust: pci: get rid of redundant Result in IRQ methods
Date: Mon,  3 Nov 2025 21:30:12 +0100
Message-ID: <20251103203053.2348783-1-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently request_irq() returns

	Result<impl PinInit<irq::Registration<T>, Error> + 'a>

which may carry an error in the Result or the initializer; the same is
true for request_threaded_irq().

Use pin_init::pin_init_scope() to get rid of this redundancy.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci/irq.rs | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
index 782a524fe11c..03f2de559a8a 100644
--- a/rust/kernel/pci/irq.rs
+++ b/rust/kernel/pci/irq.rs
@@ -175,10 +175,12 @@ pub fn request_irq<'a, T: crate::irq::Handler + 'static>(
         flags: irq::Flags,
         name: &'static CStr,
         handler: impl PinInit<T, Error> + 'a,
-    ) -> Result<impl PinInit<irq::Registration<T>, Error> + 'a> {
-        let request = vector.try_into()?;
+    ) -> impl PinInit<irq::Registration<T>, Error> + 'a {
+        pin_init::pin_init_scope(move || {
+            let request = vector.try_into()?;
 
-        Ok(irq::Registration::<T>::new(request, flags, name, handler))
+            Ok(irq::Registration::<T>::new(request, flags, name, handler))
+        })
     }
 
     /// Returns a [`kernel::irq::ThreadedRegistration`] for the given IRQ vector.
@@ -188,12 +190,14 @@ pub fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'static>(
         flags: irq::Flags,
         name: &'static CStr,
         handler: impl PinInit<T, Error> + 'a,
-    ) -> Result<impl PinInit<irq::ThreadedRegistration<T>, Error> + 'a> {
-        let request = vector.try_into()?;
-
-        Ok(irq::ThreadedRegistration::<T>::new(
-            request, flags, name, handler,
-        ))
+    ) -> impl PinInit<irq::ThreadedRegistration<T>, Error> + 'a {
+        pin_init::pin_init_scope(move || {
+            let request = vector.try_into()?;
+
+            Ok(irq::ThreadedRegistration::<T>::new(
+                request, flags, name, handler,
+            ))
+        })
     }
 
     /// Allocate IRQ vectors for this PCI device with automatic cleanup.
-- 
2.51.0


