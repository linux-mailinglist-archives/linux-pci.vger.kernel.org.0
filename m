Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FF625B401
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 20:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIBSmv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 14:42:51 -0400
Received: from mail-eopbgr690081.outbound.protection.outlook.com ([40.107.69.81]:32764
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727949AbgIBSmq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 14:42:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIi7Q9OEOH5mViK90qZ5xKxtMuA6VMGN7ZHfgg4cAWg70hW3r3BeN478W1FnbGtfI6jOwiNR17VnuWkONodkl/QgxBlzic2mF5GdPskud4J+1ka6Ds+ZYySBWomyW0eG2OhovEk8ptT200Mop/6jjmCDu2awNeFoVPHlj/2fu4d2+JUY3m1gqrxaoN/DlPNb1h9rTJpzpJ9nRC9viggPw7vzqkNMXgNdvEgAq/iG7K6HkhYmuVtVQajvlUyQNrIGicuAMA1Kd+A/hdogbj/0ZcMeKuBM5J/QFqOHNXcke8+7dABjq3CJ0vfssOpkB2/An53k/aFacVLK1SgzKa3Png==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D47DwW1UsgsYOwf+GdZbEucDvh4xznXRlexqRqYOJKA=;
 b=iyiVewjKYuUe1I44aEs01wEDaC4BSsNJd2SlDVgBjeVYMyQbrRaCfUszIegVAOm8yodNPSreV/J2K9/K9pNxKBD+q0bBXBo0BO4jMGTg8f0/AR69FDSnvWqbp6SYvTIu2uHu51g1p+Sv7ezbouxKS7CGralTo1gQRockFvGmTHEBwZNiXsfdKBSMQELi7BFGjFYI/qNy2eEe9c5f6b9Kn9het7lNX/9PqRyqOnPpt5H25jvTXHUQi3HTFlxW9JiN/Ql7CENhF2/CxNv48D6IJ0Sxv2fXQ8IluZKv8g5GvjLQ4jAHKdNGmx00Ie8fdorQFvWgT020bR/k9oyrWJ3eGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D47DwW1UsgsYOwf+GdZbEucDvh4xznXRlexqRqYOJKA=;
 b=u0oCtUWVxf+yyIZh6LNMwtSDEGNJmwwcqcIvvfND061BYYY98h6QeAS/9SV1CD1LZgqcFnTQnaZ0537Vvq9zImfUWSroZzU3X+MWCLLgMUX1HILj05bysrT3ltlyz7luuFcbKVlghq20l4znfgn0xnH3BGRvmTStUwjfdlSHcJE=
Received: from BN8PR04CA0049.namprd04.prod.outlook.com (2603:10b6:408:d4::23)
 by DM5PR12MB2424.namprd12.prod.outlook.com (2603:10b6:4:b7::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Wed, 2 Sep
 2020 18:42:43 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::7d) by BN8PR04CA0049.outlook.office365.com
 (2603:10b6:408:d4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Wed, 2 Sep 2020 18:42:42 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 18:42:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 13:42:42 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 13:42:42 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 2 Sep 2020 13:42:41 -0500
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To:     <amd-gfx@lists.freedesktop.org>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>
CC:     <alexander.deucher@amd.com>, <nirmodas@amd.com>,
        <Dennis.Li@amd.com>, <christian.koenig@amd.com>,
        <luben.tuikov@amd.com>, <bhelgaas@google.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH v4 4/8] drm/amdgpu: Fix consecutive DPC recovery failures.
Date:   Wed, 2 Sep 2020 14:42:06 -0400
Message-ID: <1599072130-10043-5-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d586669-8769-4f13-d153-08d84f6ffa0e
X-MS-TrafficTypeDiagnostic: DM5PR12MB2424:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24244FBFC8D7D3CB64542A97EA2F0@DM5PR12MB2424.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mwNnHNzah7SpWW6vf3WoD1AO7t2WKJymV1MxpsdUuym9TaZEo5yYCOp5VIsnYYOVzKveOAjZwEBmPUvADAmr8f160hM5r2l0rKrOu0lLJGdif9DdFFRtmmdzA0Wc8GtO3GvUdSOFz7rWKWhx7ygne4GWodqATB4OlhvuV+8RSLa26srQx7IWZUcZkb7MaHEQZFREME1CRKv3DyuEMsU41kZ7+TzKg68KXKPNQO+53IEafOnTBk8L0HLdjn0OhhsFGqX8a4ADbAfE9QDTuvD/6ZewHJu179NBXf3r++GIbxmT1211qFbuwDlhdN9J4fxGy6n0KnVfm5RI4rcZPuEQfWqDgIh7ZAffaKaocCXEtmmKhcWMRmVwVCMamjKV2D56RxWcWVaMaudwhWKorbq0PQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB02.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(46966005)(54906003)(82740400003)(110136005)(70206006)(26005)(83380400001)(82310400003)(70586007)(426003)(44832011)(86362001)(81166007)(4326008)(8676002)(316002)(2906002)(2616005)(6666004)(36756003)(47076004)(5660300002)(186003)(8936002)(356005)(478600001)(7696005)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 18:42:42.7744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d586669-8769-4f13-d153-08d84f6ffa0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2424
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cache the PCI state on boot and before each case where we might
loose it.

v2: Add pci_restore_state while caching the PCI state to avoid
breaking PCI core logic for stuff like suspend/resume.

v3: Extract pci_restore_state from amdgpu_device_cache_pci_state
to avoid superflous restores during GPU resets and suspend/resumes.

v4: Style fixes.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 62 ++++++++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/nv.c            |  4 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  4 +-
 5 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b20354f..13f92de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -992,7 +992,9 @@ struct amdgpu_device {
 	atomic_t			throttling_logging_enabled;
 	struct ratelimit_state		throttling_logging_rs;
 	uint32_t			ras_features;
+
 	bool                            in_pci_err_recovery;
+	struct pci_saved_state          *pci_state;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
@@ -1272,6 +1274,9 @@ pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev);
 pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev);
 void amdgpu_pci_resume(struct pci_dev *pdev);
 
