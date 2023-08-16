Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BE077ECCA
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 00:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346789AbjHPWKy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 18:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346782AbjHPWKn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 18:10:43 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB672701;
        Wed, 16 Aug 2023 15:10:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJ0VcRpqiJWxWhH0yB2kv4ZPSvjXg5eS1zenr7SzBJ5NadZX3dC+JrVIPSYirW639uKGDVEZ0LYl0xyXTKvAqpuwykGPr4kAignJNmnQp0f0QjzMLi5Hq+OCHLRZvyQ7NjKVFxRaiWGldRnxjmETowSvUji8JpXsTfGUovQ0QuZCBzjxh/T6Oq95bB546uWVorw+IkdmOOT+nGHoDzDoIHFdByKnpUIP4n7ANr/gPjaCYDLoLZbJuKiURYoO6jYGpsc+wvokvgQHZUWmomX3NA+JBQfW3cVpjtIP0zWs8lubY24CDiA9c18Hln/byeXoZ1fie4+wyl0zBQMR1/3wfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJYKHE+AvatFioWyB1AcmiLLoh0OopBVnD7/lHOSme0=;
 b=Ug6h6RpRPuqXJjmz5cjYiPsf8bLQNxTBytUZltAILUaNBnn+RGLIxawdVqspTyD0JiceZ6OSucZwq+oL/+6KlxRYtIgeq1ckCljd17dmmEKAeJcWNpLwHSkbpzAE2URjtmJo8RR6mBpVBwrZ2trAxT27F6rDuM4wWjpZMPx87fQhIz9VXl/D1/PjgvjwBnrWLssTNGL3t3TbAxXkUMqtNMbJntfimdoN/zuVuRXrU9r1A9keqxxvA6R4bDJCdOcqr3lS2vOOUPcA6Dw/ohb7TEz/IHmrmsfHsaH9c9oN95bxDPxNs3X5/4DTUV/Fcbbu1frqf6rUM2lUy5fT+19YAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJYKHE+AvatFioWyB1AcmiLLoh0OopBVnD7/lHOSme0=;
 b=It8TQagRMNCm9VNZpP+kIyJwfWrjDhubhcKMOrJEKMYQ/iNECeL7g7IOJv7hRgY0cpcLXu3CfeMfcjqO+ONXy5MhGcIaYzgDlcQU+jKqjprKlPiokvEANda/W+xjZ3xWhAbFlopBfTDSSx/JvUwGo8nQvOm1H3w1XED85M7B0rE=
Received: from CY5PR15CA0234.namprd15.prod.outlook.com (2603:10b6:930:88::24)
 by DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 22:10:38 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:88:cafe::8d) by CY5PR15CA0234.outlook.office365.com
 (2603:10b6:930:88::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 22:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 22:10:38 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 17:10:37 -0500
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
Subject: [PATCH v12 0/9] Fix wakeup problems on some AMD platforms
Date:   Wed, 16 Aug 2023 15:41:34 -0500
Message-ID: <20230816204143.66281-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|DM4PR12MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d260f6-31c8-4b50-8eee-08db9ea59f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g9xvWz2s9yeJ0hYOrXhQ9NzkMfyudHjCCdVUqWc9i09eNViOCarzmFc4M7M8VtJf1ZpOgtjyGtcpmRkjs67T1Ep6vZ3nVuseoWJIeBfgVFxCXAxGwrl0OA/Ikil/1Nny8jzQivZXUWSS2V70fw4GFSZ4FLnicokr7kYcaDXyC9AhlpdF/AAKto93jEwqZM52gGgyYgAurslpVomBxv5oEVeeiNOok5LeY9giJTCB+5ZHntVWnuX/syCE8BdoY5K/7GdoubCAubIEr6+lPoUeRV+SG5j49gAxk6YPqcUlDmbQ9hH7ZREQyxWXi879OgIacZee+BbxcQeIfrypvCmyYJ1azAOKn3IaKIC3bZO2jaBo0vuw0QCHxvDYLe9jiLwkwXRVcLFw+7MEfWXlo9GyL5im8dOk57XheghgSLRZ8Ti2K+57YpFUACBgGb/4qWTEf193ntKHSZUzr8qmvXn85NbQT2wQKO6P+RxGOgKzRpMD515qdpJ1b4/gR9iyk7kSRVCA7z7w/iDYetaObR+rSM2Yo3QFpnHf8z5TwOvjL6CpRu4esDsfwy5qedIByZnRpPTdkoT1jzWMJ3nh22gyUYn9ygdsnTDxBYz6Hlu6koMYysmfjNvQ4TYKo83nvbOmhoFe9BZ1rw3BQeTp9lPgeo7eR0RzLAN9u5GXtP82HEDucY+miBP19GwLg83J9UeZ1HDYQ81TPOtQRohS81oHgbZaW48HCMbJDITyUWFSmGevecsyAWR/F7Uit65Psws4Es8oyu8yc8WGnrzIIczEPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(316002)(54906003)(356005)(82740400003)(81166007)(110136005)(70586007)(70206006)(5660300002)(41300700001)(36860700001)(44832011)(47076005)(8676002)(4326008)(8936002)(2906002)(40460700003)(83380400001)(26005)(16526019)(40480700001)(478600001)(426003)(336012)(86362001)(7696005)(36756003)(6666004)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 22:10:38.5086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d260f6-31c8-4b50-8eee-08db9ea59f85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5119
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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

This patch series adjusts it so that PCI device constraints for low power
idle are considered when the system is put into s2idle.

Andy Shevchenko (1):
  ACPI: x86: s2idle: Add for_each_lpi_constraint() helper

Mario Limonciello (8):
  ACPI: Add comments to clarify some #ifdef statements
  ACPI: Adjust #ifdef for *_lps0_dev use
  ACPI: x86: s2idle: Post-increment variables when getting constraints
  ACPI: x86: s2idle: Catch multiple ACPI_TYPE_PACKAGE objects
  ACPI: x86: s2idle: Fix a logic error parsing AMD constraints table
  ACPI: x86: s2idle: Add more debugging for AMD constraints parsing
  ACPI: x86: s2idle: Store if constraint is enabled
  ACPI: x86: s2idle: Enforce LPS0 constraints for PCI devices

 drivers/acpi/x86/s2idle.c | 131 +++++++++++++++++++++++++-------------
 include/linux/acpi.h      |   8 +--
 2 files changed, 90 insertions(+), 49 deletions(-)


base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
-- 
2.34.1

