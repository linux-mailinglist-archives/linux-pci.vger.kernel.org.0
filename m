Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04E73928E1
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 09:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbhE0Hsb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 03:48:31 -0400
Received: from mail-dm6nam10on2050.outbound.protection.outlook.com ([40.107.93.50]:53134
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235097AbhE0Hs0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 03:48:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfHi0sDg40p9SWqkQRg0jGjGn/OHoILUK2HDF8VCdkw7SFIKzkT4MT6F2K8+3WYEHvsynoxaVySLYqTzE9KEIrcR96rZ6l/wEQZ1AraUpjd+rnBmakB5xXvf6K9dBjC7xtfukHaZwF1xD5IKRye7Nl0S8z3uo6ag8WGGuun6BQL6kL1dtGLEWk05cxQc/r7gICqRAt1v1hvNIloMdVHbAIt6AX1WzfaBk3Rstx3BISDE84ogavBq8WrWKwigwmqUblNIdJOO4Y7VumSRTdUMgYlaDB551qT8dc4oJ8XEY88+mpsGCkjKJuabpLjj2EEE6SSBKb1eU28VJzZcduBvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHkDEk+PXRjNch4/r18GUZQOtmmMvUrKeYwS6LPpo8E=;
 b=MJQ6hNxlVVDf5iRTZ2m9irgiebtKLWbh5/Nm6grPpf4gaYbfdi2kdCqDwXwyrUanwx/lmQKTitUCLzai3by7rg17UkM201YikIJjlxBKBMYZfn7sc88sJr/uZk+KsIywg2GHQvIbONSJAPzJR7UeuKYpXZZlBNw/B6UeP09Q0sASGlOtIINnQauRi8SapmPg5KU/Vb15Xu0LDxh8fu8Ot/aV6e06m7/v67ukdW/RIJkICe63F27lkKQxZ4qbhkJflvmZEwUc1Dr+oeQ06MagxWT3GZVxO5EeRAEa1uq8xWOza2HLOm4NNLpnuRbyCh8vc6BafxAwD8aYGpWdPlfB7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHkDEk+PXRjNch4/r18GUZQOtmmMvUrKeYwS6LPpo8E=;
 b=T6VlQsvSUGGYCn92AulN/lgT34rVB8Y088/STlc68WCUI3MrZ2Amu+VkoMSlK4a1mbk0BqQ0XjUUCpJfsiA3ZQMAilOuei2Pz3AeflcTkXKFnkN5LIv2OGjQg3/Lsn+g3lVSC7KvTgBCCaympR+1ZGqb5Qu/koFClF0U3n7COgMVKiodAcSSGxTTJANIiuBo87O/Q524TCewOLgsZ07oW13xJSOavps9a5oPUmgwQBqoyC8GcA+Zuc4YObms/mi7ETua4yph5ZTnX/oQmoGg4YvKaOGcq8E1b6Xz6UcQdm01LS4fBKTBpxV72wC/iMQNh1NC/IEnZWNlfYPg4J+qoQ==
Received: from BN6PR13CA0025.namprd13.prod.outlook.com (2603:10b6:404:13e::11)
 by BYAPR12MB2808.namprd12.prod.outlook.com (2603:10b6:a03:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Thu, 27 May
 2021 07:46:51 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::47) by BN6PR13CA0025.outlook.office365.com
 (2603:10b6:404:13e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend
 Transport; Thu, 27 May 2021 07:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 07:46:51 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 00:46:50 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 07:46:50 +0000
Received: from buildserver-hdc-comms.nvidia.com (172.20.145.6) by
 mail.nvidia.com (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 27 May 2021 00:46:47 -0700
From:   Om Prakash Singh <omp@nvidia.com>
To:     <vidyas@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [PATCH V1 3/5] PCI: tegra: Disable interrupts before entering L2
Date:   Thu, 27 May 2021 13:16:12 +0530
Message-ID: <20210527074614.49149-6-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527074614.49149-1-omp@nvidia.com>
References: <20210527074614.49149-1-omp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d3bf50a-5c7d-4b55-011a-08d920e3971e
X-MS-TrafficTypeDiagnostic: BYAPR12MB2808:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2808AF70545B101F9365D746DA239@BYAPR12MB2808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mf9d6AfQim4uLvrAFCKdIT5zwV4KfP3L92O+GRRIwuTcrk5nM8IJn7LHd0Jg7arhG+QZytpIPARW6zKOdzsBu7j5LBlBcLEItjosGDCEtHbkJJG3iGcXqP9sQMCACx/s2dwpfP2wAlhyatWi902P1UOHrdwUjHlCqYtMouw8YXYIvbz3eyzG/7zUVUXp5XVNY3uvBjjgb5MytCba5kHIkEmXxbUvLdM0bhb8OuornW51duA2SqUjZoOIx2/ThiSWfBi5yBoIlOscJaDXE/xhvtq9tQEs4A6+GOUbHzeC2E8Gx2t5ghQPG8YVBDx4wZdxbhSxSE0DGI7JX6WLwp/s/kJbP5CXNJaBXnH0t3PoFSLYhy2+NeUSoZaT2oyZrykMNfbMmUfqwTCKMuvwNDGhF0J+w8+zjnULS1et9FjgObFsQhCVoJhLhhlqkxte3Pcy1iCwlblb+s7vQeluUNnZW7RWkhxumEg19zBqREhEXYijX4vrkRzlQwc15VPYhxsvLiv6p8ubb4qU3XLHmB/QLWFALzyLm/071tj2sXxRXwYHAMJzLzuZAv3KM2OuxBabZkZHEzecf4G8aLerTwTCTLexKHFbAZyVAW7ERwu/suBGTVUYIgyJDtdSYZk51j3BZHJivwuRKt+UjiqEGHnqjmZuxaVm+XlvHaQvrjPbAQw=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(36840700001)(46966006)(83380400001)(7636003)(26005)(426003)(4326008)(107886003)(6666004)(54906003)(36756003)(316002)(47076005)(110136005)(82310400003)(36860700001)(478600001)(1076003)(5660300002)(186003)(82740400003)(356005)(86362001)(2616005)(8676002)(70206006)(2906002)(336012)(70586007)(8936002)(7696005)(6636002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 07:46:51.2807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3bf50a-5c7d-4b55-011a-08d920e3971e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2808
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tegra194 implements suspend_noirq() hook and during the system suspend, the link
is taken to L2 state after PME_Turn_off handshake and if it doesn't go into L2,
PERST# is asserted. It is observed that with some of the endpoints (Ex:- Marvell
SATA controller), the link doesn't go into L2 state and asserting PERST# results
in Surprise Link Down error and the corresponding AER interrupt is also raised.
Since the system is in noirq phase, this interrupt is not served. Both PME and
AER interrupts are served by the same wire interrupt in Tegra194, and since the
PCIe sub-system enables wake capability for PME interrupt, having a pending AER
interrupt is treated as PME wake interrupt by the system and prevents the system
going into the suspend state. To address this issue, the interrupts are disabled
before taking the link into L2 state as the interrupts are not expected anyway
from the controller afterward.

Signed-off-by: Om Prakash Singh <omp@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 58fc2615014d..ae62fdc840e6 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1593,6 +1593,16 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 		return;
 	}
 
+	/*
+	 * PCIe controller exits from L2 only if reset is applied, so
+	 * controller doesn't handle interrupts. But in cases where
+	 * L2 entry fails, PERST# is asserted which can trigger surprise
+	 * link down AER. However this function call happens in
+	 * suspend_noirq(), so AER interrupt will not be processed.
+	 * Disable all interrupts to avoid such a scenario.
+	 */
+	appl_writel(pcie, 0x0, APPL_INTR_EN_L0_0);
+
 	if (tegra_pcie_try_link_l2(pcie)) {
 		dev_info(pcie->dev, "Link didn't transition to L2 state\n");
 		/*
-- 
2.17.1

