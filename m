Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA7855F60F
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 08:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiF2GGF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 02:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiF2GFp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 02:05:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BB51056D;
        Tue, 28 Jun 2022 23:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgh7RJ6xtOr2O6kVBdz1tmuG2FvsuSq3nD56m2dIEsry0vhnN73RrniH7TlBzFaBuWbDQ1+O7c/kFQtv68KeFOk9W849Xp52y98zAhF2B5B0VWKJKR4mDJW5eIbJOfDbmgXfanUBjw5txHnL6InFxWAgJVTrNPwLsLBS0T1QpMpUrH9BFIKkCctfFE35MzZ/fofWL2QuMeDy/cxl+43uw60rGwuPOiM4LY4eBwMQy9LlRUsAPybc4wCspsD1lIpjQoAbZjD0as2Ok7ERUnQqsKhEvY2jGQ06QTW4EjNAKi2cWi36NiPbgJUf/t7bWHF8ZWM5Mx2LLm2UI2nlxNGssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+2QAAYH+k/fpgy4mH+HR38Hgt12Y3rr2ZmwGj/SIJ4=;
 b=Trggaag5tnQDA/ZINYpXWCbPw5AoDW8ie7YvP4yFv3tYhRvnugAlW6qlk7tMKkW4vPwl0SpAnoAOYWH9uMe4Q+wEuyWs0HIxXAKuMqGPD+ZDzaRkVrc9PZfQ/VSyWEcPEJnxB51vC3OP/1kTfBJmAQmSyz1k06AKKKKYMVqmZzJTR/K1eFWwgYWHQntPflf9bGg17sEiHlRbdb16bZEqpfI2L5q93MLaC0mnTv4dyDV/xTcOOs6EBqIo7IG+GrzlH+XPAACCvj+J7wLP6BrNxyncVzpwb8kKzHd1wAJQUMM2Lnt1LNr/DUotYJte3Afei/vxE8ytzWbzk70gUurstg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+2QAAYH+k/fpgy4mH+HR38Hgt12Y3rr2ZmwGj/SIJ4=;
 b=XhHL4LwqlYrVojGRIaS/tPD/8bVNOHFLdJ3x93ZC8OjIbeIGCo3LhjlPIaVCwQD4HV43CXgk5VKGop04/Tgav0ccxw4jORbCy8E803HuDsrlBzp3FxvQ13u1yWcqaq3blbLxUVPr2QSO5MFXrq5HDKU9ZYQVjcRKj+0IHxg6+VNw8lP/gr3wUuniKxviCy964G17xEjGeUxmKJ1E+QfpSExp+bQ0mqi/QEgz+LFGQ8C6QapfOFcS2nsl8YaA943WLPS3cF6fZnV/VLIXeSX7MJ3XhtUkqDdsO712KFR8xTQVXKXVn8USyt3KIL37d9k90ne8QllZEg5pLv8+xoV0Ww==
Received: from DS7PR06CA0043.namprd06.prod.outlook.com (2603:10b6:8:54::25) by
 DM6PR12MB4561.namprd12.prod.outlook.com (2603:10b6:5:2ac::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.17; Wed, 29 Jun 2022 06:05:43 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::38) by DS7PR06CA0043.outlook.office365.com
 (2603:10b6:8:54::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 29 Jun 2022 06:05:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 06:05:43 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 29 Jun
 2022 06:05:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 28 Jun
 2022 23:05:41 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Tue, 28 Jun 2022 23:05:37 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <kishon@ti.com>, <vkoul@kernel.org>, <kw@linux.com>,
        <krzk@kernel.org>, <p.zabel@pengutronix.de>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V3 09/11] PCI: Disable MSI for Tegra234 root ports
