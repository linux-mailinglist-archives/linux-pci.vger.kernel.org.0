Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6AA3928DC
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 09:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbhE0Hsd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 03:48:33 -0400
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:56160
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235120AbhE0Hsa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 03:48:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhQpeIYzcs4t9f4205eiPOVIJDilbeCZWo5ilG5K2xWqtRoyLl0uEVG76ZuMxdw8QE/GwYGhVLEgxmcKR7S8Kjdl1t3nK5kB2Pjo59nTYKCcm48vPIZzhSQla30pMrcc/3VAQpbqxfGdPdhfLY2+q5O0Gcz4zafxvuvoYd6NJXmMMKPDwA7K2ZSlq3QxMkrAiwg+YodwdEi0DXMdu7QxvWFwrJHQCV83ghE+CYhYyM9q1UQgTWi1610x9Cr4As6k3co/jAUPgPKu50x0jmqi9WZiTjtoSKxSD9nBpEXCwFZDCTJNuQw6i6lW6MYcuEGiVgDy1tvfcskfjUGvpScQTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O64TNUwAJmcUqqRZwQ31dHJT+11KJwMxMW/87E1xnQ=;
 b=XidIjfB4FtJviMCPO5bf+IJOqoF72mOtK/5TGCYtgDU0uY/wAx2RJOogH8gm9ldcTxnziq42/n5gNYSp7LsFn7Js8+635M5IghhzlbFRURyqHkCUp/bFE8vnboEl9Wk5pAyJXAuAuig8KPtEzkHx8AkIP5FJ3coQ0/EsPcf3Cm8+/DUaLlB0xSecW1sAfcp+S2rN5dIdhqUwnswdGeTwZN/QRE55uh9HMbSfIq+lOPG7iRMqLL2NUd6G0CHOcw5605v9h6uiht9jt6tMJpvnfEdAf3wcngfSAoXk3EDWaMWTOa3IlOvVBpZ5RkGVsu6vTp8+qFINn8SV6kOfAKOIzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O64TNUwAJmcUqqRZwQ31dHJT+11KJwMxMW/87E1xnQ=;
 b=J2YD0zkeKlRexugObintZATwib25fH0ueTrUNOIweBYt+Wv9pxy4bEx2xrLSrA4atvXYj7s7xV/G5nZfFcnQyWskjEVr8nfHNWK9CB6OGazdw+KUGR0hoYVcNS81t3w0vCJADWMp3sSgdOwCTxs91VbGlzJajt4uGZtALxPnbAcJMSkjXOFlqm7x5zMHn8Lr5VgQAeFOLobwSZd4qtpte+gAA2aIuiCsIqwq6tdLdU5tpAwPxuCp8bd495lH+7mj99f7WHwVMrEyNkjn+eLYyQ+OzCczmpRL79wIShLJ5f0j1Y63YD6AOpwOPiTHR9URxEhrDujz3CmJEvajAydAUw==
Received: from MWHPR13CA0033.namprd13.prod.outlook.com (2603:10b6:300:95::19)
 by MN2PR12MB3504.namprd12.prod.outlook.com (2603:10b6:208:d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 07:46:55 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::b1) by MWHPR13CA0033.outlook.office365.com
 (2603:10b6:300:95::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend
 Transport; Thu, 27 May 2021 07:46:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 07:46:55 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 07:46:53 +0000
Received: from buildserver-hdc-comms.nvidia.com (172.20.145.6) by
 mail.nvidia.com (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 27 May 2021 00:46:50 -0700
From:   Om Prakash Singh <omp@nvidia.com>
To:     <vidyas@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [PATCH V1 4/5] PCI: tegra: Don't allow suspend when Tegra PCIe is in EP mode
Date:   Thu, 27 May 2021 13:16:13 +0530
Message-ID: <20210527074614.49149-7-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527074614.49149-1-omp@nvidia.com>
References: <20210527074614.49149-1-omp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 030a70d5-db68-44d2-1eeb-08d920e3994e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3504:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3504E4AD4626C9136BFC7653DA239@MN2PR12MB3504.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UA7baUBPaoJK1Qyzpllz4FyqdlF6jTGTs9VRAWtaf2GWFBXTK9V4lklj1XyI1VZkF8OKVRlwVcfZi76nlL1DLIYGSlisokTbiygKnwd14rt3iTD+91TyzjqqwmuK2hZHVHqr+E/zccdZcZc7UwP9ifoYoKr8KHDkrtvVQrL3hbpecKKlIdjltLMPk5Qb47JTQKLp/2SlXMnx2X8gpGP+8zeNm6yh5nW7hOiNyjY1Hilv0lQX/38HyrbN/Xk7HsjkvivOPdAB3uETRguJkzVq61EMOlGya5NoqTY0bBA4qit6DU4TneRDTUxRlXooer9cGM4DYdsPLTWzy0RlF0a8eER9NCP3eQtY9sbZweM67GzioTvd9CiXaBPfz6uhFpJuif8+4n/3qwb4nUXl6/X6IQ5zNt5iGUTjAB6V61y9+Vtg8sh2W8zqtRCYyidtZsSu4vTLmC9gI63XTfFn5TsNN3rWB0LwUWifGWAB/a1H16Xb+2TU8Acf30XcWNUpVy7tiTLWIuRuZMDrQwHjKca4NG4btdx5qBu1rF660G4z9F2jkUk+lsEdelsv+K/vD8Ve41EquZi5pKeZj3w9xUr9Vno6kL91KLjBjlw2YZBK8TG2qwttgtXVrSk36U0MjkAcWMLKyvYMZOFs/RzWK6Nq4A==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(36840700001)(46966006)(26005)(4744005)(1076003)(186003)(82310400003)(107886003)(47076005)(70206006)(6636002)(336012)(70586007)(4326008)(426003)(2616005)(83380400001)(316002)(6666004)(8676002)(356005)(36756003)(110136005)(54906003)(36906005)(8936002)(36860700001)(5660300002)(7696005)(7636003)(82740400003)(86362001)(2906002)(15650500001)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 07:46:55.0335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 030a70d5-db68-44d2-1eeb-08d920e3994e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3504
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When Tegra PCIe is in endpoint mode it should be available for root port.
PCIe link up by root port fails if it is in suspend state. So, don't allow
Tegra to suspend when endpoint mode is enabled.

Signed-off-by: Om Prakash Singh <omp@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index ae62fdc840e6..93c89f2084a7 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2276,6 +2276,11 @@ static int tegra_pcie_dw_suspend_late(struct device *dev)
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 	u32 val;
 
+	if (pcie->mode == DW_PCIE_EP_TYPE) {
+		dev_err(dev, "Tegra PCIe is in EP mode, suspend not allowed");
+		return -EPERM;
+	}
+
 	if (!pcie->link_state)
 		return 0;
 
-- 
2.17.1

