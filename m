Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7BAEF9742
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 18:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfKLRfW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 12:35:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbfKLRfW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Nov 2019 12:35:22 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D821A214E0;
        Tue, 12 Nov 2019 17:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573580121;
        bh=aSgDyFMbR0x0kKXuE1Uwn6kWksTiWbNkcWmXkSwXo2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cmg6gDo9EOXLtZPApMz/CbAK+d0g6OUfmUbthvAS6tA3tGwtKsrzM33g6N5SBqy85
         h8FgQwLeIIh2uMQAM8FA16rMNjnrEjPrrJc4LsIfC3STPrGMMqCCvqlHnsdFhlNVaj
         ZsaoZaptziZySgDQ1QRx3wSSKI3V94Y+VIryfEiw=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>,
        linux-pci@vger.kernel.org,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/3] drm: replace numbers with PCI_EXP_LNKCTL2 definitions
Date:   Tue, 12 Nov 2019 11:35:03 -0600
Message-Id: <20191112173503.176611-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191112173503.176611-1-helgaas@kernel.org>
References: <20191112173503.176611-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Replace hard-coded magic numbers with the descriptive PCI_EXP_LNKCTL2
definitions.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik.c | 22 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/si.c  | 22 ++++++++++++++--------
 drivers/gpu/drm/radeon/cik.c     | 22 ++++++++++++++--------
 drivers/gpu/drm/radeon/si.c      | 22 ++++++++++++++--------
 4 files changed, 56 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 13a5696d2a6a..3067bb874032 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1498,13 +1498,19 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 
 				/* linkctl2 */
 				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 7));
-				tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 7)));
+				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN);
+				tmp16 |= (bridge_cfg2 &
+					  (PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN));
 				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, tmp16);
 
 				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 7));
-				tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 7)));
+				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN);
+				tmp16 |= (gpu_cfg2 &
+					  (PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN));
 				pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
 
 				tmp = RREG32_PCIE(ixPCIE_LC_CNTL4);
@@ -1521,13 +1527,13 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 	WREG32_PCIE(ixPCIE_LC_SPEED_CNTL, speed_cntl);
 
 	pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-	tmp16 &= ~0xf;
+	tmp16 &= ~PCI_EXP_LNKCTL2_TLS;
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
-		tmp16 |= 3; /* gen3 */
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_8_0GT; /* gen3 */
 	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)
-		tmp16 |= 2; /* gen2 */
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_5_0GT; /* gen2 */
 	else
-		tmp16 |= 1; /* gen1 */
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_2_5GT; /* gen1 */
 	pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
 
 	speed_cntl = RREG32_PCIE(ixPCIE_LC_SPEED_CNTL);
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 1e350172dc7b..a7dcb0d0f039 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1737,13 +1737,19 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 				pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
 
 				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 7));
-				tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 7)));
+				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN);
+				tmp16 |= (bridge_cfg2 &
+					  (PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN));
 				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, tmp16);
 
 				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 7));
-				tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 7)));
+				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN);
+				tmp16 |= (gpu_cfg2 &
+					  (PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN));
 				pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
 
 				tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
@@ -1758,13 +1764,13 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 	WREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL, speed_cntl);
 
 	pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-	tmp16 &= ~0xf;
+	tmp16 &= ~PCI_EXP_LNKCTL2_TLS;
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
-		tmp16 |= 3;
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_8_0GT; /* gen3 */
 	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)
-		tmp16 |= 2;
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_5_0GT; /* gen2 */
 	else
-		tmp16 |= 1;
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_2_5GT; /* gen1 */
 	pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
 
 	speed_cntl = RREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL);
diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 14cdfdf78bde..a280442c81aa 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -9619,13 +9619,19 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
 
 				/* linkctl2 */
 				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 7));
-				tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 7)));
+				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN);
+				tmp16 |= (bridge_cfg2 &
+					  (PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN));
 				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, tmp16);
 
 				pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 7));
-				tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 7)));
+				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN);
+				tmp16 |= (gpu_cfg2 &
+					  (PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN));
 				pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
 
 				tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
@@ -9641,13 +9647,13 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
 	WREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL, speed_cntl);
 
 	pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-	tmp16 &= ~0xf;
+	tmp16 &= ~PCI_EXP_LNKCTL2_TLS;
 	if (speed_cap == PCIE_SPEED_8_0GT)
-		tmp16 |= 3; /* gen3 */
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_8_0GT; /* gen3 */
 	else if (speed_cap == PCIE_SPEED_5_0GT)
-		tmp16 |= 2; /* gen2 */
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_5_0GT; /* gen2 */
 	else
-		tmp16 |= 1; /* gen1 */
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_2_5GT; /* gen1 */
 	pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
 
 	speed_cntl = RREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL);
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 9b7042d3ef1b..529e70a42019 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -7202,13 +7202,19 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
 
 				/* linkctl2 */
 				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 7));
-				tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 7)));
+				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN);
+				tmp16 |= (bridge_cfg2 &
+					  (PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN));
 				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, tmp16);
 
 				pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 7));
-				tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 7)));
+				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN);
+				tmp16 |= (gpu_cfg2 &
+					  (PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN));
 				pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
 
 				tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
@@ -7224,13 +7230,13 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
 	WREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL, speed_cntl);
 
 	pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-	tmp16 &= ~0xf;
+	tmp16 &= ~PCI_EXP_LNKCTL2_TLS;
 	if (speed_cap == PCIE_SPEED_8_0GT)
-		tmp16 |= 3; /* gen3 */
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_8_0GT; /* gen3 */
 	else if (speed_cap == PCIE_SPEED_5_0GT)
-		tmp16 |= 2; /* gen2 */
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_5_0GT; /* gen2 */
 	else
-		tmp16 |= 1; /* gen1 */
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_2_5GT; /* gen1 */
 	pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
 
 	speed_cntl = RREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL);
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

