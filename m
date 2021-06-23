Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBC53B17BD
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 12:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhFWKIL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 06:08:11 -0400
Received: from mail-bn7nam10on2071.outbound.protection.outlook.com ([40.107.92.71]:62336
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230481AbhFWKII (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jun 2021 06:08:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZLeu7biowDCd2YO3I8du3wKoH9cmFN1vw2x+WeWdxD7MindzZNzfbnTrzqHBPbQv6RlHjIsLEbKxCB7k2nXt4jJ7g+M9AuWiNHjSLO3IaTGLuKvtxRf5L7pfoMVoP4nh/ARFLG8z9UU76z+TZQrfTwp7uczYkpefXTLsP4lZpeBGzMivypsabBUn8SfsKclkqL8CuoTl1Yz1fIEEXDlscxpOFH8O9NF+Ae4aCuk4/y/V8+L3/iVvekFYoxqLUSWqv26Twwl5QIlANYdjfqhImnLc0f66bw6nPOmkxzGOt6hCZJzsXiBbpn6BIASTXCR0j/Qn3P6+1pkylsXreEuTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COCptJj5XK5qLyk1wEBeGvHE+YTBvOaipsAk9IrfFpE=;
 b=lZKPyT9immc8ci+/m3IAlUpZC5q6ZtSXousd+YgGuWdy6h5i1Tg/V4DJKglYYGwQy9jyToJPoRTLqfJVHe3NFli0m8eN5PJGwGZTZzKIDXeCSascbohtfw5KH0XuBeQzN2/tSUPYAxQx7GJNktIzN+0e37s37Ff2zMiwARkdFISNdDTkOW/rZKRAlL+erc/wTLIAYMVLThl8XFo/ft+d08KslwB8PzdMKfxyt+NM7r51kyUUrxsIVweE6qnh6G3+tScALANGoiflP5bsRwyfzNY8wjCuzPu7OhWlf2g8LvjPHJpwk4PW4vN0hI64PyOOLDrOcoCxC7EbudgE0bFIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COCptJj5XK5qLyk1wEBeGvHE+YTBvOaipsAk9IrfFpE=;
 b=YQgd3RSWhAbp3uTfOla6rTgGvfjT+KNMXqVy5ADc3RCCuoJKen9bpNEX1K6GN5xhxwm0F5JS1Y7+4QgtFDL4BW3tpRu4YQpumzBcOnX+GLyJ35h2aw45rTjiJ9ofOwEZ5xvZw7Qd2wUlhgcg6NdSOlRGcPvrp1JRCuKe3/FBDeU+6lPXVK6sh9Wjw+EDPY7qHRqLEOqPdAO3OOqfUI8+jIgfPd/BC97WrDdIL2lYzYO8stSX4WS2tNUbTMcfBToy9ml5wNo+qTyW/pti0/5VmmqypSxDTesS9Ik79QEA0qjpJITH4nqfUF8B5JEf1fQnSsjm8pZkbg/vnmM5uYB+jQ==
Received: from MW4PR03CA0009.namprd03.prod.outlook.com (2603:10b6:303:8f::14)
 by CH0PR12MB5220.namprd12.prod.outlook.com (2603:10b6:610:d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 10:05:49 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::5f) by MW4PR03CA0009.outlook.office365.com
 (2603:10b6:303:8f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Wed, 23 Jun 2021 10:05:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 10:05:49 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Jun
 2021 10:05:48 +0000
Received: from buildserver-hdc-comms.nvidia.com (172.20.187.5) by
 mail.nvidia.com (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Wed, 23 Jun 2021 10:05:44 +0000
From:   Om Prakash Singh <omp@nvidia.com>
To:     <kw@linux.com>, <helgaas@kernel.org>, <vidyas@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [PATCH V3 4/5] PCI: tegra194: Don't allow suspend when Tegra PCIe is in EP mode
Date:   Wed, 23 Jun 2021 15:35:24 +0530
Message-ID: <20210623100525.19944-5-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210623100525.19944-1-omp@nvidia.com>
References: <20210623100525.19944-1-omp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 533313ef-4666-4a73-7190-08d9362e79f0
X-MS-TrafficTypeDiagnostic: CH0PR12MB5220:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5220E9932F7426EF6373AC87DA089@CH0PR12MB5220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5YbmqWPc4xfmnoQ7AET8Nj0tEz2k7XcllX1833r/s+Dh94m7ABVKmEvwTwcBmpHIQXsLfaLUXMxmNbgXILV7C9d888lTYy3IUYEuEN7hGwggbXicTzgb2vn9Aa+vncq48MsO5HiB7tmqZnlBXNfyM7C9bJsTTs3f5Vw5fIkRl3fWgQN+uKl3WTyAvHmFYvxk4EVdRJXHHPo/r1xXVWcYqWmh6m8tfDy0ogA5yWWY2kppQjbvVEZauyH+ROXZSZtkH0m8NfyQ6AVfPVH+rDLlZslkLg+IGMvSSBgX2oVXtOju/r17S42mH1H3KfoShpgmblb/Y2GpsPRr82cxBG5TxodOJRNm8KB4rAwuDJNUXzabm8eWDebMlJx8bOVbG5pCpQPXrHXmYEfoAMKpBQhI68GHgxliwa5QxEPqRCJOoGShlqjngDczIBdr/MZDa3758XxmCSJ0gI1gFo7MY2uQMJLi4BY0nQq+6fNg68THQ3NnSfe8561exIkZo+YJGdrCCCAHzvZ9d8eLOCUtrdUhgyBXUjBL7LHgGVcDLvv9dRrF4vqNbCvcZWXpzC8xh/ngpETDK/+EbrcWOdQ6Evwh6KTJC0nQvOlX8X2v4tVC7iE2t93A5IUrmOxnNpTiw1P3Rv0WhEL+4byOYazq9uHDhw==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(36840700001)(46966006)(2616005)(426003)(2906002)(82310400003)(478600001)(15650500001)(36756003)(47076005)(336012)(5660300002)(4326008)(1076003)(107886003)(36860700001)(6636002)(83380400001)(36906005)(6666004)(356005)(70206006)(186003)(70586007)(82740400003)(8676002)(8936002)(7636003)(26005)(7696005)(86362001)(110136005)(4744005)(54906003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 10:05:49.1072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 533313ef-4666-4a73-7190-08d9362e79f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5220
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When Tegra PCIe is in endpoint mode it should be available for root port.
PCIe link up by root port fails if it is in suspend state. So, don't allow
Tegra to suspend when endpoint mode is enabled.

Signed-off-by: Om Prakash Singh <omp@nvidia.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Vidya Sagar <vidyas@nvidia.com>
---
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

