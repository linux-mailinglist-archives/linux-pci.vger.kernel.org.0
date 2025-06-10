Return-Path: <linux-pci+bounces-29307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E321AD339C
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 12:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051C5170AF2
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 10:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CC928BA9A;
	Tue, 10 Jun 2025 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lkonb9Rk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F3521CC71;
	Tue, 10 Jun 2025 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749551540; cv=none; b=L+V//jUM56RWqQDf7IynKMkg0lYi9d4Q4MHSwklyQuMU7g5A2CN2J3rFx+2e6KDJEHgy2/pT2I17dYJvcjlBkACNsQnZPyr3HnzZBf6blctUQe8k+zIBPxBf3HbXo/8eybOYU2KeafqoIvAN8fuFxSgbFObHfLex5vqtM4TDBiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749551540; c=relaxed/simple;
	bh=IPp90NO5h9XEYHLZy6ESP2Rd2kiZvvvgqq223uHkbGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Z1XxmdiZHAiFWgnY9duAU110a7nCAM7QjaPWxjpdyS42ERBkFkuizGTr1nsEBLUK4OSdWdtjXIUh/Q1DbcXIvrXTVatP4QLC5CiuS+61SOjTAC7jibsPh9sXiU8L/yvL/TDkVia6IVT7Nj6zrA4b6XciKESxIyV+JFXZ9bcRkMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lkonb9Rk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749551538; x=1781087538;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IPp90NO5h9XEYHLZy6ESP2Rd2kiZvvvgqq223uHkbGY=;
  b=Lkonb9RkHjvYrEa5vWeoa7wB3Ojwbtp30wqC8R3HAvRIC4pwMFrqov1W
   ZFE7fn88aV+Fl+hoiim75AZ1JEoQKTxHF4Zma9dkyI7TB9bsBUma5gwOK
   ZKK4R5I5CXipHs0uxeSa+l+4fNa+bmIk/0pqP6q1nZkFxL1D7UoIs8vY3
   5IpqYIfCcYC6AovElYkXjYUF9dWO1ItOhdeapHJ6YXWnV3Raa1Y3QEpEW
   76v5jRkURgdRb6stOh0mEYZ3UMdVavHvC0cwZSkCtGuK+vQCvWUg+YMxB
   zkWR/jeW6dB/8kWFACw6vnp8e/w8xz4t1QhQn8if36e29hRKvbtDqFeTD
   Q==;
X-CSE-ConnectionGUID: xvVcW1bDT9m6ShMCL0BfOg==
X-CSE-MsgGUID: KRsjs51QRzGRmOCBE/d6kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55447204"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="55447204"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:32:16 -0700
X-CSE-ConnectionGUID: bynyP4HYTX+P13MW4d/vJg==
X-CSE-MsgGUID: R/v4VHa8Q5ieT8qln5fe4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="151670936"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:32:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/3] cxgb3: Replace PCI related literals with defines & correct variable
Date: Tue, 10 Jun 2025 13:32:03 +0300
Message-Id: <20250610103205.6750-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace literals 0, 2, 0x1425 with PCI_VENDOR_ID, PCI_DEVICE_ID,
PCI_VENDOR_ID_CHELSIO, respectively. Rename devid variable to vendor_id
to remove confusion.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/ethernet/chelsio/cxgb3/t3_hw.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c b/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
index a06003bfa04b..4e917a578c77 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
@@ -30,6 +30,8 @@
  * SOFTWARE.
  */
 #include <linux/etherdevice.h>
+#include <linux/pci.h>
+
 #include "common.h"
 #include "regs.h"
 #include "sge_defs.h"
@@ -3262,7 +3264,7 @@ static void config_pcie(struct adapter *adap)
 	pcie_capability_read_word(adap->pdev, PCI_EXP_DEVCTL, &val);
 	pldsize = (val & PCI_EXP_DEVCTL_PAYLOAD) >> 5;
 
-	pci_read_config_word(adap->pdev, 0x2, &devid);
+	pci_read_config_word(adap->pdev, PCI_DEVICE_ID, &devid);
 	if (devid == 0x37) {
 		pcie_capability_write_word(adap->pdev, PCI_EXP_DEVCTL,
 					   val & ~PCI_EXP_DEVCTL_READRQ &
@@ -3477,7 +3479,7 @@ static void mac_prep(struct cmac *mac, struct adapter *adapter, int index)
 	u16 devid;
 
 	mac->adapter = adapter;
-	pci_read_config_word(adapter->pdev, 0x2, &devid);
+	pci_read_config_word(adapter->pdev, PCI_DEVICE_ID, &devid);
 
 	if (devid == 0x37 && !adapter->params.vpd.xauicfg[1])
 		index = 0;
@@ -3528,7 +3530,7 @@ int t3_reset_adapter(struct adapter *adapter)
 {
 	int i, save_and_restore_pcie =
 	    adapter->params.rev < T3_REV_B2 && is_pcie(adapter);
-	uint16_t devid = 0;
+	u16 vendor_id = 0;
 
 	if (save_and_restore_pcie)
 		pci_save_state(adapter->pdev);
@@ -3540,12 +3542,12 @@ int t3_reset_adapter(struct adapter *adapter)
 	 */
 	for (i = 0; i < 10; i++) {
 		msleep(50);
-		pci_read_config_word(adapter->pdev, 0x00, &devid);
-		if (devid == 0x1425)
+		pci_read_config_word(adapter->pdev, PCI_VENDOR_ID, &vendor_id);
+		if (vendor_id == PCI_VENDOR_ID_CHELSIO)
 			break;
 	}
 
-	if (devid != 0x1425)
+	if (vendor_id != PCI_VENDOR_ID_CHELSIO)
 		return -1;
 
 	if (save_and_restore_pcie)

base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.39.5


