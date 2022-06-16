Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A260C54E0FA
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 14:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiFPMou (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jun 2022 08:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiFPMoq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2022 08:44:46 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2065.outbound.protection.outlook.com [40.107.96.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82A73F8B1;
        Thu, 16 Jun 2022 05:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTf2CbMSRdm2/Kg+8bLLoiaqqyjQEV0wxwQzaTsBtNISSZdO4aVSyqOj+SW+ImDLr0AeTG41CWjA2Qm/P5VV1sBM+HIo0iJZwyZVT0sjDnd7w5UkMGa1MRWMjXZT9Dt4RdnUQy7UME8yk0NAqeMJLo2inlIMyJosyYJ0+UzSmP6kdBEYfkdEK3HBtQYq2KA/F24QdQuVyJuaSid8m2W2JBoDuRq5wKWxZeO3KI8zpQ3zb714MkM2cQd/sEtkE+PIqj2HVVK4KmSF4NCMWdTaiCJ8tP53eMbs+HbHBs6hTIR0lctyC7T19SLCklsDlRN7WW4C/M+Vwvvqv0ntfZWy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ2RMDeBBUL290SYRRhu3qCiF5XEVuN/6QlCMSYkVA0=;
 b=Nhe1dl+Qf36DkwYUc1F6O6cEbnLcjbNqYKOZA+iGM/wIX9M9GI5iEgyzZx7rcACnMcxiZDHbokdPT3SC8A3jZDn6OxI/NdkviAwDmWoC2Ktu/XWvpwBDHD4pF7qiJayIuTg3CoMbCqqrdSRfNda0UfdGQUiEOJQnERKIc8K91OHWvO3ioos0dWf8ysETPLpD/LpGIXcgVPGtztcrxuFioCHHcopSM1rigg7uSqklaBv/L9RLxxgGj7XwATlMoHPvQ6brmlmBoVpbO91kMl2VV6ZjHQ6R7bMmdKqCRvyxtNVAMBvhg3T9f3k7OFIPu/gByIpePtpNO+kFQ6pbKvzktA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ2RMDeBBUL290SYRRhu3qCiF5XEVuN/6QlCMSYkVA0=;
 b=VHHMtn3YZY/lfVMKiAzDpfsvtKwKCLS8P9MH5hpR1uX0ZCxgkrNTdV0a1Jq6ZftbD2sZCaA5ti/8OFxwvWGnNzgCs2IOK6QjLz14jCZBcoi2wRzMRfth27V2sU/D8ao4eBKSGwhnqvaRUL8WvQof5hsjghfJ0LVCXTQUnHSuiqU=
Received: from DS7PR05CA0089.namprd05.prod.outlook.com (2603:10b6:8:56::6) by
 CY4PR02MB2696.namprd02.prod.outlook.com (2603:10b6:903:11b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Thu, 16 Jun
 2022 12:44:42 +0000
Received: from DM3NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::4) by DS7PR05CA0089.outlook.office365.com
 (2603:10b6:8:56::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.9 via Frontend
 Transport; Thu, 16 Jun 2022 12:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT013.mail.protection.outlook.com (10.13.5.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Thu, 16 Jun 2022 12:44:42 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 16 Jun 2022 05:44:41 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 16 Jun 2022 05:44:41 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.140.9.2] (port=44392 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1o1orZ-000Aiu-4P; Thu, 16 Jun 2022 05:44:41 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>, <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v5 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root Port
Date:   Thu, 16 Jun 2022 18:14:29 +0530
Message-ID: <20220616124429.12917-3-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220616124429.12917-1-bharat.kumar.gogada@xilinx.com>
References: <20220616124429.12917-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e62ebc9-6b86-4b0d-c678-08da4f95fc21
X-MS-TrafficTypeDiagnostic: CY4PR02MB2696:EE_
X-Microsoft-Antispam-PRVS: <CY4PR02MB26967B368A218851588920CFA5AC9@CY4PR02MB2696.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHT7cDTCZhT9mH6/OGIDZttPiEcosyxiwyc2qB4tWw7BDnGfXfMnVlL270Ziwa4E+ugCTEpSXbpRUR4L0SPHGKN1vrp28BCwt/NCYVv6J8YXjuYx1+0DkRb1nYWzBgJalqjptTJFxXHeZREwbSucH+H5UkLQ9FDlQjNhcySQDYhVH5eGc4eB8YBvnjCtmXm3M5fCLT4RDlMu/2vasiNGMkZM4IRtSao+iPswUj9GAgoLLY9xZUghMmVGNtiDMMQ6uzYvcjD2tfrSWSJTA/4Sdalx2UWkdWs7AbCAloFIeKfC6HPY+DnO0TtYmq2pSNVjXUJq8GGwscYnHy9i991yrwu6Ok2NZEG06/Nw1ebNRFxNVNIkeb3m7rIEgOi1rFfplztgujj+7HCekjJDEbrV0RPIlLSxF/7pYjalAMGGUkAvBE/xIFXqr4WqASSnhs7asGmLlCfCS0oDhPCNc1RsFFq+yPea1Jo5MoQlaoGpHl+fSRjhg5/MrSSahkjPjmpMj+aDtEFzlr2JHk+RonM16JOOTk5TMoBP5jmarZpKQ/ltwd7Q+8xEqvcn1ql7t/8IqbRERkUmu+h/oKQjrxbX9EJGxw3NykXL0yGMw5t90Io1UH5gS3in0mEFb88HJIYS+nsTPR5A9gdzVUP4RSUj4VW8CA6IlSTfP9zOGeQKJIiqwx17qiKwsCQxW6yeUS9v20iq6CwIYiyDhzCuTSZ1cQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(107886003)(186003)(103116003)(2616005)(9786002)(508600001)(26005)(1076003)(5660300002)(7636003)(7696005)(2906002)(6666004)(8936002)(70206006)(40460700003)(70586007)(356005)(54906003)(83380400001)(110136005)(336012)(426003)(4326008)(36860700001)(8676002)(316002)(36756003)(47076005)(82310400005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 12:44:42.4202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e62ebc9-6b86-4b0d-c678-08da4f95fc21
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT013.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2696
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Xilinx Versal Premium series has CPM5 block which supports Root Port
functioning at Gen5 speed.

Xilinx Versal CPM5 has few changes with existing CPM block.
- CPM5 has dedicated register space for control and status registers.
- CPM5 legacy interrupt handling needs additional register bit
  to enable and handle legacy interrupts.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 62 ++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index c7cd44ed4dfc..0bcd11d27eeb 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -35,6 +35,10 @@
 #define XILINX_CPM_PCIE_MISC_IR_ENABLE	0x00000348
 #define XILINX_CPM_PCIE_MISC_IR_LOCAL	BIT(1)
 
+#define XILINX_CPM_PCIE_IR_STATUS       0x000002A0
+#define XILINX_CPM_PCIE_IR_ENABLE       0x000002A8
+#define XILINX_CPM_PCIE_IR_LOCAL        BIT(0)
+
 /* Interrupt registers definitions */
 #define XILINX_CPM_PCIE_INTR_LINK_DOWN		0
 #define XILINX_CPM_PCIE_INTR_HOT_RESET		3
@@ -98,6 +102,16 @@
 /* Phy Status/Control Register definitions */
 #define XILINX_CPM_PCIE_REG_PSCR_LNKUP		BIT(11)
 
+/**
+ * struct xilinx_cpm_variant - CPM variant information
+ * @cpm_version: CPM5 has few changes compared to CPM block.
+ *      CPM5 has dedicated register space for control and status registers.
+ *
+ */
+struct xilinx_cpm_variant {
+	bool cpm_version;
+};
+
 /**
  * struct xilinx_cpm_pcie - PCIe port information
  * @dev: Device pointer
@@ -109,6 +123,7 @@
  * @intx_irq: legacy interrupt number
  * @irq: Error interrupt number
  * @lock: lock protecting shared register access
+ * @is_cpm5: value to check cpm version
  */
 struct xilinx_cpm_pcie {
 	struct device			*dev;
@@ -120,6 +135,7 @@ struct xilinx_cpm_pcie {
 	int				intx_irq;
 	int				irq;
 	raw_spinlock_t			lock;
+	bool                            is_cpm5;
 };
 
 static u32 pcie_read(struct xilinx_cpm_pcie *port, u32 reg)
@@ -285,6 +301,14 @@ static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
 		generic_handle_domain_irq(port->cpm_domain, i);
 	pcie_write(port, val, XILINX_CPM_PCIE_REG_IDR);
 
+	if (port->is_cpm5) {
+		val = readl_relaxed(port->cpm_base + XILINX_CPM_PCIE_IR_STATUS);
+		if (val)
+			writel_relaxed(val,
+				       port->cpm_base +
+				       XILINX_CPM_PCIE_IR_STATUS);
+	}
+
 	/*
 	 * XILINX_CPM_PCIE_MISC_IR_STATUS register is mapped to
 	 * CPM SLCR block.
@@ -484,6 +508,12 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 	 */
 	writel(XILINX_CPM_PCIE_MISC_IR_LOCAL,
 	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
+
+	if (port->is_cpm5) {
+		writel(XILINX_CPM_PCIE_IR_LOCAL,
+		       port->cpm_base + XILINX_CPM_PCIE_IR_ENABLE);
+	}
+
 	/* Enable the Bridge enable bit */
 	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
 		   XILINX_CPM_PCIE_REG_RPSC_BEN,
@@ -503,6 +533,10 @@ static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
 	struct device *dev = port->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *res;
+	const struct xilinx_cpm_variant *variant =
+		of_device_get_match_data(dev);
+
+	port->is_cpm5 = variant->cpm_version;
 
 	port->cpm_base = devm_platform_ioremap_resource_byname(pdev,
 							       "cpm_slcr");
@@ -518,7 +552,14 @@ static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
 	if (IS_ERR(port->cfg))
 		return PTR_ERR(port->cfg);
 
-	port->reg_base = port->cfg->win;
+	if (port->is_cpm5) {
+		port->reg_base = devm_platform_ioremap_resource_byname(pdev,
+								       "cpm_csr");
+		if (IS_ERR(port->reg_base))
+			return PTR_ERR(port->reg_base);
+	} else {
+		port->reg_base = port->cfg->win;
+	}
 
 	return 0;
 }
@@ -591,9 +632,24 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+static const struct xilinx_cpm_variant cpm_host = {
+	.cpm_version = false,
+};
+
+static const struct xilinx_cpm_variant cpm5_host = {
+	.cpm_version = true,
+};
+
 static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
-	{ .compatible = "xlnx,versal-cpm-host-1.00", },
-	{}
+	{
+		.compatible = "xlnx,versal-cpm-host-1.00",
+		.data = &cpm_host,
+	},
+	{
+		.compatible = "xlnx,versal-cpm5-host",
+		.data = &cpm5_host,
+	},
+	{},
 };
 
 static struct platform_driver xilinx_cpm_pcie_driver = {
-- 
2.17.1

