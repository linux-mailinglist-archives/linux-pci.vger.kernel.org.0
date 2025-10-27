Return-Path: <linux-pci+bounces-39432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E10BC0E113
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 14:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A1EA4F9989
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 13:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EDF303A18;
	Mon, 27 Oct 2025 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aI2CP9r9"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B2F2765F5;
	Mon, 27 Oct 2025 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571830; cv=none; b=FrS9/aUFHLJLoHrU938LLgJk8KKdKvWjVfyX1QLEUGkuwHaOY4v19HKagylD3ov67/9aGanotyjUNdylZ1qJXQ6zJcrw1PHv/d1ZMna8b7J0/x2VfqSn0Bg5k+01AjBkj4hvuDCwjYWGUEIf4X9odp5QFJU8/6wryiUYwUU9bhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571830; c=relaxed/simple;
	bh=E8i7Vzxld3T07dT6NV1FN+lQW0pfXthokh6MiGtfHJw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xz4oZVomtMZQ11CYst9Lxhqldnd9PlH1824U8XTTwYtCPxxjYAZPQ4s3HwuT6qPGkEvJY1vMQrVfnL4z32YLtD4E9YBZ7GiJgcMKsQY+d4CF+8vrGe+dh4wLRlU0K00M36erm1Yp+so11iAEb6pE+mZWEEKmBiQcNJMmKolluOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aI2CP9r9; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59RDU7JJ2417320;
	Mon, 27 Oct 2025 08:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761571807;
	bh=O/IAo5Oi+YN1TvC5L+T4+FTIT9PU5gRVBHT1xVrzic0=;
	h=From:To:CC:Subject:Date;
	b=aI2CP9r9jLdy8sgXigtM/mxkBooyd4Xdpin6a67gwKHxgIzlJx+bC6n2NZhPXmQvt
	 iqx1vqd4554D0U0C0rIKeTKOhbNFddj+DIJWou+4G2jwsjPo2yd7Z53Ju/NpKPepA+
	 PW1e8Ij7v6kNF7onUuBTmDT6fBCqHh1IcPfGvlZM=
Received: from DLEE204.ent.ti.com (dlee204.ent.ti.com [157.170.170.84])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59RDU7EJ1686831
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Oct 2025 08:30:07 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 08:30:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 08:30:07 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59RDU2fl732990;
	Mon, 27 Oct 2025 08:30:03 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <unicorn_wang@outlook.com>,
        <kishon@kernel.org>, <18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] PCI: cadence: Enable support for applying lane equalization presets
Date: Mon, 27 Oct 2025 18:59:06 +0530
Message-ID: <20251027133013.2589119-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The PCIe Link Equalization procedure allows peers on a PCIe Link to
improve the signal quality by exchanging transmitter presets and
receiver preset hints in the form of Ordered Sets.

For link speeds of 8.0 GT/s and above, the transmitter presets and the
receiver preset hints are configurable parameters which can be tuned to
establish a stable link. This allows setting up a stable link that is
specific to the peers across a Link.

The device-tree property 'eq-presets-Ngts' (eq-presets-8gts,
eq-presets-16gts, ...) specifies the transmitter presets and receiver
preset hints to be applied to every lane of the link for every supported
link speed that is greater than or equal to 8.0 GT/s.

Hence, enable support for applying the 'optional' lane equalization
presets when operating in the Root-Port (Root-Complex / Host) mode.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged 20251027.
It also applies cleanly on 6.18-rc1.

Patch has been tested on J784S4-EVM which has 2 instances of PCIe,
namely PCIe0 and PCIe1. The diff corresponding to the device-tree change
for applying Presets to PCIe0 is:
https://gist.github.com/Siddharth-Vadapalli-at-TI/892ff417df178fcdf502e70d41bf5b48
An NVMe SSD has been connected to the PCIe connector for PCIe0 and
functionality has been validated after applying the current patch.
Test Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/481e3ae5d359907cd9c3d9797ea028cc

Regards,
Siddharth.

 .../controller/cadence/pcie-cadence-host.c    | 84 +++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h |  5 ++
 2 files changed, 89 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index fffd63d6665e..3fac89703c0c 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -168,6 +168,89 @@ static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
 	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
 }
 
