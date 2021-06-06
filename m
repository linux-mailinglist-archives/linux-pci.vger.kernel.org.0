Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1939CE03
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jun 2021 10:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhFFIYL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Jun 2021 04:24:11 -0400
Received: from mail-sn1anam02on2070.outbound.protection.outlook.com ([40.107.96.70]:6079
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230083AbhFFIYK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Jun 2021 04:24:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAGcXiyEOSurIcQBSqTRnxQUYpELsTopZv1OUD9923EQM4w05cWijSTRedeqAdp326Qtup8ydUTrEYoomgfYHAhZmKHuhmfGSCokqMSMHApPvrPQptwVeZIZiTfxXXWYx1aWlnAgsicU5lSeUzPtlDp7vKdfMDYrs043jm+Yna2FBr7oMaLFWYNkjsgiXZDQC5x+OESDT0lHgk9lTwhWjiuHcuTanIJLOQUMVoa1KhCHTSn53Omg/Svmu1sUP7wMR2nlh/5LHNUkBbnO3cMlhEwBmEDdqnWmfgrefuSRSa2+3FdbCsZe8KldVqWzgt4VmgP3VJrl485Z3efhbTvIzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4NTa6oVJv97qcVrmEx6XMmLsFdC/bFAIJcYsKemUW0=;
 b=mJtOMgpYHS2F/OPH6zdYjRQzjJO5NYhcvITUUhS78IStFRT76hYNrQR1gETgkMSWC1Am3IQhrIC3pbqrqHkHBdh5Dzrjy4utgQBIQ/guDFYWMAfplZjmcRHkZK4/8ESkgDqRDWRU/a1gauU897Fnhg3+4E5yGREEXu/fuOn5Ps8xf0u4svNF0y+Bkelt4nowVGTOwWIllCsPU58fkA1TbWS1N2AqkZ5Z0dyro2LtmW/F4G8iIUe0NoiKMvJq5JnsQAjGfUbXOJId1G8rvbbyUlWMLoAddrCTmG/cSmPIPkbjkzlPc3cSq8bENwu9i2h70FqD9+QLcxj8vekh9QKcHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4NTa6oVJv97qcVrmEx6XMmLsFdC/bFAIJcYsKemUW0=;
 b=E7xkNHpnvrKWg+2CZ4DYqXSVeFL9+4eVIpLtb3PqG35PVFnwu1bPQkvox2euEypF/4GZdiExdMpxgfiiopd/w5Lmgx6pQ26rqCe6zhhDSO96BcDo7LZ3iNxMBhqGNhZuySwiJRBW/FAFwlTdhQBEfSprK8zOccsxTYZTUoNNVFubPaiQsZjNVUp2Iauuw4EcDpemCn6N2F2vitu7hL318ZqML0A5e/5//z9IQ8C2ik+dh3h5sk1m2xs6uYsAo+QeY6xb1UogJ7rWQmz5u8Lk3j0oYJhRC0m3Ex0JRaEJTYUU5IaLvfFZM+XvItd8n5AAJPbj0lFFYfHAPq20hfAzeg==
Received: from BN6PR17CA0014.namprd17.prod.outlook.com (2603:10b6:404:65::24)
 by BY5PR12MB3700.namprd12.prod.outlook.com (2603:10b6:a03:1a5::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Sun, 6 Jun
 2021 08:22:19 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::44) by BN6PR17CA0014.outlook.office365.com
 (2603:10b6:404:65::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Sun, 6 Jun 2021 08:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Sun, 6 Jun 2021 08:22:19 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 6 Jun
 2021 01:22:18 -0700
Received: from buildserver-hdc-comms.nvidia.com (172.20.187.5) by
 mail.nvidia.com (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Sun, 6 Jun 2021 08:22:14 +0000
From:   Om Prakash Singh <omp@nvidia.com>
To:     <kw@linux.com>, <helgaas@kernel.org>, <vidyas@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [PATCH V2 0/5] Update pcie-tegra194 driver
Date:   Sun, 6 Jun 2021 13:51:59 +0530
Message-ID: <20210606082204.14222-1-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dd62b1a-516d-423d-0bfc-08d928c433bb
X-MS-TrafficTypeDiagnostic: BY5PR12MB3700:
X-Microsoft-Antispam-PRVS: <BY5PR12MB37002CDA25CEDA7E4B2C3F16DA399@BY5PR12MB3700.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:529;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: egAlxlaIaltPeUWsyDzzyyTDrdfPXzZB/11qcdEh6piQzT3UYy/L1FROW+rT/txzSjLiH/Synw/FzqDSqrlJNBkOQQvsvtrtpOSXflrzJJDCTojHKdy5MS8RMwG23qgEu7ekWZZv90lXDZ0/LzXaTNlUjIaZsCQBF+hmLHu8BxQPiD8wr+v4UJt+AfjnXdXUSzyVSZziXgIcvsV5mBeka/z3SC9VhEmxkAfSBLGPBByznimdysk5Be8JA0bBpqTLAWKYX+ahke23UwZDd3MiwBkBAvuiyUzlr5olQ/AXsvS8WQ6709SfcD7Vcl/ulw7dWov8Xvm/UByak3V7qNeOXYI/SBgK/40T1VGLiZnLmjiAij6RQzDSgWb5Q/zGMek+XToXGOV+abbGjn6CpW/xeXanYBkvL5Hl/3BgY6HfieM7CGbV/2qfVG1Gc/cRMdiCGBUg8YcEze6I1MY2fnfJCe9PpH8KCmZnPIVBli3kFf7mcWjPKLm7xFbV8XWEuQHato7xwmV0xvbb/psQEbDWktdubOPhUKrgJThTjwhd4vE9NNFkNbPHMTBmIlmMbGi2cFWz1doetHQlQef3VdX2Ut0ydIhITqzBdsfPNimOOBVyrJ+K9f3FlryuSsREVNRCyNJemM/u2473Y3EG50GY1O88U1fDcyeDSH/PxfXC50FZWu4MDE9gelHem0a2LmuWaN5W7SrbGPka6ZG79QG0wsRk3iX+QIBdIVRuNxfLauMeuKRaLEnGpkbOYZVdO5LDInLsVqzOjgf7Uk6Hhg+yEA==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966006)(36840700001)(36860700001)(4744005)(5660300002)(86362001)(966005)(26005)(4326008)(1076003)(2906002)(82740400003)(356005)(107886003)(7636003)(7696005)(478600001)(2616005)(316002)(54906003)(110136005)(83380400001)(47076005)(70206006)(336012)(70586007)(15650500001)(6666004)(186003)(8936002)(82310400003)(8676002)(426003)(36756003)(6636002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 08:22:19.4411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd62b1a-516d-423d-0bfc-08d928c433bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3700
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update pcie-tegra194 driver with bug fixing and cleanup

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
http://patchwork.ozlabs.org/project/linux-pci/patch/20210527115246.20509-2-omp@nvidia.com/

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

