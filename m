Return-Path: <linux-pci+bounces-22843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17507A4E138
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 15:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7FF171F23
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 14:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD73326A0D6;
	Tue,  4 Mar 2025 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8TV3Dx5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A691726AA99;
	Tue,  4 Mar 2025 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098757; cv=none; b=EdSf1Urwbu5PTcF5XRUQgFCjwzkG3MawluZFRqHrQATMGBe1uZK0nxd4NezQAmkcUPniU4wDBdQ7ovL3/kafpb4AtIkZPiTTh7kM6EiXwQ7f5EJZkBHR27H4axLeGeZx8nGdmDcHlQEHoXqI98cJ81tFt73HjPfYSlf+T+S0Uq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098757; c=relaxed/simple;
	bh=XokWXJgVsvFaOzJU4BQOTS4Hl1XUcN8dYUyAwCadPSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O0OfOj2Q5rBku6ALq4eNwYDgLR10rGHTgXA1dV2iug9ZH1xtimyfPFqEOVC9Gj/DJvX5tKaQfQqNGp69SVZYPEbFkmbWRUBp0vjXFoK2ITuAiLUOxwVFrEqbGcHhbKREeZk7uGJ1LIOGMuDcVXJmbsnpIdrYhq8t0GwNzLsfBNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8TV3Dx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9FFC4CEE5;
	Tue,  4 Mar 2025 14:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741098757;
	bh=XokWXJgVsvFaOzJU4BQOTS4Hl1XUcN8dYUyAwCadPSM=;
	h=From:To:Cc:Subject:Date:From;
	b=k8TV3Dx5qUQzv/8hcRE55wPsjfviBdZ1Tk724s7VRwqZwAEqFtoOgBcVtfSqb733M
	 xPDFtFMlYh1X4l/6yhxoakWr/tL2ZSx4iVcGbKzgB+B9KLfhrZMjuA1x/XX52Yo1nN
	 7/mYTIxbpt+2oBEv9Ku19URj2yyl8hgWHeNRNaM4DkdgFcSz398vL8hRaQgVkiMKCr
	 XPNmimF6s/sq9B1wKQHsPr41d8I38603c1edvAdYBL0110fFCWVyjBL9ANo4fr6yef
	 f67gwJk6qmPDd147/UlM4BTG6K7NuaA3PZqzCgV65bPrue+6NT5zOhD7ATjgCKKyfy
	 +HLnF8ZkGp9hw==
From: Philipp Stanner <phasta@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>,
	Bingbu Cao <bingbu.cao@linux.intel.com>
Subject: [PATCH] PCI: Check BAR index for validity
Date: Tue,  4 Mar 2025 15:31:13 +0100
Message-ID: <20250304143112.104190-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many functions in PCI use accessor macros such as pci_resource_len(),
which take a BAR index. That index, however, is never checked for
validity, potentially resulting in undefined behavior by overflowing the
array pci_dev.resource in the macro pci_resource_n().

Since many users of those macros directly assign the accessed value to
an unsigned integer, the macros cannot be changed easily anymore to
return -EINVAL for invalid indexes. Consequently, the problem has to be
mitigated in higher layers.

Add pci_bar_index_valid(). Use it where appropriate.

