Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB6F549F88
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 22:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiFMUjE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 16:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbiFMUiW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 16:38:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505425B8BE;
        Mon, 13 Jun 2022 12:30:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lffT+0SiOwUqdpeaigq9eJ4bEPRoSlAX6OLr+N1AO6ieKz71r00IH6tWq/7XVJWo9Uu2nZDqsbhbdYZdzbQfBeg+5H8LA9rIiuSS8BKqWK47GgVt7bCY5opNc9xT8jHpIpJ9oyjyj7kkSI7S3SUFRgc8fWSKcDuISwIJXsd739kw3lxtpTEMkxoG0DxYSRGHAEzTJPvvy/gx+X1/NObLm8Iv9FkQwvbLw5KXxcV70HFJooFIyOZQL1wKfwEopvKDLXhF95LpNajzoRNVvJMKr0LUSwu7JdPC1RZ3OwX5OfxzXCqdWmmThXidsPDXAMo7PuqD9YSWJEMgmoO1sm5mPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/spjDC00QYSd9p/8Tzq2Gc0e1UPeda46ywch49DRg8=;
 b=naPWt25BWKgqHUnaBaIrYbo6qFscSOWA0W6PeCBPESbD11QDThyG3jf5VadaCRA3yYK6SUF2WIqLfuNRVPtR//z+odqi+79Wqwgno2RvF1ioxJoEcC+Ucl/UacPpZtk1vRp1p+9jW/r5/czaEuevXCF8qNfUmbIwvcun81MvaBgDPCx5w8Y7br0csHLvI4udicovn7ALchke909cYvf2vGkJ78b2e7mjZeCP/DJLe2iWua4LelfNK9e1YYEmiHeECNiIssW3MbXRJb3BOvQ01U54ElAH7sYOHf8AS5T4MXdUJctur1LOgCabKwiuXJS/giR3xehFwp6EWfblN00y/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/spjDC00QYSd9p/8Tzq2Gc0e1UPeda46ywch49DRg8=;
 b=tXKLPRLbxgjKGUxSbXNBOxA9nfaCegmabF6Qk72cSDhHzqiy3KSimCW9QeTJZRUp+3OJoKKXViVlaR0u94ify5Lzoi/mRjFPibzEQjqIVAUu8eApBdbdYpEj+un6Kef4Z3swzErjR7VP2aQqDnjfGA7dUXQ7nTjdZCwCHoA1BtY=
Received: from MWHPR01CA0029.prod.exchangelabs.com (2603:10b6:300:101::15) by
 BYAPR12MB4759.namprd12.prod.outlook.com (2603:10b6:a03:9d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Mon, 13 Jun 2022 19:30:11 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::5e) by MWHPR01CA0029.outlook.office365.com
 (2603:10b6:300:101::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Mon, 13 Jun 2022 19:30:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 19:30:11 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 14:30:08 -0500
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
Subject: [PATCH v3 1/6] x86/amd_nb: Add AMD Family 17h A0-AF IDs
Date:   Mon, 13 Jun 2022 14:29:51 -0500
Message-ID: <20220613192956.4911-2-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c45ae4fb-2984-47f9-f016-08da4d732208
X-MS-TrafficTypeDiagnostic: BYAPR12MB4759:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4759498A11816CCBAB4A9E17E2AB9@BYAPR12MB4759.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /DcT1X1ykMladwLnm6CDOiMrW4MfHLW3UKnKBu36rmFEd/kCaHa5MqD3dklzEX93w+bU11RQDp8PrIyrlWFu/pkq323sNRARkY8t4yTcMAsxK0vnFrmGiQShbRenTOVpdeqkQg6yke38cicHrO4nTkvvCC5iUcS00QjqodHhymQ8xIopjBRhTIc1Oc/4lo12qC5RZxAR9aibjgg3/4oh0hey24RwwJUMJyUEbiByIA0kbxYs/UbfA5RriCzfhlZ3s0cAo2i+QH158Znk6yBfOM8PONlyyR/xnf7b9BGYnJd2nD8gLDO/93zh56V5QnpoH0cqEUu+bl5wm+n8G2E/SwGzZ2NdePUHvdyfCuMPFsuqaUE5cHUrL1HP0ga/m8dxaNhhUg+Ru8Hx//6gNEkBFVQLLo6pe2IfBUvEG6MCZ/loC2ur+wtMqLkaDfRAfJbozSlB9b67h9MjQUBWm1r5cThqIhGgtMBOMGgmqHhzVA3PP5jcGcHbC/BN8jcplfB/9hser2FlmqR8iatjwuvnpkh7yl4i2rOkCnA81BUBZmqtzmLuHa1vQiqniIH9dCqkVHNR8b7YPr9Xws+9P42Lx96BpcBfvHMvJo9pD2EXqayUHLCLWMiK6xNyXG34HX9PbTOSUDmYuCro4njsDHy7e3q070lLzWNxySmNByb3wnm985knskCpiR7OKEKuz8U1X7BM82ODH9bLCPQzwsYeEdzXghlxXdc0cLLAKkKyuKk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(8676002)(4326008)(6666004)(2906002)(70206006)(70586007)(7416002)(44832011)(5660300002)(26005)(40460700003)(8936002)(508600001)(7696005)(186003)(36756003)(86362001)(36860700001)(110136005)(81166007)(356005)(921005)(1076003)(47076005)(16526019)(426003)(336012)(2616005)(316002)(82310400005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 19:30:11.2060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c45ae4fb-2984-47f9-f016-08da4d732208
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4759
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for SMN communication on Family 17h Model A0h.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h
---
 arch/x86/kernel/amd_nb.c | 5 +++++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 190e0f763375..60c7bd525237 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -19,12 +19,14 @@
 #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
 #define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
 #define PCI_DEVICE_ID_AMD_17H_M60H_ROOT	0x1630
+#define PCI_DEVICE_ID_AMD_17H_MA0H_ROOT	0x14b5
 #define PCI_DEVICE_ID_AMD_19H_M10H_ROOT	0x14a4
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
 #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
+#define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F4 0x1728
 #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
 #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F4 0x14b1
 #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
@@ -41,6 +43,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
 	{}
@@ -61,6 +64,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
@@ -81,6 +85,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 0178823ce8c2..ec1c226d13e6 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -556,6 +556,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
 #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
+#define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3 0x1727
 #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
 #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
-- 
2.25.1

