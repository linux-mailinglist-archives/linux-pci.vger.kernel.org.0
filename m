Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A7F3928CF
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 09:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbhE0HsK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 03:48:10 -0400
Received: from mail-mw2nam12on2081.outbound.protection.outlook.com ([40.107.244.81]:65377
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233913AbhE0HsK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 03:48:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3LfKC/UY6dXRQ3YnU9KoUYusT19twJ6RmMMg6g3QEgUCWzqJj4T27f4HQ1SebmtvKuklw9yFiV3nI6aMfpvDLRZ8nxurGGH9nHibSFNMgrLC6WCWWTyTfY6VH5smAWhi7h4vfaVd7qbVLC2I3C/ukypp0fS4S6bz1UTwv6GiWuv56127ZbIThHMB7Cj6xGaSs6v5brDUC5NoytRgbpdJ+U63xMBl+gaJXNCfI/8j8pst8G2M/RisfX6AoD3XnZBJTMx7KGk9Aajw2a+wvJXt1d1z4+Oe1KoWP4hrzitLvzHST01CMYdewmK7E45mDJNqSwak5/gHSs1onNxjsm91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRWFIYLGIERz8anqg0F03cPoWlEMyVb62xjE4alU+Yg=;
 b=WI2gp5OkjBPFmGGMdW+kmjEWfDYyEe3VM36V91Vh29j1Q+nr8kJsBrdZU7V9Cpi4YOzsgveefrTyJASdEwHmII7V8v3ENttITLMvWY5/du/5n8G45N57Vyr5Np7EisUogpV1dsOzKC0sePViHBi63TFwERv/rCd5G6wenqZRPUw0tIgmJ4AdvhrkhAyEj9mogStLmxxBosd4/li5jKuKiBZskaVSh1bx5P2S8Rla16YpWA+VWHW+QVEgsq4Nojzgkr1FO+TmmZ5LpCugdP8GdmqydLvG1043DKNkVNg2WEfqf9jK/csduA4zALHRVFf9FpF9UZqGFbUXSIZs+m0YjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRWFIYLGIERz8anqg0F03cPoWlEMyVb62xjE4alU+Yg=;
 b=G0hJwLPSGZk0LhyxCp7yzp9+qQ/47362CBxWeSRe71HhjYVhCcYuN5nNrli8ArIAZI9soaOs0BrOHeYVtxK3kg8iGX2nR1ledSIPiey+CMl+R8u5oOVfpwYhNERcfqUu4ditFm7HwTmDV+QE4wWsPReZB9oICRZ6xR9kofKf6b+JX25EMiJHOBkeAimOS+H68SgXq28J1yyoZoU/p1PkukE/2yqBXZr4gThYAZ3JoK/bnrPoYQ/bkPjKuj6Zj9kqrI0ve9LgL+Dfwprb3VBxxuq6sb2cBwP3lyX2Fex15ufV56+WaF6mi1FrSmimsBBwGnEgUXVr2Z1nXxLX8bcoIw==
Received: from MW4PR04CA0088.namprd04.prod.outlook.com (2603:10b6:303:6b::33)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 07:46:36 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::65) by MW4PR04CA0088.outlook.office365.com
 (2603:10b6:303:6b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 07:46:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 07:46:35 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 07:46:34 +0000
Received: from buildserver-hdc-comms.nvidia.com (172.20.145.6) by
 mail.nvidia.com (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 27 May 2021 00:46:31 -0700
From:   Om Prakash Singh <omp@nvidia.com>
To:     <vidyas@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [PATCH V1 0/5] Update pcie-tegra194 driver
Date:   Thu, 27 May 2021 13:16:08 +0530
Message-ID: <20210527074614.49149-2-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527074614.49149-1-omp@nvidia.com>
References: <20210527074614.49149-1-omp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac4ed75a-86d9-4a46-68c1-08d920e38dc1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4125:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4125A303242D3F715BF036BCDA239@MN2PR12MB4125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JbBb99dXG1vDBZRMiyIlRD7ju34BQ8xG56Bb2P07PaqMRP3SS7/jHug6F3qJDQv1dq/MZ862Y5NVthJSRPetaPxuORDuAcISnWg/eeE+xu2gDeXTZwbfj8AzDREUG9Ebl1yOHR322cBgiabFIW7aO33p0LTcBxhPeKt4UtTjpHUJB/8TMaq2F6Y/nnGa+hi+EYqkrcV/X8xHOmcoCVb/lcmD7R1UaekSgNzDEMVx38ny+8Xrkt3YvrqPYII38IwvfLspapVN5+iMgPsUk/7XIS9RBOSKwnEeLKMlv0D/UVH/0gJA5zdDNZixPmeRhh8EAapjlfdYWfofz4Mha40X75GTEfX+BXBbndswse6MwUGFjbcm+lMzRctD81VQvgfPY3ZXsMFVevf/aBKgFNvQg5+04fLrWTCeQh03TpzM11juS+L4ZVnrY9VaoYNGAETeVGDIG5ft3+iLEL3IqbxLNYVZ586iEfYXL7Ak+doj0+mQoln3tIuwyYnCy1N9Tp4J/o+iwm3N+wXPQPfGpG+edrufMQjFBFaDIFPiOntAjsx6IzhYU83DcGdhLbHW5/tzUVXRoMeQvFirWfvxkN7wiBetCYGIV6jpcb5EAc7cvnWHc9T6qn9RnVaP4tU8DvD18Y6WcAJN3FHET6gE4Wf0LPU97vgQY92UaapIgj5j6nk=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966006)(36840700001)(6636002)(8936002)(8676002)(47076005)(4326008)(2906002)(26005)(15650500001)(316002)(36906005)(478600001)(83380400001)(70206006)(107886003)(36756003)(186003)(356005)(82310400003)(1076003)(2616005)(336012)(86362001)(82740400003)(426003)(4744005)(70586007)(6666004)(54906003)(5660300002)(36860700001)(7696005)(7636003)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 07:46:35.6354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4ed75a-86d9-4a46-68c1-08d920e38dc1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125
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

