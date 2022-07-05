Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFA95668BF
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 12:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiGEK6A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 06:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbiGEK50 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 06:57:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83E0165A0;
        Tue,  5 Jul 2022 03:56:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgV4LXlhv3faSn8BCoVpiTbqW+8HmFFNPvGyli3AO9UVMFa3GqK49A8yojScrFIqNWHDjeMd7gOGj1Dd6lB3fJmMMzUDU9+qx0rKzYSbxi9cHWGxmpJpaBGKsNCakhfRoogDMcxmDeHl8s+rIwmBiNL5ET+SfwbpjIkZIJ9LmwToPaawtSuX9cFy+whFpikT0bTfDDa2FCFWqmASvhavMb0cX5uH9tEpeJjRH+y49TsxwjugMmllcBAYZb8VlJwwsYM/VPaVDGrEJ7seJRfyYul64O7cinJBrud4lI+jj1ykY25h6lMTVF307j68529MO8fLxY+UPh9D2e6UrwNZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krFtStkDH2F/1TnfWlTvc+ZXjTBuCHTljibgm/f++qY=;
 b=ZBORESuQ0PzCVyQwk/KDO02vm4++hTYJg8dcwyHEOTLtJ30CgA44JUY1XVabY3p5kxNkSg1tQknEodWjpBRpAOymuUVAH/yGm93OrPpuPSzUt5+ACfEkLktRTNtqrXsiRMvCJxpPrmqzym7oDj52SjI806RjAGHpc72nUR8furO70XL6UFv74H7KX5Jt138EClk/jGQ6Ctl2qXm2QdOajDGfHSxq092+GFAICaZX4+j8rNgrj0+LCT0mNlcBMEJxqBT1UEksbRe2mWL4I1ttTgUVvPUVK6XJcvp/jYqKAiMfX8znelkIlMwBpMzgAv2lg+vOEgNbX34cqdUC67uhlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krFtStkDH2F/1TnfWlTvc+ZXjTBuCHTljibgm/f++qY=;
 b=AzMlv3V4WwMxPo+4oCNw/o38a/CSiR63mE4X485U5nY7hCAD3viYd/XDpStyJ04ewHZkqZzhXtTocwVVi0MNyTnlRG+W7cYMDAK3ypsg36XC8l+ft0AuLdwGinDIdyTebbO4BO2V37pXY/3ulDZ6LqRsrEY/+NPjvn+2KMKWHcg=
