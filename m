Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516B7392D31
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 13:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhE0Lya (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 07:54:30 -0400
Received: from mail-co1nam11on2048.outbound.protection.outlook.com ([40.107.220.48]:55264
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234215AbhE0Ly3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 07:54:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSoQ1nfaxNys+Y6Y492/T+isBt2OcpLpAaANOjbAKKq2HNl82LT2goOKLFaf1r2K7I94ELgo5DSp7lAJhKRpqb5ZeI7dd++96GmWo321gKXmDnfz5UeoW+RKvaUVxFza1CuEKS1oQBVVZQkoAUI6uR05A/1/arxasMqsgqzYMZmcTvIeebiEaEV9/K78Vnn7Q3+UD5+NkKIImVY2SNNv110O4orlqKjGNw3MkDn/Q3GIuGjkJPAxTGXElK8tj2vaj0lJOXrDsX9sCem+MqPmpKdM9tGzq7a6On7KnPC+nxW1ksGCGyo09CRYqvQnKNu1XFeqUh8jeigiWIN57ZBePQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRWFIYLGIERz8anqg0F03cPoWlEMyVb62xjE4alU+Yg=;
 b=oO1VpHPuYyN65/JfpL6xEpQNM+LVadgB+obg90elcC+5zeMYqhqYlpROGltb2c+oT3q3d+G56jegDFU5Lkwazd3XwbXFC5hAwGTYEsHB5/MKxrBiKXIfswdDdum8bNoDjWXp7k0R+T2mq8vBTqdk59CpAhZ3mSbZBBTv/FYq0Z4/A3szC0JwmnmLKWFi99H1m7PXzdb2+HNUO5sOKtQhdaGUXW4b6XdDtwFlupm2bZx3BIsk/SfZtoMVU9CgLbx5pRm5KPJ09ocbOPdqyKgKFzRSkraR5C1NBxIf29llFHwOqXo1+6KnLo7bbEFQvisRLiLdPguOZJDXfpse/gxCeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRWFIYLGIERz8anqg0F03cPoWlEMyVb62xjE4alU+Yg=;
 b=CQL5KdLNQUaYs1V1vlsq5ueM2NgPNB0uZDGImnc2t91uj7YicfeTBC/WwYlQRJTv/+8k+VyZPKzcyKPVUFj/jz9oL17PoK0kuUMK8iugqSL+viAQjAsE6zu/T4FM2Jg9Vnl/w8wY4/s9EQ10Vgmocrw+eOQAI0xpge7ctQxkCQTY8OBgmrf7n1emGax/cwXAVUKG7Fx7Ayymw0z8OmhcNzDRxYjf17e3DI4/Ct+Tp+B/h6tWYn8ujm/TA9EaugAEhOO1ClD4SZouaP8Kgdv3UO94br5TQaQ5i+rg2DFhbZ6j4/KAkXue2ptVh9yTEshZCxBW/xC088m/zxT7yOLInQ==
Received: from DM5PR1101CA0002.namprd11.prod.outlook.com (2603:10b6:4:4c::12)
 by CY4PR12MB1397.namprd12.prod.outlook.com (2603:10b6:903:41::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Thu, 27 May
 2021 11:52:55 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::77) by DM5PR1101CA0002.outlook.office365.com
 (2603:10b6:4:4c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 11:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 11:52:55 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 11:52:54 +0000
Received: from buildserver-hdc-comms.nvidia.com (172.20.145.6) by
 mail.nvidia.com (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 27 May 2021 04:52:51 -0700
From:   Om Prakash Singh <omp@nvidia.com>
To:     <vidyas@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [RESEND PATCH V1 0/5] Update pcie-tegra194 driver
Date:   Thu, 27 May 2021 17:22:41 +0530
Message-ID: <20210527115246.20509-1-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a31a6a81-8a96-4566-3c63-08d92105f6fe
X-MS-TrafficTypeDiagnostic: CY4PR12MB1397:
X-Microsoft-Antispam-PRVS: <CY4PR12MB13978144B30240D0C8885DC5DA239@CY4PR12MB1397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w/QRxt3V1MNoqw8Z8Z3MloHhSoSW+gk48JOw8AQ0vb8hV1BkeuitxoTDJyfAb5Iu06bgF8aVm1FWOBe0oyQ3n6w1pX2kToDTzQIciTh5LSXTvEH5GwwV7jNLzile1wEqQ7uCwq/xUXZ54+84IH1PHCstYcOyfiwalJqclAfWwduK9Kg1sjtswyPVpg2cBYdxL1D2AuL+bsYonXQ0rTQmfpPoV7GksF5pN1n2c4aybOAJ0DU/XzLdjZnTJaomb15PmGuaRJ1uXcZpjUBq7omYwr8YwSa/MLZKJO+Tycu5rHXstsMd0NoLQhHUpa8SKbifbpWnwqAGRbwtFyJ/0K11B9PEnYopcG6ML+skDQKhofM7r/nziyjUCbTWXQCb2kioeRToj0S6YlEuJ0DkCBN4tmE2fYKA2Dexg0kUt0iHP5giAubl8awmpCMJTAf0cgnX8scIkIrucWHCN0FbDM+tLmnR2pjeoR9hYSYKSf89C5OeeqAWqbHakVteeTcfPCP0744pNims857tZBwExhHzDVFwivtIKXaxawlZdrGOHl33MvSBOfWDdvAYNdb2BSJW5s+P9mO6FA/Q3YOUmiyaApxVtaAZPzMmG8B/K3hTIndh+MAIU4xa5K1oVBStpPZq/jhG2t/+RnMwFsVU22CUl0QTxv8HoXHUB6OypGDJZR0=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(36840700001)(46966006)(8676002)(70586007)(15650500001)(36906005)(186003)(336012)(26005)(356005)(70206006)(426003)(86362001)(107886003)(36860700001)(47076005)(5660300002)(478600001)(8936002)(7696005)(82740400003)(2616005)(6636002)(54906003)(7636003)(2906002)(1076003)(36756003)(6666004)(110136005)(83380400001)(82310400003)(4744005)(316002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 11:52:55.0986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a31a6a81-8a96-4566-3c63-08d92105f6fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1397
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update pcie-tegra194 driver with bug fixing and cleanup

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

