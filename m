Return-Path: <linux-pci+bounces-30941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EC1AEBD11
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 18:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2E797B516A
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 16:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6382E9EDF;
	Fri, 27 Jun 2025 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="kSbvSdQB"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199EF2D3EFA;
	Fri, 27 Jun 2025 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041330; cv=pass; b=Zc6TunhHeo8voUpr/tufu0jLXtoGsFTdgcb6Tqyz89xXI80/kNsHElKBT7dkRMaC6wPhK4dHlSKeyFSbG9V9OyCuuYL5G4TBNmNKIWfpS+fliFX9VirroXeXtUZKhP37GzLbjbG1Ilu3beSoPyowzyZQE/BLQ+MhHG/TJGT7weY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041330; c=relaxed/simple;
	bh=aEMkXvUthUB8l3Ze03TQRSrmmhr7dlle2OHZ3th5mnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r+Mkg9RftQJ76Bit9Bj97G++KyjsFg34vc2JMG3n4yi4YkWKMUTGzq6nECLKRrP5IvjHsSqE3qzjJwuEFyyAdtsklMItK7Eb49pGYsvDpi1nvUW16Za4uclMaM1ibG22jmGloglN9noPfB5rQ9SqHGYq7aTPwrhbIfAFbopQMVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=kSbvSdQB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751041295; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aHI2MeTlFnNzSo7CFpMiOLuw7trvYJFSOFVXU6I8Kax7opliYG29fVzRj6KVPs/124kAd8EeFXS+Bpz2XU3UN5Q5VMmm4+qWbPPnrjdY3yKTGzUPW3QvYFAWpnH6/MlsZz1CVUMSpeiikh5nck6V9zskAa3NHki3TaN6C0VxHzo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751041295; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gfN2hhL3lfXYyJIhQf1mFRJtLEy5tuC2aFyzf06oeU0=; 
	b=m2a4kSCzmCQIdTYYrlM+f1uc+dXqn7CzRirHDbVaqjmgIytDCoQC+XAPYqpRppubUD5X8qdszs4D2HUnMM6kzAkcVI6qyWVzI2MBfbtiiTt5M+rx8nj39KcMMyVK8BhNRQ0iMF3Ci3vitwxDOYvbLUja4jocXvBUsaRvSl7qAds=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751041294;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=gfN2hhL3lfXYyJIhQf1mFRJtLEy5tuC2aFyzf06oeU0=;
	b=kSbvSdQB1T6NxjWP3K/HdNzqz+9doVXOMIdNoY6/DiUa0vDgSh8zGrsnfHWvQtsF
	H914RiOlcQPJ7TbpmNjJbTaxCvHCmczAjpaw7kxU1xaJIeLRRPhEzfvO0zQY4PYaxYL
	QqsGqCx0ITWamp75jXqKlnjF8lHvBvmqfxg0Jgh0=
Received: by mx.zohomail.com with SMTPS id 1751041293651663.112480858902;
	Fri, 27 Jun 2025 09:21:33 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Fri, 27 Jun 2025 13:21:03 -0300
Subject: [PATCH v5 1/6] rust: irq: add irq module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-topics-tyr-request_irq-v5-1-0545ee4dadf6@collabora.com>
References: <20250627-topics-tyr-request_irq-v5-0-0545ee4dadf6@collabora.com>
In-Reply-To: <20250627-topics-tyr-request_irq-v5-0-0545ee4dadf6@collabora.com>
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
2.50.0