Received: from SA0PR12CA0026.namprd12.prod.outlook.com (2603:10b6:806:6f::31)
 by DM5PR02MB2523.namprd02.prod.outlook.com (2603:10b6:3:3f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Tue, 5 Jul
 2022 10:56:57 +0000
Received: from SN1NAM02FT0028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:6f:cafe::59) by SA0PR12CA0026.outlook.office365.com
 (2603:10b6:806:6f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Tue, 5 Jul 2022 10:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0028.mail.protection.outlook.com (10.97.4.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Tue, 5 Jul 2022 10:56:57 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 5 Jul 2022 03:56:57 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 5 Jul 2022 03:56:57 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 bhelgaas@google.com
Received: from [10.140.9.2] (port=51530 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1o8gEi-000FEX-Jf; Tue, 05 Jul 2022 03:56:57 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v6 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root Port
Date:   Tue, 5 Jul 2022 16:26:46 +0530
Message-ID: <20220705105646.16980-3-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220705105646.16980-1-bharat.kumar.gogada@xilinx.com>
References: <20220705105646.16980-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66d8149c-4868-4e11-28ea-08da5e75149d
X-MS-TrafficTypeDiagnostic: DM5PR02MB2523:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jcq5GZnVx2Xiva6yBYstLraGtJdqkmk0HaV9yLkuyxui1/KIfybybyibJIk/Lw2KMpyk9hP+Ik/onhVFSt04mhZTZHvlysZPBALJgc3Wg1JTzDLJIjg5LUC7gUb0mFsT6Lj8T5BGPCLMm+YB++iRyjQ72ZpJL5/kD4ycHiFBO50GdCdG2nnjNVAumqfxyO7cXVe+NSSTmFN9H307sbgR4lzovNXN7g+VSalmzGBmM4nJAgZGKnr9nd2jKfpyV5eXfucVEW4nENgwr0bgD9hzZO1aH0BJYm9GySbjlGsjoTVupY4DsbYfrfSCfXBbAZGpVq6XhXqoqMYbcJagTQ64b8HzoMADhS8zk0ixuZKKiMSeQcvilMeBn7sNfiT8Gtl/PLbsyZbktluFVUOgH5k8q0Fn8eqE2/8yIUbEXGfJCqd8+sl+HxQAjAHWl9ohZDh9XlFFm4yqgIzyRePeM5CC7EAI15vs30G+eApGtLZ58tA6KiLH+qqTM68aSkOI9JO3lKMdy8RNNxSMAcqxJbu+PXREwoXb1wwj0CT92Gw1Yb16152MYKnhNU/tayCusL22l4DKjnK+Cjf/5nMGb+4peYq3dVZ/uuaA/1VO69KQtO/umevW+5V+CffXyy9CMz4y0zdOX+JQicubxzQU5SOPwtPLfK/VjVTLrAKCgQrGcgvgeeN+dmukv8Oo1WvJa419LP8twANmi3GKcR4BFV61mkTaQsHF0Lh2nxoaPKZ98Wg1Paokd3dIbHDi1/uZmlUqbJpZIFOBOTnzv6mG3nOEyUEponIGAyAeVayi3+EAxaCv8FD8gnAbskBO9fHRc3VaBdUdhipYMPuOmGPOo4bSmAqrh4wmLucKaAXqPw+OU5A=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(136003)(36840700001)(46966006)(40470700004)(70586007)(7636003)(70206006)(2616005)(82740400003)(2906002)(103116003)(4326008)(356005)(8676002)(186003)(336012)(7696005)(426003)(1076003)(26005)(83380400001)(36756003)(54906003)(316002)(107886003)(110136005)(40480700001)(47076005)(36860700001)(82310400005)(41300700001)(5660300002)(6666004)(40460700003)(9786002)(8936002)(478600001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 10:56:57.5593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d8149c-4868-4e11-28ea-08da5e75149d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2523
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
 drivers/pci/controller/pcie-xilinx-cpm.c | 64 ++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index c7cd44ed4dfc..65fbcf702a1b 100644
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
@@ -98,6 +102,20 @@
 /* Phy Status/Control Register definitions */
 #define XILINX_CPM_PCIE_REG_PSCR_LNKUP		BIT(11)
 
+enum xilinx_cpm_version {
+	CPM,
+	CPM5,
+};
+
+/**
+ * struct xilinx_cpm_variant - CPM variant information
+ * @version: CPM5 has few changes compared to CPM block.
+ *      CPM5 has dedicated register space for control and status registers.
+ */
+struct xilinx_cpm_variant {
+	enum xilinx_cpm_version version;
+};
+
 /**
  * struct xilinx_cpm_pcie - PCIe port information
  * @dev: Device pointer
@@ -109,6 +127,7 @@
  * @intx_irq: legacy interrupt number
  * @irq: Error interrupt number
  * @lock: lock protecting shared register access
+ * @variant: CPM version check pointer
  */
 struct xilinx_cpm_pcie {
 	struct device			*dev;
@@ -120,6 +139,7 @@ struct xilinx_cpm_pcie {
 	int				intx_irq;
 	int				irq;
 	raw_spinlock_t			lock;
+	const struct xilinx_cpm_variant   *variant;
 };
 
 static u32 pcie_read(struct xilinx_cpm_pcie *port, u32 reg)
@@ -285,6 +305,14 @@ static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
 		generic_handle_domain_irq(port->cpm_domain, i);
 	pcie_write(port, val, XILINX_CPM_PCIE_REG_IDR);
 
+	if (port->variant->version) {
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
@@ -484,6 +512,12 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 	 */
 	writel(XILINX_CPM_PCIE_MISC_IR_LOCAL,
 	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
+
+	if (port->variant->version) {
+		writel(XILINX_CPM_PCIE_IR_LOCAL,
+		       port->cpm_base + XILINX_CPM_PCIE_IR_ENABLE);
+	}
+
 	/* Enable the Bridge enable bit */
 	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
 		   XILINX_CPM_PCIE_REG_RPSC_BEN,
@@ -518,7 +552,14 @@ static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
 	if (IS_ERR(port->cfg))
 		return PTR_ERR(port->cfg);
 
-	port->reg_base = port->cfg->win;
+	if (port->variant->version) {
+		port->reg_base = devm_platform_ioremap_resource_byname(pdev,
+								       "cpm_csr");
+		if (IS_ERR(port->reg_base))
+			return PTR_ERR(port->reg_base);
+	} else {
+		port->reg_base = port->cfg->win;
+	}
 
 	return 0;
 }
@@ -559,6 +600,8 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 	if (!bus)
 		return -ENODEV;
 
+	port->variant = of_device_get_match_data(dev);
+
 	err = xilinx_cpm_pcie_parse_dt(port, bus->res);
 	if (err) {
 		dev_err(dev, "Parsing DT failed\n");
@@ -591,9 +634,24 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+static const struct xilinx_cpm_variant cpm_host = {
+	.version = CPM,
+};
+
+static const struct xilinx_cpm_variant cpm5_host = {
+	.version = CPM5,
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

