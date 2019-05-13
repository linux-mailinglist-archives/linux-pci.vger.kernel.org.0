Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC4791AFC4
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 07:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfEMFHn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 01:07:43 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5073 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfEMFHn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 01:07:43 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd8fb770001>; Sun, 12 May 2019 22:07:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 12 May 2019 22:07:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 12 May 2019 22:07:42 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 05:07:41 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 13 May 2019 05:07:41 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cd8fb990000>; Sun, 12 May 2019 22:07:41 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V6 07/15] PCI: dwc: Add support to enable CDM register check
Date:   Mon, 13 May 2019 10:36:18 +0530
Message-ID: <20190513050626.14991-8-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513050626.14991-1-vidyas@nvidia.com>
References: <20190513050626.14991-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557724023; bh=7xxPkifwDteKlYRNf3xpXMWTfGiNI/BvKSG3YUqSokM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ZK7MSp1Eu0HmY29OPcYxj8eEHEmk3vXmsWCbEEY0UQkidwBZdf9oT5Kc9fpdwix19
         GNfaEq+NgOVRuVK310l9217XBuhwfuU4BuX8eLVWhK3Qyfn6sT1Fp1WBa5iRL8xR0N
         qWRbdx2tJUjpum+99NPqSfNLSW4s8pFW9q83fqBDKT0ZLEasjUuddk5FLpWSEQciE9
         Wov81O838iWu5l5SO+6/5zVSSzLrZY/6GU8WUbCRCBXgrHSmfEioltEfutCAKRll7N
         p+fho8XdELNYKTgBQgapcJ+7rhTHPyaxbtLFP6+5a7BMyaPhpErAkE6u93jZHb2yK1
         WCjMoX3tAVJ5Q==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to enable CDM (Configuration Dependent Module) register check
for any data corruption based on the device-tree flag 'enable-cdm-check'.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Changes since [v5]:
* None

Changes since [v4]:
* None

Changes since [v3]:
* None

Changes since [v2]:
* Changed code and commit description to reflect change in flag from
  'cdm-check' to 'enable-cdm-check'

Changes since [v1]:
* This is a new patch in v2 series

 drivers/pci/controller/dwc/pcie-designware.c | 7 +++++++
 drivers/pci/controller/dwc/pcie-designware.h | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index e46d19f61c9c..574245a63af5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -521,4 +521,11 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		break;
 	}
 	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+
+	if (of_property_read_bool(np, "enable-cdm-check")) {
+		val = dw_pcie_readl_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS);
+		val |= PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS |
+		       PCIE_PL_CHK_REG_CHK_REG_START;
+		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
+	}
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index fff284098117..55e9c941e280 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -86,6 +86,15 @@
 #define PCIE_MISC_CONTROL_1_OFF		0x8BC
 #define PCIE_DBI_RO_WR_EN		BIT(0)
 
+#define PCIE_PL_CHK_REG_CONTROL_STATUS			0xB20
+#define PCIE_PL_CHK_REG_CHK_REG_START			BIT(0)
+#define PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS		BIT(1)
+#define PCIE_PL_CHK_REG_CHK_REG_COMPARISON_ERROR	BIT(16)
+#define PCIE_PL_CHK_REG_CHK_REG_LOGIC_ERROR		BIT(17)
+#define PCIE_PL_CHK_REG_CHK_REG_COMPLETE		BIT(18)
+
+#define PCIE_PL_CHK_REG_ERR_ADDR			0xB28
+
 /*
  * iATU Unroll-specific register definitions
  * From 4.80 core version the address translation will be made by unroll
-- 
2.17.1

