Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8B257CD62
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 16:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiGUOWj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 10:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiGUOWS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 10:22:18 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB0D8238F;
        Thu, 21 Jul 2022 07:22:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F92hiZpnBfF/s6aUMq0e1T/phK7u20a9UrbNWVoa5LaufvNCZrocONaoE42/cznSBAw3trilLdQGjXzoIY1wYlVPPJk7dEdLoT/HuE+wTHEhjWpsi83fYjnjqCLbvB5utclZNYty8mk7Ds7EjY0nouTblZdOJfmuXyIZxQcf8xeXdVVRDR8eittbDVmjDWpzuWh2wTrsB2KZNImKuEWKopS5cbrb8K1MmNEhWcVXZ/0OUQ/cr09MEkcR99f5PjJ5GlAqQZHF26C2Ql8VHRb8ToszHk8MB2LQtz/VeSaMLCctHGXRyuM2UrAl5JWbRqeZ3T9EKKqSYW6Rn/0FVUoYLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKCR8VnuXmVQED13rgLYPLkUEtaE9k07Pm8OW+gHayU=;
 b=GhKY3iOLDyBVFyeq0v1ZJvISWAM42bL3ZARvZo1rvkE5DD8qFQaJkwuZA+6bhV6AUxCFs2+RqS5bXlBjGGFQCCjDiROw+FV1rDZsppQ+/qzUIItKUTgQ+hdwgLuAEPF55MnEq0yAYGZYH1TKpY5ntpEJhBCLZspUT25LJOqd+7XoeRPgSHK0K9RqCoF6q+8I82DNhIjYaQYygx5FsNEdPSahne7N8nbmWYmZEYWj75PSqGsR7LSf8jVJzzXAd6LTTL4b5qBjWvl325++/VjgvUxzmB6JHBzl3Ui1h3VWxJbseHXIfMZzDOKywfIdGoEgPFAAJyIHOXZNGc2wtQ/2cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKCR8VnuXmVQED13rgLYPLkUEtaE9k07Pm8OW+gHayU=;
 b=QW/WpMhAD6RGb7x8+Ez1Ge0C3rc94C0Xb3fE0DqWRTkEzvjDLudQUO44G0NY3t1mQzqOdLUcoc1XskumetxZCSG6ScawlcXyxKlb/SfeJ8HoAHqqSyHPeULmY/PYQfNQBm8POBGNXHsWQWj9Kl2bPoBAWQJ8jlkb8aMRa9cr+F08F57kHv0CCSt2XphA0ufkHt1UrbOrptYp2HBOCIto59KhgfZNULELD+5BZlgy8w3SxBbt6Rsx6/EDzeNjNVTQjzizHiZDOrtQ4PtPFEEmro9HrMVEnCGCYyEOpN4y1BPwU0TDcO3W1CBy4WjXjpewiXrEPFOxseWJkmmM5id68A==
Received: from BN8PR15CA0072.namprd15.prod.outlook.com (2603:10b6:408:80::49)
 by DS0PR12MB6632.namprd12.prod.outlook.com (2603:10b6:8:d0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.23; Thu, 21 Jul 2022 14:22:13 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::72) by BN8PR15CA0072.outlook.office365.com
 (2603:10b6:408:80::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Thu, 21 Jul 2022 14:22:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 14:22:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 21 Jul 2022 14:22:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 21 Jul 2022 07:22:11 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 21 Jul 2022 07:22:07 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V6 09/16] PCI: tegra194: Find RAS DES PCIe capability offset
