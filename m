Return-Path: <linux-pci+bounces-17968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA829EA1F0
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 23:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0A41660D9
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 22:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD2D1A9B42;
	Mon,  9 Dec 2024 22:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSmkNYDn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B32619F13F;
	Mon,  9 Dec 2024 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733783383; cv=none; b=GLDycQTImtIGB1iDPgJvomR0uHFHrL6yntDTyLlRGwWVvGdnE3nr206+KYoralrNQmUa/4E+IhUAgVppY0m4pHpJdUlPnRz0rSq1/+09TGdVSbqjT1wWj3A5iFouQM9mRGAkaKsyAowbXMCH8Xyhd49XKF6hMnALhle+rC3NPbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733783383; c=relaxed/simple;
	bh=uQB9FqZV8S9ljImuA1+RLrowIMKCGgBRgFgwfCk1L+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WuQRU6F5HPDPumntvgNqNRGdm4xZvUaps4xf4XTatBO5/lyVngZJh5/wEWXm+9wMPEIrjpr2Ge62HI0iwTQ+uQ9mTfJseZ+RDb5pXTJTOnDbhE6b4Zl3BjSSI5OkJk8ZsWHSJin317cloAF8P1X5yFPN9d7nRKPqbKhsM1DFPdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSmkNYDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C951C4CEDD;
	Mon,  9 Dec 2024 22:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733783382;
	bh=uQB9FqZV8S9ljImuA1+RLrowIMKCGgBRgFgwfCk1L+s=;
	h=From:To:Cc:Subject:Date:From;
	b=qSmkNYDnDYfnTXlZ/hbN66HInnToCRcDJYAU94+Pe5oXlpwTOc/6W3gCxO6q6IfR1
	 bGybcx8QeYxXJfH1l1Vems7MzQb0ymHvkGqSDX2knyTKzA6F4a0AbgQT+gStqZPTvQ
	 pGhoW+E0AwkkUnNxNDO822be3pirQJp7j9UuvQ+wsC4bvBZth2mkjmu54SXoDvKf6p
	 RCZcUVLqkXsVSyWRJNTMYlqwBO/9wS1K3t8Zc8rB7gbrN4DjEns++0G1fFg8XWX1AE
	 g8OmPC5DRGDfStJaqitiEc99/SDp8b4DEnk7XTPLBNpFar8O0vuZJATHoJlpqJC4uw
	 mZV/UlU8CsVuA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] perf/dwc_pcie: Qualify RAS DES VSEC Capability by Vendor, Revision
Date: Mon,  9 Dec 2024 16:29:38 -0600
Message-Id: <20241209222938.3219364-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

PCI Vendor-Specific (VSEC) Capabilities are defined by each vendor.
Devices from different vendors may advertise a VSEC Capability with the DWC
RAS DES functionality, but the vendors may assign different VSEC IDs.

Search for the DWC RAS DES Capability using the VSEC ID and VSEC Rev
chosen by the vendor.

This does not fix a current problem because Alibaba, Ampere, and Qualcomm
all assigned the same VSEC ID and VSEC Rev for the DWC RAS DES Capability.

The potential issue is that we may add support for a device from another
vendor, where the vendor has already assigned DWC_PCIE_VSEC_RAS_DES_ID
(0x02) for an unrelated VSEC.  In that event, dwc_pcie_des_cap() would find
the unrelated VSEC and mistakenly assume it was a DWC RAS DES Capability.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
Sample devices that advertise VSEC Capabilities with VSEC ID=0x02 that are
unrelated to the DWC RAS DES functionality:

  https://community.nxp.com/t5/S32G/S32G3-PCIe-compliance-mode-set-speed-to-5-8Gbit-s/m-p/1875346#M7024
    00:00.0 PCI bridge: Freescale Semiconductor Inc Device 4300 (prog-if 00 [Normal decode])
      Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
      Capabilities: [158 v1] Vendor Specific Information: ID=0002 Rev=4 Len=100 <?>

  https://github.com/google-coral/edgetpu/issues/743
    0000:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad0 (rev a1) (prog-if 00 [Normal decode])
      Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
      Capabilities: [1d0 v1] Vendor Specific Information: ID=0002 Rev=4 Len=100

  https://www.linuxquestions.org/questions/linux-kernel-70/differences-in-'lspci-v'-output-4175495550/
    00:01.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 1 (rev 13) (prog-if 00 [Normal decode])
      Capabilities: [90] Express Root Port (Slot+), MSI 00
      Capabilities: [160] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>

  https://www.reddit.com/r/linuxhardware/comments/187u87b/the_correct_way_to_identify_the_kernel_driver/
    04:00.0 Network controller: Realtek Semiconductor Co., Ltd. Device c852 (rev 01)
      Capabilities: [70] Express Endpoint, MSI 00
      Capabilities: [170] Vendor Specific Information: ID=0002 Rev=4 Len=100 <?>
