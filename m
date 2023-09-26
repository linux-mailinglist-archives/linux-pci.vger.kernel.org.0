Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562467AE4EB
	for <lists+linux-pci@lfdr.de>; Tue, 26 Sep 2023 07:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjIZFUS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Sep 2023 01:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjIZFUR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Sep 2023 01:20:17 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7A2D7;
        Mon, 25 Sep 2023 22:20:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIFjELBMdBNNCpOYzxaFl/3MqAPRgjTHNWeWFIFYu6SCMayGCoimGlilPdyVW42bSpLaBNBy2jzhkHPCYNMBSdnmxDi/3rJCNlkNIrNTfElOYAIxwK12Fb0dwHCTZGrcQ5lm8ZOVAcVv3YR26uCJubiF4+0NZbP2MBrN8Ydy/OrDaf5AkaCxiBlJ78yydumwBPM8ob/bAsbX+Bx5eexY9D4I6DVy1G5Wi/9w1xckfJ+G9c6ke584X0Xv+Ge7GHITVFuuT54doSfnqVtAJ8//s5fxCJ9k+ZZxe8d+cJrrIGAz0wZy4HASfFXHZ9pfM9yqmsxrMAfz8/UXDA/L5VdxXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rErPFLdhA06NBX6h55yd7LNYWI2qIAMZ0O38BTU2T9w=;
 b=fdavcyyOwP+4JJPm3HXf4ZULcBZ/0q/EJ0SCW3p/9853DPzZGdXlXoZl4/cQDi0UiHvdFGaCYbcPGOT1jP82u6k3WIRfCO+pKL19h8sa4bxN0D8/9muApT8hTehhu7Vf8TtMP9ZqsFbWmU+EFb+NkMOQv6G/qSc17Llq+Wiy3Q4E/MZVjLTFKarsZgOwuOeXEYV0ZMF+UQPSBPjies9ooEEngsyeQNn1bqpVZCmGpraZFzxumAE3f32nQVPk91ah3QTX/Jyq43pc/3xxnMgrNrvwGnt+5Yf0T4aWiRJpBVPfuRhRNzBvNIs/7aCy91AE8r6Esht0wBafkUpQr03HIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rErPFLdhA06NBX6h55yd7LNYWI2qIAMZ0O38BTU2T9w=;
 b=EYHHSjI6jOgP3x35Z+Z7iRtY1JM7VMMbED0NFzogXPZbkMPiIwTldF02x1WbMa27NJ8oD6yoBo/iSS6n8NoeYP/Ra0xjbIJDEty1i+Yr8FoYJloT/i8Oovs5vQuTDnGq5dgfRIBqAmzNqMO24m7MbsJsMLCCKx0SZ1oecyj9IQo=
Received: from CH2PR18CA0018.namprd18.prod.outlook.com (2603:10b6:610:4f::28)
 by CY8PR12MB8265.namprd12.prod.outlook.com (2603:10b6:930:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 05:20:05 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::76) by CH2PR18CA0018.outlook.office365.com
 (2603:10b6:610:4f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 05:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 05:20:04 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 00:20:01 -0500
From:   Suma Hegde <suma.hegde@amd.com>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <borislav.petkov@amd.com>, <hdegoede@redhat.com>,
        <nchatrad@amd.com>, "Suma Hegde" <suma.hegde@amd.com>,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH v2] x86/amd_nb: Add AMD Family MI300 PCI IDs
