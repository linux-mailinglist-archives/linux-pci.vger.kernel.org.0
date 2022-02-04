Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A4F4A99AD
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 14:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbiBDNGK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 08:06:10 -0500
Received: from mail-bn8nam12on2076.outbound.protection.outlook.com ([40.107.237.76]:52640
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240726AbiBDNGJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Feb 2022 08:06:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P913wYApW1i096sLwyUOtuplH9V0pe0Z5h4n1gfkY2Wz29V2rGlYolsZlDgI8MIlcF1weShHRLXgxMeCIeuwjj9RPah8oOeej9U2MN09sykF86RM2ZDFn2fgGuDq2bYzMCVdVbIem65/QYJ6kEAeuAd6RRJNgzW9Rztz8SRIpRcklRoozVUE64cEG9TJNecm4zPzauc98x3M1JwXsTAb8xrWB7fEGBZ/ySmZrzY4ZeJ8wSGJAOgJQUoGcogvE3T/+8lpV3FHyWHbvwHzC3Fopma4rFiVx5V2aM6bZU+kPdcPHJawawRtVffBqjYPFImUWu4glDY1Z7QayT32GirUkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQztx4CQJr/b+brzajSB/3W1dw9k+ExjvVcb8QD7fhE=;
 b=RBWXIUPOuc0c/QWKOjv4DI5GqrpRINN/H1iD90KowrTSGNIX+khwbnjgT/ilCNxinGc4CMCLWnDkVol5WbALFn82UYttY6EQPaWOw+8ckByY2l8YCuBQ1lNVqlYcW04kZDUKDvb6M6bHYuZryQ5kQNynd8EFQHIHTXAQmS1g6XBFBcFhTgHXoJyPF2etLr8aQf3l8wkYxDuDO/bJOsAlSIvdYK7Ov4nFPUFIzQGmNS/G9bzgOeBKH6heFWsFnxAYXzFEv9ZAPMMAvVSPTfhzl4eyitQRp/SDwhmCgliPSDJtzq1Zhlih2cFdo2bvq/tfpBLf4o1AjDQELDgLDQPqKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQztx4CQJr/b+brzajSB/3W1dw9k+ExjvVcb8QD7fhE=;
 b=sJOtHqxMrduZ08F1VIf5i01jzZyqxT2r5IYzTLK84xmYkq6tXqS8hThiBJgRD5+kOuy578NCHdikIApOTtMA7dyP8NashUsWCPxwK2by5NSLgvTknVR618AWxd9DesQZX6LK15JCLOvPzztGKO1p9A62row3q4HajTvlI6a5zRE=
Received: from BN0PR02CA0023.namprd02.prod.outlook.com (2603:10b6:408:e4::28)
 by DM6PR02MB5291.namprd02.prod.outlook.com (2603:10b6:5:45::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Fri, 4 Feb
 2022 13:06:07 +0000
Received: from BN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::b6) by BN0PR02CA0023.outlook.office365.com
 (2603:10b6:408:e4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 13:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT062.mail.protection.outlook.com (10.13.2.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 13:06:06 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 4 Feb 2022 05:05:54 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 4 Feb 2022 05:05:54 -0800
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com
Received: from [10.140.9.2] (port=44286 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nFyEN-000Bmk-73; Fri, 04 Feb 2022 05:02:27 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root Port driver
Date:   Fri, 4 Feb 2022 18:32:16 +0530
Message-ID: <20220204130216.2206-3-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220204130216.2206-1-bharat.kumar.gogada@xilinx.com>
References: <20220204130216.2206-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb334d17-bedb-4cff-e779-08d9e7df1b05
X-MS-TrafficTypeDiagnostic: DM6PR02MB5291:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB529161B7EFB9A6BE6F5FF199A5299@DM6PR02MB5291.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0uS4BlksizSF6upAkZdDEGIT6Ip8+0lxzLd2YBCcrsSvSloywdheXA75Xkwo32CNt8uftvLihrbBCzePHvCHDT+kDVqX7dstyCWZuSollgyh7UmqExf/9x4990qvuJ2QVon+pi+SEcV6s7uLYYPbxt+syOKmOtsXawAjJYCwthzHjx87DLvr6utnVj/ycwzx+5+mClOqHh7BnvNo0NcA3ug0d7bVJsAh0dwmWstdfmvCHnub2Ba7Cm6I5VFj2nuSJ5VZLEnLguDOj/Q3Bo77dLQj2Y0zSR1Vqf6COv4qZLbvcYN+v8Xs4emdGRiPd/e5NtWExfCZc0UqeJ15AgbF4RfzTevUi0HPOpEdn+n2cOLKQ1IL01XN23w3OY/A/k4wVs15hZiOrJVuFcq18fE47uUYJ7thSXFTYZPiQk6pO3kf6x/dGAB9FVdE81EH5pm8W+ryR5TgbZboTm1VqodT75gt8nusHyayw01gGkIO4tuhDSBaRfuVJd8sbjBAbdDKbjW5st4DFLa+YzZCUORtP8FftjhWA19VcSEtGmZp6calxLoJ2iGzClSzZ1aJGFrzXczTzGeS5A94V5jL0Kq2lQHno93uzHSxdkP24Kde8dUmgHK75OBYCUT90RfmAgdFFDE4dpQkkPDqCKLqb21vrAAR/7jdtPc8e6Zk4WWBR+ErFMNr2Z3Vb0sCIR2sUvbuKnWBnjgWVyu9DV/31Y3b5g==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(103116003)(336012)(26005)(186003)(426003)(8936002)(36860700001)(1076003)(82310400004)(8676002)(4326008)(7636003)(356005)(107886003)(83380400001)(47076005)(2906002)(6666004)(508600001)(40460700003)(36756003)(9786002)(7696005)(70206006)(110136005)(54906003)(2616005)(316002)(5660300002)(70586007)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 13:06:06.5324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb334d17-bedb-4cff-e779-08d9e7df1b05
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5291
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Xilinx Versal Premium series has CPM5 block which supports Root port
functioning at Gen5 speed.
Xilinx Versal CPM5 has few changes with existing CPM block.
- CPM5 has dedicated register space for control and status registers.
- CPM5 legacy interrupt handling needs additional register bit
  to enable and handle legacy interrupts.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 33 +++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index c7cd44ed4dfc..eb69f494571a 100644
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
@@ -109,6 +113,7 @@
  * @intx_irq: legacy interrupt number
  * @irq: Error interrupt number
  * @lock: lock protecting shared register access
+ * @is_cpm5: value to check cpm version
  */
 struct xilinx_cpm_pcie {
 	struct device			*dev;
@@ -120,6 +125,7 @@ struct xilinx_cpm_pcie {
 	int				intx_irq;
 	int				irq;
 	raw_spinlock_t			lock;
+	bool                            is_cpm5;
 };
 
 static u32 pcie_read(struct xilinx_cpm_pcie *port, u32 reg)
@@ -285,6 +291,14 @@ static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
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
@@ -484,6 +498,12 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
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
@@ -504,6 +524,9 @@ static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *res;
 
+	if (of_device_is_compatible(dev->of_node, "xlnx,versal-cpm5-host-1.00"))
+		port->is_cpm5 = true;
+
 	port->cpm_base = devm_platform_ioremap_resource_byname(pdev,
 							       "cpm_slcr");
 	if (IS_ERR(port->cpm_base))
@@ -518,7 +541,14 @@ static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
 	if (IS_ERR(port->cfg))
 		return PTR_ERR(port->cfg);
 
-	port->reg_base = port->cfg->win;
+	if (!port->is_cpm5) {
+		port->reg_base = port->cfg->win;
+	} else {
+		port->reg_base = devm_platform_ioremap_resource_byname(pdev,
+								       "cpm_csr");
+		if (IS_ERR(port->reg_base))
+			return PTR_ERR(port->reg_base);
+	}
 
 	return 0;
 }
@@ -593,6 +623,7 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 
 static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
 	{ .compatible = "xlnx,versal-cpm-host-1.00", },
+	{ .compatible = "xlnx,versal-cpm5-host-1.00", },
 	{}
 };
 
-- 
2.17.1

