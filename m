Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D4E776919
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 21:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjHITre (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 15:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbjHITrZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 15:47:25 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E113710E0;
        Wed,  9 Aug 2023 12:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Np66/hxiz46aJnvMbkFFYzGXvdG8UEpN1dOVDXbmDr87jsr65owDuVFaCAan3+4UlShbQSEpgMthRT6W1evYqBcRoWiWGlInHOcDc/ItcmsSbSGKiltvde2DciZLgZkKWU5DMBYCtW0NCbic2oLTiDvIDlD2wNRgIKlDF+qfbn+HhDo/sOFX+6w9y/wOnQqmY3Zo0PCLeu0xxhQ+dDmwAsPnfT8ktod8XJ4Zmojfx8x+HqGQHwCNSaodtNZGlskj4Fos+a17ckv5hXiG3QzyqbtGYZqUheoQCNRdUus3ObfEu8Rolw3x3ibX7GA+t8cB9nH9pdeDILF6vrUdd670mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lkYiFMckExmcs/g1xdUVlvrDSHqW2J0qOhUZBWyD4k=;
 b=isb8vP6wiQMbys6pB/mXD1VKCquzHkkVG2iu0QaG4GJ3GdkGyPCi0wYKyBVKzzB51s9/UsaM58J0xF+81LPgQn7vY4IcCLkiQ+2Rc9JaQsWVArRhcD/aCUjLnraxe3bgI6RFaTtrJmuyt5F6Q/qLHuAIIcg3qgdfeBLemiCArJAa5ZmypMsGuYUkXdzYAVZnWwKVkLkGNQLK3FpLwZlui3JP8iZPB6UM4552tKZ6cnuhJw0cp+cZZQrbK7gX5XCiIkXTMXrtde9x78z/49vFwh0sr4aABogHg18gos7TnwebfZupWoNTk4xJZNceQDldrZTZHqiM2nyyYF8tknVmjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lkYiFMckExmcs/g1xdUVlvrDSHqW2J0qOhUZBWyD4k=;
 b=a8Vq4MB8mTeaP0OasiDl05jVuP4Pn5dYXnDgaCxm4DsUn16Sfr7t/HCF1bpMopY760qgT6T20zApxo2sGF1XNfCRSIYeJwOw+uDtaoR8htGq9N0Cavq0kgmWIZxuQOlRlbB6FVL+jKKtXd3UPpelKof+Y/mhZg/ZApFUDZixUDE=
Received: from MW2PR16CA0070.namprd16.prod.outlook.com (2603:10b6:907:1::47)
 by DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 19:47:14 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::2c) by MW2PR16CA0070.outlook.office365.com
 (2603:10b6:907:1::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 19:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 19:47:14 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 14:47:13 -0500
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
Subject: [PATCH v11 1/9] ACPI: Add comments to clarify some #ifdef statements
Date:   Wed, 9 Aug 2023 13:54:45 -0500
Message-ID: <20230809185453.40916-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809185453.40916-1-mario.limonciello@amd.com>
References: <20230809185453.40916-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f8c016-0553-4f5e-b564-08db99116e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HkRpPB8NivTsIWGjcXGvsm788vg8ZT2MV3iDjdlDPydCbRRdTx0mM7ZbFjZ9OBZN7plVrgCuvUC7zf/FiELoMJUkRo9P6M31uFZ6aopssNKxZKzDMw4zAjIaHwMyvjCp4Ys/ZOycETjxcFQKnqbgM15cbXbQ7xafz7y+kgBWjxDewamI2FuSzmbJlT71iUf1FX6EwwaPWhYCKP+veq+o0HDUgKxlo/BkuD5Coev+2UpuwLOE0hwcy3GKu9Uw/nTP+gyGqIrOpfss5oEleqki5aLSw9gaHsmrlN22uzEwTUfLTYJ9Rnbo+/0DOR13lUJHAafMGDUShWK61KGusylbAxQfTjF55VOdsI3+pfzpBqLn3M9UPB/O4DIL3j7caAsT4ysO4rc5KplemUJRCoxPtDSF+QZXuJwom+fMejXuNhgGydpJv9INqH3mDEF5Ugmvjn+RUvuPNKiVu7x55BRuduGkMIuXUxHZV98Kw2Kp/QGcYZ/BoWifhbYUCNfDVmG1IVJNPUVhceSz2sXDR1FZZSO2EyajgYZwfdf2UTNne/3ocEdBC7vzU/gQUZmEWT4aLL+vCErutiVLqPfcMKCBmyWyCRy5c7Fe7UZp/YVpNF+Y6WBQ+XA+6AQCTyc13hGurXFf40k45biaEwbrJ7JgkULxJuFkQ3SI6Kfz5ir2nrSVCnLHDcjCypTMqUhp+/Jre5eKUrZA3ZCj6WgD6rpMj939+duc+PTxp40fOevgM607tQzETvB+R07jzFxexrRoJBUl9XgkGzq91ywct3fs5stp81YJo1eGBObaOdu30MrWe2zcJ+JXdagX40KPQRxt
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(1800799006)(82310400008)(451199021)(186006)(40470700004)(46966006)(36840700001)(8936002)(8676002)(44832011)(40480700001)(26005)(1076003)(5660300002)(70206006)(70586007)(356005)(4326008)(478600001)(81166007)(36756003)(110136005)(40460700003)(54906003)(7696005)(82740400003)(316002)(6666004)(41300700001)(2616005)(2906002)(4744005)(36860700001)(16526019)(86362001)(336012)(426003)(83380400001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 19:47:14.3371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f8c016-0553-4f5e-b564-08db99116e29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With nested #ifdef statements it's sometimes difficult to tell
which code goes with which statement.  One comment was wrong,
so fix it and add another comment to clarify another.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v9->v10:
 * no changes
---
 include/linux/acpi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 641dc48439873..0d5277b7c6323 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1117,10 +1117,10 @@ static inline void arch_reserve_mem_area(acpi_physical_address addr,
 					  size_t size)
 {
 }
-#endif /* CONFIG_X86 */
+#endif /* CONFIG_IA64 */
 #else
 #define acpi_os_set_prepare_sleep(func, pm1a_ctrl, pm1b_ctrl) do { } while (0)
-#endif
+#endif /* CONFIG_ACPI */
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PM)
 int acpi_dev_suspend(struct device *dev, bool wakeup);
-- 
2.34.1

