Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A18025B3F8
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 20:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgIBSmp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 14:42:45 -0400
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com ([40.107.237.42]:37025
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727949AbgIBSmn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 14:42:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RG1uA62vwsbER5ebHLI+bo8a+FrO3Y/oH+Fst6a216ZN7veYWmI6aYiGURROxeYXYGB1K1VkPDo4tdj2UC6k8SORSCwHpUslHU5qaFtN/pQ5ae6pSD+NMTTL1QBN+HyP7DI5tEPmiqxV8fDzqbtEtAIGe/IdL4WvMY1rvZYnvebI9giIDxJmssIGDxqV/8dn99BUakLQF6vsfoTZY4XWejQ64rA5+FRQBTPYrawBVw7pV5RwNlMLa0O8P5nU+q8H2flNvwAx0YNLACON3zB2YEEfBnVnKArHD1RHkhKcYw9T0Uvg11KQelGzt5FGjpvaAH9fmNlrmdgtTDbmMkfhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTnxDBdCjMml7DsteqWxDUwBtEIOI8fXmdrjUFclBps=;
 b=Ty2oaHtOsCOa9hVTBDp8gRoQq76EMrA7LGPy6qXXffUqglvaQiPncYTDmFOT78JtJlbD/tHu0VpM7cNJ9PJ1C/DgaKIVM21q1phtsAxmKoSB0k82jr+JUKCk+NZ6+WqXf3L9gPnq5NhyHhlWtg1BZP+hOMnFJE2ojAPq8/ermhvbNCTa/NrFhCeCRRDk0IehEUJ7BRYyPEyQovMtvh+i2MJwPVXFGF8Eu6vf8FFSgxcNd/hyb22KK+lSWzxj3eWXZDxawp07uIScMTLU4mAKSWfEgB9ctKLKiaryXIFIIx/beojynaP74njP7PnDC9fEMmA7biJ+cuKpqKzmZdB7Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTnxDBdCjMml7DsteqWxDUwBtEIOI8fXmdrjUFclBps=;
 b=OzAfwI1tpgaNjDMrvdfcSnQWMmVyO3yMIcTBlamtyKYWP54WT09PLSYIdb8y4kckip5YSVcapuEqfnI1oSwiXo5M8HQpQt1byWgT9WXf9mfELGAIlW8KoW6YZRU+l/HHoD3TA87/AHZKu8wLTYn2Tz+kyubGjXEwxu3roxW/ps0=
Received: from BN6PR10CA0035.namprd10.prod.outlook.com (2603:10b6:404:109::21)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 18:42:40 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:109:cafe::87) by BN6PR10CA0035.outlook.office365.com
 (2603:10b6:404:109::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Wed, 2 Sep 2020 18:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 18:42:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 13:42:39 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 13:42:39 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 2 Sep 2020 13:42:38 -0500
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To:     <amd-gfx@lists.freedesktop.org>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>
CC:     <alexander.deucher@amd.com>, <nirmodas@amd.com>,
        <Dennis.Li@amd.com>, <christian.koenig@amd.com>,
        <luben.tuikov@amd.com>, <bhelgaas@google.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH v4 2/8] drm/amdgpu: Block all job scheduling activity during DPC recovery
Date:   Wed, 2 Sep 2020 14:42:04 -0400
Message-ID: <1599072130-10043-3-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e175e72-182d-4cbc-b4f2-08d84f6ff831
X-MS-TrafficTypeDiagnostic: BY5PR12MB4307:
X-Microsoft-Antispam-PRVS: <BY5PR12MB430744C2172539D46A886F0AEA2F0@BY5PR12MB4307.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tnkp9fJ6uy+sv6ff8L02bB0Dyk7Crz65YxvsDehzyFLQN5GqgighmcRUZMnvU25E1Tw+ParZmRBGVN57t9/Lx556aIGPANVoAFMcuKu5e3lM6aXdz/WGVtA+Fi2gU0tlteFFlmSwUEh3N+/XnbI8SmHCsYX0YfBDSzoJUyQjCr0zL3wSMrq3jPBkAuaOX1HK9cklDjTzghgdVUO2mOax2u64pmyMsbBGeOQ6iOQ5oUS2mU+VoZs7bkEwyz6+hcjf/OGPW8SMTA1jvsza55KxtiBe1yBffU+OqY5X9rWAEP7jNps2/L054MHwIgn4n9njYE+vA/mFHlPI14iAZR2NHZeNz5sX/wHF/aeWz3kS3asmy32UWZc0rT9bpCLg0jv/LkSVJySceYdRO2ZcndFomw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB01.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966005)(336012)(7696005)(186003)(316002)(26005)(81166007)(356005)(6666004)(47076004)(426003)(82740400003)(44832011)(478600001)(86362001)(70586007)(5660300002)(70206006)(36756003)(82310400003)(2906002)(110136005)(54906003)(8936002)(2616005)(4326008)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 18:42:39.6466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e175e72-182d-4cbc-b4f2-08d84f6ff831
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DPC recovery involves ASIC reset just as normal GPU recovery so block
SW GPU schedulers and wait on all concurrent GPU resets.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 57 +++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1fbf8a1..e999f1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4740,6 +4740,20 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 	return 0;
 }
 
+static void amdgpu_cancel_all_tdr(struct amdgpu_device *adev)
+{
+	int i;
+
+	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
+		struct amdgpu_ring *ring = adev->rings[i];
+
+		if (!ring || !ring->sched.thread)
+			continue;
+
+		cancel_delayed_work_sync(&ring->sched.work_tdr);
+	}
+}
+
 /**
  * amdgpu_pci_error_detected - Called when a PCI error is detected.
  * @pdev: PCI device struct
@@ -4753,15 +4767,37 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	int i;
 
 	DRM_INFO("PCI error: detected callback, state(%d)!!\n", state);
 
 	switch (state) {
 	case pci_channel_io_normal:
 		return PCI_ERS_RESULT_CAN_RECOVER;
-	case pci_channel_io_frozen:
-		/* Fatal error, prepare for slot reset */
-		amdgpu_device_lock_adev(adev);
+	/* Fatal error, prepare for slot reset */
+	case pci_channel_io_frozen:		
+		/*		
+		 * Cancel and wait for all TDRs in progress if failing to
+		 * set  adev->in_gpu_reset in amdgpu_device_lock_adev
+		 *
+		 * Locking adev->reset_sem will prevent any external access
+		 * to GPU during PCI error recovery
+		 */
+		while (!amdgpu_device_lock_adev(adev, NULL))
+			amdgpu_cancel_all_tdr(adev);
+
+		/*
+		 * Block any work scheduling as we do for regular GPU reset
+		 * for the duration of the recovery
+		 */
+		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
+			struct amdgpu_ring *ring = adev->rings[i];
+
+			if (!ring || !ring->sched.thread)
+				continue;
+
+			drm_sched_stop(&ring->sched, NULL);
+		}
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		/* Permanent error, prepare for device removal */
@@ -4894,8 +4930,21 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	int i;
 
-	amdgpu_device_unlock_adev(adev);
 
 	DRM_INFO("PCI error: resume callback!!\n");
+
+	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
+		struct amdgpu_ring *ring = adev->rings[i];
+
+		if (!ring || !ring->sched.thread)
+			continue;
+
+
+		drm_sched_resubmit_jobs(&ring->sched);
+		drm_sched_start(&ring->sched, true);
+	}
+
+	amdgpu_device_unlock_adev(adev);
 }
-- 
2.7.4

