Return-Path: <linux-pci+bounces-38871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD5FBF5DFB
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 12:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B293424E1E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 10:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10B12F0C67;
	Tue, 21 Oct 2025 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4hn0HpM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCF232ABFE
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043718; cv=none; b=TfRqMyh5OlzFFsca8H4WrN0HA6+2+H6k84pyiHMKDaQrIMLoejNy7K/+FB4wfKZ+CeSso/o+xdGUxA0zbxpG+iOpwZ4YKGRJJp7l9a9bf9jOEZacNEtR2cfPVQyp7oTNNIw/r7AFtCSItI00hHvWXS+BYh8vG2DOIQHGVfcfw00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043718; c=relaxed/simple;
	bh=olJmFGlKFNLp0pg07TkKmR6050oXI4IGIcOyPRNd8Og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fmSvVjpo0vFSqKoKf7UbQ9DkEOdbt6PxRswVUZ4iEJj/+Ugq+pz6uyzx/uc7zt9M4+3pO03mwe8jnStQ6WOTpSca4IECNjHJKw8sIgFtY5UwVo5N2cBqr8Bs2NNMejgOeyx3cdYeQNMdy/JHPyGNynFoEo4XqUI4321uY2sSUpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4hn0HpM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761043717; x=1792579717;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=olJmFGlKFNLp0pg07TkKmR6050oXI4IGIcOyPRNd8Og=;
  b=H4hn0HpMdGou+aWyZhtnfbZsT04RcQ8rp2wtoE7Nwr8AnPiztGLE3zDu
   l3mp+miLaJZgT3jSd0rQIgVHxVArYX942CI+UdGAu6Ls0WYMfw9b4KQBn
   IpJYCcSFWeFeEAWQjtaBEQ+0kikAkkBlhEsxOW87Qt5maGpLX0GgVCe29
   tjniKQvCyieceQ+1bWUpmGiB3ZQ9qVm/JmjVRr5b/lk5CZwXAc6gNTq2/
   G71c/3+Ae6kqzWH7fuzd5d3ebN+D5jW86GQvYeOUrJdbcovvoH0Lpsl+7
   Pb5SHQ2Mk0B/qA8KRe4j091ZULsp4YvCtsGb3Xi1zhBsspv4lrcENQSzm
   A==;
X-CSE-ConnectionGUID: f7OtXeJEQA6ko8cQGAZmsw==
X-CSE-MsgGUID: OLNMxHDRTFq+k3WSi+FrBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63087652"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63087652"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 03:48:36 -0700
X-CSE-ConnectionGUID: 97xsNhDdSYiNeWC6oH0QQg==
X-CSE-MsgGUID: F4QFdYCkTbmPlnqrjggoPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="214192976"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 21 Oct 2025 03:48:34 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 92F8195; Tue, 21 Oct 2025 12:48:33 +0200 (CEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] PCI/PTM: Do not enable PTM solely based on the capability existense
Date: Tue, 21 Oct 2025 12:48:33 +0200
Message-ID: <20251021104833.3729120-1-mika.westerberg@linux.intel.com>
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
    both requester and responder capable
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
 drivers/pci/pcie/ptm.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 65e4b008be00..8dcc3469dc09 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -81,9 +81,26 @@ void pci_ptm_init(struct pci_dev *dev)
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
+		 * Switch Upstream Ports must declare both Requester
+		 * Capable and Responder Capable if we want to enable
+		 * PTM for it.
+		 */
+		if ((cap & (PCI_PTM_CAP_REQ | PCI_PTM_CAP_RES)) ==
+		    (PCI_PTM_CAP_REQ | PCI_PTM_CAP_RES))
+			pci_enable_ptm(dev, NULL);
+		break;
+	}
 }
 
 void pci_save_ptm_state(struct pci_dev *dev)
@@ -125,7 +142,7 @@ static int __pci_enable_ptm(struct pci_dev *dev)
 {
 	u16 ptm = dev->ptm_cap;
 	struct pci_dev *ups;
-	u32 ctrl;
+	u32 cap, ctrl;
 
 	if (!ptm)
 		return -EINVAL;
@@ -144,6 +161,14 @@ static int __pci_enable_ptm(struct pci_dev *dev)
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


