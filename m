Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A644F5BCF04
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 16:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiISOg7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 10:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiISOg6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 10:36:58 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8386BB85A;
        Mon, 19 Sep 2022 07:36:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baaqC/q4O6rj7wrN1IrTVIVpwRgkWJiJoPrHVi0QuZ3R0F5mV072pQBvSZZvM9HyIgWxzlyyfzEgT9Rx+BT7V6rbG4i+rAEG8K5WkSwwuuddukKdciJpSisJzjfNZmoo5GMVpRk2zNIy5/ik6WxIMBzzRYhOUxCKG0jS26KG7bItaATsEDIOL6maPMgiAGyaaiykldrJMpDVfY1NEcdpzdLQkqzSfsmAYTKiMnQNtVnluIZhXTGBwdCn6B2icjgkboOahcYOl22PxsjT+7c7b3A3P+PlLb7ckH70PlCCgH5DCKPwLeYnp2/HWxdXjzWxL61D46Txl7PBW2UGJHcUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erQNOiq0Qw2v7UDAvlxDxp3yjE3FmL4ppdyMNMH38nM=;
 b=RcinSKjbe7t931Fp8F7B/1LkwiByV0EGio2zJgnX824kCXRYHW3jub8ssTdE6SbJOnW/L2oRfe9EiIJUzgF7g7MZ3dg+BzkpBmKPu/2HghDIaTaE0n53GVB3d5CVwo6d0XdqEpCgywBfD8LoC+bwpY7Ytz5NhB4nVcuEM1wy/9IugWhFZi158plXJ1ZMbIKjUVsIP+G6ykt0zClyVd/mET6U8qW742PGmDt4Q3pxr858aPaouEv2fdgBSWn7KUJUwIcdsw9ffBJ5PNx9jS2cugEltWdU9A0xV0bidFbQ41X3ZLv3CP9h+3TlF2yP4rvw16olj8z2z+GBYu/hUePGHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erQNOiq0Qw2v7UDAvlxDxp3yjE3FmL4ppdyMNMH38nM=;
 b=J8rf+IRK9/KLEU74ABF4PSstBzY5xWZlyMFkg3QzOc8pSjKiBWLXp3OpH5rfhFsW0T5GIEN3vBL2gagCcw/rjXHFlgQUPS+dDrmPCR80WJIBS62ZcVL2t7U2hbOR/lwfFhB73M7Zc/DI2p8IaK1OfZeDZ3JnOJbPYupVGRVTdpuGrcTXRp0QjrhRQyUmUp5nQ7XWhxt/hATfYl1EQntVhrbSZxuQnSOS+TWLcBcIiZcXAA98Xx343/asu0wgmvjh7NkOy0tQa3p6XwdOjBQvuc/bIOECBNULmiy2m+QXzj/vF0w/7TV6Uv5+sLg/x4oSHzO9UF2rpsG+xBewAL+Ajw==
Received: from CY5P221CA0127.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::13)
 by CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Mon, 19 Sep
 2022 14:36:55 +0000
Received: from CY4PEPF0000B8E9.namprd05.prod.outlook.com
 (2603:10b6:930:1f:cafe::b4) by CY5P221CA0127.outlook.office365.com
 (2603:10b6:930:1f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Mon, 19 Sep 2022 14:36:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000B8E9.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.11 via Frontend Transport; Mon, 19 Sep 2022 14:36:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 07:36:37 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 07:36:37 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 07:36:32 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <vkoul@kernel.org>,
        <mani@kernel.org>, <Sergey.Semin@baikalelectronics.ru>,
        <ffclaire1224@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1 0/9] Enhancements to pcie-tegra194 driver
Date:   Mon, 19 Sep 2022 20:06:18 +0530
Message-ID: <20220919143627.13803-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E9:EE_|CY5PR12MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 33312334-86e4-4c01-cd22-08da9a4c662d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mcw0QrzQsf2zT5L96TK/0W1BfC/OMeuYsPBvo8ytqzmZ+60kWKdt+HvGUjGsLL5PH+5qmE/QDfOvolrG6k0vhuquDBNHB3mP0ohZv2l6Ud1f7tp5CBtt2dRfvltK2I8tDKq8M09rN5HV+g/YGSNbbZuUfuzt4gEre/5Z+QCxaXu7U0gx51U991mSOkw9af9c5Z4BoH2jcFh8SoNMRmG8LNVl5Ojvi/th1RdwMR6hhAjER2ha1M/5qJXvSnVDnXMjnJuWZvaeLnGoYwxY0SRGe1ao7jBoE8PPlybjUYI1jDAy8XLRp6zNnrAWuxiCy29bZfYn7cF9Yi+VMMwahjpGwBRB7w1PMUU9RMimlDhgE9JgPZ5c+2HurUgDtG0yjfZcR7hnng7ZifZclIxQVLbApZKW9HR1oDpb7bO+SJ3wVetc8CHkUbY5LlDIM9ow97WJ4mKzMxxOmUgp6KUNjJPLp0j4cDtcMvEdCaqHbUCYxWqI6pQjDKlSu+VjO3AB5OyHD4ny+J3OJys9CiBC4yaoV8OPwTY52YYOIotct+LSQwH5e3/DQc3fzt6rm1PLCdYhKkq9npOxZhOe2zJHPkpdj0BidV5IeMBHBgm/g4h8b5UDAwSPmm55QDU9XF9LjBocb9etRuIvb+tGUlrOqt7ezXxkDhzedVA7aZtA0xICsN4iTBF0dBolRzn8ae3VJ4go2cs5+KppQ1prjulSabiF1hGba07b9rDVlUAZV5SdOwg1QKKRCz1hXIT6UjsD8nonkb8LWZm+cobtxDdPsTtWR3K053WLsNglw8/YzpnO2zw=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(336012)(1076003)(47076005)(186003)(426003)(2616005)(36860700001)(86362001)(4744005)(82740400003)(83380400001)(7636003)(921005)(356005)(8936002)(70206006)(41300700001)(82310400005)(6666004)(7416002)(40480700001)(4326008)(8676002)(70586007)(40460700003)(2906002)(26005)(7696005)(5660300002)(54906003)(110136005)(316002)(478600001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 14:36:54.7722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33312334-86e4-4c01-cd22-08da9a4c662d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series contains enhancements to the pcie-tegra194.c driver
that works for both Tegra194 and Tegra234 SoCs and for both RootPort
and Endpoint modes.

Vidya Sagar (9):
  PCI: tegra194: Use devm_gpiod_get_optional() to parse
    "nvidia,refclk-select"
  PCI: tegra194: Drive CLKREQ signal low explicitly
  PCI: tegra194: Fix polling delay for L2 state
  PCI: tegra194: Handle errors in BPMP response
  PCI: tegra194: Apply pinctrl settings for both PCIe RP and EP
  PCI: tegra194: Refactor LTSSM state polling on surprise down
  PCI: tegra194: Disable direct speed change for EP
  phy: tegra: p2u: Set ENABLE_L2_EXIT_RATE_CHANGE in calibration
  PCI: tegra194: Calibrate P2U for endpoint mode

 drivers/pci/controller/dwc/pcie-tegra194.c | 126 +++++++++++++++------
 drivers/phy/tegra/phy-tegra194-p2u.c       |  14 +++
 2 files changed, 104 insertions(+), 36 deletions(-)

-- 
2.17.1

