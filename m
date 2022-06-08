Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3574C543945
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 18:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245648AbiFHQl3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 12:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245624AbiFHQlY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 12:41:24 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45293A183;
        Wed,  8 Jun 2022 09:41:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYdBNTECZet8xV3478sCkPGJGBVpEAV/btl80q7DDyjGvV/wNJKAGBufFGU/T+bqU4zpu6RwXPJH1VQxfa+2wr8vwEZOkPqeO9v9+B43LzX/z+GyzHWmzMjqWZ+cpgnwzbThAsQTBMenn/8SJesUEStFhKKg6Y73E2ZL9EW9G+ryx8ZduN33URGMAPqbj1hNTYAQflf4ENB5qQinmKhczDsb3m8jd+vbTR/jJG0dX0YJF4yTpGDykbs/URbCC8Qoixll6rorOmguQO3KKUiFAaRp57o8UUvk+pnibDHgiIAEde4LRRRjOOhAS+zHYoF37HlRnDS2/1FRIDwhG84mSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JzkrQVtvdUrigBCGYj16qerczDCpXz4LKCs9+G293o=;
 b=ANYax8GiHUJJIUW7okISSqHDmBo1lMdcZ9SgD/hNjPP31Jm2qCmU3A83CeyZxY9wz3Mk22dXR4b7SBbKqmkSgHq4lb6P3FQsP6VvQkaFeA1NRFIopgmf66qakdIsQEZvhAztfVIDECo4r4Xm6GeQIpHcyjNtp8EogBRDLD05HSrUlYLS6fvz8QQTJyOycDUsshqbik3BVHnegdCzET4ZCHoGm5QYfV0uJet0zyDNzyIMssAheq+MXri9/jNDC8uz3XTmgzrBWXXktfNQ2587ZkOcQ1FjfcBa4secGzUUtB7cGA838E3GK9IKrsbG3pvxVbAvkIzC0iuMmC2TaA9MpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JzkrQVtvdUrigBCGYj16qerczDCpXz4LKCs9+G293o=;
 b=X407vd3tAaobViYElETZt5WbjnyId6e135pA8nQGi2EIFA71Va+qxTV6A3iL1mgt9ZT7cA+aaRsc8C8dWGK9ORwCqhFL/OLPKiZyEydZVb6xMyHdxqbUsEicc1MqrCgzk9B+HNtv2/jUKyEGMWx1LN5mF09HkVua9VOutQKT8sM=
Received: from SA9P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::12)
 by CY4PR02MB2550.namprd02.prod.outlook.com (2603:10b6:903:6e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 16:41:22 +0000
Received: from SN1NAM02FT0032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:26:cafe::4a) by SA9P223CA0007.outlook.office365.com
 (2603:10b6:806:26::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Wed, 8 Jun 2022 16:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0032.mail.protection.outlook.com (10.97.5.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Wed, 8 Jun 2022 16:41:21 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 8 Jun 2022 09:41:20 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 8 Jun 2022 09:41:20 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.140.9.2] (port=41368 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nyykB-00016D-MY; Wed, 08 Jun 2022 09:41:20 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>, <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v4 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root Port
Date:   Wed, 8 Jun 2022 22:10:46 +0530
Message-ID: <20220608164046.3474-3-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220608164046.3474-1-bharat.kumar.gogada@xilinx.com>
References: <20220608164046.3474-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffd3414a-2c8d-4199-aa73-08da496db844
X-MS-TrafficTypeDiagnostic: CY4PR02MB2550:EE_
X-Microsoft-Antispam-PRVS: <CY4PR02MB2550C172EC6AD8702D760756A5A49@CY4PR02MB2550.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GrZlDTMsNt6MiBNACGQI0VypDzgmGbDNZTVbj3eEHZHJRpfswV2A0zncLlrESsdnll9l7ubcmY2Z6dTmrUhLYHsOYI1YhEc6Hbdb8SNc+SGKYPhjUlxHcRTDd4iEXnqQV4PKL24jcrE4JtD4wPR3vszixgK3mebVYMOTYgtLgocDLh6Iv8R6xjwoQMDsvYN92qj5Bb8ONcVDMU6j19EtcyE1mRtCwrTuoPLZbJTvAwLrwumXrOdMaRyYvWqGwp70LQjKRhV97lRYJDC4IatIHmgjLNu34hJ/5LDjaYZoXSZhF+plMJRIqJT+4FMxj4ksI061LjSGdpQPt4OQeNkibycv7gA3JnlZtetDXrxr+D8mZpZs6++2O5UAIMFY6tWYniEZLtpfr7Zj/Yl8lddYqO2QjKjdPf0DGeToOw+64es1itC13RQF3L3FIbqJGy99JV5Q3dDyaudKSTFo9+9g3iD42liNcClgsfry4KwCvLUOdllX0AN69nRX7r7MgZcKSi/D+w7NzwHKn80kbwDZJhVMPtOk5MZRmb4XioiWnckYpK0Oc4bBe/3XFzKtgOwGEQzHvCxgzWOu6zQKSXfwm34YuIAcx0MxE458iFROGC9TW1yrmxRWaAvNm/E77PNlyDIrb0ovX23DwiWChlcyknMKx/n/D5NsUt2qD84AeKQSJPIDM8bIUuAYVwiVZhNsF6q5KSwpp2O5b0Zr46rfzw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4326008)(1076003)(107886003)(186003)(7636003)(40460700003)(82310400005)(36756003)(356005)(26005)(2906002)(110136005)(316002)(103116003)(54906003)(70206006)(6666004)(36860700001)(2616005)(8676002)(5660300002)(70586007)(7696005)(9786002)(508600001)(83380400001)(8936002)(336012)(426003)(47076005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 16:41:21.7023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd3414a-2c8d-4199-aa73-08da496db844
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2550
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
index c7cd44ed4dfc..a3b04083b6b3 100644
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
+						"xlnx,versal-cpm5-host");
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
+	{ .compatible = "xlnx,versal-cpm5-host", },
 	{}
 };
 
-- 
2.17.1

