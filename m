Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C205B3D6C
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 18:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiIIQtL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 12:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbiIIQsk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 12:48:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D59D1475C8
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 09:48:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVPsv+YjcKmlcc24+xVIASPyLrG7go8tXho+Tu5XpfCVcHPuPgkInpx81ASqlBJR6BENfmb87wQXBwov6uYmEpJVdGcTyu5ClSPHg/TjMuON0eM7Rtdkg/6Bb2DN3xaiA75I3WERJfuIj9c+s4rVvoHP8AlfuOL2/h6TJnHS14djbNFpMR4SxDOLHtAncLd3a/cSMngVodAso0sioB3Hu3EfZXyV+iLTbJsdcJ6B+JFFbVnA1VYBZQEut+svSEdeMtG7xaXbwZ7twqlKqeVuaQXsNZtQWw4hUF+ZssX1/bDD9YVn6oYtYE0+LM+Ai63dhjQTUxnHwMDXtrCmYWo4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qc3gCklKkhMCMu7aSanYB4FwlktNeiGGlvsNGxIjqBk=;
 b=jdHR7+iwK58wc2Ve9IMQG75K4swoVU8AiZS/XFID8voq9YGuzJIiJ96x12r3OjwIQiOzn7GlLL8CxS++OjO8WbwuJ/uw4FG7VQQt2hJbYJXrW+uMip5mStz6pC9rTw3I/o0JOmAhJ3A4TBvOUu/rnjDySVn4ar2eWm7TxQUMsYffSyseOi+z1pQNXp2PfGVFRTX3fTanabshKBw/R92Sdz2L/vrLORbVGo2An5iMo1XTJOD/JukiPj3LF3zxutcfxUdjulDzvNsydqPjYqTOs9qOGANOHZKXn6zcFmcWHhN08xSqn8M+1wEbU1E76XOVNc6W9YuUlctjCw5HOcb94A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qc3gCklKkhMCMu7aSanYB4FwlktNeiGGlvsNGxIjqBk=;
 b=oYFBWxh1YVEy5WxCDgYx+2atpwClLJfteyCUbhQC9oMn1C5te9KFv7/DmhYUqYHYx80ZJF+YDT8VBOmOpI00xr0JwIeJRmsDtPmHQYxtTIdx53a7HSnP8or47pRIs/uCPCNufQk92KiDidF//ZS3CncFaVYqUMzTkuFhqDyTChg=
Received: from BN8PR03CA0023.namprd03.prod.outlook.com (2603:10b6:408:94::36)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 16:48:19 +0000
Received: from BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::2f) by BN8PR03CA0023.outlook.office365.com
 (2603:10b6:408:94::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Fri, 9 Sep 2022 16:48:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT071.mail.protection.outlook.com (10.13.177.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 16:48:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 11:48:17 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <helgaas@kernel.org>
CC:     <regressions@lists.linux.dev>, <airlied@linux.ie>,
        <linux-pci@vger.kernel.org>, <tseewald@gmail.com>,
        <kai.heng.feng@canonical.com>, <daniel@ffwll.ch>, <sr@denx.de>,
        <m.seyfarth@gmail.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: make sure to init common IP before gmc
Date:   Fri, 9 Sep 2022 12:47:58 -0400
Message-ID: <20220909164758.5632-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220909164758.5632-1-alexander.deucher@amd.com>
References: <20220909164758.5632-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT071:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: af494d37-e4b6-40f8-bcc2-08da92831928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DRtX2rR9cYSczVLB445qSpsc9r3QwNs2XPAWSTU7Uc6pQZCymkDNj2cHT2xZZSa7Zb4ac1wsrmilp5lQGYVKXAAQBfxBW7JeZLzv1KYVArB8u3rh99dKt1sBy3tC2nGxLZCjhmR/z7MQS9XomhhHaETNiX3hu8UVsc2Um+CgYTgJoozZIfzpJ1ZgdKIElSAuiseUEEJ/zRVCIC9vjwks6+5RtQwmnpUV4pqF5uKX/0PfXsYmBi8tFcI+LMK7YJqhY61l9mjLqehn8DTdRFrEeCdMyxK9g3xVRfRl9QEcR0mqbj+wriBg+E7S5Z03RtIvzlgbwrX57quX9SwgYo5dIH3AlDCZYbzv8x4lvOOHR8Rkl6T/CPu/oS6FHHi0pd4lTddFzx5lhcMZ3BSSqjRZRJiFxDvIyhV9Al/BKACAeddI6xXzVvacgPgEdus9XJX9UQw+uAaORC/FsiOT5GfR/t3pVt8fw1asHlxQqHqdiG6aHhd7oOlXbxanr3uT+N2A4IAq4QN6JHKRkAnqyhrdeB3ZEjH9GDwr83dQRP9aY5qZjpS4AcR+AtZ37G/dHug9VhBkszCPdf3yV9JPSRQL54VkHK3QH0+FolM8FmxT07KPY68q48Ero1HyZkRB5+KPT4+6ifRO1YVod+QOXawlsSVG4IZhc4b+2uPEhPbwmhXptdTtRrrREqplr4L0nBAqnjYYdpTAzOSuYzG7wn3CtDX4Bo7vwboru+v5ye3seY5cpab4ON0GVt6qLilkzwcKfdg8yAgyQjJo4P7K2s3zQMvGDHzI2PsoIFUgYLPs60uMEzAKfPgTf1NZLBwC4x8+
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(346002)(40470700004)(36840700001)(46966006)(16526019)(336012)(1076003)(47076005)(4326008)(5660300002)(6666004)(426003)(8936002)(2616005)(7696005)(7416002)(70206006)(8676002)(2906002)(70586007)(82310400005)(26005)(36756003)(86362001)(41300700001)(83380400001)(40480700001)(478600001)(186003)(356005)(82740400003)(40460700003)(36860700001)(81166007)(110136005)(316002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 16:48:18.6192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af494d37-e4b6-40f8-bcc2-08da92831928
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is not strictly necessary at this point since
we moved the HDP remap into GMC HW init, but at this
point it doesn't seem to cause any problems and it may
be beneficial to initialize the the common stuff before
GMC.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 899564ea8b4b..4da85ce9e3b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2375,8 +2375,16 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		}
 		adev->ip_blocks[i].status.sw = true;
 
-		/* need to do gmc hw init early so we can allocate gpu mem */
-		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
+		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
+			/* need to do common hw init early so everything is set up for gmc */
+			r = adev->ip_blocks[i].version->funcs->hw_init((void *)adev);
+			if (r) {
+				DRM_ERROR("hw_init %d failed %d\n", i, r);
+				goto init_failed;
+			}
+			adev->ip_blocks[i].status.hw = true;
+		} else if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
+			/* need to do gmc hw init early so we can allocate gpu mem */
 			/* Try to reserve bad pages early */
 			if (amdgpu_sriov_vf(adev))
 				amdgpu_virt_exchange_data(adev);
@@ -3062,8 +3070,8 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 	int i, r;
 
 	static enum amd_ip_block_type ip_order[] = {
-		AMD_IP_BLOCK_TYPE_GMC,
 		AMD_IP_BLOCK_TYPE_COMMON,
+		AMD_IP_BLOCK_TYPE_GMC,
 		AMD_IP_BLOCK_TYPE_PSP,
 		AMD_IP_BLOCK_TYPE_IH,
 	};
-- 
2.37.2

