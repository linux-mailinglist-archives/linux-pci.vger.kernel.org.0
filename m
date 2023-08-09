Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1511977691D
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 21:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjHITri (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 15:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbjHITrd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 15:47:33 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124512684;
        Wed,  9 Aug 2023 12:47:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nar6ov2hlkYDsUt1rHh9Yg8C3wD4Ubdn+R6o004FEUfoEaOaDcO2z6ZFUAtwo8N2db6StvSQkVkIy5DBwvOjqn1oNDKR+BlkWb6aVvQengeURBcyACVd0eij0d1Aq5K0VaoQPpDUkdpRMN9KRGn8mGdxdifvd1MIxIJLjSWlwF33RmcJ8gN9ZuuJUoAW1CwUmDS4xyqWuTEmDzeyY52seMSuL/3TsKifMvflaMVlf6teMlUEIQ53PMaL2Y5gMGucrWSmZMdjgaXjPeuZC6YLbrqkgTypX4mkCTn4Dq8K6QwOlSTeyUFiLig592vH0OOLsPGEui/quqSv32e2ByoSpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9k7NHlZm5zRV/jx3CNKtdCrmCFksuxH3Lu5pt50c8OE=;
 b=BQio15fXzPRzbRXV9ljedRNCs2k4T0QO7l5lBDnIt/puvw7oU/j8+a2MRFQCxYFUnf8cC7zB1vnb9OaS7eiLU98HyJyDBDDfSNnu8dLLiNJRBt2YRuBtJnf/Fig8gtECe9JN0I5zVPOqdEtaUVTPSgZJmShBv5/hM1hISsn9RvIe2sCFwPHiLBDWwhME02to1hN0T7mn1rCfCyTrE/2M3GV2ydu7bK/BML3ta37ZnvQ4Fv5ou7QLH5XX68dceX5P+R/wJ+nvunuUL58pwTAYbWrrK/V7EsooHgQKBWU5Pq1mAGpMnDwO942BLwugsjyZBecRqQFqfI0BN1rYuBUpPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9k7NHlZm5zRV/jx3CNKtdCrmCFksuxH3Lu5pt50c8OE=;
 b=d2tq0Z8TD7HJ8lFFspWUTPvxZ+KaxWnVTBNro4UiHsYR46uTV6d2wzwVQOU6FIYER8aOZ+J07CQZLFehY+Doh+cnER4qZIuaeLJDrgUlVX8+Yo9zGOfr1/dnJ+FJ2D1H1/HXuNNXZAQsBsA9E7RRlKiUTzPA2JvXaFluqGyOPKI=
Received: from MW2PR16CA0052.namprd16.prod.outlook.com (2603:10b6:907:1::29)
 by BL0PR12MB4993.namprd12.prod.outlook.com (2603:10b6:208:17e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Wed, 9 Aug
 2023 19:47:13 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::89) by MW2PR16CA0052.outlook.office365.com
 (2603:10b6:907:1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 19:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 19:47:13 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 14:47:11 -0500
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
Subject: [PATCH v11 0/9] Fix wakeup problems on some AMD platforms
Date:   Wed, 9 Aug 2023 13:54:44 -0500
Message-ID: <20230809185453.40916-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|BL0PR12MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c26404-3ff0-48a8-442a-08db99116db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MVSde0OtJwzZHU2cjbBKxDs5lqi1bZ1nrmuUhgcjP4ACQhnE/+lJiOOe9o/gkPaAG95q/ut4ftrKLEbO1MRBBTMFAwH/i7/VLK2TpMD/2mYEHGaMPySrJzgMBlUCPJY2cdhhSgug6jktbJOKcAVl2t3k/xFeug85WLnzYE2ir5EuQBkEOYHk11uA7YgduzJRF3M2u/n4PUZqFT+ySmSQHV5VqRMyD9SgbGGIiqziIpJV7/tYgZVKKay7yYHW6nTC47yXaoPPYibqKcr8PhvWsDQE5b1vGJ3IjGsh4cwcJd32KFoqRkqsPyewjjIMmRhbySEAxItHNxSi50cwA9qHTo+wmdUHWxwiGyh+w6zZjXHIY5wI9mvvtchmQSeA2sScXiGzvnruwcCuep4v8586QwUO6OkYbuvr/GBkLeyDEi7khsyd0AbkAPnrGP9qOZumMk0jobXYKrD0a/IdvI5oqe+o4UPAllRJr84BNLmBE10TJOUutF+UbWNTYX+dCwf5bL10B7aUic8RshxcaoG9JqYKindZ46svWwNjL0nYS6o2wI+pw3BwY+AM7pM4waq3Du0OLL0UVi7mFsPce6OfpYj74t83uqRJ1UYvRMk+T9BQLh8NsJupC4JuFk5goLx8BRrpko/8nZX+PYUygrA2+lspTwGcLWznj+2kptfnWBSU3jTNcrLEocz1ZnAZanrfa57EwFu6EtmNPtxuiBjBENl3ZZTzJWaqFbjA1M1iU+CQB0gRnn/Yj2Py/6ZMXl0gy3mR5MqvDsifWFz7fl7mlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(82310400008)(186006)(1800799006)(46966006)(40470700004)(36840700001)(44832011)(2906002)(5660300002)(40460700003)(356005)(81166007)(83380400001)(426003)(47076005)(16526019)(336012)(2616005)(36860700001)(1076003)(26005)(41300700001)(8676002)(8936002)(6666004)(7696005)(36756003)(40480700001)(86362001)(70586007)(70206006)(82740400003)(316002)(4326008)(478600001)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 19:47:13.5871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c26404-3ff0-48a8-442a-08db99116db7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4993
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

This patch series adjusts it so that device constraints for low power idle
are considered if the device is not power manageable by the platform.

Mario Limonciello (9):
  ACPI: Add comments to clarify some #ifdef statements
  ACPI: Adjust #ifdef for *_lps0_dev use
  ACPI: x86: s2idle: Fix a logic error parsing AMD constraints table
  ACPI: x86: s2idle: Add more debugging for AMD constraints parsing
  ACPI: x86: s2idle: Store if constraint is enabled
  ACPI: x86: s2idle: Add a function to get constraints for a device
  PCI: ACPI: Add helper functions for converting ACPI <->PCI states
  PCI: Split PME state selection into a local static function
  PCI: ACPI: Use device constraints to decide PCI target state fallback
    policy

 drivers/acpi/x86/s2idle.c | 75 ++++++++++++++++++++---------
 drivers/pci/pci-acpi.c    | 99 +++++++++++++++++++++++++--------------
 drivers/pci/pci.c         | 53 ++++++++++++++-------
 drivers/pci/pci.h         |  5 ++
 include/linux/acpi.h      | 14 ++++--
 5 files changed, 171 insertions(+), 75 deletions(-)


base-commit: 13b9372068660fe4f7023f43081067376582ef3c
-- 
2.34.1

