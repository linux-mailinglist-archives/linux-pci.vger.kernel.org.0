Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3447A70FB
	for <lists+linux-pci@lfdr.de>; Wed, 20 Sep 2023 05:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjITD16 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 23:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjITD14 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 23:27:56 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353C2B0
        for <linux-pci@vger.kernel.org>; Tue, 19 Sep 2023 20:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5sfoBB3J9i45PG7Zl8Ybbr1qpceu+ze6IMw/m6vNZPVxi1OJB/mBg7FXpa7qUCtWDh7oaEyC0o4RSqcZOXve8uEH3qrt7qN4ojOXjMC85vO/VLWOQ1NvIbmjFoPE2tPGjwhNZ7ztM41ZmDEQUhwBCxkUua7HDJNxvX43Wyci77uSDVX8yvsc6kXyAehCzziRsWPqeRac68lehfqXgKgDZvrnHgThT+C4kkbg+sorzkat9hFdYbOMBMCMGzha0pmA+8mzRdyYPjXwakhCMRmdV0nYVbMXcYBiICuIPJqGljuSCCwfLaxbarx9UDNSl7SZYT1rihX6cNxPgMHQXfgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Km8FhSv/sgv9PD38B9Swah6kuv7TOiZppU67mrxBnc=;
 b=KBO5fvs86j8Cs53HbrbBoWmKbNtXFoHZOxJz0WvAWVQFUcKmeIHaq7eb9JfvHlybARsja/iOWr4rmLwlrKXhPQLaAyFx0DCxglx2I6KKLGR4ZBnjBWeb1qWctQRpAEjtwro1Skiz8LZR80CiXDR92I1wguzPINWMW0MxQ53VdDP48sCJD6tiKfMTRJTvtjdNqcxCVQSyVH3LG00DxWusg46lDk9BnZtnbvqEDdht3YmKsGzpylItnt4iND4+9D7mdXmNLeSiyY+JVNocgq6hDWpkAwNQE9UavI2Pxgf/6ESqArQdFcyranablnwxpBOvdX2xM192QSnD5Uqapr4otQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Km8FhSv/sgv9PD38B9Swah6kuv7TOiZppU67mrxBnc=;
 b=ZlpkwrR4piVp36Me8VOw1WvtbGiHU8PwQQeUnrWGmJqXb2X8O7g6IDiKdTmYlj88eRY2YN/dVPLF0VC3blpj+ecHnkjQeOdO+92K4jtdEzCsH8p3rC3CiW2JbG9tzc9B92QWXDkm+x0yV+X7IteuCnJ59GLVD14lxShlQCsSGeg=
Received: from PH7PR10CA0012.namprd10.prod.outlook.com (2603:10b6:510:23d::26)
 by DM4PR12MB5069.namprd12.prod.outlook.com (2603:10b6:5:388::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 03:27:45 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::7e) by PH7PR10CA0012.outlook.office365.com
 (2603:10b6:510:23d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 03:27:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Wed, 20 Sep 2023 03:27:44 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:27:42 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        <iain@orangesquash.org.uk>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v20 0/2] Add quirk for PCIe root port on AMD systems
