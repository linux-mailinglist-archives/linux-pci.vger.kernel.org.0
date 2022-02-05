Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197804AAA0F
	for <lists+linux-pci@lfdr.de>; Sat,  5 Feb 2022 17:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380430AbiBEQXe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Feb 2022 11:23:34 -0500
Received: from mail-dm6nam12on2042.outbound.protection.outlook.com ([40.107.243.42]:58881
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1380425AbiBEQXd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Feb 2022 11:23:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7tQQ2BwetJk3nl2V72F23Qi0ldkGMn/2ZPuNXdAS2hzo3pHWOw91ePaILlzsLDj1vk9gN/hMknRDNfmKuYGp//rW16MKu1sZ92I2utwWyL8KfshX9jC/XcK6cK2XVH5RtDdJSLXUYyzfdHOn3gndw8FvtE9GLRTSUmGTNaZwZOFK90pGu9c2vugvkiE3RLJiUv7ZSUUQtAAOGMwth7JwoAhVD9uCk8dDjBCxsh0obInnq5dr8CFzaCDztFfJwJ67cLfGFPdfZeQo64z7khRJkda/qh8F8Xa7AoqntrX2MnnBDeAmpP6IrDvx0tK0mnjh+0vH76JDoOpAhPJWGuCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3l9SQw7DZJphGb24RsmWzOqdjpMuxYTnbZqXJ8ayyls=;
 b=mTVFZs72pRoojv6bGxqWsA/lBdkLCvdtN6wkr/miu84QeUsWaBs76eHTAIt5Ln4asxeKyKwSPF1VLy6OFHcyMkeuEK6jHyUY13pg/GB01wmoyU3qhLImzulRKG0dR+rDm/4wsYNfeU5ugpO3EbZQOvG/zKRzmL6fNUM/I2WwS3sllrIDZ61P0g7fCuOLujwo6o3UotoU8WigTukqVAvlFPub/qLTet8SzxEnH2v5GpTZImcgbne3WhDX1eooWYO28YjU/DUa8cwK2lz+WbbwL8qqimrNS4tnt+x/yLmipFN4a9dljhNG1b+9179SRromGHrDNnQP4ybHPaLkus5WaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l9SQw7DZJphGb24RsmWzOqdjpMuxYTnbZqXJ8ayyls=;
 b=e0PrWY5+ih6CrfSEDYppvkrSFSC98zEW4odqxfjPmJHdp3wpbvoxvozVuRKNpMU4hP+5BeLoL+or1ypZZPLyCBtIAvv0JoudPHNF8hglg6pW/GEP0u2a575WhSJRc9ZbdTvphIS+OQeDSFafk7M1tmAwfUEjYsQDrz5ZxQuego3tlM7a9ytwW8G2MOXORSNRSrEfwfsTE3SNUUozcz7rQxzWsEEzjfcculPLxfB2BO6/tkf+mScQTNKJmpMW446ChDrh+70hOr5OzrkxdnPrU/OACmpJAKp4s1S+nQTULhSHz1j2wbOMgQVR2Qxc1FJ4qLDvffxn7eX685zDe+/0JQ==
Received: from DM5PR21CA0046.namprd21.prod.outlook.com (2603:10b6:3:ed::32) by
 DM4PR12MB5102.namprd12.prod.outlook.com (2603:10b6:5:391::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.18; Sat, 5 Feb 2022 16:23:30 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::e) by DM5PR21CA0046.outlook.office365.com
 (2603:10b6:3:ed::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.2 via Frontend
 Transport; Sat, 5 Feb 2022 16:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 16:23:30 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sat, 5 Feb
 2022 16:23:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Sat, 5 Feb 2022
 08:23:28 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sat, 5 Feb 2022 08:23:23 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <kishon@ti.com>, <vkoul@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski@canonical.com>, <p.zabel@pengutronix.de>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1 09/10] PCI: Disable MSI for Tegra234 root ports
Date:   Sat, 5 Feb 2022 21:51:43 +0530
Message-ID: <20220205162144.30240-10-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220205162144.30240-1-vidyas@nvidia.com>
References: <20220205162144.30240-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d871e24-2c2a-438a-b8da-08d9e8c3d8fb
X-MS-TrafficTypeDiagnostic: DM4PR12MB5102:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5102149251E8CA35E94DD966B82A9@DM4PR12MB5102.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8a6glFM1iRLwoyiPwNBR5z16TWdkGH6kNUcKU39X89yFPimaFRwajmtRmDPsqraQiIDwk/B1tUYPb8bW7+J5j2SIJVHT5wXPkNJLugiuw/dV4CdLhyZTRqVgu+75rSsNSGjNB1ZZaLqlSE5Zvp9A/qe6AuugYYV4FqKq4k+7JIzd9dAQ9Qh4d/dGQ4eqVwcY46AW0eUUz2c9EXbviE4DKR59BX6EnWfQVtjdD0Aejskxt+aFWWVLIH6Wv3cMrYJ6le8Kl/yR3CMOpMWM4B1fKE3LF0I4K2U/DHSxmWOlcrmpkrvitNLOt0ha+8zsPJMV/IZ1HjVIzfndePYIw27iMM1pSmctuKqAtsIj1PxgbpEL20GWOUBdgONj9yKtgV9VqYDRwHMvlkgrH1U5vEYK8S4hAyK4g5LEoo/nRc09qf1RSt8tThNZ2/x7NM9xKzQS/9I8jHEreMCgRBU5TMIDjo5xrRyuofI99rnr3pZHrA/iqjftaoGtiDBppeuHSY5101iCW9dze/rZ9INqomN79Qm6GLukCl8RIPSEIJHY3JyiimLKivaxJ2qzm6Bt7Jg1lk8vCOOqm4ZeFPTRUQBr6NWT6u4OLlbKqiBE9CId/cg2ZwqX0dPBv3UxZUIFeGaPZ1RljR4EMT3JyeVJWERrZ9RlDOIvS3lF4lpbQNT5F1FhuLiDDjKd4Hkgti+ozdOl5a4TbxmswEKFMb7BMrUwoQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(40460700003)(2616005)(81166007)(5660300002)(7416002)(83380400001)(316002)(6666004)(70206006)(82310400004)(336012)(8936002)(8676002)(70586007)(4326008)(47076005)(36756003)(6636002)(54906003)(110136005)(86362001)(7696005)(2906002)(36860700001)(356005)(426003)(1076003)(186003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 16:23:30.5184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d871e24-2c2a-438a-b8da-08d9e8c3d8fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5102
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tegra234 PCIe rootports don't generate MSI interrupts for PME and AER
events. Since PCIe spec (Ref: r4.0 sec 7.7.1.2 and 7.7.2.2) doesn't support
using a mix of INTx and MSI/MSI-X, MSI needs to be disabled to avoid root
ports service drivers registering their respective ISRs with MSI interrupt
and to let only INTx be used for all events.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/quirks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d2dd6a6cda60..3ac5c45e61a1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2747,6 +2747,15 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x10e5,
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x10e6,
 			      PCI_CLASS_BRIDGE_PCI, 8,
 			      pci_quirk_nvidia_tegra_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x229a,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x229c,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x229e,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
 
 /*
  * Some versions of the MCP55 bridge from Nvidia have a legacy IRQ routing
-- 
2.17.1

