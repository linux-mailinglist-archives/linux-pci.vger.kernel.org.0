Return-Path: <linux-pci+bounces-22840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8E5A4DFB9
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 14:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C7B3B38DC
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 13:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01B32046BD;
	Tue,  4 Mar 2025 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R5kgj4H/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE8E2046B0;
	Tue,  4 Mar 2025 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096278; cv=none; b=cx7MR0LRjgekYCsNctkZ7KZ/n5Rbpcp96N7/5Toc6Bv65ZDq2sW81l6P9f+vlMJlKIU3+w6QQsidPglsOIQLpnx7MezODCwy6/O4eekgM1cU37IHEQn9Q8fnIbVUa4Xk6AzHsmdrD5yBCuOpzRi8ujbFm768pmNXfJ5j9TE1nLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096278; c=relaxed/simple;
	bh=gAVOKnxuAXipq7wqreAj7N7ZvPmdB9OEU/wbN3apFMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Aec0Ves1v1H/7krfO7oC72M1MFnX00HIDTmisi+xEaas84PoyjL332UIBR1w/O8astR9g7FmtDi8Kc60xXLj8SrZYKmitvvnJHhhJrS/duNg2PfOEOXEEMjSLudpVtped7WMrz9p3SyeVtboOPPuFwcnfkKsIBsa/XPi1k5l72E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R5kgj4H/; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741096277; x=1772632277;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gAVOKnxuAXipq7wqreAj7N7ZvPmdB9OEU/wbN3apFMk=;
  b=R5kgj4H/XcXrV/Z8IxXZQFo48m60XuIv74BOOLvqRpcGTjuB/UfbPrwa
   ZHY9tnsq7o0LHCHTNXmsZr5Df90cQi+xornyfXUC/2ND+K7N6KYg1dRty
   aXQtjPEjfAed7zrF2MnlZQm9FKPH1OkGV7rvglmJXs9Gzz0AikhIbiwYb
   Q3Hu3ZpRLWqHp+BzaXT0ppjmPitQQ8MVUYp4BcWKAThXFXrvEh/O9/Tz4
   PmSRTnzX8W+chMlSV9DcZf6ty5l2VT14W6hN/iUtQFTo0I+w40jA4uKwx
   R0hjs6npRPudsXLM17bsETy6vzFEQc27xsuZU9KhWvjUjVNOY4w7rJoKb
   A==;
X-CSE-ConnectionGUID: oF7t/7YKSvWFH8BRfFuncg==
X-CSE-MsgGUID: g1zXP3OzQ4uINHKUIoO1vA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41260835"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="41260835"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 05:51:16 -0800
X-CSE-ConnectionGUID: Ip2M1FLJSISDCQ4PkwytEQ==
X-CSE-MsgGUID: kUfPb+B8ReqGr4n8n8+Vkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="118388115"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.220])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 05:51:14 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC PATCH 1/1] PCI: Add Extended Tag + MRRS quirk for Xeon 6
Date: Tue,  4 Mar 2025 15:51:08 +0200
Message-Id: <20250304135108.2599-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Disallow Extended Tags and Max Read Request Size (MRRS) larger than
128B for devices under Xeon 6 Root Ports if the Root Port is bifurcated
to x2. Also, 10-Bit Tag Requester should be disallowed for device
underneath these Root Ports but there is currently no 10-Bit Tag
support in the kernel.

The normal path that writes MRRS is through
pcie_bus_configure_settings() -> pcie_bus_configure_set() ->
pcie_write_mrrs() and contains a few early returns that are based on
the value of pcie_bus_config. Overriding such checks with the host
bridge flag check on each level seems messy. Thus, simply ensure MRRS
is always written in pci_configure_device() if a device requiring the
quirk is detected.

Link: https://cdrdv2.intel.com/v1/dl/getContent/837176
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