Date:   Wed, 29 Jun 2022 11:34:33 +0530
Message-ID: <20220629060435.25297-10-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220629060435.25297-1-vidyas@nvidia.com>
References: <20220629060435.25297-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 777f78a2-6116-49e8-1b62-08da599566b7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4561:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phAjF6j/8cVY2vsc9B1y4qIr8WwR27pMaG8ruUm+MO+q8OtIJ2YyoeJEOnDMTg2l0+dHM8Vj0DndRW/dVsd9MyeiCCzxFCKeHiPdrVXFeSzwGLu0c6VqxgcUdvs+uIlXhUV2fSVIdhY31DWiTJDx/S/d+zqGeD5T2eLbb8ht8ArosHEeH+DIFbUugfjUIej/oOu0t4bwoFml++JF7C40DLEcr+urucd29cIbaaN4147dPbrHPXzlwhjQlwW2qGsSVVzlnzZSjSPf8Y3P4Hxszks2gWehj5W8/QkQfmg4uGcTZfLrAocPhCflc9rmII4I4e1VosvfOrnSulsd4CNhoOdOTqHuQU8Vi1fVYpSZxPIH7eWWAue9HCK/ZNtboOLq3RhCnhoMU+B3oqQUPL+JQ0lscXsPCwvLeVHxv0+4+4YHla3jDciUZkn148yRyjiRksc0QGO2FewL1GMaJ4X15CU1KLtLmgBzp+Cs8V5zIVbnvPJA1ivuJ0kU/NrEukze2lZUQ7O5KwFx8cg1WvgAvmfMYkUqhnQxIaRnn+296E9AlrybgYmkk+eArKEmpWG7xTuHpJdPFivTdb8oaNz/+5fpdTANE97yvpou8qSqhDqDNbGei12WS+9KZLuOvJG88p/QevWuxfRcF2IV+1kJwM1ft9XFx72+GI0RfXP4W00/5kCUeiujLispMlbd1YYvl4DiNO+EKeAv/44rxRy/LRNHIpXOeZbWjL8SDf0V29sg9sKbr0G099enl1QKicy7/42de1uKAfwxpmWzpElFnFhrNyLmAPz9iCTI51OH7HFaCxYj5fmYVE7gHrPlWnkooCHlwXS6lsC9PttbqPEuqg==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(46966006)(40470700004)(36840700001)(8676002)(426003)(2616005)(336012)(83380400001)(8936002)(26005)(4326008)(186003)(70206006)(70586007)(36756003)(47076005)(1076003)(82310400005)(7696005)(81166007)(478600001)(6636002)(2906002)(6666004)(40480700001)(110136005)(7416002)(316002)(5660300002)(86362001)(40460700003)(356005)(41300700001)(36860700001)(54906003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 06:05:43.3528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 777f78a2-6116-49e8-1b62-08da599566b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4561
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tegra234 PCIe rootports don't generate MSI interrupts for PME and AER
events. Since PCIe spec (Ref: r4.0 sec 6.1.4.3) doesn't support using
a mix of INTx and MSI/MSI-X, MSI needs to be disabled to avoid root
ports service drivers registering their respective ISRs with MSI interrupt
and to let only INTx be used for all events.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* None

V2:
* Addressed review comments from Bjorn i.e. changed the PCIe spec reference
  to a more relevant section and modified commit message accordingly

 drivers/pci/quirks.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2e68f50bc7ae..5b532449ac4f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2709,8 +2709,8 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
 			nvenet_msi_disable);
 
 /*
- * PCIe spec r4.0 sec 7.7.1.2 and sec 7.7.2.2 say that if MSI/MSI-X is enabled,
- * then the device can't use INTx interrupts. Tegra's PCIe root ports don't
+ * PCIe spec r4.0 sec 6.1.4.3 says that if MSI/MSI-X is enabled,then the
+ * device can't use INTx interrupts. Tegra's PCIe root ports don't
  * generate MSI interrupts for PME and AER events instead only INTx interrupts
  * are generated. Though Tegra's PCIe root ports can generate MSI interrupts
  * for other events, since PCIe specification doesn't support using a mix of
@@ -2760,6 +2760,15 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x10e5,
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

