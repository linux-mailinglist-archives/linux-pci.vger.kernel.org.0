Return-Path: <linux-pci+bounces-39499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 888BFC130E3
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 07:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C6754E1AFF
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 06:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0E623BD17;
	Tue, 28 Oct 2025 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c8P2PQvf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A01F1C3F0C
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 06:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761631473; cv=none; b=oRREPnJG79EbVkK2VVQvnJkg3LTvP28XOel7sMQ7tgbpJjAl985iDFm7Z+UVFNBGENbjJLnn0i6HSoHeKEuTRfUBp6sZpu1CVpsXu7fe5jfsk6ewnGvBkvjshdwmSDQVFkz4kHpUjRoQrmIp9uFLw+nwve8i7oQI38Z1wRMnKZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761631473; c=relaxed/simple;
	bh=sJquROINHU0vD6xFgwqX0QHgbOdJoNLb4XGCof7zuaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUfEcKtX+PJu73nS1Di2MI4brT6muI404SW8rvf0xNJHyC64jQKhVt4O/Hj5DQ3JvSPJFseDkBMye7Gg+X5mmKPtQfVmCse/zplOqZOWnlWdo+yGo+iH4vn8W+JYHTjOitzJMhC2JnnspV3lEYaDOfKOe/6yXATfKtrdi4BJHH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c8P2PQvf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761631472; x=1793167472;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sJquROINHU0vD6xFgwqX0QHgbOdJoNLb4XGCof7zuaI=;
  b=c8P2PQvfAXHbZ024H7Q70qEHTJ2eMzgvit0sbmIVPomKebE+iq8V2otg
   l685QuIL00mB4LYtA1JabCdNBE3t+DvIB67k/20NAbSZugLsgiCJodHq9
   4uIYa3LA2tgQgcF7QJgpyfpJelm5nutgClNwJwdd/caBoWvOFuFBlEcXu
   Vd0tWcuulUuwmn3xuF6pKl+QHR41WbyXxRWWRNUn1gLUHb9VL2f2A+zA1
   soUlJXWapxXSvt+u5lDut40RDoDPS4uQyL2d53VmmXDsV3zD9CMjGTZ+k
   lcShJqdrqXcUZheFgSxX33F0psoC8hUP0wgCN4ntFaBKa5VXgG3sjJNYF
   A==;
X-CSE-ConnectionGUID: erOPQ0xCSqODARjKBCOLVQ==
X-CSE-MsgGUID: hTvsrYE/TTOMRuLlb8Vtug==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74009866"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="74009866"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 23:04:31 -0700
X-CSE-ConnectionGUID: YPm0M2E1R82st+gKdsS/+w==
X-CSE-MsgGUID: GVJzy0CEQzeU3h+t6oq0Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="222462051"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 27 Oct 2025 23:04:28 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 4410095; Tue, 28 Oct 2025 07:04:27 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2] PCI/PTM: Do not enable PTM solely based on the capability existense
Date: Tue, 28 Oct 2025 07:04:27 +0100
Message-ID: <20251028060427.2163115-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is not advisable to enable PTM solely based on the fact that the
capability exists. Instead there are separate bits in the capability
register that need to be set for the feature to be enabled for a given
component (this is suggestion from Intel PCIe folks):

  - PCIe Endpoint that has PTM capability must to declare requester
    capable
  - PCIe Switch Upstream Port that has PTM capability must declare
    at least responder capable
  - PCIe Root Port must declare root port capable.

Currently we see following:

  pci 0000:01:00.0: [8086:5786] type 01 class 0x060400 PCIe Switch Upstream Port
  pci 0000:01:00.0: PCI bridge to [bus 00]
  pci 0000:01:00.0:   bridge window [io  0x0000-0x0fff]
  pci 0000:01:00.0:   bridge window [mem 0x00000000-0x000fffff]
  pci 0000:01:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
  ...
  pci 0000:01:00.0: PTM enabled, 4ns granularity
  ...
  pcieport 0000:00:07.0: AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:00:07.0
  pcieport 0000:00:07.0: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Receiver ID)
  pcieport 0000:00:07.0:   device [8086:e44e] error status/mask=00200000/00000000
  pcieport 0000:00:07.0:    [21] ACSViol                (First)

The 01:00.0 PCIe Upstream Port has this:

  Capabilities: [220 v1] Precision Time Measurement
		PTMCap: Requester- Responder- Root-

This happens because Linux sees the PTM capability and blindly enables
PTM which then causes the AER error to trigger.

Fix this by enabling PTM only if the above described criteria is met.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Previous version can be seen:

  https://lore.kernel.org/linux-pci/20251021104833.3729120-1-mika.westerberg@linux.intel.com/

Changes from the previous version:

  - Limit Switch Upstream Port only to Responder, not both Requester and
    Responder.

 drivers/pci/pcie/ptm.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 65e4b008be00..5ebb2edb4dec 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -81,9 +81,24 @@ void pci_ptm_init(struct pci_dev *dev)
 		dev->ptm_granularity = 0;
 	}
 
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
-	    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
-		pci_enable_ptm(dev, NULL);
+	switch (pci_pcie_type(dev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+		/*
+		 * Root Port must declare Root Capable if we want to
+		 * enable PTM for it.
+		 */
+		if (dev->ptm_root)
+			pci_enable_ptm(dev, NULL);
+		break;
+	case PCI_EXP_TYPE_UPSTREAM:
+		/*
+		 * Switch Upstream Ports must at least declare Responder
+		 * Capable if we want to enable PTM for it.
+		 */
+		if (cap & PCI_PTM_CAP_RES)
+			pci_enable_ptm(dev, NULL);
+		break;
+	}
 }
 
 void pci_save_ptm_state(struct pci_dev *dev)
@@ -125,7 +140,7 @@ static int __pci_enable_ptm(struct pci_dev *dev)
 {
 	u16 ptm = dev->ptm_cap;
 	struct pci_dev *ups;
-	u32 ctrl;
+	u32 cap, ctrl;
 
 	if (!ptm)
 		return -EINVAL;
@@ -144,6 +159,14 @@ static int __pci_enable_ptm(struct pci_dev *dev)
 			return -EINVAL;
 	}
 
+	/*
+	 * PCIe Endpoint must declare Requester Capable before we can
+	 * enable PTM for it.
+	 */
+	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
+	if (!(cap & PCI_PTM_CAP_REQ))
+		return -EINVAL;
+
 	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, &ctrl);
 
 	ctrl |= PCI_PTM_CTRL_ENABLE;
-- 
2.50.1


