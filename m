Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEAE50544
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 11:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfFXJPb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 05:15:31 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14480 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfFXJPa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jun 2019 05:15:30 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1094ae0000>; Mon, 24 Jun 2019 02:15:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 24 Jun 2019 02:15:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 24 Jun 2019 02:15:28 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Jun
 2019 09:15:28 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Jun
 2019 09:15:27 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 24 Jun 2019 09:15:27 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d1094aa000f>; Mon, 24 Jun 2019 02:15:27 -0700
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
Subject: [PATCH V11 01/12] PCI: Add #defines for some of PCIe spec r4.0 features
Date:   Mon, 24 Jun 2019 14:44:54 +0530
Message-ID: <20190624091505.1711-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624091505.1711-1-vidyas@nvidia.com>
References: <20190624091505.1711-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561367727; bh=jQ0/DrjetyRKjWbooQREwDcgZAJE6UmaJLMRuUPV6Ak=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=XN2A8+Tb/U+2f8jc1Zytit6w8nFawjIOum3fW8OmvuX7JelPjmYX7gejQEnnqr16r
         9lH8xN15s+u2ar55ZAVEeKqoesTMV3F0sckfa7YtAxyOTwIx0f8lPVd9dO+caQQZvv
         NdiOOn2y9BFvJ8k+YqtQyJ44vfnn7EX/20MInhTZQJqp6NUzyjjJNh/S21mNi1zJl6
         f8eUigmcAMDWEacqXgQHQhcBYbmFbCTMw42CVQBmbRvGs++sj+pt7RUWsv46lDPh3K
         1MRHSyG6k8/6I+QDl/H6nvSpWoTtjktVVBq76ulJDJuoOZ7d6CJMalABnRCmWKZZ4u
         dCr4CHk5esYfA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add #defines only for the Data Link Feature and Physical Layer 16.0 GT/s
features.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
---
Changes since [v10]:
* None

Changes since [v9]:
* None

Changes since [v8]:
* None

Changes since [v7]:
* None

Changes since [v6]:
* None

Changes since [v5]:
* None

Changes since [v4]:
* None

Changes since [v3]:
* None

Changes since [v2]:
* Updated commit message and description to explicitly mention that defines are
  added only for some of the features and not all.

Changes since [v1]:
* None

 include/uapi/linux/pci_regs.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index f28e562d7ca8..1c79f6a097d2 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -713,7 +713,9 @@
 #define PCI_EXT_CAP_ID_DPC	0x1D	/* Downstream Port Containment */
 #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
 #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PTM
+#define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
+#define PCI_EXT_CAP_ID_PL	0x26	/* Physical Layer 16.0 GT/s */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
@@ -1053,4 +1055,22 @@
 #define  PCI_L1SS_CTL1_LTR_L12_TH_SCALE	0xe0000000  /* LTR_L1.2_THRESHOLD_Scale */
 #define PCI_L1SS_CTL2		0x0c	/* Control 2 Register */
 
+/* Data Link Feature */
+#define PCI_DLF_CAP		0x04	/* Capabilities Register */
+#define  PCI_DLF_LOCAL_DLF_SUP_MASK	0x007fffff  /* Local Data Link Feature Supported */
+#define  PCI_DLF_EXCHANGE_ENABLE	0x80000000  /* Data Link Feature Exchange Enable */
+#define PCI_DLF_STS		0x08	/* Status Register */
+#define  PCI_DLF_REMOTE_DLF_SUP_MASK	0x007fffff  /* Remote Data Link Feature Supported */
+#define  PCI_DLF_REMOTE_DLF_SUP_VALID	0x80000000  /* Remote Data Link Feature Support Valid */
+
+/* Physical Layer 16.0 GT/s */
+#define PCI_PL_16GT_CAP		0x04	/* Capabilities Register */
+#define PCI_PL_16GT_CTRL	0x08	/* Control Register */
+#define PCI_PL_16GT_STS		0x0c	/* Status Register */
+#define PCI_PL_16GT_LDPM_STS	0x10	/* Local Data Parity Mismatch Status Register */
+#define PCI_PL_16GT_FRDPM_STS	0x14	/* First Retimer Data Parity Mismatch Status Register */
+#define PCI_PL_16GT_SRDPM_STS	0x18	/* Second Retimer Data Parity Mismatch Status Register */
+#define PCI_PL_16GT_RSVD	0x1C	/* Reserved */
+#define PCI_PL_16GT_LE_CTRL	0x20	/* Lane Equalization Control Register */
+
 #endif /* LINUX_PCI_REGS_H */
-- 
2.17.1

