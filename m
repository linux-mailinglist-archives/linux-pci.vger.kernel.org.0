Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEFE1053DF
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 15:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfKUOCi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 09:02:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbfKUOCg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 09:02:36 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 676412070B;
        Thu, 21 Nov 2019 14:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574344954;
        bh=TP+FQMSqKA0fGNgps9ogIDNXTdLZ+sJxF9h9fPbPHMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V/5sTl7TvqaU01yg9EJyBt+H+ToQFyavjv2XRYUXMt5IP7atodfKRIT2nfvmIGxRn
         YFbXbG7xHo4WI8EuFn5xmcSM3aUJenECkhPuaXW0JGIG8SguRJHm3qtFrbMSR7R7s1
         tKWbC/c3hG77qCnKXl2YvXl20j9mzOl486hZL9gw=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4/7] drm/amdgpu: Prefer pcie_capability_read_word()
Date:   Thu, 21 Nov 2019 08:02:17 -0600
Message-Id: <20191121140220.38030-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191121140220.38030-1-helgaas@kernel.org>
References: <20191121140220.38030-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frederick Lawler <fred@fredlawl.com>

Commit 8c0d3a02c130 ("PCI: Add accessors for PCI Express Capability")
added accessors for the PCI Express Capability so that drivers didn't
need to be aware of differences between v1 and v2 of the PCI
Express Capability.

Replace pci_read_config_word() and pci_write_config_word() calls with
pcie_capability_read_word() and pcie_capability_write_word().

[bhelgaas: fix a couple remaining instances in cik.c]
Link: https://lore.kernel.org/r/20191118003513.10852-1-fred@fredlawl.com
Signed-off-by: Frederick Lawler <fred@fredlawl.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/gpu/drm/amd/amdgpu/cik.c | 71 ++++++++++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/si.c  | 71 ++++++++++++++++++++------------
 2 files changed, 90 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 3067bb874032..38b06ae6357a 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1384,7 +1384,6 @@ static int cik_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
 static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 {
 	struct pci_dev *root = adev->pdev->bus->self;
-	int bridge_pos, gpu_pos;
 	u32 speed_cntl, current_data_rate;
 	int i;
 	u16 tmp16;
@@ -1419,12 +1418,7 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 		DRM_INFO("enabling PCIE gen 2 link speeds, disable with amdgpu.pcie_gen2=0\n");
 	}
 
-	bridge_pos = pci_pcie_cap(root);
-	if (!bridge_pos)
-		return;
-
-	gpu_pos = pci_pcie_cap(adev->pdev);
-	if (!gpu_pos)
+	if (!pci_is_pcie(root) || !pci_is_pcie(adev->pdev))
 		return;
 
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) {
@@ -1434,14 +1428,17 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 			u16 bridge_cfg2, gpu_cfg2;
 			u32 max_lw, current_lw, tmp;
 
-			pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
-			pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
+			pcie_capability_read_word(root, PCI_EXP_LNKCTL,
+						  &bridge_cfg);
+			pcie_capability_read_word(adev->pdev, PCI_EXP_LNKCTL,
+						  &gpu_cfg);
 
 			tmp16 = bridge_cfg | PCI_EXP_LNKCTL_HAWD;
-			pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
+			pcie_capability_write_word(root, PCI_EXP_LNKCTL, tmp16);
 
 			tmp16 = gpu_cfg | PCI_EXP_LNKCTL_HAWD;
-			pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
+			pcie_capability_write_word(adev->pdev, PCI_EXP_LNKCTL,
+						   tmp16);
 
 			tmp = RREG32_PCIE(ixPCIE_LC_STATUS1);
 			max_lw = (tmp & PCIE_LC_STATUS1__LC_DETECTED_LINK_WIDTH_MASK) >>
@@ -1465,15 +1462,23 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 
 			for (i = 0; i < 10; i++) {
 				/* check status */
-				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_DEVSTA, &tmp16);
+				pcie_capability_read_word(adev->pdev,
+							  PCI_EXP_DEVSTA,
+							  &tmp16);
 				if (tmp16 & PCI_EXP_DEVSTA_TRPND)
 					break;
 
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
-				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
+				pcie_capability_read_word(root, PCI_EXP_LNKCTL,
+							  &bridge_cfg);
+				pcie_capability_read_word(adev->pdev,
+							  PCI_EXP_LNKCTL,
+							  &gpu_cfg);
 
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &bridge_cfg2);
-				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &gpu_cfg2);
+				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
+							  &bridge_cfg2);
+				pcie_capability_read_word(adev->pdev,
+							  PCI_EXP_LNKCTL2,
+							  &gpu_cfg2);
 
 				tmp = RREG32_PCIE(ixPCIE_LC_CNTL4);
 				tmp |= PCIE_LC_CNTL4__LC_SET_QUIESCE_MASK;
