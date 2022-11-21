Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02996329E2
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 17:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiKUQnf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 11:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiKUQn0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 11:43:26 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EA1C622E;
        Mon, 21 Nov 2022 08:43:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blUcgX8mY8WgrFpMcPGcDzXunG3i7Y18ZFQ0Fc/IPLNc34J3CXCPtk8AypBFkPqTcu/U68PEPLI0ljQNpHuzoBRlB7EgEhmEqAcgCBNQO4ZfuUKkRSk3eOW7O8mtfa8Bmnp9aL6Qd4lf2TRmOufKdxgEYUGKnc00N6urZi/SW5ubRgRa/qkpGjx6VvSALg3dZD4p2O6//nN5Co7B3k76qdDLUTUaC5fQByS9VBv8RbobBv2AInA9RkMFdQ3A5bnTH5dKVwb4SmIAtpotFajq2wYDs8XgPupLhuKRC3XjfoQy8nDFasxRTAK/TJU9rg0uqiDgDSamtudhKDJut/BDhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kE3EEoROF8TRC85LHQNVGLLOGk4/ncwzq/kMy+zm2w=;
 b=aiqrNXjXVK5KK820565dIhPUcUBPOKp5NSgMHHGRd6esVJ3l6lOHKhGD3271pPyVB4fWrXAhVLkK4g/PnkaffDCQDaKTsSEjmfoG73kKDJAUcqBHqJWB6MlpLpXAVuyDe7Z6U4D/7uvXmKbUiYSI2xhPKn7n+k6plESGeSQqSyVY60ftrSpEmQXvN2ulsa7fboIEf7D9vOv2ivGVqGspcOo0zriv1tbwo7n7cBEw0AH84TA9D/QaKeYrlZfpOsOiQVY0MXZ2JxwiARDKzUY38XLASSjJfEhE7dKPNAafFADULYfL0fH0Q4IC/lzvwDfPo1NgCRTDm7hKWO+rqqXbFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kE3EEoROF8TRC85LHQNVGLLOGk4/ncwzq/kMy+zm2w=;
 b=E8pI1yVC+a5tLYPFdwGwlhEiiUOX4PTi/zVtRD/OF7kAlszNxA4XitoT9nbihDLupx7jvd+bO7teO/ADNQHk1U9wrZ6GX6ZLAy/ArUVO5gYGiuzrLUd5pIHix5LjDvQwqc4W2PY0Hog4wn2tYkqimYA65h2vPjevaHCtkhcDz9A=
Received: from BN8PR12CA0013.namprd12.prod.outlook.com (2603:10b6:408:60::26)
 by MW4PR12MB6876.namprd12.prod.outlook.com (2603:10b6:303:208::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Mon, 21 Nov
 2022 16:43:18 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::d9) by BN8PR12CA0013.outlook.office365.com
 (2603:10b6:408:60::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Mon, 21 Nov 2022 16:43:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Mon, 21 Nov 2022 16:43:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 10:43:17 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 21 Nov 2022 10:43:16 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [RESEND PATCH RFC V4 3/3] PCI: Add PCI quirks to generate device tree node for Xilinx Alveo U50
Date:   Mon, 21 Nov 2022 08:43:04 -0800
Message-ID: <1669048984-56394-4-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669048984-56394-1-git-send-email-lizhi.hou@amd.com>
References: <1669048984-56394-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT055:EE_|MW4PR12MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: b53e4737-aa55-478d-bf90-08dacbdf7e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c2SRC6cXPmWJL2P78fPjrvq+7BzHrIncOSANufEQEK4ogCDq9mAkZQy6aUxdS2n/KNHdSLA091eQMrrHBCC93x7vgmDFzHDaLZ2wfDODh0QLpnTPb/gajdQPMgKGEyE064WHwO62jhgIcG32Z2YKzMT3GL32LlPj6/cwY9bpUSRleDffthOL5TAWJSnM88wYB4k/kHTKEhBhBEOlZAGRD1xflyo/osIO4BEdHkJG5IiH2jKblZltQauh3L715Bo8DSdxsONE8gX0cjKB63Y+0Ntgo3hx+msS+dK7L1Pq4Tn7vKBnNAbLKHoFYBgpp5mCSubE7fn1eyrdVI0FKF6Y7q8/LjF2Ozqq0mxiCrZVUypaTFPb7Qgvx+mi9IvkEnaqOXWy2yeR9mhGUlalqA0OcSx7NEdSXnDpgRLX2lvKfHEmOuMFzwSTxuBUP4WvKwiZJyeBruVZPmnTqkiKO6F/74EIbh94gt/HSzOmNvuYXLm290SCR6yzm/gMh5utKkTCTEBMazgNT0r3dqNhYtKd2SwXKD0/8ASFHQq14XF0S35wZxO2XiY1bCpsQOPKHBOHXB0c3uwQvxulJbfo/P1h4wOxiWdKH93UgIfJZPwuzxPJoSv0OmeR0b1VGgD5I7kWeLBJZaxJeM7UZqhAjpRR6xFnFcWjI85CGT51SHYANkTq+Y22zCqJ57Ih/gmAxGAZCimespkHnRo0IX1YfQF3RDIM31TexRMnE64Kpn7muOw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(478600001)(5660300002)(44832011)(336012)(47076005)(40460700003)(70586007)(4326008)(8676002)(426003)(70206006)(26005)(54906003)(316002)(110136005)(2616005)(8936002)(82310400005)(356005)(36860700001)(81166007)(82740400003)(41300700001)(186003)(2906002)(40480700001)(86362001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 16:43:18.0557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b53e4737-aa55-478d-bf90-08dacbdf7e27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6876
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
index 4944798e75b5..5d76932f59ec 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5956,3 +5956,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
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
2.17.1

