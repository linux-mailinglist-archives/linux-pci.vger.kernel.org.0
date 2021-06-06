Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E90539CE0F
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jun 2021 10:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhFFIY1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Jun 2021 04:24:27 -0400
Received: from mail-bn8nam12on2065.outbound.protection.outlook.com ([40.107.237.65]:20225
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230258AbhFFIYZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Jun 2021 04:24:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaqvHSULCbxTAY/tqrEK6QgroFDOp8HnPc8aKlzGg/o6z1KDTHH+t3ZkYVE5C1ZXL3OVEpU2UMOXkq7TFSmNjRLzQeG7DnUabA2lHUD3AYGjHQNcCStaBS4xVaJ4nzbVHJzE6cuNlJxBKoI5oESHn1KTznsnD/YDxfO3fC27O9cL+C7MeaTugNl0xkV9yoLQgbnio5dz/qkaptfh71rRfc06oIaDi/m1/DLgxQQuLRy/M9ugl/8WmuR8cLCz9Wlu35dyd/6bWGWWFpz1NwaJSEq3NzKPzBZV/VZ+mgUetwAxlTllSYbtaFwHv9Q1tPqJCQIwoDrxVs047hXp6b2oaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJgCjHplD4sKyrbnRleMAJ9aHePNdb0ecqQ4e4Of9Xc=;
 b=hNp+WO/69dZTvbCp5kv1ouPNAoLbPqgEBBFrjnfP0u6mkS7+yY+HooufVWEzlX6qcjvX9BnxalOBZSnuxRM1+eozK1q8TCKYyJaab21Lm+aC1wstQm0AjR07EUbI08WY7JUmUhjHqfjfOem6yJ0nImZTlZEwqwm6VS1utAe0NyAqOFk+FKM+ax4+HfySMX5bRZMzQYl3y2MhBCGKwgOwpDfNprbrtE7tyTttwxQvAkXHeNITE4ishiDyv+2Lulb05Sf7MAnsn0C4ZOvCNIBlLwXTGi1J/ucpEuvdYf90w44eO/9tFmBV9CaosuXPucwfcwjtfrdJSaRYtCXCcsZlKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJgCjHplD4sKyrbnRleMAJ9aHePNdb0ecqQ4e4Of9Xc=;
 b=YgFZGihnoDR+1S9UWJOQ59MsEZtSQibwTbFzhdUyQ764gMJzy620w9+VODt6gi8R27yMbrd+Wxx7Ec3pG6M3GJoJD/j1QymyjZLAEu48RIkxMkch0csTAEmMvSHRotKPy6R9pZCD3pMmVG/RJHpyREbD3nLYXYw46dd5cCMEbslQPXquMKChe7Gp2SpG54miqgiu78oi1FQyBfFoN9Ri5gIPesPOQ2uB+TApUQZ+WQYzYpQMSBa5kwzN6IB7RzTYCxuUQyQlENpN93RJnIpskOMlv/HhFXKOAu7v1JmWfi0pQzZGpDbik5hvCZYL6pF8LQcdk8PXG7JvhR5bmxNEwQ==
Received: from MWHPR21CA0049.namprd21.prod.outlook.com (2603:10b6:300:db::11)
 by BN6PR12MB1442.namprd12.prod.outlook.com (2603:10b6:405:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.26; Sun, 6 Jun
 2021 08:22:35 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::e4) by MWHPR21CA0049.outlook.office365.com
 (2603:10b6:300:db::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.4 via Frontend
 Transport; Sun, 6 Jun 2021 08:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Sun, 6 Jun 2021 08:22:34 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 6 Jun
 2021 08:22:34 +0000
Received: from buildserver-hdc-comms.nvidia.com (172.20.187.5) by
 mail.nvidia.com (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Sun, 6 Jun 2021 08:22:30 +0000
From:   Om Prakash Singh <omp@nvidia.com>
To:     <kw@linux.com>, <helgaas@kernel.org>, <vidyas@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [PATCH V2 4/5] PCI: tegra: Don't allow suspend when Tegra PCIe is in EP mode
Date:   Sun, 6 Jun 2021 13:52:03 +0530
Message-ID: <20210606082204.14222-5-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210606082204.14222-1-omp@nvidia.com>
References: <20210606082204.14222-1-omp@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9fd0506-24ca-4fb8-e241-08d928c43cc2
X-MS-TrafficTypeDiagnostic: BN6PR12MB1442:
X-Microsoft-Antispam-PRVS: <BN6PR12MB144229939874987760D0FCDADA399@BN6PR12MB1442.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DzxyfjBVsN8dZRmoMZM1eShbuzTqvjWm8bVw6MVDbc/aFipP4/z0hjhjjiPrCkHpl8wYO4nte3CCTMEVaaTNh8rknqTBYl3as5nOnmmYJ9sy76XeF00CvrQEYzAjC5GtDMjaSvwsegD9g9QYQnQAiQO10PKcHPSiKL5Gx8YB30vQWTx0AN4xow4zsO62JJ4RdgRwiTHBH7zRxYzgB19H91rNAq9eXiAFDuIr/ByVfXJSSjULqPDCnrBalWklEtb8trozZFKpzTtKustWDtZltQtkiWQzsRxG/KU7SH4if+55uYaMpUShHzeb9Ci8ziIGbV6nAfTvk4qnWP7hsH0+aeRrIwm51q38NpbhC81iihYxQh+MGN3fR8AqEXP10EaJuyxXUbB6Kq2L3sor/O6vDEqX1kv+aWavpoGKhi5r2CMU30Ra81f+HmBzTc1iQvjBdNBfnchhIiaGLYPeRMuKxYvCWOvAzuZ9Egx3f46RL8F0GO7FEpr85nccA81DUp1vcxY50tOq6QeupfQ+QHepy6bdzGuVTmkAOUWbAckHXqgm5RTMMn8/ik9mlipTDnFYI8A/tZPkWJuPCayd0HGVMQ5a3hYwrElc2id6NbB1BtyprgFU8yk0H3H8OEAboTjRqoGUN7qLVRdxP7beZPcr7w==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(36840700001)(46966006)(82740400003)(1076003)(107886003)(4326008)(36860700001)(82310400003)(2906002)(4744005)(83380400001)(426003)(336012)(47076005)(86362001)(15650500001)(8676002)(6666004)(70206006)(478600001)(7696005)(110136005)(186003)(36756003)(26005)(54906003)(36906005)(316002)(8936002)(5660300002)(6636002)(70586007)(356005)(7636003)(2616005)(66574015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 08:22:34.5113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fd0506-24ca-4fb8-e241-08d928c43cc2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1442
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When Tegra PCIe is in endpoint mode it should be available for root port.
PCIe link up by root port fails if it is in suspend state. So, don't allow
Tegra to suspend when endpoint mode is enabled.

Signed-off-by: Om Prakash Singh <omp@nvidia.com>
---

Changes in V2:
	- Update return value and error log as per comment from Krzysztof Wilczyński

 drivers/pci/controller/dwc/pcie-tegra194.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 64ec0da31b5b..ae4c0a29818d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2276,6 +2276,11 @@ static int tegra_pcie_dw_suspend_late(struct device *dev)
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 	u32 val;
 
+	if (pcie->mode == DW_PCIE_EP_TYPE) {
+		dev_err(dev, "Suspend is not supported in EP mode");
+		return -ENOTSUPP;
+	}
+
 	if (!pcie->link_state)
 		return 0;
 
-- 
2.17.1

