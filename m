Return-Path: <linux-pci+bounces-27794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A84AB86CF
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 14:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2ED6A02DA0
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 12:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7432829B785;
	Thu, 15 May 2025 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzMB+LVY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4728029AAE6;
	Thu, 15 May 2025 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313194; cv=none; b=bdNJ0Z2JjAEmfDVgE/6LCD+mYFbvwhpWdCmezxaQUrzZRiQ847jNC9JfyMWtzE2Ibq4a+Z6sCfLz515A06jpu3gA44fMdaHSbGA/tJZYjiBno16apHfOqARYWpesLb+Pw5t3VZfufOPcYu80jRSWst4pDCjRdxg6pQuFaxk01io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313194; c=relaxed/simple;
	bh=UQAWPez3Fzrr6zEIxOxuQHIJ3TdMQpWgR9D4TZwbenI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qph4nkhgY8a3jVM3ZEYdoEx9YsyXq8xRMBZwksdXShipSXYDXW29wgF51yEfU4hHQ0F8Usg33E81ujR2lCPfzlIQdQwwcRlKJJ/CafKywGP81M15UaRRLD27iLHqJQ6L6mzx541fYEQWmI9fNCpGbZy69la1UNrt4x+uwsnpIdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzMB+LVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18B0C4CEE7;
	Thu, 15 May 2025 12:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313193;
	bh=UQAWPez3Fzrr6zEIxOxuQHIJ3TdMQpWgR9D4TZwbenI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XzMB+LVYPCvBIOcEfPTtWqvd3enfhhbA1wpn9w1eORevyG/tYha17ot9FwxOUUlM8
	 j/yrpCB/QWAhIOXJbRP6MImzMs1+H2wug9oEtj9wYVVqUUeeGWNeqpwJhGkNm+nVYV
	 Nj70sS3fWm6i69MeoR7VFzmcHqGK3svAy9t+iCl8tjFrXvVupxgN4k5ZFkUKAa7PKJ
	 Q8/NLHTzQZd7BgRCHyXz49rtn4aSSaR3Yh7V6O6bZ2pmJMHZOK6bgVjS+g7QKojOm+
	 cPKJpRlaLZvWSCPoA7xTWzjoUGw89CxET4QtANJZLYR2Wu3yaUYGBYjKdQXhgpsxA6
	 2Ivx/qH6sAs+g==
From: Philipp Stanner <phasta@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 5/7] PCI: Remove redundant set of request funcs
Date: Thu, 15 May 2025 14:46:03 +0200
Message-ID: <20250515124604.184313-7-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515124604.184313-2-phasta@kernel.org>
References: <20250515124604.184313-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the demangling of the hybrid devres functions within PCI was
implemented, it was necessary to implement several PCI functions a
second time to avoid cyclic calls, since the hybrid functions in pci.c
call the managed functions in devres.c, which in turn can be directly
used outside of PCI and needed request infrastructure, too.

Therefore, __pcim_request_region_range(), __pci_release_region_range()
and wrappers around them were implemented.

The hybrid nature has recently been removed from all functions in pci.c.
Therefore, the functions in devres.c can now directly use their
counterparts in pci.c without causing a call-cycle.

Remove __pcim_request_region_range(), __pcim_request_region_range() and
the wrappers. Use the corresponding request functions from pci.c in
devres.c

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/pci/devres.c | 110 ++-----------------------------------------
 1 file changed, 5 insertions(+), 105 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index ae79e5f95c8a..4a4604b78b90 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -70,106 +70,6 @@ static inline void pcim_addr_devres_clear(struct pcim_addr_devres *res)
 	res->bar = -1;
 }
 