Date:   Tue, 19 Sep 2023 22:27:22 -0500
Message-ID: <20230920032724.71083-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DM4PR12MB5069:EE_
X-MS-Office365-Filtering-Correlation-Id: e36ee08f-07db-4d6f-da3b-08dbb9898de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: msDoQyyQB7FldwFytJxjuu1onnFCoDxwF82gqIpZZ3BY31DnzRf5w4PGeMhqrXsXlzIpavkOtpTquUDl9fgS494OnsjRwHZ8VDURUzJlnHEDcT5Qs3Ywc3yPgGoBrUkj5nez6WDAYrHfBKz1wqATpxE/xjYaXa1LrgGwUENrSeB0d7v6BBdQXQxOmKXiibARXwEd69SaOrV1NEhqmW6TkiYhihPP+ajTYXfX4Z0fc7WpQc0usx236a/2pUGU2/PTpQc6WT1nngaGD6O500mxR9+bfSz+Y8idD4JOEWdcQDRZ0+ZvDPUiYT8GHhw2FZSKIcB49ZOMeMqAQ6Za/3GKMVa+XvztDaDs/ace0aBjF/6mko6Cy/ddD29i3pAwcj62VdzaX+k/WTbusEePIkSxOMx/FJTLCTIqYmloKFUJFOeY7/tMLeRGOOL+QoU59Cq9hI+FTqLLoVg3x7vS3KqGItLQ6n+tZkAIqSD3GpMS5Nv9j6KgKLOLDVaI74CCoC0op5n2KI12iAYoHhL1RXG8GrAQeEmhgCANzPbsiLabHBDNthaMPMS9+3plQqMaOVUXXTJvmwm+vVclnQ7SOXBsSYhhHJC6Ji4aqru7YGpRPLER6AOKKu0KQO8iVARiHH0RxqbQQWzhkqqxkRHOczKAn24JS79IG9fBPfAOeV6P0kT6mMO288hbsnbA+0LDgsPukJXlFWKOsyHq7gwaIensqh3mvCycdlMzShbNpGQjTIywn9erkJcc/LmFUjgOto8EZ31KPxrXmR5SPFLgEWstmZNkBdUdtjyotFIaA/WR+LU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(82310400011)(451199024)(186009)(1800799009)(46966006)(40470700004)(36840700001)(26005)(1076003)(2616005)(36860700001)(47076005)(40460700003)(83380400001)(426003)(336012)(16526019)(5660300002)(70586007)(70206006)(110136005)(8676002)(8936002)(44832011)(40480700001)(41300700001)(4326008)(2906002)(86362001)(966005)(478600001)(316002)(36756003)(54906003)(7696005)(356005)(81166007)(82740400003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:27:44.4806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e36ee08f-07db-4d6f-da3b-08dbb9898de6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5069
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Iain reports that USB devices can't be used to wake a Lenovo Z13
from suspend. This is because the PCIe root port has been put
into D3hot and AMD's platform can't handle USB devices waking the
platform from a hardware sleep state in this case.

The firmware doesn't express this limitation in a way that Linux
recognizes so this series introduces a quirk for this problem.

Previous submissions:
* v19
  https://lore.kernel.org/linux-pci/20230915023354.939-1-mario.limonciello@amd.com/
* v18
  https://lore.kernel.org/linux-usb/20230913040832.114610-1-mario.limonciello@amd.com/T/#m92a2654129d5f6be5439d8a94fb36734804763c1
* v17
  https://lore.kernel.org/platform-driver-x86/20230906184354.45846-1-mario.limonciello@amd.com/
  This version implemented constraints for the amd-pmc driver and introduced
  a veto/optin system for the PCI core as suggested by Hans.
  Rafael suggested not to use the veto/optin system and instead use a quirk.
* v16
  https://lore.kernel.org/platform-driver-x86/20230829171212.156688-1-mario.limonciello@amd.com/
  This version implemented constraints for the amd-pmc driver.
* v15
  https://lore.kernel.org/platform-driver-x86/20230828042819.47013-1-mario.limonciello@amd.com/#t
  This version hardcoded the quirk into amd-pmc driver as part of suspend
  callback.
* v14
  https://lore.kernel.org/linux-pci/20230818193932.27187-1-mario.limonciello@amd.com/
  https://lore.kernel.org/linux-pci/20230818194007.27410-1-mario.limonciello@amd.com/
  https://lore.kernel.org/linux-pci/20230818194027.27559-1-mario.limonciello@amd.com/
  This version implemented constraints exporting and limited the policy for
  >= 2015 to Intel only. It also added support for constraints optin.
  V13 was split into multiple parts to make it easier to land. 14.b was
  merged.
* v13
  https://lore.kernel.org/linux-pci/20230818051319.551-1-mario.limonciello@amd.com/
* v12
  https://lore.kernel.org/linux-pci/20230816204143.66281-1-mario.limonciello@amd.com/
* v11
  https://lore.kernel.org/linux-pci/20230809185453.40916-1-mario.limonciello@amd.com/
* v10
  https://lore.kernel.org/linux-pci/20230804210129.5356-1-mario.limonciello@amd.com/
* v9
  https://lore.kernel.org/linux-pci/20230804010229.3664-1-mario.limonciello@amd.com/
* v8
  https://lore.kernel.org/linux-pci/20230802201013.910-1-mario.limonciello@amd.com/
* v7
  https://lore.kernel.org/linux-pci/20230711005325.1499-1-mario.limonciello@amd.com/
* v6
  https://lore.kernel.org/linux-pci/20230708214457.1229-1-mario.limonciello@amd.com/
* v5
  https://lore.kernel.org/linux-pci/20230530163947.230418-1-mario.limonciello@amd.com/
* v4
  https://lore.kernel.org/linux-pci/20230524190726.17012-1-mario.limonciello@amd.com/
* v3
  https://lore.kernel.org/linux-pci/20230524152136.1033-1-mario.limonciello@amd.com/
* v2
  https://lore.kernel.org/linux-pci/20230517150827.89819-1-mario.limonciello@amd.com/
* v1
  https://lore.kernel.org/linux-pci/20230515231515.1440-1-mario.limonciello@amd.com/

Mario Limonciello (2):
  PCI: Move the `PCI_CLASS_SERIAL_USB_USB4` definition to common header
  PCI: Add a quirk for AMD PCIe root ports w/ USB4 controllers

 drivers/pci/quirks.c      | 71 +++++++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/nhi.h |  2 --
 include/linux/pci_ids.h   |  1 +
 3 files changed, 72 insertions(+), 2 deletions(-)

-- 
2.34.1

