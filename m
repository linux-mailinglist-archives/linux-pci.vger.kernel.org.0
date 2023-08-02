Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DE676D866
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 22:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjHBUKp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 16:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjHBUKn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 16:10:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E372101;
        Wed,  2 Aug 2023 13:10:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Na/1d7IOh9kLwNrSR2bUgqEk2/lepJ5VuiCMxYa8fNSOc7nUYb/hM98Ix4pBjpHHpmEFbWHdn2XDCxbHzJK62V43VTfPFA4JT+paoPqzE/iJL7T2UmPC7o67QuvlJ/uJUjIqFU6fMam1XYKUQChchCUbpPEXQOmES9eDDusOW5d3sw6H7zyoiyAupIDPMeXfLQSzVC92i0jOVzynbCM49A03D49XPR0vb+cynkHDuLCkJ1Fe8+B4fNSPGGY1g6mK4JURVLNJLHfmr35KcGg+2V+ln46vPs+T5gte8swV8patWNxyjfu7hg7v0dOZTIbDSp6taXsVKVFa6sutvRfm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caaw98/m+uJ5RsbWMg9ZWfTPOc3/v8+ZU4JT58RbSqQ=;
 b=jtlkmKve3fvUv/A5pTwk7/GdGKXegEdT+OjnmRSOdO9qyw+FHUIR9fd/g8J2rFFqGqVBO86DLtySRabQx9DfPlch+HE5mqldb2ixXKOdBjzIJCNyVqDR+P2FqJl/hd1zwKFIeY8JC3AcxMMSMeDt8NxLf6JIND+mfTO3GjajCDwjjMXVJOP1BI+ene1BCUXbUrMZSIm/meEymb7kLdNyFLOx12J4XKzmTMn9fiBfX3l64TpAjmVRYMP59ir697jSFb0kJaw0K2j30lAdeDjUtezVslhiX0IBQcGOBYP6Ze/IMnKJE/ZXHrYUBkDO3/EGvIZHIhitC0pNZP/1OdiV9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caaw98/m+uJ5RsbWMg9ZWfTPOc3/v8+ZU4JT58RbSqQ=;
 b=XVr9eY92Y1+u3mLg9dBohdckRV4UH3lya21geRA7XoBVVpJU4+CP+w8xoHmswMtcaDQ7h77qV9Os5VwXN5xEHw5zgmSMyEnOelhxY4TRPkOJTz/9j8maqOv1lwBJHZ7YRoa23UBgpuwa0eAdAou6DqORIizOFp9Y75MKOuZOaXk=
Received: from DS7PR03CA0193.namprd03.prod.outlook.com (2603:10b6:5:3b6::18)
 by MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 20:10:39 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:5:3b6:cafe::83) by DS7PR03CA0193.outlook.office365.com
 (2603:10b6:5:3b6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 20:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 20:10:38 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 15:10:35 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, Iain Lane <iain@orangesquash.org.uk>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v8 0/2] Fix wakeup problems on some AMD platforms
Date:   Wed, 2 Aug 2023 15:10:11 -0500
Message-ID: <20230802201013.910-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|MW4PR12MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f89c171-141a-4d9a-3858-08db93948a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rd1WLCSn/5/VUpdjwLEgpcRR8c5xwkcCcS511B6SDLWmOid4TBtrl/vlOaEW8AGGPdbyI99iv3EFuaRh1i/TrmROjK62bDgLeO6tUm4ql0DAz0mx0McyxQDtRZKzzSapQXGQIpoXyYy32nM1cllI1DbKM7fDcsrowNLXAsmLt/M7flSZKrnecaOJhhIPJdi5fFNGezeCriSJ3FM++ocGN1TqUVuyrWJHeGECGoDlie4tVaF8vxm0/xjD4yIea5srQIQS6XKg9Ef3P922bBfu0SugwlsRnlA5VxdaucpSwkl1qE46TsMB9ihs0y4JITskM40dO6EfrJcZK6Gk0ZEKYLrw+fTFZ5w/YXI9mFqzcocJow7mmnKt3woXYIovwDoMADnEPQ82jo1EErxWCf/5dKobHXRLGZkUuQh4uYc8kEXDuN5Cak9VFPoSetlqGaC0xN+4sBDTrZg6pgCna/yvtHvIBO4QlATvp1RkEBEXPOrTrYoBX/fsY+d+E0JJ3AUMWD10h1VJ5k/I+xbkl4im3ZBoAoiXiaMtc14tK1hA5+CBD/gtP79d3gtFCypT8/oC/Z4evXJSkd1W22fo4WnobMKzXE4r42o0CeA+4OxIVARwFQzt3oXsLvf6mqpcdxnutz2Sjd/WZ6shgm3UOZKhxZAzk0RnCo5yKWIl9uXrjaxjTPZVDB4TW0wiq88uTgTmmSk6bYp1uuV2xUxUe2GjhhBCZHazh5gSeQBntJBYTBjFycQXbqzdgEHz+xtee29ZTApZ+hLsRa89YFejo1ff5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(40480700001)(44832011)(5660300002)(8936002)(8676002)(40460700003)(41300700001)(70206006)(70586007)(4326008)(316002)(2906002)(36860700001)(47076005)(7696005)(110136005)(54906003)(6666004)(478600001)(356005)(81166007)(82740400003)(336012)(86362001)(16526019)(83380400001)(426003)(2616005)(26005)(1076003)(36756003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 20:10:38.3713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f89c171-141a-4d9a-3858-08db93948a2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6754
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
considered instead of a time based policy.

Mario Limonciello (2):
  ACPI: Add comments to clarify some #ifdef statements
  PCI/ACPI: Use device constraints instead of dates to opt devices into
    D3

 drivers/acpi/x86/s2idle.c | 28 ++++++++++++++++++++++++++--
 drivers/pci/pci-acpi.c    | 19 +++++++++++++++++++
 drivers/pci/pci.c         | 15 ++++++++++-----
 drivers/pci/pci.h         |  5 +++++
 include/linux/acpi.h      | 10 ++++++++--
 5 files changed, 68 insertions(+), 9 deletions(-)

-- 
2.34.1

