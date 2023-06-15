Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAF8731E79
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jun 2023 18:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjFOQwc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jun 2023 12:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237750AbjFOQv3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2023 12:51:29 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2817A2955;
        Thu, 15 Jun 2023 09:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YD5UPCpjBo6fyfkYm8NzREbXXMzEJfPahjFKsQXkgUWw+1bIy/GG33IqcSq0rNlm/tfjCVxK7KeOqd0AX4bvC9h1LITLhXpO9PH6DHBdueYX+Y8gbcRslb0vMV4J9eGLZLBk75sSvJ8Q6HffwYo2eEn9I/2PaFc/QyOw9VK4G5LXJCkyeX+0vW8CDb6qAX/xQfIVWPHsqchORitoDmbmLYYmVsXXA4WEy7KyVvxtqUkMsUQJrqSYZpAfk4XrAjihhgWR6sxON9P8j6Ds11A0I7Se6P5RK5FKhdF3iM3b8+nAx0BImxnMB8V/4YujSpfVvzDNaSwWf2cO1V3cg6Vj1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGbfjJaeCFsHY4yrDPsgA0/1fC10vw15xK0xAuVzttU=;
 b=guYIHkUe2cflZU3qR2WvZgVxjHTbF3qcmZaB2uY0wdUk9aIp7SS+laDe9RtyA7x/bxVJCZWS5p/klwUY3rPrtJU2wmLwVo7SRypEBs+yRb8IdNDB9xGqD9S1/B+4Smo/RZqt5ECvgpS8z+Mx1PV9PiThN4b7xeOBFQG+ZRed2RtMFjipLw1z2pJ+gOSinT/503kHDE2/blvs9TE09Hjxzhg0zpeGc6QbM+nFyzQSe4NAn0N5JUGBA3IsIu7D4cSs5TO5GarT6jZ4wDf5QfzAxSGu87UKYbuGd09hcRZj1hZZcQzIgvZ3scW10ejkhtnnRCRmkiouenB4FrWt/BUSyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGbfjJaeCFsHY4yrDPsgA0/1fC10vw15xK0xAuVzttU=;
 b=iqAQwg4CbA0k+0JIpoGROyU26J9ouh45OUrit6M3eaS9tYoPXeCbj8t9RqqIlLIvhmd0390tE6tN1SJDa1zBAaagMAMyxDsPzNE4TtDzutaOeFNAAnKxvUaPfz+3FBuju+e3ZGQo5dh82CJcjBHt8YIg1drs2YksilqPuLfHCgA=
Received: from SJ0PR03CA0212.namprd03.prod.outlook.com (2603:10b6:a03:39f::7)
 by IA1PR12MB6409.namprd12.prod.outlook.com (2603:10b6:208:38b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 16:51:19 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::4) by SJ0PR03CA0212.outlook.office365.com
 (2603:10b6:a03:39f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27 via Frontend
 Transport; Thu, 15 Jun 2023 16:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Thu, 15 Jun 2023 16:51:16 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 11:51:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 09:51:15 -0700
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 15 Jun 2023 11:51:14 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V9 3/6] PCI: Add PCI quirks to generate device tree node for Xilinx Alveo U50
Date:   Thu, 15 Jun 2023 09:50:39 -0700
Message-ID: <1686847842-33780-4-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1686847842-33780-1-git-send-email-lizhi.hou@amd.com>
References: <1686847842-33780-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|IA1PR12MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: b1534be7-3ebf-43b0-c406-08db6dc0bc80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c7zPC0zg91jlpc6RF3qFZDnkFLlo9nJwxZ4yb/E2hYS7k33GqSKFFB6QYViZIGuRgKzIPFq0j+S1SKH6tK95UZzN9PTy8tUoKxmh39vmt9dOHrepbYZ3+pFnYzpq7n91rbsnybAzTym8DtiAbcNdjjT2RjL/a0kAl0aY2kVA6XVa0RmejwZ3+fDNOVwfOllt1ZbV4Scp8hTLL6TvF4jARC+JSVs8beM2C3JfD//g2S3nUzvYi+IA6dmNVVB8gTHitsc4Nrm7oJbFchj8uVv4df2ghpXWecbFKvRTslui27POBwxWdZ8WikjDfEn7VXZm+g7xFM+V8RBs7jDLhowatZg61crbWZTE+kfRpGJc8HF4t/x489SIUwbV7ItqOzUsKXQtcW5+E7bD314zMvXMGjtvNZu0zH/RS9tY5XQAlwTSVAANTouE7X2Y8xF/gJQcAYvEFigWk+KDEBADWT9/U8wT2JwiR1HUqUkSHoQasqK+7B8Xn1KaJLNfTyFbRKecY6O/3Qe50xFjpmihcRUaou97a5K03VAKpPs7in3l3IvNyYCFlekdr5/D259uO3F7ElD990nTQthHrAhn8jisU9KdTbc32HwNhh9T21oxiU5XZfWDyk26HTWYd9VJOvodS4Ess/Y/48C2U8K90M0IutNE2WALYl0/7rQn9tnDFaa7GWiN6dy0FsJ8LSnGskve74Xfry9lsm8tqwMMXzNuusTG3m5upi8smyyr197Cs7VTTtXToXKbV0bGiW7Fs8azcAH++NQIeI20Xf9E95B7jA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(5660300002)(426003)(336012)(186003)(40480700001)(44832011)(2906002)(47076005)(2616005)(36860700001)(41300700001)(8936002)(26005)(40460700003)(8676002)(110136005)(54906003)(316002)(6666004)(36756003)(478600001)(81166007)(356005)(82310400005)(82740400003)(4326008)(86362001)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:51:16.5979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1534be7-3ebf-43b0-c406-08db6dc0bc80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6409
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

