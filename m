Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECD45B3D63
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 18:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiIIQtF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 12:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiIIQsi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 12:48:38 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EF51473BF
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 09:48:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRjJPjvC4D6By5/yfTgvJFwCvY1gFgArobUKMhBkFCyUjCvW5WGiPn0dodL+FOcjiOglFmtUzgTfMHdzkMy2Brf6rKZlY+EML3Lv36z5oL5xp9WVswZyAt3aGXhsgG1i/JG4QgQ3IzCOTrrvp34R/7k7Ec2oBj9VRaa3ciDvKGXH3pJCokLD4LzDNtjp2/4wF4aYtuS9jT8xE1L+28rzQxdl/z6t/R4f6UlRyJ+4sUhGRipcJzTG0gZgEaarxvPu37ngS78f6k1mc2aLfKelSd6DsqkF6rZvqZGHKYvHOQeoUyZjL6s6zRJqag5iFUC5HUl8hgEdG+85B9WsibvwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uOI5sMmg6ldzbyIvS5rWKQT3pk/iUNp2GBuBzs3CxM=;
 b=EPHIushczj2UN1gsEyzZ88UDjJaBB3WLTPB36qz0MKIOH4mDsfXtbvAqoLRCL+UnKi1nOzQheDGWHAxLKOCJg2GTZBcjx4C/9wbXk5afDhJxj0rui6NJKuSStXn7sfm8yDHKSutEB91iuT4W9lIyzkUlwMtBYg9GqjAiAsjYFA7F4dlp9J/7JjdjJDQEu77MmrZG0Twuye43Q1yx7pmha6dt81sGxaz2zq+gqXZmAUL4glpMiCYy+gcqmtza+9MzNhGHU79BGBIpfwRxIdtqdkkTITsQj2hwVUhVUu6olrmnMJYACCDyVlpfgm1RH1SNka+0bpHCgNtyqq3XBAEkPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uOI5sMmg6ldzbyIvS5rWKQT3pk/iUNp2GBuBzs3CxM=;
 b=SixiTIMeQQlgswZzubZttoBnwBtc5Sj4er1Mg2FTAxqs98lOuvImCfRcrL5mc37ciJAGpKKp9Lqo92aP/1hDmRLBm2/J2ZyhrMaU+kiRI3lVB86M+oEjV0RQlQcO4OjOWTju3/t649WugHhj0wJjshKefUohlG0EeOsI5gbZNGw=
Received: from BN9PR03CA0133.namprd03.prod.outlook.com (2603:10b6:408:fe::18)
 by DS7PR12MB6334.namprd12.prod.outlook.com (2603:10b6:8:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Fri, 9 Sep
 2022 16:48:17 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::9b) by BN9PR03CA0133.outlook.office365.com
 (2603:10b6:408:fe::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Fri, 9 Sep 2022 16:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 16:48:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 11:48:16 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <helgaas@kernel.org>
CC:     <regressions@lists.linux.dev>, <airlied@linux.ie>,
        <linux-pci@vger.kernel.org>, <tseewald@gmail.com>,
        <kai.heng.feng@canonical.com>, <daniel@ffwll.ch>, <sr@denx.de>,
        <m.seyfarth@gmail.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/7] drm/amdgpu: move nbio sdma_doorbell_range() into sdma code for vega