Date:   Thu, 21 Jul 2022 19:50:45 +0530
Message-ID: <20220721142052.25971-10-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220721142052.25971-1-vidyas@nvidia.com>
References: <20220721142052.25971-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60d771df-1dc1-4a44-e1ef-08da6b2467e3
X-MS-TrafficTypeDiagnostic: DS0PR12MB6632:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dr1PwUaMBRTpOAIKY0qhe6YfOGhfaUa5ty/tzkh3BUZPOXLhO9ce64fAFcfF9orOGWn0MyUwbs4Tr2UHj1uQmovCpDCTYgR0zx5YJGR2UEuJLRGIQUmkXDXnVn4PyoLnPr/NZua4KGPfHwQO+mQzgfSQVoJVdrMrXbz2VwVcGFknTUaXw2H1l2uE25391MdiefPW0TXaV583dFasMglJc7P6lUoAMPSD6cj2xpIRQ843MuoLfXINhCHt3qQTSKH1qMPocruS6SQzy7z9rtfnD/CvQaILxnlRl8EuTw6wwrOItY4VM90mKQkDSoeGqe7gqaWtgFYuIfcTdN1fOHzd7gvjvIq/dQNPnFBuwyhbbo1/oL1NfA+aqRU6GXhJmxif3QF126iLUOcxeQU7HV5QRGxrdKXc7Krm9tAQVpG4jDl/XFJO9C+6yCJ+S/p7ZV06Wh6jchAYM+x78IfeYIJTbCAzyH97d9gKaTArgg0jpYrf6Bb/Yg0YlGDvyMHXVRfzmdr6MR9nT71hOjV3GsjfSS2J9+rUOYhDWD+1BMnVaAyBp5be4E+OhO9murOhtRR3RD1X8vuhUPwr58QrUqfRnMi3OIYL2ZHin8nCLsCqP+YMKjFj3hD0YLocS0q8MGGC4IhExB3NiBn7bxYVYMzzAK2oMFfblzFcLP5xAFxjENT9weKIUcjabSNiRLK2eOhGFpr5ISDFv8hHGTr4+DWniliD7qv1w/2mG/DjP4u0kzuZNMnqQVMkw/kdW7uVe38NZ5rpFBmSgGBsVPSKpiwj95KPaw29dMSfJX5IjjA2TJkPjJLICCs/THa1ocUhPJbj/9Wt5Et1VcJdI9KWLCABMansO5+hSAzBf7sC8uFoVY=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(376002)(36840700001)(40470700004)(46966006)(41300700001)(47076005)(36756003)(110136005)(82310400005)(36860700001)(336012)(40460700003)(54906003)(186003)(2906002)(2616005)(70206006)(426003)(478600001)(1076003)(26005)(83380400001)(86362001)(70586007)(316002)(81166007)(356005)(8676002)(7696005)(8936002)(7416002)(6666004)(82740400003)(40480700001)(5660300002)(4326008)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 14:22:13.0610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d771df-1dc1-4a44-e1ef-08da6b2467e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6632
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Find RAS DES PCIe capability offset instead of hardcoding the offset
for each controller.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V6:
* New addition in V6 based on Bjorn's review comment

 drivers/pci/controller/dwc/pcie-designware.h | 19 +++++++
 drivers/pci/controller/dwc/pcie-tegra194.c   | 53 ++++++--------------
 2 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 8fd3ad70dd2f..77c17cf1cc29 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -130,6 +130,25 @@
 #define PCIE_ATU_UNR_UPPER_TARGET	0x18
 #define PCIE_ATU_UNR_UPPER_LIMIT	0x20
 
