Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09DA77D506
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 23:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbjHOVVG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 17:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239101AbjHOVVC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 17:21:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3F883;
        Tue, 15 Aug 2023 14:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXFvRMoMjDTP2bRS6SfaCOyxrNjzk9Jg3htvlLRp8oCc+MzQU4xMSLylzZL/8oV/FKxgPUtqW1UMNjW9OXObW1eFqJXsWk7lYqtawHTvosjAYpY30Q5FG4DQQ6twbbbNhhZYoQvS5eqFefmsnjjmEDl1EQk5n5ZI0SIIL0fqHG6g0kjOf97dnRsaSSkp9T86+hz+AwCltVtmHqsXRIyR/mwLFu+kAr2BUE3XjBaRmX3O2Fu66AxcZJZHLwCINinDp4I4uIRfCMrzlIu4WiFtLjFFWtWRAKCSt5/9X+Fb0SZGAF3H/53JdUL8CU26aIYOaS/rF2J3WoS+8mUeuncrnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYW/QtOaFXrXMsuX6438/s+C7fuYpXv8Sy7GOFUjlww=;
 b=DRicM0LhgNht5bR2O5tSqPZXtXhqHUMj41x/E5O1suX31p7xfWKANAZC7MCRL8cTaa6c6LrAAyiwzYZuUDutzwKlPVYkh9ROMQqVUdft7cT/7rvoqOOTFqmtX4O+SCdCZU9255I80Q799czWCRDWJpnl4hmnoNkkhxkAdDlByrqumq77oxHK5Wz4YEAOpGdGfBEU/o+wreTRWtZ3pooEWMvMjA5Wi3CxJRkwXFDMw6tEbuyczGYH95H64N5lOUq0p79FRxhgiO2pfiFun4ntmCMIPnI+7os9hQAvgdvRzjSBWtRXTONdTaNizzAGGz3im13OWhLl4ewReNcQTe4A+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYW/QtOaFXrXMsuX6438/s+C7fuYpXv8Sy7GOFUjlww=;
 b=OE9ikviJarrXsai6caL+PYYPZ9rAceLIhEwb1iGTXqud3jAFLkRhIqzXEyrc6wiP5tbIbymhEuwlIN9zSCvef7zsTQ/S2k6fwH/eoW8pXQRaXiJz/aDO3TVH4Y4XSWkrW8XFWqLH32YUokId6VhYzSqKgkQUwhLrjRBrbxAUa2A=
Received: from MW4PR03CA0008.namprd03.prod.outlook.com (2603:10b6:303:8f::13)
 by CH0PR12MB5387.namprd12.prod.outlook.com (2603:10b6:610:d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 21:20:58 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:8f:cafe::9) by MW4PR03CA0008.outlook.office365.com
 (2603:10b6:303:8f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Tue, 15 Aug 2023 21:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 21:20:57 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 16:20:56 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v4 0/3] PCI: pciehp: Add support for native AER and DPC handling on async remove
Date:   Tue, 15 Aug 2023 21:20:40 +0000
Message-ID: <20230815212043.114913-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|CH0PR12MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b70a67-8f5c-459b-1a98-08db9dd58480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lv9NPGmRQNlEbWr8NEvdns4HH8qqJY0QoHsZb3g3NC86r2izZrnlfXFNzx5keEeDGKumpRk1Z6izXzVN0+hQ7KQUIbrTRxxWMZzbD/WZj+NpAXgcUXSb72VvaonxIKqURAmvBwZ58MsdAUR2hPnalvSqGg713jC+ZMu5RgCnKNAHl3xX4F0lTgz7W3a6uyC1C/pI9eL5Xj0PJPtFzCkF6PtL2Ik3rSjOiuKtnBMhNSfYZo26aN4xL/lEk4TCA5IEW8gVksDJ/q5ulvx/qqT+WfMFRyI+0Lzc0AoZuaTfZH+lRrDbHZvb3FVaoLkNCHH5luhhhzKJAo+CmSmCaNXy1mkvxMa8SFweWy92ZTo0guRKrRGUuqp6LX2hoNRTjrChjkwXnIokhz8P/8/Qyalg7nPnbWAeCw4zHjkYq2RSqt49ctCHSdM8Ae7dq3uKLTwA2xS9r1J3jGxkRIih5RnuZUDIlAlb1llMZ/M94Ps0S5wjOeLRYzW2hgHVDxYBNqSZjgoq2xkzevgQpI7CTAn5Y0Vy1lhoBBZeG5lsLvPorDuC6AIuxkXppANSom1R7Prleh/HjhKF3BKR47SRu8D+xRu1kkmM48rh/leTOdn0u64JPT/Y1QJyhPbL031Pgda/CPKscBrLX0v/COrXWKY86UtID12KCLKtjV4DkjhHIh1f4DwbY8YLqX3FMdNvtOK3JhIuZeRvrR6/pNtzvb0PyzSZDFeDnCsKQp0zeFOSHQ4yPYsD+tdqwm991NXF0ILF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(1800799009)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(5660300002)(6666004)(41300700001)(86362001)(36756003)(110136005)(316002)(16526019)(336012)(426003)(47076005)(4744005)(478600001)(36860700001)(40480700001)(40460700003)(2616005)(8936002)(356005)(82740400003)(966005)(8676002)(2906002)(26005)(4326008)(81166007)(1076003)(70586007)(54906003)(70206006)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 21:20:57.8077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b70a67-8f5c-459b-1a98-08db9dd58480
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5387
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series of patches adds native support to handle AER and DPC events
occurred as a side-effect on an async remove.

Link to v3:
https://lore.kernel.org/all/20230621185152.105320-1-Smita.KoralahalliChannabasappa@amd.com

Smita Koralahalli (3):
  PCI: pciehp: Add support for async hotplug with native AER and DPC/EDR
  PCI: Enable support for 10-bit Tag during device enumeration
  PCI: pciehp: Clear AtomicOps unconditionally on hot remove.

 drivers/pci/hotplug/pciehp_pci.c |  3 ++
 drivers/pci/pci.c                | 59 +++++++++++++++++++++++++++
 drivers/pci/pci.h                |  1 +
 drivers/pci/pcie/dpc.c           | 69 ++++++++++++++++++++++++++++++++
 drivers/pci/probe.c              |  1 +
 include/uapi/linux/pci_regs.h    |  3 ++
 6 files changed, 136 insertions(+)

-- 
2.17.1

