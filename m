Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC5E36E2B4
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 02:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhD2Aui (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Apr 2021 20:50:38 -0400
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com ([40.107.92.85]:34145
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232095AbhD2Auh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Apr 2021 20:50:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MH+Mwb0vPCqlAqnluLeZNwc57AOLIUNuG4Iomc6DpA0l5umOjxK0IFmfuiDYUQxvMKCMe0w1XMEfmiwksqKR9BCiWXnobcMVQBabSqxmffk2TF7UFVoFk/Fan4L/DVj5aViiWwoPsKrB3uETvu10nQxzSFrf1le8vRdQdXFeHS4NoTVniAJLSS9ml8CaoNvp21Sj9FuP/uuoOw6Tj5OjyZry3B8C9Tnf020KoWxWiZbmkj3x+yz03soZ4e0jllPhti9MoZ7ynsmVD03ugw3gKy5+zOyP+wGRm+Xkr0axzNeYShqRmoJWMTicfonnsWVZmZ8eoNRHIDLctwVvkxxmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HtWOgrM7n26nUsKQX3K7t3NWfGhqFZx0+M8EU4rZmY=;
 b=ZwVPu6ulFA5IO1y5gbzCDM21yN8iTs0tnn+wR4HnuWBzRX0B2jjDcX7D7E/IK2b9XwC+5aM9fids0nvuM2Zq4B16SwE41e2Q9LHL17cpGAxp8SBLucZrPVHLJ7ayiPG7AO+TFkDk+FF/Ms/V7yYiEO+vDze2Vhcqw29wldDJDvEu5Grg4Z/zWMNOn5lEnv4Lecn7undlNsupsR1E1ZC3nPyMg/FbRoNeC6zmNr9YTpRccykFDMKQZLeNSelc9ApZG4OQQnEXSNHaEoo35AZ/w4RsMoVgnjx7OwABNpPyBSOxKmrOEHpnztr3P5kz7HQIXaIB88zvNshF5XvLPnOLrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HtWOgrM7n26nUsKQX3K7t3NWfGhqFZx0+M8EU4rZmY=;
 b=Hz+6CoCBxpg/3+hEOG1CnSyPZDODmE4TCIfJEyZisv4drEXczEfqEdUIA6zNQLWrh8akUJ+Y2N1JMlwj3M2o9Kf7Y+895NjwjO8pDbXuN9Nkk7i9yOK1qfuRMXBf0pJOtgSTl5jFfupRJqMZenYaqAtFpDQGngq9mJL5FKEFHxLPzMH+A4H8PoL/ocUNMiSZlvK9aHCM37rQVOrM2b5AtuGuZpN7fk8nRMJTu5+rIZrt347RTG3yf7tQK0TVWEC6qc0CTNT9JRnI9pM8lWxRMH0xRdYE2tj3f1959BhA08csu7oJ5/4lJnAO3iWvzjHaexqE2xPiTgImu0ic9XgzHA==
Received: from BN9PR03CA0228.namprd03.prod.outlook.com (2603:10b6:408:f8::23)
 by DM5PR1201MB2490.namprd12.prod.outlook.com (2603:10b6:3:e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.27; Thu, 29 Apr
 2021 00:49:51 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::19) by BN9PR03CA0228.outlook.office365.com
 (2603:10b6:408:f8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend
 Transport; Thu, 29 Apr 2021 00:49:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Thu, 29 Apr 2021 00:49:50 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 29 Apr 2021 00:49:49 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        "Shanker Donthineni" <sdonthineni@nvidia.com>
Subject: [PATCH v4 2/2] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
Date:   Wed, 28 Apr 2021 19:49:07 -0500
Message-ID: <20210429004907.29044-2-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429004907.29044-1-sdonthineni@nvidia.com>
References: <20210429004907.29044-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 627c36f2-bb14-436a-d3bc-08d90aa8b235
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2490:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB249049D8A3F4891609DB6D1FC75F9@DM5PR1201MB2490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tSQ7QsWX/PZIyTiIFYliw22XPo0D9ZuRB1DJERXknoDfON9NjTuSPXgKy+IUiNGL3xus3MhdTDJrcjsTZSkNR4JE/kpgAqGkFD/H4rUvdX6kwA4pBjlwXMeK67KrLd0NOP5Z53Adf0kxTym3hIZYZpBG/ZaYDNQEBN+H9r3MjVaWvOJ6FPqhQv5CcaW/NWj0EqKDRhLFRTb6ZQscLser+1wmacDcIn/gp7C2I4VYQ5UW4Ue+e/gTCsndmeMm8chc/Awy8BVLeNQiEt5ngOxLOE4OjyFKndjIlCC6BQ++3qqKVImfbp3cZCFBOKku8x1CnfhoGD3KnWKkmn2KTEp9IkWy11xbohlvjAtS2L2PV/5hxUArn0NQhZygDXb8KPIdEDvkWBCNB6HiR7Lo8FIPE0EifrTF4SkbVr7i10FZJa6RbfsHoBiEDKjvDP3RqgWlUPV9akg6IYxkCuz6PVqFxMtBzX6eVNdHpsqUotcpAiGp2H0de7WLeKOP5bJ/+VWjIZuUnDCfvIrsXdGRY9jNyRt1Cac6qvib2bTRiTS42H2ke002TMDowjqgFAt5vzHsbtyzaRC22/xa4ZKxCAPWD34OOGtpq0X6p/9wmuFpChU7mcMF1q7odklR2ejRskvRCwVH9KZbGw+mYmI/k5xU+Ly9Mc3t924BUJjbug9xuEw=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(46966006)(36840700001)(70206006)(356005)(4326008)(86362001)(6916009)(316002)(54906003)(82740400003)(2616005)(6666004)(2906002)(82310400003)(5660300002)(336012)(478600001)(8936002)(8676002)(426003)(26005)(7696005)(36906005)(7636003)(1076003)(36756003)(70586007)(107886003)(36860700001)(16526019)(186003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 00:49:50.8532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 627c36f2-bb14-436a-d3bc-08d90aa8b235
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2490
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On select platforms, some Nvidia GPU devices do not work with SBR.
Triggering SBR would leave the device inoperable for the current
system boot. It requires a system hard-reboot to get the GPU device
back to normal operating condition post-SBR. For the affected
devices, enable NO_BUS_RESET quirk to fix the issue.

This issue will be fixed in the next generation of hardware.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
Changes since v1:
 - Split patch into 2, code for handling _RST and SBR specific quirk
 - The RST based reset is called as a first-class mechanism in the reset code path

 drivers/pci/quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8f47d139c381..e1216a8165df 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3910,6 +3910,18 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
 	return 0;
 }
 
+/*
+ * Some Nvidia GPU devices do not work with bus reset, SBR needs to be
+ * prevented for those affected devices.
+ */
+static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
+{
+	if ((dev->device & 0xffc0) == 0x2340)
+		dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
+			 quirk_nvidia_no_bus_reset);
+
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
-- 
2.17.1