+static void cdns_pcie_setup_lane_equalization_presets(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	struct device *dev = pcie->dev;
+	struct device_node *np = dev->of_node;
+	int max_link_speed, max_lanes, ret;
+	u32 lane_eq_ctrl_reg;
+	u16 cap;
+	u16 *presets_8gts;
+	u8 *presets_ngts;
+	u8 i, j;
+
+	ret = of_property_read_u32(np, "num-lanes", &max_lanes);
+	if (ret)
+		return;
+
+	/* Lane Equalization presets are optional, so error message is not necessary */
+	ret = of_pci_get_equalization_presets(dev, &rc->eq_presets, max_lanes);
+	if (ret)
+		return;
+
+	max_link_speed = of_pci_get_max_link_speed(np);
+	if (max_link_speed < 0) {
+		dev_err(dev, "%s: link-speed unknown, skipping preset setup\n", __func__);
+		return;
+	}
+
+	/*
+	 * Setup presets for data rates including and upward of 8.0 GT/s until the
+	 * maximum supported data rate.
+	 */
+	switch (pcie_link_speed[max_link_speed]) {
+	case PCIE_SPEED_16_0GT:
+		presets_ngts = (u8 *)rc->eq_presets.eq_presets_Ngts[EQ_PRESET_TYPE_16GTS - 1];
+		if (presets_ngts[0] != PCI_EQ_RESV) {
+			cap = cdns_pcie_find_ext_capability(pcie, PCI_EXT_CAP_ID_PL_16GT);
+			if (!cap)
+				break;
+			lane_eq_ctrl_reg = cap + PCI_PL_16GT_LE_CTRL;
+			/*
+			 * For Link Speeds including and upward of 16.0 GT/s, the Lane Equalization
+			 * Control register has the following layout per Lane:
+			 * Bits 0-3: Downstream Port Transmitter Preset
+			 * Bits 4-7: Upstream Port Transmitter Preset
+			 *
+			 * 'eq_presets_Ngts' is an array of u8 (byte).
+			 * Therefore, we need to write to the Lane Equalization Control
+			 * register in units of bytes per-Lane.
+			 */
+			for (i = 0; i < max_lanes; i++)
+				cdns_pcie_rp_writeb(pcie, lane_eq_ctrl_reg + i, presets_ngts[i]);
+
+			dev_info(dev, "Link Equalization presets applied for 16.0 GT/s\n");
+		}
+	case PCIE_SPEED_8_0GT:
+		presets_8gts = (u16 *)rc->eq_presets.eq_presets_8gts;
+		if ((presets_8gts[0] & PCI_EQ_RESV) != PCI_EQ_RESV) {
+			cap = cdns_pcie_find_ext_capability(pcie, PCI_EXT_CAP_ID_SECPCI);
+			if (!cap)
+				break;
+			lane_eq_ctrl_reg = cap + PCI_SECPCI_LE_CTRL;
+			/*
+			 * For a Link Speed of 8.0 GT/s, the Lane Equalization Control register has
+			 * the following layout per Lane:
+			 * Bits   0-3:  Downstream Port Transmitter Preset
+			 * Bits   4-6:  Downstream Port Receiver Preset Hint
+			 * Bit      7:  Reserved
+			 * Bits  8-11:  Upstream Port Transmitter Preset
+			 * Bits 12-14:  Upstream Port Receiver Preset Hint
+			 * Bit     15:  Reserved
+			 *
+			 * 'eq_presets_8gts' is an array of u16 (word).
+			 * Therefore, we need to write to the Lane Equalization Control
+			 * register in units of words per-Lane.
+			 */
+			for (i = 0, j = 0; i < max_lanes; i++, j += 2)
+				cdns_pcie_rp_writew(pcie, lane_eq_ctrl_reg + j, presets_8gts[i]);
+
+			dev_info(dev, "Link Equalization presets applied for 8.0 GT/s\n");
+		}
+	}
+}
+
 static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
@@ -600,6 +683,7 @@ int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
 
 	cdns_pcie_host_enable_ptm_response(pcie);
+	cdns_pcie_setup_lane_equalization_presets(rc);
 
 	ret = cdns_pcie_start_link(pcie);
 	if (ret) {
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index e2a853d2c0ab..39d03b309978 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -11,6 +11,8 @@
 #include <linux/pci-epf.h>
 #include <linux/phy/phy.h>
 
+#include "../../pci.h"
+
 /* Parameters for the waiting for link up routine */
 #define LINK_WAIT_MAX_RETRIES	10
 #define LINK_WAIT_USLEEP_MIN	90000
@@ -288,6 +290,8 @@ struct cdns_pcie {
  *                available
  * @quirk_retrain_flag: Retrain link as quirk for PCIe Gen2
  * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
+ * @eq_presets: Lane Equalization presets for Link Speed including and upward
+ *              of 8.0 GT/s
  */
 struct cdns_pcie_rc {
 	struct cdns_pcie	pcie;
@@ -298,6 +302,7 @@ struct cdns_pcie_rc {
 	bool			avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
 	unsigned int		quirk_retrain_flag:1;
 	unsigned int		quirk_detect_quiet_flag:1;
+	struct pci_eq_presets	eq_presets;
 };
 
 /**
-- 
2.51.0


