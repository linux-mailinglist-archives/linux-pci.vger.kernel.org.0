Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9732D4B6C95
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 13:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbiBOMqj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 07:46:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237795AbiBOMqh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 07:46:37 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000E7193DB;
        Tue, 15 Feb 2022 04:46:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qntwt8EgPgnp6pQ0ZnGJx7r1UoKMufG+9o0tka2zacpG/VQZqLpZB7hwhYqnQLOUtzC2llnR4ZAB95lB9m+Nsal01vSEymzYcNiKL2g7oYu/t1GZcXLI0ImG2Zl5WdVzORiKIFg8xdFFDYqwvdIYRgPTDlY/Vs0y093qyiHjD+a0aQDSTp+MGuEhP7w5SP01VIJ6aIYc+5YfArh+WfmKANmJcMl2fuea5m0jj6X852N715/QTGSrGbLALXGoxkLxk/6/R9TZRM8Z19Es5zAR51ezRu2hQidZ64NAT1azvXWIj85EVlUpf70/G0/72qA+FP2IWof4W4zNYpNGsqgITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RM1L5FsvJVL/Ko7Mz2H2uBXzhIvrPYNRNs4WXQEA0dQ=;
 b=WgoKoQBhFN8Ke5p4Q3VjQ4bSZZayZlHOIXhlicLflNbM/imqNkhunh6OVtCSxkv5WSR3Ht3IibOESlzVRkipklsM7ZnQBfc6ANloD2WPO2Y4+YX0JhYTHhCdpsbjRRmUTYzUktvHp0NW3Y6w+zc3u7N7tUdHVc5Gc/ZCdg+qNFur5I+lUEl1fL4gmfLu6DTiKJodS8XUJMMIJt04Klfy0aM+iEJpQ1Fg6A2FSrIs2qFCSENsQRc/0kqxjVKBjciqPNMtI7Q6tMOq9dGhAdTjJijvm25WKnzO/KNuTIeOPkFTPQzb9z166osCgP6+am5Hn+0vTbalhBIRstQuwsvh0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RM1L5FsvJVL/Ko7Mz2H2uBXzhIvrPYNRNs4WXQEA0dQ=;
 b=K/A89gW0jVemGopZ24YpeWlARM0aALMaDuHbyUs/UxWfoGU6j5SxhnNoixREMTdK1HOo79omQxKg9KP5b5v3yF2aS/8lNtIWobQ+Bkckf0gIFBuGgyMuZsOELNvfTkCVc7D7W4yrg+wP2aBaUqItHV065QfI+9/dsGeOPtwuJoQ=
Received: from SN7PR04CA0091.namprd04.prod.outlook.com (2603:10b6:806:122::6)
 by MN2PR02MB6464.namprd02.prod.outlook.com (2603:10b6:208:184::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 12:46:22 +0000
Received: from SN1NAM02FT0054.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:122:cafe::d1) by SN7PR04CA0091.outlook.office365.com
 (2603:10b6:806:122::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Tue, 15 Feb 2022 12:46:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0054.mail.protection.outlook.com (10.97.4.242) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 12:46:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 15 Feb 2022 04:46:19 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 15 Feb 2022 04:46:19 -0800
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com
Received: from [10.140.9.2] (port=50434 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nJxDm-000EtN-H6; Tue, 15 Feb 2022 04:46:18 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v2 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root Port
Date:   Tue, 15 Feb 2022 18:16:06 +0530
Message-ID: <20220215124606.28627-3-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215124606.28627-1-bharat.kumar.gogada@xilinx.com>
References: <20220215124606.28627-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8519f087-c861-4c85-c60a-08d9f0812bbf
X-MS-TrafficTypeDiagnostic: MN2PR02MB6464:EE_
X-Microsoft-Antispam-PRVS: <MN2PR02MB64647482153D649E0E2F8FDEA5349@MN2PR02MB6464.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tjaYKOwvEZ3VpwT/dTsQZv0P2YQxHO32tVnCQR9ISlU8/No6vOpBY/QS5PprCjlD12IIG/Xr3sOgRs37t/cKFbJqIaWfGf3pLHlzvKiab2auPKPKvDkDKnMreZlpcDIhodn13qfwp/YS7qcOsjqLXnwywG+IwPBbzJsDtEWtCDVvyk9G4fxHo48v5CH5c0qZ8Hrj0agqof2Bypy9PpBb6u1EdDpm2lEkTKlRgi/rEB0r7ZzBIcypSQFwigpnS8SPbcbJRRmWLtbKQoQRqBIYtvZqJCekdNZo5OZ4lhfFYW3pQnpSvncgKTmdpUKsF34qL4ud8OiZ6iBK7zJx3hEU/pEk7GjiZ8m57EQ7WX/oEcyQWeP58sti84eq/Rbn5yRT9X6HD/D9c8hb6Kuxt7LglzxTvaXgorsYEXukuQ4eowBb6bWDFNCEp6kfjQMXxuHCTIJy3yNoTDB0dxwE5pLj7Km3FeWpSG7+uDhi1iW33JerXHcrUWJhFC0mg87RMb9jmzod6KX9wTFJwOWhiPXJlUYnBRoCAdyEvQzpkH3CsVDhzGNbJ33Fn/vxejDeLFvPQ6/qgpnZj0894NbIIXUV2cQ8KIB+BEGL2ppCvl74URETHqakorwMzXNIyJBmnApxH/aX+dW/1ZEslQLawuF+rT7wbWxL3W4UmnlBlE4nQfp6yRiEDP7KzZqRdqv+3UYgiNGVuZXUm7e/r9tFMAgV/Q==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400004)(83380400001)(316002)(54906003)(110136005)(70586007)(70206006)(8676002)(4326008)(336012)(6666004)(508600001)(426003)(7696005)(2616005)(1076003)(7636003)(47076005)(103116003)(2906002)(356005)(40460700003)(36860700001)(36756003)(26005)(107886003)(186003)(8936002)(5660300002)(9786002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 12:46:22.4290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8519f087-c861-4c85-c60a-08d9f0812bbf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0054.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6464
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

