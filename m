Return-Path: <linux-pci+bounces-24064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1956A67E9F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 22:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0D14242B9
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 21:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A0F2135A9;
	Tue, 18 Mar 2025 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vqw94kyd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370CC1E1DE6;
	Tue, 18 Mar 2025 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742333392; cv=none; b=TJbiYjAMYnGdLS72XdB9BiAcNzLjmL94FAmDJclfn/t8cFfygrrqnduAUnAIveVudmBBvgYZjihBoFcTS2D8NaPqQ+CekdO+xP9LHyad7eTlCuTCqZfoTPOSpj62PAz10slEVlJ/gsNBFNRbEVXmKQ6FWJpCwOgLoyOQc5tdyTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742333392; c=relaxed/simple;
	bh=kxHGru9iXi3QJL2TwUqd6Z6AcylhUepcUE+J+xfbUoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHHpmK7ZeHzd6XDo75ZndFPdl3kWjVizhdrYg4L/TDgBb+M9lU34rZYZFIxSR5NyS25MES1EPZZk6xLox1hoH/y9nsDS3EZX4whAffVQayM3608bDGMFniNhHsr/UW/dmZyJhKVn21oe4nhXy+CXzmUwICDVI6UrZhFamdWgEtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vqw94kyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80373C4CEF4;
	Tue, 18 Mar 2025 21:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742333391;
	bh=kxHGru9iXi3QJL2TwUqd6Z6AcylhUepcUE+J+xfbUoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vqw94kydYKgry8QLhvshkLFRJ02acjf8TERxmHillAJuNZAYsAIMhg9hl/iTL5Vs2
	 qlkCeiUIMunuXQymkaXYqWmgVDi7jEvG3zXWGeUJO33b03uv4k63krfXPsjd11Qu7Z
	 2VCDKU1sVV7jF5X6kbGw4x39iFM0A114Xuy4yE5o0ZrrpSyhPzKUOkhLyNyug9qsZT
	 ovI9acRan7cqgvziHSwcpQMR/QdSNZsN+h5x1iigLKUJiMDRqWdsLqOAZ5ofX6KdEe
	 FrK8/1luC1uKmUWYHnmfZG433U7uv59yiQ/ZHKdOzSVlzqw50J5V6uw1cOw79udRGH
	 8vHNllrPoZaiw==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
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
Subject: [PATCH 2/2] rust: platform: impl Send + Sync for platform::Device
Date: Tue, 18 Mar 2025 22:29:22 +0100
Message-ID: <20250318212940.137577-2-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318212940.137577-1-dakr@kernel.org>
References: <20250318212940.137577-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4d320e30ee04 ("rust: platform: fix unrestricted &mut
platform::Device") changed the definition of platform::Device and
discarded the implicitly derived Send and Sync traits.

This isn't required by upstream code yet, and hence did not cause any
issues. However, it is relied on by upcoming drivers, hence add it back
in.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/platform.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index c77c9f2e9aea..2811ca53d8b6 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -233,3 +233,10 @@ fn as_ref(&self) -> &device::Device {
         unsafe { device::Device::as_ref(dev) }
     }
 }
+
+// SAFETY: A `Device` is always reference-counted and can be released from any thread.
+unsafe impl Send for Device {}
+
+// SAFETY: `Device` can be shared among threads because all methods of `Device`
+// (i.e. `Device<Normal>) are thread safe.
+unsafe impl Sync for Device {}
-- 
2.48.1


