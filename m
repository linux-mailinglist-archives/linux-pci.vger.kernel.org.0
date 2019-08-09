Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A300D870C6
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 06:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfHIEqZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 00:46:25 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5502 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfHIEqZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2019 00:46:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4cfaa20000>; Thu, 08 Aug 2019 21:46:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 08 Aug 2019 21:46:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 08 Aug 2019 21:46:24 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 9 Aug
 2019 04:46:24 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 9 Aug
 2019 04:46:23 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 9 Aug 2019 04:46:23 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d4cfa9a0000>; Thu, 08 Aug 2019 21:46:23 -0700
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
Subject: [PATCH V15 01/13] PCI: Add #defines for some of PCIe spec r4.0 features
Date:   Fri, 9 Aug 2019 10:15:57 +0530
Message-ID: <20190809044609.20401-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190809044609.20401-1-vidyas@nvidia.com>
References: <20190809044609.20401-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565325986; bh=yFehXsjNRJlHL1q3HvFaPjCAb4XcBfWHr7DU4Chl2+E=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ZkkApcqIP6rS4apWxAauoQ0sCR80NNyVRug21JxPLtuoRreP/Z8cHWhEWO2U3q1LO
         iEJW/Yio6I6rk/I6runlgLfZ/no1zYeuBahes6oNkZWWNGzFgXEJqfjZHLec+nI6ut
         fUGwAfrQ2kodhis8kxDu49hZ96mZgv21sefHW+66zVJyoL8qllLOPlAtRnx4LMO6si
         hBcU5pkpnbnd3sw9dT2BsiWHbXam8GeX3HYNlQ743zVHK4u1ZyNt4OxpPXQDbOL+PA
         cRtdJxtIUpWqGT/nCOxlcZCeEpxc/AceNcFIlLuOzMY7SR/wQ3cG6fNPQlO1hM2SKU
         sp5vSrzzsXAag==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add #defines only for the Data Link Feature and Physical Layer 16.0 GT/s
features as defined in PCIe spec r4.0, sec 7.7.4 for Data Link Feature and
sec 7.7.5 for Physical Layer 16.0 GT/s.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
V15:
* None

V14:
* Added 'Acked-by: Bjorn Helgaas <bhelgaas@google.com>'

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

