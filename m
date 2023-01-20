Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E656749B4
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 04:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjATDDa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 22:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjATDDW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 22:03:22 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4571A8A724;
        Thu, 19 Jan 2023 19:03:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8z7N7i0P8GuJoKzcosA3/QA9Na1tkMoVlx+QOBM1uMHxj5V7mXjSE4YCnRsMPTdWIkeuWQNok/x2vyCPY7dWlkDgkzUkmRCLLtTuK5BuGu3cq4WlrQYuFNfSrybZQgbw7wIZ1lrENnp6qYjbRHpYn/MIDvlAOSDg1RClP/GgbTVhO1MAcf9S5f/XrSZXfJfraGsZF8/TU9A2n49Ug99r0IdQjWyfJi2bm6a3RuPZf8Z1JGyCsVK0qAQU3lzwbzh1a+TDd/KhmV8kpajvk9GJ7gf2aTI0HkTWo+rS+aM50PYUQ1N+xCFmuej4dikZHDFxw5FgAELXtyR0vToUnPUiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqMruNlZ0Y2993+SE7bM+U6sHCgD2F4Ol08U/JVUCi0=;
 b=JQ5iratz1tfjnMpOseLjr6Vg8ns5W2JrQMPFAnfeywVgUGsNP9SQ3n7dSt2QJC46w2i8vQBIdf2lO3N7WYHg0O8TqWtPyPCP5CmfmrhPbiOvlAJvkiJD1k63KRHahfKFjTV3LQcCyecKAWWQs2YytKcSRrcdSuJJ//kE6KQNwXKa4gOSJ3QDh0lIGfaQKRvWwR5lShg1mgY1+vj83DPbNy8cZu6ZZ+VVtI6pK47fwxXgtWua6OuytBXSNbD11jBPdfVvP7BV9blm/6q+PmJrhlIxpRkVUdQBw/bttZPvF7aiik9pdYJRHO7XtNgezo0OQA6txa8ERH5XHZa886f7bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqMruNlZ0Y2993+SE7bM+U6sHCgD2F4Ol08U/JVUCi0=;
 b=zI/YH6jHvQ4kKhrXDt6JBg9r8QnBgz+lo9gV170aGiZqn3WPg56sj9sj8t3RAkxvBZ0edd7OrSN5ood45RgRgV9Reu40d92MOCrNbBshF6HA5J3qfy8FXgVRYvn5RxsrhLK5CoeBhBGbTAReYHGTjw2U7J02/RY5smCDI5G76Qo=
Received: from DM6PR11CA0055.namprd11.prod.outlook.com (2603:10b6:5:14c::32)
 by BL1PR12MB5143.namprd12.prod.outlook.com (2603:10b6:208:31b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 20 Jan
 2023 03:03:06 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::25) by DM6PR11CA0055.outlook.office365.com
 (2603:10b6:5:14c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26 via Frontend
 Transport; Fri, 20 Jan 2023 03:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 20 Jan 2023 03:03:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 21:02:55 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 21:02:55 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 19 Jan 2023 21:02:54 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH V7 3/3] PCI: Add PCI quirks to generate device tree node for Xilinx Alveo U50
Date:   Thu, 19 Jan 2023 19:02:12 -0800
Message-ID: <1674183732-5157-4-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
References: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT068:EE_|BL1PR12MB5143:EE_
X-MS-Office365-Filtering-Correlation-Id: 808fefb5-21e9-4fdf-448b-08dafa92da75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnA0eannw7ZMzo4XIjUWPspkWBxOZL+1vjr0zvhRhuerI1ZnJRLK5+K0nPQdE3jx4ZKbC43MnA2vmbTHd/49n9GEJcC47Xk4exYC0N83wvyPsQcgyJdFTLgPXsuNFdyK7UaQWrcN8KBfZhl118KAxhMXePLs8MaVMN9UFPr7alfKITVZBMSNRUxfeXcKhH15sD8+nv+TThIq6i9vQeIGaQe9gGfczuMxTcLSSY1n+jZG/pKBavCjY0jrF25qFFvv8ZqThXtJHnzHh9yKExkf6oHZllWfos2GnmysUssONCgHt3B/3Ks1euXJFFYIil7ixF+kM5/oJp1ODjImjRjlFquGIWLrfDmSp4EBcSvE6sfKZ8PO50gm4wjQsDAEPDRJaCgU8s/LiuWTCKxArQGQPcG447KCiwV3RtO2Yi++s5slJniAyLFHFjCyfe/UBUIqSH0Eo8wbGarfS2feKyQKPBabeLYcXEFxK77iO00LQgdlTpAHJI20QmuyiW1nG8opLNbmmqiq6Ck96XIjQeDwfmOSlMCvpDpFKBr2Ljmp9oAVKEScaq54iZQbM0Zut3AFg4XgrEjNse04nJ9tCOFoeVT9NAVgugTTHFm+UpNZQ/1lB/WxfAENVvPGZ5fRvztOto8e9tER1v3WFvra3Q20l7BUJYsyscQUuBTRfLHEGTT47Y2/GwgpbGYpxuRVhpVH7F3rxu8svNXy0sb62FPK3q7L2BAG6lqMMrBJ/grjhZw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(81166007)(70206006)(36860700001)(82740400003)(44832011)(356005)(5660300002)(2906002)(70586007)(8936002)(36756003)(8676002)(40480700001)(4326008)(41300700001)(186003)(26005)(2616005)(40460700003)(82310400005)(336012)(54906003)(426003)(110136005)(6666004)(478600001)(47076005)(316002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 03:03:06.2852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 808fefb5-21e9-4fdf-448b-08dafa92da75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5143
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
Signed-off-by: Clément Léger <clement.leger@bootlin.com>
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

