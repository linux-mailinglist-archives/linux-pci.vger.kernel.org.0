Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83406662FA3
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 19:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbjAIS50 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 13:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237376AbjAIS5T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 13:57:19 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE461C92A;
        Mon,  9 Jan 2023 10:57:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8MNUYiSHoTo6CA27NGecjfTJItZFD9Icu+CAKcQV5XHxAA7I3P8up5JnsBgHdfE2o0kiHxN7NgLaokpLVrntosZ4UB9D3U78IrAhTX0/qfut2Z2LFD2A08geD9UjdhLWAvDcAi8VoAV/ZfFkirl5XFcp0cLg8jjJ+1YQJFZ5Q/BrGwZygFJFYaTB4c9/pg++VfHmI4qbM/FHDrCy5Xefpb/bv3zDlfqKpI70tHQKAPU+A3A9tY3uQXs2yFTa58Ko9AbIUXhjMtqlRE/8oGsWn7bby82yqcQuoST1M57gIRGnihUNbXkI7kx7P+sCr+GUhb0GzlER4QGeZs9Cth26w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KarMdi42u+/IAKp2JXuYoWN2rUUCErnnjvhJBRY4oxs=;
 b=fIDcM0fH+jUZxPgQs42FqE9W06At+Jn/qSQE/Kv74YJTGvzCrXGgdPSUPCh6bp83rxMTa+3zjTKxp9/woC+5BZYkpMGB+8xbp/ljCsSNcUdip5z0jJwflFRRPQSUmi9YlN9Xood9qu/BW2YbhWIqvnsP3IrWXK2joCYrFRh1qvZ3b3G2kNlz2Et61/nWF7A9K3SlipJoCE8T55SypKhbg4II3CE+yxZd9W7S4LYhbsjJCc5ZKyjBHt1OoTf9KSjYCsU7r37M6LlNUAmc67LPEStSGHCSd7zlz37EPeIElTAohL3vTHg9sc3HAGbezk0pI7CdJx1gEY0t9nqlCmhGjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KarMdi42u+/IAKp2JXuYoWN2rUUCErnnjvhJBRY4oxs=;
 b=44gvzZy+KOMFHMyimm1CLFRS0RNabvJa/2sPrS05nhXQtkYOKB6Gq3uZ5FmRiQieBgR8nwsUFak2kFjN+EfZ9SsZsqNnovBvR7X+S2MV1XHPdMYzlHm8QUoUj5EyhL+8iAFNQ4A2yGYUytnPg8IgylmwfbOeANMogeU6rhT5lWw=
Received: from CY8PR02CA0009.namprd02.prod.outlook.com (2603:10b6:930:4d::29)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 18:57:10 +0000
Received: from CY4PEPF0000C96C.namprd02.prod.outlook.com
 (2603:10b6:930:4d:cafe::2e) by CY8PR02CA0009.outlook.office365.com
 (2603:10b6:930:4d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 18:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C96C.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Mon, 9 Jan 2023 18:57:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 12:57:09 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 12:57:09 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 9 Jan 2023 12:57:08 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH V6 3/3] PCI: Add PCI quirks to generate device tree node for Xilinx Alveo U50
Date:   Mon, 9 Jan 2023 10:57:01 -0800
Message-ID: <1673290621-22888-4-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1673290621-22888-1-git-send-email-lizhi.hou@amd.com>
References: <1673290621-22888-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96C:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: b74b0686-2d38-4c8b-a006-08daf273500d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qsigRyYsR4wwSEeLmUkTaRufkF5KBUEJlpwMMnvTgWW1CW8CZOqQl/6ZWwd/X7VNBXTNc+BczXPGDjCGcGCHv9hhSnbyfGLEBXTI41JilC4YjWgAuWjY3RLy/34YQxDszMrNkpTCrd5k3mgmpHOYyUiTGZi0Xr7tLCecQ5in0UQf2peTi32fwdYdNtt5HEhdFAJCq6H4d4LgL/Ys4mIDgab4OyoeoYL+JiT0wzqUNEo4U8Y+dj7y3XLIUpYdEbSzQ4vQZ7EHGNoLpw9LUWgXn932lVzab3/LheP+dcVFmooAXF5z11yApxut3UekQIWKh/COw+43sYrcMwhpEdd28wuENzcrTBUPWsXOFl5O05q3ljHZ5fD97q/alfUksj2/Kok2bGWgCwm1AU3KV1dJpP2sYv7Mzh1tqiAh9+xxr8+oravO7FhqejAV/oA1K1v0aiWCovxSfJrlUxWAE6F4WFvZyRyn9y4ZJRl48MgUhWXxWopp505ewO7O1k7EYhmLK1yYN3FB7cgfIAKH1Ew6jwsj9mHkbptcAi+P2N+R0jRrIBsnmwjCvCgsgpO/GMo3oNGcisLKWHLJ9lCPLgOaKPrBjhmEo7K0DGvkivHwwgaIFK0u2rmmBeOuuZmuIhk96gPQzREHSVL8ww5te4UuX4F+GsRAuTSWpFTOWkrZBl6O0N98qKfgSGeg3W0qW8fgPVZnbiGp3h+e/pqdlqOvRLeUv4duc+jHckG/JQ9Ta3E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(316002)(5660300002)(44832011)(40480700001)(26005)(186003)(478600001)(2616005)(40460700003)(426003)(47076005)(41300700001)(110136005)(54906003)(336012)(4326008)(70206006)(70586007)(8676002)(82310400005)(8936002)(86362001)(36756003)(6666004)(36860700001)(82740400003)(356005)(2906002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 18:57:10.3639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b74b0686-2d38-4c8b-a006-08daf273500d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Xilinx Alveo U50 PCI card exposes multiple hardware peripherals on
its PCI BAR. The card firmware provides a flattened device tree to
describe the hardware peripherals on its BARs. This allows U50 driver to
load the flattened device tree and generate the device tree node for
hardware peripherals underneath.

To generate device tree node for U50 card, added PCI quirks to call
of_pci_make_dev_node() for U50.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Sonal Santan <sonal.santan@amd.com>
Signed-off-by: Max Zhen <max.zhen@amd.com>
Reviewed-by: Brian Xu <brian.xu@amd.com>
---
 drivers/pci/quirks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 285acc4aaccc..f184cf51b800 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5992,3 +5992,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
 #endif
+
+/*
+ * For PCI device which have multiple downstream devices, its driver may use
+ * a flattened device tree to describe the downstream devices.
+ * To overlay the flattened device tree, the PCI device and all its ancestor
+ * devices need to have device tree nodes on system base device tree. Thus,
+ * before driver probing, it might need to add a device tree node as the final
+ * fixup.
+ */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
-- 
2.34.1

