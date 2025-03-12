Return-Path: <linux-pci+bounces-23476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8789AA5D7D0
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 09:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00ED616CCD7
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 08:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A9D233D99;
	Wed, 12 Mar 2025 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/vef+q8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62955232364;
	Wed, 12 Mar 2025 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766814; cv=none; b=FMcTY6qjhO72QhoLCSABeMk2u9UVJiXHtd+eRsfToaaeCnWJxUMkgUHXiXsObp0+ehj/9BzERsf3JXs9NdkwXN3dpzR+gcdxqpbOWBn41hKCDYCk9QHo1Z2gOCnn2s6bYfZf+n8F7oskIznBdBG/7lxDVsFSi/UOc/alsR2eqSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766814; c=relaxed/simple;
	bh=hy1fPZC2FIGVsEIMGtrBPmDIOw6KnV62HzIoDTQYHLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocZpsBxy4INqb9H6hgrKaTAeEIuJUrgOBuzG546yZQajBVD+2Kh/uKlL1VlJByszBHQXAGVbWeTkn0TYHkuEnzAPrBByTxNxIqfhyZscZu+/I1sOPD/aIrIvcYuQlZwbOPhnmc/mQdgqTuYa1kHrRC/mh6/Wu3FP7HHbjk7ceTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/vef+q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764B6C4CEEE;
	Wed, 12 Mar 2025 08:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741766813;
	bh=hy1fPZC2FIGVsEIMGtrBPmDIOw6KnV62HzIoDTQYHLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m/vef+q8ptNAQIaH3VyG6fBhF7ecuTqBBMiXdTB2jQ0Q2VNtJytrUpn+WhTUwmvMR
	 eW8X8QlFyCq25GtJRYU+sF2SzThP7n1/GefEXOrYUy0B27KRZsVRhPma0b4LvjYDMX
	 DtkCnf724+RbJByyYc16BCmaeIsFb8YQ3+4lZO4x3OJXVOjpjyoFU/q6cHINhYTTvp
	 4a8k5qfKXNKBvzgWdgsQxPB4ZYquNp91aDvrY3pFuAfgZw0EQQJMT9QoGkM5RX1y69
	 3SsC3XhGPhfrXw92lfKsoG0CcNIUiYP+FEfP3tGAkjsXT0psRz69KFXAcETDWKZuVy
	 B0Bb+8eCq5VCQ==
From: Philipp Stanner <phasta@kernel.org>
To: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>,
	Bingbu Cao <bingbu.cao@linux.intel.com>
Subject: [PATCH v3 2/2] PCI: Check BAR index for validity
Date: Wed, 12 Mar 2025 09:06:35 +0100
Message-ID: <20250312080634.13731-4-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312080634.13731-2-phasta@kernel.org>
References: <20250312080634.13731-2-phasta@kernel.org>
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
 drivers/pci/iomap.c  | 29 +++++++++++++++++++++--------
 drivers/pci/pci.c    |  6 ++++++
 drivers/pci/pci.h    | 16 ++++++++++++++++
 4 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 728ed0c7f70a..73047316889e 100644
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
index 9fb7cacc15cd..fe706ed946df 100644
--- a/drivers/pci/iomap.c
+++ b/drivers/pci/iomap.c
@@ -9,6 +9,8 @@
 
 #include <linux/export.h>
 
+#include "pci.h" /* for pci_bar_index_is_valid() */
+
 /**
  * pci_iomap_range - create a virtual mapping cookie for a PCI BAR
  * @dev: PCI device that owns the BAR
@@ -33,12 +35,19 @@ void __iomem *pci_iomap_range(struct pci_dev *dev,
 			      unsigned long offset,
 			      unsigned long maxlen)
 {
-	resource_size_t start = pci_resource_start(dev, bar);
-	resource_size_t len = pci_resource_len(dev, bar);
-	unsigned long flags = pci_resource_flags(dev, bar);
+	resource_size_t start, len;
+	unsigned long flags;
+
+	if (!pci_bar_index_is_valid(bar))
+		return NULL;
+
+	start = pci_resource_start(dev, bar);
+	len = pci_resource_len(dev, bar);
+	flags = pci_resource_flags(dev, bar);
 
 	if (len <= offset || !start)
 		return NULL;
+
 	len -= offset;
 	start += offset;
 	if (maxlen && len > maxlen)
@@ -77,16 +86,20 @@ void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
 				 unsigned long offset,
 				 unsigned long maxlen)
 {
-	resource_size_t start = pci_resource_start(dev, bar);
-	resource_size_t len = pci_resource_len(dev, bar);
-	unsigned long flags = pci_resource_flags(dev, bar);
+	resource_size_t start, len;
+	unsigned long flags;
 
-
-	if (flags & IORESOURCE_IO)
+	if (!pci_bar_index_is_valid(bar))
 		return NULL;
 
+	start = pci_resource_start(dev, bar);
+	len = pci_resource_len(dev, bar);
+	flags = pci_resource_flags(dev, bar);
+
 	if (len <= offset || !start)
 		return NULL;
+	if (flags & IORESOURCE_IO)
+		return NULL;
 
 	len -= offset;
 	start += offset;
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
index 01e51db8d285..19af5491f674 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -167,6 +167,22 @@ static inline void pci_wakeup_event(struct pci_dev *dev)
 	pm_wakeup_event(&dev->dev, 100);
 }
 
+/**
+ * pci_bar_index_is_valid - check wehether a BAR index is within valid range
+ * @bar: the bar index
+ *
+ * Protects against overflowing &struct pci_dev.resource array.
+ *
+ * Return: true for valid index, false otherwise
+ */
+static inline bool pci_bar_index_is_valid(int bar)
+{
+	if (bar >= 0 || bar < PCI_NUM_RESOURCES)
+		return true;
+
+	return false;
+}
+
 static inline bool pci_has_subordinate(struct pci_dev *pci_dev)
 {
 	return !!(pci_dev->subordinate);
-- 
2.48.1


