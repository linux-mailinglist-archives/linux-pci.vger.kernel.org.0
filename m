Return-Path: <linux-pci+bounces-33757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30C5B21175
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 18:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED3B505CDF
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B4D2E2671;
	Mon, 11 Aug 2025 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PBTgwReS"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171B22E2657;
	Mon, 11 Aug 2025 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928251; cv=none; b=UgmAZIPY19C3GFC9rPO1msQM5zspDgh41dt4BQOdrmkPBmZx/FE+xNfRZzNcFy6zBfRZym3kRcicAmOy1Blsfk1qhpMTGigySu9zdHicKxMey59dJSAVhTeisuXA4OuDNOXZSqzCsTo6iY3ui0H19bMD1xnxHBSilAgQYZjZNuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928251; c=relaxed/simple;
	bh=IFTM+cCl1PzcsGLiOvasHfcz6hoVV8pnqOMPQjed5gw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CUXY1zzaTMT6Q6In2w59BeeaJzzLyznnYkPdOV62zFd4pk/z6K78uzmbGNZ2C8VJTM8yI8N93QoKwk314vFT8fNoswFg7SayEEk1iCA5f4bLRXfcV9MNJ/for7wviuctHnKty524ltH3OhWgPpmxWxYRk4aOQ2/zDDv5P7Rsytg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PBTgwReS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754928248;
	bh=IFTM+cCl1PzcsGLiOvasHfcz6hoVV8pnqOMPQjed5gw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PBTgwReSgKRo7S541yW0NkFDWF4l2ETAzctV0cpatDLj4lhyD+WuVlOr5IqgjHjbK
	 Feu92LYC4hTIYjnFOXr+5qiY91quhM86fI3+YCHtAUn3OklfLs5s7Qp+u44Gem47CM
	 5uEFdGziA2lTBspQi9vlVaHNjrgD0P+z05yynZUk8k5JIEzrMqACx+LcLZZbFhL6vN
	 34wrnaxX02gE3I/gT0OBcUsr0PAF3SYKY82nVYrfsj6f1sr88r1JF/U2vw4TgKU3nB
	 Kl1olj8jztNBQ4KlDSkHRBtPfmc98rOBDAo+JjqKkp2sfwDylqnd+xaGIlXZOgfp5J
	 zOpvDDI1i1nyg==
Received: from [192.168.0.23] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2A29417E0286;
	Mon, 11 Aug 2025 18:04:03 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Mon, 11 Aug 2025 13:03:39 -0300
Subject: [PATCH v9 1/7] rust: irq: add irq module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-topics-tyr-request_irq2-v9-1-0485dcd9bcbf@collabora.com>
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
In-Reply-To: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
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
 linux-pci@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>, 
 Dirk Behme <dirk.behme@de.bosch.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

Add the IRQ module. Future patches will then introduce support for IRQ
registrations and handlers.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
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
index ed53169e795c0badf548025a57f946fa18bc73e3..f8db761c5c95fc66e4c55f539b17fca613161ada 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -92,6 +92,7 @@
 pub mod init;
 pub mod io;
 pub mod ioctl;
+pub mod irq;
 pub mod jump_label;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;

-- 
2.50.1


