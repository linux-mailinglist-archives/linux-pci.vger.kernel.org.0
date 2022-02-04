Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AF34A9F01
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 19:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbiBDS3L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 13:29:11 -0500
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com ([40.107.237.46]:46689
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1377511AbiBDS3K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Feb 2022 13:29:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIWmcYsbY0CKhsaHgAiEzAIHlJ1kWrkuARxzwupU2WlXzw5Wgb1/hnV6wbKVZ1+QYnrrBIMXnpIGsVFhF6OG70w301lgBwgY73p5lToTAncD3W2PXZDe+eqQFWk30uqiGJwZsuRkvYiDoUjuXUqDik9VUjZjuCkMRY/jrQcDVrsOp+3qTCQIJXpjBvfRBzYtsqhDv9JoGmrg+Zab0e9mzm3SnazTjRCH3HCDXUfhd3DZcv4FcsPslpQ4ZyZBPUbGl95W6gF67etWL+5aUhDFxzGn6Obh6abVYHKq1IgP91vH/NILiQ2RMig+QtdnPuIHiXv0Dhn21ozJpz4q/3W1FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rKIF1fpsn4PKDC5NrB4Sqvqq2Mvj2Q7uc9T29UOur8=;
 b=brzBXpJ8+YVL7JHnSjvkm3U5YKW4dVovAXvUbUfovVNSD9E5vbR0uVdnyucV+bc64NPjF3avCT6ShfIqZH1AfZ6AjUhy3gDtyzfJfhft0cMq5/xFj1W4G3Mhu74WMB3+Cb+YpAjT2nnZ2DQmejl01G5Bqe7PNarz9RPZr1K27V58WvS5p3DpMTxXOmDPrKI1qzOuJrIEX4/wudhvFA2JX5fes84Y/TZwLkO/uL7ms7MUcKpSW9HPVZMYGd+ReclWb5vgma91SnHzIa7ohNjDTY826iMW78s7e+8/kEa4MIKrFoTqTmKlLu0vUlwgBqCjkjReA+EMosHBTx/+y5IUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rKIF1fpsn4PKDC5NrB4Sqvqq2Mvj2Q7uc9T29UOur8=;
 b=XzyGrJwqn0XPIEpUohs6/H9hOrMWWUhFo73XulusbkAy36dcfMzIKreK0aJqjIs1Wogim2ixTebBNOOTbv2878wFjxJShfvu6hyGQWInKBwucqQucxvtG5kMNavDYAsfh1p13GjrZ4vmf47TGjFqJ5rpBTq9fAF8EoQrr9008Uc=
Received: from BN9PR03CA0803.namprd03.prod.outlook.com (2603:10b6:408:13f::28)
 by BL0PR12MB2561.namprd12.prod.outlook.com (2603:10b6:207:3e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 4 Feb
 2022 18:29:07 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::be) by BN9PR03CA0803.outlook.office365.com
 (2603:10b6:408:13f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 18:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 18:29:07 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Feb
 2022 12:29:06 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>
CC:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        <Alexander.Deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/2] thunderbolt: move definition of PCI_CLASS_SERIAL_USB_USB4
Date:   Fri, 4 Feb 2022 12:28:19 -0600
Message-ID: <20220204182820.130339-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204182820.130339-1-mario.limonciello@amd.com>
References: <20220204182820.130339-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5209e531-d0e2-44b1-6af8-08d9e80c3b15
X-MS-TrafficTypeDiagnostic: BL0PR12MB2561:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2561676CD1814CF43A93FC0AE2299@BL0PR12MB2561.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T9/zyk48gOmXaYA+gahuhnW28AJUrs1XiihfAC5nz5UgzSZb89a8o374+aHeKpaPsqKz9dVk476KkkLXTmXsvA0Yboso46r+CFgbk/+ni0S3nYqulTuSgWkhxcsJUc1b4C62hEbaRo4uFt5Fhud6KcHE7BubKrobkWqxbAJ+mGCxggVkfLkRYVDnDAkjyLJ1/OAGP7ZQ7XgGJl2y1xxRZ0bQoz+fzCMA16N2n0/K3/a33GqBhlDQGkj2CuPN7CMTS/SJIMLd6JcAtOsb11yjOaxW1Lm3zT0KQli+bB4x+SoygoIwyTD15uK6HO99R2dHwbXRLPoJ7ceTXudcPk/GbZzGCd8wHVxXkWPQDxLe+DaG8BYe9ZkTfFTFxg6LHOAumKH4gHbYWFiKuUHLN1bSaFuzfKSTh1Knc9+d/tgkECaPqTgylThY/kMMbJZE0bJWpSDEZ3g358gHTIbPKeZHowGiyuRu91QyMhVILYAM9aA5U4GQQojA6nteIh1jHcgS0eEyFp9qyjFVWua0ZI4tiIL+hFW9eDzhyjIajCark0PMXJds5ajY8uPt0zQSZwChdwatrQyhzFvqpOmu7gnOO1M61rTbPLmAbsYm+Z18hupVr0cWAEjtFRBJrk+Ze9JD8PaqwGXoHzyxXWdyV01oPAaDO5Llq1+7HSxfHQx96Njt48ZBYShpUY+BbwpI+9GVcq+OaPGXejuhVOPrZUGzug==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(316002)(508600001)(36756003)(16526019)(1076003)(2906002)(40460700003)(6666004)(54906003)(110136005)(336012)(186003)(44832011)(2616005)(26005)(426003)(86362001)(82310400004)(4326008)(36860700001)(70586007)(8936002)(8676002)(70206006)(356005)(5660300002)(81166007)(83380400001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 18:29:07.7521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5209e531-d0e2-44b1-6af8-08d9e80c3b15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2561
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This definition will be needed by a pci core for upcoming
changes.  Move it into common include file.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/thunderbolt/nhi.h | 2 --
 include/linux/pci_ids.h   | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/nhi.h b/drivers/thunderbolt/nhi.h
index 69083aab2736..79e980b51f94 100644
--- a/drivers/thunderbolt/nhi.h
+++ b/drivers/thunderbolt/nhi.h
@@ -81,6 +81,4 @@ extern const struct tb_nhi_ops icl_nhi_ops;
 #define PCI_DEVICE_ID_INTEL_TGL_H_NHI0			0x9a1f
 #define PCI_DEVICE_ID_INTEL_TGL_H_NHI1			0x9a21
 
-#define PCI_CLASS_SERIAL_USB_USB4			0x0c0340
-
 #endif
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index aad54c666407..61b161d914f0 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -116,6 +116,7 @@
 #define PCI_CLASS_SERIAL_USB_OHCI	0x0c0310
 #define PCI_CLASS_SERIAL_USB_EHCI	0x0c0320
 #define PCI_CLASS_SERIAL_USB_XHCI	0x0c0330
+#define PCI_CLASS_SERIAL_USB_USB4	0x0c0340
 #define PCI_CLASS_SERIAL_USB_DEVICE	0x0c03fe
 #define PCI_CLASS_SERIAL_FIBER		0x0c04
 #define PCI_CLASS_SERIAL_SMBUS		0x0c05
-- 
2.34.1

