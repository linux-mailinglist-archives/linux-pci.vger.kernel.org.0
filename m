Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C234B5EA3
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 01:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbiBOAEc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 19:04:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiBOAEb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 19:04:31 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0597A9AF;
        Mon, 14 Feb 2022 16:04:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMb+6XIZOwz8L2seRikZvYTke2K98XTmKguxRkPTLekwh4eT9rrZ/xaZzjTy9tMikcjTQX7CgT3+4HhCWC02VpI/49k8RCbyH2k8k9pd2hnO0ew+a2MpMCHXBdWFwB9JBMM5xWUobpnN3BRwIdWAZqyokKTFoDRQF8UDENL9j5eRUMJ4WNJdjWoVSpuU1d3aWTbWgCs9w4ynQyHxgEn7QQCjqm1JOoRQIedlQRqRiwRiy2gaKAcPtvbLVORc7cWay7N0uoiG66ePtGKtsDatTO9ZoeDEMRl/EVeiDF7xCJBOpNcIyCEvax+JefojiU/dTLlikHiQrsagTt9C/s+PZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4yk8hvDmhzfiKFK+3l63Ar/Gg2nsFdd8RGrNekuAok=;
 b=TrFGLsMEyeQx+UTNBhDF6lrT4DQcgx+EE8yesIRPN42MQ1VY1i4QSXgbpfGCkZe5XvI7fHwJK4+/WN3IbZJXLCv6kjka0MISiYdhBDnRBmOL3MhYMkv99TsUHTxUSk00VplR1sUrdvw9q1wA2U4QvhmG5AM1hQ5fYNLUgXybyzohztYXoLbugqku5jxF35aXTK48fXpFMzeDsssvIaAZhOcGVY2v9C9URUZIaa8I2CRIvm6hqmEm0IyRtExePBxlPMAB5PlcO3gJ+j38F4DFnry1OYlzko6mKiOus+DnQZ5+n4R9glkGF1uCJo1Qsi8uRSdi1S7LgbBUUL2YMmWneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4yk8hvDmhzfiKFK+3l63Ar/Gg2nsFdd8RGrNekuAok=;
 b=Z1q1k/D8eJebdqP+EGW29Y/6sQk3OaDB7mChuhNMAjqwxK098h0JJ74grEUfhoU1AnqNycpvTWNyaZsUxpoLhfvdWA0fLNH+zR1kN8HJyuVJ3QLdhiVOAKY6RTcESabMJmNveaJCi7z6RA0jEQxIfuPbbON7BH4Vos5O3hCLYMs=
Received: from MWHPR12CA0039.namprd12.prod.outlook.com (2603:10b6:301:2::25)
 by BN9PR12MB5209.namprd12.prod.outlook.com (2603:10b6:408:11a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 00:04:20 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::b0) by MWHPR12CA0039.outlook.office365.com
 (2603:10b6:301:2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Tue, 15 Feb 2022 00:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 00:04:19 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 14 Feb
 2022 18:04:16 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>
CC:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Lukas Wunner" <lukas@wunner.de>, <Alexander.Deucher@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Macpaul Lin" <macpaul.lin@mediatek.com>
Subject: [PATCH v4 07/10] drm/amd: drop the use of `pci_is_thunderbolt_attached`
Date:   Mon, 14 Feb 2022 18:01:57 -0600
Message-ID: <20220215000200.242799-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220215000200.242799-1-mario.limonciello@amd.com>
References: <20220215000200.242799-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 876067ce-20cd-417d-c12c-08d9f016b6fe
X-MS-TrafficTypeDiagnostic: BN9PR12MB5209:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB52094C94CE3243FF0C63F745E2349@BN9PR12MB5209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kk2P+juuQEP1Na60Bb5ELSQp1ELRyVpVZbnC4cOA1++18HpARLJ6lxJz8PxpChXllgAGGg/xolbKRPQxWR0fHPiPKuiRWdIHq8g2dcUQkhY9UPOHTYLhvj3ExzrO+BuNEKNrp0tuMAI3zr3JoQvbkl1uzULFN4UfhIB4V5t+98WSOj4n8pVOy5g8d2AK52ThzC5GVKXJzN2P4l2U87HptrXYbn8xHlmQ0LXCS3uODsscGGCNETyOhqWXToUnBJWt/2XMJQtnAn/QZPIguOMbX5oBOAL5ZH+QNqMwnmhxW74LDJBVaUho9qvOeVlUvf9si9jcn/k6+BxMcW9+5lvff/u8n8rBNWZ2RGk0Ub9xv+GzZ1s+dUr6/xgbN58wp6wDrQU0gNxNd6gJfb9M2Y3v3fbNSR4ZpfQlMzoYHcPf+gcaZfEHWDqkXY3wL2vBEAx6+EpvpCtY/rMv29/Hl7gnwAo/PqlVL/7G5DzeluqT5emCMhzGqckpuAyOHZO3YSo0WDuPXRT22n5422FrOdQtJTi39PEJNBoy3cdjommWq2eqqC4oLCp07KrY+zYmTTwB0Z1F8FXTS9TpNwJ+jpHNx/Q+EECmw01+9/qIv42/ro4N8MZfC9dyCm+Zp2iL/OVVnNhbGO2ZTIHTOYQ8HxqiQvH2vuHCnNpFVMDYRhc1f4L+a8UwSs0hbrkfUVjQKuV7mns1nfT73Zek2Exv4ND0yBoumURNo182p13wJBAKqwM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(36860700001)(336012)(426003)(86362001)(47076005)(356005)(82310400004)(40460700003)(81166007)(16526019)(70586007)(70206006)(2906002)(1076003)(36756003)(110136005)(316002)(54906003)(8936002)(44832011)(8676002)(5660300002)(4326008)(7416002)(508600001)(186003)(6666004)(26005)(2616005)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 00:04:19.8169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 876067ce-20cd-417d-c12c-08d9f016b6fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5209
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently `pci_is_thunderbolt_attached` is used to indicate a device
is connected externally.

The PCI core now marks such devices as removable and downstream drivers
can use this instead.

Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 1ebb91db2274..6dbf5753b5be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -161,7 +161,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 	    (amdgpu_is_atpx_hybrid() ||
 	     amdgpu_has_atpx_dgpu_power_cntl()) &&
 	    ((flags & AMD_IS_APU) == 0) &&
-	    !pci_is_thunderbolt_attached(to_pci_dev(dev->dev)))
+	    !dev_is_removable(&adev->pdev->dev))
 		flags |= AMD_IS_PX;
 
 	parent = pci_upstream_bridge(adev->pdev);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index ee7cab37dfd5..2c5d74d836f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -382,7 +382,7 @@ static void nbio_v2_3_enable_aspm(struct amdgpu_device *adev,
 
 		data |= NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L0S_INACTIVITY__SHIFT;
 
-		if (pci_is_thunderbolt_attached(adev->pdev))
+		if (dev_is_removable(&adev->pdev->dev))
 			data |= NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT  << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
 		else
 			data |= NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
-- 
2.34.1