+bool amdgpu_device_cache_pci_state(struct pci_dev *pdev);
+bool amdgpu_device_load_pci_state(struct pci_dev *pdev);
+
 #include "amdgpu_object.h"
 
 /* used by df_v3_6.c and amdgpu_pmu.c */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 412d07e..174e09b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1283,7 +1283,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
 		pci_set_power_state(dev->pdev, PCI_D0);
-		pci_restore_state(dev->pdev);
+		amdgpu_device_load_pci_state(dev->pdev);
 		r = pci_enable_device(dev->pdev);
 		if (r)
 			DRM_WARN("pci_enable_device failed (%d)\n", r);
@@ -1296,7 +1296,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 		drm_kms_helper_poll_disable(dev);
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 		amdgpu_device_suspend(dev, true);
-		pci_save_state(dev->pdev);
+		amdgpu_device_cache_pci_state(dev->pdev);
 		/* Shut down the device */
 		pci_disable_device(dev->pdev);
 		pci_set_power_state(dev->pdev, PCI_D3cold);
@@ -3399,6 +3399,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		dev_err(adev->dev, "amdgpu_pmu_init failed\n");
 
+	/* Have stored pci confspace at hand for restore in sudden PCI error */
+	if (amdgpu_device_cache_pci_state(adev->pdev))
+		pci_restore_state(pdev);
+
 	return 0;
 
 failed:
@@ -3423,6 +3427,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 	flush_delayed_work(&adev->delayed_init_work);
 	adev->shutdown = true;
 
+	kfree(adev->pci_state);
+
 	/* make sure IB test finished before entering exclusive mode
 	 * to avoid preemption on IB test
 	 * */
