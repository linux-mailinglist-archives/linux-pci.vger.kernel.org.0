Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6420D392D40
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 13:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhE0Lyu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 07:54:50 -0400
Received: from mail-dm6nam10on2062.outbound.protection.outlook.com ([40.107.93.62]:44033
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233633AbhE0Lyo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 07:54:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2R/TgS7P3MErFhaNsohAb1UziqmuEc5A6CcBPCKg0evYHqO5xFEHPsenQPJbrqgvncx8zIQWEICdi0VKeyU5pGxidtz3hAUY4/Q6D4xVkUqv62TEnMJkoOrDTUBODId9pRW8ebbPrUP0rlQxM3bqMZ4zwW+JayXk7AbvxTfwgtzEw0Cxv0Y8FZIGHwnWToV7gxciZiEVQLQianU84146mjkiT3mGq/rVsas9JvDqh0wEt12Axn025T7ivcJXTE15akL/Px6OrcaRZFhBcLw+yvJMjsXkRSFWmmeWUUuSbC/VlxB7SvHSKZv5LlT10UojvSu0RgxhU0lEGQMeLIQaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O64TNUwAJmcUqqRZwQ31dHJT+11KJwMxMW/87E1xnQ=;
 b=i5anVD69ICnK2SlG81URVLo0/7fYXBrGEam7KS8kG8afAlZiw6pIRZw1ITWw8SJPd7F8bo5qvEcBQXWpPttoA+t5cmwspUTLtCG9EuQ06wKeaENViCvSc1jUjJ7dvXdF/Nd+AkhMj24ZPJryaT9I7WncDFVCLe3tMAxkzYUTGaWtL81JhZsbJbPgRF1Xr1eKen8GNt7APs09a3AC9pMDN/IVEnBWHhmaVRwrS3prOiF8SvLYOcE/2R1Fded3eauwegDHzXzQKCwiAHSl33A+bPxTktGHsFWaPE/lKn+lcmHzTRFASH58OzEALcS34uVSXRJ94L2zUuiXyIgWk7zrAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O64TNUwAJmcUqqRZwQ31dHJT+11KJwMxMW/87E1xnQ=;
 b=hveRruq+qrc2bM3IwRWRYDI1siniQ9cntcMXZDmmO3teO9a1eH6+6Mfqd+NpWBr4kTGcmS7MnUYj/jsVAV8PHV4s9SMm/Es6g9FeKehCEwteTJLiR+ZO0VijkTSscnMBNrmb1Z84Vb017i59JwWHy4rF62z+z2u7NaePLL62lHVw8hrQExpJhC/IPVT0HI6J81wigJgLpz4IQYPNNDNghw4B6fE+2YNTtXUzvCEEWP58QZ8PVcAYT6eTFCF2WvnhUxbMXD0EU3sMnbWUwsi/DwDaHgbrRe8WA5+7KABzbbZ9LHFmSQchM2uJUvL+Z/wBF7kq9LNOvciDufGcPT9QBA==
Received: from MW4PR04CA0156.namprd04.prod.outlook.com (2603:10b6:303:85::11)
 by BN6PR1201MB2531.namprd12.prod.outlook.com (2603:10b6:404:b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 11:53:10 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::e6) by MW4PR04CA0156.outlook.office365.com
 (2603:10b6:303:85::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 11:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 11:53:10 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 04:53:09 -0700
Received: from buildserver-hdc-comms.nvidia.com (172.20.145.6) by
 mail.nvidia.com (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 27 May 2021 04:53:06 -0700
From:   Om Prakash Singh <omp@nvidia.com>
To:     <vidyas@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [RESEND PATCH V1 4/5] PCI: tegra: Don't allow suspend when Tegra PCIe is in EP mode
Date:   Thu, 27 May 2021 17:22:45 +0530
Message-ID: <20210527115246.20509-5-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527115246.20509-1-omp@nvidia.com>
References: <20210527115246.20509-1-omp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8c38a60-a37d-4b12-2f36-08d92105ffed
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2531:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB25312E75A0EA7A3C163368E5DA239@BN6PR1201MB2531.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xbR3jKf2zHLT9MCt5TQ+M+cKXXptzC+6itAs6dI7jwJOLCznwhaC5JmLWSDY0wJjCywC4MOcBCXGwx9EL4/qqM4VG1MRQTeeLixzJNhK3X8OtosCLSSTfmUcYzf9QoIyfgps8dStjtB1kvma7agEAKHe8RyPSZHGFk7ThpStoRKqFgDXq/vbiAeJ+2jMS1z2qclguHTZxZxJhxLA0YPrZhcDTSwyS1+6vd3eRyiy9DmyCS7qGrv0YQelRBRjVlOyV95C8HuoSRlRRxgUgeNVx2ZpV1IgT36X+u6GS6pDzef73efK1b71f86dWxMBouzuC8KZZE06VTWvZbKdwSjOoVuwWS0td6Ljw3gOx7y1kU70+MiqlbbE5FqeFTaU/BzVzzvSqeS/vel+96vSFiGRh+EfoFWlitYdsQrANrBDxDWVnBF9ha++Nx0ilj3EvKGMd9rJu6qu3gYSGY8nU12tHmiffjwJWGs+EslN93ObAN3yRPnbL3Q6CmwtsdHrFODCwLtqrA0GEC724eeqBxO7FBncXmRMSmRHIdGQ0tv00UNXJugNIGhVUjivXJigYqIuXTCpAzpDluDvOMiRpLnGOhAwAaaISQ/lS1h4wwi/JOnqOeIjnRhkVRc0A5OZemy1JJWdOzVXeUtbIVgumgSmUA==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(36840700001)(46966006)(107886003)(2616005)(70206006)(26005)(6666004)(316002)(1076003)(70586007)(82740400003)(356005)(36860700001)(8676002)(86362001)(110136005)(8936002)(54906003)(83380400001)(4326008)(5660300002)(478600001)(82310400003)(6636002)(2906002)(15650500001)(336012)(186003)(47076005)(4744005)(36756003)(7636003)(7696005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 11:53:10.0833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c38a60-a37d-4b12-2f36-08d92105ffed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2531
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

