Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DCB55021E
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jun 2022 04:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383937AbiFRCpV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 22:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383936AbiFRCpT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 22:45:19 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0566AA73;
        Fri, 17 Jun 2022 19:45:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoPxkTxc+kh+L3hJaFXeF8YrxO3uZCFOxhDd+J3PJoZDJ7wkuz8PjQkxFV5vpZL62cT+V4p5D6fQpDcg9EJKMeq9Sa1uxAVR9z8BtJsLYbornu05wVmWMHInsUvGiixITqS1QOFtNvZCZVPbF4QItEeDllYBrsmQCUFIicwZ0WNEEJRZCBRipCmVmXIX/OihXeWuv+vCYl3KYEB5RGD2OvFSDSHMRXcmjTkaD4eMjhi7FrJf1lE/7sfQriEQQLNtmti4nEKOeibc+qhad9J98WzJpRbUgy/n7LDgpa+UUVGv1qzMJktYqhit8UgxGm+gN0fPzmtK31UGWjjA/uCZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ2RMDeBBUL290SYRRhu3qCiF5XEVuN/6QlCMSYkVA0=;
 b=jJT+fMWBB/gb+g04KLRRTmvJagCkbNanHD6RivKcHFiRYHcicBCB5x0appdLtGFZQ/oHxXvUit2dMEnxkT1tFMGqjbhsPFKs62snsckeSfIkoTjqv2ZlausK9jxYlJHOtp6fZ4NnneI59DH1klB7CwEgC/WRJqFU2OXo8+dVQHxD+bxjjiZlbji0vHyr/XIwg1rB3tkNVS3J0iBWCzN9twIQnWUGt28kapQ6JCvJPBoUOhdNijjVAAXgJ5fD2IK9hknUWNJcTB89ai/oz91XT91z9p96t4uABa9jN5A7OlQS5ux73vq5p7A4biDw/B0xmAL/e7dYr5cROyOZW13Yuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ2RMDeBBUL290SYRRhu3qCiF5XEVuN/6QlCMSYkVA0=;
 b=PqYul5uCqZpElYoAK0broo0K2LniLV4pmAIgAPyPz+TAN6dQAjE5a/Fe7KBEXcln43QD1FF/3o4lKYV9ZJvhsaZCP+2t959o42qPCjBVCGcdSj0aH9mvuR4E2RPqGi4ez679sFAE4y/HNIyf4TRfOtP+7TmqKqd1hM6wE0utOJk=
Received: from DM5PR12CA0007.namprd12.prod.outlook.com (2603:10b6:4:1::17) by
 MN2PR02MB5888.namprd02.prod.outlook.com (2603:10b6:208:11b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Sat, 18 Jun
 2022 02:45:16 +0000
Received: from DM3NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::66) by DM5PR12CA0007.outlook.office365.com
 (2603:10b6:4:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Sat, 18 Jun 2022 02:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT041.mail.protection.outlook.com (10.13.5.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Sat, 18 Jun 2022 02:45:15 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Jun 2022 19:45:10 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Jun 2022 19:45:10 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.140.9.2] (port=44908 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1o2OSU-000FZO-Ab; Fri, 17 Jun 2022 19:45:10 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>, <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v5 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root Port
Date:   Sat, 18 Jun 2022 08:14:59 +0530
Message-ID: <20220618024459.7554-3-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220618024459.7554-1-bharat.kumar.gogada@xilinx.com>
References: <20220618024459.7554-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac280487-2110-448b-08d6-08da50d49340
X-MS-TrafficTypeDiagnostic: MN2PR02MB5888:EE_
X-Microsoft-Antispam-PRVS: <MN2PR02MB5888F8C6AF1E6C5BB72BE609A5AE9@MN2PR02MB5888.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D5vfUv0ZG9rbbwYAd8gvtbEareQDurULxwnXOngGNIj6mrZ7NCztRLwliti+67YBu2bC7uEQeEw7h/9E4Qk779SjMhOqud2APAuVgn6LoOsdhQMeIalJHbn9z3lZv5cVL/54+YqzqyMvOd0xO0C4LvzFcVInr8x9u+XjrqTDGgsxPfIbzG5mveAhqK7rTmDoLKWdA4jmTKJxuOjSYmMjawZ1KAY8WMlBXs8yWT9BQOEs88HCjxCIhKEeEHq9rSAAhHg9eiKXGsrgsVNTt+JRRQZS9BZZQ656u6kGbVCnq9rW8Qg/yhgb45tPIiAX+LWq2lM/3LiyEXWCyMGzj/b3/zn6AmbodwUlrspMQUOby+s5JKZMZgU7WFSPji8LVm4Ti1W8uAepBsI0QUoqRLoOcAWaT+xLNnDCWSLjPSydrttDp7z8Xa5gQFp+CaZKhnwe3ZH42jWq9cWHVhVP3Vj/vZwsZn2qnwMdNRxjiNAcLYc+RWgbfWm4oZMKsz38fhOp+otGFvoRzfIb+6XcmChVarCh6+hho1ujSTBaEFshdfxh6sKZHAwWqtymxHQIZOcobvVfMJKaiZjlRSK+t3paj3y3bzf2q1Xkpi02v/x0l0dcl9zL7wjJbRjUCcjusPhfmUPp8DToHxZjiqRBv0Tdj/G5yRezsp83eI2jDSbb0nCSN6rpvZsE/5+SPrXptGjI/UlcCqGhABPyaHtlTJ6xmw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(426003)(336012)(186003)(1076003)(47076005)(107886003)(103116003)(7636003)(40460700003)(356005)(2616005)(36860700001)(83380400001)(8936002)(54906003)(70586007)(70206006)(9786002)(8676002)(110136005)(316002)(36756003)(26005)(498600001)(6666004)(7696005)(82310400005)(5660300002)(4326008)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2022 02:45:15.9145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac280487-2110-448b-08d6-08da50d49340
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT041.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5888
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

