Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AB33B17AF
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 12:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFWKHx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 06:07:53 -0400
Received: from mail-bn7nam10on2077.outbound.protection.outlook.com ([40.107.92.77]:36769
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229987AbhFWKHx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jun 2021 06:07:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fb8kDaSt66rrrGbzo3JRjiDouG2OBGNkuzSqNB92i8sZg8bxqrYFjBN1/rraXRC0NHAawz72ahG9psVEUrrCl5i53q9xG5Yq7lzZbtwOEWPDIoW/XQ/w4lX/KFXRt6PWhAUFxX4Lv/bF30/zfvWpIuFRZG6PO+uoDdM0u+ymZ+6n4zkGDqV5GkbBBQXfTSVTTY0rd0QoyikMOlhYnZdCmWPokvDm5WgQDXpOs5amzdPGQtQZxCq5NVcz2+0tEpcGIb+1aWLN8VLnVegQ3OhoMxDrWsHX3RquYkwJAffG4wlkiXTL+Zxi0DkkayNQ1+xbka6iDCxE3m8VeuIa7LqI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6pImG4vCtELS0ZAUsuGJs+LzaWWhdUCT87E2+A45Pc=;
 b=hHcETKpbfj+FZALW/iBr/Eo+e5AV9fZpSAd0+S/1zUpGXM9qa+0y0BzmXaKIW5M8IxHI9nUElsVRM9QB16KHog7l+ePS5d+YEn9Kn3aJguBVsUNW/xQGcmgP6JSIiX52t7DLoCtM6/axzFeGphT99ILLpydHZf/YMGyFIxVsH2g/oUiH9il7Pi77H13jwzhHg3a5pGuApej4f9jeAE5X+80YU7EH29nJCIx/gVWXBafuJrX778/3tQCIJvOOoIXHnFA8PHgiv5r2CuAywaQPWSHmE+BsKEvCChzy/HeYcd1czalpv/p3KD3J24peVN2KEoJFHNby070TWSXqK9Daag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6pImG4vCtELS0ZAUsuGJs+LzaWWhdUCT87E2+A45Pc=;
 b=MQAfoK5Qu5G3wGsIRtFjMmDzK97diIFsjxKSI/nHxLeNSt8KxF9QpBuEIDp6YjmmGzAyqS0qdlRbVzjTDOQ5pXWn0Hq+ERLZb62itxtpQouUylvll1q+22faSe0wxub+0IYot2MTD/4qkjQ0T2AYTEBGZEyBGbw1/uGm4jRlEoe4LCYwlskPBNXkIqeK1UIeaBapBd49vc1bMAz3NaFn+sT3xtNydZBx327Dhh1sXEktPy8cfXALdvTqv8JjXwCN1hwKSwhfRJvPCy8xbguQLHxNsCuIs7pbMWcwN5hos59nh9aQ/YhZvBCdHHbacjQYZ7gGzrBZTNQTJSygtcmcqw==
Received: from MW4PR03CA0104.namprd03.prod.outlook.com (2603:10b6:303:b7::19)
 by MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Wed, 23 Jun
 2021 10:05:34 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::42) by MW4PR03CA0104.outlook.office365.com
 (2603:10b6:303:b7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Wed, 23 Jun 2021 10:05:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 10:05:34 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Jun
 2021 03:05:32 -0700
Received: from buildserver-hdc-comms.nvidia.com (172.20.187.5) by
 mail.nvidia.com (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Wed, 23 Jun 2021 10:05:28 +0000
From:   Om Prakash Singh <omp@nvidia.com>
To:     <kw@linux.com>, <helgaas@kernel.org>, <vidyas@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [PATCH V3 0/5] Update pcie-tegra194 driver
Date:   Wed, 23 Jun 2021 15:35:20 +0530
Message-ID: <20210623100525.19944-1-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bb36415-2543-43eb-c8c0-08d9362e7103
X-MS-TrafficTypeDiagnostic: MN2PR12MB3344:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3344C4AA4BA7E9E9D6C0498EDA089@MN2PR12MB3344.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:556;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6Xh1gSDqHlXk5t7hUaI9CM7LGIWAjQ6cAnP/pCkmXlPSDM6t0Hh00+WMsLyzWcJ/GHtcmNpKYxow9CGyCXiuf4LTp9OZD9RI1KiN4Qsg9vnIQcOaz/hJBhY0lNMbi0Sc+nya0V1WII4OPjipTl3xEl5HFnkj3O3m/FZkqutNCW9E9BFcfVnrGSpMU2ZEvpJi0XuVywuqAf+CsYyrIqa2LL8nCLj4H+IAmTkrRPkEogMXly47+msK93oBY33ulsrGJOnerfTnTKBloJxLkI1d4vu/mAncN0v1ncWjlnxVjSPRLE/4DlPZ25J90AlWI9TgoZ+02t5zoSJ/HIPKydzx8p9D+IbfJnKuaguSNeteAvqH6MBx1ETiXm76FbCbuRAQJ8Ytx7HmyfvMOsb5Oca9qMn1QNKZSVGyONIW8un8yIavVe3+RMa76mm/RGuDNamPXB7zdIHBnTCPWBW/uTAVfunsWsPs68m4bnQ/DiAG5Gpxu/Odp1hG1X6uP6z7NtwUyqF3yglLOsI20laFSZquJuDqIXg/T2K2iUMC1f5aazWu1/8PEAmj3wcVzrt6j9MPIrdgX+O2KeBldESV2qmPJIMxoD6aOYIWGoKc4FMwoblHJY7mTY4TqnSHFiDpDYM8rLyM7c7g7jFp6W3nMfKjEXUjhQC0VlQPkhq3QMPAFg7IYORAlTuy9EDxMqS2jYHAME/4sGWA7m9ZRcRHhRqauQ/XFiV+sW5sfpHE85Hol5qJIyaO1xb0LR0HbuuPCQUqmMVxSUzi2YDBAMMlJjroJc3cU7X20cvVr1hHElKHa+CdmT6Ck6yoJJG8DYBocK9
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(36840700001)(46966006)(15650500001)(8936002)(6666004)(966005)(186003)(82310400003)(82740400003)(6636002)(86362001)(54906003)(5660300002)(4326008)(336012)(2616005)(110136005)(83380400001)(36860700001)(47076005)(316002)(1076003)(356005)(70586007)(7696005)(7636003)(70206006)(36756003)(426003)(478600001)(107886003)(8676002)(26005)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 10:05:34.1045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb36415-2543-43eb-c8c0-08d9362e7103
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3344
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update pcie-tegra194 driver with bug fixing and cleanup

Changes from V2->V3
  Updated subject line from "PCI: tegra:" to  "PCI: tegra194:"

Changes from V1->V2
  PCI: tegra: Fix handling BME_CHGED event
	- Update variable naming
  PCI: tegra: Fix MSI-X programming
	- No change
  PCI: tegra: Disable interrupts before entering L2
	- Rephrase the commit message
  PCI: tegra: Don't allow suspend when Tegra PCIe is in EP mode
	- Update return value to -ENOTSUPP.
  PCI: tegra: Cleanup unused code
	- No Change

V1:
http://patchwork.ozlabs.org/project/linux-pci/cover/20210527115246.20509-1-omp@nvidia.com/
V2:
http://patchwork.ozlabs.org/project/linux-pci/cover/20210606082204.14222-1-omp@nvidia.com/

Om Prakash Singh (5):
  PCI: tegra: Fix handling BME_CHGED event
  PCI: tegra: Fix MSI-X programming
  PCI: tegra: Disable interrupts before entering L2
  PCI: tegra: Don't allow suspend when Tegra PCIe is in EP mode
  PCI: tegra: Cleanup unused code

 drivers/pci/controller/dwc/pcie-tegra194.c | 36 +++++++++++++---------
 1 file changed, 22 insertions(+), 14 deletions(-)

-- 
2.17.1

