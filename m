Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146CD392D43
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 13:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbhE0LzE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 07:55:04 -0400
Received: from mail-mw2nam08on2052.outbound.protection.outlook.com ([40.107.101.52]:28745
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234473AbhE0Lyt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 07:54:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCtWWthg5MrMs5YlDTAtjEi/0OG+9waJJpvCZZTFHOooTNDehFVFLNEtIx+h1ln6j3rMLbR8Jaawgk3DkgTDzPTLFb98lwBoyh04wf3knTgaKJphADcF3EgaW8xykMXQax+8gvaxrz2lgxlN9WtYsG98LAILHIlfMcSkzq0R1c2U3Pg+tbBRXJ3zbwL+JpwrqE1XFHbXPZXBF2clVVnGJ0P8zbUoY/vAgg0cdktpIZp5Xgpn8LD7Dt4tDuO7cfUeFWltwd+DLZzRsdLXeNMsNOssUidp1kVNCDi8N04tSVcYgq5/r4hAteV3CljPvAwaV9Nn5pwd7Y7O1H8uOf9iqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1GK2JWWrQSWRsqdJXF260JrFBq7qIyGNr5crXTQ3Kg=;
 b=bTNyqayVygNI24q2jil8zLvAf+oiehy9BrQLqaJoMjynw6CVMxivv1W0ZD5yScLvC6hIixMlhCdnXTjesft+s7G1fEytDm09Top1pmPUKcYONdnp73tIFcwwxkxOtrTz7PmXVDVTkBf8pC6vulJe3k0ZrjPnKAUGBPcZsCJNLgIQwO/7Dhzc9kzjUkY1QGNXPqYEBy55nZlDEM2JOoxrWkGTgmTwkD4LtskB8cX//IBMtEph8cIk2HeTZxD7/qfWqhWDu3DyiM2Caxxjs6zdorrFhHnY8P+oqBlVhxTwpTBTtArJJ2Oc5vAJyeTc8/eOpIWDWT0GE148/6ernlLpqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1GK2JWWrQSWRsqdJXF260JrFBq7qIyGNr5crXTQ3Kg=;
 b=hcmyEsRS6H+Gi9UbZXmY/WRuYwycaICQnmAPKI/5NOD/3IUQ2h+zRmfkTfzUMRNBFmwhHsHP6+mQcgTeoMvqDOV2iuAs/Xwkquu5bPG/yDb4UEnQvXLi5g/ADXLXJg/41/NmC1+A0maMJ3o0nioIPb/fZ7Rcb7eh2BKNCK0u5eYR8PV2r4eO/uMz/8OfBMR0/OwIatqAQ+e3DGf+uNW9FPgpy3inDxNvWiubkVCcysM2xTFTDAw+5byhwX6uC51iesPcKvdcfzXU2rp5eTG1AUytwW4OD3mQntBQ1Qnbaj7Bf6EAiiMeYZ2ETCvtwk6CL3/k8lWqH4dxCrhsd/F+qw==
Received: from DM6PR08CA0013.namprd08.prod.outlook.com (2603:10b6:5:80::26) by
 MN2PR12MB3888.namprd12.prod.outlook.com (2603:10b6:208:162::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 27 May
 2021 11:53:14 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::35) by DM6PR08CA0013.outlook.office365.com
 (2603:10b6:5:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 11:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 11:53:14 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 11:53:13 +0000
Received: from buildserver-hdc-comms.nvidia.com (172.20.145.6) by
 mail.nvidia.com (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 27 May 2021 04:53:10 -0700
From:   Om Prakash Singh <omp@nvidia.com>
To:     <vidyas@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [RESEND PATCH V1 5/5] PCI: tegra: Cleanup unused code
Date:   Thu, 27 May 2021 17:22:46 +0530
Message-ID: <20210527115246.20509-6-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527115246.20509-1-omp@nvidia.com>
References: <20210527115246.20509-1-omp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c96e8d9-303a-4568-c0ea-08d92106025b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3888:
X-Microsoft-Antispam-PRVS: <MN2PR12MB388816E1FECD6B0EEC50129FDA239@MN2PR12MB3888.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yFx9cOVgGk2Ib2Iu5TjYvjSgvKovuBx5T8y27lzk/McVuZj2FfyizXV7Q0th8orZBpTtnqcpnX/786QaMFkK+6qUnDzfzrjdXJUC18Zw0mfrfCSRo2zu0IjW194MZ0ngOVYbf2rvdn8M3mUu6CXpoofecaGgSLmgw5EOPqadDckmgGMq9Wu2WgoIsitxrEeETPKtMUPnMyqkgmCjCtLeZ9G9GaDjZr9Q+RX0LVqrxHt/7EWkxAJ8XRpzdWNEoGeG2xQ7TyfU+bCj62d1rfXN8TZUEIEz2A+jYT6Pg9+D2G424yWjoHsKcpoV/KdNSOhnWQfq3bSJNR7nRws4TEwg2Cd46PAOQT3i3yVjS/bQ0G1+aniBKEoD57RdYcbMkLh7YvTSRvwd45OeV12bUHzPBfsq0dqyjQ9tut6zn9MAi9JSiGkA4l8vsvrGpZFAEd+NZaZOUGbGVsc4iKQPomltrXujsTr8mXu7Uqgb/17PEegnKXQk3JMNa2CQ9opRqlXE/EBTGH9xXoP2OoMAKk0WBzhCEfFh4WkepK9naU2ST/n6fVxGwxHHUGqKMwY4fTRzqjdzNynOWG+5U4Ag9qw1ryLZevAMIpuBVkUo0zHObQKL+1OKmNzw5Jm4LkaDypLC+sF1m0TXCIIW3Pw/Ttxmv/OP8aZB87zvrGS6lCLYZgs=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966006)(36840700001)(70206006)(82310400003)(1076003)(356005)(70586007)(2906002)(36860700001)(82740400003)(86362001)(426003)(36906005)(54906003)(107886003)(110136005)(4326008)(2616005)(336012)(7636003)(8936002)(316002)(6666004)(83380400001)(36756003)(186003)(47076005)(26005)(4744005)(478600001)(8676002)(7696005)(5660300002)(6636002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 11:53:14.1664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c96e8d9-303a-4568-c0ea-08d92106025b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3888
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unused code from function tegra_pcie_config_ep.

Signed-off-by: Om Prakash Singh <omp@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 93c89f2084a7..096aa5306fda 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2045,13 +2045,6 @@ static int tegra_pcie_config_ep(struct tegra_pcie_dw *pcie,
 		return ret;
 	}
 
-	name = devm_kasprintf(dev, GFP_KERNEL, "tegra_pcie_%u_ep_work",
-			      pcie->cid);
-	if (!name) {
-		dev_err(dev, "Failed to create PCIe EP work thread string\n");
-		return -ENOMEM;
-	}
-
 	pm_runtime_enable(dev);
 
 	ret = dw_pcie_ep_init(ep);
-- 
2.17.1

