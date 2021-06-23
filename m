Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8EF3B17B4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 12:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhFWKIB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 06:08:01 -0400
Received: from mail-bn1nam07on2053.outbound.protection.outlook.com ([40.107.212.53]:58970
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230161AbhFWKIA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jun 2021 06:08:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNzaTxzFdfnnO9r5xRGWv4QAjHBOibMmMmXMa3Cuh6s2Ukf0pcYcwTXFOaKdFuyVXjeHyPCZTKw6sADgx0AaIhMGlO2aOrgGs6pMkdZwLIt4ImzefJSUAwSrlK8AoTys8v99c3zoqFab2jQkUqvLtCtZZfY75hSQs3nib712yDG1I0/q+cQbKEsFSI2sa4TvMDRtgjFZ+Au4G1ylC2Db/MQxrvSAcho3tgjKqCHoMWZVDPjcYSA76TtOxmajAmw/jqipEh2RvF3lm0qNri5L6IUEXxG0i4JYjskAVfCogHRt5Ilhgh4TAJ5Vb8Ekc4E0ux/gV9v1/E/sR44XhzEcbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xazu/TsVsCTn8lL338bBSD847Z1w1P6HYqCczQ3CoWI=;
 b=l35cLTb+86K21caDaFAnGt5Nxt2d0Y2xhGXEPfoUlLiH0wLg6TDEe+4i5EPRGEu05+KTBvlFCv5Lohlc8nVMxrgxXWkI8nuWuI011UhhbqLZyCRwsRa+WriLTlO4R+tX5ViSKXQZytNVRCaVzzlovWd9JaRvxIzzJxe9agS3NtKEKNaZxrucJjONbmrikdptoUcCv0HxYfLw0wWUJn9khdBfoPzBZKAAL/M3yqz2iawKsENk091lC0nSedzYUPOosS0xF6z+5AhE01WWPHRxO6EIrMbKghtFO+cWjBJYNRO9+UgXP1EbiWOJiv2KaIoWJYpRQ1hSENsYFVT2mFWuww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xazu/TsVsCTn8lL338bBSD847Z1w1P6HYqCczQ3CoWI=;
 b=G5npGtGwEXFsImJEvAbrht5upE43BWHTwGRaNOojze+lusOp0Ueg2IGzZIgIaF3uz88dkYrEdiZIyico/TBaZVFR1TN9cI1bzra3OPmQ7/TVp7GZMewsVSWER1k17Oe5i2jSCw2+cGmQujmLQoWWje0Nbz4oQ4JEgN+meoA5upJRXnUREsWuMTLoIsuubG4RgQwUYaz0ohpWfIw1UjybLRTsjK00qYabtP0u0WW/qQmH1V4uRuJQIJOHK7IZy+6N1NXC0X0us5qtJ0de6R9k8gcBEakohv/GtBWMJqvZamniiQ2y3g4Q7+SYnwL26rSRU5xEuWyy2W6JA2rr4xUkjA==
Received: from MWHPR08CA0059.namprd08.prod.outlook.com (2603:10b6:300:c0::33)
 by BY5PR12MB3825.namprd12.prod.outlook.com (2603:10b6:a03:1a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Wed, 23 Jun
 2021 10:05:41 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::8) by MWHPR08CA0059.outlook.office365.com
 (2603:10b6:300:c0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Wed, 23 Jun 2021 10:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 10:05:40 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Jun
 2021 10:05:40 +0000
Received: from buildserver-hdc-comms.nvidia.com (172.20.187.5) by
 mail.nvidia.com (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Wed, 23 Jun 2021 10:05:36 +0000
From:   Om Prakash Singh <omp@nvidia.com>
To:     <kw@linux.com>, <helgaas@kernel.org>, <vidyas@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [PATCH V3 2/5] PCI: tegra194: Fix MSI-X programming
Date:   Wed, 23 Jun 2021 15:35:22 +0530
Message-ID: <20210623100525.19944-3-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210623100525.19944-1-omp@nvidia.com>
References: <20210623100525.19944-1-omp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05a13b50-208a-46a3-2d96-08d9362e750f
X-MS-TrafficTypeDiagnostic: BY5PR12MB3825:
X-Microsoft-Antispam-PRVS: <BY5PR12MB382578E81B94EA89F7D9D862DA089@BY5PR12MB3825.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:327;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: es80HArPhAJkxHW4dXTXGfOwnGcsHJxfFfcChbob2ZA+IftmDLciAZFahY1TMedI9pk9GG34LOIyhQwe5Ymbjb2kshec7eL/naKabwR8zinb9PozGsK4nXfSEAGGoFqCemG1evVyhZBV0fp0gh5xHVui9v6hv7wdc6ciUMljP1292aXnshVm/lUn0q6hbXBvp+R1PNz/s/NyDsLCPzmIO7CI7HJgNFUwiW7IEm+4/6bMPxn07qHBRVOInPuKkXkzSSh/cttoLIiO1XRIH0nuaNeaM1WRQ3TJcHhs5G2+VLsafWW2Yf/NYfAyPRtRau3nHIMT622KzdxE1LuVThHj7hsix4quKeLBU+fdDPgDKzp0RJr9Y3JwkB6fir6vPLsJQyatMBEdWYvoKb4leOD+nvbU6T57JFgjkNOQufYpJeBG3d4hJpxmJAoNVxQo7pmuLRWfRWaD4H0xRg3wd6vCc51gI6katzs0bJd/X0K/elErc0tfVGjDsNZ9pmKI5I+3bO4P/W5nBUvBJ/SgyluN8LA96b3lyrQS5Me+P5JtIb+GSFM+oZa3OyDhBHlvnqaeDXObh2enekGwxqQP2YKU77Njypp40TDe9W3As2yNGHO9K5fhFTUUAvhlr0+Z4ojycOK06XX4TjTjzEHVrKgtmjuUkkjyVVXhjp58kyQU6II=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(36840700001)(46966006)(7636003)(8936002)(7696005)(356005)(8676002)(83380400001)(36860700001)(110136005)(82740400003)(316002)(26005)(82310400003)(186003)(6636002)(47076005)(2906002)(36906005)(1076003)(426003)(2616005)(70206006)(70586007)(6666004)(86362001)(54906003)(478600001)(4326008)(36756003)(5660300002)(107886003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 10:05:40.8820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a13b50-208a-46a3-2d96-08d9362e750f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3825
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lower order MSI-X address is programmed in MSIX_ADDR_MATCH_HIGH_OFF
DBI register instead of higher order address. This patch fixes this
programming mistake.

Signed-off-by: Om Prakash Singh <omp@nvidia.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 6f388523bffe..66e00b276cd3 100644
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

