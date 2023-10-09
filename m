Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2907C7BEE9C
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 00:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378949AbjJIW5Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Oct 2023 18:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378939AbjJIW5X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2023 18:57:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FFC9D
        for <linux-pci@vger.kernel.org>; Mon,  9 Oct 2023 15:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maTn5gy7blhFousBlNohg7hB+urdsRwlDICR55LN1x1MBuqtITtxWFfsTaaD7/bytlrb1fYFZfF3oQbXQicDE+nPVBebaSMddg5YT9fzVkdM8Qi7x4keKZFVCTOYyyUp6WOT0syLM0uq/p5T91/bJfXdsBdSkdxa9aUYWiKF8svcvjamWAw3pf2Ycs0tAumwWUzjCLAfAMSyqVfbqKSHrAtOc+CV6UOAZttFB66pah/h/8UqukafxcVYInEh5O5r23CyBnlkp8Or1mQJbFSsfcUNEdDt5jXV2ANkwH8JNO7sp4jbfCICzB7ixnasnG20QKsQnvdDrM8xWbS1/UDysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HN8kMIvVe++MqRsZOhU7NWOYKinfjVCV1FpeMlyytxo=;
 b=Z4P3BbbkQRGPQYEeFSQmGzYKpdSNy5pLEmcXITmX3bKmAX0H3T+FySCHR6E60DI3tW4RSbocR56X0/zx/Ss2YI4GN2oaTmskYZCmhPXYUWcQ/lOCquXJSOcjlFWvbRRq3eDr1PO5k2o61lQsdWq5XL1zZscH9HcsjX8O0Te4GAMhvWFWa4x6FOe7seW+hv+a3/bBT2m+LO4cmuh/TXhTRYVMCrEatu9rPlZZ7stFged16zY+BEgVlc0RxFpkKgGl3vc1M4qHcFfRAQ0Vei3SEryb1zfAlFw4m7qpL+z7H1plfWq5wtdnV8GdAVRvdVk+9WRSzluUGqyF+ijZ9zxcbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN8kMIvVe++MqRsZOhU7NWOYKinfjVCV1FpeMlyytxo=;
 b=scNR5y+lo8jqmVWbCo5M0Q78MYzCr3umKamyWYAcaZ9wDxPtrRIvpMJcB71HJ/BEd532loCZc5jrF34WqA/s4pCe997lxzpp13cyygyP6w2IvU6dT1UaH8HeSP2uLU5Sgp4N/45LQIpQmeSNSCKJeDbYL1ZbTljPJU/COGzSwo0=
Received: from CYZPR05CA0038.namprd05.prod.outlook.com (2603:10b6:930:a3::29)
 by PH0PR12MB8099.namprd12.prod.outlook.com (2603:10b6:510:29d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 22:57:19 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:a3:cafe::4c) by CYZPR05CA0038.outlook.office365.com
 (2603:10b6:930:a3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.23 via Frontend
 Transport; Mon, 9 Oct 2023 22:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.19 via Frontend Transport; Mon, 9 Oct 2023 22:57:18 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 17:57:17 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [RFC v1 0/4] Add support for drivers to decide bridge D3 policy
Date:   Mon, 9 Oct 2023 17:56:49 -0500
Message-ID: <20231009225653.36030-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|PH0PR12MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ffd0dc6-dda5-4fa1-73d0-08dbc91b170a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IWQSnlzojT84vmMk10JZ2c8ovxAHxQz+T4TfwVILZry6YSvskXaUg6k1uQYOpX9AM4E61amxlA6hWrWH4WOgfzIMQ+JNo2GUFsAGmnoDTE7MCkvD1tX1FtvaaECoGYcZYPA4wmyNCbNtrgATcG5WPQYvHDTkutuA693/9xd5xZXIy3fCu44ogi48UPNnHDrdiyCfyp2tfCo1+/hYzX3+g37CIlJTJTu14pnE+U2GfYK7n5AP1Wy7Mz5NEKSy/iUKn3iOpa8bbBEyAfAO+mYbErxmM+YzvO1IU3eRAm5BCWRgeUvV4hpoWglRiwgS3idjIxry1/mFMECkUXXoGr+Lwp1RkYyklZ9E1ozWy6tPFcL3WYr3cnRmIK+z8x3aZhKhxyWYakKkZRJm5488ObfjKUnRVPidiZWr03cjkcL34S5zbNWCKfZEW1EMhNMdEQNf9Uq4EGq5QyR+bRfYNjqjNUjA+mWk6LINPMfMmDTRkMu87MPlyLNRCp9aXTiZfyQNdOivzCrjvBfk/LEzMjJLI7eJpk09jI+5fK4JeNONdJYqEqMg0wQbHRergk2vA4HxLLzf8yjHjGSyU6J68kARFGbUc47BqhvnGlhxYLtGC16LSxnJRUrdg/CK6XQuJ0gD7qGGzQshhYAEJjaBwsl9NPuXJkfi0F4cSGjUf0pThf4Zaryg9FbEmzbr9q8+8iicB/HJ0g+JtudgRwq3pRmoyf73tKYL3uRk2kQwqTUZdi+69tYwK69fbSNBppWBRLYsHV2s74rXrvM63LPy2UsnEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(82310400011)(186009)(451199024)(1800799009)(64100799003)(40470700004)(36840700001)(46966006)(82740400003)(2616005)(7696005)(1076003)(478600001)(41300700001)(336012)(47076005)(83380400001)(44832011)(966005)(426003)(2906002)(70586007)(70206006)(54906003)(110136005)(5660300002)(4326008)(8676002)(8936002)(316002)(16526019)(26005)(36756003)(36860700001)(356005)(81166007)(40460700003)(86362001)(40480700001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 22:57:18.9980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffd0dc6-dda5-4fa1-73d0-08dbc91b170a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8099
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
Mario Limonciello (4):
  ACPI: x86: s2idle: Export symbol for fetching constraints for module
    use
  PCI: Add support for drivers to decide bridge D3 policy
  PCI: Check for changes in pci_bridge_d3_possible() when updating D3
  platform/x86/amd: pmc: Add support for using constraints to decide D3
    policy

 drivers/acpi/x86/s2idle.c          |   1 +
 drivers/pci/pci.c                  | 148 +++++++++++++++++++++++++++--
 drivers/platform/x86/amd/pmc/pmc.c |  59 ++++++++++++
 include/linux/pci.h                |  54 +++++++++++
 4 files changed, 252 insertions(+), 10 deletions(-)

-- 
2.34.1

