Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73B325B3FA
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 20:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgIBSmp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 14:42:45 -0400
Received: from mail-bn8nam12on2086.outbound.protection.outlook.com ([40.107.237.86]:14824
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726882AbgIBSmn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 14:42:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYfDTZwo1YPIpLsoSxkC9HcAT3rYz9swrFUDMwcK2tFx2kFMZWK50KbZo1VW5r6tBwogk8ItZ3SqDyZaQjphIno3uhjJNfTdNuNN5p6Zu1obqELteUjboIlVax79I9KGW+3+V1hASOpCkcqYjyR1gdROBePjDMbViKImgGufUYy03WHPT/iq5BmZqQ19je781TPeElzX4aanglY8fwg7uy/WImL0G72MNq5F2z/pr/R0NfiW86JcF/elwB1Ee6R2+FW8wWDrtjwiv0Iekxg+Uy/U3IZEkKAegE3Ooi/AumKVeLutxWXQavlDhiAY8VSu+VcJAve9Hj6r2dW5h6X2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0y4g78b13dYA2H19U3m5IlbmltgAn1fmjhJAFRrgU4=;
 b=WqFOokxg3tduvsz1/+kEXq1rt6/BfYEhPOiY/0BCLUN+Uv/Um1K+m3CrWvAdHM61Qn41x2Dp/Q/gjRVF03G6ltIOYMIuDL7H+mvKh4mMOG3qfNDG50yvQsNutCoR9qo6XB0wGsP53ljyfHl/v+T1y18irzpkgMhWd7UmTihRgnPVboPb5s3m8wQ7hnAs/UOc+JsJIAvXaHcWp8B9Mv5UsxjOFGB/rnaXdXzon661WBgLks2EgBEjeXWEgB/LS7Vxnf2bY8UfVnJYsmYS9KhSDCS9TGMpCqrNdUMezuvbS/FN9w/IoI0EQhLK6YEH4ez78DVTGeGWtfHDCXg+WUcjUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0y4g78b13dYA2H19U3m5IlbmltgAn1fmjhJAFRrgU4=;
 b=WHS3v6lSHy58t44w6yaTSZ8BiLgLQba8hW1b3P6tuMkyLupxTfG7E/rcq5umAo/TWZYT4l/oSgAHs88sOYeRKKb1tcwm1CVZmiiXJuX3IUI8GsxK9HDcr/qfMR/lfH5CGTBdxyo8NSBNc2ulBZ14Yk7ijnqar5FCoUi0JKugs2Y=
Received: from BN6PR10CA0027.namprd10.prod.outlook.com (2603:10b6:404:109::13)
 by DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 2 Sep
 2020 18:42:39 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:109:cafe::e3) by BN6PR10CA0027.outlook.office365.com
 (2603:10b6:404:109::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Wed, 2 Sep 2020 18:42:39 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 18:42:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 13:42:38 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 13:42:37 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 2 Sep 2020 13:42:37 -0500
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To:     <amd-gfx@lists.freedesktop.org>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>
CC:     <alexander.deucher@amd.com>, <nirmodas@amd.com>,
        <Dennis.Li@amd.com>, <christian.koenig@amd.com>,
        <luben.tuikov@amd.com>, <bhelgaas@google.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH v4 1/8] drm/amdgpu: Avoid accessing HW when suspending SW state
Date:   Wed, 2 Sep 2020 14:42:03 -0400
Message-ID: <1599072130-10043-2-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9affded5-4bc7-49a1-610b-08d84f6ff76a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3433:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3433ED50312FBA7C338CE18BEA2F0@DM6PR12MB3433.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: daYpifmjMFp7rferWJbsrlCdtIpXTof6hyjzdJzz8Pi9fT2EKhelJkSIvHrbq0B0k3M1gRPv9XPuZyyz8UAs3BAMafAPQp9RNmHElH41iTfcMy8ijKXM2n1wzLUH5zrV0LV+Lcfjy9lPgtLiAArMppBjSUtCs+WlQ8LJEzg+MX1+0TAYHEtbdPFdG8X0bJys67qYJgAXyPjJwQWUWx2uGrhcqD4YsbySitiBfzpbIaNsDcyAOb2sr1XuFSizN1H3CAL20eaq2CuQVBkfj2xfeGSNkjEJdBDVlJf5RizZKtzunj+dSJfgX02zuyHXRS5+zSd0oqf8qI0AApZTf89xoYdts9eUeMMkle94FkXqx6/8Zt7DISP3iGdQHiOEph1JPG9tDfA+60fYCcgvzKb11g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB02.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966005)(70206006)(356005)(54906003)(426003)(2616005)(2906002)(4326008)(110136005)(6666004)(336012)(82310400003)(44832011)(47076004)(8936002)(478600001)(7696005)(82740400003)(8676002)(83380400001)(316002)(26005)(36756003)(81166007)(186003)(70586007)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 18:42:38.3403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9affded5-4bc7-49a1-610b-08d84f6ff76a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3433
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

At this point the ASIC is already post reset by the HW/PSP
so the HW not in proper state to be configured for suspension,
some blocks might be even gated and so best is to avoid touching it.

