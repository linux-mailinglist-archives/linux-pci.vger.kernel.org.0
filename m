Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1363DD62F
	for <lists+linux-pci@lfdr.de>; Mon,  2 Aug 2021 14:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhHBM6t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 08:58:49 -0400
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:52161
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233859AbhHBM6r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 08:58:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgWE9LHUqotHP1sFydM2GoByJf4Vb/hPnC5uxsTQExLq6u6ZvP0Gh7HZrR3ZfO/mEOuibl7YnhK+f8OC+sJ5veATT2ILUUYCxuNxmgayhM5XUFz9wGPfEfNVUoH8zIpi0ErkyBM87eYNXhQLLf3JXrQujCkjx4vdzxnlSyIIsrrvm+BLMTtKVt6tOPPqMSDLvEgqdd6XjV66vHwwOAumftjk9GqVQ63NJa5yHaUt92jkXEyhs4uNogCIpZyFzAi2d0kWu9dgZguGOq9cTyxQEuoIOy8jb6Jups9JikpNCMVAEY7ukdBf7/PSVmEz3VuJAG0JlfWfAe0WDMcHgo5v3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYgwXMrVBUYPAIEWUgnbHcHX5bQkQwEB+Ar+9kMY/9M=;
 b=Ye11xzpRgYJqU/dynbuGnSzR14Bg59Barj/J0WbCSzE6CHai3afjrJ0qFA2LT1aAzRU3Ywd+8EV4PIs0z7eA6g6p6Xooersc+GKKUvJYx5SB3OGAEAQBlLMouanxa5R8cjRQMmbenO3BGJAlufL/HGF9wP1naLjsrc6rzl6oIFoxDqRpqsGoPUlIPmVws6i1R+zf9YV7Nkn843uJdS3sE7zFH4yOOa7g1W9Jzncu/y/Y9x+rUk/eKZWbfPtOudYO9Z92VDvfN77Zh4zuJsV9hzcodLUEjvb19u1nI2/WDuGbFdM2/f21wvUeCWVW6eLmdtoLKOlH4s7nyc+/6XS1nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYgwXMrVBUYPAIEWUgnbHcHX5bQkQwEB+Ar+9kMY/9M=;
 b=PaRJC9C7YzH7FAmWKuxKnqO4+0Awfpgb93y+d7zlWCofy8XPMgr1AZ/o9OLC9XW9tGCXpFygKpPo72F5BOXcJfnYdiREH02+dxGtVdXJPP07QafIur/b8EsXLGXVT0rlJBPCips+gw8aXzB9cJpbEXGx4WAvTJWJJa9123AufcA=
Received: from MW4PR03CA0090.namprd03.prod.outlook.com (2603:10b6:303:b6::35)
 by CH2PR12MB3992.namprd12.prod.outlook.com (2603:10b6:610:29::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Mon, 2 Aug
 2021 12:58:35 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::1b) by MW4PR03CA0090.outlook.office365.com
 (2603:10b6:303:b6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21 via Frontend
 Transport; Mon, 2 Aug 2021 12:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 12:58:35 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 2 Aug
 2021 07:58:31 -0500
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <mika.westerberg@linux.intel.com>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <bhelgaas@google.com>,
        <YehezkelShB@gmail.com>
CC:     <Basavaraj.Natikar@amd.com>, <linux-usb@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH 0/4] Add support for AMD USB4 and bug fixes
Date:   Mon, 2 Aug 2021 07:58:16 -0500
Message-ID: <1627909100-83338-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c07fbd4-e6d4-431f-8ecd-08d955b53d26
X-MS-TrafficTypeDiagnostic: CH2PR12MB3992:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3992A5358A040D78AA15D02CE5EF9@CH2PR12MB3992.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqemz9JpQlr9RCrjwoJci86JpL1i2zlQyeGK5SncxseI+VrcH+YhMFd+eiPJvLbOPyHx/+Bz79xo1r6+CvciIz5cdRTZ3bWynykPYIMiwamONtPFI19/CLAuRfzXw278e6lf7Gs+TYZ+iMXl8O9ixxDLnz9uGtzS0uCLb9+4op2b7tIE7D3Amt/1zigd8Y5uuM6yZjwA/i3Frd39Mv71LTz2/Q/xR3fjQjYumP6p2jKEgKL7+e1bcY5FNqdybs8YUXfsh0kC72TK6Ers4FI/Tkp80fZpLOAeuO7Yzbb6TE/ukJA0AsFbLiIOSFDE8JT+B9K3K7JHqgvs9qlYIjYG1PCC1vNbKopEphM76XLvamFUhhDioU591Y9n5TW/30gQUXIE997T9wWt+rXJAjSwDd1uFJmEQDa8C2OnbOI7mwgdb07K4SX9TFHE4hPyiFW6QkoSowdxIZlcXjuZaZ8203cLhyF7Hk3OKOIMoPQdK9NuqOU4QhPiuttN5Twr7rVxRhOeufmyw7V1zYaedkXtrCtwojL6rxflqWh6F0YiQ2BqZjTjM9ko4ybflJveCa44+CXq0rhxz5DZdXIxe1/k/uevxz3X3MOFQa3iu+aSJb/tnwsPhsnLS5o+rOQ+DovCPT294jyODpM5mxxvBi5sF0tGoZRHP1x2fDxeW+HlUjmbxvZbnsX/Ndrvi3nbDZRGKwlVJ0YvzlWGppx6n9hKnsncMk/KJ+SdDOGEuVKjxWs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(4326008)(2906002)(54906003)(356005)(36756003)(426003)(6666004)(336012)(316002)(86362001)(110136005)(2616005)(83380400001)(70206006)(47076005)(70586007)(82310400003)(26005)(5660300002)(186003)(16526019)(36860700001)(8936002)(8676002)(7696005)(4744005)(508600001)(81166007)(66574015)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 12:58:35.1465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c07fbd4-e6d4-431f-8ecd-08d955b53d26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3992
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

This series adds support for AMD USB4 host router and
some general USB4 bug fixes.

Sanjay R Mehta (4):
  PCI: Add AMD USB4 host router device IDs
  thunderbolt: Handle INTR when Disable ISR auto clear bit set
  thunderbolt: Fix adapter init handling during switch add
  thunderbolt: Fix port linking by checking all adapters

 drivers/thunderbolt/nhi.c    | 30 +++++++++++++++++++++++++++++-
 drivers/thunderbolt/switch.c |  5 +++--
 include/linux/pci_ids.h      |  2 ++
 include/linux/thunderbolt.h  |  1 +
 4 files changed, 35 insertions(+), 3 deletions(-)

-- 
2.7.4

