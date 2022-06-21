Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5345530F8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 13:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349674AbiFULhS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 07:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349641AbiFULhP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 07:37:15 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A25A2A247;
        Tue, 21 Jun 2022 04:37:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKl1fvLepH0XEaSAIkkEvwmQTNvlZsNPGyv/Up3bJx7Ne+h87lwgZTRPKf3RYENMC86BFNiDNf9ZK35DKEdVn7I7fktX5ARNFlvKsCuXIqKRJnLghmce4vxmFRNyaVhZGOpKvstR62rdQWK/nQA9+gost6mL7fUYA8ITD2bS/csQb6Is0nPH/2zFgDvH3mf4CMpLhkWDfphpvDGLEvzFvvOwUJfF272XYZ1hitwOnblMqm18QHCRkj0mXPmEuFN6SxGr906+ipijMkqbOhbs7JjV+VS+jSD/OJ1MyScyPtLMh22spfGbjlIy2kzjiek6BYeQ+aeXrS8qvrrU/uyvJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0gOu+EFdT1Ic9Bu9riCGgWlqaGTGZeGFNgn2cWyO7A=;
 b=WuQ88qrTe8o3ojFtJXG5d1imLgiLHwyC39N+pQMI8fS03R1RnYHACAQsQUMfqvM3gspGLIJOBfz+ymy0UkDNDlZ6XTsNID9Dvn/Et52gT85njiGXY58fmFr1cZIksQCy7eqOxTH0NTYYax/UF3m20FMg5PQN+D0Pbv1l8bWO8yVc5dCo0bQymdv3Yd0MpJPisxAtdETYZ+mAIhbKGLI8kIopdQANfzycIaK1hpoS5u2uY63vjq4px3YSs4JrVENr5uT9emwrBa8Q0NRvpHRX3rtVnPQqUzAivnO6JJJvdNRuYI+AM6PB3AHGyrPSLt8+1XXQ9SrzIFITSNkzHK8bJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0gOu+EFdT1Ic9Bu9riCGgWlqaGTGZeGFNgn2cWyO7A=;
 b=lB2CDAhqzCy9Kj3TkGzQqZqulRUkMlTp2FgAkU2ZKqanzeWtM7s7OXw0XfEorlCfK7+SNAt4Lt31wxZ0aaw8kCtNj4NhH3UBwnPbwCMu6uI3jmc43ToWZIiIcyzvnuE/2CSzy7jA+Jg04rGqKeyXOhV34szvVhvkYic4V8LAnns=
Received: from SA9PR13CA0030.namprd13.prod.outlook.com (2603:10b6:806:21::35)
 by BL0PR02MB3666.namprd02.prod.outlook.com (2603:10b6:207:45::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 11:37:07 +0000
Received: from SN1NAM02FT0015.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:21:cafe::c2) by SA9PR13CA0030.outlook.office365.com
 (2603:10b6:806:21::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.13 via Frontend
 Transport; Tue, 21 Jun 2022 11:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0015.mail.protection.outlook.com (10.97.5.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Tue, 21 Jun 2022 11:37:07 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 21 Jun 2022 04:37:05 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 21 Jun 2022 04:37:05 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.140.9.24] (port=39508 helo=xhdarjunv40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1o3cBt-000Bco-12; Tue, 21 Jun 2022 04:37:05 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>, <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v5 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root Port
Date:   Tue, 21 Jun 2022 17:06:53 +0530
Message-ID: <20220621113653.2354462-3-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621113653.2354462-1-bharat.kumar.gogada@xilinx.com>
References: <20220621113653.2354462-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94299793-79ed-4096-e173-08da537a5f57
X-MS-TrafficTypeDiagnostic: BL0PR02MB3666:EE_
X-Microsoft-Antispam-PRVS: <BL0PR02MB366632F6DEE424EFBF005262A5B39@BL0PR02MB3666.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tTiVkREl5u5LGCc03V1w0JTOklj7Z4e3ZhsYVHnqSs1tfUKQ+XJyo1JxgrV+9b4S4e0LUBphTDhcLENGGwV2aqAZCgMvtFIHgdECN5sMJTEGhHhCh3EjhiZgb3YNI7KWgOjq0/rZ2QJpNWK1aFrKGPxVZBBEQBu2benWVNEm2t1RG9ZZa5SjZ4N/6XZrct/oYCx+fEP2q0cAim5GCuKq3rQW+9rJ3KXWUulXVOEEYBpKskMy44NisRRAefpf6q79axuHBojZYD3G6IFtdBdx9uJE++aDwoQnEPxxNwMw7E/RVEnEHgTB91JQmiWTk4Z4pA316il7cyfPbzi3OlZI6hBvxbyK7+XApXQRuXhsIETPeZaSKl1Dvh/KlZYBGaMz7BTSuoxMYCdvvyZyVu+yl9EYDXiS46Pi2m0Xih4K0NZXJKNVhgis6vG9KEjRRgYFbiijXJ+hGpAspL3Pvbe3JcvD6oBenK1qHvbQx9US/nytu8oo61xctis3lTQcxsbAzJgNtoVqSIKHIZrSrxQKwTuVVdLdctkVYu4HDyoyPpu10CX0D0uabBp6W60nY/qkwOIrITn02pkbbttUd6M0AItyr6FBLBjjhVa3H2wa0F772Gg57Hoclfrn9Pu4PwYg/aEtXW+akBJAasFdnmwaZX/fdLVMMGXiTJNYmclWMjleZ6ggyOY3doSF9EbUe4fbkB53XzenoahHB4FL4AVnhsfU/Z3Gati+u4gXXHywn64=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(40470700004)(46966006)(36840700001)(8936002)(186003)(316002)(9786002)(478600001)(7636003)(47076005)(5660300002)(83380400001)(336012)(36860700001)(6666004)(40480700001)(426003)(82310400005)(40460700003)(36756003)(103116003)(2616005)(1076003)(107886003)(41300700001)(54906003)(2906002)(110136005)(356005)(82740400003)(70586007)(70206006)(8676002)(4326008)(26005)(7696005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 11:37:07.6119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94299793-79ed-4096-e173-08da537a5f57
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0015.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3666
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
2.25.1

