Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776875B75D2
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 17:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbiIMP4a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 11:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbiIMP4C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 11:56:02 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFED38F97B
        for <linux-pci@vger.kernel.org>; Tue, 13 Sep 2022 07:55:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYW5dOSV2YJ/bEycTkgehVKuVbH6csf1NfO5pjEbfEPfQujgjC955rWRN8naR7Mk19TVlO4mSoRm2errgQVqqnUzitTcxwTQRPapFBVjP/+7tX0U7mI45dukAa7do1BmDrB86bgq7MUB5FNXxcrwg/zbhRTioCBpZpGObckI6FHkGYfyM9JVxURqADAebsfkVYPXZjSFiIRaRms0B8bZdNLVGGdzNbup1Ct/lGpy7da9bK5P2GCTCEOd+7lTY+zAohXGPeuhBcN7ddnnWqMXot6SV/+kyLxMtRY/4YVO1j2fYz2LX9oK/6piF9br/s6Vywj/1MNhGhxPp6swhoFUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMvJ0cK1RtZ4HhvKKjbtYOgW4IAD+9M5R56NNR8pkoU=;
 b=IPtVNTjA7dMEDLljx5sgPP0MYJngVrm7mgO18oGjQ4f4JWkOaMrYdbMhYfVfHxz5b722czhY5A47jUElc9qkO9NNRXBs9LlviVPIiwdsDIiTNpnxM66hCU2Hvu7AsSiPAQ5pR3+XCfCr1BlV+5wxqVFuuSEHNaXtDkmmaCkwEnDbTAii1AmGV5O8w5hoDdH0CL/sQP8rMfwe8PW4pOUT9L/S3PlRWqBt4wiiV5CK0Dx4s58O3SWC5iSuFBwCiatPnjdMOJbJKDoa/sbybnd2VxgAa6JbmsekGZgBv4SJdwuzcfU+FRQRsccOY4h3zZyMtAMno4VosmwL6kUjzIBr5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMvJ0cK1RtZ4HhvKKjbtYOgW4IAD+9M5R56NNR8pkoU=;
 b=CV6INuQN8jBAEXQKlU6PgB3pLmto6HGnY4RPbF32fhV+yiMYdcBbkR2QSoFHfn333aDTlVC21stedL5ACZPt1HXE49LaM7D3FXFklPBF5nR0gVj1t7Odf94TKEs7lY6b9tGNMIgtQSf42D+xC5D3vG3u5RchtAAUX3qwR++QMa0=
Received: from DS7PR05CA0098.namprd05.prod.outlook.com (2603:10b6:8:56::8) by
 DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.19; Tue, 13 Sep 2022 14:48:49 +0000
Received: from CY4PEPF0000B8EF.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::9c) by DS7PR05CA0098.outlook.office365.com
 (2603:10b6:8:56::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.5 via Frontend
 Transport; Tue, 13 Sep 2022 14:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EF.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.9 via Frontend Transport; Tue, 13 Sep 2022 14:48:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 09:48:47 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <helgaas@kernel.org>
CC:     <regressions@lists.linux.dev>, <airlied@linux.ie>,
        <linux-pci@vger.kernel.org>, <tseewald@gmail.com>,
        <kai.heng.feng@canonical.com>, <daniel@ffwll.ch>, <sr@denx.de>,
        <m.seyfarth@gmail.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: make sure to init common IP before gmc
Date:   Tue, 13 Sep 2022 10:48:32 -0400
Message-ID: <20220913144832.2784012-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220913144832.2784012-1-alexander.deucher@amd.com>
References: <20220913144832.2784012-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EF:EE_|DS7PR12MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: 19cb231a-9c84-4845-cef0-08da9597115f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /muC4vf1lma2wu4hSTmKqdlCRdiUTwKxkiGbYiNHyDXjvtKRVhidamxH+X8lj5XrJtsP4sheF4RNccDqWdYokb4YbrzHaJdj510SbhaYCMxr4S5oSRSq5te4AFghyz15eoD8ChJtVYczgswmFC2U+oVp1CGpgHRke+hoafcQztb9QduPncV3G7GdbvNqlGVs0gNXYl0DA7SgEPrdbqfIa8Fqn+TzyEw5NPhZP6ZxjVekFeurvkWqCuUsqMy1HwKKDnDxhFjMVP3ROPW84JsnnxFqxzjK1rJAp/t9Q7Z/Ee1dRFSFsspFM/s4+cYyWTO2dD1I5T9IeMdsc0Q1X+cCGh+25+S3q/879IuMTFs6XzRtD1uH+vLYG3zEVQ6fZJd+q0UeM9ahFAYWEpl5Amz2/Y6Q+UqGihaxSZZZ/r1EHNFyA0Z+lAykDsMRDA23+ZMU8WPgqWiXqd3dStUbUYd0p+I8CZ8zXnRE0IGAjoWDqkOuafyIe/06EuQ+KL1TZ9va5AHboLslksIA3N1j6QiYmhOmFgdbTmOVbHUH1nKHKa75hNorDGDo6aB8w3qS//go7CUZskkNCFkD1UWLPREt5SH6MXZ/c90jSE/0Y+cSY11QgcPfJvJ9lu5peOlAcmwuVQ/TOhfS5ELvmxSm4Ulax31HZwKUX+W9JxreyNsD5h0EM12z2lzOndFhNOi7soerGEALek15x9CLSeJfPQ5iKFC979+Wigspj5fSZtWfUckfYAghUJnqhzCa+G/iEuLBwMdeN2YgZCQMZPC1Oa1ZgcwW4LDxmn00k1mZ87hlnzy1o9ESNQ0MsVR06+C4dqVgNazgyTGxRyJrs2eBjMRoHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(356005)(8936002)(47076005)(70206006)(8676002)(2906002)(2616005)(86362001)(4326008)(478600001)(82310400005)(186003)(36756003)(41300700001)(26005)(16526019)(966005)(40460700003)(7696005)(36860700001)(336012)(81166007)(110136005)(1076003)(40480700001)(82740400003)(54906003)(316002)(7416002)(6666004)(5660300002)(426003)(83380400001)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 14:48:48.9345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cb231a-9c84-4845-cef0-08da9597115f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move common IP init before GMC init so that HDP gets
remapped before GMC init which uses it.

This fixes the Unsupported Request error reported through
AER during driver load. The error happens as a write happens
to the remap offset before real remapping is done.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216373

The error was unnoticed before and got visible because of the commit
referenced below. This doesn't fix anything in the commit below, rather
fixes the issue in amdgpu exposed by the commit. The reference is only
to associate this commit with below one so that both go together.

Fixes: 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in get_port_device_capability()")

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

