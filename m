Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0E24AB471
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 07:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbiBGGPR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 01:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351333AbiBGENP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Feb 2022 23:13:15 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB26C061A73;
        Sun,  6 Feb 2022 20:13:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9K4I7+XWHv/dwDe+n4pL7huhhL/rUt05Q7lD+dSAui9nhoEhQ7gvDseGD33b1jhtZWD/Oi0IaQxiMF7oFCqF0AMWTKoMBip5L8ByqBQtWRJLM35ZOxQtJdOLdvcDNVcf1uwpCld7/EKXRRwTxuhVPyo2zc0V+YJORkm+rBcPhKQPHhYb7GicDgR1yCOED+IkmGJdOjUqWRmdqqBcizxwY/ofvVQBJ7d7p+rkGp2jPut6BaeG9H1RJqToahnEeljtS4OAsQktWaxI+vIUmRldODERBWZTjvlBoas9LZ1xJ8aEkNpFKADCYlKvyKLKRDOxxauEbRSSTAlNxFCcP7Q0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQztx4CQJr/b+brzajSB/3W1dw9k+ExjvVcb8QD7fhE=;
 b=Cgej5+AOUPcbhEn9OCLKw4SDsWIoEQ5hgGfp87KOeXXED9jIj85bSc+gUvHDCKcENmkKi6x863b1j82Hgov4KYYqRyoS1tH7TFG67AY83+WudX9J7KJxPVs0K7yugHdtTl/yg5xC0wirIcTFpfZE5ssIgouyMGvc+aSwN1C36n/RVSFXP1zkagdy9oAJpgiFN2NoCxs02px5kvZZ47DWHvmiWjtfDjsS/RzQ/L6JnAbcjoGQYQF1uXfBc7yBTZdWiG0I6plKaKAXgRRgHdE6g2zV9bc89P8jTqCJpTOCcBI+U7RW/8QZqApTfimo1QJq1+MvVcE/GWxP4gNCX/UHjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQztx4CQJr/b+brzajSB/3W1dw9k+ExjvVcb8QD7fhE=;
 b=Gb+9DPVQUpZunJ140mdZ+NpBt8yf5MCqiRxwlXWoPKSCLEeT0k2ucFrM8qVhSx3xXopRDVsw/0WaDKliKRVnZqDyG6uhffhulXEJNITYpklYZMCL6wrhR0nieG6/+K1prB8PyS1ewP17ftBpd4i+LGk8F1Ps0zLdczUGK5TRU7o=
Received: from BN6PR16CA0003.namprd16.prod.outlook.com (2603:10b6:404:f5::13)
 by PH0PR02MB8408.namprd02.prod.outlook.com (2603:10b6:510:10b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Mon, 7 Feb
 2022 04:13:12 +0000
Received: from BN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::e0) by BN6PR16CA0003.outlook.office365.com
 (2603:10b6:404:f5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18 via Frontend
 Transport; Mon, 7 Feb 2022 04:13:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT057.mail.protection.outlook.com (10.13.2.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 04:13:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 6 Feb 2022 20:13:09 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 6 Feb 2022 20:13:09 -0800
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com
Received: from [10.140.9.2] (port=45184 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nGvOm-0005Nx-Qx; Sun, 06 Feb 2022 20:13:09 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root Port driver
Date:   Mon, 7 Feb 2022 09:42:50 +0530
Message-ID: <20220207041250.1658-4-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220207041250.1658-1-bharat.kumar.gogada@xilinx.com>
References: <20220207041250.1658-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fdf97b5-19d1-4cdb-80b6-08d9e9f027e6
X-MS-TrafficTypeDiagnostic: PH0PR02MB8408:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB840877A5766A7AEC8299D640A52C9@PH0PR02MB8408.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /iCn2rZiHZHsq2NDJ0d8w2Z0UvEWaMM9I0KHqSt0AbR1z4MvwF/L8k0xowz8n3x18IaIfbfZbXvne+MRSFEpQ2yj+7jAeiSlkNlUt6ifjg5ZXnLPt6RBL2g671EEyL8DLHRBtWguV++2IIB2shyJSzKhW7lP3L+FYlUgiAi0gIjQ5m++25eqyy/9IhLOUXxIot+RoXOPuYP/UmtN0u7Oo7vk5ctpRNfI+qctCtceYI4qL7hQ4qhv/mXLwW7bq4J6IinoXUPzdzmmY4mpwaFiYF0CeqIa7266h4P5AA/ZlJgyy1uCzQ5qy9gL/wqc+duGoqd2thtmKfg9g45ylRTkXi79a/NWVNH03smqd6Dm925GW5RzIN6RDslKdRwTKugPZRh4PKztjqtcKsqgd4t+gmrDK7xsIb/3g+XdXWIA1X3vGmzQ4omhM0qDQX6U6ISy+dfcChEIOe24PtNTRkWlx5wIHQWMlQdIqJEV+SKv79seyuwccj4O0rkbwPiMr9gFzsntNvTDlL3z0Te1A6+CD+yQ7nntVcJ475Ih0MPVXRX9IXoVyeAn7MHepRVxdvm5MM2rUI5G6oNP3TaB42P4tBJI+JxQYlsp60rnCvfoRJzO3uNL48m3TvmEeVY7oft8a3Y+wnjd4qvmqRufxQ+F0cE4gxqPqZWTTEthVDMngQq19KpQdZCtHnqeK3gZawO5
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(8936002)(7636003)(6666004)(4326008)(2616005)(9786002)(70586007)(8676002)(83380400001)(70206006)(356005)(1076003)(186003)(5660300002)(2906002)(103116003)(107886003)(26005)(82310400004)(7696005)(336012)(426003)(54906003)(110136005)(36756003)(36860700001)(508600001)(47076005)(316002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 04:13:11.9070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdf97b5-19d1-4cdb-80b6-08d9e9f027e6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8408
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

