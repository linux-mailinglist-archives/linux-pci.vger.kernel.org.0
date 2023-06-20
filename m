Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFE7736DBC
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 15:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjFTNsF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 09:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbjFTNsF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 09:48:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1482199C;
        Tue, 20 Jun 2023 06:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687268857; x=1718804857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tCBTG6EshP8yDnY64rQPzjgjv41iMK/kEF3IhZM1+uU=;
  b=CWMbhmcTwsH6JIvnaPAoyKU02LOM0ik3Dv1iLUjP6bcmbwu0j/LLR1Fu
   VQUOTTRu97dFU7+sng7Tcb3e9pKcWLcqlOFb92Q1Xz1Mw/UxFWDrdUs5t
   7Ko2aw4wjeMRn5h8uAOWwvKujsmivZIoftjDG3oUCOFbaMVDDhexQjS+r
   /t34RRwnmnJyVU7DYcA1yt6JH7NNAX4xSXoP4u0RRMPH2jXlOD0kNIccS
   N4Yvgeh764SU/bO2FWyxCsSj/4zR9uG6/rhh14NERTTfCMLDiEdIRe8OY
   XmHL4Sf5ha5MLRPRILKNMDx9keW1nmEcFXsE0HJCjaXbWQsxth15aZe1B
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="362401433"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="362401433"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 06:47:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="827006800"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="827006800"
Received: from eshaanan-mobl.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.61.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 06:47:09 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jammy Zhou <Jammy.Zhou@amd.com>,
        Ken Wang <Qingqing.Wang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH v3 05/10] drm/amdgpu: Use RMW accessors for changing LNKCTL
Date:   Tue, 20 Jun 2023 16:46:19 +0300
Message-Id: <20230620134624.99688-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230620134624.99688-1-ilpo.jarvinen@linux.intel.com>
References: <20230620134624.99688-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Don't assume that only the driver would be accessing LNKCTL. ASPM
policy changes can trigger write to LNKCTL outside of driver's control.
And in the case of upstream bridge, the driver does not even own the
device it's changing the registers for.

Use RMW capability accessors which do proper locking to avoid losing
concurrent updates to the register value.

Fixes: a2e73f56fa62 ("drm/amdgpu: Add support for CIK parts")
Fixes: 62a37553414a ("drm/amdgpu: add si implementation v10")
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/cik.c | 36 +++++++++-----------------------
 drivers/gpu/drm/amd/amdgpu/si.c  | 36 +++++++++-----------------------
 2 files changed, 20 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index de6d10390ab2..9be6da37032a 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1574,17 +1574,8 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 			u16 bridge_cfg2, gpu_cfg2;
 			u32 max_lw, current_lw, tmp;
 
-			pcie_capability_read_word(root, PCI_EXP_LNKCTL,
-						  &bridge_cfg);
-			pcie_capability_read_word(adev->pdev, PCI_EXP_LNKCTL,
-						  &gpu_cfg);
-
-			tmp16 = bridge_cfg | PCI_EXP_LNKCTL_HAWD;
-			pcie_capability_write_word(root, PCI_EXP_LNKCTL, tmp16);
-
-			tmp16 = gpu_cfg | PCI_EXP_LNKCTL_HAWD;
-			pcie_capability_write_word(adev->pdev, PCI_EXP_LNKCTL,
-						   tmp16);
+			pcie_capability_set_word(root, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
+			pcie_capability_set_word(adev->pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
 
 			tmp = RREG32_PCIE(ixPCIE_LC_STATUS1);
 			max_lw = (tmp & PCIE_LC_STATUS1__LC_DETECTED_LINK_WIDTH_MASK) >>
@@ -1637,21 +1628,14 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 				msleep(100);
 
 				/* linkctl */
-				pcie_capability_read_word(root, PCI_EXP_LNKCTL,
-							  &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (bridge_cfg & PCI_EXP_LNKCTL_HAWD);
-				pcie_capability_write_word(root, PCI_EXP_LNKCTL,
-							   tmp16);
-
-				pcie_capability_read_word(adev->pdev,
-							  PCI_EXP_LNKCTL,
-							  &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (gpu_cfg & PCI_EXP_LNKCTL_HAWD);
-				pcie_capability_write_word(adev->pdev,
-							   PCI_EXP_LNKCTL,
-							   tmp16);
+				pcie_capability_clear_and_set_word(root, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   bridge_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
+				pcie_capability_clear_and_set_word(adev->pdev, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   gpu_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
 
 				/* linkctl2 */
 				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 7f99e130acd0..fd34c2100bd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2276,17 +2276,8 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 			u16 bridge_cfg2, gpu_cfg2;
 			u32 max_lw, current_lw, tmp;
 
-			pcie_capability_read_word(root, PCI_EXP_LNKCTL,
-						  &bridge_cfg);
-			pcie_capability_read_word(adev->pdev, PCI_EXP_LNKCTL,
-						  &gpu_cfg);
-
-			tmp16 = bridge_cfg | PCI_EXP_LNKCTL_HAWD;
-			pcie_capability_write_word(root, PCI_EXP_LNKCTL, tmp16);
-
-			tmp16 = gpu_cfg | PCI_EXP_LNKCTL_HAWD;
-			pcie_capability_write_word(adev->pdev, PCI_EXP_LNKCTL,
-						   tmp16);
+			pcie_capability_set_word(root, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
+			pcie_capability_set_word(adev->pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
 
 			tmp = RREG32_PCIE(PCIE_LC_STATUS1);
 			max_lw = (tmp & LC_DETECTED_LINK_WIDTH_MASK) >> LC_DETECTED_LINK_WIDTH_SHIFT;
@@ -2331,21 +2322,14 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 
 				mdelay(100);
 
-				pcie_capability_read_word(root, PCI_EXP_LNKCTL,
-							  &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (bridge_cfg & PCI_EXP_LNKCTL_HAWD);
-				pcie_capability_write_word(root, PCI_EXP_LNKCTL,
-							   tmp16);
-
-				pcie_capability_read_word(adev->pdev,
-							  PCI_EXP_LNKCTL,
-							  &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (gpu_cfg & PCI_EXP_LNKCTL_HAWD);
-				pcie_capability_write_word(adev->pdev,
-							   PCI_EXP_LNKCTL,
-							   tmp16);
+				pcie_capability_clear_and_set_word(root, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   bridge_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
+				pcie_capability_clear_and_set_word(adev->pdev, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   gpu_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
 
 				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
 							  &tmp16);
-- 
2.30.2

