Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E5B5B3D69
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 18:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiIIQtN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 12:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiIIQsl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 12:48:41 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5971475E2
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 09:48:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMCpk6LUbymycZhZ21l1skTx0zopqyUi6NSceQ0EFkeSlp8e7+bYXIsuDLJt8kLMG6rnduGDt43ASePYFmPB9firnc5+CPuFWbLd2o8qvkB4A/uQxLYflpEuZFZn2negERI6vxHG6ULKJN/FAVZUTT5HHl4S1zMfxiuqTWp2CpokW7RYicqsiGFtRWPzBGLanpabrRFOncNlwj6o4bBZSUZc/G4ca2F0kYK6bFA/awLy5UDRSz8HWzNPbfNEDwFZ+yjhUSI0W3sSQPmkHkcOr50oSM4REtFtUPchvykOnT2Vy8gYC6hRRo8OgaVj0Lj0fAbnMX/YPXwBUlKzM/i/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXpXKTqgKINmemUxFtjfNnk3zIej8RE38fJourwE2gs=;
 b=aE1F4zqAcoDSgGQj7cDR8S92mZsCQIOklLXFrfuJFnoJ6tqPPZZ4Z+Fb2zYgF8Q93B+1VkKQmMpiVCPa0pAsYXPiGhoQzcAfi1e8axcovdLWIM0t3RTfydwpflSjBB6QyMdeZBm/Prj9x1fbrpNEQ8O9ct3PQymMz1sdikBbJnUi+7HmMvBWgOcsaKlenjXd6+xlb7hnYKUMNo8yUktoDaJOMkvmg4H1rsyzx+Yae4NL53URVYXoPTD0nIXo9e/Ai1C+zpcCRNEIwr4RcUFFUY2aPS/mUFkdlA/heyXQlCOS/06uLv/Drq6AUFPhwxL2ZMHHzRK0O0zIUC7654ebvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXpXKTqgKINmemUxFtjfNnk3zIej8RE38fJourwE2gs=;
 b=qhRVuepKRYnQtirHq2gx2DyIC4Phz6QS69cY/s7LFuvwqbhAS3+Aym2eLemHEV0TMpJDSfjxpSgl8zIQn7J4RYfTaDkaqAo2Aw+WwBHvUBV4vrp96ZNwfuWPzfGRpFBr2SUF+dVYsi/RR+lialNuB/hdTOc9VK8bkMD/tNiL66g=
Received: from BN9PR03CA0138.namprd03.prod.outlook.com (2603:10b6:408:fe::23)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 16:48:16 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::f0) by BN9PR03CA0138.outlook.office365.com
 (2603:10b6:408:fe::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Fri, 9 Sep 2022 16:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 16:48:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 11:48:14 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <helgaas@kernel.org>
CC:     <regressions@lists.linux.dev>, <airlied@linux.ie>,
        <linux-pci@vger.kernel.org>, <tseewald@gmail.com>,
        <kai.heng.feng@canonical.com>, <daniel@ffwll.ch>, <sr@denx.de>,
        <m.seyfarth@gmail.com>, Alex Deucher <alexander.deucher@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 4/7] drm/amdgpu: add HDP remap functionality to nbio 7.7
Date:   Fri, 9 Sep 2022 12:47:55 -0400
Message-ID: <20220909164758.5632-5-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: e9cea0a4-1ef4-4189-783c-08da928317dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mu1JgmOg+uEHMiZj1qnR7lg9xkOlce22otXAIgsUGAhHD+G23GoDX3QpXI0FJY+1a14/UffDL1byHWe7zeSdCNH2gUrI5Ijx0WLNCtTlMwjegEA9TSP5yEjxsg4PSmB5wnrYJk0urTqxFLnfAcClG9+8u6Irn2s58qDxKqfS6ruC/g4cvVG4nscsGgtaeWscXKh5V0cykvuvLLz9kKZKAV0/GWJcU955Ff+LysI5/oHWZ1dNdP3BeReivfo5dlIu4M6SUuM2tbc9vFMBc/NTcv6kTIZakm6f1C8r4Fw7HKSlDMPZwVy+iy3nGVG2LxNFHjwj3DaOW94P5Va+UJycCbWGQ+mL4i33gIy5cwL+22z0Yz/U1bortgcSRnGCM3o5DVVpgHmXspa7fkTYxI8+e1q/MzHeIz7BIW+6wcHTsF2QVvN6OABFburtsqbS8GTvWT/JCRXPXeelet6+Y3YsShuVcikrt4vFbcAXbdUMAZkZ3VBDEW7x41GoyWs3UA2sWC/N0eGitcy7wT+PwmJlzRlMXzCylV8ocMtRabDKp9DkaQlPDLW/Ysu/EbF3kFiAzjLrTHYyuEcWCJvCYMtPVeEiGV0OoIqNPdVD4Lb1vwH/fslbPj1c4njwUhFBFJ5hvshPsVFo7/PDyVYNFlUj1Rt1+kHUj3MQkM3Dp6EwlATY8p04i4koE7xAYZwhAb5sXGGPnvKze6jLvyGF0alhNV9nQcD8lyABpxB1CuaJWpnF1/bpUGXiFpHGdAzEFg+y0BNHckyTjUohgDi88Ok2pPYalORaGqb0TpfznpUP0CIpkl9VCV9BKsRkQj+CtnwR
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(346002)(40470700004)(36840700001)(46966006)(7696005)(6666004)(478600001)(41300700001)(83380400001)(2616005)(426003)(47076005)(26005)(2906002)(16526019)(336012)(1076003)(7416002)(5660300002)(8936002)(316002)(40460700003)(82310400005)(110136005)(186003)(40480700001)(54906003)(4326008)(70586007)(70206006)(8676002)(86362001)(82740400003)(356005)(81166007)(36860700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 16:48:16.4326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cea0a4-1ef4-4189-783c-08da928317dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Was missing before and would have resulted in a write to
a non-existant register. Normally APUs don't use HDP, but
other asics could use this code and APUs do use the HDP
when used in passthrough.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
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

