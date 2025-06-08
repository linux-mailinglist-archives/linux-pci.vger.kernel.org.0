Return-Path: <linux-pci+bounces-29174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9B2AD1564
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 00:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B341167A98
	for <lists+linux-pci@lfdr.de>; Sun,  8 Jun 2025 22:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAB51FBE8A;
	Sun,  8 Jun 2025 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Xy+sYhr/"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14501B040B;
	Sun,  8 Jun 2025 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749423351; cv=pass; b=ff26Mih7YkA2eo8elYsJhHuBoMmvSB49ikEtdSCTeCO736pnZi0o9hp5gR55VgXfxuXYoTuwo2NunSoSV7EocHb/I/MNqN0lhmIH/XiNDts+xvVLPshbSC1vCBU4pCCW3LEjtJ0f6wlxk6rSfUlhoyeJ0iwnCW9EsoQuiYSOo54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749423351; c=relaxed/simple;
	bh=h+SLCJJwf8HMAtNPdD31HJj/cZbgtSA27jC24nkczeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZwYie16Orf7swcHK8IjTzhU7IZOod0IPGseotXbVVoTIC4z45fQohHtDZacC+sUc5GZIFhD/rOiK0Af+zu7yI59uv4CmXn5ny790Cc9kdcud8FYx5QgAV2M7Fl2OhUMQCSrewDwEak4Bc/nmiN+yF8iII+qx95cSBV64rJHmTBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Xy+sYhr/; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749423330; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EoJqMNlIVhjLEe97EGnd/VYGaUh6lND/SjvYjdBaOeIH5QFLHV1l5xXJ8CbH75wB+0Uy7Ne7N9AR+ee78pn136UjI00vDdB/e6GDAQIzjVnNKuKGyCsAgHkPSYJIrIBbzAgUBIV7fxK17lAjnp0g/hg7iSykdm5W+grLjcpyk5E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749423330; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BM8965L3u7JYgx6I7IMt0Zp/Bhc+3KfFO2e8FinR7SE=; 
	b=Q4i8zYWrSM97K4yQeYqv4kQwjMoGwYbIFUZ+7VjQ0lQhPZKeojSM+mMKQajuzP/Rbeniq88Jmcq20+l73iTXlpK7otaE43+E3lZ04IIJPmLSzLZBiHIYcDk7v5a47lZC40DJTE4nvO3KuUddridyssMtM98JKzpFUgoFCYYgYCE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749423330;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=BM8965L3u7JYgx6I7IMt0Zp/Bhc+3KfFO2e8FinR7SE=;
	b=Xy+sYhr/2hIR2ToMaBXtmFx/Toy2tPvw/JIAuUTt9mpUYKHr0IcCZ4gSYyj2UzpJ
	jn6XJVtfFC+9q66yJ02su0CEzI2eNWLQIrn8TBMibc3w9yiKl1NpK3cO/IGihVvJQdG
	OSDGpYqdhJw0PhFLPqQVrIpTjyDxRDd20CrsglGg=
Received: by mx.zohomail.com with SMTPS id 1749423328029560.192805230777;
	Sun, 8 Jun 2025 15:55:28 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Sun, 08 Jun 2025 19:51:06 -0300
Subject: [PATCH v4 1/6] rust: irq: add irq module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250608-topics-tyr-request_irq-v4-1-81cb81fb8073@collabora.com>
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
In-Reply-To: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Benno Lossin <lossin@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-pci@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

Add the IRQ module. Future patches will then introduce support for IRQ
registrations and handlers.

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
index 6b4774b2b1c37f4da1866e993be6230bc6715841..28dd0ef077fa47211fc0eae899ae4ac82fb6be24 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -81,6 +81,7 @@
 pub mod init;
 pub mod io;
 pub mod ioctl;
+pub mod irq;
 pub mod jump_label;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;

-- 
2.49.0


