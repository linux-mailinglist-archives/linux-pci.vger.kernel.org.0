Return-Path: <linux-pci+bounces-15644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB6B9B6937
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 17:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0701C21A58
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 16:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE902215010;
	Wed, 30 Oct 2024 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewn7RLIM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC441213EEC;
	Wed, 30 Oct 2024 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305907; cv=none; b=CTh+VJdCrsA5KER+vl75nGqdTy7XtTOo8k1/mPrKMsTiC15zFk9xd6dW7P6r1fMR0l2S0m7n+pksK2SadCyrJlzbCkzsP2ku4+lTwZKiTIlN35yqHxn5PmJ+ThIu13HmatLHHrOrLGnQ6mS7mHBV0EbJzUpggVAu5JsD1zTMAno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305907; c=relaxed/simple;
	bh=5qXp4dv3iXZzbT2Gc/7Buqw70YKVFaQXchMAPrct4ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+NqUtAHnc3/aw8PgA43XQmn5ZHwrNCcdum221KCQrld0FbCzs4M588Vx3JXtBBbIveRQ7oFxVafdcMjrmcDhc8JvRjyxCUzrlPLlR6z4xIiNfivs3Nf5ug6eEEr3ST9kAJOUZK/4Xq/4oXv7TCCQ0KYlg4qy8+pFc1w7Hc0tgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewn7RLIM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730305905; x=1761841905;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5qXp4dv3iXZzbT2Gc/7Buqw70YKVFaQXchMAPrct4ds=;
  b=ewn7RLIMr1b91wFPNv66Fyi7C1/zcbQFxJ/JC90dCupCj0OhfoGo6r2l
   bG2euJen1DguNU9fQ2p9Z1UD91AXgG7EEQmPiiBMHDPn+czidNoNjtcw/
   FsFAz9fMkJNe4O99InsEBA11dkvjq3oEr8Sj6lelLnXOk0aHW/U+CScPU
   jYjrBb9djkiblsFW/halvANV96PqOB+IwqGejW00TVKqk0nlK508CbWCN
   uFWMZzoFahy39RLruclsjDvIpQbI02m5PbSFT5AcYY5tlKVHweXcRD6sR
   Jg0AX3MA1LrzfOu/swIsL9Aqmj/djiC31h/ta9b4qVCd+okbxAdCORUR4
   g==;
X-CSE-ConnectionGUID: NFRBXLTdT0qeuUJrqC6gWA==
X-CSE-MsgGUID: pEBRjnG5Q9e2qmXA5JUIAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41119427"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41119427"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:31:45 -0700
X-CSE-ConnectionGUID: wp9glxCYTyeqDKKR93s/oQ==
X-CSE-MsgGUID: +HdJOXKnSkOGAld+9AMIXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="86977264"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 30 Oct 2024 09:31:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 77AA81CF; Wed, 30 Oct 2024 18:31:41 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] PCI/bwctrl: Check for error code from devm_mutex_init() call
Date: Wed, 30 Oct 2024 18:31:39 +0200
Message-ID: <20241030163139.2111689-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even if it's not critical, the avoidance of checking the error code
from devm_mutex_init() call today diminishes the point of using devm
variant of it. Tomorrow it may even leak something. Add the missed
check.

Fixes: 9b3da6e19e4d ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/pcie/bwctrl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 3a93ed0550c7..2a19e441a901 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -299,7 +299,10 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
 	if (!data)
 		return -ENOMEM;
 
-	devm_mutex_init(&srv->device, &data->set_speed_mutex);
+	ret = devm_mutex_init(&srv->device, &data->set_speed_mutex);
+	if (ret)
+		return ret;
+
 	ret = devm_request_threaded_irq(&srv->device, srv->irq, NULL,
 					pcie_bwnotif_irq_thread,
 					IRQF_SHARED | IRQF_ONESHOT,
-- 
2.43.0.rc1.1336.g36b5255a03ac