-/*
- * The following functions, __pcim_*_region*, exist as counterparts to the
- * versions from pci.c - which, unfortunately, were in the past in "hybrid
- * mode", i.e., sometimes managed, sometimes not.
- *
- * To separate the APIs cleanly, we defined our own, simplified versions here.
- *
- * TODO: unify those functions with the counterparts in pci.c
- */
-
-/**
- * __pcim_request_region_range - Request a ranged region
- * @pdev: PCI device the region belongs to
- * @bar: BAR the range is within
- * @offset: offset from the BAR's start address
- * @maxlen: length in bytes, beginning at @offset
- * @name: name of the driver requesting the resource
- * @req_flags: flags for the request, e.g., for kernel-exclusive requests
- *
- * Returns: 0 on success, a negative error code on failure.
- *
- * Request a range within a device's PCI BAR.  Sanity check the input.
- */
-static int __pcim_request_region_range(struct pci_dev *pdev, int bar,
-				       unsigned long offset,
-				       unsigned long maxlen,
-				       const char *name, int req_flags)
-{
-	resource_size_t start = pci_resource_start(pdev, bar);
-	resource_size_t len = pci_resource_len(pdev, bar);
-	unsigned long dev_flags = pci_resource_flags(pdev, bar);
-
-	if (start == 0 || len == 0) /* Unused BAR. */
-		return 0;
-	if (len <= offset)
-		return -EINVAL;
-
-	start += offset;
-	len -= offset;
-
-	if (len > maxlen && maxlen != 0)
-		len = maxlen;
-
-	if (dev_flags & IORESOURCE_IO) {
-		if (!request_region(start, len, name))
-			return -EBUSY;
-	} else if (dev_flags & IORESOURCE_MEM) {
-		if (!__request_mem_region(start, len, name, req_flags))
-			return -EBUSY;
-	} else {
-		/* That's not a device we can request anything on. */
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-static void __pcim_release_region_range(struct pci_dev *pdev, int bar,
-					unsigned long offset,
-					unsigned long maxlen)
-{
-	resource_size_t start = pci_resource_start(pdev, bar);
-	resource_size_t len = pci_resource_len(pdev, bar);
-	unsigned long flags = pci_resource_flags(pdev, bar);
-
-	if (len <= offset || start == 0)
-		return;
-
-	if (len == 0 || maxlen == 0) /* This an unused BAR. Do nothing. */
-		return;
-
-	start += offset;
-	len -= offset;
-
-	if (len > maxlen)
-		len = maxlen;
-
-	if (flags & IORESOURCE_IO)
-		release_region(start, len);
-	else if (flags & IORESOURCE_MEM)
-		release_mem_region(start, len);
-}
-
-static int __pcim_request_region(struct pci_dev *pdev, int bar,
-				 const char *name, int flags)
-{
-	unsigned long offset = 0;
-	unsigned long len = pci_resource_len(pdev, bar);
-
-	return __pcim_request_region_range(pdev, bar, offset, len, name, flags);
-}
-
-static void __pcim_release_region(struct pci_dev *pdev, int bar)
-{
-	unsigned long offset = 0;
-	unsigned long len = pci_resource_len(pdev, bar);
-
-	__pcim_release_region_range(pdev, bar, offset, len);
-}
-
 static void pcim_addr_resource_release(struct device *dev, void *resource_raw)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -177,11 +77,11 @@ static void pcim_addr_resource_release(struct device *dev, void *resource_raw)
 
 	switch (res->type) {
 	case PCIM_ADDR_DEVRES_TYPE_REGION:
-		__pcim_release_region(pdev, res->bar);
+		pci_release_region(pdev, res->bar);
 		break;
 	case PCIM_ADDR_DEVRES_TYPE_REGION_MAPPING:
 		pci_iounmap(pdev, res->baseaddr);
-		__pcim_release_region(pdev, res->bar);
+		pci_release_region(pdev, res->bar);
 		break;
 	case PCIM_ADDR_DEVRES_TYPE_MAPPING:
 		pci_iounmap(pdev, res->baseaddr);
@@ -720,7 +620,7 @@ void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 	res->type = PCIM_ADDR_DEVRES_TYPE_REGION_MAPPING;
 	res->bar = bar;
 
-	ret = __pcim_request_region(pdev, bar, name, 0);
+	ret = pci_request_region(pdev, bar, name);
 	if (ret != 0)
 		goto err_region;
 
@@ -734,7 +634,7 @@ void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 	return res->baseaddr;
 
 err_iomap:
-	__pcim_release_region(pdev, bar);
+	pci_release_region(pdev, bar);
 err_region:
 	pcim_addr_devres_free(res);
 
@@ -835,7 +735,7 @@ int pcim_request_region(struct pci_dev *pdev, int bar, const char *name)
 	res->type = PCIM_ADDR_DEVRES_TYPE_REGION;
 	res->bar = bar;
 
-	ret = __pcim_request_region(pdev, bar, name, 0);
+	ret = pci_request_region(pdev, bar, name);
 	if (ret != 0) {
 		pcim_addr_devres_free(res);
 		return ret;
-- 
2.49.0