Reported-by: Bingbu Cao <bingbu.cao@linux.intel.com>
Closes: https://lore.kernel.org/all/adb53b1f-29e1-3d14-0e61-351fd2d3ff0d@linux.intel.com/
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/pci/devres.c | 16 ++++++++++++++--
 drivers/pci/iomap.c  | 30 +++++++++++++++++++++---------
 drivers/pci/pci.c    |  6 ++++++
 drivers/pci/pci.h    |  8 ++++++++
 4 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 3431a7df3e0d..d2c09589c537 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -577,7 +577,7 @@ static int pcim_add_mapping_to_legacy_table(struct pci_dev *pdev,
 {
 	void __iomem **legacy_iomap_table;
 
-	if (bar >= PCI_STD_NUM_BARS)
+	if (!pci_bar_index_is_valid(bar))
 		return -EINVAL;
 
 	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
@@ -622,7 +622,7 @@ static void pcim_remove_bar_from_legacy_table(struct pci_dev *pdev, int bar)
 {
 	void __iomem **legacy_iomap_table;
 
-	if (bar >= PCI_STD_NUM_BARS)
+	if (!pci_bar_index_is_valid(bar))
 		return;
 
 	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
@@ -655,6 +655,9 @@ void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen)
 	void __iomem *mapping;
 	struct pcim_addr_devres *res;
 
+	if (!pci_bar_index_is_valid(bar))
+		return NULL;
+
 	res = pcim_addr_devres_alloc(pdev);
 	if (!res)
 		return NULL;
@@ -722,6 +725,9 @@ void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 	int ret;
 	struct pcim_addr_devres *res;
 
+	if (!pci_bar_index_is_valid(bar))
+		return IOMEM_ERR_PTR(-EINVAL);
+
 	res = pcim_addr_devres_alloc(pdev);
 	if (!res)
 		return IOMEM_ERR_PTR(-ENOMEM);
@@ -823,6 +829,9 @@ static int _pcim_request_region(struct pci_dev *pdev, int bar, const char *name,
 	int ret;
 	struct pcim_addr_devres *res;
 
+	if (!pci_bar_index_is_valid(bar))
+		return -EINVAL;
+
 	res = pcim_addr_devres_alloc(pdev);
 	if (!res)
 		return -ENOMEM;
@@ -991,6 +1000,9 @@ void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
 	void __iomem *mapping;
 	struct pcim_addr_devres *res;
 
+	if (!pci_bar_index_is_valid(bar))
+		return IOMEM_ERR_PTR(-EINVAL);
+
 	res = pcim_addr_devres_alloc(pdev);
 	if (!res)
 		return IOMEM_ERR_PTR(-ENOMEM);
diff --git a/drivers/pci/iomap.c b/drivers/pci/iomap.c
index 9fb7cacc15cd..0cab82cbcc99 100644
--- a/drivers/pci/iomap.c
+++ b/drivers/pci/iomap.c
@@ -9,6 +9,8 @@
 
 #include <linux/export.h>
 
+#include "pci.h" /* for pci_bar_index_is_valid() */
+
 /**
  * pci_iomap_range - create a virtual mapping cookie for a PCI BAR
  * @dev: PCI device that owns the BAR
@@ -33,12 +35,18 @@ void __iomem *pci_iomap_range(struct pci_dev *dev,
 			      unsigned long offset,
 			      unsigned long maxlen)
 {
-	resource_size_t start = pci_resource_start(dev, bar);
-	resource_size_t len = pci_resource_len(dev, bar);
-	unsigned long flags = pci_resource_flags(dev, bar);
+	resource_size_t start, len;
+	unsigned long flags;
 
+	if (!pci_bar_index_is_valid(bar))
+		return NULL;
 	if (len <= offset || !start)
 		return NULL;
+
+	start = pci_resource_start(dev, bar);
+	len = pci_resource_len(dev, bar);
+	flags = pci_resource_flags(dev, bar);
+
 	len -= offset;
 	start += offset;
 	if (maxlen && len > maxlen)
@@ -77,17 +85,21 @@ void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
 				 unsigned long offset,
 				 unsigned long maxlen)
 {
-	resource_size_t start = pci_resource_start(dev, bar);
-	resource_size_t len = pci_resource_len(dev, bar);
-	unsigned long flags = pci_resource_flags(dev, bar);
-
+	resource_size_t start, len;
+	unsigned long flags;
 
-	if (flags & IORESOURCE_IO)
+	if (!pci_bar_index_is_valid(bar))
 		return NULL;
-
 	if (len <= offset || !start)
 		return NULL;
 
+	start = pci_resource_start(dev, bar);
+	len = pci_resource_len(dev, bar);
+	flags = pci_resource_flags(dev, bar);
+
+	if (flags & IORESOURCE_IO)
+		return NULL;
+
 	len -= offset;
 	start += offset;
 	if (maxlen && len > maxlen)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..da82d734d09c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3921,6 +3921,9 @@ EXPORT_SYMBOL(pci_enable_atomic_ops_to_root);
  */
 void pci_release_region(struct pci_dev *pdev, int bar)
 {
+	if (!pci_bar_index_is_valid(bar))
+		return;
+
 	/*
 	 * This is done for backwards compatibility, because the old PCI devres
 	 * API had a mode in which the function became managed if it had been
@@ -3965,6 +3968,9 @@ EXPORT_SYMBOL(pci_release_region);
 static int __pci_request_region(struct pci_dev *pdev, int bar,
 				const char *name, int exclusive)
 {
+	if (!pci_bar_index_is_valid(bar))
+		return -EINVAL;
+
 	if (pci_is_managed(pdev)) {
 		if (exclusive == IORESOURCE_EXCLUSIVE)
 			return pcim_request_region_exclusive(pdev, bar, name);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01e51db8d285..ae8b2f5c118b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -167,6 +167,14 @@ static inline void pci_wakeup_event(struct pci_dev *dev)
 	pm_wakeup_event(&dev->dev, 100);
 }
 
+static inline bool pci_bar_index_is_valid(int bar)
+{
+	if (bar < 0 || bar >= PCI_NUM_RESOURCES)
+		return false;
+
+	return true;
+}
+
 static inline bool pci_has_subordinate(struct pci_dev *pci_dev)
 {
 	return !!(pci_dev->subordinate);
-- 
2.48.1


