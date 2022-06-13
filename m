Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F883549F87
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 22:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiFMUjD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 16:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbiFMUiY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 16:38:24 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEFE5BD2B;
        Mon, 13 Jun 2022 12:30:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Old1rWKNbAFtrtlVg+jk+erSr4sEXH/asyflPKpJcL9ywWHWMUCWKjFkI1UM7oSqwUik/pseVKtXt54VrjUqb1bb6lRon1yL5x7I4q3I5d3MXRLw/DMZDeBjmpiao/uSDKxugCX/OXl5bBZGbpxDu4jksPzeLLESnDi0uTqoqHtosVkzUMhABU+GrDcpbgGdLs0W9OJK59ekpGNn+lLn7npASfaU3n+gpGA/9/Z3lQSF4Q5w8O5u+5+RUF5rJU5WZjo5okwzTaP9n2szvwS7//9FM95LKWacA4gB68RRY431Gs/Y9fj2uJSvQX28hqH0Np/SgwqDFJcKDo0CNDAM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ulfuzw05oiyPgZjysKx2jk0oon55GmjWqqqtDykRQLE=;
 b=m3n/F9WFT4UkKcFMtyTasPPgf/mjYkVRPqoPo1rc1EWhVuLpKkixt10eXDeDOonIvlBGxVpmYMVo/0BrXHLcjJIldn7JMfXx7ZFLBUfImM2rB9BJsi0aQmcuUZCYrDvk9bPfTfVlK2R5TdlhGrO4KgAL4V7ll5TrbqCUfosbZdtsP+VEJOmbKHkvmUqPiniTrLE4Lr1x2L2rVIHt6rL7ASgvj1FTHaVqvbaxvvB8UYTmF0gC2ieB83UYt/+eH/C8aOSlmovttPrYJaY9BjHP5OdYo/AEqOpgBeNlmEbipnDtZb3xyp0rocbniMJUsIXxq2lWoQYzR1Ioyqi8sGnI8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ulfuzw05oiyPgZjysKx2jk0oon55GmjWqqqtDykRQLE=;
 b=NTcLJXr8Rgg3iJmPDIvFCXb8SmiOPdU8w4GklySUToiD5W7b3iBwD2Cu/YOwTG+i6D+0c/3wysqOcrclULlab/7xyDSKDQYE3mzXSsdnE+GSSbCF6dI/0U4aP6c24+XSx4H8AKU5O6MyK6E/8gCIKc1yLSwmFLocen3Rw8ddQQE=
Received: from MWHPR01CA0031.prod.exchangelabs.com (2603:10b6:300:101::17) by
 CY4PR1201MB0231.namprd12.prod.outlook.com (2603:10b6:910:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Mon, 13 Jun
 2022 19:30:12 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::21) by MWHPR01CA0031.outlook.office365.com
 (2603:10b6:300:101::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14 via Frontend
 Transport; Mon, 13 Jun 2022 19:30:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 19:30:12 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 14:30:10 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Muralidhara M K <muralimk@amd.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
CC:     <linux-hwmon@vger.kernel.org>, <babu.moger@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v3 2/6] x86/amd_nb: Add Family 19h model 70h-7Fh IDs
Date:   Mon, 13 Jun 2022 14:29:52 -0500
Message-ID: <20220613192956.4911-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613192956.4911-1-mario.limonciello@amd.com>
References: <20220613192956.4911-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ca3e660-e59e-487e-348d-08da4d7322b2
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0231:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0231FACDF5F31BFA2986C434E2AB9@CY4PR1201MB0231.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4hnFGVwzabkAhW5zk+icUgYXT5W9bnHOeBwMY9HWscRKN0vS6ce5fZ9SV3AJBeFtYXkFDEahv4gbuyBekuxv+dZvK4ll2J57kO5vqBBn/HPEpw4cqshoHHX7YvzPX6KloU9/LujevQkw2DHtufND/4Xw3PZp0lIzqEjSWZrgttJowqNUnEU9he7RYR2oJ+ioNmriLB4H4L2TadUHYqJuVK+kCrCs9flvta4ocuC49gv28BZZh2GUJ6ik5RSijdYrdO28zsfJqnYPwXX5nkfSlPyQ+6K6wxuhoJAg7XYc5Lsb5QR0ashyppu1Cfsu4se9+ZGk7u378xXoEOuaTkiItquyxiuXp0z7PNaU9cEJ7mgJB2VnaxtllyZVUdf8ZL233TDYRkFAAbgQr5Eza4cT34Oec7PtWdKJEUyWm1CkLtKuvggPnyO7ytDlqsjBP1Apiise1N5hyfoIQsVN5ElEbCeNjjwwpsPz8I0WcLzY/mGBnrJQGAN8owRyFHwOBHlmEkROxAzA1ti+4i4aQM8Xju/JNUtgf0yygOXTyuShAKyeOoZ+oPAkwMbLcyKQKTLTC516S2gwDwlCw/RTlqMXwcGNTrrF8ot+kzRCwXFpTrETiUv80dcXX2HQ6jABlSuku3we/VVdYd0Pg1iSeHcXd3LMqTWd7FcjJvRli8AEY5a1mPyi6soCOMXiIPhRp5v7wmIA4KnMF4vbd3A0X2gkOc71iJ5+QRuNN3Q0/4zjFgI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(82310400005)(36860700001)(86362001)(26005)(356005)(316002)(921005)(40460700003)(81166007)(508600001)(44832011)(2906002)(7416002)(8936002)(5660300002)(8676002)(70206006)(70586007)(4326008)(47076005)(426003)(336012)(1076003)(16526019)(186003)(6666004)(36756003)(2616005)(110136005)(54906003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 19:30:12.3153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca3e660-e59e-487e-348d-08da4d7322b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0231
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for SMN communication on Family 19h Model 70h.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
v2->v3:
 * Pick up tags
 * Move "ROOT" declaration to match others

 arch/x86/kernel/amd_nb.c | 4 ++++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 60c7bd525237..cb7a40378ed3 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -21,6 +21,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M60H_ROOT	0x1630
 #define PCI_DEVICE_ID_AMD_17H_MA0H_ROOT	0x14b5
 #define PCI_DEVICE_ID_AMD_19H_M10H_ROOT	0x14a4
+#define PCI_DEVICE_ID_AMD_19H_M70H_ROOT	0x14e8
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
@@ -32,6 +33,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
+#define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
@@ -46,6 +48,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
 	{}
 };
 
@@ -71,6 +74,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
 	{}
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index ec1c226d13e6..32a1f85ff0de 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -561,6 +561,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
+#define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
-- 
2.25.1

