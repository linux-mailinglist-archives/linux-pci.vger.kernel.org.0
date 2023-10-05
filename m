Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAA77BA716
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 18:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjJEQuM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 12:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjJEQtE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 12:49:04 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3D21717;
        Thu,  5 Oct 2023 09:41:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/NAQjqbjT4btflA0tr2Q2bzZwPUjAI4Xsz6GIDYvARWW31iK37L2OOWUKJHliont+DPDlDgHEEx/DpSUdmCTFiUCrhOfstnbfed6GqhTNTUqFb8a6H5BEEmspJdxucAAy5uKIxAzhHm4hVCruY3aKnADsydzPGoT6a+lFDafbtudgeTH4+xUANHqYWGCeKh3DnCs4CxA1ZiX8ACdbFnWtIW9VNssWeH6WTnuDA2AGAQP9r0JXhOPp3LvlQQHjZ9le1RwKswIB4hOqzJ2wkabrZeoT3wiBwxXbKNnZFCpX2VLbWH9t8e+xLTPnHhnlVHcRHUV27jIZwvjRYJFr2NIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3ilyPbCZMc9D4qzJENbNGKw8ecAZQwX+PvbXf06TO8=;
 b=HrSmcsT8VgzbB0Xuh6sYOfiXLaboswaLeu5AKUvGMERJogRTFgdHoAXmGW1zruwev6ojkAvxyoNJ2ERg88LV3iByGSV3UI3It5ZB4ZVt6om6W+J/hwhiVpgIrEAkJqBY1FHLpRk8N58V/VVXPUHpH4OQ8dpWejbDKuJgiE1zAd3yZk9vEeBHe/9S6uChf5ZN0ZI4g15YqLlXPePrMmPwnXD1rLXEpZkfzZHZ1sdbdm0ZJmLZj1eYW4q+bd7rsP5m48pl+Wf+TisQFtGGd5rGC/vpKgR2SDaPkQDS9UVKqZCE7DetOBSX8IkMFyMmtB1ZKwj4FpEwX07tvhWGEE5lyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3ilyPbCZMc9D4qzJENbNGKw8ecAZQwX+PvbXf06TO8=;
 b=TY3uql6Xr/Di9Djs4gkDTOUDQDQRxujZbEIhAtHcsMPkckrLb+1DLYE0XlGV5LC428r0SrcY4BXyTsx3BtWWSrXk/bE/SCFcYC6hdF5IbXKulZvgShdBDCTdNIwwNrEw3j6BLNXbWxQfis/5A3cerS/0G4ae9KYI4Z775E1Fz/A=
Received: from DS7PR05CA0022.namprd05.prod.outlook.com (2603:10b6:5:3b9::27)
 by SJ2PR12MB8159.namprd12.prod.outlook.com (2603:10b6:a03:4f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 5 Oct
 2023 16:41:56 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::dc) by DS7PR05CA0022.outlook.office365.com
 (2603:10b6:5:3b9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Thu, 5 Oct 2023 16:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 16:41:56 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 11:41:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 09:41:55 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 5 Oct 2023 11:41:52 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <bharat.kumar.gogada@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v5 RESEND 1/4] PCI: xilinx-nwl: Remove unnecessary code which updates primary, secondary and sub-ordinate bus numbers
Date:   Thu, 5 Oct 2023 22:10:48 +0530
Message-ID: <20231005164051.984254-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231005164051.984254-1-thippeswamy.havalige@amd.com>
References: <20231005164051.984254-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|SJ2PR12MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: f1062870-38cb-40be-5cbd-08dbc5c1fd0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ghf1bFyzzXHJWGbTzlVp7Va/9pmwUYielNG4dhYD9tSa+QH6WtHuTcos/rKALFQf71IciUTdORFu+SFWl2ax43GFjHfOcNurIhPHBUDxMhrLGqEPCTwjulPKztkESKw//dk3+Xn+vscFkJueNnek897vTT8TTDAzqketKS6JtKLkuV+2SZr2bnTXQl8Mo9po77/HH4ECuVJfJG7E5h/yWxGA3gyO31TeJ+wvm8fno4KV81zgINx7CKKeuJ7oDeHD0OB2s+uZqFgLnaPmN0XOqg4jUWB1AIa1vQP/Zh/TNW32JB94zer91k+RqBkWkaa4znlJ+ZXoNo6WlqfCy2UdBpYCK3tzOXKGRj5kg2fAxRRSlzJ1avHCQn3eBYiqG5FsIt6EtZiK1H1f7BNqlbKvrdL0nyc9rx8diDs20NzIhwZc7doIxuJ8Qi7y17EjHbaCzITlcruR/Au3908jkSBVJ0m2kiZJbzJhbXLp2hT4qB4LffVZPstb0XNbHVDrIG/M1EFm7FXwvESH896SS9vu2+K200zZe5VfX4FtKt5IwXSryC3qA9zelz4O9H9xxIqnLDniERjvwtGg9To/J/xFoq2CDDFuJ9nCqQmwVP8BRMjnuhGOqAxr8SqnZqCiCyPFZCK6+YHr5PBGofbC6Qrm+bJDCuoVjoX191RawY9BKUBtYlVe74Lj41biiqmfYqyu7oYhE+l8ACV4LrnDwWPqrK9LqmoB4UOt+b5KY1VzgmAAeAugnWOJvDOsxVXNHUq+Pq++Y/JISKU0lW4jaI9RPoQgFOFimu0DAJI18w15rDo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(356005)(6666004)(82740400003)(81166007)(40480700001)(26005)(2616005)(336012)(426003)(44832011)(70586007)(316002)(8936002)(2906002)(41300700001)(4326008)(1076003)(5660300002)(86362001)(15650500001)(7416002)(70206006)(54906003)(36756003)(8676002)(110136005)(478600001)(47076005)(40460700003)(36860700001)(83380400001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 16:41:56.7081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1062870-38cb-40be-5cbd-08dbc5c1fd0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8159
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The primary,secondary and sub-ordinate bus number registers are updated by
Linux PCI core, so remove code which updates respective fields of type 1
header.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
changes in v5:
- None
changes in v4:
- None
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
2.25.1

