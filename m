Return-Path: <linux-pci+bounces-20909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA4CA2C86C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 17:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FCAD188B09B
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 16:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FD23FB9C;
	Fri,  7 Feb 2025 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SA05g0rw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C88A23C8C5;
	Fri,  7 Feb 2025 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945152; cv=none; b=QVJpV9d3Rt0VjXBJMJ8qFYKwRH7sCjfiv0aLvJr4MhYs+qq3rk9U4B5RVOHJflW4GJbInLGpYjk+HTsL/Z12bmxt49H7pnzVJYuyaiLOQ6FDVZpZ5BE9HC9O4FJYXYKcMUjW+rC4gqYHFObJiYohuJGliKtyHotHvbfhx9U6Ozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945152; c=relaxed/simple;
	bh=ARSjCqPD4d2t/Gj/0MRiC2OYh5VkRn2anE403NEiXdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CzqU9Nxx2WCgS49/cBKzuyMov62T0sgTylXXX6r+1e1BQ8DQIlQ24reSBw1Blqpsk7Icr71zPo2XQi4qHZGCZRkxydSZSe5QP+1NZ5nCqUnVO1OLAOFpzYc++OR/uwsWD5/sj5Qqu9QNKtVJ3J9D6R5lWqC6b/Jm/8NxR9M0o7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SA05g0rw; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738945151; x=1770481151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ARSjCqPD4d2t/Gj/0MRiC2OYh5VkRn2anE403NEiXdM=;
  b=SA05g0rw8O4SBJUhlLHYo/eqjtBs7H707K+bI9WokFt8CsNPut7H5XHx
   eDgm7oIyjaH6h4T39EoMFOvPV9PeGpg90Hz/tGMimg9ltHf+vlNMVYvU4
   QkhPOx13AYw6MZBUik1ygvm38sXHZm4toh9vwYveGftwBs5jxqLFdVdOF
   RwaT+gksYtbph+GYbH4wDyRhE02S9Gf4eqbuf4Yl7ojmpKUIk/i9bAqLk
   0LQq2BcHSzUsbXU349rCT/5WFfEkes11VvumaGrLX+o/QexzIjtWxm/4H
   n0AFul9mFGqIVHjRuoTRznldL1C+PwoRp7/+JLVXO6ocm/X4H6HSwmEPs
   w==;
X-CSE-ConnectionGUID: 3kCwsQEZT9KNT4iHzWdrGA==
X-CSE-MsgGUID: G9+xoZF8REqV86eUUdoPdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="57006860"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="57006860"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 08:19:11 -0800
X-CSE-ConnectionGUID: kODiWntbRh2cIYXayBBsoQ==
X-CSE-MsgGUID: n6p+B96YTlWTh8m0fv7IJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="116502414"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 08:19:06 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Tony Luck <tony.luck@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/2] PCI: Track Flit Mode Status & print it with link status
Date: Fri,  7 Feb 2025 18:18:35 +0200
Message-Id: <20250207161836.2755-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207161836.2755-1-ilpo.jarvinen@linux.intel.com>
References: <20250207161836.2755-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCIe r6.0 added Flit mode that mainly alters HW behavior but some OS
visible changes are also because of it. The OS visible changes include
differences in the layout of some capabilities and interpretation of
the TLP headers (in diagnostics situations).

To be able to determine which mode the PCIe link is using, store the
Flit Mode Status (PCIe r6.1 sec 7.5.3.20) information in addition to
the link speed into struct pci_bus in pcie_update_link_speed().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |  5 +++--
 drivers/pci/pci.c                | 12 ++++++++----
 drivers/pci/pci.h                |  3 ++-
 drivers/pci/probe.c              |  5 +++--
 include/linux/pci.h              |  1 +
 5 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bb5a8d9f03ad..10130ac9f979 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -292,7 +292,7 @@ int pciehp_check_link_status(struct controller *ctrl)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	bool found;
-	u16 lnk_status;
+	u16 lnk_status, linksta2;
 
 	if (!pcie_wait_for_link(pdev, true)) {
 		ctrl_info(ctrl, "Slot(%s): No link\n", slot_name(ctrl));
@@ -319,7 +319,8 @@ int pciehp_check_link_status(struct controller *ctrl)
 		return -1;
 	}
 
-	__pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status);
+	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &linksta2);
+	__pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status, linksta2);
 
 	if (!found) {
 		ctrl_info(ctrl, "Slot(%s): No device found\n",
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..313c66863752 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6190,21 +6190,25 @@ void __pcie_print_link_status(struct pci_dev *dev, bool verbose)
 	enum pci_bus_speed speed, speed_cap;
 	struct pci_dev *limiting_dev = NULL;
 	u32 bw_avail, bw_cap;
+	char *flit_mode = "";
 
 	bw_cap = pcie_bandwidth_capable(dev, &speed_cap, &width_cap);
 	bw_avail = pcie_bandwidth_available(dev, &limiting_dev, &speed, &width);
 
+	if (dev->bus && dev->bus->flit_mode)
+		flit_mode = ", in Flit mode";
+
 	if (bw_avail >= bw_cap && verbose)
-		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)\n",
+		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)%s\n",
 			 bw_cap / 1000, bw_cap % 1000,
-			 pci_speed_string(speed_cap), width_cap);
+			 pci_speed_string(speed_cap), width_cap, flit_mode);
 	else if (bw_avail < bw_cap)
-		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)\n",
+		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)%s\n",
 			 bw_avail / 1000, bw_avail % 1000,
 			 pci_speed_string(speed), width,
 			 limiting_dev ? pci_name(limiting_dev) : "<unknown>",
 			 bw_cap / 1000, bw_cap % 1000,
-			 pci_speed_string(speed_cap), width_cap);
+			 pci_speed_string(speed_cap), width_cap, flit_mode);
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01e51db8d285..9c6a4a980678 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -406,9 +406,10 @@ const char *pci_speed_string(enum pci_bus_speed speed);
 void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
 void pcie_report_downtraining(struct pci_dev *dev);
 
-static inline void __pcie_update_link_speed(struct pci_bus *bus, u16 linksta)
+static inline void __pcie_update_link_speed(struct pci_bus *bus, u16 linksta, u16 linksta2)
 {
 	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
+	bus->flit_mode = linksta2 & PCI_EXP_LNKSTA2_FLIT;
 }
 void pcie_update_link_speed(struct pci_bus *bus);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b6536ed599c3..e6f11498a345 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -788,10 +788,11 @@ EXPORT_SYMBOL_GPL(pci_speed_string);
 void pcie_update_link_speed(struct pci_bus *bus)
 {
 	struct pci_dev *bridge = bus->self;
-	u16 linksta;
+	u16 linksta, linksta2;
 
 	pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &linksta);
-	__pcie_update_link_speed(bus, linksta);
+	pcie_capability_read_word(bridge, PCI_EXP_LNKSTA2, &linksta2);
+	__pcie_update_link_speed(bus, linksta, linksta2);
 }
 EXPORT_SYMBOL_GPL(pcie_update_link_speed);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..9862f65d899d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -681,6 +681,7 @@ struct pci_bus {
 	struct bin_attribute	*legacy_mem;	/* Legacy mem */
 	unsigned int		is_added:1;
 	unsigned int		unsafe_warn:1;	/* warned about RW1C config write */
+	bool			flit_mode;	/* Link in Flit mode */
 };
 
 #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
-- 
2.39.5


