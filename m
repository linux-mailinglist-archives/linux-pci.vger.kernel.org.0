Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F44392D39
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 13:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbhE0Lyk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 07:54:40 -0400
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com ([40.107.244.72]:6784
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234430AbhE0Lyi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 07:54:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYSUoJ9h3avMQ/SRfE4rr73XT7AY11mvf3znG08XoFJ5pky2UhKPQmuubb6XUxIo8U7xyD16z0O9PTLy6eCuWpIPSEVBzd+sd4afkmly328dblXa16IbXwwpz/aeG0bwcAJ3VTjd6ydDkgEX5ebrx4f98wTx3uwiqmIGaftm7fH1fNv6fjfPoKTnTZ9Qp4CTxloOjQ3+lXhI6b/Ml3sDnQbbko9GJ+Om3WCmy5RjFyO7uJsTuiWNOgCYeqXEqeW1iEJNYC6+u2EfQxbXTRDo2ZoWyI8MsCZEutJZP0O0B52gi3w10EtDU3x0IPJ7kvMgfSggClqykxbWnp+qZnLrcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poBoznlKclT7OVyqjX+EPspeaHTBbocMQsmvW4nROls=;
 b=nivNTuuAKf7JtODZh7xUWKhERgJDcRUQ2o1QsGOREKqWHi+sZ8QYpoZ9GrGZp0zcHjBhh6sj5YdRb+pUE2JtDEGN8j3ZfJTCn2KliwFx/p3yOPrYz62zpBOOgtxe6nL37NDxL6KbAVXIvs9DWPaun9imy79azh095t3N4d3ZEB3th0IUry+8DvLB+fFKwTr3StnoO/435bNSASPEIp3cWcCZVRMjuIEMIJ84ezewEmClrMfG63aOpMjwuXyy1yAltdXGm0NZs0uqHwWL68IuH8txQRgi3dA3mBJH1dI1CDNWfOZkipiIVngRqasz28yEOA49aIo9bibpudfAHzxhtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poBoznlKclT7OVyqjX+EPspeaHTBbocMQsmvW4nROls=;
 b=DPUtwxTMbOrWe1m7G35gWQ55VbWdpPDyyxiArSNLJU2WZcGJS8BAqzAw+qn2f/dS+Gu91E2D1u+9KhN2w/KKWdYq+xmI3fWk+ld8hLR9JH29y2ehgtIl/l7z6jJvP49h4Ksej5pDfpipii98HaOjmp44LuWOfbpmuGQrqnZ7w1dZM5cdM0Ic/3egI9XQwfJPQT/Pwzb5htv/nKXYXLyfkxTfUsQtRAmUYbpf6LTIlYmjfQgtyroP3E7anC07BkcGZ4+DxvtTkVrKaSX2CjWjgw4SFQuppJEkWfKSehYGTOWCUz4L4oLbN6dRFLxh+f0NKx289cGpXfxZxoS74wUQfg==
Received: from DM5PR18CA0080.namprd18.prod.outlook.com (2603:10b6:3:3::18) by
 DM6PR12MB3737.namprd12.prod.outlook.com (2603:10b6:5:1c5::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.26; Thu, 27 May 2021 11:53:04 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::3a) by DM5PR18CA0080.outlook.office365.com
 (2603:10b6:3:3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 11:53:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 11:53:04 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 11:53:02 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 11:53:02 +0000
Received: from buildserver-hdc-comms.nvidia.com (172.20.145.6) by
 mail.nvidia.com (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 27 May 2021 04:52:58 -0700
From:   Om Prakash Singh <omp@nvidia.com>
To:     <vidyas@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [RESEND PATCH V1 2/5] PCI: tegra: Fix MSI-X programming
Date:   Thu, 27 May 2021 17:22:43 +0530
Message-ID: <20210527115246.20509-3-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527115246.20509-1-omp@nvidia.com>
References: <20210527115246.20509-1-omp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9fd129b-e75e-4a28-1651-08d92105fc58
X-MS-TrafficTypeDiagnostic: DM6PR12MB3737:
X-Microsoft-Antispam-PRVS: <DM6PR12MB373793305A0BCF078EB70101DA239@DM6PR12MB3737.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:327;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xegRNsU5lPTsdmjOJLZHSFcPY/CIK1jQnhmGdcD41eizudW3GLeJeJZ2WMN43HjgARGrlUvO9dUGfpdJWy7o5C5rYirJ1wAH6h0DxQFZ630aiV+znYvwxHF9OY0zK8YQR8o0GBwDkb2oCQaFiVm2ghQHK0plDtZwB6T35kYe28/foURs/n7KOyCvf6DHAFy0NK54OIGuwSib8rLnF8NixXCsAfh90THaVFJt/wVGwqWmwtLhSB1c+DEtZ2PTtk2CWzL5wBYVln6uMfoy86mkJIITV6eF/otKABcei0jMutEjn4r4GINMryecr5FOSojiGNx2nV3w6bVNxFPv43IkQWIkRY2yYryWzuM5YlCBNpQKCV0cfRijhbfFACNn1/IN051hZaGnst5uu95eSxDUOPePgJV5TkHHbkgtULNHtltkpOMYGv4LSQ1cKuKG1LBcsqHjRT0At30e+TCgqSTIbZsBt3ovWEgzTXSV5kuFMpTQeSkuJTR9AuRkoQpvLCvUgOuhLGChpqgVoCxWQruVKlbw/m6k54h9XthU2f91eu0SuBAdnBAkeKT2q3VRpq03kZs2ViBTgsPSLPPJ9aXO5jqY4l+bx6fUTMgZqt5X/6QUT9kzRf/nZswPd52SHwf/1mwX7Lx4NS3PJwEtlpQrDP+17hkSYCO+x7T2P20Erus=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(46966006)(36840700001)(186003)(26005)(54906003)(336012)(2616005)(47076005)(1076003)(316002)(36906005)(478600001)(110136005)(426003)(5660300002)(8936002)(107886003)(7696005)(82310400003)(82740400003)(86362001)(83380400001)(8676002)(356005)(4326008)(36860700001)(36756003)(70586007)(2906002)(6636002)(7636003)(70206006)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 11:53:04.0710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fd129b-e75e-4a28-1651-08d92105fc58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3737
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

