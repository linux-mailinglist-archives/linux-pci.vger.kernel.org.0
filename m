Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B9579DF13
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 06:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbjIMEK6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 00:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238403AbjIMEKq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 00:10:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B61B30EE;
        Tue, 12 Sep 2023 21:09:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiTVg/AQvFNQiNzdUS+yOJTCQdlvH+jRS30I6LnbLGVqGc2qr72kiugvsMt5izq5uEiniKXH2A+ykfd0MPpZA9xhfyHcoueMScfaD+631PdtJ++8bVAdzujN5mSaME+ePanbScvOI5gjwnpFDD2XxnLhUMVCwHnOioyJceAktIUgfpeRaufNQlOhV+kn6LA7tlT0Da87JeL37hyNVnmS1/hUTXlHtjdd3DHpKZBVeFlRxUSv/t+f0YrBqYgBUQcV+5mCfibMcbqDgpc0e6DX726xuAjAx90LbbzghkH2W12iolNl7ST6Rl6irKIVEpAZ99TFKyKDTdkutGz2LPHKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFMLG51dl2hcXBUWl1vTvdtf1S19g+jQkXiHhfsVTKs=;
 b=R2iPpIh2l9cbTSZza4H+pK6yN2+YC6NFDS0Ak3NVPCfeukLW+pN/dZ0bubBufz6uvP8eYO1D4mMfEP7p3HbysUO/DWnn8KMTB2gvGwekXG8wQ7squlMwfy/XxQtTbpgfL52KcO5/ZEVxszpwktFgOqQQptcl/sGDz5p8zzKmR30f2O555ZFt0EmVrEy6h+mAxNzl3O+YnNknrdxMsHPxLyDe1palVk2g2O5MOhcYJ4UB7A22+DOOGqLcC+N0JANcPVUCIfw6LoZHjnkyJLmosV+kWCzMFi8AdHUDJTqg4ORliGeN8BV9Bevh8iVb2YTnSFyt38FvXJSsY/dQ39Qesw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFMLG51dl2hcXBUWl1vTvdtf1S19g+jQkXiHhfsVTKs=;
 b=RgkdUhpkNnviLN+HmU2Olf09svxf2Jbc1bUR24dk5Pz9dKR0OQgBTKJ+fbuIEB2bkLdSkuLiXCkmlZxVNS8gMcclqliEQRs1wtwKdwSMZJ+iY8FuKZMjZFZbCGc9Y1epuelGse5tz20GjSoiS9UTSoIibRf/Qc6BbkOMrqE/ydo=
Received: from MN2PR20CA0026.namprd20.prod.outlook.com (2603:10b6:208:e8::39)
 by MW6PR12MB8867.namprd12.prod.outlook.com (2603:10b6:303:249::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Wed, 13 Sep
 2023 04:09:36 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:e8:cafe::a9) by MN2PR20CA0026.outlook.office365.com
 (2603:10b6:208:e8::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Wed, 13 Sep 2023 04:09:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Wed, 13 Sep 2023 04:09:36 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 23:08:57 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        <iain@orangesquash.org.uk>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v18 1/2] PCI: Move the `PCI_CLASS_SERIAL_USB_USB4` definition to common header
Date:   Tue, 12 Sep 2023 23:08:31 -0500
Message-ID: <20230913040832.114610-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913040832.114610-1-mario.limonciello@amd.com>
References: <20230913040832.114610-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|MW6PR12MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f3a70a6-fd08-4c32-2e10-08dbb40f3e3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dA7vjSV2GHIxyBlbsNs05UQ8QMGlPbBSGeaBIltCHH4G9XlxBAo8fzyRLW0eTy37jB8t8xYuqo6Jg4UULW/oPqYYnrk8bR8b8MXpE/cincH973TDgbAhndNv665NpYSSK23rKr2Xb8JscX1yrXIwHsU7E4kQMmtXhnPe/Cz5GynUsTnAE2mNp7ycMVr4PP4PZ2fbjKg9BUUZv/WG3UK3Ecjw9b4pG/wGHDcp6OQSSHuZlDxhFUwZJHhjYtJ4X+wdkClClZugyuUDLpHHLQVcfpskxLw45NcuAP3gm42xyJMRFYSd7zgpgp1ZrXSt5CchaUZKsbyq2VHFfejp2MJqD6ZmT9PVk1cvtGr2GYJ4cM+OnFN4wUc/C8on0NsX1lme12lWammGGvspcqgRgEhVzvzfTy/kmeA6/nI62l0ruLVTa1aXoD/Ndu/w5vA4H/Oyb6z2u2ClNA7snA7USSTgVkahefTZrZtPN4W8vb1SyvDC/GLY1EXNbKdw/axWmZEsQANVvpMh1ChgIe4AxGfHWWh+zwrz3rWo3HoD8oTcaeUc+MxUCAEtwsyX6ICdMBl0ELxab1ZSU+JR8zMFnPOveDyhkLeoOqYInBiEHvNQfzqCRDRNMiPRCw8FqHvZkOSRivN87ABwZvwpFtsgYJ8qdD88/hVhELPbR41MnVfLWDnkGQyeciHB9daRBFWafmkzaA37F1X2St2HfXQRUghyhmeyZDP0svAP32Jsy0J+nUTGiLqsz7Im8oaUrcp8EHtp76ox8Ms9ljkjELxTG42WNWd7f1vQxJuDv4HOOXNs3rU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(186009)(451199024)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(81166007)(41300700001)(316002)(26005)(336012)(16526019)(40480700001)(426003)(1076003)(110136005)(54906003)(44832011)(70586007)(8676002)(70206006)(4326008)(2906002)(8936002)(478600001)(5660300002)(6666004)(40460700003)(7696005)(36756003)(36860700001)(47076005)(2616005)(86362001)(83380400001)(82740400003)(356005)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 04:09:36.4359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3a70a6-fd08-4c32-2e10-08dbb40f3e3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8867
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

`PCI_CLASS_SERIAL_USB_USB4` may be used by code outside of thunderbolt.
Move the declaration into the common pci_ids.h header.

Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/thunderbolt/nhi.h | 2 --
 include/linux/pci_ids.h   | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/nhi.h b/drivers/thunderbolt/nhi.h
index 0f029ce75882..675ddefe283c 100644
--- a/drivers/thunderbolt/nhi.h
+++ b/drivers/thunderbolt/nhi.h
@@ -91,6 +91,4 @@ extern const struct tb_nhi_ops icl_nhi_ops;
 #define PCI_DEVICE_ID_INTEL_RPL_NHI0			0xa73e
 #define PCI_DEVICE_ID_INTEL_RPL_NHI1			0xa76d
 
-#define PCI_CLASS_SERIAL_USB_USB4			0x0c0340
-
 #endif
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 5fb3d4c393a9..29aeac53dc41 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -121,6 +121,7 @@
 #define PCI_CLASS_SERIAL_USB_OHCI	0x0c0310
 #define PCI_CLASS_SERIAL_USB_EHCI	0x0c0320
 #define PCI_CLASS_SERIAL_USB_XHCI	0x0c0330
+#define PCI_CLASS_SERIAL_USB_USB4	0x0c0340
 #define PCI_CLASS_SERIAL_USB_DEVICE	0x0c03fe
 #define PCI_CLASS_SERIAL_FIBER		0x0c04
 #define PCI_CLASS_SERIAL_SMBUS		0x0c05
-- 
2.34.1

