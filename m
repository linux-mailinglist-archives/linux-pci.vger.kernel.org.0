Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBD8731E7F
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jun 2023 18:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbjFOQwj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jun 2023 12:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237768AbjFOQv3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2023 12:51:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972C02D76;
        Thu, 15 Jun 2023 09:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODYCqBeJkOquGtoWnrhCcOp8EyJ0g6JewrJ0GK3osSn5oCM7CxzFcLTNZ/vGqGRbOOHmiTMW4WyvS5cLQpgu44nLxxB5PCS9BlHvyu40ZhkmEv/A+MroYC65nQ41jHcJdeB3l/4sxFmtUxolPR4HgGgcbkJdPG9fyCCfEY/KHwTejcTRgNHLUpxXiPpL/feLkNZvRJZjSpuenoE/eaiDjl46pUZoQkk3IxFHOFGT4rmsevy5unZR8MFj6HTzGfxOUN51Y7ZdSwOCCxh3P24P7zUnHKwXH5Cy2eAaLse7TeypuzX0uZKy7BaHMevQKrEOy+XqPQQQenpsuip+5BHpkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZ1kgSZw47xXhcNbhwHHN5lf0GqcJcShG1NB5mlUfWg=;
 b=WhfX9TmC7fLVF7IaRATXj1wMnX9aq6h8Mvk1fzYWlr3oEoqsPHyxoxPSe5MLzwilSm0k8K0Jwp2hw3U1Qb1pCjOvd6JXuuoycGBiRjJ6qnfRxMIx7LlK/DsN2Ja2onXMuNck+rlql+uyTU07iBDLmUwjvYKcn9ztdilurijLlS40X9p96kadM5eVRkmgumhA3JnyV88jPpWK/m9JHERtFqBQSMdc8APOut2Y7BYSA0Ioj0umsVeLDYtdghlIXdVVRJw6tNa8bd3RG+tn3bkKpwq992JbcsZvudTjpL28a7FUlveDZnr7pPIJbOd9P2br7iaRHpmA3Ltx8WFpV3F3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZ1kgSZw47xXhcNbhwHHN5lf0GqcJcShG1NB5mlUfWg=;
 b=Qqn9r+lYXH2QcgOYsKZIUlEfQ1g6j4bvmy5gEBLO3xn6PVTG5d+fcNtaHP9A1QKFEWGpfGObgSfsmNfTrD2ykLCNIG8xd8wkbBpOUJ7PiCU4ijLefpK+Ac/36USRG4DrfGkcU4gDIgZmw0ZdxgBsYq2KG74T+0p5qZdb3h7LvVo=
Received: from SJ0PR03CA0235.namprd03.prod.outlook.com (2603:10b6:a03:39f::30)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 16:51:21 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::8e) by SJ0PR03CA0235.outlook.office365.com
 (2603:10b6:a03:39f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Thu, 15 Jun 2023 16:51:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Thu, 15 Jun 2023 16:51:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 11:51:16 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 15 Jun 2023 11:51:15 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V9 4/6] PCI: Add ranges property for pci endpoint
