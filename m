Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04A525B402
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 20:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgIBSmw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 14:42:52 -0400
Received: from mail-bn8nam08on2083.outbound.protection.outlook.com ([40.107.100.83]:40641
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727990AbgIBSmr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 14:42:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QR+i2S33e47tBjmtguTqVrlZqRFIGDw2usMBkxs8DPkGh5GrVX8o4L6UfTTybW0VXkZ966ARJax1dM6m++gZU+U/y3mcT+2ua7/9OG7TlsefZPuvs1VuIa8QUAJv57dyr1lJ+my9/lxxXYwosVEXcoeFOst3K7wnzPFonm4Uz187XFnz7E/MocoHcYiMSJYCW+HOAJ9ZoZ+NmeK9PUgDeWqAiILo7iOg0TMB/DdzFhfVH4OiuNwp8+7v5NpD6al6J6Gf3iYgANW6iHu+4LGnBGd6z2rYk2MiiA56vQ/vDEFR/pIhEGfBwa8odfFvUtkGWUlxx5fmG2DrtlScr3F9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgXrcPq4rGq3KBls5HUE/5Oopfr0gZ3DxsNsmVLTADU=;
 b=YhCoj90Awln6G03bYEo3RPn8fthxaoQ+4oJw8QKwMeTCdVoFsk5/WW+ztmx4BPOXbyB1cHkUJx0wKM5azDBgfekrWudIZl3mQIenafx8ZdfYEcXQTU7Zx7F39U7BP1oESuEyqfQFrAOAuA3r+7ujyhC/W4BEQEEOhIgm/MYyLxf/NUkI2zT9hEVa1AaYQJP0kImkmGjd4XFcF536NQlZ2acUphcgc5FMmDsOuBcVJf90flkALQ5eN1qeHX3VYkI+6Yv7Kd5rAuVt1/grJrwkNPycH/2uM/+gqXN7UBL6sZMnpIu3mH5txN/f93YXg2SUUWCKjrYoEGmdpUfHm5lH+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgXrcPq4rGq3KBls5HUE/5Oopfr0gZ3DxsNsmVLTADU=;
 b=U7cFqBFOY8CbmhRiOZuqT44S4lN0/iE+YOeL2eNpoIJPgCMha+uP+Q96/OoNfGX8UnkgjcQX763vD554p/1tqDE8vPiJWAajca+IRWrWsSbnbdug/+wrJR3bsNuxwKZ+CyonMHbYg+VUNrrtExNDU6pKJBl8LzOinqMLMa0J7us=
Received: from BN6PR10CA0030.namprd10.prod.outlook.com (2603:10b6:404:109::16)
 by DM6PR12MB2857.namprd12.prod.outlook.com (2603:10b6:5:184::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.24; Wed, 2 Sep
 2020 18:42:44 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:109:cafe::89) by BN6PR10CA0030.outlook.office365.com
 (2603:10b6:404:109::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Wed, 2 Sep 2020 18:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 18:42:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 13:42:43 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 13:42:43 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 2 Sep 2020 13:42:42 -0500
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To:     <amd-gfx@lists.freedesktop.org>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>
CC:     <alexander.deucher@amd.com>, <nirmodas@amd.com>,
        <Dennis.Li@amd.com>, <christian.koenig@amd.com>,
        <luben.tuikov@amd.com>, <bhelgaas@google.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH v4 5/8] drm/amdgpu: Trim amdgpu_pci_slot_reset by reusing code.
Date:   Wed, 2 Sep 2020 14:42:07 -0400
Message-ID: <1599072130-10043-6-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df3d874a-105b-4834-68ec-08d84f6ffad7
X-MS-TrafficTypeDiagnostic: DM6PR12MB2857:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2857C09E1311F9B4756102B6EA2F0@DM6PR12MB2857.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ynQNLYnIHdLy1A+AjWyTXC+YYVCTdWwt2179hJMf1//H82SE4EXZoB2tQALvdBIv7wr3KswPX1Fjz2RvJqUmKyOVfSzz8AiOxd7X40tdhD/UUTD0DxOXDyoT3f+83iNvXrDwVacDF2bfhvo/sh3zOiRgoHgv6INhS5GkfqxNqXbc9FJ0BORablMW2vrDtg+yl/QeZ7CQqGtHrLs53X1AaIouS+ZhkwbVTVWlDner0gj/JGOC3fst6MVZeZcjiaCJEhuMD1lN3N9NfPYfOEQ6B8PhCAHgZyqvbsPia/3fU8aPOYjdkjvrNtcN0D269rIskOq8IakfrbPIpImr78EBOvQj2D+oMBUJJOv7LKRbojOgU2R5J0hQb5RYLybLzkmxYpPaGFUSXlkfczuMQ5DlOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB01.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966005)(316002)(110136005)(83380400001)(5660300002)(36756003)(70206006)(2906002)(81166007)(54906003)(4326008)(478600001)(7696005)(356005)(70586007)(6666004)(47076004)(186003)(86362001)(8676002)(44832011)(2616005)(82740400003)(426003)(8936002)(26005)(336012)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 18:42:44.0890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df3d874a-105b-4834-68ec-08d84f6ffad7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2857
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reuse exsisting functions from GPU recovery to avoid code
duplications.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 73 +++++-------------------------
 1 file changed, 12 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 174e09b..c477cfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4111,7 +4111,8 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 			       struct list_head *device_list_handle,
-			       bool *need_full_reset_arg)
+			       bool *need_full_reset_arg,
+			       bool skip_hw_reset)
 {
 	struct amdgpu_device *tmp_adev = NULL;
 	bool need_full_reset = *need_full_reset_arg, vram_lost = false;
@@ -4121,7 +4122,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 	 * ASIC reset has to be done on all HGMI hive nodes ASAP
 	 * to allow proper links negotiation in FW (within 1 sec)
 	 */
-	if (need_full_reset) {
+	if (!skip_hw_reset && need_full_reset) {
 		list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 			/* For XGMI run all resets in parallel to speed up the process */
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
@@ -4517,7 +4518,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (r)
 			adev->asic_reset_res = r;
 	} else {
-		r  = amdgpu_do_asic_reset(hive, device_list_handle, &need_full_reset);
+		r  = amdgpu_do_asic_reset(hive, device_list_handle, &need_full_reset, false);
 		if (r && r == -EAGAIN)
 			goto retry;
 	}
@@ -4845,14 +4846,19 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	int r, i;
-	bool vram_lost;
+	bool need_full_reset = true;
 	u32 memsize;
+	struct list_head device_list;
 
 	DRM_INFO("PCI error: slot reset callback!!\n");
 
+	INIT_LIST_HEAD(&device_list);
+	list_add_tail(&adev->gmc.xgmi.head, &device_list);
+
 	/* wait for asic to come out of reset */
 	msleep(500);
 
+	/* Restore PCI confspace */
 	amdgpu_device_load_pci_state(pdev);
 
 	/* confirm  ASIC came out of reset */
@@ -4868,70 +4874,15 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 		goto out;
 	}
 
-	/* TODO Call amdgpu_pre_asic_reset instead */
 	adev->in_pci_err_recovery = true;	
-	r = amdgpu_device_ip_suspend(adev);
+	r = amdgpu_device_pre_asic_reset(adev, NULL, &need_full_reset);
 	adev->in_pci_err_recovery = false;
 	if (r)
 		goto out;
 
-
-	/* post card */
-	r = amdgpu_atom_asic_init(adev->mode_info.atom_context);
-	if (r)
-		goto out;
-
-	r = amdgpu_device_ip_resume_phase1(adev);
-	if (r)
-		goto out;
-
-	vram_lost = amdgpu_device_check_vram_lost(adev);
-	if (vram_lost) {
-		DRM_INFO("VRAM is lost due to GPU reset!\n");
-		amdgpu_inc_vram_lost(adev);
-	}
-
-	r = amdgpu_gtt_mgr_recover(
-		&adev->mman.bdev.man[TTM_PL_TT]);
-	if (r)
-		goto out;
-
-	r = amdgpu_device_fw_loading(adev);
-	if (r)
-		return r;
-
-	r = amdgpu_device_ip_resume_phase2(adev);
-	if (r)
-		goto out;
-
-	if (vram_lost)
-		amdgpu_device_fill_reset_magic(adev);
-
-	/*
-	 * Add this ASIC as tracked as reset was already
-	 * complete successfully.
-	 */
-	amdgpu_register_gpu_instance(adev);
-
-	r = amdgpu_device_ip_late_init(adev);
-	if (r)
-		goto out;
-
-	amdgpu_fbdev_set_suspend(adev, 0);
-
-	/* must succeed. */
-	amdgpu_ras_resume(adev);
-
-
-	amdgpu_irq_gpu_reset_resume_helper(adev);
-	r = amdgpu_ib_ring_tests(adev);
-	if (r)
-		goto out;
-
-	r = amdgpu_device_recover_vram(adev);
+	r = amdgpu_do_asic_reset(NULL, &device_list, &need_full_reset, true);
 
 out:
-
 	if (!r) {
 		if (amdgpu_device_cache_pci_state(adev->pdev))
 			pci_restore_state(adev->pdev);
-- 
2.7.4

