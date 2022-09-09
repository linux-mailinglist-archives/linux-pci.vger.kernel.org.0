Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B489C5B3D6B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 18:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiIIQtC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 12:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiIIQsi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 12:48:38 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08851473AD
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 09:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbjZBojrOu/SE6ByL1/qnN+neTXQI6C2bEBWT7CDXPFPB1FENVg+MKtIVN9ApbjCp+cT8V0si0u1yNaRj+esAL2DJvGGMMsqL2tPllsoSjG+bSdiDh+YT38ConR3WB0Rv+jsLfGNToQWMLDeZ0KVmXNW5ci3D3Ch9mJs/1z6caTVTRfCzbCynKv0C+k3XsCsq/vUhED6qxizECyBRZ0CrlGDUArgO+5q2YlWC9irWLklCMlwilMgOMbvPOlg3NQ7zy31rAFavL82cJYff78+BXj0Xe2JoWfToXYLnoMZ84d2mODjQtM4LaoO8Se3ULvCtjno9wzFpEOfLam7747m6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gcpqfjUwXiegHzeEhsvThhQFBMNZtA7QZSmeL8pPQc=;
 b=YhED1F2qA9xNdvkF+G0EEq/i3LoxMukAWZ2YAfgR2JNbLW2m2FBws45QfIWW0gGvIojOoVM/1zAZaiFtyKvYNaYKlZckYid2VM5GoBojRsfsNaMogqEili9ZCmX7QFJyls8RA8QhH7IYt7O7BoSsnPG2WO9n52m9JaZblixMnjtpsRBJuI0THks/MAMNgiCJUbrxGg8pnB42ZypgTc6ljlBrjyoc36HiUJERqttjQchF2wjembhLa0Yi/tpJcE9M0BfmSpyqzVnnedMeD8EYp+CEoy8ZJWdPHSADYJh8elgAYXDXandXUQl7p4DldZfd5hyMa7XPNmj1VlT++Ek0rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gcpqfjUwXiegHzeEhsvThhQFBMNZtA7QZSmeL8pPQc=;
 b=Jz4UjJiRL8mxvoua78o74HlAZDTye0MLA9rD/iYuHnArQPZWGwXpJJVToaj+rUL9qc4ugwcN2+Tta7IgEywl0VPaqqCToMf4ZifYvkJAH7irZjh/7h7vPImox7ytQ53rOOt3XCMC1KVJ/kFgdsahfRpiu5FMuDpgLDyCLQfy6i8=
Received: from BN9PR03CA0140.namprd03.prod.outlook.com (2603:10b6:408:fe::25)
 by DM6PR12MB4545.namprd12.prod.outlook.com (2603:10b6:5:2a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 16:48:14 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::3f) by BN9PR03CA0140.outlook.office365.com
 (2603:10b6:408:fe::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Fri, 9 Sep 2022 16:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 16:48:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 11:48:12 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <helgaas@kernel.org>
CC:     <regressions@lists.linux.dev>, <airlied@linux.ie>,
        <linux-pci@vger.kernel.org>, <tseewald@gmail.com>,
        <kai.heng.feng@canonical.com>, <daniel@ffwll.ch>, <sr@denx.de>,
        <m.seyfarth@gmail.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/7] drm/amdgpu: move nbio remap_hdp_registers() to gmc10 code
Date:   Fri, 9 Sep 2022 12:47:53 -0400
Message-ID: <20220909164758.5632-3-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|DM6PR12MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e6389d-8627-404e-6e6c-08da92831688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZ6Na1Fh9KA+1pGxVwxPlVobkz25Mk6JLuoJVbqNWOWPJdy8A9DSoEnBkbB/T8SOV+LM4PTahqBj3DT5Cp6QrXZ9W51CiyylbGwujC1xJpKllrASx4NL/j2uxWiNxxZcE+kmPlbxKFBCPAuGM9aimL1HyxxFOsSwets7yJpphXptXDpkwrBPRPQDPGai0JMeHSOCKebdjtqiG547ClxpmJIbvyptl/nSGvuAa0WA8jyB0fAwOzO68azWbH0ur8A0KIfiDS4x4+8fDCpm/Z3UnnCPZfvHswlQy4QvxQFc9aasNGxWyNEIxR8v64uGsmeEQDd7gdv1VvG0QsG/z/NpGt/5ZDtUC9kuwZjy062BLBpow8tK1EN60AQ9u2ZMPag5hHzzdOalt6fFGBfAbnVRLP/bmA1+B9k5kXnU67XA6sAx4A+S/KF1cQjF17gt4YHob969fCuq9SZwIE6ncAzgbdygqhbe6JlSWyBt5UITY1JSL2XoOYmbUa3u4V86cXmVPpj79YLAGhWqkOxRHKLZqhnYbQdXMRQyorw3Cln7glH0KUQTu1iWzGJjM6ChDj+4So7L3GCVZKmek/snCUS7Uq5GXnUoq1uR1eWjRUJ+TjZgMbNyfP9OdFQj2RVE7md6PPVrasQNDcoZmyiGK3OJJK3bWShXkn+AFYfudqA0RmXc5+FTH+rPYF+dZh6sz8aD1ZHyK/O99B9ZgXWU46tv9K76vrinrxKfp9gBHVki75lv/jMyo1yPuP1sC6qfmBQlmVIDkjVyDPQUNmhwzjypmuRPIn4/htDWt6bB6SrFIIDzeAp8fRXmzxRWhvzWe+z1vUfZTG+nUisWQvF6zrohQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966006)(36840700001)(40470700004)(70586007)(8676002)(47076005)(186003)(426003)(336012)(1076003)(82310400005)(54906003)(356005)(81166007)(16526019)(966005)(83380400001)(70206006)(4326008)(316002)(36756003)(110136005)(86362001)(36860700001)(2906002)(40460700003)(6666004)(7416002)(26005)(478600001)(2616005)(41300700001)(8936002)(7696005)(5660300002)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 16:48:14.2132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e6389d-8627-404e-6e6c-08da92831688
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4545
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is where it is used, so move it into gmc init so
that it will always be initialized in the right order.
We already do this for other nbio and hdp callbacks so
it's consistent with what we do on other IPs.

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
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/nv.c        | 6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index f513e2c2e964..140eb47abce6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1091,6 +1091,13 @@ static int gmc_v10_0_hw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/* remap HDP registers to a hole in mmio space,
+	 * for the purpose of expose those registers
+	 * to process space
+	 */
+	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
+		adev->nbio.funcs->remap_hdp_registers(adev);
+
 	/* The sequence of these two function calls matters.*/
 	gmc_v10_0_init_golden_registers(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index b3fba8dea63c..3ac7fef74277 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1032,12 +1032,6 @@ static int nv_common_hw_init(void *handle)
 	nv_program_aspm(adev);
 	/* setup nbio registers */
 	adev->nbio.funcs->init_registers(adev);
-	/* remap HDP registers to a hole in mmio space,
-	 * for the purpose of expose those registers
-	 * to process space
-	 */
-	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
-		adev->nbio.funcs->remap_hdp_registers(adev);
 	/* enable the doorbell aperture */
 	nv_enable_doorbell_aperture(adev, true);
 
-- 
2.37.2

