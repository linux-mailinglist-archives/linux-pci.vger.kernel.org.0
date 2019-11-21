Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6A351053DE
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 15:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKUOCi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 09:02:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbfKUOCh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 09:02:37 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6A5720714;
        Thu, 21 Nov 2019 14:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574344956;
        bh=iI6P6FLhSZffxNAomh8eN45Lk4VFuntsL83fGjuXh+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RKO3DxKO3jUUQU2GSnSiihCTC12JxFdcHvrSy8GhnixGFgHxJjDcZxOOKa3I4qHB0
         lJoj0WGHo91ieE1jKTfEL2PXPipg7YzAGSv+23DLAyoNueC1/c+OBUsjexx58ezPgV
         7bi8VmzkHVq7KMWmhFJeuqD/srdjbfdsKm7u5vbU=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/7] drm/radeon: Correct Transmit Margin masks
Date:   Thu, 21 Nov 2019 08:02:18 -0600
Message-Id: <20191121140220.38030-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191121140220.38030-1-helgaas@kernel.org>
References: <20191121140220.38030-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Previously we masked PCIe Link Control 2 register values with "7 << 9",
which was apparently intended to be the Transmit Margin field, but instead
was the high order bit of Transmit Margin, the Enter Modified Compliance
bit, and the Compliance SOS bit.

Correct the mask to "7 << 7", which is the Transmit Margin field.

Link: https://lore.kernel.org/r/20191112173503.176611-3-helgaas@kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/radeon/cik.c | 8 ++++----
 drivers/gpu/drm/radeon/si.c  | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 62eab82a64f9..14cdfdf78bde 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -9619,13 +9619,13 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
 
 				/* linkctl2 */
 				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 9));
-				tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 9)));
+				tmp16 &= ~((1 << 4) | (7 << 7));
+				tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 7)));
 				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, tmp16);
 
 				pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 9));
-				tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 9)));
+				tmp16 &= ~((1 << 4) | (7 << 7));
+				tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 7)));
 				pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
 
 				tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 05894d198a79..9b7042d3ef1b 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -7202,13 +7202,13 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
 
 				/* linkctl2 */
 				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 9));
-				tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 9)));
+				tmp16 &= ~((1 << 4) | (7 << 7));
+				tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 7)));
 				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, tmp16);
 
 				pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 9));
-				tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 9)));
+				tmp16 &= ~((1 << 4) | (7 << 7));
+				tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 7)));
 				pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
 
 				tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
-- 
2.24.0.432.g9d3f5f5b63-goog

