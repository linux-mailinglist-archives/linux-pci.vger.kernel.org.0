Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A567943AB
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 21:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244142AbjIFTQl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 15:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243932AbjIFTQj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 15:16:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20620.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::620])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E32185;
        Wed,  6 Sep 2023 12:16:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0yYyAXPGWPCgdWkhLCISbcj5kRYedweEss2iI/TwqGr/oAwQ2+XY3fzGg6UokOJcrngTgcWt3SSLcv/9/yVUeoHq3JbnOlYzMwDaXl+EOna+3NfKWWnjO4gdbhhsZD1YoV/dJuIpyoALCl6RY/tldo8qOUxnlO3kxTuZyUdZtd1Ci8ObOtlARSzfs/DabkdC9TevN+RpNJ9N+oELIt5mn31kGtgUFVUc1gbJ2aI6pE/QTYoH0sys8XqIaxrSmq0XR8h/OgoAqP2aDaFtpbkG23TSFplWCL9/IaZhHW5Dyw+0Gf6PWg4EHdmiJuWfMYiquUTaHdfBYxASyLUD8xXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhgdq7tuoTrEq5dIpJ1dvdmdDEcRiop06oGFEE7Xd/s=;
 b=CBXoJL8O7yhRxrsda0mTjAMCzIOvlKbJQA6Pm5C4qTgRmq6/FGomw4V9CsSD+TDBFzAkTGLoCtmNoq+p9DfmTgNTyOkipnZGQ4YX7A3dDnxGrI1Kr5DjrU0BQEfk1roVr4wmWgBij0r+zOOo+pi96+AdyR1PsRg57Mh6gs1shU9YnTEf6UOxs6KH3drgIPxo0yTgBgacmdssQylAJdqt4OP2LbY27bqYatZ9Cl+Rdqrz+iccp4kw0NgXpVmEjAS2r7Ltq9hM5Ynsz6XjuCvCWVxcA8YT7TzOwONoDDYHsR/vZzLmVv0+Hetm8cQ8WhxZjnHnbJ+R9R7NdXL3wVVRQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhgdq7tuoTrEq5dIpJ1dvdmdDEcRiop06oGFEE7Xd/s=;
 b=TKwSDBO1HXiwbEdlTgjhgmP/JWIUe0JFrtYkVO6r6pxRMqk6ffnPx8xWZ6+RwpqAa/MtOSEKajf8RIjxz636NFOJlGWiOvW4PLjUb85s2jdAO73lHtbQogXV5zoGy19pG7QmdEOWfzPKsT2ajLGJs2qbm/kvvVJ05rHSwSRCJA4=
Received: from BL1P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::8)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 19:16:32 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::88) by BL1P223CA0003.outlook.office365.com
 (2603:10b6:208:2c4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 19:16:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.26 via Frontend Transport; Wed, 6 Sep 2023 19:16:32 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 14:16:29 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v17 1/4] ACPI: x86: s2idle: Export symbol for fetching constraints for module use
Date:   Wed, 6 Sep 2023 13:43:51 -0500
Message-ID: <20230906184354.45846-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906184354.45846-1-mario.limonciello@amd.com>
References: <20230906184354.45846-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: b91e16b1-3107-403f-7a21-08dbaf0dc7bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M3mU4xb6k2MBsiBQkF6X7DKCvxejopNikMULMvT1uq4GBSumpdp3N7O++jyaHfIJ0W/w3EzbNe9hSkof6+0UaTc58Gv9M7xHAZZl+1pVUg3ahOzhOfJMU0DNisaPcyHEfDpZxF0XkPB2NvzIL3uhRBYxIDgHML7Cf+WOQcDnYId9oDb81IFK6LntF8spLFyDIFiHnC5ZyT98fxQ0RSlMKPXCbz+HABS11rRCraShrL0cl+ZAobFvy9n4HV73r1qGuBtpXp2Kjmg5WraZf/xhZq3OEVBYEQjwEBgEOSJy50VV70bkwDOGF38PwDk9UNY9J5MltjwvJIu9FGhTo6pOHDRkzyjkqm+YOcCc9Q2ZMeSAeJXtzXXc3u3hJH3L96ml/d2d6a2y6hQvGm5hQHufe+s/BfgohURv2062nqoHFHvwcyY7FiP3l+bBLs/Op+ohfeCa7+GROlzki3eTnYuFBV3nRWNs4YAOHdE4giwIW6loAcjZJ/j73lUE4ZEo9izuHja5YZB5P6+8vmdFfN9nYtWIDcqwhLeNuxucDMa0jo+NVeu9bJWxRx3iskNNl9C2oClF0nA/dXok6XHAa1iT3bNWvyDDOkC/Z9dV/z1OglzqfrROWIkIUzMT6P2Rw/xGvvSjLkPdxXxcHuVjQPJK0AcTRqas8a0UFnn5ifqYsisX6AMLumO0inZE7RCE0vN01cNM4YT3efGzsbzi2cvx6Nqgau/JtwiiRKfXv0mZ52/sOPBnBR3fsZj6sUadUdGhVtNlECd7UYk6Bbdhlm12ZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(1800799009)(186009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(81166007)(6666004)(7696005)(356005)(82740400003)(40460700003)(36756003)(36860700001)(47076005)(86362001)(40480700001)(1076003)(2616005)(4744005)(2906002)(426003)(16526019)(336012)(26005)(478600001)(83380400001)(110136005)(70206006)(70586007)(41300700001)(4326008)(8936002)(8676002)(5660300002)(316002)(44832011)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 19:16:32.3238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b91e16b1-3107-403f-7a21-08dbaf0dc7bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The amd-pmc driver will be fetching constraints to make decisions at
suspend time. This driver can be compiled as a module, so export the
symbol for when it is a module.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 08f7c6708206..de9c313c21fa 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -322,6 +322,7 @@ int acpi_get_lps0_constraint(struct acpi_device *adev)
 
 	return ACPI_STATE_UNKNOWN;
 }
+EXPORT_SYMBOL_GPL(acpi_get_lps0_constraint);
 
 static void lpi_check_constraints(void)
 {
-- 
2.34.1

