Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294C15B1327
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 06:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiIHEJP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 00:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHEJN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 00:09:13 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927A089830
        for <linux-pci@vger.kernel.org>; Wed,  7 Sep 2022 21:09:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMgoL0GbZ4ZqA7dax4jNIAb1fM8axI10qw9Ajr9jsphthl/XJlwRi/wVuSijeC7uc/ePtEssKVmhJRmQ0ICgLpWHqs7ywn4dnlBExaFeGi80+AlwocUuYlkL/dd5aMS8jt3JOAWa3GpNEFOy92NswEZviSSVC9fjb3IXhWnOnTTu2BHyD0+oF808QwzRRjVnLOOA2tKe4xYGD9XQlMyZL/sYpRxviGEWGB/bi0895bTPxeD5j2vfHFP5uSB9Uld4p2sz89NEwiJ2dZuGepDahMIfV6LLljnoDm/oRhTXg5wNGGk2z1gIMBiJ7qt6mKMwSZq7CoMKrLEvrfd6nig+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3jekuELnqmshTWix0Nw8fGJXskJ1X6NI2naNdelhHc=;
 b=dCgY39LEtVSc1wSEG90VYMZVUAmVIbbCHT4pcjLmtrR1TTJaPFc+f9spelPiARI+kYAsUOCcDCk8lA6BFHpT27vGqFHh8qf28u61wGlW0iuJTXEcotfTXy4EFO22qk9q+FDNVm7aYlSxkyJwbYF36ano11PA+L+IB2KdcAD/glqZ7wKHAmxNIkw5v5wQB3po2UMylTNYwg/X4DTGNR40v3Z62noFYuBQ1cQbKalRA+FAaPFHLEohltWBS+HIzNm33xUY1AfO2ivuxQZ0XqxmaYRfmFvvAenqSXg6QuGlu0/a2UGak0z1hw9+5x+LBp3o2kNxTPtX6efSjiucsvHLeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3jekuELnqmshTWix0Nw8fGJXskJ1X6NI2naNdelhHc=;
 b=nKK5lle1jUEAJ7NuWuCLFCAh+qlD+qIiHa/Bu4iG7AWGf/j+Poh6kn+LzhWTwbH/cYAMiw/R+rJUaFTtbb6oRVDzKvm+skSWCT0zu+3TEdIUBv3EYRYpYB372OFHifhFlIpN0RcG4MGwKodXhzD9EeyDBsCBvwQgWESWCDTW3KI=
Received: from DS7PR05CA0087.namprd05.prod.outlook.com (2603:10b6:8:56::9) by
 CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Thu, 8 Sep 2022 04:09:10 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::b4) by DS7PR05CA0087.outlook.office365.com
 (2603:10b6:8:56::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.5 via Frontend
 Transport; Thu, 8 Sep 2022 04:09:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 04:09:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 23:09:05 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <helgaas@kernel.org>
CC:     <regressions@lists.linux.dev>, <airlied@linux.ie>,
        <linux-pci@vger.kernel.org>, <tseewald@gmail.com>,
        <kai.heng.feng@canonical.com>, <daniel@ffwll.ch>, <sr@denx.de>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add HDP remap functionality to nbio 7.7
Date:   Thu, 8 Sep 2022 00:08:21 -0400
Message-ID: <20220908040821.5786-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220908040821.5786-1-alexander.deucher@amd.com>
References: <20220908040821.5786-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|CH2PR12MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: c77dd33d-d137-4691-8613-08da914fe1cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iAUiDb44k5TYJDHDcn5VlfK3RUm2rl/rEFKiPOpbIaiTKddCa9PTgvGFFpJS3QFb2KFz23QED65LxGvuD/JxN/DGNdjdJOPCKUp5t4ozKPc/LRA5DCCkJffdTHgxrzrdQ307+nWNkMKGd7qUslcrC0EU9tdQMFhkNW9VAir1Qwefb0RiAth58ft31MqnTWD+tS4RdEu0rULMyjaE5fbmau7x4/BtkV2VOoMCKneO3vTaLV1bnw7E2+1DQgyo/X4WmGgkLozE/SPgAUPySgniC9u8DZQPpGUbh8k5++ydNeRbx1eHKoIyB9RnKl3FEyPcnB3T+qFm5wps3F43jyOcrbBTP8NI6GM4FjRdZyS4FzQvAkrHNJbD8/jz3nYhCFGn8Dle6f9DjJFwI0YZvQevfJ2iHaVPY/VG0JBYiWHEIHmJyxLQoBw1Jc29Q/3cajSlQpbAsI0nfV+uP3r7IRY08x8nflrWL7AwEiCZ6CZgyDEyPUseynAVok/VI56RrXwuxPbi+gbkbibMZPr9pWQ6eOZ/xGAR38PnrNo/BHUyLcktRrP9iP5IuYeYq5eBURaZc25sxrYLB8suQSCXYRXlYChcrZsN1sj+VhGfDtptUdfE/IKBPHnVRwsSL4bkq7wGGW/ScGBdIopY9l+Aw7sHoj9CRfevrb4VR1UqC6R7p5cf5kfvc44l7aFfaTz8lwq6dnVSY+xYDx6PL6S+oA2eY3IXUaRBjMlnz3pUN9F3/ZSrqtiqGK6QYKKH2ttMbm2EHE/Np6ovwRjKZ/6z7NLqsJ1zndR1rAVTQsqweluuO64GXVSC6lfCd67PC4F6Qlgd
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(36840700001)(46966006)(40470700004)(2906002)(36756003)(40460700003)(110136005)(86362001)(316002)(40480700001)(82310400005)(82740400003)(81166007)(356005)(36860700001)(8676002)(8936002)(336012)(47076005)(54906003)(70206006)(186003)(426003)(70586007)(16526019)(83380400001)(5660300002)(2616005)(41300700001)(1076003)(26005)(4326008)(6666004)(7696005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 04:09:10.2130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c77dd33d-d137-4691-8613-08da914fe1cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Was missing before and would have resulted in a write to
a non-existant register. Normally APUs don't use HDP, but
other asics could use this code and APUs do use the HDP
when used in passthrough.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
index f30bc826a878..def89379b51a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -28,6 +28,14 @@
 #include "nbio/nbio_7_7_0_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
 
+static void nbio_v7_7_remap_hdp_registers(struct amdgpu_device *adev)
+{
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
+		     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
+		     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+}
+
 static u32 nbio_v7_7_get_rev_id(struct amdgpu_device *adev)
 {
 	u32 tmp;
@@ -336,4 +344,5 @@ const struct amdgpu_nbio_funcs nbio_v7_7_funcs = {
 	.get_clockgating_state = nbio_v7_7_get_clockgating_state,
 	.ih_control = nbio_v7_7_ih_control,
 	.init_registers = nbio_v7_7_init_registers,
+	.remap_hdp_registers = nbio_v7_7_remap_hdp_registers,
 };
-- 
2.37.2

