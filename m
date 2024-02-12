Return-Path: <linux-pci+bounces-3335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 952D6850D8A
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 07:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5196D2859B7
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 06:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B643C15;
	Mon, 12 Feb 2024 06:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KeZ6oAxh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74AF1876;
	Mon, 12 Feb 2024 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707719565; cv=none; b=f8nqdqzXdnynHaKnNrPoFZbYBTXMnzZ2E888e5chuimPgjgKDpByNQdKfNefY42xqve98BknC7529bQIGlMtQontq/fjDpQ6jbIEMBnrPY2v+Wk8oyrjVEvkMtc1DllUWNGbhCqlt5nlgJVQ8Sosm2t/N10JgaPXe3bMSU0Qgh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707719565; c=relaxed/simple;
	bh=WtENbaXqtArIZ1h/ul86KKlsUh8sF5NCgydYyrUusME=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=icVHeoPGZGiRuz1UhSqnuzo1YwDa0h/FR2aFLqlE5wDkoTcG0CRJzJMFUUjJHi73J3wWWRSY2Vj+MmUB5nWQSaOTTCp9ZiIvdWzsIw/SGTvnbvvojDYgB23ljYlKnT47iLZxlujrPDyDYu4zH4lNWFfFRpk1paJB/LaLfqIrADU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KeZ6oAxh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707719564; x=1739255564;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WtENbaXqtArIZ1h/ul86KKlsUh8sF5NCgydYyrUusME=;
  b=KeZ6oAxh/OFsHP3Hpk3UKglRsnIl0Aq+h/ANK0HNVQ7YfO8i3BZiiqv0
   KF8inZLt9ZeeeJPMVJpC41yuA/ik4WnjGrTR575psTLTSAbV/vA3Klykm
   eyJ+uVGlh3ABwyjugCl3pS5gmwJr64QdChhifDPDG9zZTSWWD3ORVfaOL
   p+zi/AVHITwMQUxiF4lcOwdk+hoSSX2vKSCN8/COdkCGLh0n3HITgpb9d
   q46HPILfwtfZd7jDbYix/5SbCRKzwDcUrTtDtR4YJR/NzIpJWvttufZso
   HZHprdb3Db9vr4bBP/lhT5mrhNHgSehhwXm4w966oCObMWWZI4p8ihi/V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1538558"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="1538558"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 22:32:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="2897133"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by orviesa008.jf.intel.com with ESMTP; 11 Feb 2024 22:32:41 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 882D01CAEA;
	Mon, 12 Feb 2024 12:02:39 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 837061600100; Mon, 12 Feb 2024 12:02:39 +0530 (IST)
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
Subject: [PATCH v1] PCI / PM: Really allow runtime PM without callback functions
Date: Mon, 12 Feb 2024 12:02:33 +0530
Message-Id: <20240212063233.5599-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c5eb1190074c ("PCI / PM: Allow runtime PM without callback
functions") tried to eliminate the need for runtime PM callbacks
by modifying pci_pm_runtime_suspend() and pci_pm_runtime_resume(),
but didn't modify pci_pm_runtime_idle() with relevant changes, which
still returns -ENOSYS if the driver supplies no runtime PM callbacks.

Fix this by modifying pci_pm_runtime_idle() such that it allows PCI
device power state transitions without runtime PM callbacks.

 0)               |  pm_runtime_work() {
 0)               |    rpm_idle() {
 0)               |      rpm_check_suspend_allowed() {
 0)   1.500 us    |        __dev_pm_qos_resume_latency(); /* = 0x7fffffff */
 0)   4.840 us    |      } /* rpm_check_suspend_allowed = 0x0 */
 0)   1.550 us    |      __rpm_get_callback(); /* = 0xffffffffb4bc84f0 */
 0)   1.800 us    |      pci_pm_runtime_idle(); /* = -38 */
 0) + 17.070 us   |    } /* rpm_idle = -38 */
 0) + 22.450 us   |  } /* pm_runtime_work = -38 */

Debugged-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---

This is not marked for linux-stable for the need of extensive testing
and can be backported after a few releases if no issues are reported.

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


