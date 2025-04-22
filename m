Return-Path: <linux-pci+bounces-26397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DE8A96BBF
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 15:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32408168F78
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 13:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9C22135DE;
	Tue, 22 Apr 2025 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IyJNqN6k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D9027466;
	Tue, 22 Apr 2025 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745326943; cv=none; b=tQNK02M6LkwSeZRgUwYaFyDPVH62CXiqKZRPfBt+Aswwccw05Z1H7MfMsyAG6vsie1k0E/8FLIngFf5RFa3og/vQ9jbg3//1Q9hw6a1v7oldpko0l2KWl2MIk7mtm2YXDpMXienWE55/ENlu/LHB3qQdNXEm13HIlKsnnkigiAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745326943; c=relaxed/simple;
	bh=XCj1nJ3OncyLNSZrpgZACHzBripTp/bT3l0dBJWMy5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VFAPalwTYQd+mKNuidNdc/ccVeLWN/Yt78nEWn+Nmq237A9we0PZFE6trmJ4BKSNUFxYCn8CqoGSmh0GHx314TCSgdcx6W6DD9ahs4nXpVkLX0xt7nHpkMy/PM9V4sh5rptnRScqarjsXOf7c+DaaPQDb8Z9pvSJo9zg+EAS7QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IyJNqN6k; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745326941; x=1776862941;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XCj1nJ3OncyLNSZrpgZACHzBripTp/bT3l0dBJWMy5A=;
  b=IyJNqN6k1cXyuEiSIn2wk0gNTs/dSjsVhMLuLTa5cyYkC8dbsMebZm4v
   FPbKo6U53sUHIW3ml4nlSWUrksPs9gOcj8ZNvPplnRflDefwH7W4SiBKL
   1uoW4klmLKatNJFgjTuBYbF9I6/XQu7wg85Y4XJ+x8Egic9hlrYKR16Ki
   MwU84+qqna5iKcHCGilqaImHtWmTYjCmSbXEH7bHuW1LxgW5oR582vRNi
   LWGRSs5BzVipqwpQNBjiJR2TQ/K3dhNdXWRZN52lBUVf84gwuQZIkRAFH
   ZqTdt6niVdmlpru5R9nNXjHCLVmHEXlAIZB6DhJUCR67fTjQP2UYRJO5v
   w==;
X-CSE-ConnectionGUID: LlQHuon/Q5GJdbzTj+QrFg==
X-CSE-MsgGUID: nFeb5vtQT8ar0mqd6759ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="47012381"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="47012381"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 06:02:20 -0700
X-CSE-ConnectionGUID: odkkmjBNT1SISieZOSu+Xg==
X-CSE-MsgGUID: uyldVBgeRpGvdyfHD8RS3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="132549094"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.148])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 06:02:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/1] PCI: Add Extended Tag + MRRS quirk for Xeon 6
Date: Tue, 22 Apr 2025 16:02:07 +0300
Message-Id: <20250422130207.3124-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When bifurcated to x2, Xeon 6 Root Port performance is sensitive to the
configuration of Extended Tags, Max Read Request Size (MRRS), and 10-Bit
Tag Requester (note: there is currently no 10-Bit Tag support in the
kernel). While those can be configured to the recommended values by FW,
kernel may decide to overwrite the initial values.

Unfortunately, there is no mechanism for FW to indicate OS which parts
of PCIe configuration should not be altered. Thus, the only option is
to add such logic into the kernel as quirks.

There is a pre-existing quirk flag to disable Extended Tags. Depending
on CONFIG_PCIE_BUS_* setting, MRRS may be overwritten by what the
kernel thinks is the best for performance (the largest supported
value), resulting in performance degradation instead with these Root
Ports. (There would have been a pre-existing quirk to disallow
increasing MRRS but it is not identical to rejecting >128B MRRS.)

Add a quirk that disallows enabling Extended Tags and setting MRRS
larger than 128B for devices under Xeon 6 Root Ports if the Root Port is
bifurcated to x2. Reject >128B MRRS only when it is going to be written
by the kernel (this assumes FW configured a good initial value for MRRS
in case the kernel is not touching MRRS at all).

It was first attempted to always write MRRS when the quirk is needed
(always overwrite the initial value). That turned out to be quite
invasive change, however, given the complexity of the initial setup
callchain and various stages returning early when they decide no changes
are necessary, requiring override each. As such, the initial value for
MRRS is now left into the hands of FW.

Link: https://cdrdv2.intel.com/v1/dl/getContent/837176
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v2:
- Explain in changelog why FW cannot solve this on its own
- Moved the quirk under arch/x86/pci/
- Don't NULL check value from pci_find_host_bridge()
- Added comment above the quirk about the performance degradation
- Removed all setup chain 128B quirk overrides expect for MRRS write
  itself (assumes a sane initial value is set by FW)

 arch/x86/pci/fixup.c | 30 ++++++++++++++++++++++++++++++
 drivers/pci/pci.c    | 15 ++++++++-------
 include/linux/pci.h  |  1 +
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index efefeb82ab61..aa9617bc4b55 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -294,6 +294,36 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PB1,	pcie_r
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC,	pcie_rootport_aspm_quirk);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC1,	pcie_rootport_aspm_quirk);
 
+/*
+ * PCIe devices underneath Xeon6 PCIe Root Port bifurcated to 2x have slower
+ * performance with Extended Tags and MRRS > 128B. Workaround the performance
+ * problems by disabling Extended Tags and limiting MRRS to 128B.
+ *
+ * https://cdrdv2.intel.com/v1/dl/getContent/837176
+ */
+static void quirk_pcie2x_no_tags_no_mrrs(struct pci_dev *pdev)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
+	u32 linkcap;
+
+	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &linkcap);
+	if (FIELD_GET(PCI_EXP_LNKCAP_MLW, linkcap) != 0x2)
+		return;
+
+	bridge->no_ext_tags = 1;
+	bridge->only_128b_mrrs = 1;
+	pci_info(pdev, "Disabling Extended Tags and limiting MRRS to 128B (performance reasons due to 2x PCIe link)\n");
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
 /*
  * Fixup to mark boot BIOS video selected by BIOS before it changes
  *
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4d7c9f64ea24..2ca9cb30fbd3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5941,7 +5941,7 @@ EXPORT_SYMBOL(pcie_get_readrq);
 int pcie_set_readrq(struct pci_dev *dev, int rq)
 {
 	u16 v;
-	int ret;
+	int ret, max_mrrs = 4096;
 	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
 
 	if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
@@ -5961,13 +5961,14 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 
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
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0e8e3fd77e96..6dc7a05f4d4b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -603,6 +603,7 @@ struct pci_host_bridge {
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */
 	unsigned int	no_inc_mrrs:1;		/* No Increase MRRS */
+	unsigned int	only_128b_mrrs:1;	/* Only 128B MRRS */
 	unsigned int	native_aer:1;		/* OS may use PCIe AER */
 	unsigned int	native_pcie_hotplug:1;	/* OS may use PCIe hotplug */
 	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */

base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.39.5