@@ -4847,7 +4853,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	/* wait for asic to come out of reset */
 	msleep(500);
 
-	pci_restore_state(pdev);
+	amdgpu_device_load_pci_state(pdev);
 
 	/* confirm  ASIC came out of reset */
 	for (i = 0; i < adev->usec_timeout; i++) {
@@ -4927,6 +4933,9 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 out:
 
 	if (!r) {
+		if (amdgpu_device_cache_pci_state(adev->pdev))
+			pci_restore_state(adev->pdev);
+
 		DRM_INFO("PCIe error recovery succeeded\n");
 	} else {
 		DRM_ERROR("PCIe error recovery failed, err:%d", r);
@@ -4966,3 +4975,50 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 
 	amdgpu_device_unlock_adev(adev);
 }
+
+bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
+{
+	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	int r;
+
+	r = pci_save_state(pdev);
+	if (!r) {
+		kfree(adev->pci_state);
+
+		adev->pci_state = pci_store_saved_state(pdev);
+
+		if (!adev->pci_state) {
+			DRM_ERROR("Failed to store PCI saved state");
+			return false;
+		}
+	} else {
+		DRM_WARN("Failed to save PCI state, err:%d\n", r);
+		return false;
+	}
+
+	return true;
+}
+
+bool amdgpu_device_load_pci_state(struct pci_dev *pdev)
+{
+	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	int r;
+
+	if (!adev->pci_state)
+		return false;
+
+	r = pci_load_saved_state(pdev, adev->pci_state);
+
+	if (!r) {
+		pci_restore_state(pdev);
+	} else {
+		DRM_WARN("Failed to load PCI state, err:%d\n", r);
+		return false;
+	}
+
+	return true;
+}
+
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index af99a5d..b653c72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1322,7 +1322,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		if (amdgpu_is_atpx_hybrid()) {
 			pci_ignore_hotplug(pdev);
 		} else {
-			pci_save_state(pdev);
+			amdgpu_device_cache_pci_state(pdev);
 			pci_disable_device(pdev);
 			pci_ignore_hotplug(pdev);
 			pci_set_power_state(pdev, PCI_D3cold);
@@ -1355,7 +1355,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 			pci_set_master(pdev);
 		} else {
 			pci_set_power_state(pdev, PCI_D0);
-			pci_restore_state(pdev);
+			amdgpu_device_load_pci_state(pdev);
 			ret = pci_enable_device(pdev);
 			if (ret)
 				return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 4d14023..0ec6603 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -311,7 +311,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
 	/* disable BM */
 	pci_clear_master(adev->pdev);
 
-	pci_save_state(adev->pdev);
+	amdgpu_device_cache_pci_state(adev->pdev);
 
 	if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
 		dev_info(adev->dev, "GPU smu mode1 reset\n");
@@ -323,7 +323,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
 
 	if (ret)
 		dev_err(adev->dev, "GPU mode1 reset failed\n");
-	pci_restore_state(adev->pdev);
+	amdgpu_device_load_pci_state(adev->pdev);
 
 	/* wait for asic to come out of reset */
 	for (i = 0; i < adev->usec_timeout; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 2f93c47..ddd55e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -484,13 +484,13 @@ static int soc15_asic_mode1_reset(struct amdgpu_device *adev)
 	/* disable BM */
 	pci_clear_master(adev->pdev);
 
-	pci_save_state(adev->pdev);
+	amdgpu_device_cache_pci_state(adev->pdev);
 
 	ret = psp_gpu_reset(adev);
 	if (ret)
 		dev_err(adev->dev, "GPU mode1 reset failed\n");
 
-	pci_restore_state(adev->pdev);
+	amdgpu_device_load_pci_state(adev->pdev);
 
 	/* wait for asic to come out of reset */
 	for (i = 0; i < adev->usec_timeout; i++) {
-- 
2.7.4