Date:   Fri, 9 Sep 2022 12:47:57 -0400
Message-ID: <20220909164758.5632-7-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|DS7PR12MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a196f13-acd6-4f23-e0d7-08da928318ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lvUYJ+Qsuo2Rn5WTKHFAIJ/+aMFOEfnrTbvhUdZZZpvDQbpD5MOYCUAe17eSlB47/gosuR0Wx9JLAV+SOlQXbJNK5LIY0hY88K1Q6ei2s8Z3TLs/FOyBpMqSJQN1xQDMUKxI2qCkUJvcENqPCWxoYspbraWsei31dnhuPhzhUIAjzw8L1MLCU0E8nWWe9hShYl8uTx4/TYF8eoRMJSF+kdWkrPb5MRKwBE95bxBFqR2BXfzO9YuL7nDVcW667elvwvE2x2VAM2gVnN0JxxjkMw8ld1R8gXwy4mtNontxEzu6XUAX4eTCFlrizStw6/46erfraJNSZeCAQOKBN9aW70yK4O63XAmhs4++nS7/qnyXelwvE3i07i9HCZaUZ55ICTo33RJd4L2Nd1n5tut/2/TdA2uiWoKbPkUOFX1+pPBF3xom8gjGq/ZtdxaCAiMwfPK4Gv853LwY1jOsMnFS0+arpLqDLf252kxQCFALoTAo2k+t6YTEu6Un06ms8gRRPdXMYpSgYMuiCDSbW9NZqDHXdOj/4tUa4JaQFcM05bl61mbXXNai1vSUAStqcE9I4+oixpWiMUUP/zI/0EGr/udRJI5C+/QmLflRTeP9/nfd2pA3z5TkAiuqllOJYihCo1aZB2fErWnnMdFA7Nt8lRGEwmH0FhNei/CrtDeqvR6FtPZygOX35J6rMCpovmVp+8tm1TiWrdVnNQbtSqIsnIZUpVqrlT8BkV0bTFde9ZmNS1EZx9TUKqLTumNUUs+PqK1LizxLu8pytxPtch+0qGP4HlsMpsF8jJA4fPMY/vk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(40470700004)(36840700001)(46966006)(1076003)(186003)(26005)(336012)(8936002)(16526019)(2616005)(86362001)(426003)(5660300002)(7416002)(6666004)(36756003)(7696005)(478600001)(41300700001)(47076005)(40460700003)(356005)(81166007)(4326008)(83380400001)(36860700001)(2906002)(40480700001)(110136005)(8676002)(82310400005)(316002)(82740400003)(54906003)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 16:48:17.7919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a196f13-acd6-4f23-e0d7-08da928318ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6334
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This mirrors what we do for other asics and this way we are
sure the sdma doorbell range is properly initialized.

There is a comment about the way doorbells on gfx9 work that
requires that they are initialized for other IPs before GFX
is initialized.  However, the statement says that it applies to
multimedia as well, but the VCN code currently initializes
doorbells after GFX and there are no known issues there.  In my
testing at least I don't see any problems on SDMA.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |  5 +++++
 drivers/gpu/drm/amd/amdgpu/soc15.c     | 22 ----------------------
 2 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 0cf9d3b486b2..7fe8bf3417db 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1504,6 +1504,11 @@ static int sdma_v4_0_start(struct amdgpu_device *adev)
 		WREG32_SDMA(i, mmSDMA0_CNTL, temp);
 
 		if (!amdgpu_sriov_vf(adev)) {
+			ring = &adev->sdma.instance[i].ring;
+			adev->nbio.funcs->sdma_doorbell_range(adev, i,
+				ring->use_doorbell, ring->doorbell_index,
+				adev->doorbell_index.sdma_doorbell_range);
+
 			/* unhalt engine */
 			temp = RREG32_SDMA(i, mmSDMA0_F32_CNTL);
 			temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 1dbb2a3ac4c4..218571574fa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1211,22 +1211,6 @@ static int soc15_common_sw_fini(void *handle)
 	return 0;
 }
 
-static void soc15_doorbell_range_init(struct amdgpu_device *adev)
-{
-	int i;
-	struct amdgpu_ring *ring;
-
-	/* sdma/ih doorbell range are programed by hypervisor */
-	if (!amdgpu_sriov_vf(adev)) {
-		for (i = 0; i < adev->sdma.num_instances; i++) {
-			ring = &adev->sdma.instance[i].ring;
-			adev->nbio.funcs->sdma_doorbell_range(adev, i,
-				ring->use_doorbell, ring->doorbell_index,
-				adev->doorbell_index.sdma_doorbell_range);
-		}
-	}
-}
-
 static int soc15_common_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1239,12 +1223,6 @@ static int soc15_common_hw_init(void *handle)
 	adev->nbio.funcs->init_registers(adev);
 	/* enable the doorbell aperture */
 	soc15_enable_doorbell_aperture(adev, true);
-	/* HW doorbell routing policy: doorbell writing not
-	 * in SDMA/IH/MM/ACV range will be routed to CP. So
-	 * we need to init SDMA/IH/MM/ACV doorbell range prior
-	 * to CP ip block init and ring test.
-	 */
-	soc15_doorbell_range_init(adev);
 
 	return 0;
 }
-- 
2.37.2

