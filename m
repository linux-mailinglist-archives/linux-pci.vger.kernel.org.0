Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE8A5B75D0
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 17:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiIMP4V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 11:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiIMPzv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 11:55:51 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F8972B51
        for <linux-pci@vger.kernel.org>; Tue, 13 Sep 2022 07:55:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAYdKfGBAyoWFSii1pPgfVceDu1y8FTO+6yf8UCtXz9hepZNFbIhVdOyEPWIGJaDmZEJ/4en9E9txmjNbhJsscwgMRDsC9MHuUpDa4qs397++t0d5hePR0NGaK5ulCBrW/qaQXYzbZ7iyMLCn63pdsI6VE7xjk39B/91jFfefjItWbrkt/AdCnq/HSdIp/OT15BCV5whXRazEGCoFi3m+HmeNZYSD2I4+ajrR4RXjzRhRrbPtranxQHKwTdavteRf8KihA5y7ExDMbyd6GdLJUaNWSWb5VYgT4SoiJy9+0cuDrM/hnqpPoHIwhjVO5DT8pc6QGenXa6Ysblo8fu1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/rNLgZyzZ6VUodTt4yEHs9rX6Uw0ih3HvVKXJasi7g=;
 b=Fd7BlPPtDuZ6i6mGra88zaOEq65866iCI/3wjGB0QnqaYMFpLR+PN77rWHgUod4aH92kSwDxTvb1DK7wCRka1WIxbVmAvaOWfKY64ZkyQ+bvXLTlkb8LY9n5HLAjujEE6tu0KL+DFsX5a1sJzS5K6CQFrQHbPTQoImauuREE1QThEunEWkCGkDuk1MI5G0k8syCfpDod3equ+I/boC3vBM4H4jdgh4a69cmj7OvrGGwGS+FbrR1KnxK300VCZXqO847vjnwOlUPIUlsy0aopx94Tz2ybI6zlgml8qQAKoV8Tc97tnHL4ld8yi+WJvnXnu3q9/bCnbVJbJ9F25vd+sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/rNLgZyzZ6VUodTt4yEHs9rX6Uw0ih3HvVKXJasi7g=;
 b=o06aqg1BRQqzEgKGgyH7zDlJgBtiICwmV90/ymWRuzULVdmzFTIO5Zj2J26Rg8sJGnCX/Gf3DbzLEtEi7tH1K0bhOaV3durUmQ68sO2P1A1VElQLiuFBP2wKgq9cV0sB4a4tiXzL0XWwDFzma99+OnoEErfSw5ICiEfI9vLJ4vM=
Received: from DS7PR05CA0102.namprd05.prod.outlook.com (2603:10b6:8:56::22) by
 IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Tue, 13 Sep
 2022 14:48:48 +0000
Received: from CY4PEPF0000B8EF.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::3b) by DS7PR05CA0102.outlook.office365.com
 (2603:10b6:8:56::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.5 via Frontend
 Transport; Tue, 13 Sep 2022 14:48:48 +0000
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
 2022 09:48:46 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <helgaas@kernel.org>
CC:     <regressions@lists.linux.dev>, <airlied@linux.ie>,
        <linux-pci@vger.kernel.org>, <tseewald@gmail.com>,
        <kai.heng.feng@canonical.com>, <daniel@ffwll.ch>, <sr@denx.de>,
        <m.seyfarth@gmail.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: move nbio sdma_doorbell_range() into sdma code for vega
Date:   Tue, 13 Sep 2022 10:48:31 -0400
Message-ID: <20220913144832.2784012-3-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EF:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 6257bc7d-d2b1-4202-21be-08da959710f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGXlls4iG597JmDlzljDK2pdisgVD9fPt1tPcCvGr1+Vtn8ErA05KGDz5kMyroQfbqXXqoyJZRNh2fYrMHTT2226izMmrwu/PYfm5vxH5R5JAzy0W6EnxwSQcjpLLkGpOInf32G2lYM2V46TClA4wWecap7E75At9Sfiox7lniUYyYnXlPJukBoYMkfrpv2EbkAHOA9VhdL7PmaTCa5jHe6eiEL3SL5xFf6fagURgLR6Y5kzMq6OFPvPonie8gMEdDzVsJrhbMGqErqk3np4tVd5q6xNNdckhC6Uv1O/wGa7GKxYxnG1B7tXHGUnwoLzccbkjC89N40JzBpbw1+OLSKfjqKow5Ek4ZT3XQTWkffOdGPAY0R/qkM4p5jtvQXjZWyGXMqqWUbimqBwHXjxKgormiQlzvw+Sa2cZ5bnCV0R0mrpYArxNXHFxvHUwFlwZ/ijAxBCLiFAfFswFS0nXBYpgEgqVXXfYq+l9wL/46Wcjqz7lgmQBbgo+yR6ud6mZX2nP8Oi12oQPTWR4+Xix5bJWVNbKXKQ4cOGl2naWzOYg9BpnnS90p/OJRp+GGsWhPgZ4BkPCNMKYnH5iPuDgGYj2d0ORdYOng8jr4GBX2QTLDgVq85Knx4ST5+ls5Sk5OfIxgv1bS6QUEPIbjvsvRy0oBYqOLj0bietya7tHelO7vPRVTW0B6JQ/wkx/mWUGINk7lrymdwtdvOpq4yV8tpfDEZvUKDyCNAW43pHIruLlxm02GY3AaN0Pfz/aQYKDXH6VZDalBVMjmL9gRuyQRptDwp+Q6MP5lR7EC0rqWAXhYz5qDjXyM0nP+mzB3cV6BdQD9nKWT4Bd/i3zsOG3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(7696005)(16526019)(83380400001)(82740400003)(5660300002)(316002)(7416002)(47076005)(26005)(426003)(4326008)(356005)(81166007)(36756003)(966005)(70586007)(8676002)(70206006)(86362001)(41300700001)(110136005)(2906002)(1076003)(6666004)(40460700003)(36860700001)(336012)(478600001)(40480700001)(2616005)(186003)(54906003)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 14:48:48.2156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6257bc7d-d2b1-4202-21be-08da959710f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index e6a4002fa67d..d9914052d20d 100644
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
@@ -1246,12 +1230,6 @@ static int soc15_common_hw_init(void *handle)
 
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