v2: Rename in_dpc to more meaningful name

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  6 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 18 ++++++++------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     |  3 +++
 6 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c311a3c..b20354f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -992,6 +992,7 @@ struct amdgpu_device {
 	atomic_t			throttling_logging_enabled;
 	struct ratelimit_state		throttling_logging_rs;
 	uint32_t			ras_features;
+	bool                            in_pci_err_recovery;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 74a1c03..1fbf8a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -319,6 +319,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
 {
 	uint32_t ret;
 
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
 		return amdgpu_kiq_rreg(adev, reg);
 
@@ -351,6 +354,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
  * Returns the 8 bit value from the offset specified.
  */
 uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	if (offset < adev->rmmio_size)
 		return (readb(adev->rmmio + offset));
 	BUG();
@@ -372,6 +378,9 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
  * Writes the value specified to the offset specified.
  */
 void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value) {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if (offset < adev->rmmio_size)
 		writeb(value, adev->rmmio + offset);
 	else
@@ -382,6 +391,9 @@ static inline void amdgpu_mm_wreg_mmio(struct amdgpu_device *adev,
 				       uint32_t reg, uint32_t v,
 				       uint32_t acc_flags)
 {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
 
 	if ((reg * 4) < adev->rmmio_size)
@@ -409,6 +421,9 @@ static inline void amdgpu_mm_wreg_mmio(struct amdgpu_device *adev,
 void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		    uint32_t acc_flags)
 {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
 		return amdgpu_kiq_wreg(adev, reg, v);
 
@@ -423,6 +438,9 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		    uint32_t acc_flags)
 {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if (amdgpu_sriov_fullaccess(adev) &&
 		adev->gfx.rlc.funcs &&
 		adev->gfx.rlc.funcs->is_rlcg_access_range) {
@@ -444,6 +462,9 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t
  */
 u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
 {
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	if ((reg * 4) < adev->rio_mem_size)
 		return ioread32(adev->rio_mem + (reg * 4));
 	else {
@@ -463,6 +484,9 @@ u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
  */
 void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if ((reg * 4) < adev->rio_mem_size)
 		iowrite32(v, adev->rio_mem + (reg * 4));
 	else {
@@ -482,6 +506,9 @@ void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
  */
 u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
 {
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	if (index < adev->doorbell.num_doorbells) {
 		return readl(adev->doorbell.ptr + index);
 	} else {
@@ -502,6 +529,9 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
  */
 void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
 {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if (index < adev->doorbell.num_doorbells) {
 		writel(v, adev->doorbell.ptr + index);
 	} else {
@@ -520,6 +550,9 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
  */
 u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
 {
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	if (index < adev->doorbell.num_doorbells) {
 		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
 	} else {
@@ -540,6 +573,9 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
  */
 void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
 {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if (index < adev->doorbell.num_doorbells) {
 		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
 	} else {
@@ -4773,7 +4809,9 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 
 	pci_restore_state(pdev);
 
+	adev->in_pci_err_recovery = true;
 	r = amdgpu_device_ip_suspend(adev);
+	adev->in_pci_err_recovery = false;
 	if (r)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index d698142..8c9bacf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -693,6 +693,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *ring = &kiq->ring;
 
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	BUG_ON(!ring->funcs->emit_rreg);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
@@ -757,6 +760,9 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 
 	BUG_ON(!ring->funcs->emit_wreg);
 
+	if (adev->in_pci_err_recovery)
+		return;
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_emit_wreg(ring, reg, v);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d6c38e2..a7771aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -219,6 +219,9 @@ int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
 	int i;
 	struct amdgpu_device *adev = psp->adev;
 
+	if (psp->adev->in_pci_err_recovery)
+		return 0;
+
 	for (i = 0; i < adev->usec_timeout; i++) {
 		val = RREG32(reg_index);
 		if (check_changed) {
@@ -245,6 +248,9 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	bool ras_intr = false;
 	bool skip_unsupport = false;
 
+	if (psp->adev->in_pci_err_recovery)
+		return 0;
+
 	mutex_lock(&psp->mutex);
 
 	memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2db195e..ccf096c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6980,15 +6980,19 @@ static int gfx_v10_0_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+
+	if (!adev->in_pci_err_recovery) {
 #ifndef BRING_UP_DEBUG
-	if (amdgpu_async_gfx_ring) {
-		r = gfx_v10_0_kiq_disable_kgq(adev);
-		if (r)
-			DRM_ERROR("KGQ disable failed\n");
-	}
+		if (amdgpu_async_gfx_ring) {
+			r = gfx_v10_0_kiq_disable_kgq(adev);
+			if (r)
+				DRM_ERROR("KGQ disable failed\n");
+		}
 #endif
-	if (amdgpu_gfx_disable_kcq(adev))
-		DRM_ERROR("KCQ disable failed\n");
+		if (amdgpu_gfx_disable_kcq(adev))
+			DRM_ERROR("KCQ disable failed\n");
+	}
+
 	if (amdgpu_sriov_vf(adev)) {
 		gfx_v10_0_cp_gfx_enable(adev, false);
 		/* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index a58ea08..97aa72a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -112,6 +112,9 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, index = 0;
 
+	if (smu->adev->in_pci_err_recovery)
+		return 0;
+
 	index = smu_cmn_to_asic_specific_index(smu,
 					       CMN2ASIC_MAPPING_MSG,
 					       msg);
-- 
2.7.4