@@ -1486,32 +1491,45 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 				msleep(100);
 
 				/* linkctl */
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &tmp16);
+				pcie_capability_read_word(root, PCI_EXP_LNKCTL,
+							  &tmp16);
 				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
 				tmp16 |= (bridge_cfg & PCI_EXP_LNKCTL_HAWD);
-				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
+				pcie_capability_write_word(root, PCI_EXP_LNKCTL,
+							   tmp16);
 
-				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, &tmp16);
+				pcie_capability_read_word(adev->pdev,
+							  PCI_EXP_LNKCTL,
+							  &tmp16);
 				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
 				tmp16 |= (gpu_cfg & PCI_EXP_LNKCTL_HAWD);
-				pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
+				pcie_capability_write_word(adev->pdev,
+							   PCI_EXP_LNKCTL,
+							   tmp16);
 
 				/* linkctl2 */
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
+				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
+							  &tmp16);
 				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
 					   PCI_EXP_LNKCTL2_TX_MARGIN);
 				tmp16 |= (bridge_cfg2 &
 					  (PCI_EXP_LNKCTL2_ENTER_COMP |
 					   PCI_EXP_LNKCTL2_TX_MARGIN));
-				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, tmp16);
+				pcie_capability_write_word(root,
+							   PCI_EXP_LNKCTL2,
+							   tmp16);
 
-				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
+				pcie_capability_read_word(adev->pdev,
+							  PCI_EXP_LNKCTL2,
+							  &tmp16);
 				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
 					   PCI_EXP_LNKCTL2_TX_MARGIN);
 				tmp16 |= (gpu_cfg2 &
 					  (PCI_EXP_LNKCTL2_ENTER_COMP |
 					   PCI_EXP_LNKCTL2_TX_MARGIN));
-				pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
+				pcie_capability_write_word(adev->pdev,
+							   PCI_EXP_LNKCTL2,
+							   tmp16);
 
 				tmp = RREG32_PCIE(ixPCIE_LC_CNTL4);
 				tmp &= ~PCIE_LC_CNTL4__LC_SET_QUIESCE_MASK;
@@ -1526,15 +1544,16 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 	speed_cntl &= ~PCIE_LC_SPEED_CNTL__LC_FORCE_DIS_SW_SPEED_CHANGE_MASK;
 	WREG32_PCIE(ixPCIE_LC_SPEED_CNTL, speed_cntl);
 
-	pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
+	pcie_capability_read_word(adev->pdev, PCI_EXP_LNKCTL2, &tmp16);
 	tmp16 &= ~PCI_EXP_LNKCTL2_TLS;
+
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
 		tmp16 |= PCI_EXP_LNKCTL2_TLS_8_0GT; /* gen3 */
 	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)
 		tmp16 |= PCI_EXP_LNKCTL2_TLS_5_0GT; /* gen2 */
 	else
 		tmp16 |= PCI_EXP_LNKCTL2_TLS_2_5GT; /* gen1 */
-	pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
+	pcie_capability_write_word(adev->pdev, PCI_EXP_LNKCTL2, tmp16);
 
 	speed_cntl = RREG32_PCIE(ixPCIE_LC_SPEED_CNTL);
 	speed_cntl |= PCIE_LC_SPEED_CNTL__LC_INITIATE_LINK_SPEED_CHANGE_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index a7dcb0d0f039..9f82be879224 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1633,7 +1633,6 @@ static void si_init_golden_registers(struct amdgpu_device *adev)
 static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 {
 	struct pci_dev *root = adev->pdev->bus->self;
-	int bridge_pos, gpu_pos;
 	u32 speed_cntl, current_data_rate;
 	int i;
 	u16 tmp16;
@@ -1668,12 +1667,7 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 		DRM_INFO("enabling PCIE gen 2 link speeds, disable with amdgpu.pcie_gen2=0\n");
 	}
 
