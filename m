Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBB2372ED1
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 19:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhEDRXC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 13:23:02 -0400
Received: from mail-mw2nam08on2089.outbound.protection.outlook.com ([40.107.101.89]:16448
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231642AbhEDRXB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 May 2021 13:23:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjsAxDWgSxZOiswwpIiy+fHTUAkpX9QujKclKgXib5juqfPCXY2OwV8w+r3/q2m8CznRBo0o9oUEwN6KA96OxhDE+EOk3iTcnySVGCMGN8NRphd/T/s+vhWZY8O2rSsD+uFzQ7UY5CxBagApzg4MvlsYqHpPOmizjcERArFpDNnOrDtFMRB4WM/+zb7zXwaWL+sd1zmHq5J/KUA3E7BG6gQku3Wc8+k5TgrIy/YYH34eK3JnthdwYNrw+kIhHZJi7iLAg1ZOVjiyigmddNNF+/e7sE8xCdUYNLluilH8KwV1l7vFztn5PUiIxNUC41i2tq0UgJ3vCQ63Sf6OpU4p2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZQyrFc5IDFViAS/U7PqSjm6lo0EAPfDa54XVBjW8yI=;
 b=Gl6ZAgDEk0ujoa7QlCvLf1KUglgYgeA5qjmIp7K4vXEUdf1GxJwLjUwss27tnnXifLaarkIB3DwqqEdcDkbjvOtJqWEPK9zs6CmVpaiiAHQW8USwuBayLydn8N9JGThsY/YubTSjl4LMt+NYb9+aqJZvXgb9VNrTPMOfE+1NCXLTdKcuZlzInybgP1VM/xdHtOxywbOsapIviMygtonM9BkOFSPFU7aJcokncJdP0loWn/dNycIcbwWSwwAUeJmNFX9sbZ1ztfeeVYi9zmg2kR6uqtstEVergaZF96NjrtNWv680mEBFlNR6/KotoMA8MdqNfAJ8oox0P7b79uKkzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZQyrFc5IDFViAS/U7PqSjm6lo0EAPfDa54XVBjW8yI=;
 b=oDVZCr1xma+1ghU0Upp3C7tQUzQDQTKwdELxq1eH4/xxQ1QG0fLu+Y2/nfTn+gbOLpticx4NDsZxaWrHzrNrVoJCxhFj9FFi5JMCO58nkxdd4XIhdnKfZRNA+YZMf8UwiSq7kTDW0uwQeXMA1fSSOgQgamJcKXKjPPf2icTGh77yOxig2S3a5Fvx8YHe3F368136XczjAAkf9UZrxa7RD/xiW/oMxhZvdUV7WXQt8V6iU04gXcHuabFGG/ISs1khFsoiZhGQ3dSfHdAMJkfm8EYFdCqZeG2K8MYqrT+laDRCPtN6JEupOirdHh8p/4fKSPs7qSe5xGjhAwODmgObpw==
Received: from MW4PR03CA0170.namprd03.prod.outlook.com (2603:10b6:303:8d::25)
 by MN2PR12MB3871.namprd12.prod.outlook.com (2603:10b6:208:16a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 4 May
 2021 17:22:04 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::6d) by MW4PR03CA0170.outlook.office365.com
 (2603:10b6:303:8d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.28 via Frontend
 Transport; Tue, 4 May 2021 17:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Tue, 4 May 2021 17:22:03 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 4 May
 2021 10:22:03 -0700
Received: from vidyas-desktop.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 4 May 2021 17:22:00 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH] PCI: tegra: Fix host initialization during resume
Date:   Tue, 4 May 2021 22:51:57 +0530
Message-ID: <20210504172157.29712-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b92a2ed7-2a3e-42a5-4472-08d90f2122b8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3871:
X-Microsoft-Antispam-PRVS: <MN2PR12MB38710C79AF4F81173E709F11B85A9@MN2PR12MB3871.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IRaqGlRRaeXbCjyef9qBwHScjZAwEwI8ZELPtZG3DvLQdqgu1qpHurqIt6xU/GoiM5XQzCbus4LvaH5+f476XPMKrvYrFA5vE4Xm6zye6+cZHaVhG5aA5cGN0JVycqm7B0om4qq9FFz+TIq2VW7t0nQxF3uh5SpHHwIaha2+mJaBXQuoKAIm/wcjMVxAUffcweBbr/Q541E6h1liiA7dAjDOFWupjd1L69X7iFYcwMeGDmEASL6BB30Y9dE+3KOPrGHM/BzeeKBx4nNhiyTAhJ2L30JAND3xSwAHMuyQynbc1S2vi9DT8fraCjTkFizSLXZ7lVS6nHTWD476HhwPUWwnEAwSmxPTvKA/0yutOdVd1QpIICHN1wnz1YLD63ID8n61aFhZ0r0aQ8ztKLoka7lQE/Lh36A0UmB1y/DdO4bAxuyhF5vojRR4bD6xFfhXHizhdLPN+XEHfZhZ6e+UWANk9wjLzxp4T4LuJjBxvGxK1lhkZSClhIGhbWoYr2DkFuZDMRjB5Zzl6Wkmzon1jZqHxe0VufUYnk8FRzpV0PSREEyTQrj1JRnEYPW3ZMAjOjHNMV260smsawJQvLPa0X6iQDw2XBVgZUI6ucMj5sryMc/A0aGWjFD9hbhlnAqAhZ+TbXDfOuRMpUxlolhwZLA0n/R3SKZbnnIL/HSv25Ch3VYghgYNTZaQWn5IxwVl
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39850400004)(46966006)(36840700001)(110136005)(7696005)(2616005)(36756003)(6666004)(86362001)(36860700001)(26005)(478600001)(54906003)(336012)(8936002)(426003)(1076003)(5660300002)(4326008)(316002)(47076005)(8676002)(4744005)(186003)(82310400003)(70586007)(70206006)(7636003)(2906002)(82740400003)(7416002)(356005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 17:22:03.9385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b92a2ed7-2a3e-42a5-4472-08d90f2122b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3871
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 275e88b06a27 ("PCI: tegra: Fix host link initialization") broke
host initialization during resume as it misses out calling the API
dw_pcie_setup_rc() which is required for host and MSI initialization.

Fixes: 275e88b06a27 ("PCI: tegra: Fix host link initialization")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 6fa216e52d14..4c3c0738f2e6 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2214,6 +2214,8 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
 		goto fail_host_init;
 	}
 
+	dw_pcie_setup_rc(&pcie->pci.pp);
+
 	ret = tegra_pcie_dw_start_link(&pcie->pci);
 	if (ret < 0)
 		goto fail_host_init;
-- 
2.17.1

