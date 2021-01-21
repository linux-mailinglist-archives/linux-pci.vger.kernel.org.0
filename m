Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E68D2FE6F4
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 11:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbhAUKAp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 05:00:45 -0500
Received: from mail-eopbgr760059.outbound.protection.outlook.com ([40.107.76.59]:15968
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728336AbhAUKAP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jan 2021 05:00:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LM/u6uIGejPHjEjwPzQDmOxru+ocbBsNDZBmCF1DAq28rV1W/ysTsWG/8sylY0LvsNyBvLFwvn7q49REWvS6WtxjCynCx6qWrKYh/QS9IL/UxXSBSMog/6lpbHk/jMn521EH06wnyUaaO5ZOrwuarZ4gWkin4k97qbW+9IiBha2eY0Lvjhoc4j/dfuKilBDEuUdk/TwuSJLm9XbFyRKIEOffoLcFfHiADscGpZeUIVSVwfwVn/oriwKkPtuCZnTI9l1cPooWoKF6pgNZ++vDvKllz5QBVJBYKmj6jQ+jPj/OSgMioP0OMYVx614sP+ZFYRHgQ4XyvZAYauAvyJ93bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OchD7+pkMKuxP1fklda8kDbYhh2bXCkrzfYWcP3Lno=;
 b=hldNsCZ719wpDBv3As/VbLw9Nl6Q3jHPWEh+oi+P5uCiM33eamlMkz3CFmIjAyXCk4Z71PRqA1aigoOMOFpUw1pORI4jbxHCWFLbN8DCosxKqbudST3iGmHFLtUiISyAxlm8ld3kTSEKNXN3KvnXQ+ZVHj7AFhP9mY5DnXmC+1b7pSg3/CXcjMRMpKhyRj+ebdJdKddGQbqydEoDInLR3JG92gTNJEYStrdTcl9ozniFF1cy7EkJGpVGGtflEPVNlhRi/Q93TPVqoCaU3JczJG9bmQdCF6GYVrkb8yYIOoqSHm8pXDqs26mzbn97KPYCVwAQWI5tM+ER+8PXG87HRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OchD7+pkMKuxP1fklda8kDbYhh2bXCkrzfYWcP3Lno=;
 b=OHzA7EJQZ/iH2vhLlWFmcaVHDd3CAe+JMubT2dvKua7IosvWpPGd5wUdgA8QgYhfK54Rb6oFpqRm8WbPso6kmDcDsYAXF0LHy/UO69pADq+sXT90K64RzNCiVencwsJsql41GnCV6yA0ok3mmVMdo8gxxLhaYVuN+uq/fJCgU4o=
Received: from MN2PR20CA0014.namprd20.prod.outlook.com (2603:10b6:208:e8::27)
 by BL0PR02MB4546.namprd02.prod.outlook.com (2603:10b6:208:26::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Thu, 21 Jan
 2021 09:59:27 +0000
Received: from BL2NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:e8:cafe::75) by MN2PR20CA0014.outlook.office365.com
 (2603:10b6:208:e8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Thu, 21 Jan 2021 09:59:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT059.mail.protection.outlook.com (10.152.76.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 09:59:26 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 21 Jan 2021 01:59:22 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 21 Jan 2021 01:59:22 -0800
Envelope-to: bharat.kumar.gogada@xilinx.com,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 bhelgaas@google.com
Received: from [10.140.9.2] (port=42522 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1l2WkM-0000of-3Z; Thu, 21 Jan 2021 01:59:22 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH] PCI: xilinx-nwl: Enable coherenct PCIe traffic using CCI
Date:   Thu, 21 Jan 2021 15:29:16 +0530
Message-ID: <1611223156-8787-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08473162-bdb7-4459-f9e0-08d8bdf33ce7
X-MS-TrafficTypeDiagnostic: BL0PR02MB4546:
X-Microsoft-Antispam-PRVS: <BL0PR02MB454670503844F420BA908FDDA5A10@BL0PR02MB4546.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4JGz07VU21SWfjXrEVQX+K7bbttj4Vm/QFaxbloA3X4et55Ev60y/sSTZkq4IvhoDxipaWeigStiGKcYBkKTGUqEDUaK4nQdg5U4UmNQlVBjfZlJz1aSb3VFTphfnRw4gDbeMSnwgPGxwjw0tNxxFHKgy6ubLm7BZeSCxlZUqUYxzJST/StIBM6hVYl+KgLE1O8Tit31J9pUyuG2ULAv66LamYI9VlUNFTcbQoMYCnp+FYm+adomRROPTWtWEtrf2E0LnjfCukH2Jrt3Fz9uy2MxEgzA2H3VtMj7DUB+c1aoPIcv2N7z0rrEO1copgrIlJ+VRkiSLh3Eq6dL/w7zlWEPbUYfeZ1ppfFyQ8HD84OsY+egqwLazJ7pKNKIFaUJFIvuHQDH//lbj9DXVKbVc1TZPnVkiqZt9SurDFo432/B2uDYp4NW8vBAC5nd4iVmb4sS6tDze7Ys51IYqhLFT+F+ZPmmzQ9WIQ5DLkwJyrueHUk7JGYKtFs092iS6rtvR1Hy2lktrG/0u8oibh6ojH3KyDQH3L3gLr+ACi54raY5qL9e92EPWF7STpVQLoxvgg7/qNtyaDsGmyzleJicMFbUe9nNIm5whJkJNugMptpKDFCXpLm2cVZwp++5tMS9
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966006)(110136005)(4326008)(5660300002)(26005)(2906002)(47076005)(7636003)(186003)(426003)(478600001)(356005)(6666004)(8676002)(36756003)(107886003)(54906003)(7696005)(8936002)(316002)(82310400003)(82740400003)(70586007)(70206006)(336012)(9786002)(2616005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 09:59:26.8056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08473162-bdb7-4459-f9e0-08d8bdf33ce7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT059.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4546
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

- Add support for routing PCIe traffic coherently when
 Cache Coherent Interconnect(CCI) is enabled in the system.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 07e3666..08e06057 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -26,6 +26,7 @@
 
 /* Bridge core config registers */
 #define BRCFG_PCIE_RX0			0x00000000
+#define BRCFG_PCIE_RX1			0x00000004
 #define BRCFG_INTERRUPT			0x00000010
 #define BRCFG_PCIE_RX_MSG_FILTER	0x00000020
 
@@ -128,6 +129,7 @@
 #define NWL_ECAM_VALUE_DEFAULT		12
 
 #define CFG_DMA_REG_BAR			GENMASK(2, 0)
+#define CFG_PCIE_CACHE			GENMASK(7, 0)
 
 #define INT_PCI_MSI_NR			(2 * 32)
 
@@ -675,6 +677,12 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	nwl_bridge_writel(pcie, CFG_ENABLE_MSG_FILTER_MASK,
 			  BRCFG_PCIE_RX_MSG_FILTER);
 
+	/* This routes the PCIe DMA traffic to go through CCI path */
+	if (of_dma_is_coherent(dev->of_node)) {
+		nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, BRCFG_PCIE_RX1) |
+				  CFG_PCIE_CACHE, BRCFG_PCIE_RX1);
+	}
+
 	err = nwl_wait_for_link(pcie);
 	if (err)
 		return err;
-- 
2.7.4

