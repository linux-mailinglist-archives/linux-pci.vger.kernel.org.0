Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BAA3928D8
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 09:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhE0HsY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 03:48:24 -0400
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com ([40.107.92.55]:63809
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235130AbhE0HsV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 03:48:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJCmHXu0u1+Mstm47DjW+rvGEA1Q2fABQYk+yV54fNfPTPKqJPbnsusN0I6qN++76FD6MhA/VmvjWHDsmsy+8w3JHbeQKQK+4ohFAGdW9WCkEgmLQnXs8q+52zVZDwjUvdR79taTe4tdB/OXfo2Uqn/IqJ0hmZXfKA0MOxXa1jo57MF5yEzHnf6I1D4HMVJasSfrGoGXMlo6T43PXneSyJkuhPs42NYJ9nZ+u7K1ZgShpidcLiS/XCjYdgksRa3coJAGRwmcv6F8v49gIIueJkkNkuqmr+EbhstaShlrw3BxQE/V09+OWqz4lqEP3FVBEmROn9xl3l8ABIUg3OLoVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poBoznlKclT7OVyqjX+EPspeaHTBbocMQsmvW4nROls=;
 b=Gii0qzGli49wUFpsAJysPyungNucOqpVy6jhWcB/eE19dm0SFzv7o5U8yHZCU5SZq2efwN2fK+ENIg1/Mt0g4W6mLq7ET2guPCG0Xg4H1SMBqWaB6aKFHc167ytMfRd1s0+dTxKS620C3mYaeBaloh2D/tS3H+DoEKA6PQS5VtfK1Y0/NNhSG6m5Q4umL4g44zAtL9YXgs57J4DxAqFXZonjJQldBAooKZfKhGALdic03ITF7DK6ryuPFSNQ0hYX3lxm87uztcEPBEvcD5/o0VLmXDUVyJc7M2AH/B0iBQzvLYRyE/F7E3IB72QadWrpWZ56wnYcohC2SJrCFQWp3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poBoznlKclT7OVyqjX+EPspeaHTBbocMQsmvW4nROls=;
 b=UEq0eOHKKJxqLvCQJap2KRVQvL/56q1yy7R/HJG9jAr5p0k9Yo+kq8O6JxuBcFInoD+NWQZlxD1oQsXODPk1kHhQ7l7sm/L74D6FnHWNwCYqy8CgmIgNEqNA+XemyCJuE5RKS9QRYVCRRUKj6djWumX45BzDTa6Hoxngkq2Bn+AL7Kc+LeLT1zRpRq0Jyl7wLEBxFgVkMc6eJSp93nAnakRg/d81oBflA4M0wbol+EKD9vGonYJCEk6nCwNvad4hNcCu3sop5ULigw+9vC+Qz5HopJxBQU5aucEER2nAMdXinH52E0VMhJZNgJiFYBaFdoFIzPj9vyUIHtinLRxbYQ==
Received: from BN6PR13CA0015.namprd13.prod.outlook.com (2603:10b6:404:10a::25)
 by BL0PR12MB4738.namprd12.prod.outlook.com (2603:10b6:208:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Thu, 27 May
 2021 07:46:47 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::a9) by BN6PR13CA0015.outlook.office365.com
 (2603:10b6:404:10a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.10 via Frontend
 Transport; Thu, 27 May 2021 07:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 07:46:47 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 00:46:46 -0700
Received: from buildserver-hdc-comms.nvidia.com (172.20.145.6) by
 mail.nvidia.com (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 27 May 2021 00:46:43 -0700
From:   Om Prakash Singh <omp@nvidia.com>
To:     <vidyas@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [PATCH V1 2/5] PCI: tegra: Fix MSI-X programming
Date:   Thu, 27 May 2021 13:16:11 +0530
Message-ID: <20210527074614.49149-5-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527074614.49149-1-omp@nvidia.com>
References: <20210527074614.49149-1-omp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f6f8462-ed7c-4656-ab1c-08d920e394de
X-MS-TrafficTypeDiagnostic: BL0PR12MB4738:
X-Microsoft-Antispam-PRVS: <BL0PR12MB47383B1A99D9099799E606D9DA239@BL0PR12MB4738.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:327;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ng6QvcrFzASh9ry811dcMnG/VodXYOb3bQ6KMYy8M6SDr2iFlr/mNOrT5sb821cNTYU6UxGp269oublz2qaiBDv0BZTyyOtn+y5X7GfvOBihdffQOmGm7EdlIuIVBSr4XwBcLrkdNB2teExX+EvnIb9PQwCTQNqmt+2KU8myp3zMvu8Fm7hKM7uoX/MA7FREatYQOTHK4aXvY0OlHDJZe1DkDt8BzMCgtNyoyCG92h5YyS2n5YO2nta5DjXxeJ+OZYhXF4bng6F6KseET9vi2frdz58ge3st+qqAU+3ISGVDU4Eu+4a++NTSjJAg3miIk8OVHHar9AQ5xA6TNKxU9apkfd1EVU0EXnMfYMuO0bWwh9JIFxY8rOqfTq8mXf/1DHh5wi2FnZyntPQGeEQvmJz/Z+23RK6wakJ5y+lcnQzuKRNQbFyScdzy6+vu0V5XtttmZHhnUTn5tNnSbvNQuSqofU7Wem8qiqyDAPVxbz5kY6zb0q9pLSkAhO2RIXH6E6bNS7L9bOSXCR55UOEhdeNwD38Hc+FQlEVDK9LN0gZDHEmo3VIV5KLwEfYb5XpMFbEN4wqDCwWrwRJIEwJASxJD1+CWo1X8dwKFSS+K7p1HG4wdAft7ZMEME8mgg9pgjh+5/nUkDvV3/SwH6s2mvc55LOOVMshRJJ67OJ/zERM=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(36840700001)(46966006)(7696005)(478600001)(82740400003)(186003)(6666004)(6636002)(5660300002)(356005)(83380400001)(47076005)(8936002)(36860700001)(8676002)(26005)(36756003)(7636003)(2616005)(86362001)(336012)(70586007)(82310400003)(1076003)(4326008)(2906002)(70206006)(110136005)(316002)(426003)(54906003)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 07:46:47.5052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6f8462-ed7c-4656-ab1c-08d920e394de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4738
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lower order MSI-X address is programmed in MSIX_ADDR_MATCH_HIGH_OFF
DBI register instead of higher order address. This patch fixes this
programming mistake.

Signed-off-by: Om Prakash Singh <omp@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index c51d666c9d87..58fc2615014d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1863,7 +1863,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);
 	val |= MSIX_ADDR_MATCH_LOW_OFF_EN;
 	dw_pcie_writel_dbi(pci, MSIX_ADDR_MATCH_LOW_OFF, val);
-	val = (lower_32_bits(ep->msi_mem_phys) & MSIX_ADDR_MATCH_HIGH_OFF_MASK);
+	val = (upper_32_bits(ep->msi_mem_phys) & MSIX_ADDR_MATCH_HIGH_OFF_MASK);
 	dw_pcie_writel_dbi(pci, MSIX_ADDR_MATCH_HIGH_OFF, val);
 
 	ret = dw_pcie_ep_init_complete(ep);
-- 
2.17.1

