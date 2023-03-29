Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EFA6CF10C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 19:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjC2R3l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 13:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2R3k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 13:29:40 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EED49FA
        for <linux-pci@vger.kernel.org>; Wed, 29 Mar 2023 10:29:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGNLXvuo2PdcQ+RZ0hU1tXx5YtIfTKFThwFTqSjnPXL5aBTq5SHK0VjcBhNSTPtx/z0Li2ctytqGyiGq1Ktv4nUOXgc0OS8BVHKAR6SAV+Vrq8L66rnB5TovyCqdTYUwR4ULZ0xZAOLzRFWdhUX9ZGQ1sut6LE8hS8R2XIGreeONcqNc+x+WGanZf0mh7lh91balL6P7WcT4PPhhgHEyuuGdNgsnIeXW9wkzuAk8uFRMDlqoHc1Mrr7MyLQBmRn97OgTPDaGS8xV7poO9bsqLEK1Wp4lfWchVCNNpXoMuN3RsKjxTSYFu7F4+oclrZ0a6CiSJsPGknsLlqtai2ujoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39OsLylqr9MvlnEUM6aASLxeKisosw3KoyU99cJt4RI=;
 b=HxeTy2o2XqDAAsbGDGrymdV7/PxO6wqj4YZGdgSdp/+kS216iUWz3EM/C+n37x6H2S9nVgSmDryasIwg0oTj+u24RZ0g6n9d1PXFpGnf58ZqaRpkmqg8qM58m6P7LqroUqqMvO53XxDa1/w3M8qMOW514JvBixGPqHXqgDC7CsahuOaO3A5umOyI9JYc60yu0jdUrDzIpLwlADmvEcZVgj5qQ8wHWw5GonqWCjU82aax857IBawUhbqXoeEa1m5xEejCkuLm9qrRn0L7tvF4A+YZD/K0vztrxMR8/Ak8cxC4HwrcvVFy3Dw86ecCXzdykNJybhie/FZUn8vhfSdvRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39OsLylqr9MvlnEUM6aASLxeKisosw3KoyU99cJt4RI=;
 b=YTTM03jSkEhBzWtGEYfizgkeilyMHj5GSFRf1JFWlALc3VhJMY7/WLkcIywqonjFRU84UIgHKc9WVCRlxwplsgltktJPoEjwYkbY4Y3Q49dggAZHfZeOQqICfrRgS9T+Iufn1rAhndlftzL4/zpwSnOz+3+zXC12O5cOyvnaQ/8=
