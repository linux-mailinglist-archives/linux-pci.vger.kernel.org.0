Return-Path: <linux-pci+bounces-26940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8853FA9F312
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 16:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22371A811EC
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BFE26D4F4;
	Mon, 28 Apr 2025 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKb1YK+z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E043F26B2D6;
	Mon, 28 Apr 2025 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848922; cv=none; b=Zy0WDxYahfXUwNULOtnbp/DoAPhDYafMJnzWa/TrUnkaMBq3PQF/KkKfrwZ17PPFBOemH22Gycn7y55+X/f0LFu0/e1DGQAYTEkgRQWnfQDf5xkqf9XxNmBwaCGRvLxHJ/vz6FMpw9NbpWM1Qrg5+nqdrUK32NCxMjlGKJhuiW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848922; c=relaxed/simple;
	bh=RMj0v7yzxGxIBf2g3qGoGs/WIjraPNY4gUN8Pz9vsVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFFcnTX7lHU17YZ9vkcnLKLm6n6thv58E+cNtTu93RXx+5GbOgsCnv2lEdEqi2fCY/4TB/SlrirhDvicEyWGvqBScQ79TEm0/S10KqLJs8QhaQXgTbWYNedGr0z4Z1kULAe/qwU/rKmPkNrhxa6qDzQcXb7W4JCfv9fuTu5LNlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKb1YK+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953B4C4CEEA;
	Mon, 28 Apr 2025 14:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745848921;
	bh=RMj0v7yzxGxIBf2g3qGoGs/WIjraPNY4gUN8Pz9vsVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kKb1YK+zGe3UVTuzXgx/Y1C8eOIi8UVajcPkDn2bY36hCZliMXhZngY1WL8J68CdG
	 dLB7n48KVFoWNBEUx6S65ssy+VPu5tYMp4YW6sZgh8oc/PHRtX7pIzOMhbxv3Xs0ov
	 B/w3W0+TRRPGZP1rBSXXWfWTR8PP6QxD3yAyklJy9r1QmxTJMI5hGJTJOUDsuu/JAg
	 Ulml5aQFOeH2rh5iRxiygBBstaVm0WGMjHr6V0UInTUu6rLN/2gKxFiv3qX8w5qyyw
	 s7CiE4+F5OVPp+wstQEDdb0GNj622hy7sSotyz//W7xwWxD5DTECDJLe7np7SQnUCu
	 tP/7RThTYMyhw==
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
Subject: [PATCH v2 3/3] samples: rust: pci: take advantage of Devres::access_with()
Date: Mon, 28 Apr 2025 16:00:29 +0200
Message-ID: <20250428140137.468709-4-dakr@kernel.org>
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

For the I/O operations executed from the probe() method, take advantage
of Devres::access_with(), avoiding the atomic check and RCU read lock
required otherwise entirely.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_driver_pci.rs | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 9ce3a7323a16..15147e4401b2 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -83,12 +83,12 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>
             GFP_KERNEL,
         )?;
 
-        let res = drvdata
-            .bar
-            .try_access_with(|b| Self::testdev(info, b))
-            .ok_or(ENXIO)??;
-
-        dev_info!(pdev.as_ref(), "pci-testdev data-match count: {}\n", res);
+        let bar = drvdata.bar.access(pdev.as_ref())?;
+        dev_info!(
+            pdev.as_ref(),
+            "pci-testdev data-match count: {}\n",
+            Self::testdev(info, bar)?
+        );
 
         Ok(drvdata.into())
     }
-- 
2.49.0


