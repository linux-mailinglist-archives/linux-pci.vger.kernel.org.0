Return-Path: <linux-pci+bounces-31449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B77B1AF8160
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 21:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A501C840D3
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 19:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F3B2FA642;
	Thu,  3 Jul 2025 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="DsLACnb1"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708542F85FB;
	Thu,  3 Jul 2025 19:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751571067; cv=pass; b=nG4J9EWFfYnLVmOVnscsLamPYDb91DroyKrwtmm56IQ3+iEHZNpEGxW8OtBpq+izO/v+j/eZnHkVrBfqSINe3YEM3YiC2zedK/MysDl8s67HlSdXym93DgK2CliARsQrIU4CK651gWwHhloPsa6RjdRecvu2NQqsFLB0sIzQy5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751571067; c=relaxed/simple;
	bh=aEMkXvUthUB8l3Ze03TQRSrmmhr7dlle2OHZ3th5mnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XEsYDrGkWYzIeELVw/wPQJpKaMuYfw0mYdb3Lno66bwPDd1Ly1+HG1QwmqC/ffv/rn5v9fIzNcjd4Ku+VigsUCuG5IPnBM/E7bSwbdGIEIxEmASGc8KuYBwnsg+6/+Z70CHpoQgPd18s4xgL862R7t7rOCMKxk0tSp2Ryxkofko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=DsLACnb1; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751571046; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QxNiabCTIjq66TjKplNEJZRT3eW7MFGF51oR+dFu8wldiBwXtrSdfSMQWGISpIOLP1aPyQwXV027stt8nY2S8GJt40xqpu7KzjB7A37pD1joPsOmzjdloRyejmqJTzKUSGAACx0m9R0aAUW7rXBLvmuNofNXmTdoPMIyGaflV+g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751571046; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gfN2hhL3lfXYyJIhQf1mFRJtLEy5tuC2aFyzf06oeU0=; 
	b=PYWT19QVCYTG1XNkrQFvcejv0axFlW4AzkhTT8Ti2O4CxXRQj0iwiKzw+miyIf+gEN98qKryVWEcC6q7AdUPcXF84jg6fRDFSmQWxqY2OAflcq5fnuyPoMNv08Fb+DIRWtkp3clJXeS7P1D5DQLKtOWo2LpB+5/153r5z4caJkg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751571046;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=gfN2hhL3lfXYyJIhQf1mFRJtLEy5tuC2aFyzf06oeU0=;
	b=DsLACnb1nvR/BR50ZlHNL2D2aJjnuySqT103Yvp6oP7CGHPzt8MufVRrsL3iCUV4
	d/GuJgJx9u0ASYw2FlEgjfk6AbHJwXOfSu6jwA4E32SxO7we2i1dsU2Reem0CYhnWaJ
	AQSXnddmmw9IHWJny0c2VMvQsWc0seGsyVRL+hLw=
Received: by mx.zohomail.com with SMTPS id 1751571043331493.12856796447954;
	Thu, 3 Jul 2025 12:30:43 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 03 Jul 2025 16:29:59 -0300
Subject: [PATCH v6 1/6] rust: irq: add irq module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-topics-tyr-request_irq-v6-1-74103bdc7c52@collabora.com>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
In-Reply-To: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
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


