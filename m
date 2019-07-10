Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5552B6411B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2019 08:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfGJGWo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jul 2019 02:22:44 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2259 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfGJGWo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jul 2019 02:22:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d2584310003>; Tue, 09 Jul 2019 23:22:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 09 Jul 2019 23:22:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 09 Jul 2019 23:22:43 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Jul
 2019 06:22:42 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 10 Jul 2019 06:22:42 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d25842d0000>; Tue, 09 Jul 2019 23:22:42 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V13 01/12] PCI: Add #defines for some of PCIe spec r4.0 features
Date:   Wed, 10 Jul 2019 11:52:01 +0530
Message-ID: <20190710062212.1745-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710062212.1745-1-vidyas@nvidia.com>
References: <20190710062212.1745-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562739761; bh=WJoTFrZ6vHVNeo9jqVEQitDnvShsfQ/nBJU7EhnuY00=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=qrqft/jWqEP37c5hcZcFJjWL+3SGkUaUZm1FnERM2Y6dFHPew4d7JK5s1OcPyS5yF
         eY/doeVOqapZrXe4sNRIhzgt7J00etlLarTh3PteVSeGpez911ghF9ZkO6GY1CyEO3
         D9QbjTXYZOaNnGSa44sNp3IoYZMwPlaTVbZ6pCIMyI5VLoKuAZCBXWQ4ymWkFSlq5V
         dF9bqWD41vp0PO/bQqZCQtuusAZXdirfEk8iQ048PxT+nXdtSPjawi6TcSB0O+hkTX
         OIvrLzMiY/dL2kZ1ogsh2xTvZOjd4+wm/ckYrmZOZ0Q6uFyojkK8dRdWJUwMw4xX+N
         iiNR6tpdmOelA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add #defines only for the Data Link Feature and Physical Layer 16.0 GT/s
features as defined in PCIe spec r4.0, sec 7.7.4 for Data Link Feature and
sec 7.7.5 for Physical Layer 16.0 GT/s.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
---
V13:
* Updated commit message to include references from spec
* Removed unused defines and moved some from pcie-tegra194.c file
* Addressed review comments from Bjorn

V12:
* None

V11:
* None

V10:
* None

V9:
* None

V8:
* None

V7:
* None

V6:
* None

V5:
* None

V4:
* None

V3:
* Updated commit message and description to explicitly mention that defines are
  added only for some of the features and not all.

V2:
* None

 include/uapi/linux/pci_regs.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index f28e562d7ca8..d28d0319d932 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -713,7 +713,9 @@
 #define PCI_EXT_CAP_ID_DPC	0x1D	/* Downstream Port Containment */
 #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
 #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PTM
+#define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
+#define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_16GT
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
@@ -1053,4 +1055,14 @@
 #define  PCI_L1SS_CTL1_LTR_L12_TH_SCALE	0xe0000000  /* LTR_L1.2_THRESHOLD_Scale */
 #define PCI_L1SS_CTL2		0x0c	/* Control 2 Register */
 
+/* Data Link Feature */
+#define PCI_DLF_CAP		0x04	/* Capabilities Register */
+#define  PCI_DLF_EXCHANGE_ENABLE	0x80000000  /* Data Link Feature Exchange Enable */
+
+/* Physical Layer 16.0 GT/s */
+#define PCI_PL_16GT_LE_CTRL	0x20	/* Lane Equalization Control Register */
+#define  PCI_PL_16GT_LE_CTRL_DSP_TX_PRESET_MASK		0x0000000F
+#define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
+#define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
+
 #endif /* LINUX_PCI_REGS_H */
-- 
2.17.1

