Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776DD3928CC
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 09:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhE0HsI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 03:48:08 -0400
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:4910
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229579AbhE0HsI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 03:48:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wbdwuwujt8AteDFAA45kScCEoZjJ4spSHXWsiIfPgxuIJ3jG7jvLQ+hcfLr4v91TgRx7lBWDF7QgWLPBdWnf8JcfAxl36S5bjha1Z46CwMYG3z0DFjTWFm0Pn6BsrBDkgqh+KkqdsCuzDOPia2sqIvSgVNlShxSEl1OZPb7+tZGzhTH93+tMuPLfvrYo/qZU13c6n7qXO+tXZ0upWXfYG+PCQSpjCmNhpI4Z2WF+ziYVpH4XXYOfatNJ9gElO96PH9DKdFQfP2DMYJpz1cwUYfk1HEfddgmzHpF0/y1Vjh9i2Y0EelTcMvj2foPhz79d658FCMUvRpnPfBkxSXuHEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVeIBkY+qlwrOj5x6aKAzhU5ny4IlGwFDEXbf1v5mwM=;
 b=mU5wc3i1zDD6Has7fbytHvFoodK8K6hH3Iaf1Sgbp6upPVbogYfn8Lpw/iNQxbup8LRkmp11mU8Wq/PdtwrVjrYHv3k/Ka2D8ANwSzrr6B4cc/1OsSUlHqSttLn0edKCvbzPNA7NEQUCnDj99QV4s93j9MKHjOowVvZBHOSVUMLn7U3uHr5GjpkneaBNzPlXmwt39cvt4+ggZ2vl8SOh1+SrWDjzAKq7JsoWC7jC0BdoU4dWd7XFsR9DkB154y/rM+/FMSqBbaQ1BwR0vurswtZxvv2qD3EfhnJxUsBEPrEjaHXET5I2QovvnAuYOHxqAl3oFiOmWo01uErdXchQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVeIBkY+qlwrOj5x6aKAzhU5ny4IlGwFDEXbf1v5mwM=;
 b=hwURqzNHlkuVXVIdSrqnC4T4yYCaKPPGbTrLZYsXycABK7GUQ4jeDms2hmug/fsTiJK49wfgLuvShkYFMM8N5HAHVOAvaWEmZZ2LTtKzWS2/MPRrUAJcxX7YndFGAyNS9exZlcl/d7tAfSmKSHm2YkmIoXyYOcTY1AaWafekg9omAaTrCzRceb4Cruj5J/lFZvDEN4lhIujCCer9ushF8gT91CxAfbgxdkh7kufJ+sCmmWCrKfEuoBjRCL+qiucOmgsIu+f9EtumSWESBqHq9qxxo/WFflaGCt1Kr1eoXyT5ryrK9ThOF5vkzNupBEKFpAvI9DJoH9s7j4jp7bRheA==
Received: from DM5PR07CA0092.namprd07.prod.outlook.com (2603:10b6:4:ae::21) by
 CH2PR12MB5563.namprd12.prod.outlook.com (2603:10b6:610:6a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20; Thu, 27 May 2021 07:46:34 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::85) by DM5PR07CA0092.outlook.office365.com
 (2603:10b6:4:ae::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24 via Frontend
 Transport; Thu, 27 May 2021 07:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 07:46:33 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 07:46:31 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 07:46:31 +0000
Received: from buildserver-hdc-comms.nvidia.com (172.20.145.6) by
 mail.nvidia.com (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 27 May 2021 00:46:28 -0700
From:   Om Prakash Singh <omp@nvidia.com>
To:     <vidyas@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [PATCH V1 0/6] Update pcie-tegra194 driver
Date:   Thu, 27 May 2021 13:16:07 +0530
Message-ID: <20210527074614.49149-1-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be9d7684-0796-416f-f809-08d920e38c7b
X-MS-TrafficTypeDiagnostic: CH2PR12MB5563:
X-Microsoft-Antispam-PRVS: <CH2PR12MB5563284E2E5FDFA3CF1AA789DA239@CH2PR12MB5563.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urmTVTGFkvmwRVaqaBiv+sduzWMjXUTd+RBuBDKLemN7f7GnQc2ok5gb9hWvzrJ3jGJkQ9YdjDlSd9o8d5APXJD5EGo7c09zylCuOgdXpmXmNlo4yWvfZ67R4HwHXEuFz0fOb9z4+9LqObZg37ugys5k7UTKq5pC8y42g55cD+YqDAKmeVjHfYijSZLk6XrDlH+PEDm9yG7sUZffvm+PnZZc/Rgu1xZje/5rZBy3a49GJTq3M0HgjQjtvLJOMUBveZYrRtgo+90BwIN+x+K4WJ2nBMqq15t2dzhKOt9GlhxcxzH8gWnAl7tHPtuLzJcXXr7FYzwZxyCiqoFV/vmnwFOus3VYPXAF+oQzhQgYTRvfpxq+ePuLvn85bIR5mZjfRLfwWRyDtXa+H9xrolZRRHPhFNc0+WuyDGfKcVfpGHtYFoV6RLSioFvIk5QkDFiuYqhSl40t/wTNxHOFU5TqhQNLux1t6ygMyzExQ303LUKJiuax890oyutLrmGk6zS0giX7VysivezOOLO8Rs4GXbhgv7mAnNiT0+ikAilOcT++iswH6MC/r4H0apPNZCoHGWgYdpkw4k5hcTVr4ALP5MDE4OSZVk3kB1un5+UXXkPpl5rlxU2amNf4YjbvG/lZUP9RWN5dVI9toEW/5blKikNyAVqHSz0GUB1Y30EuHMw=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(36840700001)(46966006)(356005)(82740400003)(7636003)(83380400001)(86362001)(15650500001)(54906003)(1076003)(36906005)(4744005)(110136005)(2906002)(36756003)(47076005)(36860700001)(82310400003)(8676002)(4326008)(316002)(2616005)(8936002)(70586007)(478600001)(6636002)(7696005)(336012)(426003)(70206006)(6666004)(26005)(186003)(107886003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 07:46:33.5116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be9d7684-0796-416f-f809-08d920e38c7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5563
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update pcie-tegra194 driver

Om Prakash Singh (6):
  PCI: tegra: Find RAS DES PCIe capability offset
  PCI: tegra: fix handling BME_CHGED event
  PCI: tegra: Fix MSI-X programming
  PCI: tegra: Disable interrupts before entering L2
  PCI: tegra: Don't allow suspend when Tegra PCIe is in EP mode
  PCI: Tegra: Remove redundant code for cleanup

 drivers/pci/controller/dwc/pcie-tegra194.c | 76 +++++++++++-----------
 1 file changed, 39 insertions(+), 37 deletions(-)

-- 
2.17.1

