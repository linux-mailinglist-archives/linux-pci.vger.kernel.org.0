Return-Path: <linux-pci+bounces-30308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63755AE2BE8
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 21:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEDC8189AAA0
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 19:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED68271457;
	Sat, 21 Jun 2025 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEE+9IDW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37A4271456;
	Sat, 21 Jun 2025 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750535522; cv=none; b=qCo9nT9oayIhc01GCbvHKuDo1ecOLrMz2BmxHiDZaEclmKq/klfTiK227iY1pZYaP+3txLsIqNZdpnLE9VDfCeQCXOej5MAnpv+GR7SAnrmG9IIFFU2Rh0Ao9JCrN5aXpYh0W8U0uwNbmcq9fSD3yaTTwbcDapn5mNqvivkrkpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750535522; c=relaxed/simple;
	bh=LVDt14mBWg0lELVOCK+Hfq1+W2xSKm8S17ORApwzmbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ky36cVnmpry2As+G4BvBJs2tHSG2OBl0DWez+nNOdSD1eGkYhc2XU8ZAmmbU9JHKNCGK/fbQUX8sZfB9VlIK9Bj1sNb9nCuwowsmRFjhsxaPSZP9mPyl13pEZsqMMuTlw+z3qTmknLsOpYY5ixhw72GrlvLxM5bUs9yQxYalvDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEE+9IDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8240FC4CEF0;
	Sat, 21 Jun 2025 19:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750535522;
	bh=LVDt14mBWg0lELVOCK+Hfq1+W2xSKm8S17ORApwzmbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SEE+9IDWJ72u5ssBPS95FTKmADMfXy0b452Dg/nJqpTdPRg/21rvdMVni0ofQJb1q
	 RptHe1Wa2D6vKl8ibFPgTC0YILGokbANMno5oiRmTcjPqWuMe9mXnIZBfiB8Xhlim7
	 /ijPOUCS+gUYGuxM3rioSfnzGNO6gJF/Q2ppl8YhS9zBnbISw/E2y2hPkrUEz7ly3E
	 w9vG4X36rgeTb/04aZrwnjR2QPOp5iEBaA9Udz2eSRujxxr+vlxFruffJh8mYbWo/e
	 7QzWhrEcgGlCz3CEYzMGPQ3YNyuMuwX20rofpLmRwJrBLEeY4NDburiMx1funvqq6N
	 x6iftko7HcjhA==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 8/8] samples: rust: pci: reset pci-testdev in unbind()
Date: Sat, 21 Jun 2025 21:43:34 +0200
Message-ID: <20250621195118.124245-9-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250621195118.124245-1-dakr@kernel.org>
References: <20250621195118.124245-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reset the pci-testdev when the driver is unbound from its device.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_driver_pci.rs | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 15147e4401b2..062a242f8874 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -18,7 +18,7 @@ impl Regs {
 
 type Bar0 = pci::Bar<{ Regs::END }>;
 
-#[derive(Debug)]
+#[derive(Copy, Clone, Debug)]
 struct TestIndex(u8);
 
 impl TestIndex {
@@ -28,6 +28,7 @@ impl TestIndex {
 struct SampleDriver {
     pdev: ARef<pci::Device>,
     bar: Devres<Bar0>,
+    index: TestIndex,
 }
 
 kernel::pci_device_table!(
@@ -79,6 +80,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>
             Self {
                 pdev: pdev.into(),
                 bar,
+                index: *info,
             },
             GFP_KERNEL,
         )?;
@@ -92,6 +94,13 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>
 
         Ok(drvdata.into())
     }
+
+    fn unbind(pdev: &pci::Device<Core>, this: Pin<&Self>) {
+        if let Ok(bar) = this.bar.access(pdev.as_ref()) {
+            // Reset pci-testdev by writing a new test index.
+            bar.write8(this.index.0, Regs::TEST);
+        }
+    }
 }
 
 impl Drop for SampleDriver {
-- 
2.49.0


