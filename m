Return-Path: <linux-pci+bounces-38820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631F8BF3EEB
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 00:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152D3540590
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 22:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39F92F3626;
	Mon, 20 Oct 2025 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsVF+N2V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9462E9EC9;
	Mon, 20 Oct 2025 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999767; cv=none; b=M6KzEYHp+uLkDZs25Ybbtz0LeWTBOTsPlC3gK7Lxwqbfe4AJL4wx9WHBYi++VfBDFnwvxww7H750GQYMMMPI1zFXtCRMajUfKh7y3aNcPbfIEypwGp9nQLEjQ6HMfohfJY5YobXtHE7BbsnASV2X7sKm0XDX5c4mvM3/8k5QE8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999767; c=relaxed/simple;
	bh=1IXPs04K4C82DSjxeOYDUizUYaX914ahcPYa0ZilGgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWxV6pTPhtzArTqotkX1eYldks2JQhm+hfX+FzF4aRJiag7grS4bJXpAJx2aoecBOUSEJyedHIr1FIRSvDHd45OZp444hPNZtybWoJNexT6/xuPTPGTLu9GPVpsr04yt9FgcuZs2JeNydj27tv3+jW6Y3EUbBg5XMhvZjdUEhyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsVF+N2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F08FC4CEFB;
	Mon, 20 Oct 2025 22:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760999766;
	bh=1IXPs04K4C82DSjxeOYDUizUYaX914ahcPYa0ZilGgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TsVF+N2Vm+qNT2bWdZ5cwFFxAJVXjDGQS61hLq2IFJrVInqCtTyK5Kxo4eZfzpM4J
	 y8e99eqMymIDcT/pVVtrI9NL92+zNxYTl1R1R//0vdFyK7XOhIyvOIFTyhaAy+m1RC
	 v2VfHa6a/hjjIo9o/8PO8eaw3X+bp5xBrS7CvubZ9/WHuZhLDLK/ROUaLvE6RAGvsH
	 R1fry9vO+fr/b/tZqVsjRBQTvWJMbhr7lJm916+crRborQNgmFPtL+K9y8eyynSLW+
	 1ZuGUFTyx6rmQFEoVg0a1iwFHtC7MM1OVkkhQ5YdLOOJCeNJeMOFeSfNj0UBbeu13c
	 5GuuytC2Ud5Ag==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	acourbot@nvidia.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	pcolberg@redhat.com
Cc: rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 7/8] samples: rust: auxiliary: misc cleanup of ParentDriver::connect()
Date: Tue, 21 Oct 2025 00:34:29 +0200
Message-ID: <20251020223516.241050-8-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020223516.241050-1-dakr@kernel.org>
References: <20251020223516.241050-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ParentDriver::connect() rename parent to dev, use it for the
dev_info!() call, call pdev.vendor_() directly in the print statement
and remove the unnecessary generic type of Result.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_driver_auxiliary.rs | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 95c552ee9489..a5d67d4d9e83 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -70,16 +70,15 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, E
 }
 
 impl ParentDriver {
-    fn connect(adev: &auxiliary::Device) -> Result<()> {
-        let parent = adev.parent();
-        let pdev: &pci::Device = parent.try_into()?;
+    fn connect(adev: &auxiliary::Device) -> Result {
+        let dev = adev.parent();
+        let pdev: &pci::Device = dev.try_into()?;
 
-        let vendor = pdev.vendor_id();
         dev_info!(
-            adev.as_ref(),
+            dev,
             "Connect auxiliary {} with parent: VendorID={}, DeviceID={:#x}\n",
             adev.id(),
-            vendor,
+            pdev.vendor_id(),
             pdev.device_id()
         );
 
-- 
2.51.0


