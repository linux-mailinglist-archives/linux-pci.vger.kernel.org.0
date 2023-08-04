Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DE376F86D
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 05:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjHDDmu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 23:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjHDDms (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 23:42:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C0411B;
        Thu,  3 Aug 2023 20:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkstugF5ZBVSKyhv5+kp0n9w22+sXvQtM4DxPlF+RlH02+MartUnbWa/xvk9L2387l+RmHYOihwankeoCHCYs3AwtNYmZhi5q3JRW2naTZN70owqk1eR3INS4Fp1BHhmGiJS5bIZTmnd3zR/OXVilof3NLQSPEm4WircQYoz4GyzVV1VpNL511D9qxJUMOzlL+AOt0r1e0Iz3IxifiFBqyKHjFxnM58ESvM02P+QMWMRMH1OqEkCu2ZjIydnVyw55FMZwnO6WZNO3ZZiNqVDeH3VxS5wxlV2MEgMTWtLldp73cilDEY2Vb2SatTRT5jSAtHZFAOsgwtUzhIxy+nC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceIARqz5Gst5xlyJyeHMLGJTwGlYFxyICgcm1A6RH5s=;
 b=V8Cd8Ve18EQMNAdsQ9XqTat17z+1x+hKJe0eDTO1U1gdsZwMtn0FXvBDXKGMJe5gLf7zY/4N7IJ3AaPjK/pQ/gtqnlxGukzAWKkS22vtAqqL6JYaQDxvoJha7uDVRD8vpvjqhoy/Y+O0ayxiUo+Shy4+T6UVjbBnJf5V7Grc593EFSuUgLXGmg8He0r0sOjNZvNHiUqiZN2/QJMaDRI+vrWqA3Pcje0pyYt1rScdyOaL9JAwpDyPEl6dFMWLlsMG/3GdVlohDylb0BEZ3BxBeWH+ey99vZeSrqegbL8qS8r/q53r1eCCy1S0rmyDUKwQ6tl4xHci9dAswNkbY9ddhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceIARqz5Gst5xlyJyeHMLGJTwGlYFxyICgcm1A6RH5s=;
 b=2WpZRyz31rLcp23ibRIeGdk+yQ/xXO1pTQXGBNfYFBH7FjnXh8b2yFC26vlgaA4NNzQ8n8/36LsRt8sXtgA/U1t/1f1T8iziQ4LXVKcRroQQ/aUNP83ats+hxEOHWifB8/RgRh2/uiwAeTrZzF1lC+VjVhUHyZqZLFmNPGOERcE=
Received: from CYZPR10CA0017.namprd10.prod.outlook.com (2603:10b6:930:8a::17)
 by CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 03:42:42 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:8a:cafe::9a) by CYZPR10CA0017.outlook.office365.com
 (2603:10b6:930:8a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45 via Frontend
 Transport; Fri, 4 Aug 2023 03:42:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 03:42:41 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 22:42:31 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        <linux-acpi@vger.kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Iain Lane" <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v9 0/3] Fix wakeup problems on some AMD platforms
Date:   Thu, 3 Aug 2023 20:02:26 -0500
Message-ID: <20230804010229.3664-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CH0PR12MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: baeb52fa-9b2f-4675-60b8-08db949cdb65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQkpS6w7hydI13jHC9nUWcG/XRRt0fSwp1y+kjYDPM0sGmNTPSmpbEGbv5TKj4zbAjHFEqniRo8uxiqrTxjGN7rSI0VYHLzAug5qH1UfwGcGNbP/9w02QFROQOoIhnG/cYdzG6ISLsNkaIrXSRTr5uI2jzIgBI4Y5fkvkjDJMSXlqB+Df5JZx0lRA/jd9V5VVa8lCtsfMWm/ByhR/pJBH6njQ/9K7Y412nnmibVz8mNpTD6FkAhXd9BsUFH2wmDsxgvfMAvWhdJj8fSUO1InsExmZxeWgP7ENV3YNzTKyHyUlw9oNGRRYECcHn4fHKiImClquvy5XQSfE9VeA3bFdQGp4FRbYR++d6N4lCJDmirR8QDOz/ZzbF6nACVDqLj/iVk96lUYecnoIsdG20Sfj4ug4nuMj1fyGliicjsITSOrmOFCri+Oik0Q+3SWzEejNboXLXQCAGWHxLp+gZgyYHnPTYLjIakSUbQSh7z0VyyWZV4fEIZRryCYj/5GK5IKah3k3DZ/vtp+h7kNA1Gzxa8cy91+3R27rHEKDwhELW8x95SXAHFHRrPGozVlhwal2Nb0xKQ0hLYmnb2mnqoVJoGL24HjIwo+PZT+92iq/hKyGpUs18CYGuzkTpsGpCAHrO895UBoNd2v2MCvpwmw/MbFziX87ijNSS5Fuc3FvmfSVy90hXi6485Af3XzrVrPpVPb2aDEJHG1xpHrzgxnpxIppI122VI02jKXMd7wcXPBSPLZ792b80RuKO/hMpfdVDvxWdLd75a1Vl4K5k6nfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(82310400008)(1800799003)(451199021)(186006)(36840700001)(40470700004)(46966006)(2906002)(44832011)(5660300002)(70206006)(70586007)(8676002)(36860700001)(47076005)(83380400001)(40460700003)(41300700001)(8936002)(316002)(110136005)(4326008)(54906003)(478600001)(36756003)(7696005)(6666004)(40480700001)(2616005)(86362001)(426003)(356005)(81166007)(1076003)(26005)(336012)(16526019)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 03:42:41.8782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baeb52fa-9b2f-4675-60b8-08db949cdb65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5156
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Problems have been reported on AMD laptops with suspend/resume
where particular root ports are put into D3 and then the system is unable
to resume properly.

The issue boils down to the currently selected kernel policy for root port
behavior at suspend time:
0) If the machine is from 2015 or later
1) If a PCIe root port is power manageable by the platform then platform
   will be used to determine the power state of the root port at suspend.
2) If the PCIe root is not power manageable by the platform then the kernel
   will check if it was configured to wakeup.
3) If it was, then it will be put into the deepest state that supports
   wakeup from PME.
4) If it wasn't, then it will be put into D3hot.

This patch adjusts it so that device constraints for low power idle are
considered if the device is not power manageable by the platform.

Mario Limonciello (3):
  ACPI: Add comments to clarify some #ifdef statements
  ACPI: x86: s2idle: Adjust constraints logic building
  PCI/ACPI: Use device constraints to decide PCI target state fallback
    policy

 drivers/acpi/x86/s2idle.c | 71 ++++++++++++++++++++++++++-------------
 drivers/pci/pci-acpi.c    | 22 ++++++++++++
 drivers/pci/pci.c         | 14 ++++++++
 drivers/pci/pci.h         |  5 +++
 include/linux/acpi.h      | 14 +++++---
 5 files changed, 99 insertions(+), 27 deletions(-)

-- 
2.34.1

