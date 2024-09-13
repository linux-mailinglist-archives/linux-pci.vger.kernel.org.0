Return-Path: <linux-pci+bounces-13178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2AB9782B6
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 16:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340721F25C5B
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 14:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198AF10A0D;
	Fri, 13 Sep 2024 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6Sy3716"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DD34AEE5;
	Fri, 13 Sep 2024 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238252; cv=none; b=NOxPppIrK0YXkSU+QHdy6TICvTVG6pjt4mFG57IxoB1jydxGh1HpJiV6lPrGjgI9wcQLAOLojEhUMTOWfRG6suHeazQi/n4DQxNgdO3LgOJRgS6xdSHYdGsuvV4jnGF4ya0fZWTGQB3ydq9KM6Q9Qsuv/CDYvs6JJ+eG7fF6AAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238252; c=relaxed/simple;
	bh=CObroKMsuCCxZkpibBqwhoNhRrODaIbk4K5GP0O+fy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCOAh9DSBduKmaHniYj7y5pNoOAK5jtHEE1XCtKU8R8ARwqDf9vA4ANRq27E9vZGGcJWx0+4Playm8H+hxjIktZQeCEInhBkvmZWPO8demjjKxKHf8Q/7dJADecZsZsKJTC3YpbIkQBROLk5BZQ+cOt/ADCRV3Eyc6xRrgSKlwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6Sy3716; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726238251; x=1757774251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CObroKMsuCCxZkpibBqwhoNhRrODaIbk4K5GP0O+fy4=;
  b=A6Sy3716SNAk4t7o7fBpfw1zJmiv4cppyeg3Ulj9UxcfUAOGeUCVDUMN
   InEPYPAOfBvkNEJWOdUIYABGIgVPa5/uEovRqcN19gzMJGooutjxtIrlX
   U6AHKa1twT3N5Z1FyxxOHZJP6kFqo8i0qvz+j6pA8rkxt/OmXSt2MLOql
   sVEDg7n8FZ6IWzL0F2j6TDMis6H0MERbZ7rZXBnqKy6f6bCw+3l8czjM8
   0ZIA/HsOplBXx8WHBBZ3OnDw09En2gr4a9WyNdDYuwqD3Zi8JOE6HEqXX
   L7ZJr+SSeFJXTho3SWS7ba94krcK1reqT8oW5cuLW3/efSZhmpMt57dHp
   w==;
X-CSE-ConnectionGUID: pIHG1+E7RySlFvAE/qeIJQ==
X-CSE-MsgGUID: iIP+QNDyRFWZV/26lfCRRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="28886534"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="28886534"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 07:37:30 -0700
X-CSE-ConnectionGUID: 5/PqCEjtS3ScAD/FUFVx/w==
X-CSE-MsgGUID: mz4Wy4HyTAqNBAK/v+hXEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="68400293"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.154])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 07:37:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v6 5/8] PCI: Store # of supported End-End TLP Prefixes
Date: Fri, 13 Sep 2024 17:36:29 +0300
Message-Id: <20240913143632.5277-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240913143632.5277-1-ilpo.jarvinen@linux.intel.com>
References: <20240913143632.5277-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

eetlp_prefix_path in the struct pci_dev tells if End-End TLP Prefixes
are supported by the path or not, the value is only calculated if
CONFIG_PCI_PASID is set.

The Max End-End TLP Prefixes field in the Device Capabilities Register
2 also tells how many (1-4) End-End TLP Prefixes are supported (PCIe r6
sec 7.5.3.15). The number of supported End-End Prefixes is useful for
reading correct number of DWORDs from TLP Prefix Log register in AER
capability (PCIe r6 sec 7.8.4.12).

Replace eetlp_prefix_path with eetlp_prefix_max and determine the
number of supported End-End Prefixes regardless of CONFIG_PCI_PASID so
that an upcoming commit generalizing TLP Prefix Log register reading
does not have to read extra DWORDs for End-End Prefixes that never will
be there.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/ats.c             |  2 +-
 drivers/pci/probe.c           | 14 +++++++++-----
 include/linux/pci.h           |  2 +-
 include/uapi/linux/pci_regs.h |  1 +
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index c570892b2090..e13433dcfc82 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -377,7 +377,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (WARN_ON(pdev->pasid_enabled))
 		return -EBUSY;
 
-	if (!pdev->eetlp_prefix_path && !pdev->pasid_no_tlp)
+	if (!pdev->eetlp_prefix_max && !pdev->pasid_no_tlp)
 		return -EINVAL;
 
 	if (!pasid)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b14b9876c030..0ab70ea6840c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2228,8 +2228,8 @@ static void pci_configure_relaxed_ordering(struct pci_dev *dev)
 
 static void pci_configure_eetlp_prefix(struct pci_dev *dev)
 {
-#ifdef CONFIG_PCI_PASID
 	struct pci_dev *bridge;
+	unsigned int eetlp_max;
 	int pcie_type;
 	u32 cap;
 
@@ -2241,15 +2241,19 @@ static void pci_configure_eetlp_prefix(struct pci_dev *dev)
 		return;
 
 	pcie_type = pci_pcie_type(dev);
+
+	eetlp_max = FIELD_GET(PCI_EXP_DEVCAP2_EE_PREFIX_MAX, cap);
+	/* 00b means 4 */
+	eetlp_max = eetlp_max ?: 4;
+
 	if (pcie_type == PCI_EXP_TYPE_ROOT_PORT ||
 	    pcie_type == PCI_EXP_TYPE_RC_END)
-		dev->eetlp_prefix_path = 1;
+		dev->eetlp_prefix_max = eetlp_max;
 	else {
 		bridge = pci_upstream_bridge(dev);
-		if (bridge && bridge->eetlp_prefix_path)
-			dev->eetlp_prefix_path = 1;
+		if (bridge && bridge->eetlp_prefix_max)
+			dev->eetlp_prefix_max = eetlp_max;
 	}
-#endif
 }
 
 static void pci_configure_serr(struct pci_dev *dev)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4cf89a4b4cbc..29b754d32f79 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -398,7 +398,7 @@ struct pci_dev {
 					   supported from root to here */
 #endif
 	unsigned int	pasid_no_tlp:1;		/* PASID works without TLP Prefix */
-	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
+	unsigned int	eetlp_prefix_max:3;	/* Max # of End-End TLP Prefixes, 0=not supported */
 
 	pci_channel_state_t error_state;	/* Current connectivity state */
 	struct device	dev;			/* Generic device interface */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 94c00996e633..b297bc30ddcb 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -661,6 +661,7 @@
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
 #define  PCI_EXP_DEVCAP2_EE_PREFIX	0x00200000 /* End-End TLP Prefix */
+#define  PCI_EXP_DEVCAP2_EE_PREFIX_MAX	0x00c00000 /* Max End-End TLP Prefixes */
 #define PCI_EXP_DEVCTL2		0x28	/* Device Control 2 */
 #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
 #define  PCI_EXP_DEVCTL2_COMP_TMOUT_DIS	0x0010	/* Completion Timeout Disable */
-- 
2.39.2