-	bridge_pos = pci_pcie_cap(root);
-	if (!bridge_pos)
-		return;
-
-	gpu_pos = pci_pcie_cap(adev->pdev);
-	if (!gpu_pos)
+	if (!pci_is_pcie(root) || !pci_is_pcie(adev->pdev))
 		return;
 
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) {
@@ -1682,14 +1676,17 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 			u16 bridge_cfg2, gpu_cfg2;
 			u32 max_lw, current_lw, tmp;
 
-			pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
-			pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
+			pcie_capability_read_word(root, PCI_EXP_LNKCTL,
+						  &bridge_cfg);
+			pcie_capability_read_word(adev->pdev, PCI_EXP_LNKCTL,
+						  &gpu_cfg);
 
 			tmp16 = bridge_cfg | PCI_EXP_LNKCTL_HAWD;
-			pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
+			pcie_capability_write_word(root, PCI_EXP_LNKCTL, tmp16);
 
 			tmp16 = gpu_cfg | PCI_EXP_LNKCTL_HAWD;
-			pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
+			pcie_capability_write_word(adev->pdev, PCI_EXP_LNKCTL,
+						   tmp16);
 
 			tmp = RREG32_PCIE(PCIE_LC_STATUS1);
 			max_lw = (tmp & LC_DETECTED_LINK_WIDTH_MASK) >> LC_DETECTED_LINK_WIDTH_SHIFT;
@@ -1706,15 +1703,23 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 			}
 
 			for (i = 0; i < 10; i++) {
-				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_DEVSTA, &tmp16);
+				pcie_capability_read_word(adev->pdev,
+							  PCI_EXP_DEVSTA,
+							  &tmp16);
 				if (tmp16 & PCI_EXP_DEVSTA_TRPND)
 					break;
 
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
-				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
+				pcie_capability_read_word(root, PCI_EXP_LNKCTL,
+							  &bridge_cfg);
+				pcie_capability_read_word(adev->pdev,
+							  PCI_EXP_LNKCTL,
+							  &gpu_cfg);
 
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &bridge_cfg2);
-				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &gpu_cfg2);
+				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
+							  &bridge_cfg2);
+				pcie_capability_read_word(adev->pdev,
+							  PCI_EXP_LNKCTL2,
+							  &gpu_cfg2);
 
 				tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
 				tmp |= LC_SET_QUIESCE;
@@ -1726,31 +1731,44 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 
 				mdelay(100);
 
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &tmp16);
+				pcie_capability_read_word(root, PCI_EXP_LNKCTL,
+							  &tmp16);
 				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
 				tmp16 |= (bridge_cfg & PCI_EXP_LNKCTL_HAWD);
-				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
+				pcie_capability_write_word(root, PCI_EXP_LNKCTL,
+							   tmp16);
 
-				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, &tmp16);
+				pcie_capability_read_word(adev->pdev,
+							  PCI_EXP_LNKCTL,
+							  &tmp16);
 				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
 				tmp16 |= (gpu_cfg & PCI_EXP_LNKCTL_HAWD);
-				pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
+				pcie_capability_write_word(adev->pdev,
+							   PCI_EXP_LNKCTL,
+							   tmp16);
 
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
+				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
+							  &tmp16);
 				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
 					   PCI_EXP_LNKCTL2_TX_MARGIN);
 				tmp16 |= (bridge_cfg2 &
 					  (PCI_EXP_LNKCTL2_ENTER_COMP |
 					   PCI_EXP_LNKCTL2_TX_MARGIN));
-				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, tmp16);
+				pcie_capability_write_word(root,
+							   PCI_EXP_LNKCTL2,
+							   tmp16);
 
-				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
+				pcie_capability_read_word(adev->pdev,
+							  PCI_EXP_LNKCTL2,
+							  &tmp16);
 				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
 					   PCI_EXP_LNKCTL2_TX_MARGIN);
 				tmp16 |= (gpu_cfg2 &
 					  (PCI_EXP_LNKCTL2_ENTER_COMP |
 					   PCI_EXP_LNKCTL2_TX_MARGIN));
-				pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
+				pcie_capability_write_word(adev->pdev,
+							   PCI_EXP_LNKCTL2,
+							   tmp16);
 
 				tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
 				tmp &= ~LC_SET_QUIESCE;
@@ -1763,15 +1781,16 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 	speed_cntl &= ~LC_FORCE_DIS_SW_SPEED_CHANGE;
 	WREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL, speed_cntl);
 
-	pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
+	pcie_capability_read_word(adev->pdev, PCI_EXP_LNKCTL2, &tmp16);
 	tmp16 &= ~PCI_EXP_LNKCTL2_TLS;
+
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
 		tmp16 |= PCI_EXP_LNKCTL2_TLS_8_0GT; /* gen3 */
 	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)
 		tmp16 |= PCI_EXP_LNKCTL2_TLS_5_0GT; /* gen2 */
 	else
 		tmp16 |= PCI_EXP_LNKCTL2_TLS_2_5GT; /* gen1 */
-	pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
+	pcie_capability_write_word(adev->pdev, PCI_EXP_LNKCTL2, tmp16);
 
 	speed_cntl = RREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL);
 	speed_cntl |= LC_INITIATE_LINK_SPEED_CHANGE;
-- 
2.24.0.432.g9d3f5f5b63-goog

