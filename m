Return-Path: <linux-pci+bounces-43956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AA7CF0135
	for <lists+linux-pci@lfdr.de>; Sat, 03 Jan 2026 15:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E02EA3017669
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jan 2026 14:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286AE24A04A;
	Sat,  3 Jan 2026 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ch38Xw0v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF435975;
	Sat,  3 Jan 2026 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767451132; cv=none; b=rKZ779emUjk7o0/V9yN/0kTsOj5/CqNZf9rNcY9AGKGOlF9g9or41Gw9nH4F9oycuF87z7n+d23Zwy1T1d7pH3HkeTzVGclzznM/5PyW4PwVuKweb95HTcawI5RbqVb7umPo3Wj2U4Xa/u+RXvn60DIT7jJ0Z7wdpYt6ZrqoAwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767451132; c=relaxed/simple;
	bh=CAU1ctlAsiL0gt7YXxksyqGWy4qAoIURirgoWRDelos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bBL7xzIkOtLUFW6taBKQITQTeourUDiwsoX4pmfa+P4pBAu9RHTNl4s94TRQ22Hn6e+R9XGRbSP/nXULjto7+3Nshkrf7H27hjI5duqAL6ZDmXKCQv12VX+W8X6m5Ui4ysE9MWl13hr8Y6LKSpwiXpFn2b4GTiHaVZ4hV6QCVPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ch38Xw0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56361C113D0;
	Sat,  3 Jan 2026 14:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767451131;
	bh=CAU1ctlAsiL0gt7YXxksyqGWy4qAoIURirgoWRDelos=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ch38Xw0voAxFZ7/ud5FhYbEB48/RIswFwgg0HJjr7ctrF6Zhj+8vLFLLJrlDt+WKn
	 NgInYCFUNKi3BJaT7lyp7UTcRrgfFNNIOU54LlXVQ2thfPBKqPp9ypCUJ152voYYsM
	 poOcd13asUYTrOYjuWOzVsWfMDr+AG9nrFEmwAS37P/re4+GFzTImbGwOHlrResUgL
	 AzQC9KsZ3AfXHmhQp4NiB8MTuy4Iq/ePZs74Esxb/UsjaEdri63kPuHdmsEtODNFGE
	 YCn6qMbR+Q2eVFmAvAaIcKxWTRAGBdPCPh5MfGSldSmtJTIQQPF7CLx0OFBaOtpC7/
	 /QlvFNh8DbvPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C233FC6160;
	Sat,  3 Jan 2026 14:38:51 +0000 (UTC)
From: SeungJong Ha via B4 Relay <devnull+engineer.jjhama.gmail.com@kernel.org>
Date: Sat, 03 Jan 2026 14:38:50 +0000
Subject: [PATCH] rust: pci: add HeaderType enum and header_type() helper
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260103-add-rust-pci-header-type-v1-1-879b4d74b227@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPkpWWkC/x3MQQrDIBBG4avIrDugRgLJVUoXon+S2SQypqUle
 PdKlt/ivYsqVFBpNhcpPlLl2Dvcw1Da4r6CJXeTt360zg4cc2Z915NLEt4QM5TPXwEPYfRhSg7
 JBep5USzyvdfPV2t/4WGVIGoAAAA=
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, SeungJong Ha <engineer.jjhama@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767451130; l=3232;
 i=engineer.jjhama@gmail.com; s=20260103; h=from:subject:message-id;
 bh=e2E4FhBSLeClmn+jWVL0WZmHkENN+PUZbPDhQoNtkk4=;
 b=XWFzV0h3yE2SOPThqJB98GlI0lv2RzQLCSus9cLyUDIbfpwW6sbnzuUnfVt3hJPcFVtwd3Qoi
 ggPUYgYQ0g6B8vzD2SeROuxPwThziziy+4DSpr9CTbgbN4MspyHoxec
X-Developer-Key: i=engineer.jjhama@gmail.com; a=ed25519;
 pk=G5nmjm+RTiWBpyCvc5xjR1b3li/2zipLSMyz+T4fj5E=
X-Endpoint-Received: by B4 Relay for engineer.jjhama@gmail.com/20260103
 with auth_id=590
X-Original-From: SeungJong Ha <engineer.jjhama@gmail.com>
Reply-To: engineer.jjhama@gmail.com

From: SeungJong Ha <engineer.jjhama@gmail.com>

Add the HeaderType enum to represent PCI configuration space header
types (Normal and Bridge). Also implement the header_type() method in
the Device struct to allow Rust PCI drivers to identify the device
type safely.

This is required for drivers to handle type-specific configuration
registers correctly.

Signed-off-by: SeungJong Ha <engineer.jjhama@gmail.com>
---
Hello,

This is my first patch to the Linux kernel, specifically targeting the 
Rust PCI subsystem. 

This patch introduces the HeaderType enum to represent PCI configuration 
space header types (Normal and Bridge) and implements the header_type() 
method in the Device struct.

I have followed the patch submission checklist, but as this is my first 
contribution, please let me know if I have missed any conventions or 
if there are areas for improvement.

Thank you for your time and review!

Best regards,
SeungJong Ha
---
 rust/kernel/pci.rs        | 10 ++++++++++
 rust/kernel/pci/header.rs | 31 +++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 82e128431..90a0eb54f 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -31,10 +31,12 @@
     },
 };
 
+mod header;
 mod id;
 mod io;
 mod irq;
 
+pub use self::header::HeaderType;
 pub use self::id::{
     Class,
     ClassMask,
@@ -373,6 +375,14 @@ pub fn revision_id(&self) -> u8 {
         unsafe { (*self.as_raw()).revision }
     }
 
+    /// Returns the PCI header type.
+    #[inline]
+    pub fn header_type(&self) -> HeaderType {
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct pci_dev`.
+        HeaderType::from(unsafe { (*self.as_raw()).hdr_type })
+    }
+
     /// Returns the PCI bus device/function.
     #[inline]
     pub fn dev_id(&self) -> u16 {
diff --git a/rust/kernel/pci/header.rs b/rust/kernel/pci/header.rs
new file mode 100644
index 000000000..032efeb16
--- /dev/null
+++ b/rust/kernel/pci/header.rs
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! PCI device header type definitions.
+//!
+//! This module contains PCI header type definitions
+
+use kernel::bindings;
+
+/// PCI device header types.
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub enum HeaderType {
+    /// Normal PCI device header (Type 0)
+    NormalDevice,
+    /// PCI-to-PCI bridge header (Type 1)
+    PciToPciBridge,
+    /// CardBus bridge header (Type 2)
+    CardBusBridge,
+    /// Unknown or unsupported header type
+    Unknown,
+}
+
+impl From<u8> for HeaderType {
+    fn from(value: u8) -> Self {
+        match u32::from(value) & bindings::PCI_HEADER_TYPE_MASK {
+            bindings::PCI_HEADER_TYPE_NORMAL => HeaderType::NormalDevice,
+            bindings::PCI_HEADER_TYPE_BRIDGE => HeaderType::PciToPciBridge,
+            bindings::PCI_HEADER_TYPE_CARDBUS => HeaderType::CardBusBridge,
+            _ => HeaderType::Unknown,
+        }
+    }
+}

---
base-commit: f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da
change-id: 20260103-add-rust-pci-header-type-346249c1ec14

Best regards,
-- 
SeungJong Ha <engineer.jjhama@gmail.com>



