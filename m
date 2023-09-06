Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FB57943A6
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 21:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244136AbjIFTQk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 15:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbjIFTQi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 15:16:38 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB44DE41;
        Wed,  6 Sep 2023 12:16:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwCqDvSSIahqxwVniWQNdQZQmo0VoEoFQgZS54ze9m1nK+2vE0jQlzHC+HpO+wMqxHQ7X3TWhQz6qUfCs2hmBJ80JL2pYx4nxDXg9Fl/Ap5wKe/RHkZy+NwTUt8lBeSi9Q8nsyExnDjeKRZeZu3fdamp2kRrDqNal2KlmlUDLCv8ZiCS+qhAzr2FR2U42RQi2FnSGj5wGlwuayUkXMC/3AhSK9ph/8yFueaojZn6QE9jK8Q3CzBBo30BqIWOiq7BJq3d1e3F05kRTR/0KVwEZui7Cf0ic4Lx1Xg1tN9J2Zo6kWMSXyqCQF3VMfKWBnX97g6W7xbKUMvzGECDGpFu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIW6k8xJ6xge9IlXVGMRc2swjg/i7BiinzTtZrUiQ/c=;
 b=UsyB/MhrKFH9xFHlcMTUlabWQhxP56ylObhvWXvd0fo6zkDAI5LX9Au3wLCa+r/B98vfBap20H7o6y7zeU+UrW4MGUwka95s4iUIS30WAug9qRk8l7VkkUb9sUSZ2viOoAxP/TB+n9YVx2dSBNmI1RZXwvbgVi5kqY91z27pu8YEdHECLShbUUsswiM7BlNO5K7/G6s6QMlaDuj1K/JMyZWVM67y8hrX2/xMCSo0AfP0Ea5K227orAIliAg3KypLRvxrIVpvXnLWkP3RSG+yREG7JE7mhDMlgUXYaUnEqzqnKd+XZbG5cNQTdRCw0G2aG248RA7ZIkznd3Rx+FL1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIW6k8xJ6xge9IlXVGMRc2swjg/i7BiinzTtZrUiQ/c=;
 b=IX6kK9RGxchfYz8SJ+i5fP6kKM81dREUglAIJ2KNmwxyDqqLRBBM6kVLtNEMk45k4aDV8AYC3Fe1YsUtFtHZuVrPH1A+BUlUlypzcB1m+Ze/nFSXf8qYWM1pqW9L9X3w1jMEv3rzY/cWIMoJ8C1qcfEBs5Z7FtW2wKOlwfzT1g4=
Received: from BL1P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::26)
 by PH7PR12MB6740.namprd12.prod.outlook.com (2603:10b6:510:1ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 19:16:31 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::1e) by BL1P223CA0021.outlook.office365.com
 (2603:10b6:208:2c4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 19:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.26 via Frontend Transport; Wed, 6 Sep 2023 19:16:31 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 14:16:28 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v17 0/4] Allow drivers to influence D3 behavior for bridges
Date:   Wed, 6 Sep 2023 13:43:50 -0500
Message-ID: <20230906184354.45846-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|PH7PR12MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d63688b-0022-488d-bae8-08dbaf0dc73e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xAOu4YHqw4DrxWbx5DaGLPiuH1tJ1DqqwUcHIWtXMpI1R5wQQjGhEOIeFMkJDlJvmXZfAr8EEFoPzP+4yzEVH1rNH/d9FJLYpFqD+p9cUm5zgjiUba57F+7bEJi5MA+/6kuldY5ai0RWnLaDq142MlML5YevcBM6Cvr7JVnjUw9dRVc0NGirks0ozNNK8PKIHF2cDC9UOeOEPY/Ydn9Y8I51A/Yw67K3CHIHLxgJm72DB1wR9fObaNwA7u/xk5DUJ0H150GTM8CKQtIz3zrLhPpFUDj9+uBYGdP5r7+d8D/PSoZoyqKPEG9UI2K2lAV8vYLuVKqMzHfoorkygpZXe1KiHF2biCk/glgHfrYCCH0ma82AZpBhCMmvOVk5+CFEQLiS75m6jR/1TF7/6pXFobArJB/SMLWeaIhz97e9AptIDOytZ0hgb3jBmkyhj7tu27z/06QM0kQlyvTGYQ5AKkacrBJxsYFwS9TL62dihOJJebB8CmUY4cxhQ1NrxnRYIuBCVswAAoA2qHggiMyrbWxpwwtZ9Fq74yOvEeC4pb1MCou0IMEEbfaFa+BnTeUOYYm3OhTiR+0D554txc9AAn8VO8pz34rVr8HuL1KjDrm34xsooIKwRg49bT6VbUvRyYDp0jBTs9jHDccFypoB4Al5lH/TNEfW9GYFr/WRSSWpVPPM6ziXiTVO2JCaXNnbnWdZbhL290ebg9hjYg0kb11ZxVkDurbblNwplUHij1i1EFIcuztx6OBX/Bx5X7njhJV47jhOPusVfUi+j8nsDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(1800799009)(82310400011)(186009)(451199024)(46966006)(36840700001)(40470700004)(8676002)(8936002)(4326008)(426003)(83380400001)(47076005)(36860700001)(478600001)(70586007)(70206006)(110136005)(54906003)(16526019)(2616005)(1076003)(26005)(6666004)(7696005)(336012)(41300700001)(2906002)(40460700003)(316002)(356005)(5660300002)(44832011)(81166007)(82740400003)(40480700001)(4744005)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 19:16:31.4801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d63688b-0022-488d-bae8-08dbaf0dc73e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6740
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

D3 on PCIe root ports isn't used on Windows systems in Modern Standby.
Windows uses a uPEP driver that helps to decide the policy for given
ports.

This series adjusts the PCI core to allow drivers to register influencing
the policy and the amd-pmc driver will register.

LPS0 constraints are the basis for it; which if they are added for
Windows would also apply for Linux as well.

Mario Limonciello (4):
  ACPI: x86: s2idle: Export symbol for fetching constraints for module
    use
  PCI: Add support for drivers to register optin or veto of D3
  PCI: Check for changes in pci_bridge_d3_possible() when updating D3
  platform/x86/amd: pmc: Report device constraints

 drivers/acpi/x86/s2idle.c          |   1 +
 drivers/pci/pci.c                  | 172 +++++++++++++++++++++++++++--
 drivers/platform/x86/amd/pmc/pmc.c |  57 ++++++++++
 include/linux/pci.h                |   9 ++
 4 files changed, 229 insertions(+), 10 deletions(-)

-- 
2.34.1