---
 drivers/perf/dwc_pcie_pmu.c | 68 ++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 9cbea9675e21..d022f498fa1a 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -20,7 +20,6 @@
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
-#define DWC_PCIE_VSEC_RAS_DES_ID		0x02
 #define DWC_PCIE_EVENT_CNT_CTL			0x8
 
 /*
@@ -100,14 +99,23 @@ struct dwc_pcie_dev_info {
 	struct list_head dev_node;
 };
 
-struct dwc_pcie_vendor_id {
-	int vendor_id;
+struct dwc_pcie_pmu_vsec_id {
+	u16 vendor_id;
+	u16 vsec_id;
+	u8 vsec_rev;
 };
 
-static const struct dwc_pcie_vendor_id dwc_pcie_vendor_ids[] = {
-	{.vendor_id = PCI_VENDOR_ID_ALIBABA },
-	{.vendor_id = PCI_VENDOR_ID_AMPERE },
-	{.vendor_id = PCI_VENDOR_ID_QCOM },
+/*
+ * VSEC IDs are allocated by the vendor, so a given ID may mean different
+ * things to different vendors.  See PCIe r6.0, sec 7.9.5.2.
+ */
+static const struct dwc_pcie_pmu_vsec_id dwc_pcie_pmu_vsec_ids[] = {
+	{ .vendor_id = PCI_VENDOR_ID_ALIBABA,
+	  .vsec_id = 0x02, .vsec_rev = 0x4 },
+	{ .vendor_id = PCI_VENDOR_ID_AMPERE,
+	  .vsec_id = 0x02, .vsec_rev = 0x4 },
+	{ .vendor_id = PCI_VENDOR_ID_QCOM,
+	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{} /* terminator */
 };
 
@@ -519,31 +527,28 @@ static void dwc_pcie_unregister_pmu(void *data)
 	perf_pmu_unregister(&pcie_pmu->pmu);
 }
 
-static bool dwc_pcie_match_des_cap(struct pci_dev *pdev)
+static u16 dwc_pcie_des_cap(struct pci_dev *pdev)
 {
-	const struct dwc_pcie_vendor_id *vid;
-	u16 vsec = 0;
+	const struct dwc_pcie_pmu_vsec_id *vid;
+	u16 vsec;
 	u32 val;
 
 	if (!pci_is_pcie(pdev) || !(pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT))
-		return false;
+		return 0;
 
-	for (vid = dwc_pcie_vendor_ids; vid->vendor_id; vid++) {
+	for (vid = dwc_pcie_pmu_vsec_ids; vid->vendor_id; vid++) {
 		vsec = pci_find_vsec_capability(pdev, vid->vendor_id,
-						DWC_PCIE_VSEC_RAS_DES_ID);
-		if (vsec)
-			break;
+						vid->vsec_id);
+		if (vsec) {
+			pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER,
+					      &val);
+			if (PCI_VNDR_HEADER_REV(val) == vid->vsec_rev) {
+				pci_dbg(pdev, "Detected PCIe Vendor-Specific Extended Capability RAS DES\n");
+				return vsec;
+			}
+		}
 	}
-	if (!vsec)
-		return false;
-
-	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
-	if (PCI_VNDR_HEADER_REV(val) != 0x04)
-		return false;
-
-	pci_dbg(pdev,
-		"Detected PCIe Vendor-Specific Extended Capability RAS DES\n");
-	return true;
+	return 0;
 }
 
 static void dwc_pcie_unregister_dev(struct dwc_pcie_dev_info *dev_info)
@@ -587,7 +592,7 @@ static int dwc_pcie_pmu_notifier(struct notifier_block *nb,
 
 	switch (action) {
 	case BUS_NOTIFY_ADD_DEVICE:
-		if (!dwc_pcie_match_des_cap(pdev))
+		if (!dwc_pcie_des_cap(pdev))
 			return NOTIFY_DONE;
 		if (dwc_pcie_register_dev(pdev))
 			return NOTIFY_BAD;
@@ -612,13 +617,14 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 	struct pci_dev *pdev = plat_dev->dev.platform_data;
 	struct dwc_pcie_pmu *pcie_pmu;
 	char *name;
-	u32 sbdf, val;
+	u32 sbdf;
 	u16 vsec;
 	int ret;
 
-	vsec = pci_find_vsec_capability(pdev, pdev->vendor,
-					DWC_PCIE_VSEC_RAS_DES_ID);
-	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
+	vsec = dwc_pcie_des_cap(pdev);
+	if (!vsec)
+		return -ENODEV;
+
 	sbdf = plat_dev->id;
 	name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
 	if (!name)
@@ -730,7 +736,7 @@ static int __init dwc_pcie_pmu_init(void)
 	int ret;
 
 	for_each_pci_dev(pdev) {
-		if (!dwc_pcie_match_des_cap(pdev))
+		if (!dwc_pcie_des_cap(pdev))
 			continue;
 
 		ret = dwc_pcie_register_dev(pdev);
-- 
2.34.1


