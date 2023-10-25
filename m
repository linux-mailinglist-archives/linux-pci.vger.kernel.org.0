Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F6C7D5FB4
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 04:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjJYCGM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Oct 2023 22:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjJYCGL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Oct 2023 22:06:11 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798E410DD;
        Tue, 24 Oct 2023 19:06:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mapdBVlTas2S0n1kg0vvn2NEGjoW1riELCShoNvCnuzkeVXvxWmaanUkhEVqgIVvoK/UizENaHqDB+pzcjtjKBpt5qO6J9U1WIy98looOKp8n2QrmL9jKT1LXl18dgT7Up0FKDldSU/ZkY5YDnnjrg80E5OLd3UrHyk0WUrL7x4718XpNTiJpj3cG5Aoj4hKrSkFGUhaJ+XZQzihdvTIlj6PvxYFDr+f0fxInQLH3WCxcURhZ6Bq1KYi52EzaNiZVHREg1RwDUJy+VUeuUP++f4NB7e13qyOsnfsvPfc+gx1VwQjtzXwOgltGEerfwW8jTqSZ6u0s0iKdy+yW3d4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fspsuZ2DJaC7CNRMP6kmYvXQZPiL0tnnUsURqdjXNHg=;
 b=GQGsnNvONhOUOJDsr9ub0m56euO8t9lzbLv6/RDxnIXMMKwcrBrCnVohJ2Vzt7rBzZTnaje8C0Cf3M79HmhaSdLvMvLT1BNbYVMolBNve/UNJGBpyWCTVe/vQ/YyeS7v3tQDUQSPHBszLEELOW8cRwRnfnFY4/VyTG5upXldtxWYRuGm3F4UkguOwnZG7vpSRhbDT3gjM/o7vc4nx6py41QO9TLgkKuONCglFE1z0r030TPZW8yrtPb45qxtVxFqfEN7a36uT88LsqgzlOUj32hcasD91xmzMV4iJl7nIDto4OtzlhhUf7ZoGmllTtm1KS1aeUAu2cIL4QYEJqyRxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fspsuZ2DJaC7CNRMP6kmYvXQZPiL0tnnUsURqdjXNHg=;
 b=lvhTll2ldsUqEXfBSSiyJNpTqWE2Vc0l0WS9Vwt6kpGY6QAtWzuMFw54TJlX1AkHRuudbB06Etgw1kYuJZmGTRVxokf1rPsrCCkV546QX302krB99VYULcB6IF7BBlfKS+hvE8ihpo1zkSVOJSFze5BFrQCYJN9pxTyII/Qpmoo=
Received: from SJ0PR03CA0190.namprd03.prod.outlook.com (2603:10b6:a03:2ef::15)
 by CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 02:06:07 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::43) by SJ0PR03CA0190.outlook.office365.com
 (2603:10b6:a03:2ef::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 02:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 02:06:06 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 21:06:04 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/4] Add support for drivers to decide bridge D3 policy
Date:   Tue, 24 Oct 2023 21:05:42 -0500
Message-ID: <20231025020546.504-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|CY8PR12MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 69144424-6287-4ca9-f3e0-08dbd4fef322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P5ukCp6WbaYEMABCVn6ym7LKD/DMDiuUYfKIglxBl8sffeaBJVCN2OzH/bOAjp8jbrzdhUfE7zoRFnqSjIPx2p/hqJauMigOUc2t+ZvwwAwE1mBME3azRO6k/h5Az+Ujcktm0oQME9ZsppjJHp4JlmVwS3f78iDTaRyUphDIT1qf3RKlYQlDafkxKMPLOeh6Pld0d4OQ9DUSXQVh7+MG91FjlIgVU7WP+zZZH9o9ssAzG7sRgqYD8hg61J7YJ2J27CpWazPbNezNTpBW0yUumaeDQXJMK+Fymw3/utO/B5uyY1VNF+WD78DyOnQ8mpcHQPwLe+kjTXEN5+w/JRt37GVEyklrNdka9DSxv+b8GAMqVgXMJ0ZoQTB1y2LclfqRYb/tsoALAIym3LLEYaeYVBWzd5d535sAwnUsap8aSkHkCYn0gvysW+K2tRk+qyMJ34DMY0HGBNXZesek7LV+WSd7crIvos20f3keQhNZs0LlqFULAuvnQfA1nLBfm1RAh8Dc+b8uFhgjwVlDp7xwgv65TfRY8uUebd4gMCwGUyVxwRI9yFnXwjv+fGXBOGgBc8Acr097u8L/MZOGAOU/FQ6XvWP7ILfpe193WLu4texvEAoJ/06jQ558Qde2/ZYmG83YyBEb3oADuf+HgVM0e0lrzwQI8PT9r+sguRMSat40u13oj6y3WjLsckMPmAfQIzPW0F2lEHi3q+NIQCdrgubukqNbs78JARHQQaBoR4eh4TuqSKLNnDm3GSmIWTeNUdyFPLpEd/u8jx8ztAh4E8skkrQLbUPtJZAF5MldHsU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(186009)(64100799003)(82310400011)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(83380400001)(40460700003)(81166007)(36860700001)(8676002)(36756003)(4326008)(8936002)(2906002)(82740400003)(26005)(47076005)(44832011)(1076003)(2616005)(16526019)(356005)(426003)(336012)(40480700001)(6666004)(5660300002)(316002)(54906003)(7696005)(966005)(70586007)(110136005)(86362001)(41300700001)(70206006)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:06:06.7274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69144424-6287-4ca9-f3e0-08dbd4fef322
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7170
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The policy for whether PCI bridges are allowed to select D3 is dictated
by empirical results that are enumerated into pci_bridge_d3_possible().

In Windows this behaves differently in that Windows internal policy is
not used for devices when a power engine plugin driver provided by the
SOC vendor is installed.  This driver is used to decide the policy in
those cases.

This series implements a system that lets drivers register such a policy
control as well. It isn't activated for any SOCs by default.

This is heavily leveraged from the work in [1]

[1] https://lore.kernel.org/platform-driver-x86/20230906184354.45846-1-mario.limonciello@amd.com/

RFC v1->PATCH v1
 * Simplify the logic, use pci_d3cold_enable()/pci_d3cold_disable() functions
 * Roll https://lore.kernel.org/linux-pci/20231004144731.158342-1-mario.limonciello@amd.com/ into series
 * Updates for some typos
 * Re-order series.  Patches 1 and 2 can potentially apply to PCI tree, 3 and 4 to platform-x86 tree.

Mario Limonciello (4):
  PCI: Make d3cold_allowed sysfs attribute read only
  PCI: Refresh root ports in pci_bridge_d3_update()
  ACPI: x86: s2idle: Export symbol for fetching constraints for module
    use
  platform/x86/amd: pmc: Add support for using constraints to decide D3
    policy

 Documentation/ABI/testing/sysfs-bus-pci |  4 +-
 drivers/acpi/x86/s2idle.c               |  1 +
 drivers/pci/pci-acpi.c                  |  2 +-
 drivers/pci/pci-sysfs.c                 | 14 +-----
 drivers/pci/pci.c                       | 12 ++++--
 drivers/platform/x86/amd/pmc/pmc.c      | 57 +++++++++++++++++++++++++
 include/linux/pci.h                     |  1 -
 7 files changed, 72 insertions(+), 19 deletions(-)

-- 
2.34.1