Date:   Thu, 15 Jun 2023 09:50:40 -0700
Message-ID: <1686847842-33780-5-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1686847842-33780-1-git-send-email-lizhi.hou@amd.com>
References: <1686847842-33780-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|PH8PR12MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a2b8885-35e0-438b-363a-08db6dc0be7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YN9pV2CKCKlNfUayfLyJt82lwo7VEyfkqNna8vfNrVDegKIitMe0krkL5MYXrfzsNJYFHMAub2h5RInLXHtMMECIxq8LLzDbq41fsYMckguslAgweU1s6IbptK57OKzQUBpvQPjAgJlzLFEMqIC/UVwTZz6Hm0FL/iXjrRItcOewXT8m0N1dlxZ6QNASboeOM48zbwMCrKGVdm31oZ+zUo8SsYFcGvkmdPKtEZZ+04nNj6BIyNpUH8glipGH1gO2MyBROyR2Oe2oDeY10irrI4QeGTYmRZOfQzaPO3bB4VXRiLC0CvSkVTYMzWjQ/YgY3rRfq9ky7yEEW3yXuhP5rviaa8Hc+X3wfCeFJDNM2eeWA2ibyj3THnredG+/pVeQ4wQ5Jt4S6x6LaQqkFPZskCBhF5ToBDuGDmK3A9SKGfYhkLBZ0PGopszPMVSvuX+CP/gVF7Mv3FqoWfh9tuikhoMROhUX4BoAKbCB8PRQwu+e4VXgom2vKVoNAlj0oMcjkDvqcYarwvXeUMj5dDgpfvTjUhVifZGNHUTnCH+7fucEemZWsLr+hmGYWEUcGRrUjQJ5kuv9S9CZaJmToByeNqoRJxDeRvQb2Os1K6QMuoJu67UYwqo+dxqqhANEWXz3LMUQYJ+HkK/B5CiNVg/qDcFvHhqh/WoCTnSbasxrHLBUsB43Batdth5gMBTQEfOzefcSddWUD4pG3s6CFmSf4Wpv6e9XTrbSqw1gyUlk6jUEJrP5cys1vAnz2M2OVNBkunuLdzdBDSvhP0uruPaL6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(47076005)(186003)(26005)(40460700003)(82310400005)(86362001)(44832011)(82740400003)(81166007)(2616005)(36860700001)(40480700001)(83380400001)(336012)(426003)(356005)(2906002)(36756003)(41300700001)(6666004)(316002)(110136005)(54906003)(8936002)(8676002)(70586007)(478600001)(70206006)(4326008)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:51:19.9104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2b8885-35e0-438b-363a-08db6dc0be7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For PCI endpoint defined quirks to generate device tree node, it requires
'ranges' property to translate iomem addresses for its downstream devices.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/pci/of_property.c | 33 ++++++++++++++++++++++-----------
 drivers/pci/quirks.c      |  1 +
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index bdd756c8d7de..08654740f314 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -84,15 +84,22 @@ static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
 	struct of_pci_range *rp;
 	struct resource *res;
 	int i = 0, j, ret;
+	u32 flags, num;
 	u64 val64;
-	u32 flags;
 
-	rp = kcalloc(PCI_BRIDGE_RESOURCE_NUM, sizeof(*rp), GFP_KERNEL);
+	if (pci_is_bridge(pdev)) {
+		num = PCI_BRIDGE_RESOURCE_NUM;
+		res = &pdev->resource[PCI_BRIDGE_RESOURCES];
+	} else {
+		num = PCI_STD_NUM_BARS;
+		res = &pdev->resource[PCI_STD_RESOURCES];
+	}
+
+	rp = kcalloc(num, sizeof(*rp), GFP_KERNEL);
 	if (!rp)
 		return -ENOMEM;
 
-	res = &pdev->resource[PCI_BRIDGE_RESOURCES];
-	for (j = 0; j < PCI_BRIDGE_RESOURCE_NUM; j++) {
+	for (j = 0; j < num; j++) {
 		if (!resource_size(&res[j]))
 			continue;
 
@@ -102,8 +109,12 @@ static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
 		val64 = res[j].start;
 		of_pci_set_address(pdev, rp[i].parent_addr, val64, 0, flags,
 				   false);
-		memcpy(rp[i].child_addr, rp[i].parent_addr,
-		       sizeof(rp[i].child_addr));
+		if (pci_is_bridge(pdev)) {
+			memcpy(rp[i].child_addr, rp[i].parent_addr,
+			       sizeof(rp[i].child_addr));
+		} else {
+			rp[i].child_addr[0] = j;
+		}
 
 		val64 = resource_size(&res[j]);
 		rp[i].size[0] = upper_32_bits(val64);
@@ -161,13 +172,13 @@ int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
 	if (pci_is_bridge(pdev)) {
 		ret |= of_changeset_add_prop_string(ocs, np, "device_type",
 						    "pci");
-		ret |= of_changeset_add_prop_u32(ocs, np, "#address-cells",
-						 OF_PCI_ADDRESS_CELLS);
-		ret |= of_changeset_add_prop_u32(ocs, np, "#size-cells",
-						 OF_PCI_SIZE_CELLS);
-		ret |= of_pci_prop_ranges(pdev, ocs, np);
 	}
 
+	ret |= of_pci_prop_ranges(pdev, ocs, np);
+	ret |= of_changeset_add_prop_u32(ocs, np, "#address-cells",
+					 OF_PCI_ADDRESS_CELLS);
+	ret |= of_changeset_add_prop_u32(ocs, np, "#size-cells",
+					 OF_PCI_SIZE_CELLS);
 	ret |= of_pci_prop_reg(pdev, ocs, np);
 	ret |= of_pci_prop_compatible(pdev, ocs, np);
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c8f3acea752d..51945b631628 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6052,3 +6052,4 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
  */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
-- 
2.34.1

