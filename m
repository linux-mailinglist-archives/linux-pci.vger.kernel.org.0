Return-Path: <linux-pci+bounces-40823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAF4C4B9DF
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 07:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4753A837F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 06:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD9E2BCF68;
	Tue, 11 Nov 2025 06:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F4m8Imv6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E806429E101
	for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2025 06:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762841533; cv=none; b=tqRyxijUWsJHYeNfXc0B5Q8iapOrvLhxxshmZ6u2TjGstbVEJ83+gZswSiIXJGv/8Yx71qH/9Ci4bdGbRwsyGTgC8cn40q4x4w6iCoLaowEpEEacO2Q3bQO36RHJ/8+Jwb9hMQ9H22ApUT/y3oN4rAMiu6J8XHl09WLCqTtrQxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762841533; c=relaxed/simple;
	bh=fCP2AgHUxsJh0c9vX7ENI+nVcyMN9tY1e6fziP1tnjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D0mRzwzRzFUp9L0xjxtOPvFA6MX3KUMzZKvIOhX/LH5A8bJDegDwTzrWpJMdoWfQYq72nkRXfXhRD+XAn9cezVicdxfbR9t7r+l8fq65A85TdjISRyjnidQFhCjEea8iFNi1QgfnCxpcyQg1UE30lRUNw7Qhh4/52AgvEcm3ZME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F4m8Imv6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762841532; x=1794377532;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fCP2AgHUxsJh0c9vX7ENI+nVcyMN9tY1e6fziP1tnjY=;
  b=F4m8Imv6kvmhmybBCUVyflYtcQ6xV45CS9RlkNhV1rI+w36hXFesVt5z
   8ag99EgptqTv8HCdMzYFImLmSCo5hzk0zUKc7sFSKjtFTRjGKtZyEKdT4
   /LkUweGX1dv3WIRAGlSf/rT8P/zNdziAIqxeLILDXw0SaDRQSb7EoEuKj
   1srS7+whbc6V1Z6LWmzADkCYLDmVHG3K0pyUmx+etbmODEVLYR0DMGJ3K
   zYe9rEZv7a1W0x+Ryu9HbRpTM5Adpw10FGNzi03LCBODTRr8MfFb9wDpm
   9WM/JEa4n4JuQHxbJUWsTeKh0doHrXRQATgy5prLwKbNZz+Wi/TSSD7S5
   A==;
X-CSE-ConnectionGUID: Tev+eE41SuOWQveYXz//Fw==
X-CSE-MsgGUID: NHc0r8cpRy6hsvUDTZwoDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="52457653"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="52457653"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 22:10:51 -0800
X-CSE-ConnectionGUID: yD+LiCxwSP27ckDJcL6QWA==
X-CSE-MsgGUID: iL8L1cwxTDqT38LBDCH3jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="188842816"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 10 Nov 2025 22:10:50 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id C9C4A95; Tue, 11 Nov 2025 07:10:48 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v4] PCI/PTM: Enable PTM only if it advertises a role
Date: Tue, 11 Nov 2025 07:10:48 +0100
Message-ID: <20251111061048.681752-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have a Upstream Port (2b:00.0) that has following in the PTM capability:

  Capabilities: [220 v1] Precision Time Measurement
		PTMCap: Requester- Responder- Root-

Linux enables PTM for this without looking into what roles it actually
supports. Immediately after enabling PTM we start getting these:

  pci 0000:2b:00.0: [8086:5786] type 01 class 0x060400 PCIe Switch Upstream Port
  ...
  pci 0000:2b:00.0: PTM enabled, 4ns granularity
  ...
  pcieport 0000:00:07.1: AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:00:07.1
  pcieport 0000:00:07.1: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Receiver ID)
  pcieport 0000:00:07.1:   device [8086:e44f] error status/mask=00200000/00000000
  pcieport 0000:00:07.1:    [21] ACSViol                (First)
  pcieport 0000:00:07.1: AER:   TLP Header: 0x34000000 0x00000052 0x00000000 0x00000000

