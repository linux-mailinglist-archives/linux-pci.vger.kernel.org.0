Return-Path: <linux-pci+bounces-23121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F62A569E4
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 15:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B706178D03
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 14:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10F421ABA4;
	Fri,  7 Mar 2025 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TdwVGdgL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE67821ABBD;
	Fri,  7 Mar 2025 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356242; cv=none; b=EnpcU1Hr4fDKNtV3v23/xbGaQoAe9K7ff+BJgrLYBJ8J5Q2qoTwAani7Mu7/8bGbYvTgD4GzFUpvPbm3kUFQWku8Rb/vZeJ+EmaMdMCW9mbKULS0ngmL4lcyk/5nACb5Fd401slCaYQ05Przr8wVKueZ60vSyH5jN5CLHMUSbJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356242; c=relaxed/simple;
	bh=ywhzavUbT8Crwka9kYfHb80Hlmy4pKHZMiz6hFpwVWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XoesShBBW5Zf5sTkVTv3y5HhFFUTaalcJeQ4RezBVuuhXm53F6O2inMWWH+YYdlEnX0K+8L8ZjvdHA7dcPiBUJGzHTNlMn5WhrrlkIYiQzWQrEELhecONdivlHCcWsBUboeXF8K2QdDTSdIk8nKlZB5v0G3GyQORvevxHCiMXKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TdwVGdgL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741356241; x=1772892241;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ywhzavUbT8Crwka9kYfHb80Hlmy4pKHZMiz6hFpwVWg=;
  b=TdwVGdgL16G/7QMutBHxazRMMTGEKfneo3IHYkklphWtgKBiFwEAJOTq
   Ey5ENKmbsdgrS+zffAtkgiFLnkLzlZE5SjecnCWRs2aOCwxDjMVOrDqST
   aSLX+Hh23S4fh6TT95j7vA0dN3vOgxvn5ArluoUiLBecc6i1W9Gwo2jk6
   bOnc7cP1hXkFK3a0QvgzX8Kg8iOKbzH2cGtJox9OJO1l7EfRKmcqVp/hT
   fPbS/CGXKA52tJBqewPcPfKnMfjocqzOwitDV2zaO6R6YvAhTLHWXVFyA
   JFaNOVJNRQqLOFRd2erzIDjlNYW1ZZ8QNWh1nTIV4ZLcEev2fBxTcRV/8
   A==;
X-CSE-ConnectionGUID: 6taCO5r2S4OIL/XJwj9vWg==
X-CSE-MsgGUID: fBUYxoQKT0+/1ff0HZXvFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53040427"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="53040427"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 06:04:00 -0800
X-CSE-ConnectionGUID: pT4gQoJlQOKKQ82jFUIpxA==
X-CSE-MsgGUID: g/AAWw7aSJmahjk8R7b9tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119257861"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.120])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 06:03:56 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
Subject: [PATCH v2 1/1] PCI: Fix BAR resizing when VF BARs are assigned
Date: Fri,  7 Mar 2025 16:03:49 +0200
Message-Id: <20250307140349.5634-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__resource_resize_store() attempts to release all resources of the
device before attempting the resize. The loop, however, only covers
standard BARs (< PCI_STD_NUM_BARS). If a device has VF BARs that are
assigned, pci_reassign_bridge_resources() finds the bridge window still
has some assigned child resources and returns -NOENT which makes
pci_resize_resource() to detect an error and abort the resize.

Change the release loop to cover all resources up to VF BARs which
allows the resize operation to release the bridge windows and attempt
to assigned them again with the different size.

As __resource_resize_store() checks first that no driver is bound to
the PCI device before resizing is allowed, SR-IOV cannot be enabled
during resize so it is safe to release also the IOV resources.

Fixes: 91fa127794ac ("PCI: Expose PCIe Resizable BAR support via sysfs")
Reported-by: Michał Winiarski <michal.winiarski@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v2:
- Removed language about expansion ROMs

 drivers/pci/pci-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index b46ce1a2c554..0c16751bab40 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1578,7 +1578,7 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 
 	pci_remove_resource_files(pdev);
 
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
 		if (pci_resource_len(pdev, i) &&
 		    pci_resource_flags(pdev, i) == flags)
 			pci_release_resource(pdev, i);

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.39.5


