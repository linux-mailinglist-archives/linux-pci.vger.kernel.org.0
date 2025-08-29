Return-Path: <linux-pci+bounces-35112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E604B3BC33
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142E11CC2740
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6242531CA74;
	Fri, 29 Aug 2025 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UPG2cd+7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1C29D267;
	Fri, 29 Aug 2025 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473197; cv=none; b=bugMxO7l7HhTBKkImqfhc43n/Mo7hj9R+XCiEyblP1z6ugQhNdJXqXiTwgUel/0z88ZycYoE7Gwd5EufiWd9sQxXibm4zsW8RXRWC3x74kZV3G1/R2Bl0GwNOTU3EPVNXfy90jNs7yo6Tr7162tGmsnzfeYJHPhtBzRJKUF6xHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473197; c=relaxed/simple;
	bh=8RJJHwoV7RWSqBYUoUcIWbmCK3tDJ2a9+TXbWu1rw7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHS+kBqi3k6ssxDlNCFEGPGxBrsh8VQCmEvK58jmuQn10BQje0y0SKD6eKdHG7btMznGhlq6tU/V6Ep/7ct/Gw6QjaJIQ+A3bT3Z5+m8rU2qK5aX+qw/cMRtyIGQeJPpljBEqC9Bu+lC/GkpE2tpJq0IQLGxV9uZx3jKHixgG9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UPG2cd+7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473196; x=1788009196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8RJJHwoV7RWSqBYUoUcIWbmCK3tDJ2a9+TXbWu1rw7I=;
  b=UPG2cd+7pJPrQcOp3x7nbiubkTtJa+X36fYe8Z1Ilr1CzsUks0izX37s
   WWNE5lvVyaVWjwUuaOXIhlAJWx/toIcbAcEsvXVWisFt10Aehe5qf+rxs
   glV6OjDdmwmuwMDXywKr0T71w+tzipz94kb6o1vioZJNOlT4dPnyxx+D1
   r+dKg8az4c+82OPBxSmd9PZ2TmxwEX1Q+LEg6MsGJdW9Q3uhqns12CfYt
   ZdYX7I4HovnC765KsQ5CQjM7bhQJzGUo8OA1HBNzodj9uJuGbBwnqFf5I
   bujBaQ0N7oEkPIrvSr33UChom9eXKAx/8u1RhmhRTdljfgBNhw3n8CNyP
   Q==;
X-CSE-ConnectionGUID: e5WyPq6oQcG60pB2PI7HjQ==
X-CSE-MsgGUID: Y9pzfUrQRt6XTzcU3VoIPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62587466"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62587466"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:13:14 -0700
X-CSE-ConnectionGUID: DVycP/aOSbyPdNGUHTw9EA==
X-CSE-MsgGUID: L2ssu3wARGuMLL5LtX7WeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="175656769"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:13:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 15/24] PCI: Use pbus_select_window() during BAR resize
Date: Fri, 29 Aug 2025 16:11:04 +0300
Message-Id: <20250829131113.36754-16-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Prior to a BAR resize, __resource_resize_store() loops through the normal
resources of the PCI device and releases those that match to the flags of
the BAR to be resized. This is necessary to allow resizing also the
upstream bridge window as only childless bridge windows can be resized.

While the flags check (mostly) works (if corner cases are ignored), the
more straightforward way is to check if the resources share the bridge
window. Change __resource_resize_store() to do the check using
pbus_select_window().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci-sysfs.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 162a5241c7f7..ce3923c4aa80 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1562,13 +1562,19 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 				       const char *buf, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	unsigned long size, flags;
+	struct pci_bus *bus = pdev->bus;
+	struct resource *b_win, *res;
+	unsigned long size;
 	int ret, i;
 	u16 cmd;
 
 	if (kstrtoul(buf, 0, &size) < 0)
 		return -EINVAL;
 
+	b_win = pbus_select_window(bus, pci_resource_n(pdev, n));
+	if (!b_win)
+		return -EINVAL;
+
 	device_lock(dev);
 	if (dev->driver || pci_num_vf(pdev)) {
 		ret = -EBUSY;
@@ -1588,19 +1594,19 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 	pci_write_config_word(pdev, PCI_COMMAND,
 			      cmd & ~PCI_COMMAND_MEMORY);
 
-	flags = pci_resource_flags(pdev, n);
-
 	pci_remove_resource_files(pdev);
 
-	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
-		if (pci_resource_len(pdev, i) &&
-		    pci_resource_flags(pdev, i) == flags)
+	pci_dev_for_each_resource(pdev, res, i) {
+		if (i >= PCI_BRIDGE_RESOURCES)
+			break;
+
+		if (b_win == pbus_select_window(bus, res))
 			pci_release_resource(pdev, i);
 	}
 
 	ret = pci_resize_resource(pdev, n, size);
 
-	pci_assign_unassigned_bus_resources(pdev->bus);
+	pci_assign_unassigned_bus_resources(bus);
 
 	if (pci_create_resource_files(pdev))
 		pci_warn(pdev, "Failed to recreate resource files after BAR resizing\n");
-- 
2.39.5


