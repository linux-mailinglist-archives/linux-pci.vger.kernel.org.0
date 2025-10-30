Return-Path: <linux-pci+bounces-39813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E22AC20532
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 14:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197C93A022D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 13:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81636211499;
	Thu, 30 Oct 2025 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CG1MzdGo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A141C2BD
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831972; cv=none; b=DmXFwV6q8IJ80939It1hX7nXHp7VwIxhaEnjF30XR/BI1k227KnWalCK8Xw8SbXOZtRs/muw8prE6CfOgi1nZiI6E3P7RD3c3iuCQgZgMT/vtwjT20SmOoX5NErDCHfFnqAcr22xZA/5HSlczGbornB25MkSAHgxOQbbf0CSIWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831972; c=relaxed/simple;
	bh=61P7J9QVGsedny9GgKTZplZSB1BHy2cadMt5RyutqQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W8jERL1YVzOxqx5hGUtERCS28j7R5/MMGNORQbQUE0CYwklKgNkYS1GvMyei0IBqu6YPhLOlQi1MS0+p0mIyhhu3u+XuiYyezL/1wC5A0/06i8PDs0oBl8E/SWo0SKauIjX0Uay+9nmQFk4/ezJ/i9ASmf2OxP16lCZ+cHU0WVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CG1MzdGo; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761831969; x=1793367969;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=61P7J9QVGsedny9GgKTZplZSB1BHy2cadMt5RyutqQs=;
  b=CG1MzdGoSekpFFYOHWAKZUkpxgOykapzuk0bwEXaACmivqwDHngKweMb
   AAlzEsKOGKh5ro0dsuPOEeQIAyWr8RZycSy7rc+qT3RPhNgr3dxr7/UDZ
   6865P5Tc1hKbaGsYJIkyr5obv0szRQchF/a9iruHoga62n1RGjKiFs0yV
   0uSdqHW+80qQSKamqDoQ9xvOdQY4pbTeTRcddyFxyR54GfyQ3Z5oHom11
   PdibKgg9kbpcbjiJv1kxEMWdCiQ/ah41I0Hzi07oqzjX6F2gitPDM1VQB
   2fIOkRf+w+GUnzqY9h9bWe0mpnmAV5C4S4Wt8/KIQjVZXWxAQuKt1obfy
   g==;
X-CSE-ConnectionGUID: PbM39yWwRbmmEBkLudGTGg==
X-CSE-MsgGUID: ywpJhic8Rliwq5Hbca/FGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="74649862"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="74649862"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 06:46:08 -0700
X-CSE-ConnectionGUID: +d0xjpSoRmWi0770azlRKA==
X-CSE-MsgGUID: 7gp3f8gIRliqarBITNdsyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="185160617"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 30 Oct 2025 06:46:07 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 05B7896; Thu, 30 Oct 2025 14:46:06 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v3] PCI/PTM: Do not enable PTM solely based on the capability existense
Date: Thu, 30 Oct 2025 14:46:05 +0100
Message-ID: <20251030134606.3782352-1-mika.westerberg@linux.intel.com>
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
component (this is suggestion from Intel PCIe folks, and also shown in
PCIe r7.0 sec 6.21.1 figure 6-21):

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

Fixes: 9bb04a0c4e26 ("PCI: Add Precision Time Measurement (PTM) support")
Cc: stable@vger.kernel.org  # v4.9+
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Previous versions can be seen:

  v2: https://lore.kernel.org/linux-pci/20251028060427.2163115-1-mika.westerberg@linux.intel.com/
  v1: https://lore.kernel.org/linux-pci/20251021104833.3729120-1-mika.westerberg@linux.intel.com/

Changes from v2:

  - Limit the check in __pci_enable_ptm() to Endpoints and Legacy
    Endpoints.
  - Added stable tags suggested by Lukas, and PCIe spec reference.
  - Added Reviewed-by tag from Lukas (hope it is okay to keep).

Changes from v1:

  - Limit Switch Upstream Port only to Responder, not both Requester and
    Responder.

 drivers/pci/pcie/ptm.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 65e4b008be00..3381bfeaccd7 100644
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
@@ -144,6 +159,18 @@ static int __pci_enable_ptm(struct pci_dev *dev)
 			return -EINVAL;
 	}
 
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_LEG_END) {
+		u32 cap;
+		/*
+		 * PCIe Endpoint must declare Requester Capable before we
+		 * can enable PTM for it.
+		 */
+		pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
+		if (!(cap & PCI_PTM_CAP_REQ))
+			return -EINVAL;
+	}
+
 	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, &ctrl);
 
 	ctrl |= PCI_PTM_CTRL_ENABLE;
-- 
2.50.1