+/*
+ * RAS-DES register definitions
+ */
+#define PCIE_RAS_DES_EVENT_COUNTER_CONTROL	0x8
+#define EVENT_COUNTER_ALL_CLEAR		0x3
+#define EVENT_COUNTER_ENABLE_ALL	0x7
+#define EVENT_COUNTER_ENABLE_SHIFT	2
+#define EVENT_COUNTER_EVENT_SEL_MASK	GENMASK(7, 0)
+#define EVENT_COUNTER_EVENT_SEL_SHIFT	16
+#define EVENT_COUNTER_EVENT_Tx_L0S	0x2
+#define EVENT_COUNTER_EVENT_Rx_L0S	0x3
+#define EVENT_COUNTER_EVENT_L1		0x5
+#define EVENT_COUNTER_EVENT_L1_1	0x7
+#define EVENT_COUNTER_EVENT_L1_2	0x8
+#define EVENT_COUNTER_GROUP_SEL_SHIFT	24
+#define EVENT_COUNTER_GROUP_5		0x5
+
+#define PCIE_RAS_DES_EVENT_COUNTER_DATA		0xc
+
 /*
  * The default address offset between dbi_base and atu_base. Root controller
  * drivers are not required to initialize atu_base if the offset matches this
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index bd16245fc2c4..6f890453021d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -170,19 +170,6 @@
 #define CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF	0x718
 #define CFG_TIMER_CTRL_ACK_NAK_SHIFT	(19)
 
-#define EVENT_COUNTER_ALL_CLEAR		0x3
-#define EVENT_COUNTER_ENABLE_ALL	0x7
-#define EVENT_COUNTER_ENABLE_SHIFT	2
-#define EVENT_COUNTER_EVENT_SEL_MASK	GENMASK(7, 0)
-#define EVENT_COUNTER_EVENT_SEL_SHIFT	16
-#define EVENT_COUNTER_EVENT_Tx_L0S	0x2
-#define EVENT_COUNTER_EVENT_Rx_L0S	0x3
-#define EVENT_COUNTER_EVENT_L1		0x5
-#define EVENT_COUNTER_EVENT_L1_1	0x7
-#define EVENT_COUNTER_EVENT_L1_2	0x8
-#define EVENT_COUNTER_GROUP_SEL_SHIFT	24
-#define EVENT_COUNTER_GROUP_5		0x5
-
 #define N_FTS_VAL					52
 #define FTS_VAL						52
 
@@ -266,6 +253,7 @@ struct tegra_pcie_dw {
 	u32 num_lanes;
 	u32 cid;
 	u32 cfg_link_cap_l1sub;
+	u32 ras_des_cap;
 	u32 pcie_cap_base;
 	u32 aspm_cmrt;
 	u32 aspm_pwr_on_t;
@@ -574,24 +562,6 @@ static struct pci_ops tegra_pci_ops = {
 };
 
 #if defined(CONFIG_PCIEASPM)
-static const u32 event_cntr_ctrl_offset[] = {
-	0x1d8,
-	0x1a8,
-	0x1a8,
-	0x1a8,
-	0x1c4,
-	0x1d8
-};
-
-static const u32 event_cntr_data_offset[] = {
-	0x1dc,
-	0x1ac,
-	0x1ac,
-	0x1ac,
-	0x1c8,
-	0x1dc
-};
-
 static void disable_aspm_l11(struct tegra_pcie_dw *pcie)
 {
 	u32 val;
@@ -614,13 +584,16 @@ static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
 {
 	u32 val;
 
-	val = dw_pcie_readl_dbi(&pcie->pci, event_cntr_ctrl_offset[pcie->cid]);
+	val = dw_pcie_readl_dbi(&pcie->pci, pcie->ras_des_cap +
+				PCIE_RAS_DES_EVENT_COUNTER_CONTROL);
 	val &= ~(EVENT_COUNTER_EVENT_SEL_MASK << EVENT_COUNTER_EVENT_SEL_SHIFT);
 	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
 	val |= event << EVENT_COUNTER_EVENT_SEL_SHIFT;
 	val |= EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
-	dw_pcie_writel_dbi(&pcie->pci, event_cntr_ctrl_offset[pcie->cid], val);
-	val = dw_pcie_readl_dbi(&pcie->pci, event_cntr_data_offset[pcie->cid]);
+	dw_pcie_writel_dbi(&pcie->pci, pcie->ras_des_cap +
+			   PCIE_RAS_DES_EVENT_COUNTER_CONTROL, val);
+	val = dw_pcie_readl_dbi(&pcie->pci, pcie->ras_des_cap +
+				PCIE_RAS_DES_EVENT_COUNTER_DATA);
 
 	return val;
 }
@@ -647,13 +620,15 @@ static int aspm_state_cnt(struct seq_file *s, void *data)
 		   event_counter_prog(pcie, EVENT_COUNTER_EVENT_L1_2));
 
 	/* Clear all counters */
-	dw_pcie_writel_dbi(&pcie->pci, event_cntr_ctrl_offset[pcie->cid],
+	dw_pcie_writel_dbi(&pcie->pci, pcie->ras_des_cap +
+			   PCIE_RAS_DES_EVENT_COUNTER_CONTROL,
 			   EVENT_COUNTER_ALL_CLEAR);
 
 	/* Re-enable counting */
 	val = EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
 	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
-	dw_pcie_writel_dbi(&pcie->pci, event_cntr_ctrl_offset[pcie->cid], val);
+	dw_pcie_writel_dbi(&pcie->pci, pcie->ras_des_cap +
+			   PCIE_RAS_DES_EVENT_COUNTER_CONTROL, val);
 
 	return 0;
 }
@@ -666,10 +641,14 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 	val = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
 	pcie->cfg_link_cap_l1sub = val + PCI_L1SS_CAP;
 
+	pcie->ras_des_cap = dw_pcie_find_ext_capability(&pcie->pci,
+							PCI_EXT_CAP_ID_VNDR);
+
 	/* Enable ASPM counters */
 	val = EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
 	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
-	dw_pcie_writel_dbi(pci, event_cntr_ctrl_offset[pcie->cid], val);
+	dw_pcie_writel_dbi(pci, pcie->ras_des_cap +
+			   PCIE_RAS_DES_EVENT_COUNTER_CONTROL, val);
 
 	/* Program T_cmrt and T_pwr_on values */
 	val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
-- 
2.17.1

