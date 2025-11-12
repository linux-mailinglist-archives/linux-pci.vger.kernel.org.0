Return-Path: <linux-pci+bounces-40958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EB5C50FE6
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 08:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 820C44E2F48
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 07:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC15E2F12A3;
	Wed, 12 Nov 2025 07:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8oe+Zjo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30C42ECEA7
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933580; cv=none; b=dDTCx7hZAQWNKr5CrVeF8JLbSL2+uxL/ybZKa+ZW9TSu7zdHFIbFc3JWmZ1haWE7G13rdSyIV/w4SuJYRB6hfq0GszLHhdRPA3vMo/HVqJQeY1SdHlUmdQCnvVq3ayN2i9SvCoIuggeKppE2yF6xLztH4gnTNT6EWBdJ2vz8yBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933580; c=relaxed/simple;
	bh=Cl1tTuVvknF5bKZDbnFljdj0Z2F2e/YcmqWWiP+O1d8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nh5n0UAjhJRDmhZ1Bw/bbkFTO2nEFjbaeCvZykKEBVHZ0qb2+5xlbNaPPjtctlqeydb9ADjEuJbXRWNFaHNE5kRndOeBS/0+vqkFNACDLLDYz16TkTX6QyFCu/WdpIqgg1pJfktpKmkMUO1J0RNnSzLPasYEysuMckaRDFiyLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8oe+Zjo; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762933578; x=1794469578;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Cl1tTuVvknF5bKZDbnFljdj0Z2F2e/YcmqWWiP+O1d8=;
  b=C8oe+ZjoXJiRD9XPNVUYJ73JdZs6wxcJnB1xRkN6fKdybxOYemyIpe3U
   ms4g+cn13TXJQEHuYvpNZ3MiOEUmY8+x36Q2SMcmpO1o2AkDkfFn3iUkM
   TV0rHEz1iG7F+T8rVErYHs92e7N82BH6nhOE+snEhTqTGe6wVY9d/69Hf
   FprFs5ZXHNLTHhaeRsbj1xp0C7jgsWL43bj+4reiqAAVhTt9edcFlgzP4
   MfZ8JfP47azJkkD9cJMfek8yMjZAhK2M0uhvSkk/TzrOJX1b/sg+VuvWu
   0TIMOE10esQX8nOQAEC6eHtpnI/RZlxp8q/LSlAKZzsx9ncO9NesuF5RD
   Q==;
X-CSE-ConnectionGUID: xDBTmYSrQhOc/3IepbYr3g==
X-CSE-MsgGUID: fXS4aThuSqulL8J1lO9H1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="76451279"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="76451279"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 23:46:18 -0800
X-CSE-ConnectionGUID: gqfvcd2QR7q5tmCEK/PXeg==
X-CSE-MsgGUID: EYa5MY5pThqKuNVRaFA6sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="188412133"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 11 Nov 2025 23:46:16 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id CE7B595; Wed, 12 Nov 2025 08:46:14 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v5] PCI/PTM: Enable PTM only if it advertises a role
Date: Wed, 12 Nov 2025 08:46:14 +0100
Message-ID: <20251112074614.1440266-1-mika.westerberg@linux.intel.com>
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
Hi,

I hope I did not make any stupid mistakes this time ;-) My testing still
passed: the Root Port that has ->ptm_root (and ->ptm_responder) PTM is
enabled and the Switch Upstream Port that does not have ->ptm_responder is
not enabled (and I don't see the flood of AER errors).

Previous versions can be seen:

  v4: https://lore.kernel.org/linux-pci/20251111061048.681752-1-mika.westerberg@linux.intel.com/
  v3: https://lore.kernel.org/linux-pci/20251030134606.3782352-1-mika.westerberg@linux.intel.com/
  v2: https://lore.kernel.org/linux-pci/20251028060427.2163115-1-mika.westerberg@linux.intel.com/
  v1: https://lore.kernel.org/linux-pci/20251021104833.3729120-1-mika.westerberg@linux.intel.com/

Changes from v4:

  - Do not enable PTM automatically for all components (e.g keep the
    existing behavior).
  - Make the switch-case new lines consistent.

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

 drivers/pci/pcie/ptm.c | 35 +++++++++++++++++++++++++++++++++++
 include/linux/pci.h    |  2 ++
 2 files changed, 37 insertions(+)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 65e4b008be00..fb1f3d0d8448 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -81,6 +81,11 @@ void pci_ptm_init(struct pci_dev *dev)
 		dev->ptm_granularity = 0;
 	}
 
+	if (cap & PCI_PTM_CAP_RES)
+		dev->ptm_responder = 1;
+	if (cap & PCI_PTM_CAP_REQ)
+		dev->ptm_requester = 1;
+
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
 	    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
 		pci_enable_ptm(dev, NULL);
@@ -144,6 +149,36 @@ static int __pci_enable_ptm(struct pci_dev *dev)
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
+	case PCI_EXP_TYPE_ENDPOINT:
+	case PCI_EXP_TYPE_LEG_END:
+		/*
+		 * PCIe Endpoint must declare Requester Capable before we
+		 * can enable PTM for it.
+		 */
+		if (!dev->ptm_requester)
+			return -EINVAL;
+		break;
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


