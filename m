Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC5D777815
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 14:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjHJMU0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 08:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjHJMU0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 08:20:26 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCFE2112;
        Thu, 10 Aug 2023 05:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjSVPqja5dx9xJdWBJ64mq3OSrYeYLEUPkgcDfzTcTd1lqWWL9LIK8aUo5+cfd669YD2sWZPuQ28a1VdGtzA0fKRnNxMh4IWR3j0fvqvfLlvb8z2ND0GaFI0HtPcWXbvu5H3PzfX+1vmYhz08qL8w+CMDjqCG+ItEfmqLcno05WbV5kWTRUTP/d1E2CaxIA1/asZhPOTF6bqDNX7m5TqycPmepjWdOgMACvZa1a66sp2UXk1iz6w4bG30BkjLCj+hecgxWWgY4U775BKbUIkNpQK5zDF53kiWuIjKt/5qY2+Kx3LN5SWOJc9LLMLYdDObYyuS51+y4aGZVHoN7aanQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhaIFtd40nJutx+8uNmpgV6+pnbP4bDCepGq+QR4OSs=;
 b=JQSVf0f4NpbegA02qbOiL/VjI+vuhURyJG1TbCUD4NxeU0JDqtQ5mrkDpxutxlcYQs0qgEmRVK1vfOB+AQbOnwDn2U1CjfvXqL7XOGhPKlDYvYTlpgo7lb7TR2t5AdC5X665rtexSOrOapdZSrxryLgmsLVvOxDoXpeCzwRCsNUjuyIWA7Dd/AayvRCZNn5uatFdX86lG4xI4ZrDEe4kRpg2bT3TcRAO12TcIcwd/8EbIPx4/7n6FbZPNnNzjl+iySZnhZ2cDWsUil6l+VZeTkxaVnXqicioqrOiXPnOGU0FPHNElQX+q9aGS8QA2lQF34E+9QkMVgLWfUKtjL+g2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhaIFtd40nJutx+8uNmpgV6+pnbP4bDCepGq+QR4OSs=;
 b=BGgBofw0mIcvrHQ8BueUxx18LJRfN7y1eFahq3FRRgE95pMD8sh7PFKTMXJrA/mzol8qDA7fexB+OpP/yeRQ5b6/0ngiMg44++M+pxEPujj8C2D9o6R26Yo/Oj2w1gKzepgIJvAJTJKL7H1A+2PTNt0XGSidFEPMfykYhgZpX10=