Fix this by enabling PTM only if any of the following conditions are
true (see more in PCIe r7.0 sec 6.21.1 figure 6-21):

  - PCIe Endpoint that has PTM capability must to declare requester
    capable
  - PCIe Switch Upstream Port that has PTM capability must declare
    at least responder capable
  - PCIe Root Port must declare root port capable.

While there make the enabling happen for all in __pci_enable_ptm() instead
of enabling some in pci_ptm_init() and some in __pci_enable_ptm().

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Previous versions can be seen:

  v3: https://lore.kernel.org/linux-pci/20251030134606.3782352-1-mika.westerberg@linux.intel.com/
  v2: https://lore.kernel.org/linux-pci/20251028060427.2163115-1-mika.westerberg@linux.intel.com/
  v1: https://lore.kernel.org/linux-pci/20251021104833.3729120-1-mika.westerberg@linux.intel.com/

Changes from v3:

  - Cache the responder and requester capability bits.
  - Enable PTM only in __pci_enable_ptm().
  - Update $subject and commit message.
  - Since this is changed quite a lot, I dropped the Reviewed-by from Lukas
    and also stable tag.

Changes from v2:

  - Limit the check in __pci_enable_ptm() to Endpoints and Legacy
    Endpoints.
  - Added stable tags suggested by Lukas, and PCIe spec reference.
  - Added Reviewed-by tag from Lukas (hope it is okay to keep).

Changes from v1:

  - Limit Switch Upstream Port only to Responder, not both Requester and
    Responder.

 drivers/pci/pcie/ptm.c | 41 ++++++++++++++++++++++++++++++++++++++---
 include/linux/pci.h    |  2 ++
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 65e4b008be00..30e25f1ad28e 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -81,9 +81,12 @@ void pci_ptm_init(struct pci_dev *dev)
 		dev->ptm_granularity = 0;
 	}
 
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
-	    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
-		pci_enable_ptm(dev, NULL);
+	if (cap & PCI_PTM_CAP_RES)
+		dev->ptm_responder = 1;
+	if (cap & PCI_PTM_CAP_REQ)
+		dev->ptm_requester = 1;
+
+	pci_enable_ptm(dev, NULL);
 }
 
 void pci_save_ptm_state(struct pci_dev *dev)
@@ -144,6 +147,38 @@ static int __pci_enable_ptm(struct pci_dev *dev)
 			return -EINVAL;
 	}
 
+	switch (pci_pcie_type(dev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+		/*
+		 * Root Port must declare Root Capable if we want to enable
+		 * PTM for it.
+		 */
+		if (!dev->ptm_root)
+			return -EINVAL;
+		break;
+	case PCI_EXP_TYPE_UPSTREAM:
+		/*
+		 * Switch Upstream Ports must at least declare Responder
+		 * Capable if we want to enable PTM for it.
+		 */
+		if (!dev->ptm_responder)
+			return -EINVAL;
+		break;
+
+	case PCI_EXP_TYPE_ENDPOINT:
+	case PCI_EXP_TYPE_LEG_END:
+		/*
+		 * PCIe Endpoint must declare Requester Capable before we
+		 * can enable PTM for it.
+		 */
+		if (!dev->ptm_requester)
+			return -EINVAL;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
 	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, &ctrl);
 
 	ctrl |= PCI_PTM_CTRL_ENABLE;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1fdf81fbe1e..d5018cb5c331 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -500,6 +500,8 @@ struct pci_dev {
 #ifdef CONFIG_PCIE_PTM
 	u16		ptm_cap;		/* PTM Capability */
 	unsigned int	ptm_root:1;
+	unsigned int	ptm_responder:1;
+	unsigned int	ptm_requester:1;
 	unsigned int	ptm_enabled:1;
 	u8		ptm_granularity;
 #endif
-- 
2.50.1


