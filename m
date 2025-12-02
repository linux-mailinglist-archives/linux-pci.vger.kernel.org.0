Return-Path: <linux-pci+bounces-42528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2BEC9D01F
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 22:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5055A4E056C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 21:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240F72F744F;
	Tue,  2 Dec 2025 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reKcttf6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74AF2E8B9C;
	Tue,  2 Dec 2025 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764709525; cv=none; b=X0PhFRkEh4MQciyV1oKaFIk1FQVSHX2NsJkYGEshnPJYQ0T5x8TbEwa4k91gtlaAbHmyBUx1mrjyAm2viAUQ5CCfPaDxHorSDORQl30fP78PWamNckctd86Th5bHWgHwENtvwF3a1pt2OORJ9XX33AMPhx4wmk4j5AyB1Fd5drE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764709525; c=relaxed/simple;
	bh=LxvmlEPnwcT3Fu4tZFgl635nHvjb95q21b94nDLlrVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3CPtZ5z6b+nlJJ9+sh6knZhhx9Ryi8e/eAf7csx3NNApaaNcyB6PO9J0TGaE6mvuZOrBZs2ixmprCGnVk8/B6cTPxXd4ws5tp1RIbH4v2c0TFJWDOkuMtwXz9lVvd+TJDWWnZ9KlgRKRl47h09Zya3wpiQZq3OrYNna2pnyzGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reKcttf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B31C113D0;
	Tue,  2 Dec 2025 21:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764709524;
	bh=LxvmlEPnwcT3Fu4tZFgl635nHvjb95q21b94nDLlrVs=;
	h=From:To:Cc:Subject:Date:From;
	b=reKcttf6QJ32bgv7Cck3ohwz+kgNgnKhxlV3WBdI0fEqia1J46gxl+HlXJhg4con2
	 C9DQt4qGggm7SijthKMXQ0UWemet7kzQN+dFfLTCG24WpkgvzG/qWt95bGehNJgALp
	 iMMqzA9oGsWuzowcH9ccT6hREYAAqsXxecmbnio0Jc1Ej6ck5b/TrQCJ8gI7vpiI0a
	 eX2j6ougYYdlxn11aKi3C9BrSIvC++69/2WIpxdVyarNYT8cFhoYxU6EN/pilsWDHM
	 twtmP11NFrXwGrhypHc63DtjrqAE2lEvwBPDukafJFpIIV9tBzN3Fpdb0FrjurDy86
	 ZTl95IzZDtEWw==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	joelagnelf@nvidia.com
Cc: linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] rust: pci: fix build failure when CONFIG_PCI_MSI is disabled
Date: Wed,  3 Dec 2025 10:01:50 +1300
Message-ID: <20251202210501.40998-1-dakr@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_PCI_MSI is disabled pci_alloc_irq_vectors() and
pci_free_irq_vectors() are defined as inline functions and hence require
a Rust helper.

	error[E0425]: cannot find function `pci_alloc_irq_vectors` in crate `bindings`
	    --> rust/kernel/pci/irq.rs:144:23
	     |
	 144 | ...s::pci_alloc_irq_vectors(dev.as_raw(), min_vecs, max_vecs, irq_types.as_raw())
	     |       ^^^^^^^^^^^^^^^^^^^^^ help: a function with a similar name exists: `pci_irq_vector`
	     |
	    ::: .../rust/bindings/bindings_helpers_generated.rs:1197:5
	     |
	1197 |     pub fn pci_irq_vector(pdev: *mut pci_dev, nvec: ffi::c_uint) -> ffi::c_int;
	     |     --------------------------------------------------------------------------- similarly named function `pci_irq_vector` defined here

	error[E0425]: cannot find function `pci_free_irq_vectors` in crate `bindings`
	    --> rust/kernel/pci/irq.rs:170:28
	     |
	 170 |         unsafe { bindings::pci_free_irq_vectors(self.dev.as_raw()) };
	     |                            ^^^^^^^^^^^^^^^^^^^^ help: a function with a similar name exists: `pci_irq_vector`
	     |
	    ::: .../rust/bindings/bindings_helpers_generated.rs:1197:5
	     |
	1197 |     pub fn pci_irq_vector(pdev: *mut pci_dev, nvec: ffi::c_uint) -> ffi::c_int;
	     |     --------------------------------------------------------------------------- similarly named function `pci_irq_vector` defined here

	error: aborting due to 2 previous errors

Fix this by adding the corresponding helpers.

Fixes: 340ccc973544 ("rust: pci: Allocate and manage PCI interrupt vectors")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512012238.YgVvRRUx-lkp@intel.com/
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/pci.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index fb814572b236..bf8173979c5e 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -23,9 +23,21 @@ bool rust_helper_dev_is_pci(const struct device *dev)
 }
 
 #ifndef CONFIG_PCI_MSI
+int rust_helper_pci_alloc_irq_vectors(struct pci_dev *dev,
+				      unsigned int min_vecs,
+				      unsigned int max_vecs,
+				      unsigned int flags)
+{
+	return pci_alloc_irq_vectors(dev, min_vecs, max_vecs, flags);
+}
+
+void rust_helper_pci_free_irq_vectors(struct pci_dev *dev)
+{
+	pci_free_irq_vectors(dev);
+}
+
 int rust_helper_pci_irq_vector(struct pci_dev *pdev, unsigned int nvec)
 {
 	return pci_irq_vector(pdev, nvec);
 }
-
 #endif

base-commit: d3666c1f8a31b7ff6805effcfedfac22454c6517
-- 
2.52.0