Received: from SJ0PR03CA0136.namprd03.prod.outlook.com (2603:10b6:a03:33c::21)
 by DS0PR12MB7947.namprd12.prod.outlook.com (2603:10b6:8:150::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 12:20:23 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:33c:cafe::a9) by SJ0PR03CA0136.outlook.office365.com
 (2603:10b6:a03:33c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Thu, 10 Aug 2023 12:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Thu, 10 Aug 2023 12:20:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 07:20:19 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 07:20:08 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 10 Aug 2023 07:20:05 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <conor+dt@kernel.org>
CC:     <lpieralisi@kernel.org>, <bharat.kumar.gogada@amd.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH v3] PCI: xilinx-nwl: Remove unnecessary code which updates primary, secondary and sub-ordinate bus numbers
Date:   Thu, 10 Aug 2023 17:49:59 +0530
Message-ID: <20230810122002.133531-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|DS0PR12MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5f88e0-e98d-4cef-4653-08db999c2bc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n90eGvbbkVsnsxaNJGVDe4+zj6qkzCzPZMhdb/PH48qM+xR9jAapzzm0ojQN01szn7lrb6l+RfXqJDk6nu/xSlu30E8qnmOLAd8BCgAatJ0TR8qE6XioSj8hqGJDF3sGWOw6aZ7TqcGGFq91uo6CWZNYJT8SY1TY8CWqCmfblW8ZTNBNtcFpnxyJD5zVyRYoli70UlsNh8hhZY7lnKtuT5Fde+ihPxgNDftvlOfqC2vvKuFxPVPZWDiL9BMMelo3tduVvpO37CxLzZfwpLYTE5x2FH9FZkEdwoQDT4NolYjvKfcp6Lj6D5eafSTlVKTRql8UPh06gMIAGgasdhdIYXnaoNRA/BtX8BnAJItuEHAIteECZKNSlJR7vvfN1fqMJwvT3ih1SxFPJfO2WAssr0wILB+KLGtFjzQFxSgfMCZJcxI2u4gjnqjcOyMHsPmktEdPKBduwM++tdnAePsPvuCcmq3I0E53WUsGxIAvlciC8M46XysxI8xSXpb5zbhgJLeR96mz+KscO85g9O6eD8r8WMRVrzBSq4MkI5Cs4XrdAJpE7IHXIPJpBemlh4yb8WQNw4gi6nLSLR7AfKuhaKKQCmOFQSKegKp+qsafBD3vAK9OsFXehg32NY2RHshwW58hsybmJBZsjB8AE3zGMClkjM024DvvYwNj8s6ajoH+++gLz3u/KPor1rcoi85qIErwLjeHIx+DyaM5SglnQ8gesTqNQ7DYbMChW8mrmoeDbNtf0vSn6sXr2gUHiYbIEoo/V0mmXreHWZggM7i0vA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(82310400008)(451199021)(1800799006)(186006)(40470700004)(46966006)(36840700001)(26005)(5660300002)(1076003)(8936002)(8676002)(41300700001)(40460700003)(82740400003)(36860700001)(36756003)(47076005)(2906002)(426003)(83380400001)(15650500001)(356005)(81166007)(2616005)(86362001)(44832011)(336012)(70206006)(4326008)(70586007)(6666004)(54906003)(110136005)(478600001)(40480700001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 12:20:22.9307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5f88e0-e98d-4cef-4653-08db999c2bc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7947
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The primary,secondary and sub-ordinate bus number registers are updated by
Linux PCI core, so remove code which updates respective fields of type 1
header.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
---
changes in v3:
- Remove unnecessary period at end of subject line.
- Updated commit message.
changes in v2:
- Code increasing ECAM Size value is added into a seperate patch.
- Modified commit messages.
changes in v1:
- Modified commit messages.
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 176686bdb15c..d8a3a08be1d5 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -166,7 +166,6 @@ struct nwl_pcie {
 	int irq_intx;
 	int irq_misc;
 	u32 ecam_value;
-	u8 last_busno;
 	struct nwl_msi msi;
 	struct irq_domain *legacy_irq_domain;
 	struct clk *clk;
@@ -625,7 +624,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	u32 breg_val, ecam_val, first_busno = 0;
+	u32 breg_val, ecam_val;
 	int err;
 
 	breg_val = nwl_bridge_readl(pcie, E_BREG_CAPABILITIES) & BREG_PRESENT;
@@ -683,15 +682,6 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	nwl_bridge_writel(pcie, upper_32_bits(pcie->phys_ecam_base),
 			  E_ECAM_BASE_HI);
 
-	/* Get bus range */
-	ecam_val = nwl_bridge_readl(pcie, E_ECAM_CONTROL);
-	pcie->last_busno = (ecam_val & E_ECAM_SIZE_LOC) >> E_ECAM_SIZE_SHIFT;
-	/* Write primary, secondary and subordinate bus numbers */
-	ecam_val = first_busno;
-	ecam_val |= (first_busno + 1) << 8;
-	ecam_val |= (pcie->last_busno << E_ECAM_SIZE_SHIFT);
-	writel(ecam_val, (pcie->ecam_base + PCI_PRIMARY_BUS));
-
 	if (nwl_pcie_link_up(pcie))
 		dev_info(dev, "Link is UP\n");
 	else
-- 
2.17.1

