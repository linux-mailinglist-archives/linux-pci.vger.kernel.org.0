Return-Path: <linux-pci+bounces-18518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 689609F3573
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C5A77A312E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 16:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5EB1C9B9B;
	Mon, 16 Dec 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Na7cekmS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6599413B2AF;
	Mon, 16 Dec 2024 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365455; cv=none; b=HA9+H6y8xUf6ToWPfCVhTXGvM8okRUU0DnEC4R4VErEToNSkIc/nvS5CGbol3cHmRYePTEiW6rLL0YQQDbmwmkDJxTuYj3mENX4EFEDfp5TKLhRlyd+2cqVdG5RCPGHqjXO1E5VAuPedCj3/kY/UJY568bM5nSXV/2+9v572u5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365455; c=relaxed/simple;
	bh=j/8R7WJoDO6RfNflWfXR5RXnV1qmNJGf5O3f1LCn+y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocw+QYZCmQZrkb+jk0mWBrcIJ0o2NwVXo+XrTiDEILJhbewvWs9LRH6jBxaRirNlS2pU8OCTde3kQmKUB5ulaIJ+8W3o9CBrrGHiiaxO1SEgWCzDQm8rp+MDLT6oW1rt4Ws8ilyiLAg+gPzeTAyg//WqngmiFwcjXXwzIrX5fAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Na7cekmS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734365453; x=1765901453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j/8R7WJoDO6RfNflWfXR5RXnV1qmNJGf5O3f1LCn+y0=;
  b=Na7cekmSEvp1b/4hKEXBXVdTkqb+1ZuF7JswJ2FuNrMgthuinxn2gDI9
   fqd4GVMLkCIMB7xqZdvxOls7bArylY65yKAh8yj4ir99cSAK25RhIKjMM
   25YZStPBWYHK3jJZ2+fs8FIBXJK2MVxceVK5p9OBH91cfib/d7OBw/M7v
   lStjlH1FY6M42GXmIZ+wN3OEjTBEFUQHPm+mAWGUTXYOgu6RuuYs+Fnhd
   TEg65urglZMOil1gFgmodrJKxMVziyfQK0uuHDS1wuvCBxacGzSK4A6IX
   VOzT5IFIpY3JWI3FFNlj6znraWNp0PrtScuAsaPa9CuWST8qhdU3jnlYW
   Q==;
X-CSE-ConnectionGUID: eeG3cFVDSqeJp7ajcPhqQg==
X-CSE-MsgGUID: hvdUOasZTPOaNLeGQgNdfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45761392"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45761392"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 08:10:53 -0800
X-CSE-ConnectionGUID: wrjHuh+eSAuFg8ggGOFU2Q==
X-CSE-MsgGUID: 7efW7r51SWaBvrsH3B67mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="97015539"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 08:10:50 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 4/4] PCI: Descope pci_printk() to aer_printk()
Date: Mon, 16 Dec 2024 18:10:12 +0200
Message-Id: <20241216161012.1774-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216161012.1774-1-ilpo.jarvinen@linux.intel.com>
References: <20241216161012.1774-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

include/linux/pci.h provides low-level pci_printk() interface that is
only used by AER because it needs to print the same message with
different levels depending on the error severity. No other PCI code
uses that functionality and calls pci_<level>() logging functions
directly with the appropriate level.

Descope pci_printk() into AER as aer_printk().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 10 +++++++---
 include/linux/pci.h    |  3 ---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 80c5ba8d8296..bfc6b94dad4d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -17,6 +17,7 @@
 
 #include <linux/bitops.h>
 #include <linux/cper.h>
+#include <linux/dev_printk.h>
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
 #include <linux/sched.h>
@@ -35,6 +36,9 @@
 #include "../pci.h"
 #include "portdrv.h"
 
+#define aer_printk(level, pdev, fmt, arg...) \
+	dev_printk(level, &(pdev)->dev, fmt, ##arg)
+
 #define AER_ERROR_SOURCES_MAX		128
 
 #define AER_MAX_TYPEOF_COR_ERRS		16	/* as per PCI_ERR_COR_STATUS */
@@ -692,7 +696,7 @@ static void __aer_print_error(struct pci_dev *dev,
 		if (!errmsg)
 			errmsg = "Unknown Error Bit";
 
-		pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
+		aer_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
 				info->first_error == i ? " (First)" : "");
 	}
 	pci_dev_aer_stats_incr(dev, info);
@@ -715,11 +719,11 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 
 	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
 
-	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
+	aer_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
 		   aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
 
-	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
+	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
 		   dev->vendor, dev->device, info->status, info->mask);
 
 	__aer_print_error(dev, info);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index db9b47ce3eef..02d23e795915 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2685,9 +2685,6 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 
 #include <linux/dma-mapping.h>
 
-#define pci_printk(level, pdev, fmt, arg...) \
-	dev_printk(level, &(pdev)->dev, fmt, ##arg)
-
 #define pci_emerg(pdev, fmt, arg...)	dev_emerg(&(pdev)->dev, fmt, ##arg)
 #define pci_alert(pdev, fmt, arg...)	dev_alert(&(pdev)->dev, fmt, ##arg)
 #define pci_crit(pdev, fmt, arg...)	dev_crit(&(pdev)->dev, fmt, ##arg)
-- 
2.39.5