The normal path that writes MRRS is somewhat convoluted so I ensure MRRS
gets written in a more direct way, I'm not sure if that's the best
approach. Thus sending this as RFC.

 drivers/pci/pci.c    | 15 ++++++++-------
 drivers/pci/probe.c  |  8 +++++++-
 drivers/pci/quirks.c | 27 +++++++++++++++++++++++++++
 include/linux/pci.h  |  1 +
 4 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..81ddad81ccb8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5913,7 +5913,7 @@ EXPORT_SYMBOL(pcie_get_readrq);
 int pcie_set_readrq(struct pci_dev *dev, int rq)
 {
 	u16 v;
-	int ret;
+	int ret, max_mrrs = 4096;
 	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
 
 	if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
@@ -5933,13 +5933,14 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 
 	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
 
-	if (bridge->no_inc_mrrs) {
-		int max_mrrs = pcie_get_readrq(dev);
+	if (bridge->no_inc_mrrs)
+		max_mrrs = pcie_get_readrq(dev);
+	if (bridge->only_128b_mrrs)
+		max_mrrs = 128;
 
-		if (rq > max_mrrs) {
-			pci_info(dev, "can't set Max_Read_Request_Size to %d; max is %d\n", rq, max_mrrs);
-			return -EINVAL;
-		}
+	if (rq > max_mrrs) {
+		pci_info(dev, "can't set Max_Read_Request_Size to %d; max is %d\n", rq, max_mrrs);
+		return -EINVAL;
 	}
 
 	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b6536ed599c3..ceaa34b0525b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2342,7 +2342,11 @@ static void pci_configure_serr(struct pci_dev *dev)
 
 static void pci_configure_device(struct pci_dev *dev)
 {
+	struct pci_host_bridge *host_bridge = pci_find_host_bridge(dev->bus);
+
 	pci_configure_mps(dev);
+	if (host_bridge && host_bridge->only_128b_mrrs)
+		pcie_set_readrq(dev, 128);
 	pci_configure_extended_tags(dev, NULL);
 	pci_configure_relaxed_ordering(dev);
 	pci_configure_ltr(dev);
@@ -2851,13 +2855,15 @@ static void pcie_write_mps(struct pci_dev *dev, int mps)
 
 static void pcie_write_mrrs(struct pci_dev *dev)
 {
+	struct pci_host_bridge *host_bridge = pci_find_host_bridge(dev->bus);
 	int rc, mrrs;
 
 	/*
 	 * In the "safe" case, do not configure the MRRS.  There appear to be
 	 * issues with setting MRRS to 0 on a number of devices.
 	 */
-	if (pcie_bus_config != PCIE_BUS_PERFORMANCE)
+	if (pcie_bus_config != PCIE_BUS_PERFORMANCE &&
+	    (!host_bridge || !host_bridge->only_128b_mrrs))
 		return;
 
 	/*
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b84ff7bade82..987cd94028e1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5564,6 +5564,33 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0144, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0420, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
 
+static void quirk_pcie2x_no_tags_no_mrrs(struct pci_dev *pdev)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
+	u32 linkcap;
+
+	if (!bridge)
+		return;
+
+	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &linkcap);
+	if (FIELD_GET(PCI_EXP_LNKCAP_MLW, linkcap) != 0x2)
+		return;
+
+	bridge->no_ext_tags = 1;
+	bridge->only_128b_mrrs = 1;
+	pci_info(pdev, "Disabling Extended Tags and forcing MRRS to 128B (performance reasons due to 2x PCIe link)\n");
+}
+
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db0, quirk_pcie2x_no_tags_no_mrrs);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db1, quirk_pcie2x_no_tags_no_mrrs);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db2, quirk_pcie2x_no_tags_no_mrrs);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db3, quirk_pcie2x_no_tags_no_mrrs);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db6, quirk_pcie2x_no_tags_no_mrrs);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db7, quirk_pcie2x_no_tags_no_mrrs);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db8, quirk_pcie2x_no_tags_no_mrrs);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db9, quirk_pcie2x_no_tags_no_mrrs);
+
+
 #ifdef CONFIG_PCI_ATS
 static void quirk_no_ats(struct pci_dev *pdev)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..def29c8c0f84 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -601,6 +601,7 @@ struct pci_host_bridge {
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */
 	unsigned int	no_inc_mrrs:1;		/* No Increase MRRS */
+	unsigned int	only_128b_mrrs:1;	/* Only 128B MRRS */
 	unsigned int	native_aer:1;		/* OS may use PCIe AER */
 	unsigned int	native_pcie_hotplug:1;	/* OS may use PCIe hotplug */
 	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.39.5


