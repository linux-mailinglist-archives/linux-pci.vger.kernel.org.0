Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AE3738D2A
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 19:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjFURee (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 13:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjFURed (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 13:34:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DD5F1;
        Wed, 21 Jun 2023 10:34:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbV+bY2+5id2hGwMbddsILdsMiQ+XhWEur04o+ohxE5ggFQCXWXBUXlnc4MSIOhbWYImdkQoN+Z/dEz8bxCvFXAkV0FcLX+xEI8pA6CVSXn6rghBLk7l0E6AMEyZIV2y51iuGhOX5cw3KmPPLd6xr2gbBJygUUWV3GFdqYc5sLVqLiwZ+FapKd+WQFqYrtlnsLSjEDdxfH95551GREYJVfNYLilO0NWCzmRm5WT3lt9CbXpZdb9nb9hbDR1da12rKsA/yltTWu0nLkv/egnvuZwYuLG9i3wRJtNxKE3vc+mHieAQX22o3XRT/0/8PRyLeje0Ovn/nRJN1ILRbTSejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGbfjJaeCFsHY4yrDPsgA0/1fC10vw15xK0xAuVzttU=;
 b=ABajy50Gn4EguU8FxqWFZKBOLgHHUKrjIyzZof5mibS7dytsKRv+rx24HgHLl3T5fjJlSamdGNu6Oky6+C9/dAb/R/Sp+i/nd+sgaaeA4j3TkIjWGbql+5JVIp+1t3Fh+ccZNKkzfWxPXBHvR3tJrBeA098XNELVPoCnRjLYmgn7zTNRxSsd2eF26mV78uFkNfr32Hem6WKPzk/rxKbKezwOVilBUjD9osNW4uTfTWkjXoWzDrmC/ANpJs2ylBKx2KpqL0bYGYgLdxsn9rzGyTt8w91d/08MoRTnm4cDJRHEienney8q8ggrSJHMYTzp0I1BsvZNBOPXmCYpFDhMsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGbfjJaeCFsHY4yrDPsgA0/1fC10vw15xK0xAuVzttU=;
 b=RSMZ2X2PCWZeK52tqwNNOmhosxC6hRr9JOCp5vIpmYmlKolAjp7JVl4qnhI+iwAtRFqYj/8+Eo202E588Qk4zDdDcmpsIKLBWC9MQb39R3s2UrCw0bqzld7So4O1hXcK2TCA2277KrVoRzHc1k3fTIwAc36cqkW+EjSs9Uc/pMs=
Received: from CY5PR15CA0035.namprd15.prod.outlook.com (2603:10b6:930:1b::22)
 by IA1PR12MB6433.namprd12.prod.outlook.com (2603:10b6:208:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 17:34:30 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:1b:cafe::97) by CY5PR15CA0035.outlook.office365.com
 (2603:10b6:930:1b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Wed, 21 Jun 2023 17:34:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.20 via Frontend Transport; Wed, 21 Jun 2023 17:34:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 12:34:28 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 21 Jun 2023 12:34:28 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V9 3/5] PCI: Add PCI quirks to generate device tree node for Xilinx Alveo U50
Date:   Wed, 21 Jun 2023 10:34:07 -0700
Message-ID: <1687368849-36722-4-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1687368849-36722-1-git-send-email-lizhi.hou@amd.com>
References: <1687368849-36722-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|IA1PR12MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 851cbda5-08fe-40b3-6e57-08db727dc483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jAVu01c4sGI7UOOS69QghlreL6NKPmopeuhOjPIvK/AjWl+IrbKuR9sddT33ciuo3HZGccBeswN3N4N3M0JRtnAZjptLhLegv+xsWlPSiotTDEvT2/Ui3EWaHmTWSGOnSlAYHblewQJUL9atqWoHQfT++QDVeDFAkoAhlqz7FOFKVxeJ6lB9sh8NueGCwxZtr/XfxZGKJRmMgwt+y3v6pm0cGzZtMGzE9C33uZCEyvYMxrs3Q8kyuQRPUpWVMPltzNSeCA/0ufodpG2EAVKuiSYEcKn5xYwNE7UkEgNj1yNMAAaK99oU4zdFtgDqJQMUuxyyQ2zehPxRVGUVvYZsm2BNQOq/CShqWCLElyybolHv4WfIXZDWErim7MLz77BfQZ7qNlAtv31xS7FFt6ePqkMdRiw2INkcRLdYmIxHQyANkJXEXwsk6UEVSqnixql/IuLeOq95fyvzXPiVS3vCJp5Nby9rubJwwLTwKXNFzev7QJEMo894MmXFaQrBnmhuLxV3a3YXlZvEdn7cHUApkNTfJnCjKENRLBrz+aGJcsGALmuRdqvm2qxKFrUef5Thq+1ab50H03/7vVOh3nRXICun/pXvON+oVgFbFlOQNa5mMBh9TB3Jn52uu0bvCKGfMXVyQcOknYFfQHVS0nuheZDVpekGn++TGO8UzVxsawYBskNFMmxMXh/jRlHWwJrwrIsixEoRhtIRWWk5sHnpxIkSXgY4+oJBKQdABpyHnWBN2iPBlmCu5qq3ix3mnac2DvrgOT/cxpa0oYXmJ/zW/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(36860700001)(36756003)(70206006)(40460700003)(356005)(81166007)(5660300002)(44832011)(8676002)(41300700001)(86362001)(8936002)(4326008)(316002)(40480700001)(70586007)(82740400003)(47076005)(478600001)(26005)(426003)(2906002)(2616005)(186003)(336012)(6666004)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 17:34:29.5389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 851cbda5-08fe-40b3-6e57-08db727dc483
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6433
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
---
 drivers/pci/quirks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c525867760bf..c8f3acea752d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6041,3 +6041,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
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