Received: from MW4PR03CA0004.namprd03.prod.outlook.com (2603:10b6:303:8f::9)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.41; Wed, 29 Mar 2023 17:29:36 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::4f) by MW4PR03CA0004.outlook.office365.com
 (2603:10b6:303:8f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 17:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 17:29:36 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 12:29:32 -0500
From:   Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To:     <bhelgaas@google.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <x86@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <mario.limonciello@amd.com>, <thomas@glanzmann.de>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH] PCI: Add quirk to clear AMD strap_15B8 NO_SOFT_RESET dev2 f0
Date:   Wed, 29 Mar 2023 22:58:59 +0530
Message-ID: <20230329172859.699743-1-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT021:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ceccf6-bb56-4edf-1c57-08db307b2b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4yEOuGFwBwIfFPJcVqpd/MGoU6nvSgfd9fZq/j1dShg0KApxmokK/OexPRu3TtbcA1wqICnUtqsja4ncUDg7xxfxQvd3xbWy/hCgqy2mzSo0x24Q7wMAARTrtnhu6FVIykYmpJNVR9mO5t6QnQyX8zsej4AfYNcAXZrZmdAoGhGbMldVgMyXxfadotqEOLG21CFKi/ikYsp4Q1RiWxVdMclHnq4853PVb7cTSFkaoKixQrr/FvNZnHOj0Ekqxi5f7kYKntX9sMseJ13Ihczxwf5iVAEr01/96UzxdrHJ7XP8gPjLNjUXx1PIK+zqrEJSqZhnFFLCQqINvQdAtuShv9/BKb4WkxnsLkt81geF4vME++9qOW+FCcskOhJ+UOHYJeV+kbAmPspIJmY8ED0wztuq5X5zVohGNqu9QJNDQ7CB+hAf/OqQiGZNWNfSmBFQNETQwpl+8F7xhgSewRQzSHVoVwCmkxHGRsKWu2w8ab5NDox2jS8o/AQDrLCwfEZDbrh5E0WX2WvbxtkcPvv7jVsC5Ea5nd7yEzzsDi2d8Ct5MHhy5IuLmhAGU7yXKLfw0dcvHKPdXM9QiYSocbWR7VE3v7v5ZOYN60YuD14oFwOB4Ttoi04l92mVxEaU2mH2PtLjM41LsiUIAu/7XvU/cb5pzfVtsTHsdIv4nnIoDMA1IB/Lu1vdcPNfvhBuiWZU6D+B9nFriiPPIXaXunYA/VKh0RuRVa5PYiZnfIIOvA4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(81166007)(70586007)(16526019)(70206006)(41300700001)(8676002)(40460700003)(2906002)(5660300002)(186003)(82310400005)(83380400001)(36756003)(36860700001)(47076005)(356005)(86362001)(426003)(82740400003)(2616005)(336012)(4326008)(110136005)(40480700001)(478600001)(54906003)(6666004)(966005)(7696005)(8936002)(26005)(1076003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 17:29:36.4326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ceccf6-bb56-4edf-1c57-08db307b2b23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The AMD [1022:15b8] USB controller loses some internal functional
MSI-X context when transitioning from D0 to D3hot. BIOS normally
traps D0->D3hot and D3hot->D0 transitions so it can save and restore
that internal context, but some firmware in the field lacks due to
AMD_15B8_RCC_DEV2_EPF0_STRAP2 NO_SOFT_RESET bit is set.

Hence add quirk to clear AMD_15B8_RCC_DEV2_EPF0_STRAP2 NO_SOFT_RESET
bit before USB controller initialization during boot.

Reported-by: Thomas Glanzmann <thomas@glanzmann.de>
Link: https://lore.kernel.org/linux-usb/Y%2Fz9GdHjPyF2rNG3@glanzmann.de/T/#u
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/pci/fixup.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 615a76d70019..bf5161dcf89e 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -7,6 +7,7 @@
 #include <linux/dmi.h>
 #include <linux/pci.h>
 #include <linux/vgaarb.h>
+#include <asm/amd_nb.h>
 #include <asm/hpet.h>
 #include <asm/pci_x86.h>
 
@@ -824,3 +825,23 @@ static void rs690_fix_64bit_dma(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7910, rs690_fix_64bit_dma);
 
 #endif
+
+#ifdef CONFIG_AMD_NB
+
+#define AMD_15B8_RCC_DEV2_EPF0_STRAP2                                  0x10136008
+#define AMD_15B8_RCC_DEV2_EPF0_STRAP2_NO_SOFT_RESET_DEV2_F0_MASK       0x00000080L
+
+static void quirk_clear_strap_no_soft_reset_dev2_f0(struct pci_dev *dev)
+{
+	u32 data;
+
+	if (!amd_smn_read(0, AMD_15B8_RCC_DEV2_EPF0_STRAP2, &data)) {
+		data &= ~AMD_15B8_RCC_DEV2_EPF0_STRAP2_NO_SOFT_RESET_DEV2_F0_MASK;
+		if (amd_smn_write(0, AMD_15B8_RCC_DEV2_EPF0_STRAP2, data))
+			pci_err(dev, "Failed to write data 0x%x\n", data);
+	} else {
+		pci_err(dev, "Failed to read data\n");
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15b8, quirk_clear_strap_no_soft_reset_dev2_f0);
+#endif
-- 
2.25.1

