Return-Path: <linux-pci+bounces-24371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9041CA6BFEF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 17:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4904E3A0480
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 16:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DFD146A68;
	Fri, 21 Mar 2025 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AObQug3I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306BA4431;
	Fri, 21 Mar 2025 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574674; cv=none; b=aAtnOyPQsyxMNm47wuQYlKBY2hR3kP/TzenibvzHaSD2HQikdd9IsYSz17tvmNaiS7cClR/GnGWeR08wbAvf++p3VANlvgSdaL4JkI+HgNcA6ojUt1/0t9Ob7h6ee2C66mrucvdX2eYWIZVLUaTyNyzBX8MsWK3rI1fVayF7AlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574674; c=relaxed/simple;
	bh=qk1FgRT9nKq806J3+8LRLz6efr1jCwCfRF/YINU2gmg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AGVGjAWzi1yLbcY6yDTtLFtVv1DdL8uGTOO1WmJutAc9hKFf0uB5IRayM4W0/mE+Ri9gmzCbb8aDIHUvBn9tda6G2FeFMXVLWdtCk1h6zZ5x2QhP2ZxRLBy+0WJg+NnDkMzZG/G6NZ3Z7fXYVkQ7Zg+jXOogSwXmBZ3bk9q0eqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AObQug3I; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742574673; x=1774110673;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qk1FgRT9nKq806J3+8LRLz6efr1jCwCfRF/YINU2gmg=;
  b=AObQug3IkFq4R6qjLfwtvJtQ7vmuYmhFEKNtFDT5QsERFf+EjSxk3U2S
   AXwRL/4V4HIxSJYd31r6GgJBE3CKcNhprdUb7vYbDd3PWkg5szw7/yOFk
   lMMWNs9sEbdUWXI7k/CaLVE+IQsEATnkDLo+DhyEdnxu3Uof4DmVQVG+Z
   zqDF1EKzIXZdx0lmDnpXDaJc5SfxVEQVnRrdeZnYfj025cy69pMkdpvAm
   ygj4obQQstfq4lP4guoTiIWviaCA1IOmD/8BGpbUEZ4xSW8nolNvPgH/k
   wM0QwjHsr+nvA2PGmRyaGj94d8n1gxOeOC6lJh3UwmEvUbiQWMPqjvoJo
   w==;
X-CSE-ConnectionGUID: 6CBYiOQxRqmeTi3X1s9lkw==
X-CSE-MsgGUID: Ng/HDfCXSY6MMbb/Ufz0nQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="66310258"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="66310258"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 09:31:13 -0700
X-CSE-ConnectionGUID: t/4OqPb1T6yotiJ0kY2Esg==
X-CSE-MsgGUID: I6UVtcN7QVm+Q7K7r5M2LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="128557902"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 09:31:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] PCI/bwctrl: Fix link speed return type
Date: Fri, 21 Mar 2025 18:31:03 +0200
Message-Id: <20250321163103.5145-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pcie_bwctrl_select_speed() should take __fls() of the speed bit, not
return it as a raw value. Instead of directly returning 2.5GT/s speed
bit, simply assign the fallback speed (2.5GT/s) into supported_speeds
variable to share the normal return path that calls
pcie_supported_speeds2target_speed() to calculate __fls().

This code path is not very likely to execute because
pcie_get_supported_speeds() should provide valid ->supported_speeds but
a spec violating device could fail to synthetize any speed in
pcie_get_supported_speeds(). It could also happen in case the
supported_speeds intersection is empty (also a violation of the current
PCIe specs).

Fixes: de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/bwctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 0a5e7efbce2c..58ba8142c9a3 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -113,7 +113,7 @@ static u16 pcie_bwctrl_select_speed(struct pci_dev *port, enum pci_bus_speed spe
 		up_read(&pci_bus_sem);
 	}
 	if (!supported_speeds)
-		return PCI_EXP_LNKCAP2_SLS_2_5GB;
+		supported_speeds = PCI_EXP_LNKCAP2_SLS_2_5GB;
 
 	return pcie_supported_speeds2target_speed(supported_speeds & desired_speeds);
 }

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.39.5


