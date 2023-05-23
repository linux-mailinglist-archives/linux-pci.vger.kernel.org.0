Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F8970D2AC
	for <lists+linux-pci@lfdr.de>; Tue, 23 May 2023 06:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjEWEDC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 May 2023 00:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjEWEC5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2023 00:02:57 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E669121
        for <linux-pci@vger.kernel.org>; Mon, 22 May 2023 21:02:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRQ4XzaNgIctTdXe9tJEkntZ13MB4vJ5EYb3W5DBzH9iJmhfJgg+2QQLmm+Ub99qYn0HhDyQxoAzvjV5aPvGU9PvhcnnYrlKKDe43wMq1qN1Of3H6BGXNkPdPVt64StZ4NXYJ/nF9ZTCQBOJxHhXbCZ57VWoGWu9Zen3t/P2GQkpMZAvb5TT0wzXDYMwCYZG6FZVWzcJRAtngkYAGo4f2zs9NtapuEwg65Bx6NmSed/+6Ytixdwd/QoUQNX+fjI+fNdMeQ2SP0zCaY+6yTjKs8Y3+9WiL/wOeciss/fyxLXgqiOPXJoGQvDek5k8a8b/G80WaAgEiQe5iltPUYhkHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLIvdSYCTBY0tNqWOyxViIZsyX6ALbxW72gRd1rL/bc=;
 b=YIBMxAf5IYdLR2VR3836ujTy/QpLZMqOqewN7E0XQArUjoXRToPK83rwNSWjoIWrSHKtrv1Ab9mD+byCIbklM7AhxgAXLmeKmR6SpGsSs0o5DIRA0Fs4vq+aJEdOFbbZoLvFf9p3I/eLRweefaZbG6mJbmlRAbrBXZ8DIij6OsCKlb0FRrp6RGLwJ06krCHGm/3sQ3VjLzf8FkrMVrUtIl81ZnpuTMaZKd+OAGXv9605qJPqhr6l8UXdNrOig6XCMhrXMIwH/0/urK/2YZdIxz6aE73bSrfgzyyi3zRML+Hn4/pGQAjWYVO47nFkIT611+qoKNWospROa8bheT/EmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLIvdSYCTBY0tNqWOyxViIZsyX6ALbxW72gRd1rL/bc=;
 b=FHvJjoJnsjh6ZjUsN9A3bkyjIxyl3d0v9mN908AVeu5Y72RYqfV5JbA0qJY9vY856drJ/IOSiCfN9KRAyk2E0N2cBXgpk58aGJ5cBI+7MyXHuBLb8A3nH/NDSEGBs8mnUBBL43ihTQ+gczGpiLU+WuP2/aiP5htA3sIL+iNnGYU=
Received: from MW4PR04CA0255.namprd04.prod.outlook.com (2603:10b6:303:88::20)
 by SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 04:02:47 +0000
Received: from CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::1d) by MW4PR04CA0255.outlook.office365.com
 (2603:10b6:303:88::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Tue, 23 May 2023 04:02:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT087.mail.protection.outlook.com (10.13.174.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 04:02:47 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 23:02:45 -0500
From:   Shiwu Zhang <shiwu.zhang@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>
Subject: [PATCH] drm/amdgpu: add the accelerator pcie class
Date:   Tue, 23 May 2023 12:02:32 +0800
Message-ID: <20230523040232.21756-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT087:EE_|SN7PR12MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: e01991a4-f5ed-4315-3952-08db5b4291d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0BQUw8fu/NNigUcbTMA7PoqmdpnSsF5g82B37ytWHO3IFYbY0hfWIUnAeNks71D+0tVQS5OeOTGI5dVkoMQsZh2/RGtF8V6vRtFYGd/D/2KoQoq7ZnKGek4IoP6glwpA+CFNhsssCUiNsrNkDW9BUyB6UylH3uK3Z5hn9WLB9Ft2AdzogyNL++bc+9uNy5pCZqSxzKUyAIjbAouq0yAcCKMq3PiC8PYU81b3sZFP9QOb84jdqwlV5Qu2JKwqem2pUXLPaMBdJUcAl2vHW5/lNABOK/LR/4jrQE4xJdD7yWc0PC1didYs/UPEfquCyub4Q7DiQdZa3gf7y6rCYixIK9509h6YiNER1pJGpAALVyWHm00z9LDEgKSPFdExy+VkPQCfaI/3pfd0dI1GoGUYRNXG8egCsfbsNfuxmO9XtBDM3lf/L6fHVwYLWJen1eRSIn0AAB2/0C6RcBvH5SPzYT+pw19E+YOV6F93Xj6YemeA6SGVRKxpLS2dna5BHE10TbZEpKv6erCQeq4YHFev1g3rdrBFKQNQ+5YZm5rhrmaVHobxMQjDL1Ob3D45Y5B3BMOBIn3mG7se+06ADuisVj1H9sXTUXpJd1aDWkdzQcETbrZWYYsg/ukcM2X6dSNYO5GtIEnba978hfdn6fyf888dov3zP2LV6dUGpDQptrKoxgXyARWAOAfObUyJUmwdTrfS3NVkhBW2Aup303vBnrcUt+4m1Jj8hFd+GSMQW/9G49F5Upp7MBheZDK1q0o5Lf28FBzwljClSyIIGU5Hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(8676002)(8936002)(5660300002)(44832011)(36860700001)(47076005)(82310400005)(16526019)(186003)(81166007)(336012)(2616005)(86362001)(1076003)(26005)(82740400003)(356005)(426003)(40460700003)(6666004)(41300700001)(7696005)(40480700001)(70206006)(70586007)(316002)(478600001)(36756003)(110136005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 04:02:47.4093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e01991a4-f5ed-4315-3952-08db5b4291d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691
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

v2: add the base class id for accelerator (lijo)

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++++
 include/linux/pci_ids.h                 | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3d91e123f9bd..5d652e6f0b1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2042,6 +2042,11 @@ static const struct pci_device_id pciidlist[] = {
 	  .class_mask = 0xffffff,
 	  .driver_data = CHIP_IP_DISCOVERY },
 
+	{ PCI_DEVICE(0x1002, PCI_ANY_ID),
+	  .class = PCI_CLASS_ACCELERATOR_PROCESSING << 8,
+	  .class_mask = 0xffffff,
+	  .driver_data = CHIP_IP_DISCOVERY },
+
 	{0, 0, 0}
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b362d90eb9b0..4918ff26a987 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -151,6 +151,9 @@
 #define PCI_CLASS_SP_DPIO		0x1100
 #define PCI_CLASS_SP_OTHER		0x1180
 
+#define PCI_BASE_CLASS_ACCELERATOR	0x12
+#define PCI_CLASS_ACCELERATOR_PROCESSING	0x1200
+
 #define PCI_CLASS_OTHERS		0xff
 
 /* Vendors and devices.  Sort key: vendor first, device next. */
-- 
2.17.1

