Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5640770A3C
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 23:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjHDVBu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 17:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjHDVBq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 17:01:46 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA58A4C3F;
        Fri,  4 Aug 2023 14:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZyTzRLB2nbAw7V2q9LJiQZyUoMS7S1+tfGMGUMKLwFd39dZ7+44QPLH3x2CwB6sRQtL97Xnmqhp/+2bJrcJcVJry6nC76G1NpO9LP5TkeMir6/sjpG9NYmn3ZxYi1lXYOMyxqFp/10ZbVPDY70F0mVcuapKf7A4vR231LeOU4RfRTGTweFCULSixa2wwy27y5AEjaYVFfjE0Y2RE4OnjLj36I9vmK7HgpqAZwuNu0hqXOhso9r0WSyPfjsnC31hJdIL9RPuFoFSaOgjPDOTjNJAZY3uk8nSE2FUZD1o4XemBTa98tYCJ/TMakQLjUPZlnaOmDwg7Jeljj+jzsliKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmLZMKWV3LtK4gzUahrIxsA/9+nptHk9ztIwUc8m0GY=;
 b=WHDaarhWPzEZ4IyeBd0twV2v8eZBepZyJkl+aYfDfKz27cntMlZsh/zPbDaKtmVYR2WCnfpV7xdWmy6SAdnO+w/GFfvU3keKwhfE7U0dctkcYCqFfZnKgZJo3zlW232KRTxgGgd3RLZcOdbhONgtCNXv4u/SWBFaTBmaaqSTDTqVaRuVNaGGNbRbpD1lwsEmy3P+WR6KKYrEk6nIVzShb0NL0omjNao8gLie/Hy8V9PdeXjWFnNhPd2BiL1YK1+bQMbS+csds7ZmjZGdjFt1xjvzsdw6PhCPyHmCXj3YmiqqJWbNy5Tfux/cbpGVPAbYlCXX6p37Buhgfq/pXYVJAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmLZMKWV3LtK4gzUahrIxsA/9+nptHk9ztIwUc8m0GY=;
 b=3vEVADOAZfyx+N+23Fhe93nvNMNTlG3P0u1qyNwY7G/IoaU6vv0nkEbnhrnA3ZGxGT+8ztiqgyvhOfC2rDl14/9XHUquiYWUbSAgvla+TdyUFWsz6FQj6+ee44GyVh9laCjim1r6XX0Mo4x4a/95m77HMg5DD5ZTHkwF8eTapbg=
Received: from CYXPR02CA0079.namprd02.prod.outlook.com (2603:10b6:930:ce::27)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Fri, 4 Aug
 2023 21:01:43 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:ce:cafe::13) by CYXPR02CA0079.outlook.office365.com
 (2603:10b6:930:ce::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 21:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 21:01:42 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 16:01:41 -0500
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
Subject: [PATCH v10 0/7] Fix wakeup problems on some AMD platforms
Date:   Fri, 4 Aug 2023 16:01:22 -0500
Message-ID: <20230804210129.5356-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d06e9b-b59f-48d1-88b8-08db952e0184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8JR2AF2kAX44w3hd8ABpSNa+I5q5RYPSJk/p/3NGSPP6JDSDxu37dPVoZPhayGdMqPzgBNCRDaWsPK1ztOLf3VSNQu8nFtUwioQoQedWnTGXr8d41w3l1qkO6Kbvfb6j13huUod78Z4gipNYsKFRdcYWjJvMLlC2vHNBw1FosXRzQFeXqrSZ0NPa0zg/9cvq/r2w54Dww9bnFOHCc00zs3up6d6Eh3YgxASCB70CCb1j8FcSoc6KgMxqgHA+wNR6+tcg5H4lnYEVGcynPH9OpE1Sy8SVRf91TIN9mlLqjAgt3LjPiVVRU5sYiCV4Z975YohDO61Za0CiFOcAHRWdqTIzoMVNgoxrk1Pin0hX56MDS5mljYP8NBVK3EzTlwEMBzbxzGTQ7Hl0KaDq8MrTm/yejook72CuvkQGePJtFfpO0TkdYAuzITH4GvzIeydFot1LdOCm1rXV6xwxkkwOdJ0rcOMUsZC3YeFG8x/AAIuIdWmDJQ+hVY4vQngy8a/fkrBP7z9isxvPM4jnFcKCsFOwUiPb2EbPmP73BztGIksHN0t85/NlUjPI5F/5M7wf/NcPhh7KoXodGhQ3iJkqKnYRRuU51Nkp+/5zXMqPc3kgC4hXgTgGtu+vn77lNu76wod5GZsBAlG7JJgMSawrnYXUXnObhClg7IyN9KpRmwsELAMdMOr+UO4rUyua/DND3plUDlBNG7ZQxraWkRxzThqpuhk4FioismHHCiDGZ1ru9F4bwa0ZO8pp6K4lGMlIvXJZkey/qd1DN0H2BFfIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(82310400008)(1800799003)(451199021)(186006)(36840700001)(46966006)(40470700004)(40460700003)(478600001)(54906003)(4326008)(2906002)(70586007)(70206006)(86362001)(6666004)(7696005)(1076003)(36756003)(16526019)(336012)(426003)(356005)(83380400001)(82740400003)(26005)(2616005)(81166007)(36860700001)(110136005)(40480700001)(47076005)(8936002)(8676002)(44832011)(316002)(41300700001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 21:01:42.8460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d06e9b-b59f-48d1-88b8-08db952e0184
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

Mario Limonciello (7):
  ACPI: Add comments to clarify some #ifdef statements
  ACPI: Adjust #ifdef for *_lps0_dev use
  ACPI: x86: s2idle: Fix a logic error parsing AMD constraints table
  ACPI: x86: s2idle: Add more debugging for AMD constraints parsing
  ACPI: x86: s2idle: Store if constraint is enabled
  ACPI: x86: s2idle: Add a function to get constraints for a device
  PCI: Use device constraints to decide PCI target state fallback policy

 drivers/acpi/x86/s2idle.c | 75 ++++++++++++++++++++++++++++-----------
 drivers/pci/pci.c         | 15 ++++++++
 include/linux/acpi.h      | 14 +++++---
 3 files changed, 79 insertions(+), 25 deletions(-)

-- 
2.34.1

