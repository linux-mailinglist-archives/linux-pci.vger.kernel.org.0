Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D471053DB
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 15:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfKUOCd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 09:02:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbfKUOCd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 09:02:33 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 975CD20714;
        Thu, 21 Nov 2019 14:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574344951;
        bh=p+6p0TR0bdwk+7OX4bKXyZhEiuv4/iFEKrfEI3PdbWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZEuKs2A/mIZEpJiRG5AS6HF5KkLmThmYQ9aVnsN58USQskGFnBX7rC0rTGBQPlfqx
         jkxa4Kv0pBFep/zihQ550g6sklDLnfuYTdcjQT6HBKztrMTSgjkkVBdcjrS2JY/0+r
         6iMG7v63RQfLYeLWaXKwHJiSFF60gpLCwWUXAbKs=
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
Subject: [PATCH 2/7] drm/amdgpu: Correct Transmit Margin masks
Date:   Thu, 21 Nov 2019 08:02:15 -0600
Message-Id: <20191121140220.38030-3-helgaas@kernel.org>
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
 drivers/gpu/drm/amd/amdgpu/cik.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/si.c  | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index b81bb414fcb3..13a5696d2a6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1498,13 +1498,13 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 
 				/* linkctl2 */
 				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 9));
-				tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 9)));
+				tmp16 &= ~((1 << 4) | (7 << 7));
+				tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 7)));
 				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, tmp16);
 
 				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 9));
-				tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 9)));
+				tmp16 &= ~((1 << 4) | (7 << 7));
+				tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 7)));
 				pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
 
 				tmp = RREG32_PCIE(ixPCIE_LC_CNTL4);
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 493af42152f2..1e350172dc7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1737,13 +1737,13 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 				pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
 
 				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 9));
-				tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 9)));
+				tmp16 &= ~((1 << 4) | (7 << 7));
+				tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 7)));
 				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, tmp16);
 
 				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 9));
-				tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 9)));
+				tmp16 &= ~((1 << 4) | (7 << 7));
+				tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 7)));
 				pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
 
 				tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
-- 
2.24.0.432.g9d3f5f5b63-goog

