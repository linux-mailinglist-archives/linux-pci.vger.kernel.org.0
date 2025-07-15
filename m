Return-Path: <linux-pci+bounces-32167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA67FB062A9
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 17:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D143B47F6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2BD239E6E;
	Tue, 15 Jul 2025 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oNRBZnTN"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65689231845;
	Tue, 15 Jul 2025 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592623; cv=none; b=K/Wm8hj7Zd7Vx/Hpsp00m/WmfjElaDh9E2I2OUXYwn6QM/GpP/ErG1S0fLYaX1vqz7U6GlovsMx4SOuvjN7vcf1NFYcGqaa5lEXjINiKBd8/FWRzU0il+Shd4ghjdGG1xn728bZuEf3UW9pD/ljJEqek461o363NoxWM8k7aV4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592623; c=relaxed/simple;
	bh=vMjwZKNmLGQQ+e93Bf0Pbs3zIvFyXNewGXBTz3pe6UI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VRTBjZp2vN/hSyIQs5yxBCp6nMTAVcxfiLg9SL4yF79n/fGuKiN8QRlaRPRpoDdV4Wt0qUJ47IXbDDjoW/C69thQ+IurcSNvLft7v/9XXG++E5qKTX+RRSQZUlMDtJ6gqnZjhvhc3jxR0g9zbEAFfunoDC44VfheXWwxuMnR594=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oNRBZnTN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752592619;
	bh=vMjwZKNmLGQQ+e93Bf0Pbs3zIvFyXNewGXBTz3pe6UI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oNRBZnTNwB6jZFvEjta75dQvm3DeH+p+ZUlI/d1pLjnYPIARI7hs1zzHJfwOZl1i/
	 TACqfiBg5iZMd7tkzcJJ19mgpOMFnaHUyX9Ie46vGo42UPIirvfGB3xamS+zMS+vjY
	 6BOJlU+y0Bu84g82YLKx//bfcyS6K2aFzb8HgRolxCd6M7qSTcokgEADlmZag9mwXV
	 UQ/atLjGgSJcwqmS76nqQqOguIYRK3mJpIv6VtCcrj1H747mo+Xm1fDgY1Tuvp5eUF
	 7hkxQwXSW4E9GxKPFd+22TxLf6mp2e2uGbiKo3czCBLQNOFeJZqIPrTY7AWaOHqWgF
	 oc4CpsQ9GThoA==
Received: from [192.168.0.2] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D1A1A17E0D15;
	Tue, 15 Jul 2025 17:16:56 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 15 Jul 2025 12:16:38 -0300
Subject: [PATCH v7 1/6] rust: irq: add irq module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-topics-tyr-request_irq2-v7-1-d469c0f37c07@collabora.com>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
In-Reply-To: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-pci@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

Add the IRQ module. Future patches will then introduce support for IRQ
registrations and handlers.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/irq.rs | 11 +++++++++++
 rust/kernel/lib.rs |  1 +
 2 files changed, 12 insertions(+)

diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
new file mode 100644
index 0000000000000000000000000000000000000000..fae7b15effc80c936d6bffbd5b4150000d6c2898
--- /dev/null
+++ b/rust/kernel/irq.rs
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! IRQ abstractions.
+//!
+//! An IRQ is an interrupt request from a device. It is used to get the CPU's
+//! attention so it can service a hardware event in a timely manner.
+//!
+//! The current abstractions handle IRQ requests and handlers, i.e.: it allows
+//! drivers to register a handler for a given IRQ line.
+//!
+//! C header: [`include/linux/device.h`](srctree/include/linux/interrupt.h)
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 5bbf3627212f0a26d34be0d6c160a370abf1e996..cdc31a89064e2144f1937a1588c460aea5f0ddf8 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -82,6 +82,7 @@
 pub mod init;
 pub mod io;
 pub mod ioctl;
+pub mod irq;
 pub mod jump_label;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;

-- 
2.50.0


