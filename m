Return-Path: <linux-pci+bounces-40145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAAAC2E07D
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 21:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA0C934BA42
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 20:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0CA2C08A8;
	Mon,  3 Nov 2025 20:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQT5lMiD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE282C031B;
	Mon,  3 Nov 2025 20:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762201871; cv=none; b=Y4lzhOhMw3XGx3Yi5sn/3Kcvm5Vv0Y+oSAi3dpYpuhe9avn22uWTjP3wLtFR89+jKcS3AYeRZNuRVTryymGiLrJZWyo9cj1KTwzVDxBEV1/JaUTLFnKc62iV/GJPVltyAcfULGSFLtslj1el7FGsL8jD07HrBTsI6bdBz50+csI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762201871; c=relaxed/simple;
	bh=kKVLGobw+B4nvv9hllHZnC0T7iYmdPfD5RAcxYFGWE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaQjAdvhQV/JEJq+xjpUQTThloKivExG2HlQ4pOozLlxVz6W0BqIKttD+cTJoVx3KJl//Ipe+pIwiIghagxnuUu8W79A3yZWBx4u54vwTRnkTONaaJRVotatfQiOKTV7VPJ2yk8kXtlLAgpiV7Iy6kKbaekuWvNf62uXv14N9w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQT5lMiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BB1C16AAE;
	Mon,  3 Nov 2025 20:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762201871;
	bh=kKVLGobw+B4nvv9hllHZnC0T7iYmdPfD5RAcxYFGWE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DQT5lMiD0NHLtIZJMuVS4ULYQ3tHZdRAsyw/qGvExCqhgoPhCvQRxe2AsFxXXvia/
	 7qrI+6/DyCL1euAzvx7E5V6G+tN8s7asGO90w0wwo/jqPSfVsckFVDia2kIGqcQdva
	 uINpBlvrJQtGQan+EXRcSE7PJ8NB9eyTeXTKdWVcwg1XeMoR1vYHQZUsQcuvFyME+J
	 +FiVWP+TVYMA7RTgqINLx/3psvBUgKmyH1Q4OJk7ojiuWKl7pdhMiD78zN4wZdMwOD
	 Uv7lg4OcOVtDLjh1bgm4VKYxqny6GWGs/DTnSs+3sDDQBGNatPsLFVe9szBcRnGwRp
	 K89n9K9UScUIg==
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
Subject: [PATCH 2/2] rust: platform: get rid of redundant Result in IRQ methods
Date: Mon,  3 Nov 2025 21:30:13 +0100
Message-ID: <20251103203053.2348783-2-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103203053.2348783-1-dakr@kernel.org>
References: <20251103203053.2348783-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently request_irq_by_index() returns

        Result<impl PinInit<irq::Registration<T>, Error> + 'a>

which may carry an error in the Result or the initializer; the same is
true for the other IRQ methods.

Use pin_init::pin_init_scope() to get rid of this redundancy.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/platform.rs | 42 ++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 8f7522c4cf89..f4b617c570be 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -301,15 +301,17 @@ pub fn $fn_name<'a, T: irq::$handler_trait + 'static>(
             index: u32,
             name: &'static CStr,
             handler: impl PinInit<T, Error> + 'a,
-        ) -> Result<impl PinInit<irq::$reg_type<T>, Error> + 'a> {
-            let request = self.$request_fn(index)?;
-
-            Ok(irq::$reg_type::<T>::new(
-                request,
-                flags,
-                name,
-                handler,
-            ))
+        ) -> impl PinInit<irq::$reg_type<T>, Error> + 'a {
+            pin_init::pin_init_scope(move || {
+                let request = self.$request_fn(index)?;
+
+                Ok(irq::$reg_type::<T>::new(
+                    request,
+                    flags,
+                    name,
+                    handler,
+                ))
+            })
         }
     };
 }
@@ -325,18 +327,20 @@ macro_rules! define_irq_accessor_by_name {
         pub fn $fn_name<'a, T: irq::$handler_trait + 'static>(
             &'a self,
             flags: irq::Flags,
-            irq_name: &CStr,
+            irq_name: &'a CStr,
             name: &'static CStr,
             handler: impl PinInit<T, Error> + 'a,
-        ) -> Result<impl PinInit<irq::$reg_type<T>, Error> + 'a> {
-            let request = self.$request_fn(irq_name)?;
-
-            Ok(irq::$reg_type::<T>::new(
-                request,
-                flags,
-                name,
-                handler,
-            ))
+        ) -> impl PinInit<irq::$reg_type<T>, Error> + 'a {
+            pin_init::pin_init_scope(move || {
+                let request = self.$request_fn(irq_name)?;
+
+                Ok(irq::$reg_type::<T>::new(
+                    request,
+                    flags,
+                    name,
+                    handler,
+                ))
+            })
         }
     };
 }
-- 
2.51.0


