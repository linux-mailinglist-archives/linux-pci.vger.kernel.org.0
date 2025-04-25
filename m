Return-Path: <linux-pci+bounces-26757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AED9A9CAA9
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 15:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F8737A63CE
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 13:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4968C25A329;
	Fri, 25 Apr 2025 13:39:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE0C25A2CC;
	Fri, 25 Apr 2025 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745588390; cv=none; b=bUPWZrk5rSHpexsdQptUS1uzR8zd9K0VJQvjXhnuePttBZSVHGIkN/BDncHE53BwAfZZrGruIv41yfutLabxdX1H32gD7kmbbciDyDlDkanlbyVOUtv3wa3bbENpCII9BX6DPeQPKKYCinR0FG+Tirp+hGqBQe32SUBxALbFUUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745588390; c=relaxed/simple;
	bh=dqb8vZ0QzGl1lb+a6KWe7g4pKVohHseW5ueItvPNZzI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JzvN37PRg4kU9E1MgXkeU/rvAT5TVLXaB53NL8WGbue47ylqDDdClRw+/qUU28LpUJzdSGPyFUnlMsnqQMSAIsW0yiL5yooYvmQoBZoxfq/SvnVogFxc2rbTx0yNv5uTvCS0KwyFhiyJi6W+diabX5yCPNH6MkRumE5ZjphOsVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDC8D1A2D;
	Fri, 25 Apr 2025 06:39:42 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3EBA13F59E;
	Fri, 25 Apr 2025 06:39:47 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Will McVicker <willmcvicker@google.com>
Subject: [PATCH] PCI: Fix driver_managed_dma check
Date: Fri, 25 Apr 2025 14:39:29 +0100
Message-Id: <20250425133929.646493-4-robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since it's not currently safe to take device_lock() in the IOMMU probe
path, that can race against really_probe() setting dev->driver before
attempting to bind. The race itself isn't so bad, since we're only
concerned with dereferencing dev->driver itself anyway, but sadly my
attempt to implement the check with minimal churn leads to a kind of
TOCTOU issue, where dev->driver becomes valid after to_pci_driver(NULL)
is already computed, and thus the check fails to work as intended.

Will and I both hit this with the platform bus, but the pattern here is
the same, so fix it for correctness too.

Reported-by: Will McVicker <willmcvicker@google.com>
Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/pci/pci-driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index c8bd71a739f7..66e3bea7dc1a 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1634,7 +1634,7 @@ static int pci_bus_num_vf(struct device *dev)
  */
 static int pci_dma_configure(struct device *dev)
 {
-	struct pci_driver *driver = to_pci_driver(dev->driver);
+	const struct device_driver *drv = READ_ONCE(dev->driver);
 	struct device *bridge;
 	int ret = 0;
 
@@ -1651,8 +1651,8 @@ static int pci_dma_configure(struct device *dev)
 
 	pci_put_host_bridge_device(bridge);
 
-	/* @driver may not be valid when we're called from the IOMMU layer */
-	if (!ret && dev->driver && !driver->driver_managed_dma) {
+	/* @drv may not be valid when we're called from the IOMMU layer */
+	if (!ret && drv && !to_pci_driver(drv)->driver_managed_dma) {
 		ret = iommu_device_use_default_domain(dev);
 		if (ret)
 			arch_teardown_dma_ops(dev);
-- 
2.39.2.101.g768bb238c484.dirty