Date:   Tue, 26 Sep 2023 05:19:32 +0000
Message-ID: <20230926051932.193239-1-suma.hegde@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|CY8PR12MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f28b1c6-e933-4af1-d169-08dbbe503dfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SzKOecASrdaMsL06Mr5yX4SSM0fP9wmGgTsSV1f3/imUpA3cbsWPAaK6DJuPfXpCMJdX1CWW8yGVAaXWEz3k4QDQ3Uizb+fcKIXB42e7p1QlIy6rTpKyqFtyLs+nwev2P+pBlkOheLQjxrnGN4/Dt0Gl9G+H+txt8pavRw4ZVdVPyBu+RrjHh8W17NSmaGr8ADw31yS6eLkWLMYqjQR5WfpDPYmgPXVvOTP0WawiyfZT56rBevHVGtY1Q1bY0ffZuhr5ENG1jjiS2Wf6Hu3zT08e8gvlvQzYGfboGOAMG0Zz01QE+on2z3Nim+f5Q4PiiyANmljWSJAu2j6HLVclJiYdejR2q3YmR5gj6GHBRv0e3gGEiV0iR52FqvaXR0Z3xEhVLUdjivCMV0bC0slRndSzZEIiXr/RhLjEJ/aI+pLWkhXd2MHNIe6oGvuqXToa0reek8obholAT853lmhJx3BAWV4658Xwd1ab+d7dgTYpLK2mXCr+700Gz8o6me53sRxxG9/Coa7wRq9EE+E1eenm4wbNrKyu+MO721XG8PTRoljB3Z0/Dou2dO7D3qnQ3RkGAE3RD0crCQxN/yz6yrVdXvTWxduo6110H9G9GfFvLdimUZFdH8a8yM24wPVAkf0bocF9t0H5/uU6219AoReA2cLq9Dw6/7Tr9T/dLvZYBvzi3zTId22wp0xBLexFguMt30Qm6o73eTjRYc39qKW6Q4aQusS2zo5vwVr/P48Cd217nBYmKCcvxo9ZZxY7QTeAyIhT216gw/29vfqHO/4ft5mQ7BChhTJAtqg4H1c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(36840700001)(46966006)(40470700004)(2906002)(40460700003)(6666004)(7696005)(1076003)(2616005)(70206006)(70586007)(54906003)(86362001)(478600001)(966005)(47076005)(36860700001)(426003)(336012)(82740400003)(16526019)(356005)(26005)(81166007)(6916009)(44832011)(36756003)(5660300002)(41300700001)(316002)(8936002)(8676002)(4326008)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 05:20:04.8941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f28b1c6-e933-4af1-d169-08dbbe503dfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8265
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

Add new Root, Device 18h Function 3, and Function 4 PCI IDS
for AMD F19h Model 90h-9fh (MI300A).

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Suma Hegde <suma.hegde@amd.com>
---
v1 of this patch was submitted as part of
https://lore.kernel.org/linux-edac/20230720125425.3735538-1-muralimk@amd.com/T/#m577beb44c3eceb0371cb0306c9ea0cb51f16b16d
Submitting this patch separately because this change is needed for HSMP
driver submitted at
https://lore.kernel.org/platform-driver-x86/166b4e9d-71e7-a95d-e11a-895f2c5dd2f8@linux.intel.com/T/#u to work on mi300 platform.

 arch/x86/kernel/amd_nb.c | 5 +++++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 356de955e78d..10c2a3c9114e 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -27,6 +27,7 @@
 #define PCI_DEVICE_ID_AMD_1AH_M00H_ROOT		0x153a
 #define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT		0x1507
 #define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
+#define PCI_DEVICE_ID_AMD_MI300_ROOT		0x14f8
 
 #define PCI_DEVICE_ID_AMD_17H_DF_F4		0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4	0x15ec
@@ -43,6 +44,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4	0x12fc
 #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4	0x12c4
 #define PCI_DEVICE_ID_AMD_MI200_DF_F4		0x14d4
+#define PCI_DEVICE_ID_AMD_MI300_DF_F4		0x152c
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
@@ -62,6 +64,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_ROOT) },
 	{}
 };
 
@@ -93,6 +96,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F3) },
 	{}
 };
 
@@ -115,6 +119,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F4) },
 	{}
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 5fb3d4c393a9..91b457de262e 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -579,6 +579,7 @@
 #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
 #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
 #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
+#define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
-- 
2.25.1

