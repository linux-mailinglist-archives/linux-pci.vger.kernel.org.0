Return-Path: <linux-pci+bounces-43487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B246CD4A5E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 04:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7E0F30062D1
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 03:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC4F7261C;
	Mon, 22 Dec 2025 03:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PYYX2iRA"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB58A4A23;
	Mon, 22 Dec 2025 03:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766375164; cv=none; b=N6Ceq/VFMZ43UJl9HTnPtTez0MAmUEPaH870oT+p6qJcmQe2u8LCBRHXrqm5CODlw4ntAVMVgDiU1xSnp1XmaGIgVgRv1ukBqnOuYBgi+iRQmANYoPmWNuG16VHyz6Yb1qewA1t/CWFQLscmDSWDBnKKGXSLjtHFIoWgLNzU3Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766375164; c=relaxed/simple;
	bh=+uoXTRL03MKwDHC5OBmwcKH9tnKh1lf6KoOQ2Ze7Eyg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VWIqJif6PAXJhK+7mUP5vmy6C4gQstKEljagcqAbvounb3NsBUNzg1wM+l70vwqRucjYzJqyMv+AKVnKM/OXgAlKnm/Cdw9IxVNh7jdQ88w3zyF35Vj5kchiuHYInSZgEvAwjOBpbX4muLvuJnKnppS0C4RsesHST9GtsdltScg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PYYX2iRA; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=aD
	soqbnVRqZ3rTeQ0tICO+fRzXLll4rw5VNAVTfuN8o=; b=PYYX2iRAJEGzUZaNsp
	NXaQs5IUj/uPDhmgsVBZlFaA4XeT1Uxi1JvCkVLd+c5qZEMltg81aKhCD/m/cEQJ
	yo/IuAV0meUfkOhKz1bBIsLNRGu0uHQvtZZfqUZnmG2ZbLrqfRy5fz9ujfbqCCOn
	DYvF1UrZlipwxUDhBfdYcLY7o=
Received: from hello.company.local (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgA3H3mSvkhpR3MqIg--.69S2;
	Mon, 22 Dec 2025 11:44:21 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	rust-for-linux@vger.kernel.org (open list:RUST:Keyword:\b(?i:rust)\b),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Cc: liangjie@lixiang.com,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] pci: provide pci_free_irq_vectors() stub when CONFIG_PCI is disabled
Date: Mon, 22 Dec 2025 11:44:15 +0800
Message-Id: <20251222034415.1384223-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgA3H3mSvkhpR3MqIg--.69S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4kXFyUtw4Dtr1rCw18AFb_yoW8ZFyDp3
	WDuw4UtrW8JFy7WwsIyw47Crn8W395GryxG3yfWw1Uury2gws7tFs8tr1aqr1xCrs3Ar43
	JasIgFWF9w1UA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSoGQUUUUU=
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/xtbC-xZBYWlIvpbv9wAA3Y

From: Liang Jie <liangjie@lixiang.com>

When building with CONFIG_PCI=n, clang reports:

  In file included from rust/helpers/helpers.c:40:
  rust/helpers/pci.c:36:2: error: call to undeclared function 'pci_free_irq_vectors';
  ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
          pci_free_irq_vectors(dev);
          ^
  rust/helpers/pci.c:36:2: note: did you mean 'pci_alloc_irq_vectors'?
  include/linux/pci.h:2161:1: note: 'pci_alloc_irq_vectors' declared here
  pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
  ^
  1 error generated.

The root cause is that include/linux/pci.h provides inline stubs for
pci_alloc_irq_vectors() in the CONFIG_PCI=n fallback, but does not provide
any declaration for pci_free_irq_vectors(). As a result, callers that invoke
pci_free_irq_vectors() under CONFIG_PCI=n (e.g. Rust PCI helpers) hit an
implicit function declaration error with clang.

Fix this by adding a no-op pci_free_irq_vectors() stub to the CONFIG_PCI=n
fallback section of include/linux/pci.h, keeping the alloc/free API pair
consistent and avoiding implicit declaration build failures.

Fixes: 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI is disabled")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512220740.4Kexm4dW-lkp@intel.com/
Signed-off-by: Liang Jie <liangjie@lixiang.com>
---
 include/linux/pci.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 864775651c6f..b5cc0c2b9906 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2210,6 +2210,10 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 {
 	return -ENOSPC;
 }
+
+static inline void pci_free_irq_vectors(struct pci_dev *dev)
+{
+}
 #endif /* CONFIG_PCI */
 
 /* Include architecture-dependent settings and functions */
-- 
2.25.1


