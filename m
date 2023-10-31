Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB407DCDF4
	for <lists+linux-pci@lfdr.de>; Tue, 31 Oct 2023 14:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344551AbjJaNfG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Oct 2023 09:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344524AbjJaNfF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 09:35:05 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DB1DE;
        Tue, 31 Oct 2023 06:35:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlCaGa6SLv+ul3Bsrjh2DqA2AMxpWm7SUMYyh43eKjKPPPYeXK6AFYpssBEJf3fWy+EzgXmLUi+jaVkOilAo2FnB3dnYyJz+IYXWCswk14ljbXJ1TCQppEOyefbwSb/ET7v+tKHRdyVavrcgsBWQhDbJHy1yAmyK1O7eGMSJr/CPMJyc8NRI3YKfpdAewKpnsH6CBsIp5JdjaWqzoYYek4w9PWAdYm7JeMRbjpqXnvflgc3TD23okHAdmNvo4ivho7TFotwaPk4+YXrr6JrqN6mHxe94Vm8Bs86xTuQhJzYxNr3NE0m/rP5zjmxrDsuSC6Z4bntvOvHDvH7Pn//1FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJCfI9albUrQlYmxaZRBNCVnPrUm6j8urzsOUYlkD6A=;
 b=TJ6UQylMJRX2v4S1D/SxQpFJv3BVeN+Q/1UasUxmhNZKeAXJF4vOPafKeT30RmM3pm9vzQqCDbTphCaW1A6qnDBeEBZnyFoIFr3vkoE6sR3P4g/fbF/ff7EOkiyPblUd1d1sKfop4GCh7+XRMqEyINRL68l/b/nfq/qMpRH+VA4nIQ319VHBOUS8MuBmrGS+2fBnnoeLErNAn4yIpB+NWsx7r7V+EZuHeLy9wzFLZpEVt2t0FK1i/dnp8w/a1pYzDM1V3ucjKQLlkqa5sh0mjOMMdqcx1BGpvZaQFBEmKNKHwWH+5S2svhzhiidyItJ0DQtZoiiJmMswgD59h018Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJCfI9albUrQlYmxaZRBNCVnPrUm6j8urzsOUYlkD6A=;
 b=U4a4O+Zq65orEqW1yZraKHqU6OtTFTebMidVDX93tqUUs8DMlvwE9GbvuHouCWKXhUQ1z98K0iNtVrVGqHWF7oMBVSXfz3CfV0PSi0oYC+xuMCHs6eEdVJmAmN+oHhRV4IiMws+XU9vl4Pan6X1tOnjvDwgz6JlrM2FvhUcuTsc=
Received: from DM6PR07CA0107.namprd07.prod.outlook.com (2603:10b6:5:330::21)
 by SN7PR12MB8026.namprd12.prod.outlook.com (2603:10b6:806:34b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 13:35:00 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:5:330:cafe::b8) by DM6PR07CA0107.outlook.office365.com
 (2603:10b6:5:330::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29 via Frontend
 Transport; Tue, 31 Oct 2023 13:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Tue, 31 Oct 2023 13:34:59 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 08:34:58 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <bhelgaas@google.com>, <mika.westerberg@linux.intel.com>
CC:     <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <YehezkelShB@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <Alexander.Deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/2] PCI: Move the `PCI_CLASS_SERIAL_USB_USB4` definition to common header
Date:   Tue, 31 Oct 2023 08:34:37 -0500
Message-ID: <20231031133438.5299-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|SN7PR12MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3ab4ce-e009-4636-5502-08dbda162e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QMlAJ4kMljvANEx5t9Zvt3dCSgGYlsTcI+Q/n8qVEhe9mmW4/Vmfphe1bXuHS8nmrTnluAQ9gj4n/AbfPk6HnDYHKg4Sd7kruxnsvK2LrjZPBy+3zwD9WFe/+EoBjehSS5df8pQQOOzWGZNoOXhUGh/BM0gnReKWMEzwTIpcdxTpsHaF/yeV56qFZoDQm0nLlo9gh8IpZR26ZLEZCsE3TIY3xNHQg/Rnb6iqyWgkOUJnoWXXQwP4rVHFoBEfahf5K9JfYmEEYJGPbe0FscGuI27eLIv45a6AtTx1hd/Jb2ttLQ/lnmEY9belQdurR8v42BJPapeZ6/BYQ5cwG4RTabTbFBmefFr3QXa8l3ncKPKd3wGqvBxgYBk8v9/02BaaOQ6ipikTXpWwbiWfyIKaLqHCeB3rm1g0GtLAxt8VsTZDBQAMQLv7MNfDEW5fSIP4+5pNpEBC+m9LvW1My7/1qetzObihNrDiecIyiG6gl2r09ZQUyWnWURd12qWPG5Qki/h0jWMsDNzOSobg0Deg4BnQaMHyk5npOCLj6fwxt2vPsmaCQzxvK7rcpfY98Jy8EUUlZKes/SFOfOh9vjuTx3ROWhDjVp5/daRYXtH9yJ6c+t3MdrRrSvekhAsSygVrdCMmYMA4nnA7bjZnBqIyN2TlD9hsvVkOgVzMlCzu++mBGnFhuZDqXp6ZsSZLIj3exzVnEWzGAIQJslQTsPsaFmVIKijh1S+sw88c0ivMX3q+4YuZM9nhOS3f7RRZFzKQJXgjKi4lIQcOynO/bL02009VnXQ9GtHf/TvLX5tyclY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(2616005)(1076003)(26005)(16526019)(7696005)(478600001)(6666004)(36860700001)(47076005)(336012)(426003)(83380400001)(5660300002)(2906002)(41300700001)(44832011)(110136005)(70206006)(70586007)(8676002)(8936002)(4326008)(316002)(54906003)(82740400003)(356005)(81166007)(86362001)(36756003)(40480700001)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 13:34:59.9929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3ab4ce-e009-4636-5502-08dbda162e1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8026
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

`PCI_CLASS_SERIAL_USB_USB4` may be used by code outside of thunderbolt.
Move the declaration into the common pci_ids.h header.

Acked-by: Mika Westerberberg <mika.westerberg@linux.intel.com>
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

