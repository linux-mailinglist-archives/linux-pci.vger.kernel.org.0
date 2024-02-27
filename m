Return-Path: <linux-pci+bounces-4076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 344D48688F1
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 07:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1271F21EEA
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 06:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C087C53373;
	Tue, 27 Feb 2024 06:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A31c+58X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC9C5336E;
	Tue, 27 Feb 2024 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709015219; cv=none; b=h6NWbzQWkHCfJPr+qUbi838oejYdg1PRXG7/FN2BMX2xpoMXri89mDdVrYmEv6Nkgu5cPSNPORx8qewq2ltz6Gl4mjdbTfOyR/JcmoUV3FJiZq97sbEX+cxg9I1Zn7wOiQT0QOvYDaRLPrtCG6iQ1SXeR3JPpwuGstb9RaWnZME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709015219; c=relaxed/simple;
	bh=l5lw8RkSxjpG2Io4jclpM5Y8NRE451hzHP+TAbY4jv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ktBLrGR+ZMCK1FZbpDxncmYXiAGvbnLjIII1VAlu7GzavhLA5YQt/LDNb7skl7INaw9JRI0itQGsfn26Qm6EQDDlTe9LASaZglXo2QOYTCxhwvXi5rk+/pvDdxg7tPzARtBxM5mZ2T/a28/djFuhmQpy2JhuCv8kLf2Ot5TtYpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A31c+58X; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709015218; x=1740551218;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l5lw8RkSxjpG2Io4jclpM5Y8NRE451hzHP+TAbY4jv8=;
  b=A31c+58X0uXKC9ygw6qcIVLetRr3AleUW9pFhimj0DzVzGP4nuDMlBJ7
   ThIGzJDJTDfO7+oH1Uxh/hqzJwYKNLkXP8H9uYUQvDoYp3LpzxwYmx2La
   PETsnJ9jt/LOu/8o++Tp3pfnV+nxXZ/4u0LQxiQ4eQ6vxxAdpgmUQgDJv
   w6lyQiKy23SST8egem2wbYwpHZGZK7Izwt6xv1x3Ewz8uOumJMn29CI6n
   0fYe9gDQSZInYcJLS6VaruP+/Rjd5P3nqz9HTwKiOjJj3o5hM7egsKSVL
   9SOYkznoYDuIEAdHUS0KLLSmeSFK1MlXMKYTRlM5VyAkmBvfE4GPso/XT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20785774"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="20785774"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 22:26:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="37959670"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by fmviesa001.fm.intel.com with ESMTP; 26 Feb 2024 22:26:54 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 446AA1FCEF;
	Tue, 27 Feb 2024 11:56:53 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 3F0871600101; Tue, 27 Feb 2024 11:56:53 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: bhelgaas@google.com,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	stanislaw.gruszka@linux.intel.com,
	lukas@wunner.de,
	rafael@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2] PCI / PM: Really allow runtime PM without callback functions
Date: Tue, 27 Feb 2024 11:56:48 +0530
Message-Id: <20240227062648.16579-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c5eb1190074c ("PCI / PM: Allow runtime PM without callback
functions") tried to eliminate the need for runtime PM callbacks by
modifying pci_pm_runtime_suspend() and pci_pm_runtime_resume(), but
didn't modify pci_pm_runtime_idle() with relevant changes, which still
returns -ENOSYS if the driver supplies no runtime PM callbacks.

Modify pci_pm_runtime_idle() such that it allows PCI device power state
transitions without runtime PM callbacks and complete the original
intention of commit c5eb1190074c ("PCI / PM: Allow runtime PM without
callback functions").

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---

This is not marked for linux-stable for the need of extensive testing
and can be backported after a few releases if no issues are reported.

Changes since v1:
- Update commit message and tags

 drivers/pci/pci-driver.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 51ec9e7e784f..bb7f6775b350 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1382,10 +1382,7 @@ static int pci_pm_runtime_idle(struct device *dev)
 	if (!pci_dev->driver)
 		return 0;
 
-	if (!pm)
-		return -ENOSYS;
-
-	if (pm->runtime_idle)
+	if (pm && pm->runtime_idle)
 		return pm->runtime_idle(dev);
 
 	return 0;
-- 
2.35.3


