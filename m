Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE30742B47
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 19:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjF2Rbk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 13:31:40 -0400
Received: from mail-sn1nam02on2044.outbound.protection.outlook.com ([40.107.96.44]:7495
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231883AbjF2Rbh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jun 2023 13:31:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PihOkmm85XGZ4AeuTON5JtRwwbdMTgazc/VaXVx4dbcuV9WcxYJkk/9S9c6415NHHxa0lW5vbecvnnOkHgRCxlGSKqzNG3mfQdyDK/Ujj9DxB6C7gs8sBMoIM4/owSN1hmo/ye/niNBzh5s8RVlJmtXJzqS2rt8MOFNX5NFvcZ4LCT1DNL1jMdT5O0uFpfyFW2xqLXggR7yEm6c1y2GJTkUfFAbzFsZ3UFAmMXltVaF3GafdTYAO4jJBq7V682ys5bPEQIEPH1cF/x94AGd9mvV0kC6RXpBBaiV6h77Gt4DyO8ogE3RLdDHyhmhT8g4Yi8xkWEUXVkAebMdlBrY+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fo7Bu/GzrPUkr5dkLA3jBt/YqWwxSRIJBa4m8KooXlw=;
 b=hZP5ZKJyneJeHFJh3PmXYEBjPAhYFdx3ISjZ+uxBORbtkRBNtZydZOn7yxC9RxVBU52HvMwRi2rGL8WvxGscOLl+LE1J22e87I+9zACwdBIZt41vmjU+9YSF8XjjLFZhC+rCCZjZVdqfvt6Z7+7YcD/82clT8EDurv0OI6EXqkqeDFiFTs+bGTfH7cfYP/0DBUw6c0xG9A4axLQE8KZjshmzPa+FRJj7tXiRfoA1Ur7LzRyR8M+x9qT+dOn/ID77AI6l+4FWNGQr/Nl/DMdIo81Ix4UhpxcJH0fGbgdf/aVrDpWHQFu2TeZYRlp2++4Pue+c7TrpzGVM/P/HodB0Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fo7Bu/GzrPUkr5dkLA3jBt/YqWwxSRIJBa4m8KooXlw=;
 b=MiZ0Swu3JDlQElI+JnS5vEeKn71sw7FH4STglwWlifCre79VxGnnmluEggx77R4o3JYpOPHt56mzC+GO5nu0BMM9RTEiMVObk75bPmcgLG3qOYEWqdTkaTM/O5HLhIJ4ysodxrIse60Lo7rVKYpHEPCXy2VMnWPQQK6S9Y+BWLE=
Received: from BN6PR17CA0059.namprd17.prod.outlook.com (2603:10b6:405:75::48)
 by LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 17:31:32 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::70) by BN6PR17CA0059.outlook.office365.com
 (2603:10b6:405:75::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Thu, 29 Jun 2023 17:31:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Thu, 29 Jun 2023 17:31:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 12:31:31 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 29 Jun 2023 12:31:30 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V10 3/5] PCI: Add quirks to generate device tree node for Xilinx Alveo U50
Date:   Thu, 29 Jun 2023 10:19:48 -0700
Message-ID: <1688059190-4225-4-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1688059190-4225-1-git-send-email-lizhi.hou@amd.com>
References: <1688059190-4225-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: 7204f461-03f0-486f-7269-08db78c6adf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +kqDKYx0gW1uKfPSXqYUfzk30d3SgUKtWbxr+LzhQG+fb0W2bjaKsRaOb58ByRo/OndrUtNM76ttKMfEsHE1AJk+/y7isXuXYlYfGnGSysPlBLWoIfgcNQrqLGeFLpendhEeYI1U+aJAOoQnB3GeYtFJsyso2o4ltqvCPnMpbNBhjWSPTBLHB54Su0rrtWZOQjb0R4tPaH6D6PwHkk9/5OmJjnI7PaMYxZrVBaQcV9S3up06dcO+DV9wWOT5aVSYFWaRnWSF7lwkNLLhBCnxIOyyP2lohLZes3szcPD5s+ETmlq8muByNkaOcn1ZfoF1s3CjAO21A80wSMw12mSai8lVbIKneBgiSLib05fP4LQyz4O07J/2Bg2Q55FggTLPfWyeNxD6yZ1E5gycwT7PE6vOyPYloXT117UPk6hdfuH47hMRKfg5rGYzVtUqGJwjOPiKBDCr4rcCrMhqXGA4LEUzFqlGq1jzhed7AEKeOESlYnfy6/XkRDMNDwAagjtnuMFmQGAeq/QQefKaDRear4aXP3eKCSka8rE++V3+kUmtvgdKVbtoWA7AmD6unOQrCFrJBt1v7DMhHeM8KEojgeJBzsAeJrazsXMMOZecj+tUHbl98I+Ov1agfMMcnFAe7YMZ756AjNc8fREejKEAvlfmYuDnNrPXcJEmKije2wR1n10bzCOZfflcsyjX22ReRCqZ6geBYn0uEnDjSOSNm3zfQrcANsQkpoMorSgCK5kMxX/N/LcaQQQuyXfNCANU9skXjBTANUwbCWwBFp3hiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(36860700001)(26005)(36756003)(82740400003)(70206006)(41300700001)(44832011)(86362001)(47076005)(356005)(40480700001)(8676002)(4326008)(81166007)(70586007)(8936002)(40460700003)(316002)(110136005)(5660300002)(186003)(6666004)(2906002)(2616005)(478600001)(54906003)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 17:31:32.0121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7204f461-03f0-486f-7269-08db78c6adf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Xilinx Alveo U50 PCI card exposes multiple hardware peripherals on
its PCI BAR. The card firmware provides a flattened device tree to
describe the hardware peripherals on its BARs. This allows U50 driver to
load the flattened device tree and generate the device tree node for
hardware peripherals underneath.

To generate device tree node for U50 card, add PCI quirks to call
of_pci_make_dev_node() for U50.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/pci/quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c525867760bf..7776012eb03f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6041,3 +6041,15 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
 #endif
+
+/*
+ * For a PCI device with multiple downstream devices, its driver may use
+ * a flattened device tree to describe the downstream devices.
+ *
+ * To overlay the flattened device tree, the PCI device and all its ancestor
+ * devices need to have device tree nodes on system base device tree. Thus,
+ * before driver probing, it might need to add a device tree node as the final
+ * fixup.
+ */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
-- 
2.34.1

