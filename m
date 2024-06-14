Return-Path: <linux-pci+bounces-8841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F84908E5E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 17:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E2F28B1AF
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 15:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2308017FAD9;
	Fri, 14 Jun 2024 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HEz8wesY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643B516D30E;
	Fri, 14 Jun 2024 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377811; cv=none; b=i3isJZUNzjWyQ7T99Lu17ty1g0gI34nN4N8rCBHkWdJrXRxrJjQqxLcyLojLL1UMgZFycV9W46KiNd9qAV9CEHdyRmP2EJ5bt22DYTS2ek6Qn44NNcZ0riOXEGIJckiD7c8LZc31Qu8VR/9LurWrVHdTXtnSMc4Ue82Im6OHsXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377811; c=relaxed/simple;
	bh=yet1N1drQ+gSy2qH8OrtJ7oc9RaHN37lFGg7skrGI6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dh4OUaN7+3JTy+9Ug+WRccT9tEAytYE3WPn0aEXGPbpSASwl6BWJ2JinasKgtfuiWEUX0sv3gf/uo4Zgz4pL0+OG8zkngWmFi2OHbCyVo6EQw1+59ndVRZK/UkLLij7qiPfISvAaM5YxqGAqoR11ZhR1j674Q9ouOS9LLoxYenw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HEz8wesY; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718377809; x=1749913809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yet1N1drQ+gSy2qH8OrtJ7oc9RaHN37lFGg7skrGI6w=;
  b=HEz8wesYx88ZMzbTPqdrNLjnR2NlughNuCqqJItK8H81Q5Tn6wIxOHDA
   hgjnmW/JNcE0+9j+wCwjYkh4+8ZrZkC2crum+F6ThZcKYMRl4dL57/8A2
   zv3oEIK+FXE/z5Z0cSMV7Bw4dQOe5jXmRk8mNC/4rruQU0HGBRhU3L/GN
   JF9WAVadHPoP0Rkd20asaQOyztmiX1Qjmzlek4WxUwHnIn5pWJ/shCX0C
   B0Hal3ci8mOy/q4psTwqZsED22bAr0QQZPQ3Y7Qh8x/J2ulBuKNuMmjV+
   3oC8+PN6gg7iae6/NgCTPnrVrTBs52YazDlGmB2m0w5lsB7y9WOcvqmgR
   A==;
X-CSE-ConnectionGUID: Zve/ZjXtRv285OFFWlZVNA==
X-CSE-MsgGUID: 4JC1z8GsRlmxuCyFLSZjxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="19089300"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="19089300"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 08:10:09 -0700
X-CSE-ConnectionGUID: YvITFwDYSqaSI+mpVpHiFg==
X-CSE-MsgGUID: azTck6y0QB+2w961eiii3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="40629261"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.222])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 08:10:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Tony Luck <tony.luck@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/3] PCI: Refactor pcie_update_link_speed()
Date: Fri, 14 Jun 2024 18:09:19 +0300
Message-Id: <20240614150921.29724-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240614150921.29724-1-ilpo.jarvinen@linux.intel.com>
References: <20240614150921.29724-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pcie_update_link_speed() is passed the Link Status register but not all
callers have that value at hand nor need the value.

Refactor pcie_update_link_speed() to include reading the Link Status
register into pcie_update_link_speed() and create
__pcie_update_link_speed() which can be used by the hotplug code that
has the register value at hand beforehand (and needs the value for
other purposes).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |  2 +-
 drivers/pci/pci.h                |  7 ++++++-
 drivers/pci/probe.c              | 12 +++++++-----
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index b1d0a1b3917d..0d818110af6d 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -319,7 +319,7 @@ int pciehp_check_link_status(struct controller *ctrl)
 		return -1;
 	}
 
-	pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status);
+	__pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status);
 
 	if (!found) {
 		ctrl_info(ctrl, "Slot(%s): No device found\n",
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 602b270c4408..47d8ccf6230c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -297,7 +297,12 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
 enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
 void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
 void pcie_report_downtraining(struct pci_dev *dev);
-void pcie_update_link_speed(struct pci_bus *bus, u16 link_status);
+
+static inline void __pcie_update_link_speed(struct pci_bus *bus, u16 linksta)
+{
+	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
+}
+void pcie_update_link_speed(struct pci_bus *bus);
 
 /* Single Root I/O Virtualization */
 struct pci_sriov {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6512b4fca229..42dbcc401443 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -742,9 +742,13 @@ const char *pci_speed_string(enum pci_bus_speed speed)
 }
 EXPORT_SYMBOL_GPL(pci_speed_string);
 
-void pcie_update_link_speed(struct pci_bus *bus, u16 linksta)
+void pcie_update_link_speed(struct pci_bus *bus)
 {
-	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
+	struct pci_dev *bridge = bus->self;
+	u16 linksta;
+
+	pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &linksta);
+	__pcie_update_link_speed(bus, linksta);
 }
 EXPORT_SYMBOL_GPL(pcie_update_link_speed);
 
@@ -827,13 +831,11 @@ static void pci_set_bus_speed(struct pci_bus *bus)
 
 	if (pci_is_pcie(bridge)) {
 		u32 linkcap;
-		u16 linksta;
 
 		pcie_capability_read_dword(bridge, PCI_EXP_LNKCAP, &linkcap);
 		bus->max_bus_speed = pcie_link_speed[linkcap & PCI_EXP_LNKCAP_SLS];
 
-		pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &linksta);
-		pcie_update_link_speed(bus, linksta);
+		pcie_update_link_speed(bus);
 	}
 }
 
-- 
2.39.2


