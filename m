Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AAD4DC73E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 14:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiCQNL1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 09:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiCQNL0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 09:11:26 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86384169B33;
        Thu, 17 Mar 2022 06:10:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYiEM+Mzay0qD5KQxG5jYZHmHjEa0y2wU26ong2FdyLMBN2T2jxGD0RnmCZ0BFZ2miHXrRZ5QhLJkn/7qQQ5Slx/VLDRGqnwIwXKs50BWF9Kk9+DWIST4/m4vrDS75a6dRCosu5UCXFwqjHrCQrhoPxXiJP2Z9FBs+vJaNaUZbHcVhjJJpeQVuvp/YEM4JiXk34/NQ9N9KOg93s20otmaYncZkxiHdb/3mZo3QyO1URXAc+EuzM6Zgt0BqgUqh5fyb1aGqec2jAAudHacUjoj8UVw09zb2bDq+i2QJOmV4iy72cqGxilZl1XJic/7qC3PnfWAxOERGhfRWZ5HQlf7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhhKZx7+BsIC0HzZAGgcrjuiAsFdKZTS95mXPoyuvpE=;
 b=GfE+MV8YA0xn4P7MoY008fn3IXlpDDrCLCO0IaWtPbkncMARC3nvVNaFWpEGh85c+EkAqUYmGM7qETcyoyRUTqRiU/fUob5UvB6saMxqPXCiUIeuTZe+F8MLcUB48H/mg2i6u9huds1Y1PcASIJtNRaUR1K3rjZI6mU34/mNHblpYhEYsTuNE0hKE0KDGY0kxJEy+4NZ6NRn6BYsOA1Bq7ytOHRYh5JSrEEb0yYG/YNRAlpo/WWTWxuAFoiObVjD/EBqzW2p0cv+DRASIprc71tXzmXYmqWjoJlbjF+mu3gnEBzDomlY/TpEdAy5qTzEG6+Dfj2K/hpN6MgZ3lTqgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhhKZx7+BsIC0HzZAGgcrjuiAsFdKZTS95mXPoyuvpE=;
 b=MViwp8XQzBqs+fdjJVCG+LdL3LMqNcZmafrz3lq9ZMsajJLXYaXppTpJwVLYDbI5x3AoyMqf+BV4CNr0SgEE4YWkeloDNeUzqBw0UT48+MpcaKUiokLeDMKW+BNcgyxF5+XZvBe6pSYG8e8cXiz7aXn2d9nqTBu1diOTUakW9w0=
Received: from MW2PR16CA0068.namprd16.prod.outlook.com (2603:10b6:907:1::45)
 by DM5PR1201MB2475.namprd12.prod.outlook.com (2603:10b6:3:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 13:10:07 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::36) by MW2PR16CA0068.outlook.office365.com
 (2603:10b6:907:1::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28 via Frontend
 Transport; Thu, 17 Mar 2022 13:10:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 13:10:06 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 17 Mar
 2022 08:10:04 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] PCI: Disable LTR on suspend for SSSTC 0x9100
Date:   Thu, 17 Mar 2022 08:10:07 -0500
Message-ID: <20220317131008.6395-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0098462e-fe8c-46cd-8dfa-08da08177542
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2475:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2475F7E8694F8F4E6F63707FE2129@DM5PR1201MB2475.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HO3GDysPs0HpeRR7lpAa+Av39NQwEdZkTc4hXNB+8ZK/RAmJ7kXToJbeoy2ec6UzoBDZB3sUe2CNadT3/U7+eMj4oq/ACo/12GYvqSXuw5ER6Oz5oKpuxGcmAuD/jbAlgw755SeVNkyY58FMjjueZSfL3u0/4wgb5MD25i5yz/MEi91bYssE6KCwwy8HRzH0ZZBMxf6FdvRRee7CrVQubxSnCcakaGL4B1OGTlpxhwBPbGqxldNOD5jYra44jWexQNDmfrh1kUpE9eX2+EMjOwmPdEEozcw1V3sxgMYXa/WcynHn4wVcP85gTw8AmOOX4/RCTqFz86aoehkYwHSzeG+NGmuvc7S/M9WWWL8b61gE4wOqAoC/MehtQn+54YLsZKVxUxseH3uRRZiYmKjGSlcRX9KuPh0PkGOLG2BhSc28jgZ5y3aPQ2mxUuLnkfaVXV68sA7FCIg0D1oqgxKKHKI584wBsv2h2FAN0PnZioUDrIj0foKS1kic9k+TMfxAXC3utyg78wOUUC68EY4VyRuHrDVIjtjJMvSbmgtBhQqx24q+c9hQroOHj4KDXKRpuUosEdwSlgYV3xUD4+n6hHQggqXrBb2AMWmxdBe6U202G4wMGYgfEb1aRas+OLelt/QtFFP+XduL2oWlqj+dzoz5l8EkRrWF6mR8uynCdvMCQ1hW8Vvpos5RVjB0whnbCsUmpa3fi5Q1TLyv9DYIZ8mxf+2+XWmIXuBApXtsVxLHuxjb9q2k6b1TBN69MHHFHJKNP/QNsHd56uA+M4lzRPboHAG613n330NZDj2AEA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(81166007)(356005)(47076005)(70586007)(70206006)(36756003)(316002)(508600001)(8676002)(110136005)(966005)(7696005)(5660300002)(8936002)(16526019)(186003)(86362001)(336012)(426003)(26005)(1076003)(36860700001)(15650500001)(82310400004)(2906002)(2616005)(44832011)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 13:10:06.8725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0098462e-fe8c-46cd-8dfa-08da08177542
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2475
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some drives from SSSTC are showing stability problems after s0i3
entry when the Linux kernel is in s2idle loop if LTR has been
enabled. This leads to failures to resume.

This appears to be a firmware issue specific to SSSTC SSDs, so quirk
them to avoid LTR being enabled during the suspend process.

Link: https://lore.kernel.org/linux-nvme/20220315072233.GA2288@lst.de/T/#mb9b5782220a32e2c69fe37cf04ae1501b0f48221
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
changes from v1->v2:
 * Move into a PCI quirk, handle entirely in PCI subsystem

 drivers/pci/quirks.c    | 17 +++++++++++++++++
 include/linux/pci_ids.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d2dd6a6cda60..005142d574e7 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5879,3 +5879,20 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1533, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
+
+/*
+ * SSSTC firmware will continue to send LTR requests after device has entered D3
+ *
+ * This behavior causes problems when entering/exit s2idle, so avoid letting LTR
+ * be enabled during suspend.
+ */
+static void ssstc_disable_ltr(struct pci_dev *pdev)
+{
+	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_LTR_EN);
+}
+static void ssstc_enable_ltr(struct pci_dev *pdev)
+{
+	pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_LTR_EN);
+}
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_SSSTC, 0x9100, ssstc_disable_ltr);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SSSTC, 0x9100, ssstc_enable_ltr);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 130949c3b486..ab47ccdd2ece 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2568,6 +2568,8 @@
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
 #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
 
+#define PCI_VENDOR_ID_SSSTC		0x1e95
+
 #define PCI_VENDOR_ID_TEHUTI		0x1fc9
 #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
 #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
-- 
2.34.1

