Return-Path: <linux-pci+bounces-24576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6E1A6E538
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 22:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB74189B912
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 21:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0518E1F582F;
	Mon, 24 Mar 2025 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPnkrEsX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7081F5612;
	Mon, 24 Mar 2025 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850281; cv=none; b=PHGwjpQ4V8C5bx/SJlidOY/7H1wj9Gi2yUvl44d2Ja0XVjZARdZe2HMrQtY7ttb4V4VnZpHPjIULojkZhHhI+/LYY0ed5p/ylAaJRYMm9aKz/8m+8HNU63jQBwM4dw71R5VFL7AaDth6/IOiKkA1uHdeMxkakcD6RWXA1oW1Z1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850281; c=relaxed/simple;
	bh=uzAUre8yuO6JwarGjgA4aQIOBg6xu8RcbsiMQ1Dc8bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diFSsx87ofeTsj/7V6ZahopNWaNcTQm6H4SdF2g2h9mxJrKXtUf7Auo+1ijTb/aHiK4fZMtcYHRz8qGc3yvSlaxvmDMn7FCjPcZdNQg5S81CnCGp9GmPr2/7PV91Yqe387LlqForlhmv8AAFmmun3fntd/8ctbtipL3AVe2YT7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPnkrEsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A81C4CEE4;
	Mon, 24 Mar 2025 21:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850281;
	bh=uzAUre8yuO6JwarGjgA4aQIOBg6xu8RcbsiMQ1Dc8bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SPnkrEsXOmUDJzEecsqBY8IqTHbrzWVOIVp4ZH0q09kXxD0MATIitKGZPcE+kshve
	 YKppWsQF7wqCekLU1SkD8x1R8mgXH3UUrR9HKkO89NRseE5hcn/M58CqxHR42TpEpX
	 aGisoO4BJlS5Sn5gCiSDFSXKpqWonY4muGVaO/0pG0m0FbhY/lskx5PNGFvXxzIBxP
	 bc+499waM6p/G4zL50h/jrA6NR+LVTCMxAxAFz/H0Gm9qmSnWclSx5dBpOUmnrR7Cp
	 OHmf+WfFPztgtLq93HQS+9ydFtQvAWE6iNRAH7dDtDDRX5mCh70zPlUZoTJP2R6mCA
	 ZxICxNHS/iDXQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 07/10] rust: pci: fix docs related to missing Markdown code spans
Date: Mon, 24 Mar 2025 22:03:54 +0100
Message-ID: <20250324210359.1199574-8-ojeda@kernel.org>
In-Reply-To: <20250324210359.1199574-1-ojeda@kernel.org>
References: <20250324210359.1199574-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In particular:

  - Add missing Markdown code spans.

  - Improve title for `DeviceId`, adding a link to the struct in the
    C side, rather than referring to `bindings::`.

  - Convert `TODO` from documentation to a normal comment, and put code
    in block.

This was found using the Clippy `doc_markdown` lint, which we may want
to enable.

Fixes: 1bd8b6b2c5d3 ("rust: pci: add basic PCI device / driver abstractions")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/pci.rs | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index f7b2743828ae..99413607c2b6 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -115,7 +115,9 @@ macro_rules! module_pci_driver {
 };
 }

-/// Abstraction for bindings::pci_device_id.
+/// Abstraction for the PCI device ID structure ([`pci_device_id`]).
+///
+/// [`pci_device_id`]: https://docs.kernel.org/PCI/pci.html#c.pci_device_id
 #[repr(transparent)]
 #[derive(Clone, Copy)]
 pub struct DeviceId(bindings::pci_device_id);
@@ -170,7 +172,7 @@ fn index(&self) -> usize {
     }
 }

-/// IdTable type for PCI
+/// `IdTable` type for PCI.
 pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<DeviceId, T>;

 /// Create a PCI `IdTable` with its alias for modpost.
@@ -221,10 +223,11 @@ macro_rules! pci_device_table {
 /// `Adapter` documentation for an example.
 pub trait Driver {
     /// The type holding information about each device id supported by the driver.
-    ///
-    /// TODO: Use associated_type_defaults once stabilized:
-    ///
-    /// type IdInfo: 'static = ();
+    // TODO: Use `associated_type_defaults` once stabilized:
+    //
+    // ```
+    // type IdInfo: 'static = ();
+    // ```
     type IdInfo: 'static;

     /// The table of device ids supported by the driver.
--
2.49.0

