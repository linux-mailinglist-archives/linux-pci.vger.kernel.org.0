Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B5253ABC0
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 19:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349589AbiFARWj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 13:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344943AbiFARWi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 13:22:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3304240A16;
        Wed,  1 Jun 2022 10:22:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFRqbhna5gx9aMo5cOa0gp6L2oQ8cig4JuDHvFnfxpLmO6ARZBbb2bCbj3ULFOJXvQQeqctV1Q3fsy9t5KC2ka3/u9uNz1YZPKfwNvH39kcyNqdGZ8CZGFeO6Baf9R9cP4o2YNH3nWvkWqKDiEV7w6/eMtxVEf+eOw8hArJ92XVKdVXlmYA66+UI39F7ylyH7v+ytRG3s7iuSibdYVGhGUDEVETwtOyZW06MeZ6/LJCb+0NZRVUEbUV0l/cNuMrLe7FHztawWPLCeM9mpz+8omiZTZ9A4QbcbUXMZGY8hQzCShxy4tD39pVUi49SpHmLYzOpZSvWUgISe/lck74A2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgiTVVDXvMQzYDk2yQg5T1ikhQz4U1HlCs5Nc8gHlFg=;
 b=SyjBx7sR2sYEvHwS83v9UCaU4rgst42hcmbWcJWqrsZmhbHNm01rXqG0+ZLtucCOgO7HwyV/fkiNMnM9qWOxMAhFbBrm2X813pWPW4PpppAEZihS0KyxqiI/jD0VHB3oVd43rjXXuXy9KSgOxcUL+G9cHti2x/DE2+NBWK/rST+EDc8p8AoWfAr2ykaQCE9V/CUrHiY9tonduHLOhmuZDWK9V+oDbMIZVhFEQRlS4sW+wBJe8N7wNVelbW94//F7eTS9nJg3+pPP0PY2MK22XKGZt2hYpvUq1T5cV2Uq5PgcnwE3PNFv8DqLXWZWJrfe0uLsJjlCP05opmlDSvZ6BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgiTVVDXvMQzYDk2yQg5T1ikhQz4U1HlCs5Nc8gHlFg=;
 b=O8uFKdKxqXkzaWsRpm8UjW3vXjeORVZDEUIbaLNNX7FAgEjgjXdGK/85LX+IWgzrO+orz+CyAmMDCF8ro4CQitwGBLPwwFEncILfSUM+CgB9q2wk1oUTT34HQuYmsXiDRN3PaatzhNrAqZ7rF9LechFfhEV0dROcFJ9L6Tds8Is=
Received: from MWHPR1701CA0006.namprd17.prod.outlook.com
 (2603:10b6:301:14::16) by MN0PR12MB5836.namprd12.prod.outlook.com
 (2603:10b6:208:37b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 17:22:34 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::df) by MWHPR1701CA0006.outlook.office365.com
 (2603:10b6:301:14::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Wed, 1 Jun 2022 17:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 17:22:33 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 1 Jun
 2022 12:21:51 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
CC:     <linux-hwmon@vger.kernel.org>,
        Gabriel Craciunescu <nix.or.die@googlemail.com>,
        <babu.moger@amd.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
Subject: [PATCH 1/2] x86/amd_nb: Add AMD Family 19h A0-AF IDs
Date:   Wed, 1 Jun 2022 12:21:18 -0500
Message-ID: <20220601172121.18612-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12be3d06-a425-4dba-328f-08da43f3507b
X-MS-TrafficTypeDiagnostic: MN0PR12MB5836:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB58367C762F65C98588F91946E2DF9@MN0PR12MB5836.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ta6ywhJB00zpvvq4gh+RbbqaINX0/juQB1oho+HTHKOD0HexAdlZArmhDTKNPbVqhTU9MglUtO/grns5rRf3g602Hdnfp+SKLJLy8eCrWNgidoITHXcqKSCwYBHxKX+nZMaxuXCdvgTU1W9uMf8TdnBZGlLzylT701sOiNxiZvylMtrESilEVaYI9cP46QOq7q896IZHzrh2fHLC/1ofDccdNy0OkWrdmClTTTj5/iOO2jVoPwjM/HwKzSzLFpxfeuqhJSirq7Nq0mlYyQhMdRC+CcGpWCvRCimZNJXlXD83N3jX/jqkp1IpdsVDBNBKpbSzYF2teUV7g844So5EAjetDh3qb+Wc6xvv2eLMHfJ6cT1as9AWNlA0v+FH7iwksYTyWM6cwOLVclvSvyAzaSQUTzih2+FBz+BdSpiVvv0nquK6/7ti5TicVW9yahoSCb46xVc36QACJIMUSXsmfQPk9FP8JIVUcasCGIkUJD2gUbJ3ej6S76BTle04d0oO0QK90tTsMWDimUPgZfPbXAYC2IO3IImxV62U1+5Ewf0O6ky1yhy1rclNZyc2SjSVllv/AjwOKcUgKbZcFTKx4cPYgDzqQunXJFSaQoEz3/ah92VJcgFr1k+Ko1+S6xLwfaEB+JyJmrQZkjRMe+/itKJtvFVDdIdYT+vS6xCeYtkRsDolDuC9qUOrDFqbcwQw6TERWn82blwIHewk32xoDRNPFBMtbqzRcew2tKbmrt4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(4326008)(508600001)(7696005)(5660300002)(921005)(6666004)(36756003)(44832011)(36860700001)(7416002)(16526019)(186003)(426003)(336012)(70206006)(70586007)(8936002)(8676002)(1076003)(2616005)(40460700003)(54906003)(316002)(110136005)(26005)(356005)(82310400005)(2906002)(47076005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 17:22:33.0836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12be3d06-a425-4dba-328f-08da43f3507b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

commit 4fb0abfee424 ("x86/amd_nb: Add AMD Family 19h Models (10h-1Fh)
and (A0h-AFh) PCI IDs") had claimed to add the IDs for models A0h-AFh,
but it appears to only have added the models 10h-1Fh.

Add the actual IDs for A0-AF which are needed for SMN communication to
work properly in amd_nb.

Fixes: 4fb0abfee424 ("x86/amd_nb: Add AMD Family 19h Models (10h-1Fh) and (A0h-AFh) PCI IDs")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/amd_nb.c | 5 +++++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 190e0f763375..cc8c7cfa9068 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -25,11 +25,13 @@
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
 #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
+#define PCI_DEVICE_ID_AMD_19H_MA0H_ROOT	0x14b5
 #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
 #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F4 0x14b1
 #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
+#define PCI_DEVICE_ID_AMD_19H_MA0H_DF_F4 0x1728
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
@@ -43,6 +45,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_MA0H_ROOT) },
 	{}
 };
 
@@ -67,6 +70,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_MA0H_DF_F3) },
 	{}
 };
 
@@ -85,6 +89,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_MA0H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{}
 };
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 0178823ce8c2..05b4c67a8a2a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -560,6 +560,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
+#define PCI_DEVICE_ID_AMD_19H_MA0H_DF_F3 0x1727
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
-- 
2.34.1

