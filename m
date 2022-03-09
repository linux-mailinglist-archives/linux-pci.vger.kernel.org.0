Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7E24D2E99
	for <lists+linux-pci@lfdr.de>; Wed,  9 Mar 2022 13:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiCIMBs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Mar 2022 07:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbiCIMBq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2022 07:01:46 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1315114AC94;
        Wed,  9 Mar 2022 04:00:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+joD1jGC+5jB5mWRkvN3YQTqeZGgtiXs2oLoAAAq+MCcOr16Z7IIcjSIbXfAeLZvpxGzyYlbD17qha8XkFc/QLOW7S3PP1E3Y7TRXyDpss18u9B+bRfTifaVDl3XW6Xf3WlTN11unaEbW0bakNDNU24N4HZF+4UOQS0IqfDE+xi0U+caR+ioSs3LxiOBhiecrDoukKuJk8C/JH440kVEYYUSBKHBS0MT72sA6d7nzEtiQzwemDFcyqI484MvPaebcsobY/LfGnLG/lkRhoaK9jz4yufmANiYMEsIkuicdmsQt1PCWLfj9TimMq6n5hReQLT+NhmvgUW5C34WOdMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w18ZRgzpk+ngd9Ve//AFklwHyI3AxSTXKhY8cSe/QLI=;
 b=jQADW+X8cfr3pFU7OnFrcFB/2+rwww8Q14eCJSu0aNeLwUFO9PXLxGirrJV9832tVJCaBrllMkdq8RwMiZUKyQQimJXQ/TmH3P9OasSdwsxOIsYaEotHNeCCk4JLHKiA8ixT8akaoNAQM9ivD71yRUtzl5q3P7FbDKkmnd2ZgypOlioM4CaEpXk01XuY5YN2f1+v5orIAqndqYDjHGMP1aX/bl2MS8dFg73/B2e+Gw9EvprUa1ypkEFvRm+499B7upBmdrLVHfZ5ITWUQWjWqcfza/LSksYHBoEt6WdLc9Ur/sMQ5xd4BSQqvWBoTKNXb2UJsBnsKufREVelmtgYzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w18ZRgzpk+ngd9Ve//AFklwHyI3AxSTXKhY8cSe/QLI=;
 b=TONlz4cOrgxn1pOQEVylF0WJrNDHQanPb8EDyxFz4nQAzzwKEaOwTSMz+gpDbxeuDHQiuullwZ7sXQn5CCzIlECfiMQhpox5r7v5hSjqVa890pYrcmZ9a9bM/XzRJobIyK/LAS1SfFmPl6jzJ/twYRskyo+jWTSeDS7G7J2pcnU=
Received: from SA9PR13CA0116.namprd13.prod.outlook.com (2603:10b6:806:24::31)
 by DM5PR02MB2667.namprd02.prod.outlook.com (2603:10b6:3:10d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Wed, 9 Mar
 2022 12:00:45 +0000
Received: from SN1NAM02FT0051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:24:cafe::d) by SA9PR13CA0116.outlook.office365.com
 (2603:10b6:806:24::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.17 via Frontend
 Transport; Wed, 9 Mar 2022 12:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0051.mail.protection.outlook.com (10.97.5.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 12:00:45 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 9 Mar 2022 04:00:36 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 9 Mar 2022 04:00:36 -0800
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.140.9.2] (port=47618 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nRuzc-0008Ca-Ba; Wed, 09 Mar 2022 04:00:36 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>, <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v3 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root Port
Date:   Wed, 9 Mar 2022 17:30:25 +0530
Message-ID: <20220309120025.6721-3-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220309120025.6721-1-bharat.kumar.gogada@xilinx.com>
References: <20220309120025.6721-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5907a838-a8b3-44a1-4d34-08da01c47148
X-MS-TrafficTypeDiagnostic: DM5PR02MB2667:EE_
X-Microsoft-Antispam-PRVS: <DM5PR02MB2667800BC2D0C7D97F6C76C4A50A9@DM5PR02MB2667.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kYdCnrAPgkm4cC1TVEPvN13GPSKYpEi6kDLqUi9tEgTYJXypMjpcERMAoBGsccNUr0RflJXdMqLoo0mi48ZQLmSSJEkhKuwXtj97xrh4vutxlX288ZPA8nEC21VuoEA4+YrKd8nO5F1NlB/anSOCgwX41jR5iDm0lob/7lefjpGhEiWzgFtAxdOsEDf1LOKlmvWh0/7+fQBwInJ77Z7oFVrsoQo3TWP6TB5yDRff2XyrmxDV70dGyfazrI28SNVHgtT030Jy3Qfk6LDEwwMvcdGK4E9kGkRwPJ8M4fN0iCpX7Cu6Fa9H9E1b1VogeCZ3zJ/5QK6jCNjLqxDbRl+IDZJ+McKgQL19Csedfitt2D9X7Y1/rs18t/2s+JXERILAGIYAJX/NSZCzsxg/flPWcoAd1GC5lhgu9NP5HWNplFOv1MF1hVJhej0NqWF92VJdAUzlUWmSo5riyGkYhZysgyY/5bA8QvRIXrt27J5jipKwYRTEcs/IkA1RdCZqce06OHvy9PXYZxdjbAqcVVbL0dGvTWHFHknQP8UP9OgEw/oq/tEpPrL93juDazxknMuLsluyaoIziU+CBVyDNnPd4gLINf3t1yrupKEwM6BD/SoyJY23O5p2DiS9YGuPTQYdsQ9PPQxqcRi26gk95hnvmiGaVgANtqhRNoXgI8wKZkyTeXYqKTG8vN5VHYwIQhPFZ067CO72Tgn8zXFWX+x8AQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(103116003)(70206006)(8676002)(5660300002)(4326008)(2906002)(7636003)(356005)(9786002)(82310400004)(36756003)(8936002)(54906003)(36860700001)(110136005)(316002)(70586007)(40460700003)(508600001)(107886003)(47076005)(6666004)(7696005)(336012)(2616005)(426003)(1076003)(26005)(83380400001)(186003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 12:00:45.1346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5907a838-a8b3-44a1-4d34-08da01c47148
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0051.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2667
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
index c7cd44ed4dfc..c8bf22718614 100644
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
 
+	port->is_cpm5 = of_device_is_compatible(dev->of_node,
+						"xlnx,versal-cpm5-host-1.00");
+
 	port->cpm_base = devm_platform_ioremap_resource_byname(pdev,
 							       "cpm_slcr");
 	if (IS_ERR(port->cpm_base))
@@ -518,7 +541,14 @@ static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
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
@@ -593,6 +623,7 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 
 static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
 	{ .compatible = "xlnx,versal-cpm-host-1.00", },
+	{ .compatible = "xlnx,versal-cpm5-host-1.00", },
 	{}
 };
 
-- 
2.17.1

